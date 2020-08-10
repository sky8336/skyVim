/*
 * Filename: bad_style.cpp
 *
 * Copyright (C) 2018-2023 eric  <eric@company.com>. All Rights Reserved.
 *
 * History:
 *    2020/08/10 - [eric] Created file
 *
 * Maintainer: eric <eric@email.com>
 *    Created: 2020-08-10
 * LastChange: 2020-08-10
 *    Version: v0.0.01
 *
 */
#include <stdio.h>

class bad_style
{
public:
	bad_style ();
	virtual ~bad_style ();

 private:
};

/******************************************************************************
* Function:bad_style::bad_style
* Description:
* Where:
* Return:
* Error:
*****************************************************************************/
bad_style::bad_style(){

}

/******************************************************************************
* Function:bad_style::~bad_style
* Description:
* Where:
* Return:
* Error:
*****************************************************************************/
bad_style::~bad_style(){

}

int main(int argc, char *argv[])
{
    int i=5;
	int foo=1;
    char * name = "hello";

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
