;; init.el 	-*- lexical-binding: t -*-

(defun custom/downcase-back()
  (interactive)
  (downcase-word -1))
(defun custom/upcase-back()
  (interactive)
  (upcase-word -1))
(defun custom/capitalize-back()
  (interactive)
  (capitalize-word -1))

;; 在 evil 加载后配置 general
(with-eval-after-load 'evil
  ;; 定义一个全局前缀键 "SPC"
  (general-create-definer my-leader-def
    :prefix "SPC")
  
  (general-create-definer my-local-leader-def
    :prefix ",")
  
  (my-leader-def
    :states 'normal
    "f" 'eglot-format)
  
  (general-def
    ;; C-x bindings in `ctl-x-map'
    "<f12>" 'toggle-frame-fullscreen
    "C-;" 'embark-act
    "C-h b" 'embark-bindings
    
    "C-x C-r" 'projectile-switch-project     ; 使用 ibuffer
    "C-x C-b" 'ibuffer     ; 使用 ibuffer
    "C-x M-:" 'consult-complex-command     ;; orig. repeat-complex-command
    "C-x b" 'consult-buffer                ;; orig. switch-to-buffer
    "C-x 4 b" 'consult-buffer-other-window ;; orig. switch-to-buffer-other-window
    "C-x 5 b" 'consult-buffer-other-frame  ;; orig. switch-to-buffer-other-frame
    "C-x t b" 'consult-buffer-other-tab    ;; orig. switch-to-buffer-other-tab
    "C-x p b" 'consult-project-buffer      ;; orig. project-switch-to-buffer
    "C-x C-k" 'centaur-tabs-kill-all-buffers-in-current-group
    "C-x C-o" 'centaur-tabs-kill-other-buffers-in-current-group
    ;; Custom M-# bindings for fast register access
    "M-#" 'consult-register-load
    "M-'" 'consult-register-store          ;; orig. abbrev-prefix-mark (unrelated)
    "C-M-#" 'consult-register
    ;; C-c bindings in `mode-specific-map'
    "C-c M-x" 'consult-mode-command
    "C-c h" 'consult-history
    "C-c k" 'consult-kmacro
    "C-c c" 'compile
    "C-c m" 'consult-man
    "C-c i" 'consult-info
    "C-c e" 'eshell
    "C-c u" 'winner-undo
    "C-c r" 'winner-redo
    
    "M-y"  'consult-yank-pop                ;; orig. yank-pop
    "C-:" 'shell-command
    
    ;; "M-i"  'compile
                                        ; M-o bindings in `open-map'
    ;; "M-o e" 'eshell
    ;; "M-o t" 'eat
    
                                        ; M-g bindings in `goto-map'
    "M-g b" 'consult-bookmark            ;; orig. bookmark-jump
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
    "M-g s"  'centaur-tabs-switch-group
    "M-g p"  'consult-projectile
    
                                        ; M-s bindings in `search-map'
    "M-s f"  'consult-fd                  ;; Alternative: consult-fd
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
    
    ;; use M-g s instead
    ;; "M-<" 'centaur-tabs-backward-group
    ;; "M->" 'centaur-tabs-forward-group
    "C->" 'centaur-tabs-forward-tab
    "C-<" 'centaur-tabs-backward-tab
    
    "C-M-k" 'bookmark-delete
    "C--" 'popper-toggle
    "C-=" 'popper-cycle
    )
  
  (general-def 
    :states 'insert
    :keymaps 'eshell-mode-map
    ;; "C-u" 'evil-delete-back-to-indentation
    "C-p" 'eshell-previous-matching-input-from-input ; 搜索历史
    "C-n" 'eshell-next-matching-input-from-input   ; 搜索历史
    "C-r" 'consult-history)
  
  (general-def 
    ;; :states '(normal insert visual)
    :keymaps 'capf-autosuggest-active-mode-map
    "C-f" 'capf-autosuggest-end-of-line)
  
  (general-def
    :keymaps 'dired-mode-map
    :states '(normal insert visual)
    "C-a" 'dired-create-empty-file
    "C-d" 'dired-create-directory)
  
  (general-def
    :keymaps 'eat-mode-map
    "M-g w"  'ace-window
    "C-w C-w"  'other-window
    "C-w c"  'delete-window
    "C--"  'popper-toggle
    "M--"  'popper-cycle)
  ;; (define-key eat-mode-map (kbd "M--")     #'popper-cycle)
  
  (general-def
    ;; :states 指定在哪些 Evil 状态下生效。
    ;; 如果你希望所有模式（包括 Insert）都能用，可以写 '(normal insert) 或去掉这行。
    :states '(normal insert visual) 
    ;; :hooks 自动处理 add-hook 的逻辑
    :hooks '(prog-mode-hook text-mode-hook)
    
    "M-p" 'diff-hl-previous-hunk
    "M-n" 'diff-hl-next-hunk
    "M-," 'diff-hl-revert-hunk
    ;; "M-." 'diff-hl-stage-current-hunk
    "M-." 'diff-hl-stage-dwim
    "C-c h v" 'diff-hl-show-hunk)
  
  (general-def
    :states 'normal
    "gh" 'eldoc-mouse-pop-doc-at-cursor
    ;; "]b" 'centaur-tabs-forward-tab
    ;; "[b" 'centaur-tabs-backward-tab
    ;;"C-u" 'evil-scroll-up
    ;;"C-d" 'evil-scroll-down
    )
  
  (general-def
    :keymaps 'minuet-active-mode-map
    :states 'insert
    "<TAB>" 'minuet-accept-suggestion
    "M-p" 'minuet-previous-suggestion
    "M-n" 'minuet-next-suggestion)
  
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
    ;;"C-u" 'evil-delete-back-to-indentation
    "C-d" 'delete-char
    "M-u" 'custom/upcase-back
    "M-l" 'custom/downcase-back
    "M-c" 'custom/capitalize-back
    ))

(provide 'init-keymaps)
