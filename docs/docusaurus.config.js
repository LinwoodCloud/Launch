/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: 'Linwood Launcher',
  tagline: 'Open source start page',
  url: 'https://docs.launch.linwood.tk',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',
  organizationName: 'LinwoodCloud', // Usually your GitHub org/user name.
  projectName: 'Launcher', // Usually your repo name.
  themeConfig: {
    navbar: {
      title: 'Linwood Launcher',
      logo: {
        alt: 'Linwood Launcher',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'doc',
          docId: 'intro',
          position: 'left',
          label: 'Docs',
        },
        {
          to: 'downloads',
          position: 'left',
          label: 'Downloads',
        },
        {href: 'https://linwood.tk/blog', label: 'Blog', position: 'left'},
        {
          href: 'https://github.com/facebook/docusaurus',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Community',
          items: [
            {
              label: 'Discord',
              href: 'https://discord.linwood.tk',
            },
            {
              label: 'Twitter',
              href: 'https://twitter.com/LinwoodCloud',
            },
          ],
        },
        {
          title: 'Source code',
          items: [
            {
              label: 'App',
              href: 'https://github.com/LinwoodCloud/Launcher/tree/develop/app',
            },
            {
              label: 'Docs',
              href: 'https://github.com/LinwoodCloud/Launcher/tree/develop/docs',
            }
          ],
        },
        {
          title: 'Legal',
          items: [
            {
              label: 'Imprint',
              to: 'https://codedoctor.tk/impress',
            },
            {
              label: 'Privacy Policy',
              href: 'https://codedoctor.tk/privacy',
            },
          ],
        }
      ],
      copyright: `Copyright © ${new Date().getFullYear()} My Project, Inc. Built with Docusaurus.`,
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          editUrl:
            'https://github.com/facebook/docusaurus/edit/master/website/',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          editUrl:
            'https://github.com/facebook/docusaurus/edit/master/website/blog/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
};
