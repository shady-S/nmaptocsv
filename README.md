# nmaptocsv-converter  
This script converts .nmap file which is obtained when using (-oA) switch to csv format in Nmap.  

## How to Use

1. **Save the Script**  
   Save the script as `nmaptocsv.sh`.

2. **Make the Script Executable**  
   Run:
   ```bash
   chmod +x nmaptocsv.sh
3. **Run the Script**  
   Provide the .nmap file as an argument:
     ````bash
     ./nmaptocsv.sh <your_nmap_file>
     ````  

   For example
   
     ````bash
     ./nmaptocsv.sh scan_results.nmap
     ````
5. **Check the Output**  
The parsed results will be saved in _scan_results.csv_ in the same directory.
