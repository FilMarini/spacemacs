;;; packages.el --- vhdl layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2020 Sylvain Benner & Contributors
;;
;; Author: Filippo Marini <filippo.marini@pd.infn.it>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `vhdl-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `vhdl/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `vhdl/pre-init-PACKAGE' and/or
;;   `vhdl/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst vhdl-packages
  '(sr-speedbar
    (vhdl-mode :location built-in)
    flycheck
    (lsp-vhdl :requires lsp-mode
              :location built-in)
    )
  "The list of Lisp packages required by the vhdl layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

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
                         ))))


(defun vhdl/init-lsp-vhdl ()
  (setq lsp-restart 'auto-restart)
  (use-package lsp-vhdl
     :defer t
     :after lsp-mode
     :init
     (setq lsp-vhdl-server 'ghdl-ls
           lsp-vhdl-server-path (executable-find "ghdl-ls")
           lsp-vhdl--params nil)
     )
  )




;;; packages.el ends here
