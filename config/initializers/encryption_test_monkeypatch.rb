module KeyGeneratorMixin
  def generate_key(salt, key_size = 64)
    unless caller.to_s.include?('global_id/railtie.rb:28') ||
           caller.to_s.include?('action_dispatch/middleware/cookies.rb')
      raise 'called ActiveSupport::KeyGenerator#generate_key'
    end

    super
  end
end

module MessageVerifierMixin
  def valid_message?(signed_message)
    raise 'called ActiveSupport::MessageVerifier#valid_message?'
  end

  def verify(*args, **options)
    raise 'called ActiveSupport::MessageVerifier#verify'
  end

  def verified(signed_message, purpose: nil, **)
    raise 'called ActiveSupport::MessageVerifier#verified'
  end

  def generate(value, expires_at: nil, expires_in: nil, purpose: nil)
    raise 'called ActiveSupport::MessageVerifier#generate'
  end
end

module ActiveSupport
  class Digest
    class << self
      def hash_digest_class
        raise 'called ActiveSupport::Digest.hash_digest_class'
      end
    end
  end

  KeyGenerator.prepend(KeyGeneratorMixin)
  MessageVerifier.prepend(MessageVerifierMixin)
end
