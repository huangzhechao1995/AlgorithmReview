program poj;
type
   arr=record
    l,r,len,loc:longint;
   end;
   so=record
    v,num:longint;
   end;
const maxn=100000+10; maxm=50000+10;
var n,m,l,r,i,j,p,tot:longint;
  a:array[1..maxn] of longint;
  tree:array[1..maxn*3] of arr;
  sum,c:array[1..maxn*20] of longint;
  s:array[1..maxn] of so;
  k:longint; ans:longint;
procedure qsort(l,r:longint);
 var t,m:so; i,j:longint;
 begin
 i:=l; j:=r;
 m:=s[(l+r)div 2];
 repeat
  while (s[i].v<m.v)or(s[i].v=m.v)and(s[i].num<m.num) do inc(i);
  while (s[j].v>m.v)or(s[j].v=m.v)and(s[j].num>m.num) do dec(j);
  if i<=j then
   begin
   t:=s[i]; s[i]:=s[j]; s[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
procedure build(x,l,r:longint);
 var mid,f,i,ll,rr:longint;
 begin
 tree[x].l:=l; tree[x].r:=r; tree[x].len:=r-l+1;
 if l=r then exit;
 ll:=tree[x].loc; rr:=ll+tree[x].len-1;
 for i:=ll to rr do
  begin
  s[i].v:=c[i];
  s[i].num:=i;
  end;
 qsort(ll,rr);
 mid:=(l+r)div 2+ll-l;
 f:=(l+r) div 2;
 tree[x*2].loc:=tot;
 for i:=ll to rr do
  if (c[i]<s[mid].v)or(c[i]=s[mid].v)and(i<=s[mid].num) then
   begin
   c[tot]:=c[i]; inc(tot);
   end;
 tree[x*2+1].loc:=tot;
 for i:=ll to rr do
  if (c[i]>s[mid].v)or(c[i]=s[mid].v)and(i>s[mid].num) then
   begin
   c[tot]:=c[i]; inc(tot);
   end;
 if (c[ll]<s[mid].v)or(c[ll]=s[mid].v)and(ll<=s[mid].num) then
  sum[ll]:=1 else sum[ll]:=0;
 for i:=ll+1 to rr do
  if (c[i]<s[mid].v)or(c[i]=s[mid].v)and(i<=s[mid].num) then
   sum[i]:=sum[i-1]+1
  else
   sum[i]:=sum[i-1];
 build(x*2,l,f);
 build(x*2+1,f+1,r);
 end;
function find(x,l,r,k:longint):longint;
 var p,mid,sls:longint;// ll,rr:longint;
 begin
 if tree[x].l=tree[x].r then exit(c[tree[x].loc]);
 mid:=(tree[x].l+tree[x].r)div 2;
 if l=tree[x].loc then sls:=0 else sls:=sum[l-1];
 p:=sum[r]-sls;
 if k<=p then exit(find(x*2,tree[x*2].loc+sls,tree[x*2].loc+sum[r]-1,k));
 exit(find(x*2+1,tree[x*2+1].loc+l-1-sum[l-1]+1,tree[x*2+1].loc+r-sum[r]-1,k-p));
 {
 if k<=p then exit(find(x*2,sum[ll-1],sum[rr],k));
 exit(find(x*2+1,r-mid,r-mid,k-p));  }
 end;

begin
 //assign(input,'poj.in');
 //reset(input);
 //assign(output,'poj.out');
 //rewrite(output);
 readln(n,m);
 for i:=1 to n do
  read(a[i]);
 tot:=n+1;
 for i:=1 to n do c[i]:=a[i];
 tree[1].loc:=1;
 build(1,1,n);
 for i:=1 to m do
  begin
  readln(l,r,k);
  ans:=find(1,l,r,k);
  writeln(ans);
  end;
 //close(input); close(output);
end.
