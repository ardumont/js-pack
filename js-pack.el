;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

(require 'install-packages-pack)
(install-packages-pack/install-packs '(js2-mode
                                       flycheck
                                       repl-toggle
                                       nodejs-repl
                                       web-mode
                                       smartscan))

(require 'js2-mode)

(require 'flycheck)
(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'nodejs-repl)
(require 'repl-toggle)

(rtog/add-repl 'js2-mode 'nodejs-repl)
(setq rtog/goto-buffer-fun 'pop-to-buffer)

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

(provide 'js-pack)
;;; js-pack.el ends here
