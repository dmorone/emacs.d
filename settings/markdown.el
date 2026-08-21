;;; -*- elisp -*-
;;; Commentary

;;; Code:
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)
              ("M-$" . whitespace-mode)))
