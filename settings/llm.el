(use-package gptel
  :ensure t
  :bind (("C-x C-ö s" . gptel-send)
         ("C-x C-ö n" . gptel)
         ("C-x C-ö ?" . gptel-menu)
         ("C-x C-ö r" . gptel-rewrite))
  :config
  (setq
   gptel-use-tools t
   gptel-confirm-tool-calls t
   ;; for web. curl handles proxy better than url.el
   gptel-use-curl t
   gptel-model 'ggml-org/gemma-4-E4B-it-GGUF:Q4_K_M
   gptel-backend (gptel-make-openai "llama-cpp"
                   ;; Llama.cpp offers an OpenAI compatible API
                   :host "localhost:8080"
                   :protocol "http"
                   :stream t
                   :models '(unsloth/Qwen3.6-27B-GGUF:IQ3_XXS
                             unsloth/Qwen3.6-27B-GGUF:Q4_K_M
                             ggml-org/gemma-4-E4B-it-GGUF:Q4_K_M))))
