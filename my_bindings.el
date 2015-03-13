;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_bindings.el                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/02/12 07:41:24 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/13 08:38:28 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

(global-set-key (kbd "DEL") 'backward-delete-char)
(setq-default c-backspace-function 'backward-delete-char)

(defun toggle-comment-on-line ()
  "comment or uncomment current line"
  (interactive)
  (comment-or-uncomment-region (line-beginning-position) (line-end-position)))


(global-set-key (kbd "<kp-7>") "\C-a\C- \C-n\M-w\C-y\C-p")
(global-set-key (kbd "<kp-8>") 'replace-string)
(global-set-key (kbd "<kp-9>") 'goto-line)

(global-set-key (kbd "<kp-1>") "\C-a\C-k\177\C-a\C-n")
(global-set-key (kbd "<kp-4>") "\C-y")
(global-set-key (kbd "<kp-0>") "\C-a\C-m\C-b\C-y\C-a")
(global-set-key (kbd "<kp-5>") 'yank-pop)

(global-set-key (kbd "<kp-3>") 'toggle-comment-on-line)
(global-set-key (kbd "<kp-6>") 'comment-or-uncomment-region)
(global-set-key (kbd "<kp-5>") "\M-;")


(global-set-key (kbd "<kp-add>") 'forward-paragraph)
(global-set-key (kbd "<kp-subtract>") 'backward-paragraph)
(global-set-key (kbd "<kp-enter>") "\C-m")

(defun indent-buffer ()
  (interactive)
  (save-excursion
	(indent-region (point-min) (point-max) nil)))

(global-set-key (kbd "<kp-divide>") 'indent-buffer)


(global-set-key [(control t)]
				(lambda()
				  "swap lines up"
				  (interactive)
				  (setq colnb (current-column))
				  (beginning-of-line)
				  (kill-line)
				  (delete-backward-char 1)
				  (beginning-of-line)
				  (newline)
				  (backward-char)
				  (yank)
				  (beginning-of-line)
				  (forward-char colnb)
				  ))

(global-set-key [(control ^)]
				(lambda()
				  "swap lines down"
				  (interactive)
				  (setq colnb (current-column))
				  (beginning-of-line)
				  (kill-line)
				  (delete-backward-char 1)
				  (next-line)
				  (next-line)
				  (beginning-of-line)
				  (newline)
				  (previous-line)
				  (yank)
				  (beginning-of-line)
				  (forward-char colnb)
				  ))
