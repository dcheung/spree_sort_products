module SpreeSortProducts
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_sort_products'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w(admin/taxon_tree_menu_overrides admin/sort_products)
    end

    def self.activate
       ['app', 'lib'].each do |dir|
        Dir.glob(File.join(File.dirname(__FILE__), "../../#{dir}/**/*_decorator*.rb")) do |c|
          Rails.application.config.cache_classes ? require(c) : load(c)
        end
      end
      
    end

    config.to_prepare &method(:activate).to_proc
    
  end
end
