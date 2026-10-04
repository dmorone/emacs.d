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
   gptel-model 'moonshotai/Kimi-K2.6
   gptel-backend (gptel-make-openai "infomaniak"
                   :host "https://api.infomaniak.com/2/ai/109428/openai/v1/chat/completions"
                   :protocol "https"
                   :stream t
                   :models '(moonshotai/Kimi-K2.6
                             google/gemma-4-31B-it
                             mistralai/Mistral-Small-4-119B-2603
                             swiss-ai/Apertus-v1.5-70B
                             Qwen/Qwen3.5-397B-A17B-FP8))))

(use-package gptel-agent
  :ensure t
  :bind (("C-x C-ö a" . gptel-agent))
  :config
  (setq
   gptel-agent-dirs '("~/.emacs.d/agents/"))
  (gptel-agent-update))
