ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :password, :password_confirmation, :remember_created_at, :firstname, :lastname, :address, :province_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :firstname, :lastname, :address, :province_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :email
    column :firstname
    column :lastname
    column :address
    column :province_id do |user|
      "#{user.tax_rate.province}"
    end
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :firstname
      f.input :lastname
      f.input :address
      f.input :province_id, :as => :select, :collection => TaxRate.pluck(:province, :id)
      f.input :email
    end
    f.actions
  end

end
