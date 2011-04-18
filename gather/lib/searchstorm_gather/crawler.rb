
require 'anemone'

module SearchstormGather

  class Gather
    class << self
      attr_accessor :crawler, :url_seed

      def crawler
        @crawler ||= Anemone::Core.new(url_seed)
      end
    end
  end
end
