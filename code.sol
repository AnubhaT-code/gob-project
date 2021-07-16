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
    
    mapping (uint => contestant)public candidates;
    
    constructor() public {
        
        chairperson=tx.origin;
        candcount=1;
    }
    
    modifier ischairperson(){
        require(msg.sender==chairperson,"Only chairperson can call this function");
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
    
    function candidate_registration_check(address ad) public ischairperson returns(bool){
        candcount--;
        for(uint i=0;i<candcount;i++){
            candidates[candreg[i].symbol]=candreg[i];
        }
        return true;
    }
    
    function voter_registration_check(address ad) public ischairperson returns(bool){
        uint votercount=votereg.length;
        for(uint i=0;i<votercount;i++){
            voters[votereg[i].id]=votereg[i];
        }
        return true;
    }
    function vote_candidates( address person_voting,uint symbol_voting )public{
    
        require(
            !voters[person_voting].voted,
            "The voter already voted."
        );
    
        for ( uint i=1 ; i <= candreg.length ; i++ ){
        if(candreg[i].symbol==symbol_voting){
            voters[person_voting].choice=symbol_voting;
        candreg[i].count+=1;
        voters[person_voting].voted=true;
        }
        }

    }
}
