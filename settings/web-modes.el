(use-package css-mode
  :mode (("\\.css\\'" . css-mode)
         ("\\.rasi\\'" . css-mode)))

(use-package web-mode
  :ensure t
  :custom
  (web-mode-auto-close-style 2)
  :mode (("\\.html\\'" . web-mode)
         ("\\.php\\'" . web-mode)))

;;;; Web debug

;; set root folder for httpd server as current buffer folder
(setq httpd-root default-directory)

;; M-x httpd-start
;; start on these files

;;;; Using impatient-mode
;; Enable the web server provided by simple-httpd:

;; M-x httpd-start
;; Publish buffers by enabling the minor mode impatient-mode.

;; M-x impatient-mode
;; And then point your browser to http://localhost:8080/imp/, select a buffer, and watch your changes appear as you type!

;; If you are editing HTML that references resources in other files (like CSS) you can enable impatient-mode on those buffers as well. This will cause your browser to live refresh the page when you edit a referenced resource.

(use-package impatient-mode
  :ensure t
  :commands impatient-mode)
