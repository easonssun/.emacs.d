;; setup
(setq make-backup-files nil)                 
(fset 'yes-or-no-p 'y-or-n-p)
(setq select-enable-clipboard nil)

;;; And I have tried
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(global-hl-line-mode t)

;; 加载 treesit-auto
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; (defun word-syntax- ()
;;   (interactive)
;;   (modify-syntax-entry ?- "w"))

;; (defun word-syntax_ ()
;;   (interactive)
;;   (modify-syntax-entry ?_ "w"))

;; (modify-syntax-entry ?- "w")

(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-shell-name "/bin/bash")
  (exec-path-from-shell-initialize))

(use-package ace-window
  :ensure t)

;; 记录 M-x 历史
(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode)
  :config
  ;; Allow commands in minibuffers, will affect `dired-do-dired-do-find-regexp-and-replace' command:
  (setq enable-recursive-minibuffers t)
  (setq history-length 1000)
  (setq savehist-additional-variables '(mark-ring
                                        global-mark-ring
                                        search-ring
                                        regexp-search-ring
                                        extended-command-history))
  (setq savehist-autosave-interval 300))

;; 文件历史
(use-package recentf
  :ensure nil
  :hook (after-init . recentf-mode)
  :custom
  (recentf-max-saved-items 300)
  (recentf-auto-cleanup 'never)
  ;; `recentf-add-file' will apply handlers first, then call `string-prefix-p'
  ;; to check if it can be pushed to recentf list.
  (recentf-filename-handlers '(abbreviate-file-name)))

(provide 'init-base)
