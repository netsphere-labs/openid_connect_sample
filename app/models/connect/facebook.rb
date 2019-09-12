class Connect::Facebook < ActiveRecord::Base
  belongs_to :account

  validates :identifier,   presence: true, uniqueness: true
  validates :access_token, presence: true, uniqueness: true

  def me
    @me ||= FacebookOAuth::Client.new(
      :application_id => config[:client_id],
      :application_secret => config[:client_secret],
      :token => access_token
    ).info
  end

  def userinfo
    attributes = {
      id:       identifier,
      name:     me.name,
      email:    me.email,
      address:  me.location.try(:name),
      profile:  me.link,
      picture:  me.picture,
      locale:   me.locale,
      verified: me.verified
    }
    attributes[:gender] = me.gender if ['male', 'female'].include?(me.gender)
    OpenIDConnect::ResponseObject::UserInfo.new attributes
  end

  class << self
    def config
      unless @config
        @config = YAML.load_file("#{Rails.root}/config/connect/facebook.yml")[Rails.env].symbolize_keys
        if Rails.env.production?
          @config.merge!(
            client_id:     ENV['fb_client_id'],
            client_secret: ENV['fb_client_secret']
          )
        end
      end
      @config
    end

    def auth
      FacebookOAuth::Client.new(
        :application_id => config[:client_id],
        :application_secret => config[:client_secret],
        :callback => config[:callback]
      )
    end

    def authenticate(cookies)
      _auth_ = auth.from_cookie(cookies)
      connect = find_or_initialize_by_identifier _auth_.user.identifier
      connect.access_token = _auth_.access_token.access_token
      connect.save!
      connect.account || Account.create!(facebook: connect)
    end
  end
end
