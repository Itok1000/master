class PoliciesController < ApplicationController
    skip_before_action :require_login
    def policies; end
end
