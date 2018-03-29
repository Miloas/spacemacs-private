(defun spacemacs//rjsx-delete-creates-full-tag-with-insert (args)
  (interactive "p")
  (rjsx-delete-creates-full-tag args)
  (evil-insert args))

(defun spacemacs//setup-emmet-mode-for-react ()
  (emmet-mode 0)
  (setq-local emmet-expand-jsx-className? t))
