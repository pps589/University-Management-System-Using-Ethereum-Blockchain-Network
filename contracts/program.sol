pragma solidity ^0.5.0;

contract program
{

    struct programInfo 
    {
        string name;
        uint256 department;
        uint256 duration;
    }
    uint256 pid=0;
    mapping(uint256 => programInfo) programs;
    uint256[] public programIds;

    function registerprogram(string memory name,  uint256 department,uint256 duration) public     
                             {
                                    pid=pid+1;
                                    programInfo storage newProgram = programs[pid];
                                    newProgram.name = name;
                                    newProgram.department = department;
                                    newProgram.duration=duration;
                                    programIds.push(pid);
        
                             }

    function getProgram(uint256 mid) public view returns (uint256,string memory, uint256, uint256)
    {
        programInfo storage p = programs[mid];
        return (mid,p.name,p.department,p.duration);
    }
    function getname(uint256 mid) public view returns (uint256,string memory)
    {
        programInfo storage p=programs[mid];
        return (mid,p.name);
    }

    function comparestring(string memory a , string memory b) public view returns(bool)
    {
           return (keccak256(abi.encodePacked(a))==keccak256(abi.encodePacked(b)));

    }
    function getProgramCount()public view returns(uint256)
    {
        return pid;
    }
}