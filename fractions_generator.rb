class FractionsGenerator

    def initialize(num_iterations)
        @num = num_iterations
    end

    def print_fractions
        @dp_arr = []
        if(@num <= 0)
            print 'Invalid input details'
        end
        1.upto(@num) do |i|
            if (i == 1)
                @dp_arr[i-1] = "1"
            else
                @dp_arr[i-1] = "#{@dp_arr[i-2]}+\u2081\u2044#{get_denominator(i)}"
            end
            if(i == @num)
                print "#{@dp_arr[i-1]}"
            else
                print "#{@dp_arr[i-1]},"
            end
        end
        puts
    end

    def get_denominator(n)
        num_of_digits = (Math.log10(n)+1).to_i
        hex_str = ""
        num_of_digits.downto(1) do |i|
            hex_str = [(2080 + (n % 10)).to_s.hex].pack("U") + hex_str
            n = n/10
        end
        hex_str
    end

end

obj = FractionsGenerator.new(3)
obj.print_fractions
#obj = FractionsGenerator.new(100)
#obj.print_fractions(100)
#obj = FractionsGenerator.new(1000)
#obj.print_fractions(1000)