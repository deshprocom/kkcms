ActiveAdmin.register HotelOrder do
  menu parent: '酒店管理'

  index do
    render 'index', context: self
  end
end
