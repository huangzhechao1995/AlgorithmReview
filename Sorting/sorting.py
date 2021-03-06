class Sorting:

    @staticmethod
    def findKthLargest(a, k):
        def compare(x,y):
            if ascending:
                return x<y
            else:
                return x>y
        def qs(l,r,k):
            
            if (l==r):
                return
            i=l
            j=r
            mid=(l+r)//2
            com_v=a[mid]
            while (i<j):
                while compare(a[i],com_v)and(i<r): 
                    i=i+1
                while compare(com_v,a[j])and(j>l): 
                    j=j-1
                if (i<=j):
                    t=a[i]
                    a[i]=a[j]
                    a[j]=t
                    i=i+1
                    j=j-1
            if l+k-1<=j:
                if (l<j): return qs(l,j,k)
                else: return a[l]
            elif l+k>i:
                if (i<r): return qs(i,r,(k-(i-l)))
                else: return a[r]
            else:
                return a[i-1]
        
        if len(a)==1:
            return a[0]
        ascending=False
        return qs(0,len(a)-1,k)

    @staticmethod
    def quicksort(a,ascending=True):
        def compare(x,y):
            if ascending:
                return x<y
            else:
                return x>y
        def qs(l,r):
            if (l==r):
                return
            i=l
            j=r
            mid=(l+r)//2
            com_v=a[mid]
            while (i<j):
                while compare(a[i],com_v)and(i<r): 
                    i=i+1
                while compare(com_v,a[j])and(j>l): 
                    j=j-1
                if (i<=j):
                    t=a[i]
                    a[i]=a[j]
                    a[j]=t
                    i=i+1
                    j=j-1
            #print(i,j,a[j+1:i])
            if (l<j): qs(l,j)
            if (i<r): qs(i,r)

        qs(0,len(a)-1)
        return a
                
if __name__=="__main__":
    sorter=Sorting()
    result=sorter.quicksort([1,4,5,2,0,9,12,8,7,0,-2,-3,3,123,10,13,11,331,12312],ascending=False)
    print(result)



