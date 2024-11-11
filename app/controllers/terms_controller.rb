# frozen_string_literal: true

# 利用規約
class TermsController < ApplicationController
    skip_before_action :require_login
    def terms; end
end