;; init.el 	-*- lexical-binding: t -*-

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

(setq straight-vc-git-default-clone-depth 1)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;(require 'package)
;;(add-to-list 'package-archives
;;'(("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
;;("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
;;("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
;;(add-to-list 'package-archives
;;	     '("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa")
;;	     '("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu")
;;	     '("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu"))
;;(package-initialize)

;;(when (not package-archive-contents)
;;(package-refresh-contents))

(defun straight-package-installed-p (package)
  "检查 PACKAGE 是否已被 straight.el 安装和管理。"
  (and (boundp 'straight--recipe-cache) ; 确保变量存在
       (gethash (intern (symbol-name package)) straight--recipe-cache)))

(defun ensure-package-installed (packages)
  "确保指定的包都已安装。"
  (dolist (package packages)
    (message "Installing %s..." package)
    (straight-use-package package nil nil)))

(setq my/packages '(evil
                    evil-collection
                    evil-surround
                    evil-visualstar
                    evil-commentary

                    posframe
                    
                    treesit-auto
                    ace-window
                    exec-path-from-shell
                    general
                    
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
                    projectile
                    consult-projectile
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
                    ))

;; 使用示例
(ensure-package-installed my/packages)

(when (executable-find "fd")
  (straight-use-package 'fd-dired) 
  (require 'fd-dired))

(straight-use-package
 '(eat :type git
       :host codeberg
       :repo "akib/emacs-eat"
       :files ("*.el" ("term" "term/*.el") "*.texi"
               "*.ti" ("terminfo/e" "terminfo/e/*")
               ("terminfo/65" "terminfo/65/*")
               ("integration" "integration/*")
               (:exclude ".dir-locals.el" "*-tests.el"))))


(require 'init-base)
(require 'init-evil)
(require 'init-ui)
(require 'init-window)
(require 'init-completion)
(require 'init-dired)
(require 'init-git)
(require 'init-term)
(require 'init-project)

(require 'init-keymaps)
(require 'init-lsp)

;;(require 'init-mc)
;;(require 'init-ai)
;;(require 'init-evil-plugins)
;;
;;(require 'lang-go)
