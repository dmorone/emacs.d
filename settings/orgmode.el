(use-package org
  :mode ("\\.org\\'" . org-mode)
  :custom
  (org-startup-folded t)
  (org-todo-keywords
   '((sequence
      "TODO(t)"
      "STARTED(s)"
      "WAITING(w!)" ;; Use @/! to log note and timestamp
      "|"
      "DONE(d!)"
      "CANCELLED(c)")))
  (org-log-done 'time)
  ;; Fontify code in code blocks.
  (org-src-fontify-natively t)

  ;; Display images inline when running in GUI.
  (org-startup-with-inline-images (display-graphic-p))
  (org-src-tab-acts-natively t)

  ;; Prevent inadvertently editing invisible areas in Org.
  (org-catch-invisible-edits 'error)
  (org-cycle-separator-lines 2)
  (org-image-actual-width nil)
  (org-hide-emphasis-markers t)

  ;; All Org leading stars become invisible.
  (org-hide-leading-stars t)

    ;; Enable RET to follow Org links.
  (org-return-follows-link t)
  :hook ((org-mode . visual-line-mode))
  :config
  (defun adviced:org-yank (orig-fun &rest r)
    "Advice `adviced:org-yank' to align tables (ORIG-FUN and R)."
    (apply orig-fun r)
    (when (and (org-at-table-p)
               org-table-may-need-update)
      (org-table-align)))

    (advice-add #'org-yank
              :around
              #'adviced:org-yank))

(use-package org-faces
  :custom
  (org-todo-keyword-faces
   '(("TODO" . (:foreground "red" :weight bold))
     ("STARTED" . (:foreground "green" :weight bold))
     ("WAITING" . (:foreground "yellow" :weight bold))
     ("DONE" . (:foreground "gray" :weight bold))
     ("CANCELLED" . (:foreground "gray" :weight bold)))))
