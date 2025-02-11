class StaticPagesController < ApplicationController
    skip_before_action :require_login, only: %i[top georgia food how_to_use]
    def top; end
    def georgia; end
    def food; end
    def how_to_use; end
end
