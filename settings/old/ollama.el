(use-package ellama ; https://github.com/s-kostyaev/ellama
  :ensure t
  :bind ("C-c e" . ellama)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init
  (setopt ellama-auto-scroll t)
  ;; setup key bindings
  ;; (setopt ellama-keymap-prefix "C-c e")
  ;; language you want ellama to translate to
  (setopt ellama-language "English")
  (require 'llm-ollama)
  (setopt ellama-provider
  	  (make-llm-ollama
  	   ;; this model should be pulled to use it
  	   ;; value should be the same as you print in terminal during pull
  	   :chat-model "gemma3:12b"))
  ;; (setopt ellama-summarization-provider
  ;; 	  (make-llm-ollama
  ;; 	   :chat-model "MichelRosselli/apertus:8b-instruct-2509-bf16"
  ;; 	   :embedding-model "nomic-embed-text"
  ;; 	   :default-chat-non-standard-params '(("num_ctx" . 32768))))
  ;; (setopt ellama-coding-provider
  ;; 	  (make-llm-ollama
  ;; 	   :chat-model "qwen3-coder:30b"
  ;; 	   :embedding-model "nomic-embed-text"
  ;; 	   :default-chat-non-standard-params '(("num_ctx" . 32768))))
  ;; ;; Naming new sessions with llm
  ;; (setopt ellama-naming-provider
  ;; 	  (make-llm-ollama
  ;; 	   :chat-model "gemma3:12b"
  ;; 	   :embedding-model "nomic-embed-text"
  ;; 	   :default-chat-non-standard-params '(("stop" . ("\n")))))
  ;; (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)
  ;; ;; Translation llm provider
  ;; (setopt ellama-translation-provider
  ;; 	  (make-llm-ollama
  ;; 	   :chat-model "MichelRosselli/apertus:8b-instruct-2509-bf1"
  ;; 	   :embedding-model "nomic-embed-text"
  ;; 	   :default-chat-non-standard-params
  ;; 	   '(("num_ctx" . 32768))))
  ;; (setopt ellama-extraction-provider (make-llm-ollama
  ;; 				      :chat-model "gemma3:12b"
  ;; 				      :embedding-model "nomic-embed-text"
  ;; 				      :default-chat-non-standard-params
  ;; 				      '(("num_ctx" . 32768))))
  ;; ;; customize display buffer behaviour
  ;; ;; see ~(info "(elisp) Buffer Display Action Functions")~
  ;; (setopt ellama-chat-display-action-function #'display-buffer-full-frame)
  ;; (setopt ellama-instant-display-action-function #'display-buffer-at-bottom)
  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode +1)
  ;; show ellama session id in header line in all buffers
  (ellama-session-header-line-global-mode +1)
  ;; handle scrolling events
  ;; (advice-add 'pixel-scroll-precision :before #'ellama-disable-scroll)
  ;; (advice-add 'end-of-buffer :after #'ellama-enable-scroll)
  )
