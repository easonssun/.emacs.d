(use-package eglot
  :hook 
  (go-mode . eglot-ensure)
  (js-mode . eglot-ensure)
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  :init
  (setq completion-ignore-case t)      ;company-capf匹配时不区分大小写
  (setq read-process-output-max (* 1024 1024)) ; 1MB
  (setq eglot-autoshutdown t
      eglot-events-buffer-size 0
      eglot-send-changes-idle-time 0.1)
  :config
  (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd")))


(use-package consult-eglot
  :after consult eglot
  :bind (:map eglot-mode-map
        ("C-M-." . consult-eglot-symbols)))

(use-package eldoc-mouse
  :ensure t
  ;; enable mouse hover for eglot managed buffers, and emacs lisp buffers. ;; optional
  :hook (eglot-managed-mode emacs-lisp-mode))

;;(use-package eldoc-box
  ;;:ensure t
  ;;;; 设置 eldoc 显示为弹出框形式
  ;;:init
  ;;(eldoc-box-hover-at-point-mode 1)
  ;;:hook
  ;;(eglot--managed-mode . eldoc-box-hover-at-point-mode)
  ;;(eldoc-mode . eldoc-box-hover-at-point-mode))




;;(use-package lsp-mode
;;  :ensure t
;;  :commands (lsp lsp-deferred)
;;  :hook ((python-mode . lsp-deferred)
;;         (js-mode . lsp-deferred)
;;         (go-mode . lsp-deferred)
;;         (c++-mode . lsp-deferred))
;;  :init
;;  (setq lsp-keymap-prefix "C-c l")) ; 设置 LSP 前缀键
;;
;;(add-hook 'go-mode-hook #'lsp-deferred)
;;
;;(use-package lsp-ui
;;  :after lsp-mode
;;  :hook (lsp-mode . lsp-ui-mode)
;;  :config
;;  (setq lsp-ui-doc-position 'bottom) ; 悬浮文档显示位置
;;  (setq lsp-ui-sideline-show-hover t) ; 在侧边栏显示 hover 内容
;;  (setq lsp-ui-doc-enable t)) ; 启用文档悬浮窗

(provide 'init-lsp)
