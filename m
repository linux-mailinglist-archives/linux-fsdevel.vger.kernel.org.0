Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099D3118F28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 18:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfLJRkB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 12:40:01 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34295 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfLJRkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:40:00 -0500
Received: by mail-lf1-f68.google.com with SMTP id l18so14428526lfc.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snXL3elBaJqUNnrwVMIQkoX2BmfJlCnkqeekmLy0jJI=;
        b=OhxH2R6Nr1ZTcmvFCJY4c42Wn+5iOTjxo201wAntKVyS+2zt9hCNsDqSOWhbVWmxQ6
         U4hf3Qf1NBY2kCFTQYJBLj+p0aj0dRmcpAQcHsx7GI/58+pcMdfjSx9IppPGmLYMx3Oq
         n1Ki3WOVdVWhlVz0yApcldThYREPXTHwKeMa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snXL3elBaJqUNnrwVMIQkoX2BmfJlCnkqeekmLy0jJI=;
        b=BPt5gLbDz7+S4fKrtFtpwwjr82aO7EqGZUUwI07MTBKGZTGQr1eVbBrxZM7Cv01fod
         pLOPw47puHUkP89LM0VT44kVmqZMNqA7UgIPDykZQyp+aurPX12jtC5S1SVOVkKsCx1Z
         YkRzKUgxSp9073sNdnSyjKzhpIA6D0HF5VrmUFvDQizTYGjtE1ZU2YdWZe+pa3RuoW6s
         giz40cKmU7/cPjM1ZyUieO0xeql1WUQrsttZS/Ra9aGcXXDQx2gOcPnIgymspeM0ttSe
         NNRoDLdOJEQC0DWsPLghI6+pALDWbh55n3gMbzODckdk+r12WjyZe8OYqA22WGmi4bxX
         d/4Q==
X-Gm-Message-State: APjAAAVsuzWKdlOvaqqTIJtq0FbslNHYIOgVVltSTgtFK1ftX4c2kvlt
        ANYNLJB4zGZSXcve7l+SYaSoCfU0AAs=
X-Google-Smtp-Source: APXvYqyl5WC9qQSvRJpcR3wwA+xLW5lYF8UXpVNjrAuEKd8rCQ/qjbBL2YTlW428HtQWZQ4QEmJjMA==
X-Received: by 2002:a19:40d8:: with SMTP id n207mr19788443lfa.4.1575999596864;
        Tue, 10 Dec 2019 09:39:56 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id i2sm1957420lfl.20.2019.12.10.09.39.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 09:39:55 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id y1so3090515lfb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 09:39:55 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr19498327lfm.29.1575999594895;
 Tue, 10 Dec 2019 09:39:54 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
 <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com> <CAKfTPtASrwDcHUDqHgHP=8brALFv7ncmQuqLvihg4tQsxNUqkw@mail.gmail.com>
In-Reply-To: <CAKfTPtASrwDcHUDqHgHP=8brALFv7ncmQuqLvihg4tQsxNUqkw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Dec 2019 09:39:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkxNmK1pGfDaA5PqsPYpZO9tL-a4R4mpY-UhSX4f-RFg@mail.gmail.com>
Message-ID: <CAHk-=wgkxNmK1pGfDaA5PqsPYpZO9tL-a4R4mpY-UhSX4f-RFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     DJ Delorie <dj@redhat.com>, David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 6:38 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 9 Dec 2019 at 18:48, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Before that commit the buggy jobserver code basically does
> >
> >  (1) use pselect() to wait for readable and see child deaths atomically
> >  (2) use blocking read to get the token
> >
> > and while (1) is atomic, if the child death happens between the two,
> > it goes into the blocking read and has SIGCHLD blocked, so it will try
> > to read the token from the token pipe, but it will never react to the
> > child death - and the child death is what is going to _release_ a
> > token.
> >
> > So what seems to happen is that when the right timing triggers, you
>
> That can explain why I can't see the problem on my platform

Note that the above is kind of simplified.

It actually needs a bit more to trigger..

To lose _one_ token, you need to have a sub-make basically hit this race:

 - the pselect() needs to say that the pipe is readable, so there is
at least one token

 - another sub-make comes along and steals the very last token

 - but because pselect returned "readable" (no SIGCHLD yet), the
read() starts and now blocks because all the jobserver tokens are gone
again due to the other sub-make stealing the last one.

 - before a new token comes in, the child exits, and now because the
sub-make is blocking for reads (and because the jobserver blocks
SIGCHILD in general outside of the pselect), it doesn't react, so it
won't release the token that the child holds.

but notice how any _other_ sub-make then releasing a token will get
things going again, so the _common_situation is that the jobserver bug
only causes a slight  dip in concurrency.

Hitting it _once_ is trivial.

Losing several tokens at once is also not that hard: you don't need to
hit the race many times, it's enough to hit the exact same race just
once - just with several sub-makes at the same time.

And that "lose several tokens at once" isn't as unlikely as you'd
think: they are all doing the same thing, and they all saw the free
token with "pselect()", they all did a "read()". And since it's common
for the tokens to be gone, the common case is that _one_ of the
waiting sub-makes got the read, and the N other sub-makes did not, and
went into the blocking read(). And they all had children that were
about to finish, and finished before the next token got available.

So losing quite a few tokens is easy.

This has actually gone on for a long time, and I just never debugged
it. My solution has been "I have 16 threads (8 core with HT), but I'll
use -j32, and it is all good".

I bet you can see it too - the buggy jobserver just means that the
load isn't as high as you'd expect. Just run 'top' while the make is
going.

With the _fixed_ jobserver, if I do "make -j32", I will actually see a
load that is over 32 (I do nothing but kernel compiles and occasional
reboots during the merge window, so I have the kernel in my cache, so
there's no IO, I have a fast SSD so writeback doesn't cause any delays
either etc etc, and I have my browser and a few other things going).

With the buggy one, even before the pipe rework, I would see a load
that tended to fluctuate around 16.

Because due to the bug you have a few locked-up tokens at times, so
instead of getting a load of 32 when you use "make -j32", you get a
load of maybe 20. Or maybe less.

The pipe re-work made it much easier to trigger the "almost all the
tokens are gone" for some reason. And the "fair readers()" patch I
have seems to make it _really_ easy to trigger the case where
absolutely all the tokens were gone and it goes into a single-thread
mode. I'm not sure I really ever saw the 1-second timeout trigger, but
it was slow.

But it _is_ dependent on timing, so somebody else with a different
load - or a different machine - might not see it to nearly the same
degree.

I bet you see the load value difference, though, even if you don't
necessarily see enough idle CPU time to see much of a difference in
compile times. After all, once you have all CPU's busy, it doesn't
matter if you have a load of 16 or a load of 32 - the higher load
won't make the compile go any faster.

             Linus
