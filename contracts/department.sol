pragma solidity ^0.5.0;

contract department
{

    struct Departmentinfo 
    {
        string Dep_name;
        string email;
        string location;
        uint256 contact_no;
        
    }
    
    
    uint256 id=0;
    mapping(uint256 => Departmentinfo) Departments;
    uint256[] public DepartmentIds;
    
    
    function registerDepartment(string memory name, string memory location,string memory email, uint256 contact_no) public returns(uint256)    
         {
                id=id+1;
                Departmentinfo storage newDept = Departments[id];
                newDept.Dep_name = name;
                newDept.location=location;
                newDept.email = email;
                newDept.contact_no = contact_no;
                DepartmentIds.push(id);
                return id;
         }
         function deptCount() public view returns(uint256)
         {
             return id;
         }
    function getDepartmentDetails(uint256 deptid) public view returns (string memory, string memory,string memory, uint256)
         {
               Departmentinfo storage d = Departments[deptid];
               return(d.Dep_name,d.location,d.email,d.contact_no);
         }
         
    function getdept(uint256 deptid) public view returns (uint256,string memory)
         {
                Departmentinfo storage d = Departments[deptid];
                return(deptid,d.Dep_name);
         }
   
    function comparestring(string memory a , string memory b) public view returns(bool)
        {
           return (keccak256(abi.encodePacked(a))==keccak256(abi.encodePacked(b)));

        }
        function getid(int c) public view returns(uint256)
        {
            uint256 n=id;
            return n;
        }
        function getname(uint256 mid) public view returns(uint256,string memory,string memory)
        {
            Departmentinfo storage d=Departments[mid];
            uint256 m=mid;
            return(m,d.Dep_name,d.location);
        }
        function getset(uint256 mid) public view returns(string memory)
        {
            Departmentinfo storage d=Departments[mid];
            return d.Dep_name;
        }
    function validatedept(string memory email,uint256 contact_no) public view returns (uint256 )
        {
            uint256 deptid=0;
            uint256 n=id;
            for(uint256 i=1;i<=n;i++)
             {
                Departmentinfo storage d=Departments[i];
                string memory chck_email=d.email;
                uint256 chck_contact_no=d.contact_no;
                if((comparestring(chck_email,email)) && (chck_contact_no==contact_no))
                     {
                        deptid=id;
                         break;
                     }
             }
             
             return deptid;
        }
    
   
        
}