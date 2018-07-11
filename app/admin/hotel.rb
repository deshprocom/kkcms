ActiveAdmin.register Hotel do
  menu parent: '酒店管理', label: '酒店列表'

  filter :id
  filter :title
  filter :location

  index do
    render 'index', context: self
  end

  permit_params :title, :logo, :location, :telephone, :description, :star_level,
                :amap_poiid, :region, :amap_location
  form partial: 'form'

  show do
    render 'show', context: self
  end

  member_action :publish, method: :post do
    Hotel.find(params[:id]).publish!
    redirect_back fallback_location: admin_hotels_url, notice: I18n.t('publish_notice')
  end

  member_action :unpublish, method: :post do
    Hotel.find(params[:id]).unpublish!
    redirect_back fallback_location: admin_hotels_url, notice: I18n.t('unpublish_notice')
  end

  collection_action :amap_detail, method: :get do
    response = Faraday.get('https://restapi.amap.com/v3/place/detail',
                key: ENV['AMAP_KEY'],
                id: params[:poiid])
    pois = JSON.parse(response.body)['pois']
    @poi = pois.presence ? pois[0] : {}
  end

  controller do
    before_action :unpublished?, only: [:destroy]
    before_action :process_doc, only: [:create, :update]

    def process_doc
      return if params[:doc].blank?

      params[:hotel][:description] = DocProcessor.to_html(params[:doc].path)
    end

    def unpublished?
      return unless resource.published?

      flash[:error] = I18n.t('hotel.destroy_error')
      redirect_back fallback_location: admin_hotels_url
    end
  end

  sidebar '侧边栏', only: [:show, :edit] do
    hotel_sidebar_generator(self)
  end
end
