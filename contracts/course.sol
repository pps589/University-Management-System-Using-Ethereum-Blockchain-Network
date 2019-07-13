pragma solidity ^0.5.0;

contract course
{

    struct courseInfo 
    {
        string name;
        uint256 department;
        uint256 pid;
        uint256 sem;
    }
    uint256 cid=0;
    mapping(uint256 => courseInfo) courses;
    uint256[] public courseIds;

    function registerCourse(string memory name, uint256 department,uint256 pid,uint256 sem) public  returns(int)   
                             {
                                    cid=cid+1;
                                    courseInfo storage newCourse = courses[cid];
                                    newCourse.name =name;
                                    newCourse.department=department;
                                    newCourse.pid=pid;
                                    newCourse.sem=sem;
                                    courseIds.push(cid);
                                    return 1;
                             }

    function getCourse(uint256 mid) public view returns (string memory, uint256)
    {
        courseInfo storage c = courses[mid];
        return (c.name,c.department);
    }
    function getname(uint256 mid) public view returns (string memory)
    {
        courseInfo storage c=courses[mid];
        return c.name;
    }
    function getdepartment(uint256 mid) public view returns (uint256)
    {
        courseInfo storage c=courses[mid];
        return c.department;
    }
  
}