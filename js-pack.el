;;; js-pack.el --- Javascript configuration

;;; Commentary:

;;; Code:

;; other deps

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

(provide 'js-pack)
;;; js-pack.el ends here
