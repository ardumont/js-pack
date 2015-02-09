;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

(require 'install-packages-pack)
(install-packages-pack/install-packs '(js2-mode
                                       flycheck
                                       repl-toggle
                                       ;; nodejs-repl
                                       web-mode
                                       smartscan
                                       js2-refactor
                                       ;; skewer-mode
                                       ;; slime-js
                                       js-comint))

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

;;(skewer-setup)

(require 'repl-toggle)

;; (rtog/add-repl 'js2-mode 'skewer-repl)
;; (setq rtog/goto-buffer-fun 'pop-to-buffer)

;; swank-js/slime-js setup

;; pre-requisite: install `'npm install swank-js`'

;; (require 'slime-js)
;; (add-hook 'js2-mode-hook (lambda () (slime-js-minor-mode 1)))

;; Now go: M-x slime-connect RET localhost RET 4005 RET

;; (add-hook 'css-mode-hook
;;           (lambda ()
;;             (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
;;             (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

;; 
;; (setq inferior-js-program-command "node")

;;  Do: M-x run-js
;;  Away you go.

;; borrowed from @purcell - https://github.com/purcell/emacs.d/blob/master/lisp/init-javascript.el

(defvar inferior-js-minor-mode-map (let ((map (make-sparse-keymap)))
                                     (define-key map "\C-x\C-e" 'js-send-last-sexp)
                                     (define-key map "\C-\M-x"  'js-send-last-sexp-and-go)
                                     (define-key map "\C-cb"    'js-send-buffer)
                                     (define-key map "\C-c\C-b" 'js-send-buffer-and-go)
                                     (define-key map "\C-cl"    'js-load-file-and-go)
                                     map))

(define-minor-mode inferior-js-keys-mode
  "Bindings for communicating with an inferior js interpreter."
  :lighter " InfJS"
  :keymap inferior-js-minor-mode-map)

(dolist (hook '(js2-mode-hook js-mode-hook))
  (add-hook hook 'inferior-js-keys-mode))

(rtog/add-repl 'js2-mode 'run-js)
(setq rtog/goto-buffer-fun 'pop-to-buffer)

(provide 'js-pack)
;;; js-pack.el ends here
