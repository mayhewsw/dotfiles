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
					; (color-theme-dark-laptop)
					; also try taylor
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

