gem 'ez_chaff','0.2'
require 'ez_chaff'
gem 'uuidtools','2.1.1'
require 'uuidtools'
require 'digest/sha1'

class UUniqueIds
  

  class << self
  
    def random_create
      
      raw_uuid = ::UUIDTools::UUID.random_create.to_s
      chaffed_uuid = ::EzChaff.chaff(raw_uuid)
      sha1 = ::Digest::SHA1.hexdigest(chaffed_uuid)
      return sha1
      
    end
    
  end
  
end
