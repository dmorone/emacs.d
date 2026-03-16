;; Reading ebooks within Emacs allows me to reuse the Emacs workflow, such as capturing with Org mode, translating, asking questions with LLMs, and so on.
(use-package nov
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-unzip-program (executable-find "bsdtar")
        nov-unzip-args '("-xC" directory "-f" filename))

  ;; nov-mode-map map <home> and <end> to beginning and end of the buffer.
  ;; Unset it so it is using the default beginning and end of the line.
  (keymap-unset nov-mode-map "<home>")
  (keymap-unset nov-mode-map "<end>"))

(use-package google-translate
  :ensure   
  :autoload (google-translate-translate)
  :bind
  ("C-c v" . google-translate-at-point)
  :init
  ;; Use "https". This should be the default value! Currently blocked in https://github.com/atykhonov/google-translate/pull/75
  (setq google-translate-base-url "https://translate.google.com/translate_a/single")
  (setq google-translate-listen-url "https://translate.google.com/translate_tts")

  (setq google-translate-default-source-language "auto") ;; or "en"
  (setq google-translate-default-target-language "it-CH")
  (setq google-translate-output-destination 'help)

  (defun my/google-translate-at-point-in-popup ()
    "Like `google-translate-at-point' with the
`google-translate-output-destination' as `popup'."
    (interactive)
    (let ((google-translate-output-destination 'popup))
      (google-translate-at-point)))

  (with-eval-after-load "embark"
    (keymap-set embark-general-map "v" #'my/google-translate-at-point-in-popup)))
