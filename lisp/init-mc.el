;; (use-package multiple-cursors
;;   :ensure t
;;   :bind-keymap ("C-c o" . multiple-cursors-map)
;;   :bind (("C-`"   . mc/mark-next-like-this)
;;          ("C-\\"  . mc/unmark-next-like-this)
;;          :map multiple-cursors-map
;;               ("SPC" . mc/edit-lines)
;;               (">"   . mc/mark-next-like-this)
;;               ("<"   . mc/mark-previous-like-this)
;;               ("a"   . mc/mark-all-like-this)
;;               ("n"   . mc/mark-next-like-this-word)
;;               ("p"   . mc/mark-previous-like-this-word)
;;               ("r"   . set-rectangular-region-anchor)
;;               )
;;   :config
;;   (defvar multiple-cursors-map nil "keymap for `multiple-cursors")
;;   (setq multiple-cursors-map (make-sparse-keymap))
;;   (setq mc/list-file (concat user-emacs-directory "/etc/mc-lists.el"))
;;   (setq mc/always-run-for-all t))


(use-package evil-mc
  :ensure t
  :config
  (global-evil-mc-mode  1))

(defun +evil-normal-state ()
  "Returns to `evil-normal-state'.
When in insert mode, abort company suggestions and then go to normal mode.
When in normal mode, abort multiple cursors and then go to normal mode.
Always quit highlighting."
  (interactive)
  (if (eq evil-state 'normal)
      (if (fboundp 'evil-mc-undo-all-cursors)
          (evil-mc-undo-all-cursors)))
  (if (eq evil-state 'insert)
      (if (fboundp 'company-abort)
          (company-abort)))
  (evil-ex-nohighlight)
  (evil-normal-state))

(evil-define-key* 'normal 'global
  (kbd "<escape>") #'+evil-normal-state)

(provide 'init-mc)
