%w(chef context databag environments error secret).each do |component|
  require_relative "../deploy/#{component}"
end

module Context
  module ConfigHelper
    include DeployHelpers::ChefHelper
    include DeployHelpers::ContextHelper
    include DeployHelpers::DataBagHelper
    include DeployHelpers::ChefHelper
    include DeployHelpers::ErrorCodes
    include DeployHelpers::SecretHelper
  end
end
