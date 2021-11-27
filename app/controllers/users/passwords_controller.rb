module Users
  class PasswordsController < Devise::PasswordsController
    respond_to :json

    # POST /resource/password
    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        respond_with({ message: I18n.t('devise.confirmations.send_instructions') }, :ok)
      else
        respond_with resource.errors, :unprocessable_entity
      end
    end

    # PUT /resource/password
    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      yield resource if block_given?

      if resource.errors.empty?
        respond_with resource, :ok
      else
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
