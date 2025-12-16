;; 使用 use-package 安装并加载 general.el
(use-package general
  :after evil
  :ensure t
  :config
  ;; 定义一个全局前缀键 "SPC"
  (general-create-definer my-leader-def
    :prefix "SPC"
    :non-normal-prefix "M-SPC")

  (general-create-definer my-local-leader-def
    :prefix ","
    :non-normal-prefix "M-,")

  (general-def
    "C-x C-b" 'ibuffer)     ; 使用 ibuffer

  (general-def
   :states 'normal
   "gh" 'eldoc-mouse-pop-doc-at-cursor
   "C-u" 'evil-scroll-up
   "C-d" 'evil-scroll-down)

  (general-def
   :states 'visual
   "Y" 'clipboard-kill-ring-save)

  (general-def
   :states 'insert
   "C-v" 'clipboard-yank
   "C-k" 'kill-line
   "C-u" 'evil-delete-back-to-indentation
   "C-d" 'delete-char)
  )

(provide 'init-keymaps)
