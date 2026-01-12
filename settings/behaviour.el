;; Bell
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; Cursor
(setq blink-cursor-mode nil)

;;;; Indentation
(setq-default indent-tabs-mode nil) ;; use spaces
(setq tab-width 4) ; or any other preferred value

(setq backward-delete-char-untabify nil)

;; Don't get weird properties when pasting
(setq yank-excluded-properties t)


;; Use y/n instead of yes/no confirms.
;; From http://pages.sachachua.com/.emacs.d/Sacha.html#sec-1-4-8
(fset 'yes-or-no-p 'y-or-n-p)

(use-package menu-bar
  ;; No need to confirm killing buffers.
  :bind ("C-x k" . kill-current-buffer))

(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)


(use-package face-remap
  :bind(("C-+" . text-scale-increase)
        ("C--" . text-scale-decrease)))

;; IDO mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(setq ido-use-filename-at-point 'guess)
(setq ido-use-url-at-point nil)

;; Kill whole line and newline with C-k if at beginning of line
; (setq kill-whole-line t)

;; Comment region
(add-hook 'prog-mode-hook
          (lambda() (local-set-key (kbd "C-<") #'comment-region)))
(add-hook 'prog-mode-hook
          (lambda() (local-set-key (kbd "C->") #'uncomment-region)))

;; Dired
(setq dired-create-destination-dirs 'ask) ; ask before creating a new folder

;; Sidebar
(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-use-term-integration t))
  ;; (setq dired-sidebar-use-custom-font t))

;; page navigation without arrows
(global-set-key (kbd "M-<down>") 'scroll-up-command)
(global-set-key (kbd "M-<up>") 'scroll-down-command)

;; syntax highlight everywhere
(global-font-lock-mode t)

;; Don't ever use graphic dialog boxes
(setq use-dialog-box nil)


;; Don't open new annoying windows under X, use the echo area
(tooltip-mode -1)


;; Parenthesis
;(electric-pair-mode 1)
;; Show matching parens
(show-paren-mode t)
(setq show-paren-style 'expression)
(setq show-paren-delay 0.0)

(setq skeleton-pair t)
(setq skeleton-pair-on-word t) ; apply skeleton trick even in front of a word.                                               
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)


;;;; Timestamps
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S %U")

(defun skeleton-time-stamp (dminus)
  "Inserts current time-stamp, formatted yyyy.mm.dd hh:mm.
   Optional argument reduces the day (by a negative quantity also)"
  (interactive "P")
  (require 'calendar)
  (if (and (listp dminus) (not (null dminus)))   ; C-u w/o prefix gives '(4) --> this sets dminus to (log_2 4)/2 = 1
      (setq dminus (truncate (/ (log (car dminus) 2) 2))) 
    (if (eq dminus nil)
	(setq dminus 0)))
  (setq dminus (- 0 dminus))
  (setq datatmp (dm/get-any-date (calendar-current-date) dminus))
  (insert (concat (int-to-string (extract-calendar-year datatmp)) "."))
  (let ((l (extract-calendar-month datatmp)))
    (if (< l 10)
	(insert (concat "0" (int-to-string l)))
      (insert (int-to-string l))))
  (insert ".")
  (let ((l (extract-calendar-day datatmp)))
    (if (< l 10)
	(insert (concat "0" (int-to-string l)))
      (insert (int-to-string l))))
  (insert " ")
  (insert (truncate-string-to-width (time-stamp-string) 20 15)))

(defun scratch-buffer nil
  "Create a new scratch buffer to work in.  (could be *scratch* - *scratchX*)"
  (interactive)
  (let ((n 0)
	bufname)
    (while (progn
	     (setq bufname (concat "*scratch"
				   (if (= n 0) "" (int-to-string n))
				   "*"))
	     (setq n (1+ n))
	     (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
    (text-mode)))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
