;;; -*- elisp -*-
;;; Commentary

;;; Code:
(use-package markdown-mode
  :ensure t
  :mode (("\\.text\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("\\.md\\'" . markdown-mode))
  :hook ((markdown-mode . ar/markdown-mode-hook)
         (markdown-mode . auto-fill-mode))
  :custom (markdown-asymmetric-header t)
  :bind (:map
         markdown-mode-map
         ("M-<left>" . markdown-promote)
         ("M-<right>" . markdown-demote)
         ("M-[" . markdown-promote)
         ("M-]" . markdown-demote))
  :config
  (defun ar/markdown-mode-hook ()
    "Called when entering `markdown-mode'."
    (set-fill-column 80)))
