;; (defun my-diff-hl-fringe-bmp-function (_type _pos)
;; "Fringe bitmap function for use as `diff-hl-fringe-bmp-function'."
;;     (define-fringe-bitmap 'my-diff-hl-bmp
;; 	(vector ((if (eq system-type 'gnu/linux) #b11111100 #b11100000)))
;; 	1 8
;; 	'(center t)))

(use-package magit
  :ensure t
  :config
  (unbind-key "M-1" magit-mode-map)
  (unbind-key "M-2" magit-mode-map)
  (unbind-key "M-3" magit-mode-map)
  (unbind-key "M-4" magit-mode-map))

;; Highlight uncommitted changes using VC
(use-package diff-hl
  :ensure t
  :bind (:map diff-hl-command-map
         ("SPC" . diff-hl-mark-hunk))
  :hook ((after-init . global-diff-hl-mode)
         (after-init . global-diff-hl-show-hunk-mouse-mode)
         (dired-mode . diff-hl-dired-mode)
         (magit-pre-refresh . diff-hl-magit-pre-refresh)  ; Magit 刷新前更新 diff-hl
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :custom
  (diff-hl-draw-borders nil)
  ;; (diff-hl-update-async t)
  (diff-hl-global-modes '(not image-mode pdf-view-mode))
  :init
  (setq diff-hl-show-staged-changes nil)
  :config
  ;; Set fringe style
  (setq-default fringes-outside-margins t)

  ;; (setq diff-hl-fringe-bmp-function 'my-diff-hl-fringe-bmp-function)

  ;; Highlight on-the-fly
  (diff-hl-flydiff-mode 1)

  ;; Fall back to the display margin since the fringe is unavailable in tty
  (unless (display-graphic-p) (diff-hl-margin-mode 1)))

;; 在 diff-hl 模式开启时启用自动刷新
(add-hook 'diff-hl-mode-hook (lambda () (diff-hl-flydiff-mode 1)))


(provide 'init-git)
