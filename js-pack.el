;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

(require 'install-packages-pack)
(install-packages-pack/install-packs '(js2-mode
                                       flycheck
                                       repl-toggle
                                       nodejs-repl
                                       web-mode))

(require 'js2-mode)

(require 'flycheck)
(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'nodejs-repl)
(require 'repl-toggle)

(rtog/add-repl 'js2-mode 'nodejs-repl)
(setq rtog/goto-buffer-fun 'pop-to-buffer)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html" . web-mode))

(provide 'js-pack)
;;; js-pack.el ends here
