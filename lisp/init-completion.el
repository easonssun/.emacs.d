;; init-completion.el 	-*- lexical-binding: t -*-

;; Optionally use the `orderless' completion style.
(setq completion-styles '(orderless basic))
(setq completion-category-defaults nil)
(setq completion-category-overrides '((file (styles basic partial-completion))))
(require 'orderless)

;; Support Pinyin
;;(use-package pinyinlib
;;  :after orderless
;;  :autoload pinyinlib-build-regexp-string
;;  :init
;;  (defun orderless-regexp-pinyin (str)
;;    "Match COMPONENT as a pinyin regex."
;;    (orderless-regexp (pinyinlib-build-regexp-string str)))
;;  (add-to-list 'orderless-matching-styles 'orderless-regexp-pinyin))


(setq vertico-count 15)
(require 'vertico)
(add-hook 'after-init-hook  'vertico-mode)
(add-hook 'vertico-mode-hook  'vertico-reverse-mode)
(add-hook 'vertico-mode-hook  'vertico-multiform-mode)
(setq vertico-cycle t)

;; (use-package vertico-posframe
;;   :ensure t
;;   :hook (vertico-mode . vertico-posframe-mode))


(require 'embark)
;;(global-set-key (kbd "C-;") 'embark-act)
(setq prefix-help-command 'embark-prefix-help-command)

(require 'marginalia)
(add-hook 'after-init-hook 'marginalia-mode)

;; Example configuration for Consult
;; 安装并加载 consult
;;(unless (package-installed-p 'consult)
  ;;(package-install 'consult))

(require 'consult)

;; 设置键绑定
;;(define-key isearch-mode-map (kbd "M-e") 'consult-isearch-history)
;;(define-key isearch-mode-map (kbd "M-s e") 'consult-isearch-history)
;;(define-key isearch-mode-map (kbd "M-s l") 'consult-line)
;;(define-key isearch-mode-map (kbd "M-s L") 'consult-line-multi)
;;(define-key minibuffer-local-map (kbd "M-s") 'consult-history)
;;(define-key minibuffer-local-map (kbd "M-r") 'consult-history)

;; Enable automatic preview at point in the *Completions* buffer.
(add-hook 'completion-list-mode-hook 'consult-preview-at-point-mode)

;; Tweak the register preview
(advice-add #'register-preview :override #'consult-register-window)
(setq register-preview-delay 0.5)

;; Use Consult to select xref locations with preview
(setq xref-show-xrefs-function #'consult-xref
      xref-show-definitions-function #'consult-xref)

;; Configure preview
;;(consult-customize
 ;;consult-theme :preview-key '(:debounce 0.2 any)
 ;;consult-ripgrep consult-git-grep consult-grep consult-man
 ;;consult-bookmark consult-recent-file consult-xref
 ;;consult--source-bookmark consult--source-file-register
 ;;consult--source-recent-file consult--source-project-recent-file
 ;;:preview-key '(:debounce 0.4 any))

;; Optionally configure the narrowing key.
(setq consult-narrow-key "<")

;; 安装并加载 embark-consult
;;(unless (package-installed-p 'embark-consult)
  ;;(package-install 'embark-consult))

(require 'embark-consult)
(define-key minibuffer-mode-map (kbd "C-c C-o") 'embark-export)
(add-hook 'embark-collect-mode-hook 'consult-preview-at-point-mode)

;; Auto completion - corfu
;;(unless (package-installed-p 'corfu)
  ;;(package-install 'corfu))

(require 'corfu)

;; 设置 corfu 变量
(setq corfu-auto t)
(setq corfu-auto-prefix 1)
(setq corfu-preview-current nil)
(setq corfu-auto-delay 0.2)
(setq corfu-popupinfo-delay '(0.4 . 0.2))

;; 设置 corfu 字体
(custom-set-faces
 '(corfu-border ((t (:inherit region :background unspecified)))))

;; 设置键绑定
(global-set-key (kbd "M-/") 'completion-at-point)

;; 启用 corfu 模式
(add-hook 'after-init-hook 'global-corfu-mode)
(add-hook 'global-corfu-mode-hook 'corfu-popupinfo-mode)

;; corfu 配置
(keymap-set corfu-map "RET"
            `(menu-item "" nil :filter
                        ,(lambda (&optional _)
                           ;; 如果当前是 eshell 或 comint 模式，返回 nil (忽略 corfu 绑定)
                           ;; 否则返回 corfu-send (执行 corfu 的补全确认)
                           (unless (or (derived-mode-p 'eshell-mode 'comint-mode)
                                       (minibufferp))
                             #'corfu-send))))

;; corfu-terminal
(unless (display-graphic-p)
  ;;(unless (package-installed-p 'corfu-terminal)
    ;;(package-install 'corfu-terminal))
  (require 'corfu-terminal)
  (add-hook 'global-corfu-mode-hook 'corfu-terminal-mode))

;; Emacs 原生配置
;; TAB cycle if there are only few candidates
;; (setq completion-cycle-threshold 3)

;; Enable indentation+completion using the TAB key.
;; `completion-at-point' is often bound to M-TAB.
;; (setq tab-always-indent 'complete)

;; Emacs 30 and newer: Disable Ispell completion function.
(setq text-mode-ispell-word-completion nil)

;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current mode.
(setq read-extended-command-predicate #'command-completion-default-include-p)

;; Add extensions - cape
;;(unless (package-installed-p 'cape)
;;  (package-install 'cape))

(require 'cape)
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-file)
(add-to-list 'completion-at-point-functions #'cape-elisp-block)
(add-to-list 'completion-at-point-functions #'cape-keyword)
(add-to-list 'completion-at-point-functions #'cape-abbrev)

(advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)

(provide 'init-completion)