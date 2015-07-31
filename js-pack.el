;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

;; slime deps

;; when using the source git repository with the right slime version
(add-to-list 'load-path "../slime")
(require 'slime-autoloads)
(setq slime-contribs '(slime-fancy))

(require 'slime)
(slime-setup '(slime-js slime-repl))

(setq inferior-lisp-program "sbcl")
(setq slime-net-coding-system 'utf-8-unix)

;; other deps

(require 'install-packages-pack)
(install-packages-pack/install-packs '(js2-mode
                                       flycheck
                                       repl-toggle
                                       ;; nodejs-repl
                                       web-mode
                                       smartscan
                                       js2-refactor
                                       ;; skewer-mode
                                       slime-js))

(use-package smartscan)
(use-package flycheck)

(defun js-pack/hook ()
  "Default js hook function."
  (interactive)
  (smartscan-mode 1))

(use-package js2-mode
  :config
  (add-hook 'js2-mode-hook 'flycheck-mode)
  (add-hook 'js2-mode-hook 'js-pack/hook))

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.html" . web-mode))
  (add-hook 'web-mode-hook 'js-pack/hook))



(use-package js2-refactor
  :config
  (js2r-add-keybindings-with-prefix "C-c C-j"))

(use-package repl-toggle
  :config
  (custom-set-variables '(rtog/goto-buffer-fun 'pop-to-buffer)))

;; (use-package :skewer
;;   :config
;;   (skewer-setup)
;;   (rtog/add-repl 'js2-mode 'skewer-repl))

;; swank-js/slime-js setup

;; pre-requisite: install `'npm install swank-js`'

(require 'slime-js)
(add-hook 'js2-mode-hook (lambda () (slime-js-minor-mode 1)))

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map (kbd "C-M-x") 'slime-js-refresh-css)
            (define-key css-mode-map (kbd "C-c C-c") 'slime-js-refresh-css)))

;; Now go: M-x slime-connect RET localhost RET 4005 RET

;; I inject inside the `'slime-js namespace`'
(defun slime-js-kill-interactive-buffer ()
  "Clean/Kill buffer relative to slime/swank js."
  (interactive)
  (mapc #' kill-buffer '("*swank-js*" "*slime-events*" "*slime-repl JS*")))

;; retrieved magnar's previous setup
(use-package setup-slime-js
  :load-path "./setup-slime-js"
  :config
  ;; Overwrite some some default from setup-slime-js
  (custom-set-variables '(slime-js-swank-command "npm")
                        '(slime-js-swank-args '("run" "swank")) ;; I run swank with npm from the current project
                        '(slime-js-browser-command "firefox"))

  (add-hook 'slime-js-minor-mode-hook (lambda ()
                                        (define-key slime-js-minor-mode-map (kbd "C-c M-j") 'slime-js-jack-in-node)
                                        (define-key slime-js-minor-mode-map (kbd "C-c M-b") 'slime-js-jack-in-browser)
                                        (define-key slime-js-minor-mode-map (kbd "C-c M-k") 'slime-js-kill-interactive-buffer)
                                        (define-key slime-js-minor-mode-map (kbd "C-c r") 'slime-js-reload))))

(provide 'js-pack)
;;; js-pack.el ends here
