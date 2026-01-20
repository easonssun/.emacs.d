;; init-dired.el 	-*- lexical-binding: t -*-
;;(setq dired-omit-files-p t) ; 自动隐藏某些文件
;;(setq dired-omit-regexp "\\(^\\.[^.]\\|\\(~$\\|\\ .orig$\\|.rej$\\)")

;; Always delete and copy recursively
(setq dired-recursive-deletes 'always
      dired-recursive-copies 'always)

(require 'dired-quick-sort)
;; Quick sort dired buffers via hydra
(define-key dired-mode-map "S" 'hydra-dired-quick-sort/body)

(require 'dired-git-info)
;; Show git info in dired
(define-key dired-mode-map "I" 'dired-git-info-mode)

(require 'dired-rsync)
;; Allow rsync from dired buffers
(define-key dired-mode-map (kbd "C-c C-r") 'dired-rsync)

;; (require 'diredfl)
;; Colorful dired

(require 'dired-subtree)
;; 折叠子目录（类似 ranger）
(with-eval-after-load 'dired-subtree
  (define-key dired-mode-map (kbd "TAB") 'dired-subtree-toggle)
  )

(provide 'init-dired)
