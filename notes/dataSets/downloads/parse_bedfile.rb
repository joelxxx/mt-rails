require 'csv'

bdta = CSV.read("new_beds.csv")

# no match found for unit -09660977-02d8-44b2-81db-10a792783db0-Bldg 2 -   line 1259

#b1 = bdta[1]
#=> ["Jester IV", "A1 POD", "J4-A1-01-S"]

#
# Need hash from facility name to fac_id
fl = CSV.read("facilities.csv")
fk = Hash[ fl.map { |u| [ u[1] ,  u[0]]  }]
# Need hash from unit name to unit_id
ul = CSV.read("units.csv")
# need key to be  concat of facility_id - unit_name
uk = Hash[ ul.map { |u| [ u[3] + "-" + u[1] , u[0]]  }]

# DEBUG HELP HERE
#puts ("facility tagged unit name to id hash = #{uk.to_s}")

#
# output  name,facility_id,unit_id,numericname,bed_app_type,bed_state
#                                    seq      ,regular     , clean
#
# see existing csv for format
#
puts ("name,facility_id,unit_id,state")
(1..bdta.size()-1).each do |i|
  #puts ("bed #{i}  is #{bdta[i][2]}")
  ukey = fk[bdta[i][0]] + "-" + bdta[i][1]
  #puts ("#{bdta[i][2]},#{fk[bdta[i][0]]},#{uk[bdta[i][1]]},#{1000+i},regular,occupied")
  puts ("#{bdta[i][2]},#{fk[bdta[i][0]]},#{uk[ukey]},occupied")
  #puts ("unit name #{bdta[i][1]}  maps to  #{uk[bdta[i][1]]} ")
  if uk[ukey] == nil
    puts ("no match found for unit -#{ukey}-   line #{i}")
    exit()
  end
  #puts ("facility name #{bdta[i][0]}  maps to  #{fk[bdta[i][0]]} ")
  if fk[bdta[i][0]] == nil
    puts ("no match found for facility -#{bdta[i][0]}-  line #{i}")
    exit()
  end
end

