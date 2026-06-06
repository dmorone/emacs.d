(use-package dired
  :hook ((dired-mode . auto-revert-mode)
         (dired-mode . dired-hide-details-mode))
  :init
  (put 'dired-find-alternate-file 'disabled nil)
  :config
  (setq dired-create-destination-dirs 'ask)
  (setq dired-hide-details-preserved-columns '(5 6 7 8))
  (keymap-set dired-mode-map "TAB" #'dired-hide-details-mode))
