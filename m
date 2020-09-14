Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA1269723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 22:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgINUxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 16:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgINUxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:53:50 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D232C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 13:53:49 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so763199lfr.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6qVsUwsNb0PU6wGHE3vfJih+i2SYx/Y/nPHj6WpL54=;
        b=e8VuIxqe+l4+N84yRJC6lPyclo5rDs0V1EJHccxRpspBH1/hPrJMWVpmRYrNpZlY4Q
         FKEF4V9DfJ1Dr3Z7iQwmMM0KbjO5UHpasBwDFCdlJJBo9CJEgS8PNqAfA8pvRiU5BiNV
         fm5pBdYHfHO1UXjsxNwOcHkstcluHp4FqKGOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6qVsUwsNb0PU6wGHE3vfJih+i2SYx/Y/nPHj6WpL54=;
        b=pCbkz3apTQxGvMACkHr8f3AXUuw61lzwKq048/jSWnc46lhzDaPxcR7KiDNrV72hKC
         56XcSz174wFzLHUlYjGz2uwa4hXPBHTPpfV03TRvBvVkCIarlu4L2Xgjm+jJVNQkkD/l
         oYoywUfh7oasshuI+5emXd7ZvHTmJDQVa45GEbbvjTgWe7JHh2xAjZYT1ZihsV5BMwA6
         W3Sj7VbJrBY+smmaBvENEmMbi8Fbhuh605FGR+ju6q7o9YBBd02J02Ui+RtVIKGzIr90
         8icXL2VxOxRn40jQQp/Y277KcPHmPb6SOdC9vQT3e0cN20y6v8HltGD8q9yXcoByEhOd
         4jyg==
X-Gm-Message-State: AOAM532tcdnwzMM4iM5cPvISSR2CHs9UtIbS/xfZavipeCyEICbdLMnl
        lmH5kxiLo2GfUaX9WiFVC/T/jKI9yA1CPQ==
X-Google-Smtp-Source: ABdhPJwaONZhAQRT47S9iNOaukBG+KSkeBUhLEZYRPpxTPbpBwxvuEhmHu24DFOOizwsvWRzZDRAYA==
X-Received: by 2002:ac2:495a:: with SMTP id o26mr5686742lfi.94.1600116827067;
        Mon, 14 Sep 2020 13:53:47 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id q4sm2148744lfm.46.2020.09.14.13.53.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 13:53:46 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r24so893472ljm.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 13:53:45 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr6044069ljp.312.1600116825294;
 Mon, 14 Sep 2020 13:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net>
In-Reply-To: <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 13:53:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
Message-ID: <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 1:21 PM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Recently, some of these packetdrill tests have been failing after 2
> minutes (timeout) instead of being executed in a few seconds (~6
> seconds). No packets are even exchanged during these two minutes.

Hmm.

That sounds like a deadlock to me, and sounds like it's a latent bug
waiting to happen.

One way I can see that happening (with the fair page locking) is to do
something like this

thread A does:
  lock_page()
    do something

thread B:
  lock_page - ends up blocking on the lock

thread A continue:
   unlock_page() - for the fair case this now transfers the page lock
to thread B
   .. do more work
   lock_page() - this now blocks because B already owns the lock

thread B continues:
  do something that requires A to have continued, but A is blocked on
B, and we have a classic ABBA deadlock

and the only difference here is that with the unfair locks, thread A
would get the page lock and finish whatever it did, and you'd never
see the deadlock.

And by "never" I mean "very very seldom". That's why it sounds like a
latent bug to me - the fact that it triggers with the fair locks
really makes me suspect that it *could* have triggered with the unfair
locks, it just never really did, because we didn't have that
synchronous lock transfer to the waiter.

One of the problems with the page lock is that it's a very very
special lock, and afaik has never worked with lockdep. So we have
absolutely _zero_ coverage of even the simplest ABBA deadlocks with
the page lock.

> I would be glad to help by validating new modifications or providing new
> info. My setup is also easy to put in place: a Docker image is built
> with all required tools to start the same VM just like the one I have.

I'm not familiar enough with packetdrill or any of that infrastructure
- does it do its own kernel modules etc for the packet latency
testing?

But it sounds like it's 100% repeatable with the fair page lock, which
is actually a good thing. It means that if you do a "sysrq-w" while
it's blocking, you should see exactly what is waiting for what.

(Except since it times out nicely eventually, probably at least part
of the waiting is interruptible, and then you need to do "sysrq-t"
instead and it's going to be _very_ verbose and much harder to
pinpoint things, and you'll probably need to have a very big printk
buffer).

There are obviously other ways to do it too - kgdb or whatever - which
you may or may not be more used to.

But sysrq is very traditional and often particularly easy if it's a
very repeatable "things are hung". Not nearly as good as lockdep, of
course. But if the machine is otherwise working, you can just do

    echo 'w' > /proc/sysrq-trigger

in another terminal (and again, maybe you need 't', but then you
really want to do it *without* having a full GUI setup or anythign
like that, to at least make it somewhat less verbose).

Aside: a quick google shows that Nick Piggin did try to extend lockdep
to the page lock many many years ago. I don't think it ever went
anywhere. To quote Avril Lavigne: "It's complicated".

                 Linus
