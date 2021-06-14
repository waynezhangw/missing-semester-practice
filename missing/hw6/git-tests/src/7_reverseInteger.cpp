#include<stdlib.h>
#include<string>
#include<iostream>
#include<stdio.h>
#include <sstream>
#include<cmath>
using namespace std;

#ifndef WIN32
     #define _atoi64(val)     strtoll(val, NULL, 10)
#endif


class Solution
{
public:
    int reverse(int x)
    {
        long long temp=10;
        if(x>0)
        {
            reversePositive(x,temp,1);
            return temp;
        }
        if(x<0)
        {
            x=x*-1;
            reversePositive(x,temp,-1);
            return (temp*-1);
        }
        if(x==0)
        {
            return 0;
        }
        return 0;

    }
    void reversePositive(int x,long long &temp,int ID)
    {
        stringstream stream;
        stream<<x;
        string caa=stream.str();
        cout<<caa<<endl;
        string caa2=caa;
        for(int i=caa.length()-1; i>=0; i--)
        {
            caa2[caa.length()-1-i]=caa[i];
        }
        cout<<caa2<<endl;
        stream.str("");
        const char* ch=caa2.c_str();
        temp=_atoi64(ch);
        if(ID==1&&temp>=pow(2,31))
        {
            temp=0;
        }
        if(ID==-1&&(temp*(-1))<pow(-2,31))
        {
            temp=0;
        }
    }
};

