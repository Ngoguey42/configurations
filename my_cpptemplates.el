;******************************************************************************;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    my_cpptemplates.el                                 :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2015/03/05 07:55:56 by ngoguey           #+#    #+#              ;
;    Updated: 2015/03/31 07:17:04 by ngoguey          ###   ########.fr        ;
;                                                                              ;
;******************************************************************************;



;; Statics f1
(global-set-key [(f1)]
				'(lambda()
				   "Statics"
				   (interactive)
				   (shell-command
					(concat "~/php ~/configurations/php_snippets/hpp_import.php '"
							(buffer-file-name)
							"' '' 'statics'"
							)
					t)
				   )
				)


(global-set-key [(f5)]
				'(lambda(choice)
				   "Class importation"
				   (interactive "n(1)Stic (2)Ctor (3)Ope (4)Get (5)Set (6)Memb (7)Met (8)Pur (9)Init-l : ")
				   (if (= choice 1)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "statics" "'") t)
					 )
				   (if (= choice 2)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "constructors" "'") t)
					 )
				   (if (= choice 3)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "operators" "'") t)
					 )
				   (if (= choice 4)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "getters" "'") t)
					 )
				   (if (= choice 5)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "setters" "'") t)
					 )
				   (if (= choice 6)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "member_functions" "'") t)
					 )
				   (if (= choice 7)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "methods" "'") t)
					 )
				   (if (= choice 8)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "pure_methods" "'") t)
					 )
				   (if (= choice 9)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '' '" "init_list" "'") t)
					 )
				   )
				)




(global-set-key [(shift f5)]
				'(lambda(hppfilename choice)
				   "Query specific file for class importation"
				   (interactive (list (read-file-name "Hpp file: ")
									  (read-number "(1)Stic (2)Ctor (3)Ope (4)Get (5)Set (6)Memb (7)Met (8)Pur (9)Init-l: ")
									  ))
				   
				   
				   (if (= choice 1)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' '" hppfilename "' '" "statics" "'") t)
					 )
				   (if (= choice 2)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "constructors" "'") t)
					 )
				   (if (= choice 3)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "operators" "'") t)
					 )
				   (if (= choice 4)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "getters" "'") t)
					 )
				   (if (= choice 5)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "setters" "'") t)
					 )
				   (if (= choice 6)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "member_functions" "'") t)
					 )
				   (if (= choice 7)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "methods" "'") t)
					 )
				   (if (= choice 8)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "pure_methods" "'") t)
					 )
				   (if (= choice 9)
					   (shell-command
						(concat "~/php "
								"~/configurations/php_snippets/hpp_import.php"
								" '"
								(buffer-file-name) "' " hppfilename " '" "init_list" "'") t)
					 )
					 )
				   )








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


;;HPP CPP file initialization
(defun canonical-hpp ()
  "canonical-hpp"
  (interactive)
  (shell-command (concat "~/php ~/configurations/coplien_hpp.php " buffer-file-name) (current-buffer))
  (sit-for 0.1)
  (header-insert)
  (goto-line 23)
  (beginning-of-line 1)
  )
(defun canonical-cpp ()
  "canonical-cpp"
  (interactive)
  (shell-command (concat "~/php ~/configurations/coplien_cpp.php " buffer-file-name) (current-buffer))
  (sit-for 0.1)
  (header-insert)
  (goto-line 17)
  (move-end-of-line 1)
  )

(global-set-key (kbd "<f10>")
				'(lambda()
				   "init hpp cpp file"
				   (interactive)
				   (if (string= (file-name-extension (buffer-file-name)) "cpp")
					   (canonical-cpp)
					 (if (string= (file-name-extension (buffer-file-name)) "hpp")
						 (canonical-hpp)
					   ))
				   )
				)


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

;;MINIMAL FUNCTION / VARIABLE
(defun function-c(arg)
  "function-c2"
  (interactive "*")
  (shell-command
   (concat
	(concat "~/php ~/configurations/function_minimum.php '" arg)
	"'")
   t)
  (move-end-of-line 1)
  (backward-char)
  (backward-char)  
  )
(defun variable_hpp(arg)
  "new variable"
  (interactive "*")
  (shell-command
   (concat
	"~/php ~/configurations/new_var.php "
	buffer-file-name
	" "
	(number-to-string (current-column))
	" '"
	arg
	"'")
   t
   )
  (end-of-line)
  (backward-char)
  )

(global-set-key (kbd "<f9>")
				'(lambda(arg)
				   "minimal hpp/cpp variabl/function"
				   (interactive "sInput variable/return type:")
				   (if (string= (file-name-extension (buffer-file-name)) "cpp")
					   (function-c arg)
					 (if (string= (file-name-extension (buffer-file-name)) "hpp")
						 (variable_hpp arg)
					   (if (string= (file-name-extension (buffer-file-name)) "c")
						   (function-c arg)
						 (if (string= (file-name-extension (buffer-file-name)) "h")
							 (variable_hpp arg)
						   ))))
				   )
				)


(global-set-key [(f3)]
				'(lambda(choice)
				   "Spacersn"
				   (interactive "n(1)all (2)Stic (3)Nest (4)CDtor (5)Ope (6)GSet (7)Funcs (8)Att: ")
				   (if (= choice 1)
					   (insert "// * STATICS ******************** //
\t// * NESTED CLASSES ************* //
\t// * CTORS / DTORS ************** //
\t// * OPERATORS ****************** //
\t// * GETTERS / SETTERS ********** //
\t// * MEMBER FUNCTIONS / METHODS * //
\t// * ATTRIBUTES ***************** //
")
					 )
				   (if (= choice 2) (insert "// * STATICS ******************** //"))
				   (if (= choice 3) (insert "// * NESTED CLASSES ************* //"))
				   (if (= choice 4) (insert "// * CTORS / DTORS ************** //"))
				   (if (= choice 5) (insert "// * OPERATORS ****************** //"))
				   (if (= choice 6) (insert "// * GETTERS / SETTERS ********** //"))
				   (if (= choice 7) (insert "// * MEMBER FUNCTIONS / METHODS * //"))
				   (if (= choice 8) (insert "// * ATTRIBUTES ***************** //"))
				   )
				)

