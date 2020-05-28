module Lita
  module Handlers
    class AwsRdsHandler < AwsBaseHandler

      protect = ['aws_admin', 'aws_rds', 'aws_rds_describe']
      help = { 'aws rdss[ --profile NAME]' => 'List all RDS.' }
      route(/aws rdss[ ]*(.*)$/, help: help, restrict_to: protect) do |response|
        opts = get_options(response)
        data = exec_cli_json('rds describe-db-instances', opts)
        res = data['DBInstances'].map { |db| db_instance_to_hash(db) }
        render(response, format_hash_list_with_title(:name, res))
      end

      Lita.register_handler(AwsRdsHandler)
    end
  end
end
