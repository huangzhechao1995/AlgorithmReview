var
h,st,sum,trk,rk,sa,tsa:array[0..20001] of longint;
l,r,ans,m,n,i,mid:longint;
{-------------}
procedure suffix_array;
var
m,i,j,p:longint;
begin
fillchar(sum,sizeof(sum),0);
for i:=1 to n do
  begin
  trk[i]:=st[i];
  inc(sum[trk[i]]);
  end;

for i:=1 to 500 do sum[i]:=sum[i]+sum[i-1];
for i:=n downto 1 do
  begin
  sa[sum[trk[i]]]:=i;
  dec(sum[trk[i]]);
  end;
p:=0;
for i:=1 to n do
  begin
  if (p=0) or (trk[sa[i-1]]<>trk[sa[i]]) then inc(p);
  rk[sa[i]]:=p;
  end;

j:=1;m:=p;
while m<n do
  begin
  p:=0;trk:=rk;
  for i:=n-j+1 to n do
    begin
	inc(p);
	tsa[p]:=i;
	end;
  for i:=1 to n do
    begin
	if sa[i]>j then
	  begin
	  inc(p);
	  tsa[p]:=sa[i]-j;
	  end;
	end;
  {-------------}
  fillchar(sum,sizeof(sum),0);
  for i:=1 to n do inc(sum[trk[i]]);
  for i:=2 to m do sum[i]:=sum[i-1]+sum[i];
  for i:=n downto 1 do
    begin
	sa[sum[trk[tsa[i]]]]:=tsa[i];
	dec(sum[trk[tsa[i]]]);
	end;
  p:=0;
  for i:=1 to n do
    begin
	if (p=0) or (trk[sa[i]]<>trk[sa[i-1]]) or (sa[i-1]+j>n) or (trk[sa[i]+j]<>trk[sa[i-1]+j]) then inc(p);
	rk[sa[i]]:=p;
	end;
  j:=j*2;
  m:=p;
  end;

p:=0;
for i:=1 to n do
  begin
  if (rk[i]=1) then begin h[1]:=0; continue; end;
  j:=sa[rk[i]-1];
  while (i+p<=n) and (j+p<=n) and (st[i+p]=st[j+p]) do inc(p);
  h[rk[i]]:=p;
  if p>0 then dec(p);
  end;
end;
{-------------}
function check(x:longint):boolean;
var
head,tail,min,max:longint;
begin
head:=2;tail:=2;
while head<=n do
  begin
  if h[head]<x then begin inc(head); continue; end;
  if sa[head]<sa[head-1] then max:=n-sa[head]+1 else max:=n-sa[head-1]+1;
  if sa[head]>sa[head-1] then min:=n-sa[head]+1 else min:=n-sa[head-1]+1;
  tail:=head+1;
  while (h[tail]>=x) and (tail<=n) do
    begin
	if (n-sa[tail]+1>max) then max:=n-sa[tail]+1;
	if (n-sa[tail]+1<min) then min:=n-sa[tail]+1;
	inc(tail);
	end;
  if max-min>x then exit(true);
  head:=tail;
  end;
exit(false);
end;
{-------------}
begin
readln(m);
while m<>0 do
  begin
  for i:=1 to m do read(st[i]);
  for i:=1 to m-1 do
    st[i]:=st[i+1]-st[i];
  for i:=1 to m-1 do st[i]:=st[i]+200;
  n:=m-1;
  if n=1 then
    begin
    writeln(0);
    readln(m);
    continue;
    end;
  suffix_array;
  l:=0;r:=(m-1) shr 1;
  while l<r do
    begin
	if l=r-1 then
	  begin
	  if check(r) then ans:=r else ans:=l;
	  break;
	  end;
	mid:=(l+r) shr 1;
	if check(mid) then l:=mid else r:=mid;
	end;
  if ans<4 then writeln(0)
  else writeln(ans+1);
  read(m);
  end;
end.
