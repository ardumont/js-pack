;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

(require 'install-packages-pack)
(install-packs '(js2-mode
                 flymake-jslint))

(require 'js2-mode)
(require 'flymake-jslint)

(add-hook 'js2-mode-hook 'flymake-jslint-load)

(provide 'js-pack)
;;; js-pack.el ends here
