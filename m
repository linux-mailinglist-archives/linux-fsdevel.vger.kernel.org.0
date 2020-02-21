Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24199168222
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgBUPpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 10:45:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41254 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgBUPpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:45:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so2351070otc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJ76dbWV6Hrpq8Mu8XFunPpoSbtEI2f1hLA0MqTSFAE=;
        b=JzNdVxLni+3SIL2B/dHNs+BXwlg8fEdeJYKxG8y/us3rYjNRsugH7zyLEd9y+Q0dvH
         tNEshKmvFe7pxySNVCK8VhNUQe/Cx9XyIGyCkUmv4+/QN+gQ58q9dcDeQwZhrfFplCqk
         r+1Tdz66GI0I7nksiWq0efA8qc01QUEnEA7O5B6RN+ttv9R+QUoXbDBSHhQaVgrfeesd
         oqTpwgM56jgYBo7KxyXJtkFs9ehZsX3BI0efQDxJeZingRxFpl4oUmbJBXh4MI5et4AR
         qfkVDpZoQCNwmfjnR3QfL86jD3RhcBEgIVSQfq96BwotoB+dEPi0UfgOpsBjGtwqH9g4
         ewHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJ76dbWV6Hrpq8Mu8XFunPpoSbtEI2f1hLA0MqTSFAE=;
        b=QuKaEmivkPrM7S2fZOy4anQO/1TF+hiLpot27mSS4k37maegvFRGORgBjVIcJ4KYqg
         MVbvBF0B+pfE69I5pF61pB0ljzyaIUoghAJRuRG44d9wwpq5Rnl8ntlnif9wGSwXsTO/
         iwl4JQFuiou9n3lppL9De1pCQ6N3lMISKkTVYAufzOvkkdJrfQVL3br+EV4w7KHJRAWP
         nqoqWEVA7z2ZvtI+iNhBbSONLBy2yUxkUtEiJf2bg+twfHYyj6XIoPV8w6aOTRFQq4TD
         i9l/MK/bGoFp8Hy9CxyiSPx2cztqMFd9sFoUjfMz43+qb1InzWGd7O/1gRfocSYxesuL
         YWEg==
X-Gm-Message-State: APjAAAWIBxS8SLA10gvodm47WkZGiVqZcjxIIDRn+kAEANWAFXfefo+V
        lGJelCFpuY6pT+ixPxYgUpT/C9dDYPA2wm+FYZQ7nRTi04AFuA==
X-Google-Smtp-Source: APXvYqz2te/dx3ohJwq4+vB3zeo3H6S/EgzaXYjYFXFzW3w2cr3qRHngMP32q64gLaLs4czHjOVSArdnDURQ/VZz1WA=
X-Received: by 2002:a05:6830:1219:: with SMTP id r25mr4451562otp.180.1582299908280;
 Fri, 21 Feb 2020 07:45:08 -0800 (PST)
MIME-Version: 1.0
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk>
 <CAG48ez2B2J_3-+EjR20ukRu3noPnAccZsOTaea0jtKK4=+bkhQ@mail.gmail.com> <1897788.1582295034@warthog.procyon.org.uk>
