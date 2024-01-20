;;; init.el --- This is my init.    -*- lexical-binding: t; -*-

;;;; Set up package tls

(require 'package)

;; Don't auto-initialize.
(setq package-enable-at-startup nil)

;; Don't add that `custom-set-variables' block to init.
(setq package--init-file-ensured t)

;; Save custom vars to separate file from init.el.
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; From https://irreal.org/blog/?p=8243
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; From https://github.com/hlissner/doom-emacs/blob/5dacbb7cb1c6ac246a9ccd15e6c4290def67757c/core/core-packages.el#L102
(setq gnutls-verify-error (not (getenv "INSECURE")) ; you shouldn't use this
      tls-checktrust gnutls-verify-error
      tls-program (list "gnutls-cli --x509cafile %t -p %p %h"
                        ;; compatibility fallbacks
                        "gnutls-cli -p %p %h"
                        "openssl s_client -connect %h:%p -no_ssl2 -no_ssl3 -ign_eof"))

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(setq package-archive-priorities
      '(("melpa" .  4)
        ("melpa-stable" . 3)
        ("org" . 2)
        ("gnu" . 1)))

(when (< emacs-major-version 27)
  (unless package--initialized
    (package-initialize)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; use-package-enable-imenu-support must be
;; set before requiring use-package.
(setq use-package-enable-imenu-support t)
(require 'use-package)
;; (setq use-package-verbose t)

;;;; Load settings
(load "~/.emacs.d/settings/appearance.el")
(load "~/.emacs.d/settings/backups.el")
(load "~/.emacs.d/settings/behaviour.el")
(load "~/.emacs.d/settings/mac.el")
(load "~/.emacs.d/settings/server.el")

(load "~/.emacs.d/settings/orgmode.el")
(load "~/.emacs.d/settings/git.el")
(load "~/.emacs.d/settings/company.el")
(load "~/.emacs.d/settings/jenkinsfile.el")
(load "~/.emacs.d/settings/markdown.el")
(load "~/.emacs.d/settings/powershell.el")
(load "~/.emacs.d/settings/web-modes.el")
(load "~/.emacs.d/settings/r.el")

(load "~/.emacs.d/settings/macros.el")
