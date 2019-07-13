pragma solidity ^0.5.0;

contract student{

struct studentInfo {
    string name;
    string birthdate;
    string department;
    string location;
    string email;
    uint256 mobile_no;
    string password;
    string pid;
}
uint256 id=0;
mapping(uint256 => studentInfo) students;
uint256[] public studentIds;

    function registerStudent(string memory name, string memory birthdate, string memory department, 
                             string memory location, string memory email, uint256 mobile_no, string memory password,string memory pid) public  returns(int) {
            
            
                 id=id+1;
                 studentInfo storage newStudent = students[id];
                 newStudent.name = name;
                 newStudent.birthdate = birthdate;
                 newStudent.department = department;
                 newStudent.location = location;
                 newStudent.email = email;
                 newStudent.mobile_no = mobile_no;
                 newStudent.password=password;
                 newStudent.pid=pid;
                 studentIds.push(id);
                 return 1;
            }
            
            
        
    function getStudent(uint256 mid) public view returns (string memory, string memory, string memory, 
                                                    string memory, string memory, uint256,string memory){
        studentInfo storage s = students[mid];
        return (s.name,s.birthdate,s.department,s.location,s.email,s.mobile_no,s.pid);
    }
    function getCount() public view returns (uint256)
    {
        return id;
    }
    function validateStudent(string memory email,string memory password) public view returns (uint256 )
    {
        uint256 mid=0;
        uint256 n=id;
        for(uint256 i=1;i<=n;i++)
        {
            studentInfo storage s=students[i];
            string memory chck_email=s.email;
            string memory passkey=s.password;
            if((comparestring(chck_email,email)) && (comparestring(passkey,password)))
            {
                mid=id;
                break;
            }
        }
        return mid;
    }
    function comparestring(string memory a , string memory b) public view returns(bool)
    {
           return (keccak256(abi.encodePacked(a))==keccak256(abi.encodePacked(b)));

    }
    function getname(uint256 mid) public view returns(string memory)
    {
                studentInfo storage s = students[mid];
            return s.name;
    }
}
    
