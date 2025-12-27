;; Better terminal emulator
(use-package eat
  :ensure t
  :config
  (eat-eshell-mode 1)
  (setq eat-semi-char-non-bound-keys '([C--] [M--]))
  :hook ((eshell-load . eat-eshell-mode)
         (eshell-load . eat-eshell-visual-command-mode)))

 (use-package eshell
   :bind (:map eshell-mode-map
    ("C-l" . eshell-clear)
    ("<M-tab>" . tab-bar-switch-to-next-tab))
   :config
   (require 'em-smart)
   (require 'em-tramp)
   (defun eshell-clear ()
     (interactive)
     (let ((eshell-buffer-maximum-lines 0))
  (eshell-truncate-buffer)
  (previous-line)
  (delete-char 1)))
   (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t)
   :custom 
   (eshell-banner-message "")
   (eshell-visual-commands '("bat" "less" "more" "htop" "man" "vim" "fish"))
   (eshell-destroy-buffer-when-process-dies t)
   (eshell-cmpl-autolist t)
   (eshell-where-to-jump 'begin)
   (eshell-review-quick-commands nil)
   (eshell-smart-space-goes-to-end t)
   (eshell-history-size 10000)
   :hook ((eshell-mode-hook . (lambda ()
         (setq eshell-prefer-lisp-functions t
               password-cache t
               password-cache-expiry 900)
         (setq-local truncate-lines -1)
         (setenv "TERM" "xterm-256color")))))

(use-package em-rebind
  :ensure nil
  :commands eshell-delchar-or-maybe-eof)

(use-package esh-mode
  :ensure nil
  :bind (:map eshell-mode-map
              ("C-d" . eshell-delchar-or-maybe-eof)
              ("C-r" . consult-history))
  )
;; (use-package eshell-prompt-extras
;;   :ensure t
;;   :after esh-opt
;;   :config
;;   (autoload 'epe-theme-lambda "eshell-prompt-extras")
;;   ;; (setq eshell-highlight-prompt nil
;;   ;;       eshell-prompt-function 'epe-theme-multiline-with-status)
;;   )
(use-package eshell-git-prompt
  :ensure t
  :after esh-mode
  :custom-face
  (eshell-git-prompt-multiline2-dir-face ((t (:foreground "#c09035" :bold t))))
  :config
  (eshell-git-prompt-use-theme 'multiline2)
  )

(use-package eshell-syntax-highlighting
  :after esh-mode
  :ensure t
  :hook (eshell-mode . eshell-syntax-highlighting-global-mode)
  :custom-face
  (eshell-syntax-highlighting-shell-command-face ((t (:foreground "#7cc77f" :bold t))))
  )

(use-package capf-autosuggest
  :ensure t
  :hook ((eshell-mode comint-mod) . capf-autosuggest-mode)
  )

(provide 'init-term)
