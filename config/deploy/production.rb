set :stage, :production
server '206.189.149.133', user: "deploy", roles: %w{app db web}
