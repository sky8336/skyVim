/*
 * Filename: bad_style.c
 *
 * Copyright (C) 2018-2023 eric  <eric@company.com>. All Rights Reserved.
 *
 * History:
 *    2019/11/22 - [eric] Created file
 *
 * Maintainer: eric <eric@email.com>
 *    Created: 2019-11-22
 * LastChange: 2020-08-11
 *    Version: v0.0.3
 *
 */
#include <stdio.h>

int main(int argc, char *argv[])
{
    int i=5;
	int foo=1;
    char * name = "hello";
	CMsgQueuePtr   message_ptr_;

    if(i==5)
	{
        printf("%s\n",name);
    }

	switch(foo)
	{
		case 1:
			a += 1;
			break;

		case 2:
			{
				a += 2;
				break;
			}
	}

    return 0;
}
