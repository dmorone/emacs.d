(setq dired-create-destination-dirs 'ask)

;; Auto-refresh dired on file change
(add-hook 'dired-mode-hook 'auto-revert-mode)
