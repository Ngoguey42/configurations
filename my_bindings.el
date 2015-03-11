;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_bindings.el                                     :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/02/12 07:41:24 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/11 15:53:12 by ngoguey          ###   ########.fr        ;
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
