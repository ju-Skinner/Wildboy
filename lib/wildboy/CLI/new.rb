require 'thor/group'

module Wildboy
  module CLI
    class New < Thor::Group
      argument :name

      def initialize
      end
    end
end
