program poj3657;
 const maxm=25000+1000; maxn=1000000+100;
 type tp=record
 l,r,k:longint;
 end;
 var i,j,n,m,l,r:longint;
 s,a:array[0..maxm] of tp;
 b:array[1..maxm*2] of longint;
 tree:array[1..maxm*2] of tp;
 loc:array[0..maxn] of longint;
 mid:longint;
procedure openfile;
 begin
 assign(input,'poj3657.in');
 assign(output,'poj3657.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;

procedure qsort(l,r:longint);
 var i,j:longint; m,t:tp;
 begin
 i:=l; j:=r;
 m:=a[(l+r) div 2];
 repeat
  while a[i].k<m.k do inc(i);
  while a[j].k>m.k do dec(j);
  if i<=j then
   begin
   t:=a[i]; a[i]:=a[j]; a[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;

procedure sort1(l,r:longint);
 var i,j:longint; m,t:longint;
 begin
 i:=l; j:=r;
 m:=b[(l+r) div 2];
 repeat
  while b[i]<m do inc(i);
  while b[j]>m do dec(j);
  if i<=j then
   begin
   t:=b[i];
   b[i]:=b[j];
   b[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then sort1(l,j);
 if i<r then sort1(i,r);
 end;

procedure buildtree(x,l,r:longint);
 var mid:longint;
 begin
 tree[x].l:=l; tree[x].r:=r;
 tree[x].k:=0;
 if l=r then exit;
 mid:=(l+r)div 2;
 buildtree(x*2,l,mid);
 buildtree(x*2+1,mid+1,r);
 end;

function dye(x,l,r,cl:longint):boolean;
 var mid:longint; pp,qq:boolean;
 begin
 if cl<tree[x].k then exit(false);
 if cl=tree[x].k then exit(true);
 if (l=tree[x].l)and(r=tree[x].r) then
  begin tree[x].k:=cl; exit(true); end;

 mid:=(tree[x].l+tree[x].r) div 2;
 if r<=mid then dye:=dye(x*2,l,r,cl) else
 if l>mid then dye:=dye(x*2+1,l,r,cl) else
 {*} begin
     pp:=dye(x*2,l,mid,cl);
     qq:=dye(x*2+1,mid+1,r,cl);
     dye:=pp or qq;
     end;
 if (tree[x*2].k=tree[x*2+1].k)and(tree[x*2].k<>0)
  then tree[x].k:=tree[x*2].k
  else tree[x].k:=0;
 end;

function judge(len:longint):boolean;
 var i,j,p,q,k,l,r,tot:longint;
 flag:boolean;
 begin
 for i:=1 to len do
  a[i]:=s[i];
//------------discretization-----------
 for i:=1 to len do
  begin
  b[2*i-1]:=a[i].l; b[2*i]:=a[i].r;
  end;
 sort1(1,2*len);
 i:=1; j:=0;
 while i<=2*len do
  begin
  while b[i+1]=b[i] do inc(i);
  inc(j);
  loc[b[i]]:=j;
  inc(i);
  end;
 tot:=j;
//----------------dye------------------
 qsort(1,len);
 buildtree(1,1,tot);
{ for i:=1 to len do
  begin
  flag:=dye(1,loc[a[i].l],loc[a[i].r],a[i].k);
  if not flag then exit(false);
  end; }
//--------------unique-judge--------------------
 i:=len;
 while i>=1 do
  begin
  q:=i;
  while a[i-1].k=a[i].k do
   dec(i);
  p:=i; l:=1; r:=2*len;
  for j:=p to q do
   begin
   if loc[a[j].l]>r then exit(false);
   if loc[a[j].r]<l then exit(false);
   if loc[a[j].l]>l then l:=loc[a[j].l];
   if loc[a[j].r]<r then r:=loc[a[j].r];
   end;
  flag:=dye(1,l,r,a[i].k);
  for j:=p to q do
   dye(1,loc[a[j].l],loc[a[j].r],a[j].k);
  if not flag then exit(false);
  dec(i);
  end;
 exit(true);
 end;

begin
// openfile;
 readln(n,m);
 for i:=1 to n do
  readln(s[i].l,s[i].r,s[i].k);
 l:=1; r:=m;
 repeat
  mid:=(l+r) div 2;
  if judge(mid) then l:=mid+1
   else r:=mid;
  until l=r;
 if judge(l) then writeln(0)
  else writeln(l);
 //closefile;
end.
