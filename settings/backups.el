;;; -*- lexical-binding: t; -*-

(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 5   ; how many of the newest versions to keep
  kept-old-versions 2    ; and how many of the old
  )

;; (setq make-backup-files nil) ; Prevent all backups
