ActiveAdmin.register HotelRoomPrice, as: 'RoomPrice' do
  config.batch_actions = false
  config.filters = false

  belongs_to :hotel_room
  permit_params :date, :price
  controller do
    before_action :set_room
    before_action :set_price, only: [:edit, :update, :destroy]

    def new
      @room_price = @room.prices.build
    end

    def create
      @room_price = @room.prices.build(permitted_params[:hotel_room_price].merge(hotel_id: @room.hotel_id))
      flash[:notice] = '增加特定价格成功' if @room_price.save
      render 'response'
    end

    def edit
      render 'new'
    end

    def update
      @room_price.assign_attributes(permitted_params[:hotel_room_price])
      flash[:notice] = '更新成功' if @room_price.save
      render 'response'
    end

    def destroy
      @room_price.destroy
      flash[:notice] = '删除特定价格成功'
      redirect_to admin_hotel_hotel_room_url(@room.hotel, @room)
    end

    def set_room
      @room = HotelRoom.find(params[:hotel_room_id])
    end

    def set_price
      @room_price = @room.prices.find(params[:id])
    end
  end
end
