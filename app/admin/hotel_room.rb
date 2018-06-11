ActiveAdmin.register HotelRoom do
  config.filters = false
  belongs_to :hotel

  permit_params :title, :hotel_id, :text_tags, :text_notes,
                master_attributes: [:price]

  form partial: 'form'

  controller do
    before_action :process_params, only: [:create, :update]

    def process_params
      # 将中文的逗号转成英文的
      params[:hotel_room][:text_tags].gsub!('，', ',')
      params[:hotel_room][:text_notes].gsub!('，', ',')
    end
  end

  show do
    render 'show', context: self
  end
end
