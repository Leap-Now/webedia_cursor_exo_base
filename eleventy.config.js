import EleventyVitePlugin from "@11ty/eleventy-plugin-vite";

export default function(eleventyConfig) {
  eleventyConfig.setServerPassthroughCopyBehavior('copy');
  eleventyConfig.addPassthroughCopy("public");
  // Add Vite plugin - handles JS/TS compilation and CSS processing
  eleventyConfig.addPlugin(EleventyVitePlugin, {
    tempFolderName: '.11ty-vite',
    viteOptions: {
      publicDir: 'public',
      clearScreen: false,
      server: {
        mode: 'development',
        middlewareMode: true,
      },
      appType: 'custom',
      assetsInclude: ['**/*.xml', '**/*.txt'],
      build: {
        mode: 'production',
        sourcemap: 'true',
        manifest: true,
        rollupOptions: {
          output: {
            assetFileNames: 'assets/css/main.[hash].css',
            chunkFileNames: 'assets/js/[name].[hash].js',
            entryFileNames: 'assets/js/[name].[hash].js'
          }
        }
      }
    }
  });

	// Copy/pass-through files
	eleventyConfig.addPassthroughCopy('src/assets/css')
	eleventyConfig.addPassthroughCopy('src/assets/js')

  return {
    dir: {
      input: "src",
      output: "_site",
      includes: "_includes",
      layouts: "_layouts",
      data: "_data"
    },
    templateFormats: ["md", "njk", "html", "liquid"],
    passthroughFileCopy: true,
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk"
  };
}
