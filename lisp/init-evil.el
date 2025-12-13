;;(use-package evil
  ;;:ensure t
  ;;:init (evil-mode)
  ;;:custom
  ;;(evil-undo-system 'undo-redo))
(use-package evil
  :ensure t
  :init
  ;; 启用 Evil 全局
  (setq evil-want-integration t)                ; 与 Emacs minor modes 集成
  ;;(setq evil-want-keybinding nil)               ; 不使用 Evil 自带键绑定（避免冲突）
  (setq evil-search-module 'evil-search)        ; 必须！支持 gn / cgn
  (setq evil-respect-visual-line-mode t)        ; 在 visual-line-mode 中按行移动
  (setq evil-cross-lines t)                     ; j/k 可跨软换行行（类似 Vim）
  (setq evil-undo-system 'undo-redo)            ; 使用 Emacs 的 undo-tree 或简易 undo-redo
  :config
  (evil-mode 1)
    ;; Vim 风格光标
  (defvar evil-normal-state-cursor 'box)
  (defvar evil-visual-state-cursor 'box)
  (defvar evil-insert-state-cursor 'bar)
  (defvar evil-replace-state-cursor 'bar)
  (defvar evil-motion-state-cursor 'hollow))
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
