;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_cpptemplates.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/03/05 07:55:56 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/11 15:15:06 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

(defun stdcout-hpp()
  "stdcout-hpp"
  (interactive)
  (previous-line)
  (move-end-of-line 1)
  (newline)
  (insert
   "std::cout <<  << std::endl;")
  (indent-according-to-mode)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  )

(global-set-key (kbd "<f1>") 'stdcout-hpp)


(defun canonical-hpp (classname)
  "tester"
  (interactive "sEnter class' name: ")
  (shell-command (concat "php ~/configurations/coplien_hpp.php " classname) (current-buffer))
  (sit-for 0.1)
  (header-insert)
  (goto-line 21)
  (move-end-of-line 1)
  (backward-char)
  (backward-char)
  )

(global-set-key (kbd "<f10>") 'canonical-hpp)
