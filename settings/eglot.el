;; Note install these language servers (brew)
;; - harper (grammar)
;; - ty (python)
;; - bash-language-server (bash)
;; - llvm (contains clangd for C)
;; - yaml-language-server (YAML)
;; Note: YAML-MODE should connect automatically to yaml-language-server if installed

(use-package eglot
  :ensure t
  :hook ((markdown-mode org-mode python-mode python-ts-mode bash-mode bash-ts-mode java-mode java-ts-mode java-ts-mode c-mode c-ts-mode) . eglot-ensure)
  :bind
  (:map eglot-mode-map
        ("M-l r" . eglot-rename)
        ("M-l TAB" . eglot-format)
        ("M-RET" . eglot-code-actions)
        ("M-l h" . eglot-inlay-hints-mode))
  :config
  (setq eglot-stay-out-of '(company))
  ;; grammar check
  (setq-default eglot-workspace-configuration
                '(:harper-ls (:userDictPath ""
                                            :workspaceDictPath ""
                                            :fileDictPath ""
                                            :linters (:SpellCheck :json-false
                                                                  :SpelledNumbers :json-false
                                                                  :AnA t
                                                                  :SentenceCapitalization :json-false
                                                                  :UnclosedQuotes t
                                                                  :WrongQuotes :json-false
                                                                  :LongSentences t
                                                                  :RepeatedWords t
                                                                  :Spaces t
                                                                  :Matcher t
                                                                  :CorrectNumberSuffix t)
                                            :codeActions (:ForceStable :json-false)
                                            :markdown (:IgnoreLinkTitle :json-false)
                                            :diagnosticSeverity "hint"
                                            :isolateEnglish :json-false
                                            :dialect "British"
                                            :maxFileLength 120000
                                            :ignoredLintsPath ""
                                            :excludePatterns [])))
  
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(org-mode . ("harper-ls" "--stdio"))))
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(markdown-mode . ("harper-ls" "--stdio"))))

  ;; ;; powershell
  ;; (with-eval-after-load 'eglot
  ;;   (add-to-list 'eglot-server-programs
  ;;                '(powershell-mode . ("pwsh" "-NoProfile -Command ~/.local/share/powershell/Modules/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1"))))

  ;; ;; LaTex
  ;; (with-eval-after-load 'eglot
  ;;   (add-to-list 'eglot-server-programs
  ;;                '(LaTeX-mode . ("texlab"))))
  ;; (add-hook latex-mode-hook 'eglot-ensure)
  
  ;; python
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
             '((python-ts-mode python-mode)
               . ("ty" "server"))))

  ;; bash
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
               '((bash-ts-mode bash-mode)  . ("bash-language-server"))))

  ;; Java
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '((java-ts-mode java-mode)  . ("jdtls"))))

  ;; C
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '((c-ts-mode c-mode)  . ("clangd")))))
