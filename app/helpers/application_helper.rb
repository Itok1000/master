module ApplicationHelper
    def page_title(title = "", admin: false)
        base_title = admin ? "ガマルジョバ/გამარჯობა(管理画面)" : "ガマルジョバ/გამარჯობა"
        title.present? ? "#{title} | #{base_title}" : base_title
    end

    def active_if(path)
        path == controller_path ? "active" : ""
    end
end
