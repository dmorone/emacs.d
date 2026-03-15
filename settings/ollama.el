(use-package gptel
  :ensure t
  :bind (("C-x ö" . gptel-send)
         ("C-x ü" . gptel))
  :config
  (setq
   gptel-model 'gemma3:12b
   gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(gemma3:12b))))
