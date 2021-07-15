pragma solidity >=0.4.25 <0.7.0;

contract ballot{
    
    struct voter{
        uint choice;
        bool voted;
        address id;
    }
    
    struct contestant{
        uint symbol;
        uint count;
        address id;
    }
    
    address public chairperson;
    uint candcount;
    
    mapping (address => voter)public voters;
    
    mapping (address => contestant)public candidates;
    
    constructor() public {
        
        chairperson=tx.origin;
        candcount=1;
    }
    
    modifier ischairperson(){
        
        if(chairperson==msg.sender)
        _;
    }
    
    voter[] public votereg;
    
    function voter_registration(address vote)public{
        
        votereg.push(voter({choice:0,
                            voted:false,
                            id:vote
        }));
    }
    
    contestant[] public candreg;
    
    
     function candidate_registration(address cand)public{
        
        candreg.push(contestant({symbol:candcount,
                            count:0,
                            id:cand
        }));
        candcount++;
    }
}
