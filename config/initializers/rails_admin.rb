RailsAdmin.config do |config|

  config.current_user_method(&:current_user)
  config.authorize_with :cancan

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Order'] 
    end
    export
    bulk_delete
    show
    edit
    delete do
      except ['Order', 'Review']
    end
    show_in_app do
      except ['Order']
    end
  end

  config.excluded_models << User

  config.model 'Order' do
    edit do
      field :state, :enum do
        enum do
          bindings[:object].aasm.states.map(&:name)
        end
      end
    end
  end

  config.model 'Author' do
    object_label_method :full_name
    field :biography, :ck_editor
    include_all_fields
    exclude_fields :books
  end

  config.model 'Book' do
    include_all_fields
    field :full_description, :ck_editor
    exclude_fields :order_items, :reviews
  end

  config.model 'Category' do
    exclude_fields :books
  end

  config.model 'Coupon' do
    edit do
      exclude_fields :orders
    end
  end

  config.model 'Review' do
    edit do
      field :approved
    end
  end
end
