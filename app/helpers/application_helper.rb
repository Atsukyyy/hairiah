module ApplicationHelper
  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "Hairiah"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def default_meta_tags
    {
      reverse: true,
      charset: 'utf-8',
      description: 'Hairiah(ヘアリア)は、無料で髪を切りたい人と、技術を向上させたい美容師をマッチングするサービスです。',
      keywords: 'カットモデル,無料,美容院,無料カット',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('favicon.ico'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        description: 'Hairiah(ヘアリア)は、無料で髪を切りたい人と、技術を向上させたい美容師をマッチングするサービスです。',
        type: 'website',
        url: request.original_url,
        image: image_url('favicon.ico'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        site: '@ツイッターのアカウント名',
      }
    }
  end
end
