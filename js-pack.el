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

(require 'js2-mode)

(require 'flycheck)
(add-hook 'js2-mode-hook 'flycheck-mode)

;; (require 'nodejs-repl)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html" . web-mode))

(require 'smartscan)

(defun js-pack/hook ()
  "Default js hook function."
  (interactive)
  ;; (setq-local indent-tabs-mode t)
  ;; (setq-local tab-width 4)
  (smartscan-mode 1))

;; (setq js2-mode-hook '(flycheck-mode #[nil "\300\301!\207" [run-hooks prelude-js-mode-hook] 2] er/add-js2-mode-expansions er/add-js-mode-expansions))
;; (setq web-mode-hook '(er/add-web-mode-expansions er/add-html-mode-expansions))

(add-hook 'js2-mode-hook 'js-pack/hook)
(add-hook 'web-mode-hook 'js-pack/hook)

(require 'js2-refactor)

(js2r-add-keybindings-with-prefix "C-c C-j")

(require 'repl-toggle)

;; (require 'skewer)
;; (skewer-setup)

;; (rtog/add-repl 'js2-mode 'skewer-repl)
(setq rtog/goto-buffer-fun 'pop-to-buffer)

;; swank-js/slime-js setup

;; pre-requisite: install `'npm install swank-js`'

(require 'slime-js)
(add-hook 'js2-mode-hook (lambda () (slime-js-minor-mode 1)))

(add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map (kbd "C-M-x") 'slime-js-refresh-css)
            (define-key css-mode-map (kbd "C-c C-c") 'slime-js-refresh-css)))

;; Now go: M-x slime-connect RET localhost RET 4005 RET

;; retrieved magnar's previous setup
(load "./setup-slime-js.el")
(require 'setup-slime-js)

;; Overwrite some some default from setup-slime-js
(setq slime-js-swank-command "npm")
(setq slime-js-swank-args '("run" "swank")) ;; I run swank with npm from the current project
(setq slime-js-browser-command "firefox")

(defun js-pack/kill-interactive-buffer ()
  "Clean/Kill buffer relative to slime/swank js."
  (interactive)
  (mapc #' kill-buffer '("*swank-js*" "*slime-events*" "*slime-repl JS*")))

(add-hook 'slime-minor-mode-hook (lambda ()
                                   (define-key slime-js-minor-mode-map (kbd "C-c M-j") 'slime-js-jack-in-node)
                                   (define-key slime-js-minor-mode-map (kbd "C-c M-b") 'slime-js-jack-in-browser)
                                   (define-key slime-js-minor-mode-map (kbd "C-c M-k") 'js-pack/kill-interactive-buffer)
                                   (define-key slime-js-minor-mode-map (kbd "C-c r") 'slime-js-reload)))

(provide 'js-pack)
;;; js-pack.el ends here
