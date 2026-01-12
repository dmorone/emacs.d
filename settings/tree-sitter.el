(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (commonlisp "https://github.com/tree-sitter-grammars/tree-sitter-commonlisp")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (c "https://github.com/tree-sitter/tree-sitter-c")
     (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (haskell "https://github.com/tree-sitter/tree-sitter-haskell")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (java "https://github.com/tree-sitter/tree-sitter-java")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (ocaml "https://github.com/tree-sitter/tree-sitter-ocaml")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
     (rust "https://github.com/tree-sitter/tree-sitter-rust")))

;; check for updates to the above repositories once per 6 months
(defun dm/update-tree-sitter ()
  "Run a specific command once every 30 days."
  (let ((last-run-file "~/.emacs.d/tree-sitter-last-update"))
    (if (file-exists-p last-run-file)
        (let ((last-run-date (with-temp-buffer
                               (insert-file-contents last-run-file)
                               (read (buffer-string)))))
          (if (> (- (float-time (current-time)) (float-time last-run-date)) (* 180 24 60 60))
              (progn
                (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
                (with-temp-buffer
                  (insert (format "%S" (current-time)))
                  (write-file last-run-file)))))
      (progn
        (with-temp-buffer
          (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
          (insert (format "%S" (current-time)))
          (write-file last-run-file))))))
  
(dm/update-tree-sitter)

(setq major-mode-remap-alist
 '((bash-mode . bash-ts-mode)
   (cmake-mode . cmake-ts-mode)
   (common-lisp-mode . common-lisp-ts-mode)
   (css-mode . css-ts-mode)
   (c-mode . c-ts-mode)
   (cpp-mode . cpp-ts-mode)
   (elisp-mode . elisp-ts-mode)
   (go-mode . go-ts-mode)
   (haskell-mode . haskell-ts-mode)
   (html-mode . html-ts-mode)
   (java-mode . java-ts-mode)
   (javascript-mode . javascript-ts-mode)
   (json-mode . json-ts-mode)
   (make-mode . make-ts-mode)
   (markdown-mode . markdown-ts-mode)
   (ocaml-mode . ocaml-ts-mode)
   (python-mode . python-ts-mode)
   (ruby-mode . ruby-ts-mode)
   (rust-mode . rust-ts-mode)))
