Rails.application.configure do
  config.generators do |g|
    g.stylesheets         false
    g.javascripts         false
    g.helper              false
    g.scaffold_stylesheet false
    g.view_specs          false
  end
end
