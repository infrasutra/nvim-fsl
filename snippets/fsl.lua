-- FSL snippets for LuaSnip
-- Usage: require("luasnip.loaders.from_lua").load({ paths = { "path/to/nvim-fsl/snippets" } })

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Type definition
  s("type", {
    t("type "), i(1, "Name"), t({ " {", "\t" }),
    i(2, "field"), t(": "), i(3, "String"), i(4, "!"),
    t({ "", "}" }),
  }),

  -- Type with decorators
  s("typed", {
    t('@icon("'), i(1, "file-text"), t({ '")', "" }),
    t('@description("'), i(2, "Description"), t({ '")', "" }),
    t("type "), i(3, "Name"), t({ " {", "\t" }),
    i(4, "field"), t(": "), i(5, "String"), i(6, "!"),
    t({ "", "}" }),
  }),

  -- Enum definition
  s("enum", {
    t("enum "), i(1, "Name"), t({ " {", "\t" }),
    i(2, "value1"), t({ "", "\t" }),
    i(3, "value2"),
    t({ "", "}" }),
  }),

  -- String field
  s("fstring", {
    i(1, "field"), t(": String"), i(2, "!"), t(" @maxLength("), i(3, "200"), t(")"),
  }),

  -- Text field
  s("ftext", {
    i(1, "field"), t(": Text"), i(2, "!"),
  }),

  -- Int field
  s("fint", {
    i(1, "field"), t(": Int"), i(2, "!"), t(" @min("), i(3, "0"), t(") @max("), i(4, "100"), t(")"),
  }),

  -- Float field
  s("ffloat", {
    i(1, "field"), t(": Float"), i(2, "!"), t(" @precision("), i(3, "2"), t(")"),
  }),

  -- Boolean field
  s("fbool", {
    i(1, "field"), t(": Boolean"), i(2, "!"), t(' @default('), i(3, "false"), t(")"),
  }),

  -- DateTime field
  s("fdatetime", {
    i(1, "field"), t(": DateTime"), i(2, "!"),
  }),

  -- Date field
  s("fdate", {
    i(1, "field"), t(": Date"), i(2, "!"),
  }),

  -- RichText field
  s("frichtext", {
    i(1, "content"), t(": RichText"), i(2, "!"),
  }),

  -- Image field
  s("fimage", {
    i(1, "image"), t(": Image"), i(2, "!"), t(' @formats(["jpg", "png", "webp"])'),
  }),

  -- File field
  s("ffile", {
    i(1, "file"), t(": File"), i(2, "!"), t(" @maxSize("), i(3, "5242880"), t(")"),
  }),

  -- Slug field
  s("fslug", {
    i(1, "slug"), t(": Slug"), i(2, "!"), t(" @unique"),
  }),

  -- Array field
  s("farray", {
    i(1, "items"), t(": ["), i(2, "String"), t("]"), i(3, "!"), t(" @minItems("), i(4, "1"), t(") @maxItems("), i(5, "10"), t(")"),
  }),

  -- Relation field
  s("frelation", {
    i(1, "author"), t(": "), i(2, "Author"), i(3, "!"), t(" @relation"),
  }),

  -- Inline enum field
  s("finlineenum", {
    i(1, "status"), t(': "'), i(2, "draft"), t('" | "'), i(3, "published"), t('" | "'), i(4, "archived"), t('"'),
    t(' @default("'), i(5, "draft"), t('")'),
  }),

  -- JSON field
  s("fjson", {
    i(1, "data"), t(": JSON"), i(2, "!"),
  }),

  -- Blog post type template
  s("typeblog", {
    t({ '@icon("file-text")', '@description("Blog posts")', "type Post {", "" }),
    t({ "\ttitle: String! @maxLength(200)", "" }),
    t({ "\tslug: Slug! @unique", "" }),
    t({ "\texcerpt: Text @maxLength(500)", "" }),
    t({ "\tcontent: RichText!", "" }),
    t({ "\tcoverImage: Image", "" }),
    t({ "\tpublishedAt: DateTime", "" }),
    t({ '\tstatus: "draft" | "published" @default("draft")', "" }),
    t({ "\tauthor: Author @relation", "" }),
    t({ "\ttags: [String] @maxItems(10)", "" }),
    t("}"),
  }),

  -- Author type template
  s("typeauthor", {
    t({ '@icon("user")', '@description("Content authors")', "type Author {", "" }),
    t({ "\tname: String!", "" }),
    t({ "\temail: String! @unique", "" }),
    t({ "\tbio: Text", "" }),
    t({ "\tavatar: Image", "" }),
    t("}"),
  }),

  -- Settings singleton template
  s("typesettings", {
    t({ '@icon("settings")', "@singleton", '@description("Site settings")', "type Settings {", "" }),
    t({ "\tsiteName: String!", "" }),
    t({ "\ttagline: Text", "" }),
    t({ "\tlogo: Image", "" }),
    t({ "\tsocialLinks: JSON", "" }),
    t("}"),
  }),
}
