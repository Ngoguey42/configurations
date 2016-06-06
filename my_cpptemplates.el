;;****************************************************************************;;
;;                                                                            ;;
;;                                                        :::      ::::::::   ;;
;;   my_cpptemplates.el                                 :+:      :+:    :+:   ;;
;;                                                    +:+ +:+         +:+     ;;
;;   By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+        ;;
;;                                                +#+#+#+#+#+   +#+           ;;
;;   Created: 2016/04/19 09:55:42 by ngoguey           #+#    #+#             ;;
;;   Updated: 2016/06/06 08:16:44 by ngoguey          ###   ########.fr       ;;
;;                                                                            ;;
;;****************************************************************************;;

(defvar phpBin "php")
;; (defvar phpBin "~/mamp/php/bin/php")
(defvar hpp_import_path (concat confPath "/php_snippets/hpp_import.php'"))

;; namespace
(global-set-key
 [(f4)]
 '(lambda(choice)
    "Namespace"
    (interactive "sNamespace: ")
    (shell-command
     (concat phpBin " " confPath "/php_snippets/namespace.php " choice)
     t)
    )
 )

;;HPP CPP file initialization
(defun canonical-hpp ()
  "canonical-hpp"
  (interactive)
  (shell-command (concat phpBin " "
                         confPath "/coplien_hpp.php"
                         " " buffer-file-name) (current-buffer))
  (sit-for 0.1)
  (header-insert)
  (goto-line 23)
  (beginning-of-line 1)
  )

(global-set-key
 (kbd "<f10>")
 '(lambda()
    "init hpp cpp file"
    (interactive)
    ;; (if (string= (file-name-extension (buffer-file-name)) "cpp")
    ;;   (canonical-cpp)
    (if (string= (file-name-extension (buffer-file-name)) "hpp")
        (canonical-hpp)
      )
    )
 )


;;MAIN MINIMUM AC AV
(defun main_minimum1()
  "main_minimum1"
  (interactive)
  (insert
   "int\t\t\t\t\tmain(int ac, char *av[])
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
   "int\t\t\t\t\tmain(void)
{
\t
\treturn (0);
}")
  (previous-line 2)
  (move-end-of-line 1)
  )
(global-set-key [(shift f8)] 'main_minimum2)
