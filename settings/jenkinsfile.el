;;; -*- lexical-binding: t; -*-

(use-package jenkinsfile-mode
  :defer
  :mode (("\\.groovy\\'" . jenkinsfile-mode))
  :ensure t
  :init)
