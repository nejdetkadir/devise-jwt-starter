module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    # POST /resource
    def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        # set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, :created
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource.errors, :unprocessable_entity
      end
    end

    # PUT /resource
    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      # prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        # set_flash_message_for_update(resource, prev_unconfirmed_email)
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        respond_with resource, :ok
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource.errors, :unprocessable_entity
      end
    end

    private

    def respond_with(resource, status)
      render json: resource, status: status
    end
  end
end
