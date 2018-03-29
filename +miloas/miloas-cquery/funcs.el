;; >>> Lifted from MaskRay's cquery layer
(require 'cl-lib)
(require 'subr-x)

(defun miloas-cquery//enable ()
  (condition-case nil
      (lsp-cquery-enable)
    (user-error nil)))


(defun miloas-cquery/customise-lsp-ui-peek ()
    (defun text-document/type-definition () (interactive) (lsp-ui-peek-find-custom 'type "textDocument/typeDefinition"))
    (defun miloas-cquery/base () (interactive) (lsp-ui-peek-find-custom 'base "$miloas-cquery/base"))
    (defun miloas-cquery/callers () (interactive) (lsp-ui-peek-find-custom 'callers "$miloas-cquery/callers"))
    (defun miloas-cquery/derived () (interactive) (lsp-ui-peek-find-custom 'derived "$miloas-cquery/derived"))
    (defun miloas-cquery/vars () (interactive) (lsp-ui-peek-find-custom 'vars "$miloas-cquery/vars"))
    (defun miloas-cquery/random () (interactive) (lsp-ui-peek-find-custom 'random "$miloas-cquery/random"))

    (defun miloas-cquery/references-address ()
      (interactive)
      (lsp-ui-peek-find-custom
       'address "textDocument/references"
       (plist-put (lsp--text-document-position-params) :context
                  '(:role 128))))

    (defun miloas-cquery/references-read ()
      (interactive)
      (lsp-ui-peek-find-custom
       'read "textDocument/references"
       (plist-put (lsp--text-document-position-params) :context
                  '(:role 8))))

    (defun miloas-cquery/references-write ()
      (interactive)
      (lsp-ui-peek-find-custom
       'write "textDocument/references"
       (plist-put (lsp--text-document-position-params) :context
                  '(:role 16))))

  )

(defun miloas-cquery/define-keys-for-mode (mode)
  "Define key bindings for the specific MODE."

  ;; lsp layer uses =,l,t,r as prefixes for format, lsp, toggle and refactor -- extend these
  (spacemacs/declare-prefix-for-mode mode "mh" "heirarchy")
  (spacemacs/set-leader-keys-for-major-mode mode
    ;; heirarchy
    "hb" #'miloas-cquery/base
    "hd" #'miloas-cquery/derived
    "hc" #'cquery-call-hierarchy
    "hC" (lambda () (interactive) (cquery-call-hierarchy t))
    "hi" #'cquery-inheritance-hierarchy
    "hI" (lambda () (interactive) (cquery-inheritance-hierarchy t))
    "hm" #'cquery-member-hierarchy
    "hM" (lambda () (interactive) (cquery-member-hierarchy t))
    ;; lsp/peek
    "lA" #'miloas-cquery/references-address
    "lR" #'miloas-cquery/references-read
    "lW" #'miloas-cquery/references-write
    "lc" #'miloas-cquery/callers
    "lt" #'text-document/type-definition
    "lv" #'miloas-cquery/vars
    )
  )
