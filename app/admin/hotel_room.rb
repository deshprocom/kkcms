ActiveAdmin.register HotelRoom do
  config.filters = false
  config.batch_actions = false

  belongs_to :hotel

  permit_params :title, :hotel_id, :text_tags, :text_notes, :published

  form partial: 'form'

  controller do
    before_action :process_params, only: [:create, :update]
    before_action :set_hotel, only: [:create, :update]
    before_action :set_hotel_room, only: [:create, :update]
    before_action :check_week_prices_params, only: [:create, :update]

    def create
      if @hotel_room.save
        update_wday_prices
        redirect_to resource_path(@hotel_room)
      else
        flash[:error] = '创建失败'
        render :new
      end
    end

    def update
      if @hotel_room.update(permitted_params[:hotel_room])
        HotelRoomPrice.where(hotel_room_id: @hotel_room.id, is_master: true).delete_all
        update_wday_prices
        redirect_to resource_path(@hotel_room)
      else
        flash[:error] = '更新失败'
        render :new
      end
    end

    def update_wday_prices
      week_prices_params.each do |wday, price|
        @hotel_room.wday_prices.create(wday: wday, price: price, hotel_id: @hotel.id)
        # 更新酒店一周的最低价格
        wday_price = @hotel.wday_min_price(wday)
        @hotel.update("#{wday}_min_price": wday_price.price)
      end
    end

    def check_week_prices_params
      week_prices_params.as_json.each_value do |price|
        if price.to_i <= 0
          flash.now[:error] = '一周的价格不能为0元或空'
          return render :new
        end
      end
    end

    def process_params
      # 将中文的逗号转成英文的
      params[:hotel_room][:text_tags].gsub!('，', ',')
      params[:hotel_room][:text_notes].gsub!('，', ',')
    end

    def week_prices_params
      @week_prices_params ||= params[:hotel_room][:week_prices]
    end

    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end

    def set_hotel_room
      @hotel_room = params[:id] ? HotelRoom.find(params[:id]) : HotelRoom.new(permitted_params[:hotel_room])
    end
  end

  show do
    render 'show', context: self
  end
end
