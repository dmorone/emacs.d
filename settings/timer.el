;; -*- lexical binding: t; -*-

(defun my-macos-notify (timer)
  (let* ((description (or (tmr--timer-description timer) ""))
         (sanitized-body (substring-no-properties description))
         (script (format "display notification %S with title %S sound name %S"
    	  		 sanitized-body
    	  		 (format-time-string "Emacs TMR: %R" (tmr--timer-end-date timer))
    	  		 "Hero")))
    (call-process "osascript" nil 0 nil "-e" script)))

(remove-hook 'tmr-timer-finished-functions #'tmr-notification-notify)
(add-hook 'tmr-timer-finished-functions #'my-macos-notify)

(use-package tmr
  :ensure t
  :config
  (define-key global-map (kbd "C-c t") #'tmr-prefix-map)
  (setq tmr-sound-file "/System/Library/Sounds/Glass.aiff"
        tmr-notification-urgency 'normal
        tmr-description-list 'tmr-description-history))
