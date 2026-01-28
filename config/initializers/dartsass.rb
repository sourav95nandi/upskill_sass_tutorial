Rails.application.config.dartsass.builds = {
  "app.scss" => "app.css"
}

Rails.application.config.dartsass.build_options = []

if Gem.loaded_specs.key?("font-awesome-sass")
  Rails.application.config.dartsass.build_options << "--load-path #{Gem.loaded_specs['font-awesome-sass'].full_gem_path}/assets/stylesheets"
end

if Gem.loaded_specs.key?("bootstrap")
  Rails.application.config.dartsass.build_options << "--load-path #{Gem.loaded_specs['bootstrap'].full_gem_path}/assets/stylesheets"
end