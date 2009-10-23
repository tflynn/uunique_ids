Dir.glob(File.join(File.dirname(__FILE__), 'uunique_ids', '**/*.rb')).each do |f|
  require File.expand_path(f)
end
