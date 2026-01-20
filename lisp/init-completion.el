;; init-completion.el 	-*- lexical-binding: t -*-

;; Optionally use the `orderless' completion style.
;; (require 'orderless)
(progn
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides '((file (styles basic partial-completion))))
  )

;; (require 'marginalia)
(add-hook 'after-init-hook 'marginalia-mode)
;; (use-package vertico-posframe
;;   :ensure t
;;   :hook (vertico-mode . vertico-posframe-mode))


;; (require 'vertico)
(with-eval-after-load 'vertico
  (setq vertico-count 10)
  (setq vertico-cycle t)
  )
(add-hook 'after-init-hook  'vertico-mode)
(add-hook 'vertico-mode-hook  'vertico-reverse-mode)
(add-hook 'vertico-mode-hook  'vertico-multiform-mode)


;; (require 'embark)
(setq prefix-help-command 'embark-prefix-help-command)

;; (require 'consult)
(progn
  ;; Tweak the register preview
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  ;; Optionally configure the narrowing key.
  (setq consult-narrow-key "<")
  )

(add-hook 'completion-list-mode-hook 'consult-preview-at-point-mode)

;; (require 'embark-consult)
;; (with-eval-after-load 'embark-consult
;;   (define-key minibuffer-mode-map (kbd "C-c C-o") 'embark-export)
;;   )
(add-hook 'embark-collect-mode-hook 'consult-preview-at-point-mode)

;; Auto completion - corfu
;;(unless (package-installed-p 'corfu)
;;(package-install 'corfu))

;; (require 'corfu)
;; 设置 corfu 变量
(progn
  (setq corfu-auto t)
  (setq corfu-auto-prefix 1)
  (setq corfu-preview-current nil)
  (setq corfu-auto-delay 0.2)
  (setq corfu-popupinfo-delay '(0.4 . 0.2))
  ;; 设置 corfu 字体
  (custom-set-faces
   '(corfu-border ((t (:inherit region :background unspecified)))))
  )
;; 启用 corfu 模式
(add-hook 'after-init-hook 'global-corfu-mode)
(add-hook 'global-corfu-mode-hook 'corfu-popupinfo-mode)

;; corfu 配置
(with-eval-after-load 'corfu
  (keymap-set corfu-map "RET"
              `(menu-item "" nil :filter
                          ,(lambda (&optional _)
                             ;; 如果当前是 eshell 或 comint 模式，返回 nil (忽略 corfu 绑定)
                             ;; 否则返回 corfu-send (执行 corfu 的补全确认)
                             (unless (or (derived-mode-p 'eshell-mode 'comint-mode)
                                         (minibufferp))
                               #'corfu-send))))
  )

;; corfu-terminal
(unless (display-graphic-p)
  ;; (require 'corfu-terminal)
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
(add-to-list 'completion-at-point-functions #'cape-dabbrev)
(add-to-list 'completion-at-point-functions #'cape-file)
(add-to-list 'completion-at-point-functions #'cape-elisp-block)
(add-to-list 'completion-at-point-functions #'cape-keyword)
(add-to-list 'completion-at-point-functions #'cape-abbrev)

(advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)

(provide 'init-completion)
