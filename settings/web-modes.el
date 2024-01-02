(use-package css-mode
  :mode (("\\.css\\'" . css-mode)
         ("\\.rasi\\'" . css-mode)))

(use-package web-mode
  :ensure t
  :custom
  (web-mode-auto-close-style 2)
  :mode (("\\.html\\'" . web-mode)
         ("\\.php\\'" . web-mode)))

