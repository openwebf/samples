const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  filenameHashing: false,
  productionSourceMap: false,

  transpileDependencies: true,
  // 关闭sso
  devServer: {
    compress: true,
    hot: false,
    liveReload: false,
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
  },
  chainWebpack: config => {
    config.module
      .rule('vue')
      .use('vue-loader')
      .tap(options => ({
        ...options,
        compilerOptions: {
          // treat any tag that starts with flutter- as custom elements
          isCustomElement: tag => tag.startsWith('flutter-')
        }
      }))
  }
})
