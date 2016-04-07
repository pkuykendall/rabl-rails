module RablRails
  module Nodes
    class Child < Glue
      attr_reader :name, :object_root

      def initialize(name, template, object_root=nil)
        super(template)
        @name = name
        @object_root = object_root
      end
    end
  end
end