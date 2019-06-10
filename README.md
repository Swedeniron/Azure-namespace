# Python3 script to create namespace in Azure ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)                    

This python3 script are taking a json files with some values as in-file.
It run true them and creating outfiles with az commands to ve deployd in Azure
This make it easy to have the same dopoyment in differt enviroments (account) and 
you will have the namespaces saved for the future.


## Author
Maintainer Stellan Eriksson <micro_se@hotmail.com>



## A simple how to

1. Change the _config.json to your location

2. Create a namespace.json file in ventures                                      

3. Run the script "python templator.py"                                          

4. The script are creating a folder structure _build/azure/namespace.json/       
   and adding a azure-resources.sh file                                          

5. To deploy the new namespace run the azure-resources.sh that are az commands
   Just check that you are connected to for the right environment dev/stage/prod



## License
Copyright (c) 2019 Stellan Eriksson <micro_se@hotmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
