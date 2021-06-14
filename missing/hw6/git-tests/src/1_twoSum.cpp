#include<vector>
using namespace std;
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        for(unsigned int i=0;i<nums.size();i++){
        	for(unsigned int j=i+1;j<nums.size();j++){
        		if(nums[i]+nums[j]==target){
        			two.push_back(i);
        			two.push_back(j);
                    showResults(two);
        			return two;
        		}
        	}
        }      
    }
    void showResults(vector<int>& pos){
        cout<<"This is final verdict: "<<"["<<pos[0]<<","<<pos[1]<<"]";
    }
    
private:
    vector<int> two;
};
