
;;;; Indentation
(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value

;; Use y/n instead of yes/no confirms.
;; From http://pages.sachachua.com/.emacs.d/Sacha.html#sec-1-4-8
(fset 'yes-or-no-p 'y-or-n-p)

(use-package menu-bar
  ;; No need to confirm killing buffers.
  :bind ("C-x k" . kill-current-buffer))

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

(electric-pair-mode 1)
