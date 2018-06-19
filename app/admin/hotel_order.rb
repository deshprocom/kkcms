ActiveAdmin.register HotelOrder do
  menu parent: '酒店管理'
  actions :all, except: [:new, :edit, :create, :destroy]

  index do
    render 'index', context: self
  end

  show do
    render 'show', context: self
  end
end
