(use-package eglot
  :ensure t
  :hook ((prog-mode-hook text-mode-hook markdown-mode-hook org-mode-hook) . eglot-ensure)
  :bind
  (:map eglot-mode-map
        ("M-l r" . eglot-rename)
        ("M-l TAB" . eglot-format)
        ("M-RET" . eglot-code-actions)
        ("M-l h" . eglot-inlay-hints-mode))
  :config
  (setq-default eglot-workspace-configuration
                '(:harper-ls (:dialect "British")))
  (setq eglot-stay-out-of '(company))
  
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(text-mode . ("harper-ls" "--stdio"))))

  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(org-mode . ("harper-ls" "--stdio"))))
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                   '(markdown-mode . ("harper-ls" "--stdio")))))
