module Context
  module DeployHelpers
    module DataBagHelper
      def data_bag_item(context, databag, item, secret = nil)
        if secret.nil?
          context.get_data_bag_object(context, databag, item)
        else
          context.get_secret_data_bag_object(context, databag, item, secret)
        end
      end
    end
  end
end
