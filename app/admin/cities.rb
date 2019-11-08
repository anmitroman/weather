ActiveAdmin.register City do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :code, :country, :display, :lon, :lat
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :code, :country, :display, :lon, :lat]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :code
      f.input :display
      f.input :country, :as => :string
      f.input :lon
      f.input :lat
    end
    f.actions
  end

end
