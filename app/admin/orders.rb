ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :total, :gst_tax, :user_id, :hst_tax, :pst_tax
  #
  # or
  #
  # permit_params do
  #   permitted = [:total, :gst_tax, :customer_id, :hst_tax, :pst_tax, :total_price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :total
    column :gst_tax
    column :hst_tax
    column :pst_tax
    column :user do |order|
       "#{order.user.firstname} #{order.user.lastname}"
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :user, as: :select, collection: -> { User.pluck(Arel.sql("CONCAT(`firstname`, ' ', `lastname`)"), :id) }
  filter :total
  filter :gst_tax
  filter :hst_tax
  filter :pst_tax
  filter :created_at
  filter :updated_at

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :total
      f.input :gst_tax
      f.input :hst_tax
      f.input :pst_tax
      f.input :user_id, :as => :select, :collection => User.pluck(Arel.sql("CONCAT(`firstname`, ' ', `lastname`)"), :id)
    end
    f.actions
  end
end
