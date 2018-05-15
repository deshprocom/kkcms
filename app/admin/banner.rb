ActiveAdmin.register Banner do
  menu parent: '首页管理'
  config.batch_actions = false
  config.filters = false
  config.sort_order = 'position_asc'

  form partial: 'form'

  index do
    render 'index', context: self
  end

  controller do
    def create
      position = (Banner.last&.id.to_i + 1) * 100000
      @banner = Banner.new banner_params.merge(position: position)

      if @banner.save
        flash[:notice] = '新建banner成功'
        redirect_to admin_banners_url
      else
        render :new
      end
    end

    def banner_params
      params.require(:banner).permit(:image,
                                     :source_id,
                                     :source_type)
    end
  end
end