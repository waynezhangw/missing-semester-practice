#include<iostream>
#include<stdlib.h>
#include<limits.h>
using namespace std;
class Solution {
public:
    bool isPalindrome(int x) {
    	bool P=false;
    	int temp=x;
        if(x<0)
        {
        	return P;
        }
        if(x>=0&&x<INT_MAX)
        {
        	int push=0;
        	int rev=0;
        	while(x!=0)
        	{
        		push=x%10;
        		x=x/10;
        		rev=rev*10+push;
        	}
        	if(rev==temp)
        	{
        		P=true;
        		return P;
        	}
        }
        return P;
    }
};
int main()
{
	Solution caa;
	cout<<caa.isPalindrome(101010)<<endl;
	system("pause");
	return 0;
}
// there is a test comment
