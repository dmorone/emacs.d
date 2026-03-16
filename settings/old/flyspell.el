(use-package flyspell
  :ensure t
  :config
  (if (eq system-type 'darwin)
      (setq ispell-program-name "/usr/local/bin/aspell")
    (setq ispell-program-name "/usr/bin/aspell"))
  (setq ispell-dictionary "british"
        ispell-extra-args '() ;; TeX mode "-t"
        ispell-silently-savep t)
  (setq ispell-personal-dictionary "~/.emacs.d/ispell-dict")
  (defun flyspellCompletion() 
    (flyspell-mode 1) 
    (set (make-local-variable 'company-backends) 
         (copy-tree company-backends)) 
    (add-to-list 'company-backends 'company-ispell)) 
  (defun flyspell-most-modes() 
    (add-hook 'text-mode-hook 'flyspellCompletion) 
    (add-hook 'prog-mode-hook 'flyspellCompletion)
    (dolist (hook '(change-log-mode-hook log-edit-mode-hook)) 
      (add-hook hook (lambda () 
                       (flyspell-mode -1))))) 
  (flyspell-most-modes) 
  :bind (:map flyspell-mode-map
              ("C-." . flyspell-correct-wrapper)))

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(use-package flyspell-correct-ido
  :after flyspell-correct)
