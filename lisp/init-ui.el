;; init-ui.el 	-*- lexical-binding: t -*-
;; (set-frame-font "-CTDB-FiraCode Nerd Font-medium-normal-normal-*-26-*-*-*-m-0-iso10646-1" nil t)
;; (set-frame-font "FiraCode Nerd Font" nil t)
(set-frame-font "JetBrains Mono" nil t)
;; 开启连体字
(global-prettify-symbols-mode 1)
;; 优化字体渲染
;; (setq-default line-spacing 0.2)  ; 行间距
(setq-default cursor-type '(bar . 2))  ; 光标样式

;;让鼠标滚动更好用
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

;; line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-width 4)

;; auto pair
(electric-pair-mode t)

;; rainbow-delimiters
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; whitespace mode 显示制表符
(require 'whitespace)

;; 1. 配置显示的样式
(setq whitespace-style '(tabs tab-mark spaces space-mark))

;; 2. 配制符号映射
;; 这里将 Tab (ASCII 9) 映射为 » (Unicode 187)
;; 如果你希望空格也显示，可以取消下面关于 space-mark 的注释
(setq-default tab-width 2)
(setq whitespace-display-mappings
      '(
        (tab-mark 9 [187 9])       ; Tab 显示为 »
        ;;(space-mark 32 [183])     ; Space 显示为 · (中间点)
        ;;(space-mark 160 [164])    ; Non-breaking space 显示为 ¤
        ))

;; 3. 自定义颜色（可选）
;; 默认颜色可能太刺眼，设置为深灰色或柔和的颜色
(set-face-attribute 'whitespace-tab nil
                    :background "#414243"  ; 背景色（与你的主题匹配）
                    :foreground "#414243")  ; 前景色（符号颜色，例如红色）

;; 4. 全局开启
(add-hook 'prog-mode-hook 'whitespace-mode)

;; nerd-icons
(require 'nerd-icons)
(require 'nerd-icons-completion)
(require 'nerd-icons-corfu)
(require 'nerd-icons-dired)

(add-hook 'vertico-mode-hook 'nerd-icons-completion-mode)

;; dashboard
(require 'dashboard)
;; (setq dashboard-banner-logo-title "~/.emacs.d/logo.svg")
(setq dashboard-startup-banner "~/.emacs.d/logo.svg")
(setq dashboard-icon-type 'nerd-icons)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(dashboard-setup-startup-hook)

;; (load-theme 'wombat)
;; doom-themes
(require 'doom-themes)
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
(doom-themes-org-config)

;; doom-modeline
(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-height 50)

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

(defun set-bigger-spacing ()                                               
  (interactive)
  (setq-local default-text-properties '(line-spacing 0.2 line-height 1.2)))

(provide 'init-ui)
