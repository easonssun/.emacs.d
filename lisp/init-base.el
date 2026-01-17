;; init-base.el 	-*- lexical-binding: t -*-
;; setup
(setq make-backup-files nil)                 
(fset 'yes-or-no-p 'y-or-n-p)
(setq select-enable-clipboard nil)

;;; And I have tried
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(global-hl-line-mode t)


(require 'exec-path-from-shell)
(with-eval-after-load 'exec-path-from-shell
  ;;(exec-path-from-shell-initialize)
  (setq exec-path-from-shell-shell-name "/bin/bash"))

;; 记录 M-x 历史
(add-hook 'after-init 'savehist-mode)
(setq enable-recursive-minibuffers t)
(setq history-length 1000)
(setq savehist-additional-variables '(mark-ring
				      global-mark-ring
				      search-ring
				      regexp-search-ring
				      extended-command-history))
(setq savehist-autosave-interval 300)

;; 文件历史
(add-hook 'after-init 'recentf-mode)
(setq recentf-max-saved-items 300)
(setq recentf-auto-cleanup 'never)
(setq recentf-filename-handlers '(abbreviate-file-name))

(provide 'init-base)

;; (defun word-syntax- ()
;;   (interactive)
;;   (modify-syntax-entry ?- "w"))

;; (defun word-syntax_ ()
;;   (interactive)
;;   (modify-syntax-entry ?_ "w"))

;; (modify-syntax-entry ?- "w")
