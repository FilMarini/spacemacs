;;; packages.el --- vhdl layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
;;
;; Author: Filippo Marini <marinifil@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Code:

(defconst vhdl-packages
  '(sr-speedbar
    (vhdl-mode :location built-in)
    flycheck
    (lsp-vhdl :requires lsp-mode
              :location built-in)
    )
  "The list of Lisp packages required by the vhdl layer."

)

(defun vhdl/init-sr-speedbar ()
  (use-package sr-speedbar
    :defer t))

(defun vhdl/post-init-flycheck ()
  (spacemacs/enable-flycheck 'vhdl-mode))

(defun vhdl/init-vhdl-mode ()
  (use-package vhdl-mode
    :defer t
    :hook (vhdl-mode . (lambda ()
                         (lsp t)
                         (flycheck-mode t)
                         ))
    :config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'vhdl-mode
        ;; beautify
        "vv" 'vhdl-beautify-buffer ;; C-c C-b
        "vr" 'vhdl-beautify-region ;; C-c M-b
        ;; insert header/trailer
        "th" 'vhdl-template-header
        "tf" 'vhdl-template-footer
        ;; libraries
        "ls" 'vhdl-template-package-std-logic-1164
        "ln" 'vhdl-template-package-numeric-std
        "lm" 'vhdl-template-package-std-logic-misc
        "li" 'vhdl-template-package-std-logic-textio
        ;; port
        "pw" 'vhdl-port-copy
        "pi" 'vhdl-port-paste-instance
        "pc" 'vhdl-port-paste-component
        "pe" 'vhdl-port-paste-entity
        "ps" 'vhdl-port-paste-signals
        "pt" 'vhdl-port-paste-testbench
        ;; sensitivity list
        "u" 'vhdl-update-sensitivity-list-process
        ;; speedbar
        "so" 'sr-speedbar-open
        "sc" 'sr-speedbar-close
        )
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "mv" "vhdl-beautify")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "mt" "vhdl-templates")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "ml" "vhdl-libraries")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "mp" "vhdl-ports")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "ms" "speedbar")
      )))

(defun vhdl/init-lsp-vhdl ()
  (setq lsp-restart 'auto-restart)
  (use-package lsp-vhdl
     :defer t
     :after lsp-mode
     :init
     (setq lsp-vhdl-server 'ghdl-ls
           lsp-vhdl-server-path (executable-find "ghdl-ls")
           lsp-vhdl--params nil)))

;;; packages.el ends here
