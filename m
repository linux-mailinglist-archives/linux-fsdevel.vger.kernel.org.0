Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8885126ABD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgIOS2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 14:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgIOS1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:27:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7CC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:27:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so3739549ljk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qd9UQxfut0hXXZzFJT2meuy74mIWL2uFMX8QA4+AqJg=;
        b=YZCLf5KwWovlmSfLKqpmzcDEAyF10UYUc9DhZZy90MM3OUQp+Ev1oCFxtSUDRKXzd+
         LlCn0zf4uazyNTtCJH26wj7kEXvoCzPV6Qb7BXxj/r9ifUPX3DcozQleedXwAZN9ZGEo
         zmKHlYAru5kQsLQh0RPI5YC1rKJiqPlN+n6D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qd9UQxfut0hXXZzFJT2meuy74mIWL2uFMX8QA4+AqJg=;
        b=fcgI7LUU3mo4j1gH59viRG9kGQsT+6v3NQtw/bZGbNKH4I/f4ntzt3To/OF/c32O1Q
         XjuJERQVWs4fKQb/DP/8jX9shzXwBZ+mcjVuVi3vAesU+oobhi8lbbK/W8pMW12OHTER
         +d6cYS+XqtkBwXIzch1ggEOSCuPGlYFMVeNyOCOhZgK9dJQeNzib/iOzeJ1UBLjqegPc
         ZpUnElADHvBnvCtuS+TiC/cnNcW2r5vAnIPK/eX4LObxoItWCdewbE3irhHa3MlbP9qg
         7HYs8czZALlzaomJzjT96PTTtevOwx7AdhTA4qOf31weqE65iGoJFHOFdKAEbQe1p2mn
         xfgw==
X-Gm-Message-State: AOAM532q+lfdk9LDBvgPIj4f0Ss9OblY9mf/zVNGD7KpfOf0+eV+2EOs
        KZzOh9Yf4q0TInNC0N0Dj1ixveCC8utOPQ==
X-Google-Smtp-Source: ABdhPJxqrVuGLRGqRskz0LrYtsjS+5V1YiY7PoF8h4mdi67/MTiojgs2hAGEkADacqdxjZs+WnpiPA==
X-Received: by 2002:a2e:88d6:: with SMTP id a22mr7711100ljk.9.1600194458123;
        Tue, 15 Sep 2020 11:27:38 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id x17sm4099820lfa.303.2020.09.15.11.27.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 11:27:36 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a15so3723713ljk.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 11:27:36 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr6691288ljh.70.1600194456034;
 Tue, 15 Sep 2020 11:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
 <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
In-Reply-To: <9550725a-2d3f-fa35-1410-cae912e128b9@tessares.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Sep 2020 11:27:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
Message-ID: <CAHk-=wimdSWe+GVBKwB0_=ZKX2ZN5JEqK5yA99toab4MAoYAsg@mail.gmail.com>
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

On Tue, Sep 15, 2020 at 8:34 AM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> > But it sounds like it's 100% repeatable with the fair page lock, which
> > is actually a good thing. It means that if you do a "sysrq-w" while
> > it's blocking, you should see exactly what is waiting for what.
> >
> > (Except since it times out nicely eventually, probably at least part
> > of the waiting is interruptible, and then you need to do "sysrq-t"
> > instead and it's going to be _very_ verbose and much harder to
> > pinpoint things, and you'll probably need to have a very big printk
> > buffer).
>
> Thank you for this idea! I was focused on using lockdep and I forgot
> about this simple method. It is not (yet) a reflex for me to use it!
>
> I think I got an interesting trace I took 20 seconds after having
> started packetdrill:

Ok, so everybody there is basically in the same identical situation,
they all seem to be doing mlockall(), which does __mm_populate() ->
populate_vma_page_range() -> __get_user_pages() -> handle_mm_fault()
and then actually tries to fault in the missing pages.

And that does do a lot of "lock_page()" (and, of course, as a result,
a lot of "unlock_page()" too).

Every one of them is in the "io_schedule()" in the filemap_fault()
path, although two of them seem to be in file_fdatawait_range() rather
than in the lock_page() code itself (so they are also waiting on a
page bit, but they are waiting for the writeback bit to clear).

And all of them do it under the mmap_read_lock().

I'm not seeing what else they'd be blocking on, though.

As mentioned, the thing they are blocking on might be something
interruptible that holds the lock, and might not be in 'D' state. Then
it wouldn't show up in sysrq-W, you'd have to do 'sysrq-T' to see
those..

From past experience, that tends to be a _lot_ of data, though, and it
easily overflows the printk buffers etc.

lockdep has made these kinds of sysrq hacks mostly a thing of the
past, and the few non-lockdep locks (and the page lock is definitely
the biggest of them) are an annoying blast to the past..

                    Linus
