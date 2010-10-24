require 'java'

module Redcar
  module SyntaxCheck
    class Ruby < Checker
      supported_grammars "Ruby", "Ruby on Rails"

      def check(*args)
        path    = manifest_path(doc)
        file    = File.basename(path)
        runtime = org.jruby.Ruby.global_runtime
        io      = java.io.FileInputStream.new(java.io.File.new(path))
        begin
          runtime.parse_from_main(io, file)
        rescue SyntaxError => e
          create_syntax_error(doc, e.exception.message, file).annotate
        end
      end

      def create_syntax_error(doc, message, file)
        message  =~ /#{Regexp.escape(file)}:(\d+):(.*)/
        line     = $1.to_i - 1
        message  = $2
        SyntaxCheck::Error.new(doc, line, message)
      end
    end
  end
end
