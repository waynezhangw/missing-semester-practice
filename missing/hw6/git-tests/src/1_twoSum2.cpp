//这是一个改进版的求两数和位置的方法，用到了C++的map
#include<vector>
#include<map>
using namespace std;
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        for(unsigned int i=0;i<nums.size();i++){
            storeMap[nums[i]]=i;
        }
        map<int, int>::iterator iter;
        for(unsigned int i=0;i<nums.size();i++){
            int temp=target-nums[i];            
            iter=storeMap.find(temp);
            if(iter!=storeMap.end()&&iter->second!=i){
                two.push_back(i);
                two.push_back(iter->second);
                showResults(two);
                return two;
            }
        }
    }
    void showResults(vector<int>& pos){
        cout<<"This is the final verdict: "<<"["<<pos[0]<<","<<pos[1]<<"]";
    }
    
private:
    vector<int> two;
    map<int,int> storeMap;     //牺牲空间换取时间，先把他按照索引值和数据存起来
};
