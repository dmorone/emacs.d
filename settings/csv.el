(use-package csv-mode
  :defer
  :mode (("\\.[Cc][Ss][Vv]\\'" . csv-mode))
  :ensure t
  :config
  (setq csv-separators '("," ";" "|" " ")))
