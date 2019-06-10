import json
import os
from jinja2 import Template
from pathlib import Path 

########################################################################################
# Python3 script to create namespace in Azure                                          #
#                                                                                      #
# 1. Create a namespace.json file in ventures                                          #
# 2. Run the script "python templator.py"                                              #
# 3. The script are creating a folder structure _build/azure/namespace.json/           #
#    and adding a azure-resources.sh file                                              #
# 4. To deploy the new namespace run the azure-resources.sh for the right namespace    #
#                                                                                      #
######################################################################################## 

# Values for some base_path
base_path = os.path.dirname(os.path.realpath(__file__))
ventures_path = base_path + os.sep + "ventures"	
get_venture_name = os.listdir(ventures_path)

# Looping true all .json in ventures directory
for i in os.listdir(ventures_path): 
	venture_name = (i)
	
	# More values for base_path
	venture_jsonFile_path = ventures_path +  os.sep + venture_name + '.json'
	venture_output_folder_path = ventures_path +  os.sep + venture_name
	config_filename_path = base_path + os.sep + "_config.json"
	skeleton_path = base_path + os.sep + "_skeleton"                                              
	output_folder_path = base_path + os.sep + "_build" + os.sep + "azure" + os.sep + venture_name 

	
	with open(venture_output_folder_path) as json_file:
		data = json.load(json_file)	
	with open(config_filename_path) as json_file:  
		config = json.load(json_file)
	data["__filename__"] = venture_name
	data["__config__"] = config
	
	skeleton_files = []
	for r, d, f in os.walk(skeleton_path):
		for file in f:
			skeleton_files.append(os.path.join(r, file))
			
	# Taking the azure-resources.sh and creating a dir/file _build/azure/namespace.json/azure-resources.sh
	# Giving the azure-resources.sh all values from the namespace.json
	for file_path in skeleton_files:
		t = Template(open(file_path).read())
		result = t.render(data)
		output_filename_path = file_path.replace(skeleton_path, output_folder_path)
		os.makedirs(os.path.dirname(output_filename_path), exist_ok=True)
		print(result,  file=open(output_filename_path, 'w'))
		print(output_filename_path)
	
	print(i) 
	



