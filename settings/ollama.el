(use-package gptel
  :ensure t
  :bind (("C-x ö" . gptel-send)
         ("C-x ü" . gptel))
  :config
  (setq
   gptel-model 'qwen3-coder:30b
   gptel-backend (gptel-make-ollama "Ollama"
                 :host "localhost:11434"
                 :stream t
                 :models '(gemma3:12b
                           qwen3-coder:30b
                           codegemma:latest
                           MichelRosselli/apertus:8b-instruct-2509-bf16))))
