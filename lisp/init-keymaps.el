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
    "C-c t" 'multi-vterm          ; 全局打开/切换多终端
    "C-c n" 'multi-vterm-next     ; 切换到下一个终端
    "C-c p" 'multi-vterm-prev)     ; 切换到上一个终端

  (general-def
   :states 'normal
   "gh" 'eldoc-box-position-function
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
