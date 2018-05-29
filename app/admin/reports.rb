ActiveAdmin.register Report do
  menu priority: 3, label: '举报管理', parent: '社交管理'
  actions :all, except: [:show, :new, :create]

  filter :target_type
  filter :user_nick_name, as: :string
  filter :body

  index do
    render 'index', context: self
  end
end
