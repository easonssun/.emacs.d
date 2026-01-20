;; 加载 treesit-auto
(require 'treesit-auto)
(with-eval-after-load
  (treesit-auto-add-to-auto-mode-alist 'all)
  (setq treesit-auto-install 'prompt)
  (global-treesit-auto-mode)
  )

(progn
  (setq completion-ignore-case t)      ;company-capf匹配时不区分大小写
  (setq read-process-output-max (* 1024 1024)) ; 1MB
  (setq eglot-autoshutdown t)
  ;; eglot-send-changes-idle-time 0.1
  (setq eglot-events-buffer-size 0)
  )
(require 'eglot)
(add-hook 'go-ts-mode-hook 'eglot-ensure)
(add-hook 'js-ts-mode-hook 'eglot-ensure)
(add-hook 'c-ts-mode-hook 'eglot-ensure)
(add-hook 'c++-ts-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs '((c++-ts-mode c-ts-mode) "clangd"))

(with-eval-after-load 'eglot
  (require 'consult-eglot)
  (require 'eldoc-mouse))

(provide 'init-lsp)
