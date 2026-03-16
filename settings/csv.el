(use-package csv-mode
  :mode (("\\.[Cc][Ss][Vv]\\'" . csv-mode))
  :ensure t
  :config
  (setq csv-separators '("," ";" "|" " ")))
