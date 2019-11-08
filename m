Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975A3F57E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 21:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfKHTsn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 14:48:43 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42984 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbfKHTsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:48:43 -0500
Received: by mail-vk1-f194.google.com with SMTP id r4so1769516vkf.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2019 11:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyD23O5RyQ9n1+J0Rmot/Yfd1nJUcElECbIwZO2sFUA=;
        b=iIBxTZqzi92g6E3Yd+VApnsY9O2aLhrUrjJDyu2FNmtAqJhtKqg9yQPrmivVsiGdep
         9j+c77PItW7VOWrAT97M+gBlJcid/7ePvIViaxdRMEBZmSm3METY83Q8oDotAkHlZDM5
         JeYJlqDx9lkFGcydbB/Ax0BFXw51MfaSzV/36KFZut4oPml6EHFphPLlvHKaxX2yKtNd
         6PgJxUsaA2+dS+/5trHIJJA4OIcWuiUbPDIp8IIKlX1HLpncDNfbL7Tr/fSN1HCA0p3u
         YgCRctdIF2kayVb1LvN9OpqgemOupYdoxUf61EZQcFvDRCQDWUa3YTDEccRGoHgdUjRo
         9W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyD23O5RyQ9n1+J0Rmot/Yfd1nJUcElECbIwZO2sFUA=;
        b=Ad4M3BTbKh4omJ14uyCHBvHEc7dc4OK8N+TzwejIaC/BcyfvDLTsX4OMOYYkpBPBqy
         Lduq4t9zfTqSnUsMWYjgtvWDMSCJ9U43pHnBzZGY+tRTz7ZoB0Q9tIXWnp7dlEnR1KL5
         ZnZ6vJwb9RaIeM4Ym4cnmuG3WKuVeS41VLq5QCHbr5PoS4eQCkf5tJeD0n9FHDlZhO1n
         t37q18Zrl+tBHoMZVA1rvp4qdFBH6CdASPxdYZy9rDR454zd0EAL8mBtprfVtyYQHXY0
         Bu/u4ws445z2xy4dVlDEJLraG5Lv71THF1K/pn2TU7NAbBBrfpuATYk2Nqv4qNf4OwxC
         z4Sw==
X-Gm-Message-State: APjAAAUUWT9fWYbuWUVSIdTO6hFUIiinPc6IIYtd6yxvezZLM2DGm/Cu
        fcVMMwLR7oZWm0iE9ize1OLDqUR6wJG53hsqOcsn0w==
X-Google-Smtp-Source: APXvYqwPlad8fMXaYo7ilZfoeUpCGfAZ/SG1/D/FP8my0qQ8yTpypRLxHH0XdtCMWlJduzxIj/5Jyj8qcN7BXblMCkc=
X-Received: by 2002:a1f:8dc5:: with SMTP id p188mr8815941vkd.13.1573242521478;
 Fri, 08 Nov 2019 11:48:41 -0800 (PST)
MIME-Version: 1.0
References: <000000000000c422a80596d595ee@google.com> <6bddae34-93df-6820-0390-ac18dcbf0927@gmail.com>
 <CAHk-=whh5bcxCecEL5Fy4XvQjgBTJ9uqvyp7dW=CLU6VNxS9iA@mail.gmail.com>
 <CANn89iK9mTJ4BN-X3MeSx5LGXGYafXkhZyaUpdXDjVivTwA6Jg@mail.gmail.com>
 <CAHk-=whNBL63qmO176qOQpkY16xvomog5ocvM=9K55hUgAgOPA@mail.gmail.com>
 <CANn89iJJiB6avNtZ1qQNTeJwyjW32Pxk_2CwvEJxgQ==kgY0fA@mail.gmail.com>
 <CAHk-=wiZdSoweA-W_8iwLy6KLsd-DaZM0gN9_+f-aT4KL64U0g@mail.gmail.com>
 <CANpmjNOuRp0gdekQeodXm8O_yiXm7mA8WZsXZNmFfJYMs93x8w@mail.gmail.com> <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com>
In-Reply-To: <CAHk-=wjodfXqd9=iW=ziFrfY7xqopgO3Ko_HrAUp-kUQHHyyqg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 8 Nov 2019 20:48:29 +0100
Message-ID: <CANpmjNO6UgNS9h5ZwSV2c+uKz04ch96d+f0-jquDj_ekOjr5bQ@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 8 Nov 2019 at 19:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Nov 8, 2019 at 10:16 AM Marco Elver <elver@google.com> wrote:
> >
> > KCSAN does not use volatile to distinguish accesses. Right now
> > READ_ONCE, WRITE_ONCE, atomic bitops, atomic_t (+ some arch specific
> > primitives) are treated as marked atomic operations.
>
> Ok, so we'd have to do this in terms of ATOMIC_WRITE().
>
> One alternative might be KCSAN enhancement, where you notice the
> following pattern:
>
>  - a field is initialized before the data structure gets exposed (I
> presume KCSAN already must understand about this issue -
> initializations are different and not atomic)
>
>  - while the field is live, there are operations that write the same
> (let's call it "idempotent") value to the field under certain
> circumstances
>
>  - at release time, after all the reference counts are gone, the field
> is read for whether that situation happened. I'm assuming KCSAN
> already understands about this case too?

It's not explicitly aware of initialization or release. We rely on
compiler instrumentation for all memory accesses; KCSAN then sets up
"watchpoints" for sampled memory accesses, delaying execution, and
checking if a concurrent access is observed.

We already have an option (currently disabled on syzbot) where KCSAN
infers a data race not because another instrumented accesses happened
concurrently, but because the data value changed during a watchpoint's
lifetime (e.g. due to uninstrumented write, device write etc.).

This same approach could be used to ignore "idempotent writes" where
we would otherwise report a data race; i.e. if there was a concurrent
write, but the data value did not change, do not report the race. I'm
happy to add this feature if this should always be ignored.

> So it would only be the "idempotent writes" thing that would be
> something KCSAN would have to realize do not involve a race - because
> it simply doesn't matter if two writes of the same value race against
> each other.
>
> But I guess we could also just do
>
>    #define WRITE_IDEMPOTENT(x,y) WRITE_ONCE(x,y)
>
> and use that in the kernel to annotate these things. And if we have
> that kind of annotation, we could then possibly change it to
>
>   #define WRITE_IDEMPOTENT(x,y) \
>        if READ_ONCE(x)!=y WRITE_ONCE(x,y)
>
> if we have numbers that that actually helps (that macro written to be
> intentionally invalid C - it obviously needs statement protection and
> protection against evaluating the arguments multiple times etc).
>
>                 Linus

Thanks,
-- Marco
