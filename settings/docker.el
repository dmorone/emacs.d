(defcustom lemacs-docker-executable 'docker
  "The executable to be used with docker-mode."
  :type '(choice
		   (const :tag "docker" docker)
		   (const :tag "podman" podman))
  :group 'lemacs)

(setq lemacs-docker-executable 'docker)

(use-package docker
	:defer t
	:ensure t
	:bind ("C-c d" . docker)
	:config
	(pcase lemacs-docker-executable
	  ('docker
	   (setf docker-command "docker"
			 docker-compose-command "docker-compose"
			 docker-container-tramp-method "docker"))
	  ('podman
	   (setf docker-command "podman"
			 docker-compose-command "podman-compose"
			 docker-container-tramp-method "podman"))))

(use-package dockerfile-mode
  :defer t
  :ensure t
  :config
  (pcase lemacs-docker-executable
	('docker
	 (setq dockerfile-mode-command "docker"))
	('podman
	 (setq dockerfile-docker-command "podman"))))

(use-package yaml-mode
  :defer t
  :ensure t
  :mode
  ("\\.yaml\\'" "\\.yml\\'")
  :custom-face
  (font-lock-variable-name-face ((t (:foreground "#cba6f7"))))
  :config)
