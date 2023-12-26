;;; -*- lexical-binding: t; -*-

(when (memq window-system '(mac ns))
  ;; No icon on window.
  (setq ns-use-proxy-icon nil)

  ;; Fixes mode line separator issues on macOS.
  (setq ns-use-srgb-colorspace nil)

  ;; Make ⌘ meta modifier.
  (setq mac-command-modifier 'meta)

  ;; Use existing frame when opening files.
  (setq ns-pop-up-frames nil)

  ;; Transparent titlebar on macOS.
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))

  (setq trash-directory "~/.Trash")

  ;; See `trash-directory' as it requires defining `system-move-file-to-trash'.
  (defun system-move-file-to-trash (file)
    "Use \"trash\" to move FILE to the system trash."
    (cl-assert (executable-find "trash") nil "'trash' must be installed. Needs \"brew install trash\"")
    (call-process "trash" nil 0 nil "-F"  file))

  (use-package ns-win
    ;; Easily insert # on macOS/Swiss German keyboard.
    ;; https://coffeeandcode.neocities.org/emacs-keyboard-config-on-mac.html
    :bind ("M-3" . ar/macos-insert-hash)
    :bind ("M-7" . dm/macos-insert-backslash)
    :bind ("M-n" . dm/macos-insert-tilde)
    :bind ("M-g" . dm/macos-insert-at)
    :bind ("M-5" . dm/macos-insert-sqleft)
    :bind ("M-6" . dm/macos-insert-sqright)
    :bind ("M-8" . dm/macos-insert-curlyleft)
    :bind ("M-9" . dm/macos-insert-curlyright)
    :config
    (defun ar/macos-insert-hash ()
      (interactive)
      (insert "#"))
    (defun dm/macos-insert-backslash ()
      (interactive)
      (insert "\\"))
    (defun dm/macos-insert-tilde ()
      (interactive)
      (insert "~"))
    (defun dm/macos-insert-sqleft ()
      (interactive)
      (insert "["))
    (defun dm/macos-insert-sqright ()
      (interactive)
      (insert "]"))
    (defun dm/macos-insert-curlyleft ()
      (interactive)
      (insert "{"))
    (defun dm/macos-insert-curlyright ()
      (interactive)
      (insert "}"))
    (defun dm/macos-insert-at ()
      (interactive)
      (insert "@")))
  
  ;; macOS color picker.
  (use-package color-picker
    :commands color-picker))
