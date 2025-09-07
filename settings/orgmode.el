
(use-package org
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-startup-folded t)
  (org-todo-keywords
   '((sequence
      "TODO(t)"
      "STARTED(s)"
      "WAITING(w!)" ;; Use @/! to log note and timestamp
      "|"
      "DONE(d!)"
      "CANCELLED(c)")))
  (org-log-done 'time)
  ;; Fontify code in code blocks.
  (org-src-fontify-natively t)

  ;; Display images inline when running in GUI.
  (org-startup-with-inline-images (display-graphic-p))
  (org-src-tab-acts-natively t)

  ;; Prevent inadvertently editing invisible areas in Org.
  (org-catch-invisible-edits 'error)
  (org-cycle-separator-lines 2)
  (org-image-actual-width nil)
  (org-hide-emphasis-markers t)

  ;; All Org leading stars become invisible.
  (org-hide-leading-stars t)
  ;; Hide emphasis markers such as ** /../ etc.
  (org-hide-emphasis-markers t)

    ;; Enable RET to follow Org links.
  (org-return-follows-link t)
  :hook ((org-mode . visual-line-mode))
  :config
  (defun adviced:org-yank (orig-fun &rest r)
    "Advice `adviced:org-yank' to align tables (ORIG-FUN and R)."
    (apply orig-fun r)
    (when (and (org-at-table-p)
               org-table-may-need-update)
      (org-table-align)))

    (advice-add #'org-yank
              :around
              #'adviced:org-yank))

(use-package org-faces
  :custom
  (org-todo-keyword-faces
   '(("TODO" . (:foreground "red" :weight bold))
     ("STARTED" . (:foreground "green" :weight bold))
     ("WAITING" . (:foreground "yellow" :weight bold))
     ("DONE" . (:foreground "gray" :weight bold))
     ("CANCELLED" . (:foreground "gray" :weight bold)))))

;; ;;;; Org-mode
;; (require 'org)
;; (require 'org-faces)

;; ;; Intercept calls from emacsclient
;; (add-to-list 'org-modules 'org-protocol)
;; (require 'org-protocol)
;; ;maybe needs to be configured

;; ;; Team management
;; ;(add-to-list 'org-modules 'org-secretary)
;; ;(require 'org-secretary)

;; ;; Set to the location of your Org files on your local system
;; (setq org-directory "~/org")
;; (setq org-agenda-files '("~/org/tasks.org" "~/org/inbox.org" "~/org/tickler.org"))
;; ; Use in agenda only those tasks that have been organized (excludes refile and others)
;; (setq org-agenda-include-diary nil)
;; ;; provide #include "/path/to/file" function in diary files
;; ;; (add-hook 'list-diary-entries-hook 'include-other-diary-files)
;; ;; (add-hook 'mark-diary-entries-hook 'mark-included-diary-files)
;; ;; (setq diary-list-include-blanks t)
;; ;; (add-hook 'list-diary-entries-hook 'sort-diary-entries t)

;; (global-set-key [f5] 
;;                 (lambda nil
;;                   (interactive)
;;                   (find-file (format "%s/%s" org-directory "tasks.org"))))


;; ;(setq org-startup-indented nil) 
;; (setq-default org-startup-truncated nil) ;non compatibile per ora con org-startup-indented
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (add-to-list 'auto-mode-alist '("\\.org.txt$" . org-mode))
;; (add-to-list 'auto-mode-alist '("\\.org.gpg$" . org-mode))

;; ;; Some options
;; (setq org-log-done nil)
;; (setq org-return-follows-link t)
;; (setq org-hide-leading-stars t)

;; ;; Code blocks
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((python . t)))

;; ;; Capturing
;; (setq org-default-notes-file (concat org-directory (format "%s/%s" org-directory "inbox.org")))
;; (setq org-capture-templates
;;      '(("t" "Inbox" entry (file "~/org/inbox.org");
;;         "* %?\n  %i\n  Source: %u")
;; 	   ("l" "Link" entry (file "~/org/inbox.org")
;;         "* %a\n %?\n %i\n Source: %u")
;;        ("p" "Inbox (with location at point)" entry (file "~/org/inbox.org");
;;         "* %?\n  %i\n  Source: %u, %a")))
;; (global-set-key [f7] (lambda () (interactive) (org-capture nil "t")))
;; (define-key global-map "\C-cc" 'org-capture)


;; ;; Refiling
;; (global-set-key [f8] 'org-refile)
;; (setq org-refile-targets '((org-agenda-files :maxlevel . 2) (org-agenda-files :todo . "PROJECT") (org-agenda-files :todo . "SUBPROJECT")))

;; ;; Org agenda
;; (global-set-key [f9] 'org-agenda)
;; (define-key global-map "\C-ca" 'org-agenda)

;; (setq
;;  org-agenda-ndays 14
;;  org-deadline-warning-days 14
;;  org-agenda-show-all-dates t
;;  org-agenda-skip-deadline-if-done t
;;  org-agenda-skip-scheduled-if-done t
;;  org-agenda-skip-timestamp-if-done t
;;  org-reverse-note-order t
;;  org-agenda-start-on-weekday 1
;;  org-enforce-todo-dependencies t)

;; ; To limit to category  ("gh" "Casa" tags-todo "casa-CATEGORY=\"Humanitas\"")
;; (setq org-agenda-custom-commands
;; '(("f" "Flagged" tags-todo "+PRIORITY=\"A\"")
;;   ("g" . "GTD contexts")
;;   ("g." "Progetti" todo "PROJECT")
;;   ("gh" "Casa" tags-todo "@casa")
;;   ("gs" "Spese" tags-todo "@spese")
;;   ("go" "Ovunque" tags-todo "@ovunque")
;;   ("gm" "Milano" tags-todo "@milano")
;;   ("gc" "CH" tags-todo "@CH")
;;   ("gl" "Lavoro" tags-todo "@work")))

;; ;; ;; People to delegate are defined in each Major Tree with
;; ;;   ;; :PROPERTIES:
;; ;;   ;; :Delegated_ALL: Mamma Papa Michela
;; ;;   ;; :END:
;; ;; (defun dm/org-agenda-delegate nil
;; ;;   ""
;; ;;   (interactive)
;; ;;   (org-set-property "Delegated" nil))

;; ;; (define-key global-map "\C-cw" 'dm/delegate)

;; ;; (defun dm/org-agenda-view-delegated (par)
;; ;;   "Builds agenda for a given user.  Queried. "
;; ;;   (let ((who (read-string "Build Agenda for person: " "" "" "")))
;; ;;   (insert t (concat "\\\"+Delegated=\\\"" who "\\\"\\\""))))

;; ; Stuck projects have PROJECT as todo state, don't have DONE as a todo state
;; ; and have no child with todo states NEXT, TODO or BOARDING
;; ; (this leaves out LASTCALL and DELAYED active states)
;; ; Stuck project will be ignore if it contains anywhere <IGNORE>
;; (setq org-stuck-projects
;;       '("+TODO=\"PROJECT\"+TODO=\"SUBPROJECT\"/-TODO=\"DONE\"-TODO=\"DELAYED\"" ("TODO" "BOARDING") ()
;;         "\\<IGNORE\\>"))

;; (setq
;;  org-todo-keywords
;;  '((sequence "TODO(t)" "BOARDING(s)" "LASTCALL(w@)" "|" "DELAYED(p)" "DONE(d)" "CANCELLED(c)")
;;    (sequence "PROJECT(.)" "DELAYED(,)" "|" "DONE(d)" "CANCELLED(c)")))

;; ;; Colors according to monokai theme
;; (setq org-todo-keyword-faces '(("TODO" :foreground "#66D9EF" :weight bold)
;; 			       ("BOARDING" :foreground "#A6E22E" :weight bold)
;; 			       ("DELAYED" :foreground "#FD971F" :weight bold)
;; 			       ("LASTCALL" :foreground "#AE81FF" :weight bold)
;; 			       ("DONE" :foreground "#75715E" :weight bold)
;; 			       ("PROJECT" :foreground "#F92672" :weight bold)
;; 			       ("CANCELLED" :foreground "#75715E" :weight bold)))
;; ;; (setq org-todo-keyword-faces '(("TODO" :foreground "blue" :weight bold)
;; ;; 			       ("BOARDING" :foreground "forest green" :weight bold)
;; ;; 			       ("DELAYED" :foreground "orange" :weight bold)
;; ;; 			       ("LASTCALL" :foreground "dark violet" :weight bold)
;; ;; 			       ("DONE" :foreground "gray" :weight bold)
;; ;; 			       ("PROJECT" :foreground "red" :weight bold)
;; ;; 			       ("CANCELLED" :foreground "gray" :weight bold)))

;;  (setq org-tag-alist '(("@casa" . ?h)
;; 		       ("@ovunque" . ?o)
;; 		       ("@milano" . ?m)
;; 		       ("@CH" . ?c)
;; 		       ("@lavoro" . ?l)
;;                        ("@spese" . ?s)))

;; ;(setq org-tags-exclude-from-inheritance '("ToREVIEW"))

;; ;; habits

;; ;; logging

;; ;; org-mode Archiving
;; (setq org-archive-location (format "%s/%s" org-directory "archive.org::"))
;; (setq org-archive-stamp-time t)
;; (setq org-archive-mark-done t)
;; (global-set-key [f12] 'org-archive-subtree)

;; ;; Attachments
;; ; Set attachments directory
;; (setq org-attach-directory "Attachments/")
;; ; Copy file to attachments directory by default when pressin C-c C-a a
;; (setq org-attach-method 'mv)


;; ;; Agenda holidays
;; (setq calendar-week-start-day 1)
;; (setq calendar-day-name-array ["Domenica" "Lunedi" "Martedi" 
;; 			       "Mercoledi" "Giovedi" "Venerdi" "Sabato"] )
;; (setq calendar-month-name-array ["Gennaio" "Febbraio" "Marzo" "Aprile" "Maggio" 
;; 				 "Giugno" "Luglio" "Agosto" "Settembre" "Ottobre" 
;; 				 "Novembre" "Dicembre"] )

;; (setq holiday-general-holidays nil)
;; (setq holiday-local-holidays nil)
;; (setq holiday-christian-holidays nil)
;; (setq holiday-bahai-holidays nil)
;; (setq holiday-hebrew-holidays nil)
;; (setq holiday-oriental-holidays nil)
;; (setq holiday-solar-holidays nil)
;; (setq holiday-islamic-holidays nil)
;; ;; Festività in Ticino
;; (setq holiday-other-holidays
;;       '((holiday-fixed 1 1 "Capodanno")
;; 		(holiday-fixed 1 6 "Epifania")
;; 		(holiday-fixed 3 19 "San Giuseppe")
;; 		(holiday-easter-etc 0 "Domenica di Pasqua")
;; 		(holiday-easter-etc -47 "Carnevale")
;; 		(holiday-easter-etc 1 "Lunedì di Pasqua")
;; 		(holiday-easter-etc 39 "Ascensione")
;; 		(holiday-easter-etc 50 "Lunedì di Pentecoste")
;; 		(holiday-easter-etc 60 "Corpus Domini")
;; 		(holiday-fixed 5 1 "Festa del lavoro")
;; 		(holiday-fixed 6 29 "Santi Pietro e Paolo")
;; 		(holiday-fixed 8 1 "Festa Nazionale Svizzera")
;; 		(holiday-fixed 8 15 "Ferragosto")
;; 		(holiday-fixed 11 1 "Tutti i Santi")
;; 		(holiday-fixed 12 8 "Immacolata concezione")
;; 		(holiday-fixed 12 25 "Natale")
;; 		(holiday-fixed 12 26 "S. Stefano")))
;; ;; Festività in Italia
;; ;; (setq other-holidays
;; ;;       '((holiday-easter-etc 0 "Domenica di Pasqua")
;; ;; 	(holiday-easter-etc -47 "Carnevale")
;; ;; 	(holiday-easter-etc 1 "Lunedì dell'Angelo")
;; ;; 	(holiday-fixed 01 06 "Epifania")
;; ;; 	(holiday-fixed 12 25 "Natale")
;; ;; 	(holiday-fixed 08 15 "Ferragosto")
;; ;; 	(holiday-fixed 11 01 "Tutti i Santi")
;; ;; 	(holiday-fixed 12 08 "Immacolata concezione")
;; ;; 	(holiday-fixed 12 09 "S.Siro - Patrono di Pavia")
;; ;; 	(holiday-fixed 12 26 "S. Stefano")
;; ;; 	(holiday-fixed 04 25 "Liberazione")
;; ;; 	(holiday-fixed 05 01 "Festa del lavoro")
;; ;; 	(holiday-fixed 06 02 "Festa della repubblica")
;; ;; 	(holiday-fixed 01 01 "Capodanno")))

;; ;; World clock
;; ;; call M-x display-time-world
;; (setq display-time-world-list '(("PST8PDT" "San Francisco, CA")
;;                                 ("EST5EDT" "New York, NY")
;;                                 ("GMT0BST" "London")
;;                                 ("CET-1CDT" "Rome")
;;                                 ("JST-9" "Tokyo")))


;; ;; Location for Sunset/Sunrise
;; ;; Call from M-x calendar then press S
;; (setq calendar-latitude 46.0)
;; (setq calendar-longitude 8.94)
;; (setq calendar-location-name "Lugano, CH")


;; ;; Omnifocus agenda colors
;; ;;; These are the default colours from OmniFocus
;; (defface je/due
;;   (org-compatible-face 'default
;;     '((t (:foreground "#000000"))))
;;   "Face for due items"
;;   :group 'org-faces)
;; (set-face-foreground 'je/due "#dc322f")

;; (defface je/today
;;   (org-compatible-face 'default
;;     '((t (:foreground "#000000"))))
;;   "Face for today items"
;;   :group 'org-faces)
;; (set-face-foreground 'je/today "#cb4b16")

;; (defface je/soon
;;   (org-compatible-face 'default
;;     '((t (:foreground "#000000"))))
;;   "Face for soon items"
;;   :group 'org-faces)
;; (set-face-foreground 'je/soon "#859900")

;; (defface je/near
;;   (org-compatible-face 'default
;;     '((t (:foreground "#000000"))))
;;   "Face for near items"
;;   :group 'org-faces)
;; (set-face-foreground 'je/near "#6c71c4")

;; (defface je/normal
;;   (org-compatible-face 'default
;;     '((t (:foreground "#000000"))))
;;   "Face for normal items"
;;   :group 'org-faces)
;; (set-face-foreground 'je/normal "#657b83")

;; (defface je/distant
;;   (org-compatible-face 'default
;;     '((t (:foreground "#000000"))))
;;   "Face for distant items"
;;   :group 'org-faces)
;; (set-face-foreground 'je/distant "#93a1a1")

;; (defvar je-schedule-flag? t)
;; (setq je-schedule-flag? t)
;; (defun je/todo-color (a)
;;   "Color things in the column view differently based on deadline"
;;   (let* ((ma (or (get-text-property 1 'org-marker a)
;;                  (get-text-property 1 'org-hd-marker a)))
;;          (tn (org-float-time (org-current-time)))

;;          (sa (org-entry-get ma "SCHEDULED"))
;;          (da (org-entry-get ma "DEADLINE"))

;;          (ta (if da (org-time-string-to-seconds da) 1.0e+INF))
;;          (a-day (if da (time-to-days (seconds-to-time ta)) 0))
;;          (sta (if sa (org-time-string-to-seconds sa) 0)))

;;     ;; Remove the TODO
;;     ;; use  (setq org-agenda-todo-keyword-format "") instead?
;;     ;; (put-text-property
;;     ;;  0 (length a)
;;     ;;  'txt
;;     ;;  (replace-regexp-in-string "^TODO *" "" (get-text-property 0 'txt a))
;;     ;;  a)

;;     ;; Remove the old face
;;     (remove-text-properties
;;      0 (length a) '((face nil) (fontified nil)) a)

;;     ;; Put on the new face
;;     (put-text-property
;;      0 (length a)
;;      'face
;;      (cond
;;       ((< ta tn)
;;        ;; The deadline has passed
;;        'je/due)
;;       ((= a-day (org-today))
;;        ;; The deadline is today
;;        'je/today)
;;       ((< ta (+ tn (* 60 60 24)))
;;        ;; The deadline is in the next day
;;        'je/soon)
;;       ((< ta (+ tn (* 60 60 24 7)))
;;        ;; The deadline is in the next week
;;        'je/near)
;;       ((< ta (+ tn (* 60 60 24 7 4 )))
;;        ;; The deadline is in the next four weeks
;;        'je/normal)
;;       (t
;;        'je/distant))
;;      a)

;;     (if (or (and je-schedule-flag? (< tn sta))
;;             (and je/org-agenda/filter-ctxt
;;                  (member/eq je/org-agenda/filter-ctxt
;;                             (org-entry-get ma "TAGS"))))
;;         nil
;;       a)))

;; (defun member/eq (o l)
;;   (or (equal o l)
;;       (member o l)))
;; (defvar je/org-agenda/filter-ctxt nil)
;; (setq org-agenda-before-sorting-filter-function 'je/todo-color)


;; ;;;; Diary skeletons
;; ;; define a diary schedule for school (this function excludes holidays from schedule!...)
;; ;; to add a schedule to your diary for history on monday (2) at 18.00: 
;; ;; &%%(diary-schedule 22 4 2003 1 8 2003 2) 18:00 History
;; (defun diary-schedule (m1 d1 y1 m2 d2 y2 dayname)
;;   "Entry applies if date is between dates on DAYNAME.  
;;     Order of the parameters is M1, D1, Y1, M2, D2, Y2 if
;;     `european-calendar-style' is nil, and D1, M1, Y1, D2, M2, Y2 if
;;     `european-calendar-style' is t. Entry does not apply on a history."
;;   (let ((date1 (calendar-absolute-from-gregorian
;; 		(if european-calendar-style
;; 		    (list d1 m1 y1)
;; 		  (list m1 d1 y1))))
;; 	(date2 (calendar-absolute-from-gregorian
;; 		(if european-calendar-style
;; 		    (list d2 m2 y2)
;; 		  (list m2 d2 y2))))
;; 	(d (calendar-absolute-from-gregorian date)))
;;     (if (and 
;; 	 (<= date1 d) 
;; 	 (<= d date2)
;; 	 (= (calendar-day-of-week date) dayname)
;; 	 (not (check-calendar-holidays date))
;; 	 )
;; 	entry)))

;; ;; define a countdown
;; ;; to add a countdown for the next 15 days:
;; ;; &%%(diary-countdown 21 05 2009 15) 18:00 Meeting
;; (defun diary-countdown (m1 d1 y1 n)
;;    "Reminder during the previous n days to the date.
;;     Order of parameters is M1, D1, Y1, N if
;;     `european-calendar-style' is nil, and D1, M1, Y1, N otherwise."
;;    (diary-remind '(diary-date m1 d1 y1) (let (value) (dotimes (number n value) (setq value (cons number value))))))


;; ;;;; Nice helper functions for text
;; (defun sort-words (reverse beg end)
;;   "Sort words in region alphabetically, in REVERSE if negative.
;;     Prefixed with negative \\[universal-argument], sorts in reverse.

;;     The variable `sort-fold-case' determines whether alphabetic case
;;     affects the sort order.

;;     See `sort-regexp-fields'."
;;   (interactive "*P\nr")
;;   (sort-regexp-fields reverse "[A-Za-z0-9\\.]+" "\\&" beg end))

