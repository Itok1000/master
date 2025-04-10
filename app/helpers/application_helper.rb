module ApplicationHelper
    def page_title(title = "", admin: false)
        base_title = admin ? "ガマルジョバ/გამარჯობა(管理画面)" : "ガマルジョバ/გამარჯობა"
        title.present? ? "#{title} | #{base_title}" : base_title
    end

    def active_if(path)
        path == controller_path ? "active" : ""
    end

    def default_meta_tags
        {
          site: "ガマルジョバ",
          title: "ガマルジョバ/გამარჯობა",
          reverse: true,
          charset: "utf-8",
          description: "ジョージア料理診断サービスWebアプリ ログインなしで簡単な質問をすれば、おすすめのジョージア料理をご紹介！ (Xでシェアもできるよ) ログインして、料理の口コミやいいねをしてジョージア料理の奥深さを感じてみよう！",
          keywords: "ジョージア,ジョージア料理,ジョージア料理診断アプリ,georgia,gamarjoba,გამარჯობა,საქართველო",
          canonical: request.original_url,
          separator: "|",
          icon: [
            { href: image_url("logo.png") },
            { href: image_url("logo.png"), rel: "apple-touch-icon", sizes: "600x315", type: "image/png" }
          ],
          og: {
            site_name: :site,
            title: :title,
            description: :description,
            type: "website",
            url: request.original_url,
            image: image_url("logo.png"),
            local: "ja-JP"
          },
          twitter: {
            card: "summary_large_image",
            site: "@Itoken1000",
            image: image_url("ジョージア料理診断アプリ ガマルジョバ.png")
          }
        }
    end
end
