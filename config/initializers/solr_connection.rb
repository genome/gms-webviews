APP_CONFIG = YAML.load_file(Rails.root.join('config', 'solr.yml'))[Rails.env]

solr_config = APP_CONFIG['solr']

SOLR_CONNECTION_STRING = "#{solr_config['protocol']}://#{solr_config['domain']}:#{solr_config['port']}/#{solr_config['path']}"

