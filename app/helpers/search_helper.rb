module SearchHelper
  def link_for_document(document)
    #work-order
    url = case document["type"]
          when 'wiki-page'
            document["display_url0"]
          when 'mail'
            document["display_url0"]
          when 'modelgroup'
            model_group_path(document["object_id"])
          when 'work-order'
            ""
          when "imported_instrument_data"
            instrument_data_path(document["object_id"])
          else
             method(document["type"].split("-").first.strip + "_path").call(document["object_id"])
          end
    link_to(document["display_title"], url)
  end
end



