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
    vhdl-ext
    )
  "The list of Lisp packages required by the vhdl layer."

)

(defun vhdl/init-sr-speedbar ()
  (use-package sr-speedbar
    :defer t
    ))

(defun vhdl/post-init-flycheck ()
  (with-eval-after-load 'lsp-vhdl
     (if (file-exists-p (concat (lsp-workspace-root) "/hdl-prj.json"))
         (spacemacs/enable-flycheck 'vhdl-mode)
    )
  )
)

(defun vhdl/init-vhdl-mode ()
  (use-package vhdl-mode
    :defer t
    :hook (vhdl-mode . (lambda ()
                         (lsp t)
                         ))
    :config
    (setq vhdl-speedbar-display-mode 'project
          vhdl-project-alist nil
          )
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
        "bo" 'sr-speedbar-open
        "bc" 'sr-speedbar-close
        ;; generate support files
        "f" 'vhdl-set-prj-file
        )
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "mv" "vhdl-beautify")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "mt" "vhdl-templates")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "ml" "vhdl-libraries")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "mp" "vhdl-ports")
      (spacemacs/declare-prefix-for-mode 'vhdl-mode "ms" "speedbar")
      )))

(defun vhdl/init-lsp-vhdl ()
  (use-package lsp-vhdl
     :defer t
     :after lsp-mode
     )
  )

(defun vhdl/init-vhdl-ext ()
  (use-package vhdl-ext
    :after vhdl-mode
    :demand
    :hook ((vhdl-mode . vhdl-ext-mode))
    :init
    ;; Can also be set through `M-x RET customize-group RET vhdl-ext':
    ;;  - Vhdl Ext Feature List (provides info of different features)
    ;; Comment out/remove the ones you do not need
    (setq vhdl-ext-feature-list
          '(
            lsp
            flycheck
            navigation
            hierarchy
            beautify
            ports))
    :config
    (vhdl-ext-mode-setup)
    (vhdl-ext-lsp-set-server 've-ghdl-ls)
    (setq vhdl-ext-hierarchy-backend 'builtin)
    ;; (remove-hook 'ag-search-finished-hook #'vhdl-ext-navigation-ag-rg-hook)
    )
  )




;;; packages.el ends here
