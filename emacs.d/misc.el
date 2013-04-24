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



;; (setq initial-scratch-message

;; "oooooo   oooooo     oooo           oooo                                                  
;;  `888.    `888.     .8'            `888                                                  
;;   `888.   .8888.   .8'    .ooooo.   888   .ooooo.   .ooooo.  ooo. .oo.  .oo.    .ooooo.
;;    `888  .8'`888. .8'    d88' `88b  888  d88' `'Y8 d88' `88b `888P'Y88bP'Y88b  d88' `88b  
;;     `888.8'  `888.8'     888ooo888  888  888       888   888  888   888   888  888ooo888 
;;      `888'    `888'      888    .o  888  888   .o8 888   888  888   888   888  888    .o 
;;       `8'      `8'       `Y8bod8P' o888o `Y8bod8P' `Y8bod8P' o888o o888o o888o `Y8bod8P' 
      
      
;;                      oooooooooooo                                                
;;   .o8                `888'     `8                                                
;; .o888oo  .ooooo.      888         ooo. .oo.  .oo.    .oooo.    .ooooo.   .oooo.o 
;;   888   d88' `88b     888oooo8    `888P'Y88bP'Y88b  `P  )88b  d88' `'Y8 d88(  '8 
;;   888   888   888     888    '     888   888   888   .oP'888  888       `'Y88b.  
;;   888 . 888   888     888       o  888   888   888  d8(  888  888   .o8 o.  )88b 
;;   '888' `Y8bod8P'    o888ooooood8 o888o o888o o888o `Y888''8o `Y8bod8P' 8''888P'


;; You probably want to search for a file. C-x C-f

;; ")

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

;; Define Ctrl-Shift-F as tab the whole file, which 
;; formats it.
(defun format-file ()
  (interactive)
  (mark-whole-buffer)
  (indent-for-tab-command))
(global-set-key (kbd "C-S-f") 'format-file)

;;Setting up tabbar
(require 'tabbar)
(tabbar-mode)

;; Taken from http://stackoverflow.com/questions/2855378/ropemacs-usage-tutorial
;;(add-to-list 'load-path "~/.emacs.d/auto-complete-1.2")
;;(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

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

