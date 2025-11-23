(use-package evil
  :ensure t
  :init (evil-mode)
  :custom
  (evil-undo-system 'undo-redo))
(use-package evil-surround
  :ensure t
  :init (global-evil-surround-mode 1))
(use-package evil-visualstar
  :ensure t
  :init (global-evil-visualstar-mode))

(global-unset-key (kbd "C-SPC"))
;; (add-hook 'emacs-startup-hook (lambda () (call-process "fcitx5-remote -e && fcitx5-remote -t")))  ; Linux（Fcitx）
(add-hook 'evil-normal-state-entry-hook
          (lambda ()
            (call-process "fcitx5-remote" nil 0 nil "-c")))  ; -c 表示关闭输入法（英文状态）
;; (global-set-key (kbd "C-SPC") (lambda () (call-process "fcitx5-remote" nil 0 nil "-o")))

(provide 'init-evil)
