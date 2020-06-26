#!/bin/bash
# zen.sh
# Andrew Davison, Nov 2019, ad@fivedots.coe.psu.ac.th

# a temporary file to hold command output
OUTPUT=/tmp/output.sh.$$

# trap to delete temp output file
trap "rm $OUTPUT; exit" SIGHUP SIGINT SIGTERM


# display output
showMsg() {
  local t=${1-Output}    # title
  local h=${2-100}       # height default 100
  local w=${3-400}       # width default 400
  zenity --text-info --title "${t}" \
         --height ${h}  --width ${w}   \
         --filename="$OUTPUT"

# alternative display format
# zenity --info --title "${t}" \
#         --height ${h}  --width ${w}   \
#         --text="$(<$OUTPUT)" 
}


startDcServices() {
  echo "Today is $(date) @ $(hostname -f)."  | tee $OUTPUT
  showMsg "Date and Time"
}


stopDcServices() {
  who | tee $OUTPUT
  showMsg "Who is Here" 200
}


validateDcServices() {
  pwd | tee $OUTPUT
  showMsg "Working Directory"
}

scanDockerImages() {

  showMsg "Scanning"
}


# supply an array of strings as an argument;
# the function sets the global opts[] to the indicies of
# the selected options (starting at 1), and returns a
# count of the selected options (which may be 0)
getOptions() {
  local options=("$@")
  local num=${#options[@]}

  # extend options array to be suitable for a zenity list
  local selects=()
  for((i=0;i<$num;i++)); do
    selects+=( FALSE  $((i+1)) "${options[i]}" )  
        # all boxes unchecked; row number which is returned
        # number starts at 1
  done

  opts=$(zenity --list  --title="Choices" \
             --text="Select options:" \
             --width=400 --height=200  \
             --column="Selected" --column="id" --column="Description" \
             --hide-column=2  --print-column=2  \
             --checklist "${selects[@]}")

  local ret="$?"
  # opts=$(echo $opts | tr -d ' \n')    # clean string (just in case!)

  if [ "$ret" -eq 1 ]; then
    echo "Selection cancelled"
    return 0
  elif  [ "$ret" -ne 0 ]; then
    echo "Unknown error"
    return 0
  fi

  local IFS="|"     # Change IFS locally to zenity separator
  opts=($opts)      # split string into an array

  return "${#opts[@]}"    # count the number of selections
}  # end of getOptions()



# ----------------- main -----------------------

options=("Start Docker services"
         "Stop Docker services"
         "Validate Docker compose file"
	 "Scan Docker images")

getOptions "${options[@]}"
ret="$?"

if [ "$ret" -eq 0 ]; then
  echo -e "\nNo options selected"
  exit 0
fi


echo -e "\nOptions chosen:"
for (( i=0; i<$ret; i++ )); do
  idx=${opts[$i]}   # idx starts at 1
  echo -e "\n$idx. ${options[$((idx-1))]}"
  case $idx in
    1) startDcServices ;;
    2) stopDcServices ;;
    3) validateDcServices ;;
    4) scanDockerImages ;;
    *) echo "??" ;;
  esac
done

# delete temp command output file
[ -f $OUTPUT ] && rm $OUTPUT

