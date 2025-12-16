(set-frame-font "FiraCode Nerd Font")

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
;; (set-face-attribute 'default nil :height 160);;

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; auto pair
(electric-pair-mode t)
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package nerd-icons)

;; (load-theme 'wombat)
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 50))

(use-package centaur-tabs
  :ensure t
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-height 50)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-icon-type 'nerd-icons)  ; or 'nerd-icons
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-style "box"))

;; 配置 Popper
(use-package popper
  :ensure t
  :bind (("C--" . popper-toggle)  ; 将 Ctrl+- 绑定为开关弹窗
         ("M--" . popper-cycle))  ; 循环切换弹窗
  :init
  (setq popper-reference-buffers
    '("\\*Messages\\*"
	"Output\\*$"
	"\\*Async Shell Command\\*"
	"^\\*Copilot"
	"^\\*.*eshell.*\\*$" eshell-mode ;eshell as a popup
	"^\\*.*shell.*\\*$"  shell-mode  ;shell as a popup
	"^\\*.*term.*\\*$"   term-mode   ;term as a popup
	"^\\*.*vterm.*\\*$"  vterm-mode  ;vterm as a popup
	"^\\*Buffer List.*\\*$"
	help-mode
	magit-status-mode
	"COMMIT_EDITMSG"                       ;; exact match
	git-commit-ts-mode
	compilation-mode))
    (popper-mode +1)
    (popper-echo-mode +1))

(defun set-bigger-spacing ()                                               
  (interactive)
  (setq-local default-text-properties '(line-spacing 0.2 line-height 1.2)))

(provide 'init-ui)
