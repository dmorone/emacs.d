;;; -*- elisp -*-
;;; Commentary

;;; Code:
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :hook ((markdown-mode . auto-fill-mode))
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)
              ("M-$" . whitespace-mode)))
