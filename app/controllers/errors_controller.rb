class ErrorsController < ApplicationController
  layout "errors"

  def not_found
    render template: 'errors/404', status: 404
  end

  def unacceptable
    render template: 'errors/422', status: 422
  end

  def internal_error
    render template: 'errors/500', status: 500
  end
end