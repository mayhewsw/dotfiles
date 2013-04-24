;; Org setup file

;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; (setq org-default-notes-file "~/org/notes.org") ; this doesn't seem to work
(global-set-key "\C-cr" 'org-remember)

(setq org-agenda-files (list "~/org/todo.org"))

;; Open file at startup
(find-file "~/org/todo.org")

;; (setq org-log-done 'time)
;; (setq org-clock-persist 'history)
;; (org-clock-persistence-insinuate)

(setq org-startup-folded 'f)
(setq org-startup-indented)
(setq org-clock-idle-time 15)