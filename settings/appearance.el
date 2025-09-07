;;; -*- lexical-binding: t; -*-

;; Don't want a mode line while loading init.
(setq mode-line-format nil)

;; No scrollbar by default.
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; No nenubar by default.
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

;; No toolbar by default.
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;; No tooltip by default.
(when (fboundp 'tooltip-mode)
  (tooltip-mode -1))

;; No Alarms by default.
(setq ring-bell-function 'ignore)

(defun ar/show-welcome-buffer ()
  "Show *Welcome* buffer."
  (with-current-buffer (get-buffer-create "*Welcome*")
    (setq truncate-lines t)
    (let* ((buffer-read-only)
           (image-path "~/.emacs.d/emacs.png")
           (image (create-image image-path))
           (size (image-size image))
           (height (cdr size))
           (width (car size))
           (top-margin (floor (/ (- (window-height) height) 2)))
           (left-margin (floor (/ (- (window-width) width) 2)))
           (title "Welcome to Emacs!"))
      (erase-buffer)
      (setq mode-line-format nil)
      (goto-char (point-min))
      (insert (make-string top-margin ?\n ))
      (insert (make-string left-margin ?\ ))
      (insert-image image)
      (insert "\n\n\n")
      (insert (make-string (floor (/ (- (window-width) (string-width title)) 2)) ?\ ))
      (insert title))
    (setq cursor-type nil)
    (read-only-mode +1)
    (switch-to-buffer (current-buffer))
    (local-set-key (kbd "q") 'kill-current-buffer)))

(setq initial-scratch-message nil)
(setq inhibit-startup-screen t)

(when (< (length command-line-args) 2)
  (add-hook 'emacs-startup-hook (lambda ()
                                  (when (display-graphic-p)
                                    (ar/show-welcome-buffer)))))



(when (display-graphic-p)
  ;; No title. See init.el for initial value.
  (setq-default frame-title-format nil)
  ;; Hide the cursor in inactive windows.
  (setq cursor-in-non-selected-windows nil)
  ;; Avoid native dialogs.
  (setq use-dialog-box nil))

;; Set font face height. Value is 1/10pt.
(set-face-attribute 'default nil
                    :height 120)


(use-package frame
  :defer
  :init
  ;; Mispressing C-z invokes `suspend-frame' (disable).
  (global-unset-key (kbd "C-z"))
  :config
  ;; Enable expanding frame to end of screen.
  (setq frame-resize-pixelwise t)
  ;; Remove thin border. Visible since Monterey.
  (set-frame-parameter nil 'internal-border-width 0)
  ;; (set-frame-position (selected-frame) 220 100)
  (set-frame-size (selected-frame) 150 40)
  ;; https://christiantietze.de/posts/2022/04/emacs-center-window-current-monitor-simplified/
  (defun my/frame-recenter (&optional frame)
  "Center FRAME on the screen.
FRAME can be a frame name, a terminal name, or a frame.
If FRAME is omitted or nil, use currently selected frame."
  (interactive)
  (unless (eq 'maximised (frame-parameter nil 'fullscreen))
    (modify-frame-parameters
     frame '((user-position . t) (top . 0.5) (left . 0.5)))))
  (my/frame-recenter))

(use-package material-theme
  :ensure t
  :config
  (load-theme 'material t)
  (ar/load-material-org-tweaks)
  :init
  (defun ar/load-material-org-tweaks ()
    (with-eval-after-load 'frame
      (set-cursor-color "orange"))

    (with-eval-after-load 'faces
      (set-face-attribute 'header-line nil :background "#212121" :foreground "dark grey")
      ;; From https://gist.github.com/huytd/6b785bdaeb595401d69adc7797e5c22c#file-customized-org-mode-theme-el
      (set-face-attribute 'default nil :stipple nil :background "#212121" :foreground "#eeffff" :inverse-video nil
                          ;; :family "Menlo" ;; or Meslo if unavailable: https://github.com/andreberg/Meslo-Font
                          ;; :family "Hack" ;; brew tap homebrew/cask-fonts && brew cask install font-hack
                          :family "JetBrains Mono" ;; brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono
                          ;; :family "mononoki" ;; https://madmalik.github.io/mononoki/ or sudo apt-get install fonts-mononoki
                          :box nil :strike-through nil :overline nil :underline nil :slant 'normal :weight 'normal
                          :width 'normal :foundry "nil")
      ;; Enable rendering SF symbols on macOS.
      (when (memq system-type '(darwin))
        (set-fontset-font t nil "SF Pro Display" nil 'append))

      ;; Emoji's: welcome back to Emacs
      ;; https://github.crookster.org/emacs27-from-homebrew-on-macos-with-emoji/
      (when (>= emacs-major-version 27)
        (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))

      ;; Hardcode region theme color.
      (set-face-attribute 'region nil :background "#3f464c" :foreground "#eeeeec" :underline nil)
      (set-face-attribute 'mode-line nil :background "#191919" :box nil)

      ;; Styling moody https://github.com/tarsius/moody
      (let ((line (face-attribute 'mode-line :underline)))
        (set-face-attribute 'mode-line nil :overline   line)
        (set-face-attribute 'mode-line-inactive nil :overline   line)
        (set-face-attribute 'mode-line-inactive nil :underline  line)
        (set-face-attribute 'mode-line nil :box nil)
        (set-face-attribute 'mode-line-inactive nil :box nil)
        (set-face-attribute 'mode-line-inactive nil :background "#212121" :foreground "#5B6268")))

    (with-eval-after-load 'font-lock
      (set-face-attribute 'font-lock-constant-face nil :foreground "#C792EA")
      (set-face-attribute 'font-lock-keyword-face nil :foreground "#2BA3FF" :slant 'italic)
      (set-face-attribute 'font-lock-preprocessor-face nil :inherit 'bold :foreground "#2BA3FF" :slant 'italic :weight 'normal)
      (set-face-attribute 'font-lock-string-face nil :foreground "#C3E88D")
      (set-face-attribute 'font-lock-type-face nil :foreground "#FFCB6B")
      (set-face-attribute 'font-lock-variable-name-face nil :foreground "#FF5370"))

    (with-eval-after-load 'paren
      (set-face-attribute 'show-paren-match nil
                          :background nil
                          :foreground "#FA009A"))

    (with-eval-after-load 'org-indent
      (set-face-attribute 'org-indent nil :background "#212121"))

    (with-eval-after-load 'org-faces
      (set-face-attribute 'org-hide nil :foreground "#212121" :background "#212121" :strike-through nil)
      (set-face-attribute 'org-done nil :foreground "#b9ccb2" :strike-through nil)
      (set-face-attribute 'org-agenda-date-today nil :foreground "#Fb1d84")
      (set-face-attribute 'org-agenda-done nil :foreground "#b9ccb2" :strike-through nil)
      (set-face-attribute 'org-table nil :background nil)
      (set-face-attribute 'org-code nil :background nil)
      (set-face-attribute 'org-level-1 nil :background nil :box nil)
      (set-face-attribute 'org-level-2 nil :background nil :box nil)
      (set-face-attribute 'org-level-3 nil :background nil :box nil)
      (set-face-attribute 'org-level-4 nil :background nil :box nil)
      (set-face-attribute 'org-level-5 nil :background nil :box nil)
      (set-face-attribute 'org-level-6 nil :background nil :box nil)
      (set-face-attribute 'org-level-7 nil :background nil :box nil)
      (set-face-attribute 'org-level-8 nil :background nil :box nil)
      (set-face-attribute 'org-block-begin-line nil :background nil :box nil)
      (set-face-attribute 'org-block-end-line nil :background nil :box nil)
      (set-face-attribute 'org-block nil :background nil :box nil))

    ;; No color for sp-pair-overlay-face.
    (with-eval-after-load 'smartparens
      (set-face-attribute 'sp-pair-overlay-face nil
                          :foreground (face-foreground 'default)
                          :background (face-background 'default)))

    ;; Remove background so it doesn't look selected with region.
    ;; Make the foreground the same as `diredfl-flag-mark' (ie. orange).
    (with-eval-after-load 'diredfl
      (set-face-attribute 'diredfl-flag-mark-line nil
                          :foreground "orange"
                          :background nil))

    (with-eval-after-load 'dired-subtree
      (set-face-attribute 'dired-subtree-depth-1-face nil
                          :background nil)
      (set-face-attribute 'dired-subtree-depth-2-face nil
                          :background nil)
      (set-face-attribute 'dired-subtree-depth-3-face nil
                          :background nil)
      (set-face-attribute 'dired-subtree-depth-4-face nil
                          :background nil)
      (set-face-attribute 'dired-subtree-depth-5-face nil
                          :background nil)
      (set-face-attribute 'dired-subtree-depth-6-face nil
                          :background nil))

    ;; Trying out line underline (instead of wave).
    (mapatoms (lambda (atom)
                (let ((underline nil))
                  (when (and (facep atom)
                             (setq underline
                                   (face-attribute atom
                                                   :underline))
                             (eq (plist-get underline :style) 'wave))
                    (plist-put underline :style 'line)
                    (set-face-attribute atom nil
                                        :underline underline)))))))

;; Alternative theme
;; (load-theme 'basic)

(use-package moody
  :ensure t
  :config
  (setq x-underline-at-descent-line t)

  (setq-default mode-line-format
                '(" "
                  mode-line-front-space
                  mode-line-client
                  mode-line-frame-identification
                  mode-line-buffer-identification " " mode-line-position
                  (vc-mode vc-mode)
                  (multiple-cursors-mode mc/mode-line)
                  " " mode-line-modes
                  mode-line-end-spaces)))


(setq global-modxe-string (remove 'display-time-string global-mode-string))

(moody-replace-mode-line-buffer-identification)
(moody-replace-vc-mode)


(use-package hide-mode-line
  :ensure t
  :commands hide-mode-line-mode)

;; No toolbar please
(tool-bar-mode -1)

;; Transparent menu bar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; Show column number
(column-number-mode 1)

(use-package nyan-mode
  :ensure t
  :init
  (nyan-mode))


;; ANSI colors in command interaction and compile:
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Found these in one place
(setq ansi-color-names-vector
      ["black" "#dc322f" "#859900" "#b58900"
       "#268bd2" "#d33682" "#2aa198" "white"])
(ansi-color-map-update 'ansi-color-names-vector ansi-color-names-vector)
;; http://emacsworld.blogspot.com/2009/02/setting-term-mode-colours.html
(setq ansi-term-color-vector
      [unspecified "#000000" "#963F3C" "#859900" "#b58900"
                   "#0082FF" "#FF2180" "#57DCDB" "#FFFFFF"])
