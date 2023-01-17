/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
    title: 'Linwood Launch',
    tagline: 'Opensource app launcher',
    url: 'https://docs.flow.linwood.dev',
    baseUrl: '/',
    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',
    favicon: 'img/favicon.ico',
    organizationName: 'LinwoodCloud', // Usually your GitHub org/user name.
    projectName: 'launch', // Usually your repo name.
    i18n: {
        defaultLocale: 'en',
        locales: ['en', 'de', 'fr', 'es', 'it', 'pt-br', 'th', 'tr'],
    },
    themeConfig: {
        colorMode: {
            defaultMode: 'dark',
            disableSwitch: false,
            respectPrefersColorScheme: true,
        },
        algolia: {
            // The application ID provided by Algolia
            appId: 'PQN0C3O7D3',

            // Public API key: it is safe to commit it
            apiKey: '219c0a938f5cec6e889c1e5edaef7035',

            indexName: 'docs-launch-linwood',

            //... other Algolia params
        },
        navbar: {
            title: 'Launch',
            logo: {
                alt: 'Launch Logo',
                src: 'img/logo.svg',
            },
            items: [
                {
                    type: 'doc',
                    docId: 'intro',
                    position: 'left',
                    label: 'Tutorial',
                },
                {
                    to: 'downloads',
                    label: 'Downloads',
                    position: 'left'
                },
                {
                    type: 'doc',
                    docId: 'community',
                    docsPluginId: 'community',
                    position: 'left',
                    label: 'Community',
                },
                {
                    type: 'dropdown',
                    label: 'More',
                    position: 'left',
                    items: [
                        {
                            label: 'Matrix',
                            href: 'https://linwood.dev/matrix',
                        },
                        {
                            label: 'Discord',
                            href: 'https://discord.linwood.dev',
                        },
                        {
                            label: 'GitHub',
                            href: 'https://github.com/LinwoodCloud/Launch',
                        },
                        {
                            label: 'Blog', 
                            href: 'https://linwood.dev/blog'
                        },
                        {
                            label: 'Crowdin',
                            href: 'https://go.linwood.dev/launch/crowdin'
                        },
                        {
                            label: 'Twitter',
                            href: 'https://twitter.com/LinwoodCloud',
                        },
                        {
                            label: 'Mastodon',
                            href: 'https://floss.social/@linwood',
                        },
                        {
                            label: 'License',
                            href: 'https://go.linwood.dev/launch/license',
                        }
                    ],
                },
                {
                    type: 'docsVersionDropdown',
                    position: 'right',
                    dropdownItemsBefore: [],
                    dropdownItemsAfter: [{ to: '/versions', label: 'All versions' }],
                    dropdownActiveClassDisabled: true
                },
                {
                    type: 'localeDropdown',
                    position: 'right',
                    dropdownItemsAfter: [{ to: 'https://translate.linwood.dev/launch', label: 'Help translate' }],
                }
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
                            href: 'https://discord.linwood.dev',
                        },
                        {
                            label: 'Matrix',
                            href: 'https://linwood.dev/matrix',
                        },
                        {
                            label: 'Twitter',
                            href: 'https://twitter.com/LinwoodCloud',
                        },
                        {
                            label: 'Mastodon',
                            href: 'https://floss.social/@linwood',
                        },
                        {
                            html: `
                <a href="https://vercel.com?utm_source=Linwood&utm_campaign=oss" target="_blank" rel="noreferrer noopener" aria-label="Deploys by Vercel">
                  <img src="/img/powered-by-vercel.svg" alt="Deploys by Vercel" />
                </a>
              `,
                        },
                    ],
                },
                {
                    title: 'Source code',
                    items: [
                        {
                            label: 'App',
                            href: 'https://github.com/LinwoodCloud/launch/tree/develop/app',
                        },
                        {
                            label: 'Docs',
                            href: 'https://github.com/LinwoodCloud/launch/tree/develop/docs',
                        },
                        {
                            label: 'Contribution guide',
                            href: 'https://github.com/LinwoodCloud/launch/blob/develop/CONTRIBUTING.md',
                        },
                    ],
                },
                {
                    title: 'Legal',
                    items: [
                        {
                            label: 'Imprint',
                            href: 'https://go.linwood.dev/imprint',
                        },
                        {
                            label: 'Privacy Policy of the app',
                            href: '/privacypolicy',
                        },
                        {
                            label: 'Privacy Policy of the website',
                            href: 'https://go.linwood.dev/privacypolicy',
                        },
                    ],
                }
            ],
            logo: {
                alt: 'Linwood Logo',
                src: 'https://raw.githubusercontent.com/LinwoodCloud/website/main/public/Linwood.png',
                width: 100,
                href: 'https://linwood.dev',
            },
            copyright: `Copyright © ${new Date().getFullYear()} LinwoodCloud.`,
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
                        'https://github.com/LinwoodCloud/launch/edit/develop/docs/',
                    versions: {
                        "current": {
                            label: "Nightly",
                            path: "1.0",
                        }
                    }
                },
                blog: false,
                theme: {
                    customCss: require.resolve('./src/css/custom.css'),
                },
            },
        ],
    ],
    plugins: [
        [
            '@docusaurus/plugin-content-docs',
            {
                id: 'community',
                path: 'community',
                routeBasePath: '/',
                sidebarPath: require.resolve('./sidebarsCommunity.js')
            },
        ],
        [
            '@docusaurus/plugin-pwa',
            {
                offlineModeActivationStrategies: [
                    'appInstalled',
                    'standalone',
                    'queryString',
                ],
                pwaHead: [
                    {
                        tagName: 'link',
                        rel: 'icon',
                        href: '/img/logo.png',
                    },
                    {
                        tagName: 'link',
                        rel: 'manifest',
                        href: '/manifest.json', // your PWA manifest
                    },
                    {
                        tagName: 'meta',
                        name: 'theme-color',
                        content: '#f2b138',
                    },
                ],
            },
        ],
        // Other tweaks
    ]
};
