/*
 * multiplecursors.c
 *
 * Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
 *
 * History:
 *    2019/08/09 - [Eric MA] Created file
 *
 * Maintainer: you <your@email.com>
 *    Created: 2019-08-09
 * LastChange: 2019-08-09
 *    Version: v0.0.01
 *
 */
#include <stdio.h>
int main(int argc, char *argv[])
{
	int sum = 0;
	int old_num = 1;

	while (sum < 100) {
		sum += old_num;
		old_num++;
	}

	printf("sum=%d, old_num=%d\n", sum, old_num);
	return 0;
}

