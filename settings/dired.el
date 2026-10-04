(use-package dired
  :hook ((dired-mode . auto-revert-mode)
         (dired-mode . dired-hide-details-mode))
  :init
  (put 'dired-find-alternate-file 'disabled nil)
  :config
  (setq dired-create-destination-dirs 'ask)
  (setq dired-hide-details-preserved-columns '(5 6 7 8))
  (keymap-set dired-mode-map "TAB" #'dired-hide-details-mode)
  ;; https://zgfabian.github.io/2025-11-01-emacs-dired-config
  (defun dual-dired ()
    "Open 2 dired buffers side by side."
    (interactive)
    (let ((original-window (selected-window)))
      (dired ".") ;; current directory
      (split-window-right)
      (other-window 1)
      (dired ".")
      (select-window original-window)))
  ;; Bind the function to a key combination
  (keymap-global-set "C-c d" 'dual-dired))

(use-package dired-ranger
  :ensure t
  :config
  (setq dired-ranger-copy-ring-size 1)
    (define-key dired-mode-map (kbd "C-w")
        (lambda ()
            (interactive)
            (dired-ranger-copy nil) ; t adds item to dired-ranger-copy-ring
            (define-key dired-mode-map (kbd "C-y") 'dired-ranger-move)))
    (define-key dired-mode-map (kbd "M-w")
        (lambda ()
            (interactive)
            (dired-ranger-copy nil)
            (define-key dired-mode-map (kbd "C-y") 'dired-ranger-paste)))
)
