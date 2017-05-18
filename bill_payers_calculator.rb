class BillPayersCalculator

    def find_bill_payers(bill_amount, friends)
        if(bill_amount <= 0)
            "Invalid bill amount or payment need not be done"
        else
            @bill = bill_amount
            @friends = friends
            #@subsets = get_all_subsets_binary(@friends)
            #@subsets = get_all_subsets_recursive(@friends)
            #get_subsets_for_bill_amount
            get_all_subsets_dp(@friends,@bill)
        end
    end

    def get_subsets_for_bill_amount
        bill_subsets = []
        @subsets.each do |subset|
            sum  = 0
            subset.each do |elem|
                sum += elem
            end
            if(sum == @bill)
                bill_subsets.push(subset)
            end
        end
        return bill_subsets
    end

    def get_all_subsets_recursive(set)
        if(set.length == 0)
            return [[]]
        end
        current_elem = set[0]
        remaining_set = set - [current_elem]
        sub_sets_excluding_current_elem = get_all_subsets_recursive(remaining_set)
        sub_sets_including_current_elem = []
        0.upto(sub_sets_excluding_current_elem.length-1) do |i|
            sub_sets_including_current_elem.push([current_elem] + sub_sets_excluding_current_elem[i])
        end
        # p "*****************************************************************"
        # p 'set', set
        # p 'current_elemm' , current_elem
        # p 'remaining_set', remaining_set
        # p 'sub_sets_including_current_elem', sub_sets_including_current_elem
        # p 'sub_sets_excluding_current_elem', sub_sets_excluding_current_elem
        # p "*****************************************************************"
        return sub_sets_including_current_elem + sub_sets_excluding_current_elem
    end

    def get_all_subsets_binary(set)
        len = set.length
        subsets_len = 2**len -1
        subsets = []
        0.upto(subsets_len) do |i|
            bin_i = i.to_s(2).rjust(len,"0").split("")
            current_subset = []
            0.upto(set.length) do |j|
                if(bin_i[j] == "1")
                    current_subset.push(set[j])
                end
            end
            subsets.push(current_subset)
        end
        subsets
    end


    def get_all_subsets_dp(set,sum)
        #p set
        #p sum
        dp_arr = []
        0.upto(set.length-1) do |i|
            0.upto(sum) do |j|
                if(j == 0)
                    if(dp_arr[i] == nil)
                        dp_arr[i] = Array.new(sum+1,0)
                    end
                    dp_arr[i][j] = 1
                elsif(set[i]==j)
                    dp_arr[i][j] = 1
                elsif(i>0)
                    # p "*****************************************************************"
                    # p 'i => ' + i.to_s
                    # p 'set[i] => '+set[i].to_s
                    # p 'j => '+j.to_s
                    # p dp_arr
                    # p 'j-i => '+dp_arr[i-1][j-set[i]].to_s
                    # p "*****************************************************************"
                    dp_arr[i][j] = dp_arr[i-1][j]
                    if(set[i] < j && dp_arr[i][j] == 0)
                        dp_arr[i][j] = dp_arr[i-1][j-set[i]]
                    end
                end
            end
        end
        return get_subsets_from_dp_arr(sum,set,dp_arr)
        
    end

    def get_subsets_from_dp_arr(sum,set,dp_arr)
         # p dp_arr
        subsets_array = []
        last_column = (dp_arr[0].length) -1
        0.upto(dp_arr.length-1) do |i|
            if(dp_arr[i][last_column] == 1)
                x = i;
                y = last_column;
                subset = []
                # p "(#{x},#{y})"
                # p "pushing => #{set[x]}" 
                # subset.push(set[x])
                while(((dp_arr[x -1][y] == 1) || (dp_arr[x-1][y - set[x]] == 1)) && (x>=0 && y>=0) ) do
                    if(dp_arr[x-1][y] == 1)
                        # subset.push(set[x])
                        x -=1
                    else
                        # p "(#{x},#{y})"
                        # p "pushing => #{set[x]}"
                        subset.push(set[x])
                        y-=set[x]
                        x-=1
                    end
                end
                # p "(#{x},#{y})"
                subset.push(set[x+1]) if y !=0
                subsets_array.push(subset)
                return subsets_array
            end
        end
        subsets_array
    end

end

obj = BillPayersCalculator.new
p obj.find_bill_payers(1201, [10, 20, 700, 2, 68, 5, 5,  200, 150, 40])
#p obj.find_bill_payers(3, [1,1,1,1])