;;; -*- elisp -*-
;;; Commentary

;;; Code:
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :hook ((markdown-mode . ar/markdown-mode-hook)
         (markdown-mode . dm/resize-margins)
         (markdown-mode . auto-fill-mode))
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)
              ("M-$" . whitespace-mode)))

;; (use-package markdown-mode
;;   :ensure t
;;   :mode (("\\.text\\'" . markdown-mode)
;;          ("\\.markdown\\'" . markdown-mode)
;;          ("\\.md\\'" . markdown-mode))
;;   :custom (markdown-asymmetric-header t)
;;   :bind (:map
;;          markdown-mode-map
;;          ; ("M-<left>" . markdown-promote)
;;          ;("M-<right>" . markdown-demote)
;;          ("M-$" . whitespace-mode)))
