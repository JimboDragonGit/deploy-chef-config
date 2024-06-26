module JimboDragon
  def context_to_json
    get_secret_data_bag_object(context_data_bag, ENV['USER'], jimbodragon_secret_file)
  end

  def create_context_databag
    create_data_bag(context_data_bag)
  end

  def context_present_in_chef?
    context_present_in_chef = false
    begin
      context_data_bag_item = context_to_json
      context_present_in_chef = true
    rescue JSON::ParserError => e
      log "Context definitivly missing\ncontext_data_bag_item = #{context_data_bag_item}\njimbodragon_secret = #{jimbodragon_secret_file}"
      context_present_in_chef = false
    end
    context_present_in_chef.nil? ? false : context_present_in_chef
  end

  def check_context_present_in_chef(fail_if_present = false, fail_if_missing = false)
    if context_present_in_chef?
      log "Context of #{ENV['USER']} is present in Chef"
      exit context_present_error if fail_if_present
    else
      log "Context of #{ENV['USER']} is missing from Chef"
      exit context_missing_error if fail_if_missing
    end
  end
end
