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


(setq inhibit-startup-message 't)

(add-to-list 'load-path "~/color-theme-stuff/color-theme-6.6.0")
;(add-to-list 'load-path "~/color-theme-stuff/emacs-color-theme-solarized-master")


;(require 'color-theme-solarized)
;(color-theme-solarized-dark)

(goto-char (point-min))

; Made with:
; http://alexpogosyan.com/color-theme-creator/
(defun stephen-color-theme ()
  (interactive)
  (color-theme-install
   '(stephen-color-theme
     ((background-color . "#1c1c1c")
      (background-mode . light)
      (border-color . "#1a1a1a")
      (cursor-color . "#fce94f")
      (foreground-color . "#eeeeec")
      (mouse-color . "black"))
     (fringe ((t (:background "#1a1a1a"))))
     (mode-line ((t (:foreground "#eeeeec" :background "#555753"))))
     (region ((t (:background "#003e80"))))
     (font-lock-builtin-face ((t (:foreground "#729fcf"))))
     (font-lock-comment-face ((t (:foreground "#fe460b"))))
     (font-lock-function-name-face ((t (:foreground "#edd400"))))
     (font-lock-keyword-face ((t (:foreground "#729fcf"))))
      (font-lock-string-face ((t (:foreground "#ad7fa8"))))
      (font-lock-type-face ((t (:foreground"#8ae234"))))
      (font-lock-variable-name-face ((t (:foreground "#eeeeec"))))
      (minibuffer-prompt ((t (:foreground "#729fcf" :bold t))))
      (font-lock-warning-face ((t (:foreground "Red" :bold t))))
      )))

(provide 'stephen-color-theme)

(require 'color-theme)
(setq color-theme-is-global t)
(stephen-color-theme)

;; (if (window-system)
;;     (progn
;;       (require 'color-theme)
;;       (setq color-theme-is-global t)
;;       (stephen-color-theme)))

(line-number-mode 1)

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


(defun copy-line-to-other-buffer ()
  (interactive)
  (kill-whole-line)
  (yank)
  (other-window 1)
  (end-of-buffer)
  (yank))

(global-set-key (kbd "C-x X") 'copy-line-to-other-buffer)


;; Taken from http://stackoverflow.com/questions/2855378/ropemacs-usage-tutorial
;(add-to-list 'load-path "~/.emacs.d/")
;;(add-to-list 'load-path "~/.emacs.d/auto-complete-1.2")
;(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;(require 'python-mode)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))


(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)

(add-hook 'python-mode-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))

(add-hook 'c-mode-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))

(add-hook 'java-mode-hook '(lambda ()
      (local-set-key (kbd "RET") 'newline-and-indent)))


; taken from: http://introrse.com/jasonc/docs/my-emacs.html
(define-key global-map [select] 'end-of-line)

;(global-set-key (kbd "C-S-<backspace>") 'kill-whole-line) 
(global-set-key [f7] 'kill-whole-line) 

; truncate lines
(setq-default truncate-lines t)

;To load python templates 
(add-hook 'find-file-hooks 'maybe-load-template)
(defun maybe-load-template ()
  (interactive)
  (when (and 
         (string-match "\\.py$" (buffer-file-name))
         (eq 1 (point-max)))
    (insert-file "~/.emacs.d/templates/template.py")))


(add-to-list 'load-path "~/.emacs.d/")
(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
 'auto-mode-alist
 '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")

(add-to-list
 'auto-mode-alist
 '("\\.lbj$" . java-mode))

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
