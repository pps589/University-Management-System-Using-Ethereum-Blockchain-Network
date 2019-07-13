App = {
  web3Provider: null,
  contracts: {},
  account: '0x0',

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    if (typeof web3 !== 'undefined') {
      // If a web3 instance is already provided by Meta Mask.
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // Specify default instance if no web3 instance provided
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      web3 = new Web3(App.web3Provider);
    }
    return App.initContract();
  },

  initContract: function() {
    $.getJSON("program.json", function(program) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.program = TruffleContract(program);
      // Connect provider to interact with contract
      App.contracts.program.setProvider(App.web3Provider);
      return App.render();
      
    });
        $.getJSON("department.json", function(election) {
          // Instantiate a new truffle contract from the artifact
          App.contracts.Election = TruffleContract(election);
          // Connect provider to interact with contract
          App.contracts.Election.setProvider(App.web3Provider);
          
        });
        
        
        
  },

  render: function() {
    var electionInstance;
    var loader = $("#loader");
    var content = $("#content");

    loader.show();
    content.hide();

    // Load account data
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        App.account = account;
        $("#accountAddress").html("Your Account: " + account);
      }
    });

    // Load contract data
    App.contracts.program.deployed().then(function(instance) {
      electionInstance = instance;
      return electionInstance.getProgramCount();
    }).then(function(candidatesCount) {
      var candidatesResults = $("#candidatesResults");
      candidatesResults.empty();
    var bc1;
      for (var i = 1; i <= candidatesCount; i++) {
        electionInstance.getProgram(i).then(function(candidate) {
          var id = i;
          var name = candidate[1];
          var department = candidate[2];
          var dept=parseInt(department);
          var dur=candidate[3];
            
        

          // Render candidate Result
          var candidateTemplate = "<tr><td>" + name + "</td><td>"+ department+"</td><td>"+ dur+"</td></tr>"
          
          candidatesResults.append(candidateTemplate);
        });
      }

      loader.hide();
      content.show();
    }).catch(function(error) {
      console.warn(error);
    });
},
submit:function(val)
{
   var electionInstance;
    
    // Load account data
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        App.account = account;
        //$("#accountAddress").html("Your Account: " + account);
      }
    });
    var bc1;
    var id1;
    var x;
    App.contracts.Election.deployed().then(function(bc) {
        electionInstance= bc;
         return electionInstance.getset(val);
      }).then(function(result) {
        x=Promise.resolve(result);
        x.then(function(value) {
          id1=value;
        });
    });
    //alert(id1);
    //return id1;
}
  };


$(function() {
  $(window).load(function() {
    App.init();
  });
});