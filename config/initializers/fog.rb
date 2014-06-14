fc = YAML::load_file(Rails.root.join 'config/fog.yml')[Rails.env.to_s]
FOG = Fog::Storage.new({:provider               => fc["provider"],
                        :aws_access_key_id      => fc["access_key_id"],
                        :aws_secret_access_key  => fc["secret_access_key"]})
S3 = FOG.directories.get(fc["bucket"])