import { createRouter, createWebHistory } from "vue-router";

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: "/",
      component: () =>
        import(/* webpackChunkName: "home" */ "../views/Home/Home.vue"),
    },
    {
      path: "/action-sheet",
      component: () => 
        import(/* webpackChunkName: "action-sheet" */ "../views/Action-Sheet/ActionSheet.vue"),
    },
    {
      path: '/action-sheet-child',
      component: () => 
        import(/* webpackChunkName: "action-sheet-child" */ "../views/Action-Sheet/ActionSheetChild.vue"),
    },
    {
      path: '/cell',
      component: () => 
        import(/* webpackChunkName: "cell" */ "../views/Cell/Cell.vue"),
    }
  ],
});

export default router;
