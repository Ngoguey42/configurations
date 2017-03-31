;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   my_functions.el                                    :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2016/06/06 06:42:59 by ngoguey           #+#    #+#             ;;
;;   Updated: 2017/03/24 11:26:03 by ngoguey          ###   ########.fr       ;;
;;                                                                            ;;
;;****************************************************************************;;

(defun ft-indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region (point-min) (point-max) nil))
  )

(defun ft-swap-line-up ()
  "swap lines up"
  (interactive)
  (if (> (count-lines 1 (point)) 0)
      (let ((colnb (current-column)))
        (beginning-of-line)
        (kill-line)
        (delete-backward-char 1)
        (beginning-of-line)
        (newline)
        (backward-char)
        (yank)
        (move-to-column colnb)
        )
    )
  )

(defun ft-swap-line-down ()
  "swap lines down"
  (interactive)
  (if (> (count-lines (point) (point-max)) 0)
      (let ((colnb (current-column)))
        (end-of-line)
        (delete-forward-char 1)
        (kill-line)
        (beginning-of-line)
        (yank)
        (newline)
        (move-to-column colnb)
        )
    )
  )

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun ft-rename-file-and-buffer ()
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")

  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)))))
  )

;; ************************************************************************** **
;; PUT DEBUG **************************************************************** **
;; ************************************************************************** **

(defun read-extension-and-put-debug (lst)
    (previous-line)
    (move-end-of-line 1)
    (newline)
    (let ((suffix (file-name-extension (buffer-file-name))))
      (let ((args (cdr (assoc suffix lst))))
        (insert (car args))
        (indent-according-to-mode)
        (dotimes (_ (car (cdr args))) (backward-char))
      ))
    )

(setq put-debug1-assoc
      '(("cpp" . ("std::cout <<  << std::endl;" 14))
        ("hpp" . ("std::cout <<  << std::endl;" 14))
        ("tpp" . ("std::cout <<  << std::endl;" 14))
        ("php" . ("var_dump();" 2))
        ("c" . ("printf(\"\\n\");" 5))
        ("inl" . ("printf(\"\\n\");" 5))
        ("lua" . ("print();" 2))
        ("ml" . ("Printf.eprintf \"\\n%!\";" 6))
        ("py" . ("print(\"\" % ())" 7))
        ))

(defun ft-put-debug1 ()
  "put debug 1" (interactive) (read-extension-and-put-debug put-debug1-assoc))

;; ************************************************************************** **
;; COMMENTS FORMATING ******************************************************* **
;; ************************************************************************** **

(defun ft-toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position))
  )


(defun ft-star-to-80 ()
  "pad with stars to column 80" (interactive)
  (move-end-of-line 1)
  (let ((to80 (- 80 (current-column))))
    ;; (if (< to80 78)
        (insert (make-string (- to80 3) ?*) " **")
        ;; )
  )
  )
