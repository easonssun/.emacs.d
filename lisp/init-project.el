(use-package projectile
  :ensure t
  :init
  (projectile-mode t) ;; 全局启用 Projectile 模式
  :bind-keymap
  ("C-c p" . projectile-command-map) ;; 设置全局前缀键
  :config
  (setq projectile-enable-caching t) ;; 启用缓存（通常默认开启，提升性能）
  ;; (setq projectile-indexing-method 'alien) ;; 对于非常大的项目，可尝试 'alien 索引方法
  )

(use-package consult-projectile
  :ensure t
  :after (projectile consult) ;; 确保在 projectile 和 consult 之后加载
  :config
  ;; 你可以在这里进行自定义配置，例如绑定快捷键
  )

(provide 'init-project)
