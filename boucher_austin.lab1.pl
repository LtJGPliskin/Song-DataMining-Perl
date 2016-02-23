######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  < Austin Boucher>
#  < boucheraustin100@yahoo.com >
#										
#########################################
# Replace the string value of the following variable with your names.
my $name = "<Austin Boucher>";
print "CSCI 305 Lab 1 submitted by $name.\n\n";

# Checks for the argument, fail if none given
if($#ARGV != 0) {
    print STDERR "You must specify the file name as the argument.\n";
    exit 4;
}

# Opens the file and assign it to handle INFILE
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";


# YOUR VARIABLE DEFINITIONS HERE...
$title;
$bigrams;
$t = 0;
$iterations = 0;
my %hash = ();
$a = "a";

# This loops through each line of the file
while($line = <INFILE>) {
    #while I know that all of these can be equated with a single regular expression, I made individual expressions to help debug the process.
    #these first three lines remove the <SEP> tags and on the third one, replaces <SEP> with a > for ease of removal
    $line =~ s/\b<\w*\b>//;
    $line =~ s/\b<\w*\b>//;
    $line =~ s/\b<\w*\b>/>/;
    $line =~ s/%//g;
    #removes all of the content up to the newly added <SEP> tag
    $line =~ s/.*\b>//i;
    #removes all content with ({[-_:/\"`+*=
    $line =~ s/\(.*//g;
    $line =~ s/\[.*//g;
    $line =~ s/\{.*//g;
    $line =~ s/\(.*//g;
    $line =~ s/\-.*//g;
    $line =~ s/\_.*//g;
    $line =~ s/\:.*//g;
    $line =~ s/\\.*//g;
    $line =~ s/\/.*//g;
    $line =~ s/\".*//g;
    $line =~ s/\‘.*//g;
    $line =~ s/\+.*//g;
    $line =~ s/\*\.*//g;
    $line =~ s/\=.*//g;
    #removes all of the special characters found throughout the lines
    $line =~ s/\?//g;
    $line =~ s/\¿//g;
    $line =~ s/\!//g;
    $line =~ s/\¡//g;
    $line =~ s/\;//g;
    $line =~ s/\&//g;
    $line =~ s/\$//g;
    $line =~ s/\.//g;
    $line =~ s/\%//g;
    $line =~ s/\|//g;
    $line =~ s/@//g;
    $line =~ s/\#//g;
    #forces the line into lowercase
    $line = lc$line;
    #now that all of the words have been type casted, I use feat,feature, and featuring to remove all additional information without having to use /i
    $line =~ s/feat \.*//g;
    $line =~ s/feature\.*//g;
    $line =~ s/featuring\.*//g;
    #removes all additional return entries that may be left over
    $line =~ s/\n//g;
    #parses through the data and removes all of the stop words
    $line =~ s/\b(a)\b //g;
    $line =~ s/\b(an)\b //g;
    $line =~ s/\b(and)\b //g;
    $line =~ s/\b(by)\b //g;
    $line =~ s/\b(from)\b //g;
    $line =~ s/\b(for)\b //g;
    $line =~ s/\b(in)\b //g;
    $line =~ s/\b(of)\b //g;
    $line =~ s/\b(on)\b //g;
    $line =~ s/\b(or)\b //g;
    $line =~ s/\b(out)\b //g;
    $line =~ s/\b(the)\b //g;
    $line =~ s/\b(to)\b //g;
    $line =~ s/\b(with)\b //g;
    #now removes all words that aren't in english
    if($line =~ s/\P{IsASCII}//g)
    {
        $line = "";
    }
    #sets title to equal the line
    $title = $line;
    #splits the title into separate words based on spacing
    @words = split / /, $title;
        #runs through the individual words and hashes out the values, incrementing the hashvalue if the word is duplicated
          for($i=0 ; $i<=$#words ; $i++)
        {
            $bigram = $words[$i] . " " . $words[$i+1];
            #print $hash{bigram};
               if($hash{$bigram} == null)
            {
               $hash{$bigram} = 1;
            }
            else
            {
              $hash{$bigram}++;
            }
            #print $words[$i] . " ";
        }
        #print "\n";
        #print $title;
        
                	# This prints each line. You will not want to keep this line.
    
	# YOUR CODE BELOW...
    }
    
# Close the file handle
close INFILE; 

# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.
print "File parsed. Bigram model built.\n\n";


# User control loop
    #prompts the user to find out about a unique word
print "Enter a word to find out about it's repitivity [Enter 'q' to quit]: ";
$input = <STDIN>;
chomp($input);
print "\n";	
while ($input ne "q"){
    #used to hold the top iterations
    $topdog = 0;
    #used to hold the unique appearences of the input word
    $iterations = 0;
    #used to hold the most frequent bigram
    $holder;
	# Replace these lines with some useful code
    
    #runs through the hash array
    foreach $key (keys %hash)
    {
        #print $key . " " . $hash{$key};
        #print "\n";
        #splits the current hash into separate words to be checked
        @temp = split / /, $key;
        #if the current input is the first value of the hash, runs this code
        if($input eq $temp[0])
        {
        #unique iterations go up by one
            $iterations++;
            #if the current hash has iterated more than the previous, it takes over
            if($hash{$key} > $topdog and !($temp[1] eq ""))
            {
                $topdog = $hash{$key};
                $holder = $key . " was found " . $topdog . " times\n";
            }
        }
    }
    #prints the information on the user input and prompts the user again
    print $holder;
    print $input . " was found " . $iterations . " unique times\n";
    print "Enter a word to find out about it's repitivity [Enter 'q' to quit]: ";
    $input = <STDIN>;
    chomp($input);
    $holder = "";
    
}
    #prompts the user to chose a word to make a song title
    print "Enter a word to form a song title[Enter 'q' to quit]: ";
    $input = <STDIN>;
    chomp($input);
while ($input ne "q"){
    #holds the number of iterations
    $num = 0;
    #refreshes the holder variable
    $holder;
    #refreshes the true holder variable
    $holder2 = "";
    #runs the choose a song title twentytimes
    while($num != 20)
    {
    $num++;
    $topdog = 0;
    $iterations = 0;
    # Replace these lines with some useful code
    
        #runs through the hash and splits up the lines
    foreach $key (keys %hash)
    {
        @temp = split / /, $key;
        if($input eq $temp[0])
        {
            $iterations++;
            
            #if the current hash has iterated more than the previous, it takes over
            if($hash{$key} > $topdog and !($temp[1] eq ""))
            {
                $topdog = $hash{$key};
                $holder = $temp[0];
                $temp2 = $temp[1];
            }
        }
    }
        #runs a security check to assure that duplicate values are not being replicated, if they are it terminates the while loop
    $input = $temp2;
        @temp = split / /, $holder2;
        if(
            ($temp[$#temp] eq $temp2) or
            ($temp[$#temp - 1] eq $holder) or
            ($temp[$#temp - 2] eq $temp2) or
            ($temp[$#temp - 1] eq $temp2))
        {
            $num = 20;
        }
        #starts the holder variables
    elsif($num == 1)
    {
    $holder2 = $holder2 . " " . $holder . " " . $temp2;
    }
        #continues the holder variables after starting
    else
    {
        $holder2 = $holder2 . " " . $temp2;
    }
        
    }
    
    #prints the information on the user input and prompts the user again
    print "\n";
    print $holder2;
    print "\n";
    print "Enter a word to form a song title[Enter 'q' to quit]: ";
    $input = <STDIN>;
    chomp($input);
}

