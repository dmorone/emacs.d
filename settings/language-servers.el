(use-package eglot
  :ensure t
  :hook (c-mode          ; clangd
         c++-mode        ; clangd
         c-or-c++-mode   ; clangd
         java-mode       ; eclipse-jdtls
         js-mode         ; ts-ls (tsserver wrapper)
         js-jsx-mode     ; ts-ls (tsserver wrapper)
         typescript-mode ; ts-ls (tsserver wrapper)
         python-mode     ; pylsp
         web-mode        ; ts-ls/HTML/CSS
         haskell-mode    ; haskell-language-server
         ))
;; powershell config TDB
  ;; :config
  ;; (with-eval-after-load 'eglot
  ;; (add-to-list 'eglot-server-programs
  ;;              '(powershell . ("fools" "--stdio")))))
 
