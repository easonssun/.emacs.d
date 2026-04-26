;; init.el    -*- lexical-binding: t -*-

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(require 'package)
(setq package-archives
      '(("gnu"    . "https://mirrors.ustc.edu.cn/elpa/gnu/")
        ("melpa"  . "https://mirrors.ustc.edu.cn/elpa/melpa/")
	("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")
        ("org"    . "https://mirrors.ustc.edu.cn/elpa/org/")))
;;(setq package-archive
;;  '(("gnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
;;    ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
;;  ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

(require 'use-package)

(dolist (package
         '(evil
           evil-collection
           evil-surround
           evil-visualstar
           evil-commentary
           posframe
           multiple-cursors
           treesit-auto
           ace-window
           exec-path-from-shell
           nerd-icons
           nerd-icons-completion
           nerd-icons-corfu
           nerd-icons-dired
           rainbow-delimiters
           doom-themes
           doom-modeline
           centaur-tabs
           popper
           consult
           embark
           embark-consult
           marginalia
           consult-eglot
           eldoc-mouse
           dashboard
           magit
           diff-hl
           dired-quick-sort
           dired-git-info
           dired-rsync
           diredfl
           dired-subtree
           eshell-git-prompt
           eshell-syntax-highlighting
           capf-autosuggest
           orderless
           vertico
           corfu
           corfu-terminal
           cape
           eat))
  (eval `(use-package ,package :ensure t :defer t)))

(when (executable-find "fd")
  (use-package fd-dired :ensure t :defer t)
  (require 'fd-dired))

(require 'init-base)
(require 'init-evil)
(require 'init-ui)
(require 'init-window)
(require 'init-completion)
(require 'init-dired)
(require 'init-git)
(require 'init-term)
(require 'init-project)
(require 'init-mc)

(require 'init-keymaps)
(require 'init-lsp)

;;(require 'init-ai)
;;(require 'init-evil-plugins)
;;
;;(require 'lang-go)
