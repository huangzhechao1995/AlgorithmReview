class KMP:
    
    def __init__(self, pat):
        length = 0 # length of the previous longest prefix suffix
        M=len(pat)
        lps = [0]*M
        lps[0] = 0 # lps[0] is always 0 
        #meanning of lps array is: if matching fails when matching pat[j], then the next loc of pat should we try matching is lps[j]
        i = 1
        # the loop calculates lps[i] for i = 1 to M-1 
        
        while i < M: 
            if pat[i]== pat[length]: 
                length+= 1
                lps[i] = length
                i += 1
            else: 
                # This is tricky. Consider the example. 
                # AAACAAAA and i = 7. The idea is similar  
                # to search step. 
                if length != 0: 
                    length = lps[length-1] 
                    # Also, note that we do not increment i here 
                else: 
                    lps[i] = 0
                    i += 1
        self.pat = pat
        self.lps = lps
    def match(self, txt, printing=False):
            matched_index=[]
            M = len(self.pat)
            N = len(txt) 
        
            # create lps[] that will hold the longest prefix suffix  
            # values for pattern 
            lps = [0]*M 
            j = 0 # index for pat[]
            i = 0 # index for txt[] 
            while i < N: 
                if self.pat[j] == txt[i]: 
                    i += 1
                    j += 1
        
                if j == M: 
                    if printing:
                        print("Found pattern at index " + str(i-j))
                    matched_index.append(i-j)
                    j = self.lps[j-1] 
        
                # mismatch after j matches 
                elif i < N and self.pat[j] != txt[i]: 
                    # Do not match lps[0..lps[j-1]] characters, 
                    # they will match anyway 
                    if j != 0: 
                        j = self.lps[j-1] 
                    else: 
                        i += 1



if __name__=="__main__":
    
    text = "ABABDABACDABABCABAB"
    pattern = "ABABC"
    kmp=KMP(pattern)
    kmp.match(text, True)

    