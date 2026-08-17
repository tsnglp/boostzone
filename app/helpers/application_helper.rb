module ApplicationHelper
  def turnstile_site_key
    ENV["TURNSTILE_SITE_KEY"]
  end

  def nav_link_to(label, path, mobile: false)
    base_classes = if mobile
      "block rounded-xl px-4 py-3 text-sm font-medium transition duration-200"
    else
      "rounded-full px-4 py-2 text-sm font-medium transition duration-200"
    end

    active_classes = mobile ? "bg-accent/15 text-white" : "bg-accent/15 text-white shadow-sm"
    inactive_classes = mobile ? "text-slate-200 hover:bg-white/5 hover:text-white" : "text-slate-200 hover:bg-white/5 hover:text-white"

    link_to label, path, class: [ base_classes, current_page?(path) ? active_classes : inactive_classes ].join(" ")
  end

  def service_anchor_path(slug)
    services_path(anchor: slug)
  end

  def icon(name, classes: "h-6 w-6")
    icons = {
      lightning: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M13 2L4 14h6l-1 8 9-12h-6l1-8z")
      ],
      chatbot: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M8.625 9.75h6.75M8.625 12.75h4.5M7.5 4.5h9A2.25 2.25 0 0118.75 6.75v7.5A2.25 2.25 0 0116.5 16.5h-4.19l-3.09 3.09A.75.75 0 017.5 19.06V16.5h-.75A2.25 2.25 0 014.5 14.25v-7.5A2.25 2.25 0 016.75 4.5H7.5z")
      ],
      website: [
        tag.rect(x: "3.75", y: "5.25", width: "16.5", height: "13.5", rx: "2.25", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75"),
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M3.75 9.75h16.5M8.25 15.75h2.25")
      ],
      maintenance: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M11.42 3.17a6.72 6.72 0 00-4.28 1.69l3.9 3.9a1.5 1.5 0 010 2.12l-1.06 1.06a1.5 1.5 0 01-2.12 0l-3.9-3.9A6.75 6.75 0 1011.42 3.17zm3.42 10.66l4.99 4.99a1.5 1.5 0 11-2.12 2.12l-4.99-4.99")
      ],
      devops: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M4.5 6.75A2.25 2.25 0 016.75 4.5h10.5a2.25 2.25 0 012.25 2.25v1.5A2.25 2.25 0 0117.25 10.5H6.75A2.25 2.25 0 014.5 8.25v-1.5zm0 9A2.25 2.25 0 016.75 13.5h10.5a2.25 2.25 0 012.25 2.25v1.5A2.25 2.25 0 0117.25 19.5H6.75A2.25 2.25 0 014.5 17.25v-1.5zM9 10.5v3m6-3v3")
      ],
      testing: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M9 5.25h6M9 9.75h6m-6 4.5h3m-4.5 6h9a2.25 2.25 0 002.25-2.25V5.25A2.25 2.25 0 0016.5 3h-9A2.25 2.25 0 005.25 5.25v12.75A2.25 2.25 0 007.5 20.25zm7.5-5.25l1.5 1.5 3-3")
      ],
      support: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M12 18.75a6.75 6.75 0 006.75-6.75V9A6.75 6.75 0 005.25 9v3A6.75 6.75 0 0012 18.75zm0 0v1.5m-3.75-9.75V9a3.75 3.75 0 117.5 0v1.5M5.25 11.25h-1.5v2.25a2.25 2.25 0 002.25 2.25H7.5m9-4.5h1.5v2.25a2.25 2.25 0 01-2.25 2.25H16.5")
      ],
      contracts: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M15.75 3.75H8.25A2.25 2.25 0 006 6v12a2.25 2.25 0 002.25 2.25h7.5A2.25 2.25 0 0018 18V6a2.25 2.25 0 00-2.25-2.25zM9 8.25h6m-6 3h6m-6 3h3")
      ],
      cloud: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M6.75 18a3.75 3.75 0 01-.53-7.47A5.63 5.63 0 0111.63 6a5.6 5.6 0 015.53 4.88A3.75 3.75 0 0117.25 18H6.75z")
      ],
      api: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M7.5 7.5l-3 4.5 3 4.5M16.5 7.5l3 4.5-3 4.5M13.5 4.5l-3 15")
      ],
      security: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M12 3l7.5 3v5.25c0 4.46-3.02 8.49-7.5 9.75-4.48-1.26-7.5-5.29-7.5-9.75V6L12 3zm-1.5 9.75l1.5 1.5 3-3")
      ],
      ecommerce: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M3.75 5.25h2.14c.33 0 .61.23.68.55l.37 1.7m0 0h10.92c.47 0 .82.45.7.9l-1.12 4.5a.75.75 0 01-.73.57H8.1a.75.75 0 01-.73-.59L6.94 7.5zm1.31 9.75a1.5 1.5 0 100 3 1.5 1.5 0 000-3zm8.25 0a1.5 1.5 0 100 3 1.5 1.5 0 000-3z")
      ],
      consulting: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M4.5 19.5h15M6.75 16.5V9.75m5.25 6.75v-9m5.25 9V5.25M9 6h6")
      ],
      local: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M12 21s6-5.69 6-11.25A6 6 0 006 9.75C6 15.31 12 21 12 21zm0-8.25a3 3 0 100-6 3 3 0 000 6z")
      ],
      solutions: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M5.25 5.25h5.25v5.25H5.25V5.25zm8.25 0h5.25v5.25H13.5V5.25zM5.25 13.5h5.25v5.25H5.25V13.5zm8.25 0h5.25v5.25H13.5V13.5z")
      ],
      pricing: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M12 6V4.5m0 15V18m-3-9h6a2.25 2.25 0 100-4.5H9.75A2.25 2.25 0 007.5 6.75c0 1.24 1.01 2.25 2.25 2.25h4.5a2.25 2.25 0 110 4.5H9a2.25 2.25 0 100 4.5h6")
      ],
      mission: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M5.25 3.75v16.5m0-15c2.25 0 3.75 1.5 6 1.5s3.75-1.5 6-1.5v9c-2.25 0-3.75 1.5-6 1.5s-3.75-1.5-6-1.5")
      ],
      integrity: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M12 3l7.5 3v5.25c0 4.46-3.02 8.49-7.5 9.75-4.48-1.26-7.5-5.29-7.5-9.75V6L12 3zm0 6v6m0 0l2.25-2.25M12 15l-2.25-2.25")
      ],
      innovation: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M9.75 18.75h4.5m-4.13-11.5a4.5 4.5 0 117.76 3.09c-.6.8-1.4 1.47-1.84 2.38-.28.58-.41 1.2-.41 1.86h-3.75c0-.66-.14-1.28-.41-1.86-.44-.91-1.24-1.58-1.84-2.38a4.47 4.47 0 01-.88-2.69zM10.5 21h3")
      ],
      growth: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M4.5 18.75h15M7.5 15l3-3 2.25 2.25L16.5 9m0 0h-3m3 0v3")
      ],
      mail: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M3.75 6.75A2.25 2.25 0 016 4.5h12A2.25 2.25 0 0120.25 6.75v10.5A2.25 2.25 0 0118 19.5H6a2.25 2.25 0 01-2.25-2.25V6.75zm1.06-.53L12 11.25l7.19-5.03")
      ],
      phone: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M2.25 5.25c0 9.11 7.39 16.5 16.5 16.5h2.25v-4.19l-4.53-1.13a1.5 1.5 0 00-1.46.41l-.99.99a13.54 13.54 0 01-5.85-5.85l.99-.99a1.5 1.5 0 00.41-1.46L8.44 3H4.25A2 2 0 002.25 5.25z")
      ],
      map: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M9 6l6-2.25 6 2.25v12l-6-2.25L9 18 3 15.75v-12L9 6zm0 0v12m6-14.25v12")
      ],
      people: [
        tag.path(stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "1.75", d: "M15 19.5v-1.13a3.38 3.38 0 00-2.11-3.14 4.13 4.13 0 10-5.78 0A3.38 3.38 0 005 18.37v1.13m10-9A3.75 3.75 0 1118.75 6.75 3.75 3.75 0 0115 10.5z")
      ]
    }

    content_tag(
      :svg,
      safe_join(icons.fetch(name.to_sym)),
      xmlns: "http://www.w3.org/2000/svg",
      viewBox: "0 0 24 24",
      fill: "none",
      stroke: "currentColor",
      class: classes,
      "aria-hidden": true
    )
  end
end
