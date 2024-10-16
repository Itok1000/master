class OgpCreator
    require "mini_magick"
    BASE_IMAGE_PATH = "./app/assets/images/ogp.png"  # 実際の画像ファイル名に変更
    GRAVITY = "center"
    TEXT_POSITION = "0,0"
    FONT = "./app/assets/fonts/KaiseiDecol-Medium.ttf" # 使用するフォントのパス
    FONT_SIZE = 65
    INDENTION_COUNT = 16
    ROW_LIMIT = 8

    def self.build(text)
      text = prepare_text(text)
      image = MiniMagick::Image.open(BASE_IMAGE_PATH)
      image.combine_options do |config|
        config.font FONT
        config.fill "red"
        config.gravity GRAVITY
        config.pointsize FONT_SIZE
        config.draw "text #{TEXT_POSITION} '#{text}'"
      end
    end

    private
    def self.prepare_text(text)
      text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
    end
end
