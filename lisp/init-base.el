;; setup
(setq make-backup-files nil)                 

;;; And I have tried
(setq indent-tabs-mode nil)
(setq tab-width 2)

(use-package exec-path-from-shell
    :ensure t)
    ;;:config
    ;;(exec-path-from-shell-initialize))

(provide 'init-base)
