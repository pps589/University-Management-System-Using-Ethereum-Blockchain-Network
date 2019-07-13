pragma solidity ^0.5.0;

contract Professor
{
    struct Professorinfo
    {
        string name;
        string birthdate;
        uint256 department;
        string designation;
        string email;
        uint256 mobile_no;
        string password;
    }
    
    uint256 id=0;
    mapping(uint256 => Professorinfo) Professors;
    uint256[] public ProfessorIds;
    
     function registerProfessor(string memory name, string memory birthdate, uint256 department, string memory designation,
                              string memory email, uint256 mobile_no, string memory password) public  returns(int) {
            
            
                 id=id+1;
                 Professorinfo storage newStudent = Professors[id];
                 newStudent.name = name;
                 newStudent.birthdate = birthdate;
                 newStudent.department = department;
                 newStudent.designation=designation;
                 newStudent.email = email;
                 newStudent.mobile_no = mobile_no;
                 newStudent.password=password;
                ProfessorIds.push(id);
                 return 1;
            }
             
     function getProfessor(uint256 profid) public view returns(string memory,string memory,uint256,string memory,string memory,uint256)
            {
               Professorinfo  storage p =  Professors[profid];
               return(p.name,p.birthdate,p.department,p.designation,p.email,p.mobile_no);
            }
     
     function getname(uint256 profid) public view returns (string memory)
         {
               Professorinfo  storage p =  Professors[profid];
                return(p.name);
         }
   
    function comparestring(string memory a , string memory b) public view returns(bool)
        {
           return (keccak256(abi.encodePacked(a))==keccak256(abi.encodePacked(b)));

        }
   
    function validatedept(string memory email,string memory password) public view returns (uint256 )
        {
            uint256 profid=0;
            uint256 n=id;
            for(uint256 i=1;i<=n;i++)
             {
               Professorinfo  storage p =  Professors[profid];
                string memory chck_email=p.email;
                string memory passkey=p.password;
                if((comparestring(chck_email,email)) && (comparestring(passkey,password)))
                     {
                        profid=id;
                         break;
                     }
             }
             
        }
        function ProfessorCount() public view returns(uint256)
        {
            return id;
        }
    
}