fu buf#cmd(c)
  if &mod && !&hid
    if confirm('This buffer has been modified. Save?',"Yes\nNo")==1
      up | redr
    el
      redr | echoh errormsg | ec 'Aborted.' | echoh none | retu
    en
  en
  exe 'sil '.a:c
  " Echo a one-line summary of where the current buffer is among other buffers
  let b=filter(range(1,bufnr('$')),'bufexists(v:val)&&buflisted(v:val)') " buffer numbers
  let i=index(b,bufnr('%'))                                   " current buffer
  let a=map(copy(b),'fnamemodify(bufname(v:val),":t")')       " buffer names
  cal map(a,'empty(v:val) ? "*" : v:val')
  cal map(a,'getbufvar(b[v:key],"&mod") ? v:val."+" : v:val')
  if i==-1 | enew | cal add(a,'*') | let i=len(a)-1 | en      " if zero buffers are listed, create a blank one
  let p='buf: '                                               " prefix
  let l=i?join(a[:(i-1)],' ').' ':''                          " left string
  let m='['.a[i].']'                                          " middle string
  let r=i==len(a)-1?'':' '.join(a[i+1:])                      " right string
  let n=&co-12-len(p)-len(m)                                  " limit
  if len(l)+len(r)>n
    if len(r)<n/2
      let l='...'.l[len(r)-n+3):]
    elseif len(l)<n/2
      let r=r[:(n-len(l)-4)].'...'
    el
      let [l,r]=['...'.l[3-n/2:],r[:n/2-4].'...']
    en
  en
  echoh moremsg | echo p.l.m.r | echoh none
endf
