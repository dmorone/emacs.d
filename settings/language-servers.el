(use-package eglot
  :ensure t
  :config
  (add-hook 'bash-mode-hook 'eglot-ensure)
  (add-hook 'cc-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  (add-hook 'python-mode-hook 'eglot-ensure)
  (add-hook 'java-mode-hook 'eglot-ensure)
  (add-hook 'html-mode-hook 'eglot-ensure)
  (add-hook 'css-mode-hook 'eglot-ensure)
  (add-hook 'json-mode-hook 'eglot-ensure))

