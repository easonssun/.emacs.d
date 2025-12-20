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
     ;; C-x bindings in `ctl-x-map'
     "C-x M-:" 'consult-complex-command     ;; orig. repeat-complex-command
     "C-x b" 'consult-buffer                ;; orig. switch-to-buffer
     "C-x 4 b" 'consult-buffer-other-window ;; orig. switch-to-buffer-other-window
     "C-x 5 b" 'consult-buffer-other-frame  ;; orig. switch-to-buffer-other-frame
     "C-x t b" 'consult-buffer-other-tab    ;; orig. switch-to-buffer-other-tab
     "C-x r b" 'consult-bookmark            ;; orig. bookmark-jump
     "C-x p b" 'consult-project-buffer      ;; orig. project-switch-to-buffer
     ;; Custom M-# bindings for fast register access
     "M-#" 'consult-register-load
     "M-'" 'consult-register-store          ;; orig. abbrev-prefix-mark (unrelated)
     "C-M-#" 'consult-register
     ;; C-c bindings in `mode-specific-map'
     "C-c M-x" 'consult-mode-command
     "C-c h" 'consult-history
     "C-c k" 'consult-kmacro
     "C-c m" 'consult-man
     "C-c i" 'consult-info

     "M-y"  'consult-yank-pop                ;; orig. yank-pop
     ; M-g bindings in `goto-map'
     "M-g e"  'consult-compile-error
     "M-g f"  'consult-flymake               ;; Alternative: consult-flycheck
     "M-g g"  'consult-goto-line             ;; orig. goto-line
     "M-g o"  'consult-outline               ;; Alternative: consult-org-heading
     "M-g m"  'consult-mark
     "M-g k"  'consult-global-mark
     "M-g i"  'consult-imenu
     "M-g I"  'consult-imenu-multi
     "M-g w"  'ace-window
     "M-g t"  'centaur-tabs-ace-jump
     ; M-s bindings in `search-map'
     "M-s f"  'consult-find                  ;; Alternative: consult-fd
     "M-s c"  'consult-locate
     "M-s g"  'consult-grep
     "M-s G"  'consult-git-grep
     "M-s r"  'consult-ripgrep
     "M-s l"  'consult-line
     "M-s L"  'consult-line-multi
     "M-s k"  'consult-keep-lines
     "M-s u"  'consult-focus-lines
     ; Isearch integration
     "M-s e"  'consult-isearch-history
    )

  (general-def
    :keymaps 'eat-mode-map
    :states 'insert
    "M-g w"  'ace-window
    "C-w C-w"  'other-window
    "C-w c"  'delete-window
    "C--"  'popper-toggle
    "M--"  'popper-cycle)
  ;; (define-key eat-mode-map (kbd "M--")     #'popper-cycle)

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
    :states '(normal visual)
    "C-M-n" 'evil-mc-make-and-goto-next-match
    "C-M-m" 'evil-mc-skip-and-goto-next-match)

  (general-def
   :states 'insert
   "C-v" 'clipboard-yank
   "C-a" 'beginning-of-line
   "C-e" 'end-of-line
   "C-k" 'kill-line
   "C-u" 'evil-delete-back-to-indentation
   "C-d" 'delete-char)


  )

(provide 'init-keymaps)
