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

(defun my/find-project-root (&optional directory)
  "向上查找包含特定标记文件的目录，作为项目根目录。
默认查找 `.git` 或 `.projectile` 目录。"
  (let ((dir (or directory default-directory)))
    (or (locate-dominating-file dir ".git")
        (locate-dominating-file dir ".projectile")
        ;; 可以继续添加其他标记文件，如 'pom.xml', 'package.json' 等
        dir))) ;; 如果找不到，返回当前目录

(defun my/set-custom-root-as-default-directory ()
  "将当前 buffer 的 default-directory 设置为自定义项目根目录。"
  (interactive)
  (setq-local default-directory (my/find-project-root)))

(add-hook 'find-file-hook #'my/set-custom-root-as-default-directory)

(provide 'init-project)
