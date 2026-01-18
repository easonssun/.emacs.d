;; init-window.el 	-*- lexical-binding: t -*-
(add-hook 'after-init-hook 'winner-mode)

;; centaur-tabs
(require 'centaur-tabs)
(centaur-tabs-mode t)
(setq centaur-tabs-cycle-scope 'tabs)
(setq centaur-tabs-height 50)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-icon-type 'nerd-icons)  ; or 'nerd-icons
(setq centaur-tabs-gray-out-icons 'buffer)
(setq centaur-tabs-style "box")
(add-hook 'dashboard-mode-hook 'centaur-tabs-local-mode)

(require 'popper)
(setq popper-window-height 20)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
        "^\\*Copilot"
        "^\\*.*eshell.*\\*$" eshell-mode ;eshell as a popup
        "^\\*.*shell.*\\*$"  shell-mode  ;shell as a popup
        "^\\*.*term.*\\*$"   term-mode   ;term as a popup
        "^\\*.*eat.*\\*$"   eat-mode   ;term as a popup
        "^\\*.*vterm.*\\*$"  vterm-mode  ;vterm as a popup
        "^\\*Buffer List.*\\*$"
        "\\*Ibuffer.*\\*" ibuffer-mode ;ibuffer-mode
        help-mode
        magit-status-mode
        "COMMIT_EDITMSG"                       ;; exact match
        git-commit-ts-mode
        compilation-mode))
(popper-mode +1)

(provide 'init-window)
