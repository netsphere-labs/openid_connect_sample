# -*- coding:utf-8 -*-

class Connect::Google < Connect::Base
  serialize :id_token

  validates :identifier,   presence: true, uniqueness: true
  validates :access_token, presence: true, uniqueness: true


private

  def to_bearer_token
    Rack::OAuth2::AccessToken::Bearer.new(
      access_token: access_token
    )
  end

  def call_api(endpoint)
    # NOTE:
    # Google doesn't support Authorization header, so I put access_token in query for now.
    endpoint = URI.parse endpoint
    endpoint.query = {access_token: access_token}.to_query
    res = to_bearer_token.get(endpoint)
    case res.status
    when 200
      JSON.parse(res.body).with_indifferent_access
    when 401
      raise Authentication::AuthenticationRequired.new('Access Token Invalid or Expired')
    else
      raise Rack::OAuth2::Client::Error.new('API Access Faild')
    end
  end

  class << self
    def config
      return @config if @config
      
      @config = YAML.load_file(Rails.root.to_s + "/config/connect/google.yml")[Rails.env].symbolize_keys
      @config.merge! OpenIDConnect::Discovery::Provider::Config.discover!(
                       @config[:issuer]
                     ).as_json
      if Rails.env.production?
        @config.merge!(
            client_id:     ENV['g_client_id'],
            client_secret: ENV['g_client_secret']
        )
      end
      return @config
    end

    def client
      @client ||= OpenIDConnect::Client.new(
        identifier:             config[:client_id],
        secret:                 config[:client_secret],
        authorization_endpoint: config[:authorization_endpoint],
        token_endpoint:         config[:token_endpoint],
        redirect_uri:           config[:redirect_uri]
      )
    end

    
    # @return Authentication Request URL
    def authorization_uri(options = {})
      client.authorization_uri options.merge(
        scope: config[:scopes_supported]
      )
    end

    def jwks
      @jwks ||= JSON::JWK::Set.new(JSON.parse(
        OpenIDConnect.http_client.get(config[:jwks_uri]).body
      ))
    end

    def authenticate(code)
      # token の検証
      client.authorization_code = code
      token = client.access_token! :secret_in_body
      id_token = OpenIDConnect::ResponseObject::IdToken.decode(
        token.id_token, jwks
      )
      connect = find_or_initialize_by(identifier: id_token.subject)
      connect.access_token = token.access_token
      connect.id_token = id_token
      Account.transaction do
        connect.account || Account.create!(google: connect)
        connect.save!
      end
      return connect.account
    end
  end # class << self

end # class Connect::Google
