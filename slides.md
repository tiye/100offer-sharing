
# 简聊 React 开发经验梳理

---

# 关于我

题叶, Chen Yong

* <http://tiye.me>
* <http://react-china.org>
* <http://clojure-china.org>
* <http://segmentfault.com/blog/jiyinyiyong>
* <http://zhuanlan.zhihu.com/cold-code>

---

# 关于简聊

* jianliao.com
* 轻量、好用的团队沟通工具
* 前端一年前整个切换到 React.js

---

# 提纲

如果你在考虑用 React.js 写单页面应用:

* React 在简聊的开发思路
* React 不适合的场景
* 开发环境的优势
* 代码编译和服务端渲染

*不涉及 React Native*

---

# 开发思路

---

# 简单地说

* 全局的 Store 保存数据
* 每次 Store 有更新, 刷新整个 View
* 用户操作对 Store 进行修改

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-arch-simple.png)

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-arch-graph.png)

---

总体原则

* 数据界面分离
* 单向数据流
* 分析数据依赖, 合并数据请求(部分地...)

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-mvc-time.png)

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-mvc-pipe.png)

---

# 克服性能问题

* 使用 React 局部更新
* 使用 Immutable Data Structure 减少冗余计算
* 避免 Forced Layout
* 减小 Virtual DOM 节点数量

---

# 不适合的场景

---

# 列举一下

* 表单, 因为 State 需要动态生成, 而不是静态的
* 数据实现, 特别是数据和后端同步问题
* 动画, 动画意味着不停变化的私有状态

...以及其他

---

# 表单处理的问题

State 通常是写死的

    React.createClass
      getInitialState: ->
        a: 1
        b: 2

      render: ->
        div null, @state.a, @state.b

在 State 上写, 不方便. 不用 State, 脱离了方案

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-table.png)

---

# 数据同步问题

比如 React 组件切换页面, 同时意味着界面对应的数据换了.
这部分更新的数据需要从服务器抓取.

按照 GraphQL 的展示, 数据可能是嵌套的对象.
然而目前主流的 API 都是 Restful API, 更像是数组, 简单的数组.

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-data-path-2.png)

---

# 动画的难点

声明式语法, 和过程式的动画. 其实有着数据不一致的问题.

重复计算 Virtual DOM, 性能.

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-animation.png)

---

# 开发环境

---

# 罗列一些

* 组件化开发
* 代码热替换
* 全局的 Immutable Store 做 Time Travel
* 路由通过 Store 控制
* Modal 通过 Store 控制

---

# Demo

* actions-recorder
* router-view
* react-stack-modal

---

# 简聊 Demo

* Time Travel

注意切换时渲染整个页面的时间

---

# 简聊的热替换方案

* react-hot-loader 弃用
* 手写热替换逻辑, 文件更新基于 Store 渲染整个页面

hot-loader 作者已经不维护了.
手写的热替换代码不仅刷新 View, 也能配合其他代码替换数据操作代码.
山寨了 Redux 的主打功能.

为什么不用 Redux? 太复杂了, 对 JSX 依赖也太强.

---

# 代码编译和服务端渲染

---

# Webpack 自带的功能

* CommonJS 等语法支持, npm 模块管理
* 静态资源自动引用, 内联图片, 分离合并 CSS
* 自动生成 revision, `'js/vendor.[chunkhash:8].js'`
* 惰性加载代码

---

![](http://78recl.com1.z0.glb.clouddn.com/100offer-share-webpack-build.png)

---

# 简聊 Demo

* 聚合的页面, 异步加载

体积

    =>> du -h */*.js
    352K  1.js/1.e103d742.js
     52K  2.js/2.a80e800c.js
    156K  3.js/3.9ed2e01f.js
    1.0M  js/main.a18e2c55.js
    688K  js/vendor.468d07a3.js

---

# 服务端渲染

* React 组件支持在 Node.js 环境渲染
* 手动屏蔽浏览器环境依赖的代码的加载
* 注意生成依赖的数据(思考: 复用客户端数据逻辑)

---

# 简聊 Demo

* 服务端渲染, 禁用 JavaScript

账号页面功能单一, 初始化的数据结构简单, 直接在前后端复用.

---

# 总结, 考虑 React

* 简化了开发环节, 需要转换一些思路和重点
* 注意一些并不擅长的场景(合适的话考虑其他的方案)
* 对开发过程可以带来效率的提升
* Webpack 处理单页面的编译已经相当成熟(服务端基本可用)

另外, 团队因素... React 大量的新概念, 理解上的差异.

---

# 其他

* 招聘 Node.js 工程师

---

# Thanks

简聊前端交流 <https://jianliao.com/page/invite/f26cf1404g>
