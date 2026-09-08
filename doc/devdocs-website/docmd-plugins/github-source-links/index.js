// docmd plugin: github-source-links
//
// 【中文注释】本插件用于修复开发文档中的源码链接在静态站点上 404 的问题。
//
// 【中文注释】背景:开发文档以仓库根相对路径(如 "/src/modules/.../Foo.cpp")
// 链接源码文件。VS Code 会相对工作区根目录解析,本地编辑时可以点击跳转;
// 但发布后的静态站点上,"/src/..." 会被解析到站点域名下,导致 404。
//
// 【中文注释】本插件把这些链接改写为 GitHub 上的绝对 blob URL,使其在发布站点
// 上可用,同时不改动 Markdown 源文件(保住本地 VS Code 的跳转体验)。
//
// 【中文注释】实现上通过 markdownSetup 在 Markdown token 层面挂钩,因此只会
// 改写文档正文里写的链接。docmd 自己生成的链接(侧边栏、面包屑、canonical
// 标签)不会经过这里——这点很关键,否则像 "/tools/build-tools" 这样的站内路由
// 渲染成 HTML 后与 "/tools/BugReportTool" 这样的仓库路径无法区分。
//
// 【中文注释】docmd 会在改写后的链接末尾追加斜杠(".../Foo.cpp/");GitHub
// 依然能正确解析到文件,为简单起见保持原样。
const REPO_BLOB_BASE = 'https://github.com/microsoft/PowerToys/blob/main';

export default {
  plugin: {
    name: 'github-source-links',
    version: '1.0.0',
    capabilities: ['markdown'],
  },

  markdownSetup(md) {
    // 【中文注释】保存默认的 link_open 渲染器,便于改写 href 后继续走原逻辑
    const defaultRender =
      md.renderer.rules.link_open ||
      ((tokens, idx, options, env, self) => self.renderToken(tokens, idx, options));

    md.renderer.rules.link_open = (tokens, idx, options, env, self) => {
      const token = tokens[idx];
      const hrefIndex = token.attrIndex('href');

      if (hrefIndex >= 0) {
        const href = token.attrs[hrefIndex][1];

        // Only repo-root-relative links ("/src/..."). Leave protocol-relative
        // ("//host"), absolute ("https://..."), relative and anchor links alone.
        // 【中文注释】只处理仓库根相对链接("/src/...");协议相对("//host")、
        // 绝对("https://...")、相对路径和锚点链接一律不动。
        if (href.length > 1 && href[0] === '/' && href[1] !== '/') {
          token.attrs[hrefIndex][1] = REPO_BLOB_BASE + href;
        }
      }

      return defaultRender(tokens, idx, options, env, self);
    };
  },
};
