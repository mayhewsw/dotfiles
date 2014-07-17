;################################################################################
; Stephen Mayhew - Emacs File                                                   |        
; Note: In order for this to work (specifically for the color-themes to work),  |
; emacs-goodies.el must be installed. This can be done from synaptic package    |
; manager.                                                                      |
;                                                                               |
; Useful emacs commands                                                         |
; Run bash: M-x ansi-term                                                       |
; Run a nice terminal: M-x eshell                                               | 
; Run a boring terminal: M-x term                                               |
; Find the function behind the command: C-h k                                   |
;################################################################################

(add-to-list 'load-path "~/color-theme-stuff/color-theme-6.6.0")

(setq inhibit-splash-screen t)
(setq default-directory "/home/stephen/" )
(add-to-list 'load-path "~/Documents/")
(goto-char (point-min))

;; Line numbers
(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "C-<f5>") 'linum-mode)
(global-linum-mode 1)

;; Set tabs to 4 spaces
(setq c-basic-offset 4)
(setq-default py-indent-offset 4)
(setq tab-width 4)

;; Supposedly this set tabs to spaces
(setq-default indent-tabs-mode nil)

(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "C-<f5>") 'linum-mode)
(global-linum-mode 1)

;; Define Ctrl-Shift-F as tab the whole file, which 
;; formats it.
(defun format-file ()
  (interactive)
  (mark-whole-buffer)
  (indent-for-tab-command))
(global-set-key (kbd "C-S-f") 'format-file)

(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)

;; Different modes
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . html-mode))
(add-to-list 'auto-mode-alist '("\\.lbj$" . java-mode))
(add-to-list 'auto-mode-alist '("\\.txt$" . conf-mode))

;; comment on C-/
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))
(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)

(define-key global-map (kbd "RET") 'newline-and-indent)

(setq debug-on-error t)

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
  )

;; Define notes functionality
(defun new ()
  (interactive)
  (let ((fname  (read-from-minibuffer "Filename: ")))
    (let ((fullpath (trim-string (shell-command-to-string (concat "new " fname)))))
      (if (string-match "whoops" fullpath)
          (message fullpath)
        (progn
          (find-file fullpath)
          (turn-on-auto-fill)
          (goto-char (point-max)))))))

(defun open ()
  (interactive)
  (find-file "~/Documents/notes")
  )


;;; -------------------- BEGIN 'LATEST' CODE ---------------------------------
(defun getFirst3 (lst)
  (list (car lst)
        (car (cdr lst))
        (car (cdr (cdr lst)))))

(defun getDateScore (s)
  (let ((lst (mapcar 'string-to-number (getFirst3 (split-string s (regexp-quote "."))))))
    (setcar lst (* 30 (car lst)))
    (setcar (nthcdr 2 lst) (* 350 (car (nthcdr 2 lst))))
    (apply '+ lst)))

;; if first is later than the second, return true, otherwise nil
(defun compare (e1 e2)
  (> (getDateScore e1) (getDateScore e2)))

;To load python templates 
(add-hook 'find-file-hooks 'maybe-load-template)
(defun maybe-load-template ()
  (interactive)
  (when (and 
         (string-match "\\.py$" (buffer-file-name))
         (eq 1 (point-max)))
    (insert-file "~/.emacs.d/templates/template.py")))

;; swap the first and second elements
(defun swapfirst (lst)
  (cons (cadr lst) (cons (car lst) (cddr lst)))
  )

;; recursive function
(defun getLatest (files)
  (if (cdr files)
      (if (compare (car files) (cadr files)) ; car later than cadr
          (getLatest (cdr (swapfirst files)))
        (getLatest (cdr files)))
    (car files))) ; return the only element left
    

;; Get the latest meeting notes from dan
(defun latest ()
  (interactive)
  (let ((files (directory-files "~/Documents/notes/" nil ".Meeting.*Dan.*[^~#]$")))
    (find-file (concat "~/Documents/notes/" (getLatest files)))
    ))
;;; -------------------- END 'LATEST' CODE ---------------------------------

;; Fancier find-name-dired
(defun my-f-n-d ()
  (interactive)
  (let ((pattern (read-from-minibuffer "File Pattern: ")))
    (find-name-dired
     (concat (car (split-string buffer-file-name "/src/")) "/src/")
     (concat pattern "*"))))

(global-set-key (kbd "C-x c") 'my-f-n-d)

;; indent pragmas in C/C++
(c-set-offset (quote cpp-macro) 0 nil)


;; Mark current word
(defun my-mark-current-word (&optional arg allow-extend)
  "Put point at beginning of current word, set mark at end."
  (interactive "p\np")
  (setq arg (if arg arg 1))
  (if (and allow-extend
           (or (and (eq last-command this-command) (mark t))
               (region-active-p)))
      (set-mark
       (save-excursion
         (when (< (mark) (point))
           (setq arg (- arg)))
         (goto-char (mark))
         (forward-word arg)
         (point)))
    (let ((wbounds (bounds-of-thing-at-point 'word)))
      (unless (consp wbounds)
        (error "No word at point"))
      (if (>= arg 0)
          (goto-char (car wbounds))
        (goto-char (cdr wbounds)))
      (push-mark (save-excursion
                   (forward-word arg)
                   (point)))
      (activate-mark))))

(global-set-key (kbd "C-c C-w") 'my-mark-current-word)
