;; init-mc.el   -*- lexical-binding: t -*-
(defvar my/is-multiple-cursors-mode nil)

;; 自动在 multiple-cursors 模式下禁用 evil，退出后重新启用
(defun my/disable-evil-for-mc (args)
  "在 multiple-cursors 模式启用时，局部禁用 evil。"
  (when (not my/is-multiple-cursors-mode)
    (cond
  ((evil-visual-state-p)
      (let ((mrk (mark))
    (pnt (point)))
      (evil-emacs-state)
      (set-mark mrk)
      (goto-char pnt)))
  (t
      (evil-emacs-state)))
    (setq-local my/evil-was-active-before-mc t)
    (setq my/is-multiple-cursors-mode t)
    )
  )

(defun my/restore-evil-after-mc ()
  "在 multiple-cursors 模式禁用时，恢复之前 evil 的状态。"
  (when (and (boundp 'my/evil-was-active-before-mc)
             my/evil-was-active-before-mc)
    (evil-normal-state)
    (setq my/is-multiple-cursors-mode nil)
    (kill-local-variable 'my/evil-was-active-before-mc))) ; 清理变量

;; 添加钩子
;; (add-hook 'multiple-cursors-mode-enabled-hook #'my/disable-evil-for-mc)
(dolist (cmd '(mc/mark-next-like-this
               mc/mark-previous-like-this
               mc/mark-all-like-this
               mc/mark-all-like-this-dwim
               mc/mark-next-like-this-word
               mc/mark-previous-like-this-word
               mc/mark-next-symbol-like-this
               mc/mark-previous-symbol-like-this
               mc/mark-all-in-region
               mc/edit-lines
               mc/insert-numbers))
  (advice-add cmd :before #'my/disable-evil-for-mc))
(add-hook 'multiple-cursors-mode-disabled-hook #'my/restore-evil-after-mc)

;; (global-set-key (kbd "C-M-p") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-M-n") 'mc/mark-next-like-this)
;; (global-set-key (kbd "M-<down>") 'mc/mark-next-like-this-word)

(provide 'init-mc)
