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
    $.getJSON("department.json", function(election) {
      // Instantiate a new truffle contract from the artifact
      App.contracts.Election = TruffleContract(election);
      // Connect provider to interact with contract
      App.contracts.Election.setProvider(App.web3Provider);

      return App.render();
    });
    $.getJSON('Professor.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var AdoptionArtifact = data;
      App.contracts.student = TruffleContract(AdoptionArtifact);
    
      // Set the provider for our contract
      App.contracts.student.setProvider(App.web3Provider);
   
      // Use our contract to retrieve and mark the adopted pets
    });
    return App.bindEvents();
  },
  bindEvents: function() {
    $(document).on('click', '.btn-adopt', App.submit);
  },
  render: function() {
    var electionInstance;
    
    // Load account data
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        App.account = account;
       
      }
    });

    // Load contract data
    App.contracts.Election.deployed().then(function(instance) {
      electionInstance = instance;
      return electionInstance.deptCount();
    }).then(function(candidatesCount) {
      var candidatesResults = $("#department");
      candidatesResults.empty();

      for (var i = 1; i <= candidatesCount; i++) {
        electionInstance.getdept(i).then(function(candidate) {
          var id = candidate[0];
          var name = candidate[1];
          var voteCount = candidate[2];

          // Render candidate Result"
          var candidateTemplate="<option value='"+id+"'>"+name+"</option>"
          candidatesResults.append(candidateTemplate);
        });
      }

      
    }).catch(function(error) {
      console.warn(error);
    });
  },
submit: function(event) {
  event.preventDefault();

  var name =document.getElementById('name').value;
  var birthdate=document.getElementById('dob').value;
  var department=parseInt(document.getElementById('department').value);
 
  var email=document.getElementById('email').value;
  var mobile=parseInt(document.getElementById('mobile').value);
  var password=document.getElementById('password').value;
  var designation=document.getElementById('designation').value;
  var adoptionInstance;

web3.eth.getAccounts(function(error, accounts) {
if (error) {
  console.log(error);
}

var account = accounts[0];

App.contracts.student.deployed().then(function(instance) {
  adoptionInstance = instance;

  // Execute adopt as a transaction by sending account
  return adoptionInstance.registerProfessor(name,birthdate,department,designation,email,mobile,password, {from: account});
}).then(function(result) {
  var x=Promise.resolve(result);
  x.then(function(value) {
    var id1=value;
    if(id1!=0)
    {
      alert("Account Created Successfully");
      window.location.href="index.html";
        
    }
    else
    {
      alert("Error");
      window.location.href="index.html";

    }
    
    // expected output: 123
  });
  //window.location.href="login.html"
  
}).catch(function(err) {
  console.log(err.message);
});
});
}

};
$(function() {
  $(window).load(function() {
    App.init();
  });
});