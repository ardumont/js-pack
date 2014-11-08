;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

(require 'install-packages-pack)
(install-packages-pack/install-packs '(js2-mode
                                       flymake-jshint
                                       repl-toggle
                                       nodejs-repl))

(require 'js2-mode)
(require 'flymake-jshint)

(add-hook 'js2-mode-hook 'flymake-jshint-load)j

(require 'nodejs-repl)
(require 'repl-toggle)

(rtog/add-repl 'js2mode 'nodejs-repl)
(setq rtog/goto-buffer-fun 'pop-to-buffer)

(provide 'js-pack)
;;; js-pack.el ends here
