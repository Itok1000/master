class Admin::DashboardsController < Admin::BaseController
    before_action :check_admin
    layout 'admin/layouts/application'
  
    def index; end
end