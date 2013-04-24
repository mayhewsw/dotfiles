;; Cogcomp emacs stuff

;; From cogcomp wiki
(setq bibtex-autokey-name-case-convert-function 'identity
      bibtex-autokey-name-separator "!"
      bibtex-autokey-names nil
      bibtex-autokey-year-length 2
      bibtex-autokey-titlewords 0
      bibtex-autokey-titlewords-stretch 0
      bibtex-autokey-titleword-length 0
      bibtex-autokey-name-year-separator "!"
      bibtex-autokey-edit-before-use nil
      bibtex-autokey-before-presentation-function
      'mingwei/generate-ccg-style-key)

(defun mingwei/generate-ccg-style-key (key)
  "A hack function to generate ccg style key"
  (mingwei/generate-ccg-key-from-list (split-string key "!")))

(defun mingwei/ccg-transform-short-bib-list (list)
  (cons (first list)
	(mapcar (lambda (x)
		  (subseq x 0 2))
		(rest list))))

(defun mingwei/ccg-transform-long-bib-list (list)
  (append (mapcar (lambda (x)
		  (subseq x 0 1))
		(butlast list))
	(last list)))

(defun mingwei/concatenate-list (list)
 (if (= (length list) 1)
     (first list)
     (concatenate 'string
          (first list)
          (mingwei/concatenate-list (rest list)))))

(defun mingwei/generate-ccg-key-from-list (list)
  (if (<= (length list) 4)
      (mingwei/concatenate-list (mingwei/ccg-transform-short-bib-list list))
      (mingwei/concatenate-list (mingwei/ccg-transform-long-bib-list list))))
