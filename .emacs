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


(setq default-directory "/home/stephen/" )
;test

(setq inhibit-startup-message 't)

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

;;(setq initial-buffer-choice 't)

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
(if (window-system)
    (progn
      (require 'color-theme)
      (setq color-theme-is-global t)
      (stephen-color-theme)))
					; (color-theme-dark-laptop)
					; also try taylor

(add-to-list 'load-path "~/Documents/")

(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "C-<f5>") 'linum-mode)
(global-linum-mode 1)


;(split-window-vertically)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(show-paren-mode t)
 '(tab-width 4))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 105 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
 
; this is to make emacs start up bigger.
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
	;; use 120 char wide window for largeish displays
	;; and smaller 80 column windows for smaller displays
	;; pick whatever numbers make sense for you
	(if (> (x-display-pixel-width) 1280)
	    (add-to-list 'default-frame-alist (cons 'width 120))
	  (add-to-list 'default-frame-alist (cons 'width 80)))
	;; for the height, subtract a couple hundred pixels
	;; from the screen height (for panels, menubars and
	;; whatnot), then divide by the height of a char to
	;; get the height we want
	(add-to-list 'default-frame-alist 
		     (cons 'height (/ (- (x-display-pixel-height) 200)
				      (frame-char-height)))))))

(set-frame-size-according-to-resolution)



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

;(desktop-save-mode 1)

;; Taken from http://stackoverflow.com/questions/2855378/ropemacs-usage-tutorial
(add-to-list 'load-path "~/.emacs.d/")
;;(add-to-list 'load-path "~/.emacs.d/auto-complete-1.2")
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(require 'python-mode)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;;(require 'auto-complete)
;;(global-auto-complete-mode t)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

(global-set-key (kbd "C-/") 'comment-or-uncomment-region-or-line)




