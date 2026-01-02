;; Turn on subword-mode everywhere
(global-subword-mode t)

;; Backup the original 'forward-evil-word' function before overriding it.
(fset 'original-forward-evil-word (symbol-function 'forward-evil-word))

;; From the Evil FAQ.
;; Defaults all word movements, including editing operations, to 
;; 'whole symbols', which is what we want by default.
(defalias #'forward-evil-word #'forward-evil-symbol)

;; evil-textobj-between
(defgroup evil-textobj-between nil
  "Text object between for Evil"
  :prefix "evil-textobj-between-"
  :group 'evil)

(defcustom evil-textobj-between-i-key "f"
  "Keys for evil-inner-between"
  :type 'string
  :group 'evil-textobj-between)
(defcustom evil-textobj-between-a-key "f"
  "Keys for evil-a-between"
  :type 'string
  :group 'evil-textobj-between)

(defun evil-between-range (count beg end type &optional inclusive)
  (ignore-errors
    (let ((count (abs (or count 1)))
          (beg (and beg end (min beg end)))
          (end (and beg end (max beg end)))
          (ch (evil-read-key))
          beg-inc end-inc)
      (save-excursion
        (when beg (goto-char beg))
        (evil-find-char (- count) ch)
        (setq beg-inc (point)))
      (save-excursion
        (when end (goto-char end))
        (backward-char)
        (evil-find-char count ch)
        (setq end-inc (1+ (point))))
      (if inclusive
          (evil-range beg-inc end-inc)
        (if (and beg end (= (1+ beg-inc) beg) (= (1- end-inc) end))
            (evil-range beg-inc end-inc)
          (evil-range (1+ beg-inc) (1- end-inc)))))))

(evil-define-text-object evil-a-between (count &optional beg end type)
  "Select range between a character by which the command is followed."
  (evil-between-range count beg end type t))
(evil-define-text-object evil-inner-between (count &optional beg end type)
  "Select inner range between a character by which the command is followed."
  (evil-between-range count beg end type))

(define-key evil-outer-text-objects-map evil-textobj-between-a-key
  'evil-a-between)
(define-key evil-inner-text-objects-map evil-textobj-between-i-key
  'evil-inner-between)

;; evil-little-word
(defun maybe-define-category (cat doc &optional table)
  (unless (category-docstring cat table) (define-category cat doc table)))

(let (uc lc defs (table (standard-category-table)))
  (map-char-table
   #'(lambda (key value)
       (when (natnump value)
         (let (from to)
           (if (consp key)
               (setq from (car key) to (cdr key))
             (setq from (setq to key)))
           (while (<= from to)
             (cond ((/= from (downcase from))
                    (add-to-list 'uc from))
                   ((/= from (upcase from))
                    (add-to-list 'lc from)))
             (setq from (1+ from))))))
   (standard-case-table))
  (setq defs `(("Uppercase" ?U ,uc)
               ("Lowercase" ?u ,lc)
               ("Underscore" ?_ (?_))))
  (dolist (elt defs)
    (maybe-define-category (cadr elt) (car elt) table)
    (dolist (ch (car (cddr elt)))
      (modify-category-entry ch (cadr elt) table))))

(defgroup evil-little-word nil
  "CamelCase and snake_case word movement support."
  :prefix "evil-little-word-"
  :group 'evil)

(defcustom evil-little-word-separating-categories
  (append evil-cjk-word-separating-categories '((?u . ?U) (?_ . ?u) (?_ . ?U)))
  "List of pair (cons) of categories to determine word boundary
for little word movement. See the documentation of
`word-separating-categories'. Use `describe-categories' to see
the list of categories."
  :type '((character . character))
  :group 'evil-little-word)

(defcustom evil-little-word-combining-categories
  (append evil-cjk-word-combining-categories '())
  "List of pair (cons) of categories to determine word boundary
for little word movement. See the documentation of
`word-combining-categories'. Use `describe-categories' to see the
list of categories."
  :type '((character . character))
  :group 'evil-little-word)

(defmacro evil-with-little-word (&rest body)
  (declare (indent defun) (debug t))
  `(let ((evil-cjk-word-separating-categories
          evil-little-word-separating-categories)
         (evil-cjk-word-combining-categories
          evil-little-word-combining-categories))
     ,@body))

(defun forward-evil-little-word (&optional count)
  "Forward by little words."
  (evil-with-little-word (original-forward-evil-word count)))

(evil-define-motion evil-forward-little-word-begin (count)
  "Move the cursor to the beginning of the COUNT-th next little word."
  :type exclusive
  (evil-with-little-word (evil-forward-word-begin count)))

(evil-define-motion evil-forward-little-word-end (count)
  "Move the cursor to the end of the COUNT-th next little word."
  :type inclusive
  (evil-with-little-word (evil-forward-word-end count)))

(evil-define-motion evil-backward-little-word-begin (count)
  "Move the cursor to the beginning of the COUNT-th previous little word."
  :type exclusive
  (evil-with-little-word (evil-backward-word-begin count)))

(evil-define-motion evil-backward-little-word-end (count)
  "Move the cursor to the end of the COUNT-th previous little word."
  :type inclusive
  (evil-with-little-word (evil-backward-word-end count)))

(evil-define-text-object evil-a-little-word (count &optional beg end type)
  "Select a little word."
  (evil-select-an-object 'evil-little-word beg end type count))

(evil-define-text-object evil-inner-little-word (count &optional beg end type)
  "Select inner little word."
  (evil-select-inner-object 'evil-little-word beg end type count))

(define-key evil-motion-state-map (kbd "glw") 'evil-forward-little-word-begin)
(define-key evil-motion-state-map (kbd "glb") 'evil-backward-little-word-begin)
(define-key evil-motion-state-map (kbd "glW") 'evil-forward-little-word-end)
(define-key evil-motion-state-map (kbd "glB") 'evil-backward-little-word-end)
(define-key evil-outer-text-objects-map (kbd "lw") 'evil-a-little-word)
(define-key evil-inner-text-objects-map (kbd "lw") 'evil-inner-little-word)

(provide 'init-evil-plugins)
