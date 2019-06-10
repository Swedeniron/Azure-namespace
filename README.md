# Python3 script to create namespace in Azure                                    

This python3 script are taking a json files with some values as in-file.
It run true them and creating outfiles with az commands to ve deployd in Azure
This make it easy to have the same dopoyment in differt enviroments (account) and 
you will have the namespaces saved for the future.


1. Create a namespace.json file in ventures                                      

2. Run the script "python templator.py"                                          

3. The script are creating a folder structure _build/azure/namespace.json/       
   and adding a azure-resources.sh file                                          

4. To deploy the new namespace run the azure-resources.sh that are az commands
   Just check that you are connected to for the right environment dev/stage/prod
 
