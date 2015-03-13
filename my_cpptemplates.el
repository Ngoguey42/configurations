;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_cpptemplates.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/03/05 07:55:56 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/13 07:49:07 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;

;;MULTIPLE LANGUAGES DEBUG
(defun cpp-debug-func()
  "cpp-debug-func"
  (interactive)
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
(defun php-debug-func()
  "php-debug-func"
  (interactive)
  (insert
   "var_dump();")
  (indent-according-to-mode)
  (backward-char)
  (backward-char)
  )
(defun c-debug-func()
  "c-debug-func"
  (interactive)
  (insert
   "qprintf(\"\\n\");")
  (indent-according-to-mode)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  (backward-char)
  )

(global-set-key (kbd "<f1>")
				'(lambda()
				   "global-debug-func-func"
				   (interactive)
				   (previous-line)
				   (move-end-of-line 1)
				   (newline)
				   (if (string= (file-name-extension (buffer-file-name)) "cpp")
					   (cpp-debug-func)
					 (if (string= (file-name-extension (buffer-file-name)) "php")
						 (php-debug-func)
					   (if (string= (file-name-extension (buffer-file-name)) "c")
						   (c-debug-func)
						 )))
				   )
				)

;;MINIMAL FUNCTION C
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

;;CANONICAL HPP
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

;;CANONICAL CPP
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

;;MAIN MINIMUM AC AV
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

;;MAIN MINIMUM VOID
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
