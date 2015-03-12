;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_cpptemplates.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/03/05 07:55:56 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/12 15:31:36 by ngoguey          ###   ########.fr        ;
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

(defun function-c(ret-type)
  "function-c"
  (interactive "sInput return type:")
  (shell-command
   (concat
	(concat "php ~/configurations/function_minimum.php '" ret-type)
	"'")
   t)
  (move-end-of-line 1)
  (backward-char)
  (backward-char)  
  )

(global-set-key (kbd "<f3>") 'function-c)


(defun canonical-hpp ()
  "canonical-hpp"
  (interactive)
  (shell-command (concat "php ~/configurations/coplien_hpp.php " buffer-file-name) (current-buffer))
  (sit-for 0.1)
  (header-insert)
  (goto-line 27)
  (move-end-of-line 1)
  (backward-char)
  (backward-char)
  )

(global-set-key (kbd "<f10>") 'canonical-hpp)

(defun canonical-cpp ()
  "canonical-cpp"
  (interactive)
  (shell-command (concat "php ~/configurations/coplien_cpp.php " buffer-file-name) (current-buffer))
  (sit-for 0.1)
  (header-insert)
  (goto-line 33)
  (push-mark)
  (goto-line 40)
  )

(global-set-key (kbd "<f9>") 'canonical-cpp)

(defun main_minimum1()
  "main_minimum1"
  (interactive)
  (insert
   "int\t\t\t\t\t\t\tmain(int ac, char *av[])
{
\t
\t(void)ac;
\treturn (0);
}")
  (previous-line 3)
  (move-end-of-line 1)
  )

(global-set-key [f8] 'main_minimum1)

(defun main_minimum2()
  "main_minimum2"
  (interactive)
  (insert
   "int\t\t\t\t\t\t\tmain(void)
{
\t
\treturn (0);
}")
  (previous-line 2)
  (move-end-of-line 1)
  )

(global-set-key [(shift f8)] 'main_minimum2)
