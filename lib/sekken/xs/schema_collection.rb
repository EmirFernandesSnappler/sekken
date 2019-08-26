class Sekken
  class XS
    class SchemaCollection
      include Enumerable

      def initialize
        @schemas = []
      end

      def <<(schema)
        @schemas << schema
      end

      def push(schemas)
        @schemas += schemas
      end

      def each(&block)
        @schemas.each(&block)
      end

      def attribute(namespace, name)
        find_by_namespace(namespace).attributes[name]
      end

      def attribute_group(namespace, name)
        find_by_namespace(namespace).attribute_groups[name]
      end

      def element(namespace, name)
        find_by_namespace(namespace).elements[name]
      end

      def complex_type(namespace, name)
        find_by_namespace(namespace).complex_types[name]
      end

      def simple_type(namespace, name)
        find_by_namespace(namespace).simple_types[name]
      end

      # TODO: store by namespace instead?
      def find_by_namespace(namespace)
        schemas = select do |schema|
          schema.target_namespace == namespace
        end

        return schemas.first if schemas.one?

        schemas.find do |schema|
          schema.elements.any?
        end
      end

    end
  end
end
