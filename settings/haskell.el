(use-package haskell-mode
  :defer
  :ensure t
  :init
  :mode (("\\.ghci\\'" . haskell-mode))
  :config

  (add-hook 'haskell-mode-hook 'subword-mode)
  (add-hook 'haskell-cabal-mode 'subword-mode)

  (add-hook 'haskell-mode-hook 'interactive-haskell-mode)

  ;; Indentation
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)


  ;; Source code helpers
  (add-hook 'haskell-mode-hook 'haskell-auto-insert-module-template)

  (with-eval-after-load 'haskell-mode
    (define-key haskell-mode-map (kbd "C-c h") 'hoogle)
    (define-key haskell-mode-map (kbd "C-o") 'open-line))


  (with-eval-after-load 'page-break-lines
    (add-to-list 'page-break-lines-modes 'haskell-mode)))

(use-package dhall-mode
  :defer
  :ensure t
  :init)

(use-package reformatter
  :defer
  :ensure t
  :init
  :config
  (reformatter-define hindent
                      :program "hindent"
                      :lighter " Hin")

  (defalias 'hindent-mode 'hindent-on-save-mode)

  (reformatter-define ormolu
                      :program "ormolu"
                      :lighter " Orm"))