In-Reply-To: <1897788.1582295034@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 21 Feb 2020 16:44:42 +0100
Message-ID: <CAG48ez2nFks+yN1Kp4TZisso+rjvv_4UW0FTo8iFUd4Qyq1qDw@mail.gmail.com>
Subject: Re: [PATCH 15/19] vfs: Add superblock notifications [ver #16]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 3:24 PM David Howells <dhowells@redhat.com> wrote:
>
> Jann Horn <jannh@google.com> wrote:
>
> > > +               if (!s->s_watchers) {
> >
> > READ_ONCE() ?
>
> I'm not sure it matters.  It can only be set once, and the next time we read
> it we're inside the lock.  And at this point, I don't actually dereference it,
> and if it's non-NULL, it's not going to change.

I'd really like these READ_ONCE() things to be *anywhere* the value
can concurrently change, for two reasons:

First, it tells the reader "keep in mind that this value may
concurrently change in some way, don't just assume that it'll stay the
same".

But also, it tells the compiler that if it generates multiple loads
here and assumes that they return the same value, *really* bad stuff
may happen. GCC has some really fun behavior when compiling a switch()
on a value that might change concurrently without using READ_ONCE():
It sometimes generates multiple loads, where the first load is used to
test whether the value is in a specific range and then the second load
is used for actually indexing into a table of jump destinations. If
the value is concurrently mutated from an in-bounds value to an
out-of-bounds value, this code will load a jump destination from
random out-of-bounds memory.

An example:

$ cat gcc-jump.c
int blah(int *x, int y) {
  switch (*x) {
    case 0: return y+1;
    case 1: return y*2;
    case 2: return y-3;
    case 3: return y^1;
    case 4: return y+6;
    case 5: return y-5;
    case 6: return y|1;
    case 7: return y&4;
    case 8: return y|5;
    case 9: return y-3;
    case 10: return y&8;
    case 11: return y|9;
    default: return y;
  }
}
$ gcc-9 -O2 -c -o gcc-jump.o gcc-jump.c
$ objdump -dr gcc-jump.o
[...]
0000000000000000 <blah>:
   0: 83 3f 0b              cmpl   $0xb,(%rdi)
   3: 0f 87 00 00 00 00    ja     9 <blah+0x9>
5: R_X86_64_PC32 .text.unlikely-0x4
   9: 8b 07                mov    (%rdi),%eax
   b: 48 8d 15 00 00 00 00 lea    0x0(%rip),%rdx        # 12 <blah+0x12>
e: R_X86_64_PC32 .rodata-0x4
  12: 48 63 04 82          movslq (%rdx,%rax,4),%rax
  16: 48 01 d0              add    %rdx,%rax
  19: ff e0                jmpq   *%rax
[...]


Or if you want to see a full example that actually crashes:

$ cat gcc-jump-crash.c
#include <pthread.h>

int mutating_number;

__attribute__((noinline)) int blah(int *x, int y) {
  switch (*x) {
    case 0: return y+1;
    case 1: return y*2;
    case 2: return y-3;
    case 3: return y^1;
    case 4: return y+6;
    case 5: return y-5;
    case 6: return y|1;
    case 7: return y&4;
    case 8: return y|5;
    case 9: return y-3;
    case 10: return y&8;
    case 11: return y|9;
    default: return y;
  }
}

int blah_num;
void *thread_fn(void *dummy) {
  while (1) {
    blah_num = blah(&mutating_number, blah_num);
  }
}

int main(void) {
  pthread_t thread;
  pthread_create(&thread, NULL, thread_fn, NULL);
  while (1) {
    *(volatile int *)&mutating_number = 1;
    *(volatile int *)&mutating_number = 100000000;
  }
}
$ gcc-9 -O2 -pthread -o gcc-jump-crash gcc-jump-crash.c -ggdb -Wall
$ gdb ./gcc-jump-crash
[...]
(gdb) run
[...]
Thread 2 "gcc-jump-crash" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff7db6700 (LWP 33237)]
0x00005555555551a2 in blah (x=0x555555558034 <mutating_number>, y=0)
at gcc-jump-crash.c:6
6   switch (*x) {
(gdb) x/10i blah
   0x555555555190 <blah>: cmp    DWORD PTR [rdi],0xb
   0x555555555193 <blah+3>: ja     0x555555555050 <blah+4294966976>
   0x555555555199 <blah+9>: mov    eax,DWORD PTR [rdi]
   0x55555555519b <blah+11>: lea    rdx,[rip+0xe62]        # 0x555555556004
=> 0x5555555551a2 <blah+18>: movsxd rax,DWORD PTR [rdx+rax*4]
   0x5555555551a6 <blah+22>: add    rax,rdx
   0x5555555551a9 <blah+25>: jmp    rax
   0x5555555551ab <blah+27>: nop    DWORD PTR [rax+rax*1+0x0]
   0x5555555551b0 <blah+32>: lea    eax,[rsi-0x3]
   0x5555555551b3 <blah+35>: ret
(gdb)


Here's a presentation from Felix Wilhelm, a security researcher who
managed to find a case in the Xen hypervisor where a switch() on a
value in shared memory was exploitable to compromise the hypervisor
from inside a guest (see slides 35 and following):
<https://www.blackhat.com/docs/us-16/materials/us-16-Wilhelm-Xenpwn-Breaking-Paravirtualized-Devices.pdf>

I realize that a compiler is extremely unlikely to make such an
optimization decision for a simple "if (!a->b)" branch; but still, I
would prefer to have READ_ONCE() everywhere where it is semantically
required, not just everywhere where you can think of a concrete
compiler optimization that will break stuff.

> > > +                       ret = add_watch_to_object(watch, s->s_watchers);
> > > +                       if (ret == 0) {
> > > +                               spin_lock(&sb_lock);
> > > +                               s->s_count++;
> > > +                               spin_unlock(&sb_lock);
> >
> > Where is the corresponding decrement of s->s_count? I'm guessing that
> > it should be in the ->release_watch() handler, except that there isn't
> > one...
>
> Um.  Good question.  I think this should do the job:
>
>         static void sb_release_watch(struct watch *watch)
>         {
>                 put_super(watch->private);
>         }
>
> And this then has to be set later:
>
>         init_watch_list(wlist, sb_release_watch);

(And as in the other case, the s->s_count increment will probably have
to be moved above the add_watch_to_object(), unless you hold the
sb_lock around it?)
