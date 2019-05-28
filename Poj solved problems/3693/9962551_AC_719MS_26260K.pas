program poj3693;
const
  ln2=1/ln(2);
type
  arr=array [-1..100001] of longint;
  arra=array [0..18,0..100001] of longint;
var
  n,i,j,k,l,max,where,t,s,e,mid,long,q,p,tot:longint;
  ok:boolean;
  root,nroot:ansistring;
  nrank,nheight,sa,dl,height,total,rank,now,keep,change:arr;
  min,dict,nmin:arra;

procedure swap (var a,b:longint);
var
  i:longint;
begin
  i:=a;
  a:=b;
  b:=i;
end;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'waff.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure solve (var rank,height:arr;root:ansistring);
begin
  fillchar(total,sizeof(total),0);
  for i:=1 to n do
    inc(total[ord(root[i])-96]);
  for i:=1 to 26 do
    total[i]:=total[i-1]+total[i];
  for i:=1 to n do
    rank[i]:=total[ord(root[i])-97]+1;
  k:=0;
  while 1 shl k<n do
    begin
      for i:=1 to n do
        if i+(1 shl k)>n then change[i]:=0
                         else change[i]:=rank[i+(1 shl k)];
      fillchar(total,sizeof(total),0);
      for i:=1 to n do
        inc(total[change[i]]);
      for i:=1 to n do
        total[i]:=total[i]+total[i-1];
      for i:=1 to n do
        begin
          dl[total[change[i]-1]+1]:=i;
          inc(total[change[i]-1]);
        end;
      fillchar(total,sizeof(total),0);
      ok:=true;
      for i:=1 to n do
        begin
          inc(total[rank[i]]);
          if total[rank[i]]=2 then ok:=false;
        end;
      if ok then break;
      for i:=2 to n do
        total[i]:=total[i]+total[i-1];
      fillchar(now,sizeof(now),0);
      fillchar(keep,sizeof(keep),0);
      for i:=1 to n do
        begin
          if now[rank[dl[i]]]<>change[dl[i]] then
            begin
              now[rank[dl[i]]]:=change[dl[i]];
              total[rank[dl[i]]-1]:=total[rank[dl[i]]-1]+keep[rank[dl[i]]];
              keep[rank[dl[i]]]:=0;
            end;
          inc(keep[rank[dl[i]]]);
          rank[dl[i]]:=total[rank[dl[i]]-1]+1;
        end;
      inc(k);
    end;
  for i:=1 to n do
    sa[rank[i]]:=i;
  fillchar(height,sizeof(height),0);
  for i:=1 to n do
    begin
      if rank[i]=1 then continue;
      k:=height[rank[i-1]]-1;
      if k<0 then k:=0;
      while (i+k<=n)and(sa[rank[i]-1]+k<=n)and(root[i+k]=root[sa[rank[i]-1]+k]) do inc(k);
      height[rank[i]]:=k;
    end;
end;

procedure st (var height:arr;var min:arra);
begin
  for i:=1 to n do
    min[0,i]:=height[i];
  k:=0;
  while 1 shl k<n do
    begin
      for i:=1 to n do
        if i+(1 shl k)>n then
          min[k+1,i]:=min[k,i]
                         else
        if min[k,i]<min[k,i+(1 shl k)] then
          min[k+1,i]:=min[k,i]
                                       else
          min[k+1,i]:=min[k,i+(1 shl k)];
      inc(k);
    end;
end;

procedure dictst;
begin
  for i:=1 to n do
    dict[0,i]:=i;
  k:=0;
  while 1 shl k<n do
    begin
      for i:=1 to n do
        if i+(1 shl k)>n then
          dict[k+1,i]:=dict[k,i]
                         else
        if rank[dict[k,i]]<rank[dict[k,i+(1 shl k)]] then
          dict[k+1,i]:=dict[k,i]
                                                     else
          dict[k+1,i]:=dict[k,i+(1 shl k)];
      inc(k);
    end;
end;

function similar (a,b:longint;var min:arra;var rank,height:arr):longint;
var
  i:longint;
begin
  if a=b then exit(n-a+1);
  a:=rank[a];
  b:=rank[b];
  if a>b then swap(a,b);
  inc(a);
  if a=b then exit(height[a]);
  i:=trunc(ln(b-a)*ln2);
  while (i>0)and(1 shl i>=b-a+1) do dec(i);
  if min[i,a]<min[i,b-(1 shl i)+1] then exit(min[i,a])
                                   else exit(min[i,b-(1 shl i)+1]);
end;

function similardict (a,b:longint):longint;
var
  i:longint;
begin
  if a=b then exit(a);
  i:=trunc(ln(b-a)*ln2);
  while (i>0)and(1 shl i>=b-a+1) do dec(i);
  if rank[dict[i,a]]<rank[dict[i,b-(1 shl i)+1]] then exit(dict[i,a])
                                                 else exit(dict[i,b-(1 shl i)+1]);
end;

begin
 // openfile;
  t:=0;
  repeat
    readln(root);
    if root='#' then break;
    inc(t);
    n:=length(root);
    tot:=0;
    solve(rank,height,root);
    st(height,min);
    nroot:=root;
    for i:=1 to n do
      nroot[i]:=root[n-i+1];
    solve(nrank,nheight,nroot);
    st(nheight,nmin);
    dictst;
    max:=1;
    long:=1;
    where:=1;
    for i:=2 to n do
      if root[i]<root[where] then where:=i;
    for l:=1 to n div 2 do
      if n div l >= max then
        for i:=1 to n div l  do
          if n div l - i + 3>=max then
          begin
            if i*l+1>n then continue;
            if root[(i-1)*l+1]<>root[i*l+1] then continue;
            s:=(i-1)*l+1-similar(n-(i-1)*l+1,n-i*l+1,nmin,nrank,nheight);
            k:=similar(s,s+l,min,rank,height)+l;
            q:=k div l;
            if q>=max then
              begin
                p:=similardict(s,s+k-q*l);
                if (q>max)or
                ((q=max)and(rank[where]>rank[p])) then
                  begin
                    max:=q;
                    where:=p;
                    long:=l;
                  end;
              end;
          end;
    write('Case ',t,': ');
    for i:=where to where+max*long-1 do
      write(root[i]);
    writeln;
  until false;
 // closefile;
end.
