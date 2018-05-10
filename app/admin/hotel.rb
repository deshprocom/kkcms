ActiveAdmin.register Hotel do
  filter :id
  filter :title
  filter :location

  index do
    render 'index', context: self
  end

  permit_params :title, :logo, :location, :telephone, :description
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

  controller do
    before_action :unpublished?, only: [:destroy]

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
