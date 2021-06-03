#!/usr/bin/awk -f

{ 
  # Get Table Names
  if ( $0 ~ /^*/ ){ 
    tab=substr($0,2); i=0; 
  }

  # handle policies
  #if ( $0 ~ /^:(.*?) (ACCEPT|DROP)/ ){
  #  pol=
  #} 

  # Add Chains
  if ( $0 ~ /^:.*? -/ ){ 
    chain=substr($1,2); 
    tables[tab][i++]=sprintf("-N %s", chain); 
  }
  
  # Add Chain Rules
  if ( $0 ~ /^-/ ){ 
    tables[tab][i++]=$0;  
  }
}

END{ 
  for ( t in tables ){ 
    for ( r in tables[t] ){ 
      printf("iptables -t %s %s\n", t, tables[t][r] ); 
    } 
  } 
}
