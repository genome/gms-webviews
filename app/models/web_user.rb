class WebUser
  extend Forwardable
  def_delegators :@genome_user, :name, :email, :username
  attr_reader :shib_username

  def self.current_user( request )
    WebUser.new( request.env['REMOTE_USER']  || request.env['HTTP_REMOTE_USER'] )
  end

  private
    def initialize( shib_username )
      @shib_username = shib_username
      @genome_user = Genome::User.where( email: @shib_username ).first!
    end
end
