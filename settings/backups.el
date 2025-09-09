;;; -*- lexical-binding: t; -*-

(setq backup-directory-alist '(("." . "~/.emacs.d/backups"))
      auto-save-default nil
      auto-save-mode -1
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 5   ; how many of the newest versions to keep
      kept-old-versions 2    ; and how many of the old
      )

(setq temporary-file-directory "~/.emacs.d/saves-tmp")
(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; (setq make-backup-files nil) ; Prevent all backups
