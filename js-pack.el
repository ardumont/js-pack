;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

(require 'install-packages-pack)
(install-packages-pack/install-packs '(js2-mode
                                       flymake-jshint))

(require 'js2-mode)
(require 'flymake-jshint)

(add-hook 'js2-mode-hook 'flymake-jshint-load)

(provide 'js-pack)
;;; js-pack.el ends here
