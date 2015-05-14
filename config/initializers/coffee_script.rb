module CoffeeScript
  class << self
    def compile_with_bare_option(script, options = {})
      options[:bare] = true
      compile_without_bare_option(script, options)
    end
    alias_method_chain :compile, :bare_option
  end
end
