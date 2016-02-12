# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    dump_sizeof.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ngoguey <ngoguey@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/10/11 16:35:06 by ngoguey           #+#    #+#              #
#    Updated: 2015/10/11 16:47:04 by ngoguey          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC=clang

printf "uname: "
uname
echo compiled with \'$CC\':
$CC -v
echo '
#include <stdio.h>
#include <stdint.h>
#  define PRINTSIZEOF(T) printf("sizeof(%20s) = %2dBytes (%3dbits) \n", #T, (int)sizeof(T), (int)sizeof(T) * 8)

int main()
{

PRINTSIZEOF(float);
PRINTSIZEOF(double);
PRINTSIZEOF(long double);
printf("\n");
PRINTSIZEOF(char);
PRINTSIZEOF(short);
PRINTSIZEOF(long);
PRINTSIZEOF(long long);
printf("\n");
PRINTSIZEOF(int);
PRINTSIZEOF(ssize_t);
PRINTSIZEOF(void*);
printf("\n");
PRINTSIZEOF(intmax_t);
PRINTSIZEOF(int8_t);
PRINTSIZEOF(int16_t);
PRINTSIZEOF(int32_t);
PRINTSIZEOF(int64_t);
return (0);
}
' > ~/.dump_sizeof.c
clang ~/.dump_sizeof.c -o ~/.dump_sizeof
~/.dump_sizeof
rm ~/.dump_sizeof
rm ~/.dump_sizeof.c
