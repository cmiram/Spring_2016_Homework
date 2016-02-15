def wordCount(str):
    return [str.count("\n"), len(str.split()), len(str)];

temp = wordCount("The quick brown fox jumped over the lazy dog.\n");
print(temp);

def mycount(str):
    mycount = [str.count(char) for char in str if char.isdigit()];
    return [mycount, str.count(' '), len(str) - len(mycount) - str.count(' ')];

temp = mycount("0123456789 \t\n");
print(temp);

def sum3(nums):
  return sum(nums);
  
def rotate_left3(nums):
  return [nums[1], nums[2], nums[0]];
  
def max_end3(nums):
  return [nums[0], nums[0], nums[0]] if nums[0] > nums[2] else [nums[2], nums[2], nums[2]];
  
def make_ends(nums):
  return [nums[0], nums[len(nums)-1]];
  
def has23(nums):
  return 2 in nums or 3 in nums;
  
def count_evens(nums):
  return len(nums) - sum(num%2 for num in nums);
  
def sum13(nums):
  sum = 0;
  i = 0;
  while i < len(nums):
    if nums[i] == 13:
      i = i + 2;
    else:
      sum = sum + nums[i];
      i = i + 1;
  else:
    return sum;
    
def big_diff(nums):
  return max(nums) - min(nums);
  
def sum67(nums):
  sum = 0;
  passed6 = 0;
  for x in nums:
    if x == 6:
      passed6 = 1;
    else:
      if passed6:
        passed6 = not x==7;
      else:
        sum = sum + x;
  return sum;
  
def centered_average(nums):
  return (sum(nums) - max(nums) - min(nums)) / (len(nums) - 2);
  
def has22(nums):
  i = 0;
  while i<len(nums)-1:
    if nums[i] == nums[i+1] == 2:
      return bool(1);
    else:
      i = i+1;
  else:
    return bool(0);
    
def extra_end(str):
  return 3*str[-2:];
  
def without_end(str):
  return str[1:len(str)-1];
  
def double_char(str):
  return ''.join([2*ch for ch in str]);
  
def count_code(str):
  count = 0;
  for i in range(len(str)-3):
    if str[i:i+2] == "co" and str[i+3] == "e":
      count = count + 1;
  return count;
  
def count_hi(str):
  return str.count("hi");
  
def end_other(a, b):
  return a[-len(b):].lower() == b.lower() if len(a) > len(b) else b[-len(a):].lower() == a.lower();
  
def end_other(a, b):
  return a[-len(b):].lower() == b.lower() if len(a) > len(b) else b[-len(a):].lower() == a.lower();
  
def xyz_there(str):
  return str.count("xyz") > str.count(".xyz");