;; Better terminal emulator
(use-package eat
  :ensure t
  :hook ((eshell-load . eat-eshell-mode)
         (eshell-load . eat-eshell-visual-command-mode)))

(provide 'init-term)
