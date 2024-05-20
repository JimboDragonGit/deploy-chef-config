
module YP
  def data_bag_item(databag, item, secret = nil)
    if secret.nil?
      get_data_bag_object(databag, item)
    else
      get_secret_data_bag_object(databag, item, secret)
    end
  end
end
