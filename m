Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14717118B30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLJOin (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 09:38:43 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42546 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfLJOim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:38:42 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so20128787ljo.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDCHPQReBntofdAnn2O3tHEDWDHTESE5vX9R+bp/+qE=;
        b=uOlWfbUxA5UXwqcXYedV/SuV2axkuGm9xKU7ABK6lTkUT4fyN74FMpSrJFptS5tqZW
         RLWgkIyqU+SQx6MAd/po4ZrUvxRQWurd8JxdtHrRu5Za8TCfjoYfsQ9Zsnduf57G8v5d
         dR5HC/PopNRnLxx/SY3ZRVt/z+FiBctLn2l3tMlFxeLMSyz6TTSkhIHPLyQ8UV1BSlX8
         kyJHuyhWbXVF6iwIwk+Il69xb+nyzdXMw+aw8dLBAwvgvPlRyIgHuVoNFnYNTwrCcral
         nE/xSk7+i2i/8dFW5QUTq3Va5CsAAbuxQE1aPbgWDJgAjKc9KMJCleTCeEpa9m5ZE7L9
         GzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDCHPQReBntofdAnn2O3tHEDWDHTESE5vX9R+bp/+qE=;
        b=hKQY5npItU45g3Pb0jZwsODlw+pMiY2KM56u7YgL5q41yJMKrkKsLYg6aC9QREkY9g
         ni1HWpn8Oo2I8wOWKqQ2yS94sRshPnhEJcOhrHryGmmckgR0DdONkSzC2AqJCuyIXR4N
         1FhbA/PBLvSf5AU1OX01+sDOvqTxyI0H1AIALX41tgjgEMbWECwpJ1hAQozvxHCD6nNg
         dEeFjZf3pRw2ueGG1MHEA3nicvaYc8GBsrU0Xfu90pNYy+P9FW74stqKokdGqBHTjBi4
         Yb8PZKzJl8hS8BeYonEcv0M21wcpK12ZWbZ8rr3TfwPLGMgjSGrFeqrzKy3l5wrX1Ob0
         3z2A==
X-Gm-Message-State: APjAAAVkWpithHFxhGSDcPcMrb/qNzQNyD9iIogrCouRoZ1ANWZuA1GA
        rjqaweeBbOQgRN4SUzLVqVXU6/ZR7Kn2xTOekIeNGQ==
X-Google-Smtp-Source: APXvYqweMxaRi1IEGtTTml4mr2+nxOL0DbKH/2SATGEcQ87DZet0Cut1IAAXfjouoPQcl6cKIIOUAwUazVr9VPcqcdg=
X-Received: by 2002:a2e:2c0a:: with SMTP id s10mr20007991ljs.193.1575988719912;
 Tue, 10 Dec 2019 06:38:39 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com> <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 10 Dec 2019 15:38:28 +0100
Message-ID: <CAKfTPtASrwDcHUDqHgHP=8brALFv7ncmQuqLvihg4tQsxNUqkw@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, 9 Dec 2019 at 18:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Added DJ to the participants, since he seems to be the Fedora make
> maintainer - DJ, any chance that this absolutely horrid 'make' buf can
> be fixed in older versions too, not just rawhide? The bugfix is two
> and a half years old by now, and the bug looks real and very serious ]
>
> On Mon, Dec 9, 2019 at 1:54 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Which version of make should I use to reproduce the problem ?
>
> So the problematic one is "make-4.2.1-13.fc30.x86_64" in Fedora 30.
> I'm assuming it's fairly plain 4.2.1, but I didn't try to look into
> the source rpm or anything like that.

I'm using Debian buster and the make package is version: 4.2.1-1.2 for
arm64. It doesn't have the commit you mentioned below but I don't see
the problem on my platform and all 8 cpus are used with -j 16 or even
-j 9

>
> The working one for me was just the top of -git from
>
>     https://git.savannah.gnu.org/git/make.git
>
> which is 4.2.92 right now.
>
> The fix is presumably commit b552b05 ("[SV 51159] Use a non-blocking
> read with pselect to avoid hangs") as per Akemi. That is indeed after
> 4.2.1, and it looks real.
>
> Before that commit the buggy jobserver code basically does
>
>  (1) use pselect() to wait for readable and see child deaths atomically
>  (2) use blocking read to get the token
>
> and while (1) is atomic, if the child death happens between the two,
> it goes into the blocking read and has SIGCHLD blocked, so it will try
> to read the token from the token pipe, but it will never react to the
> child death - and the child death is what is going to _release_ a
> token.
>
> So what seems to happen is that when the right timing triggers, you

That can explain why I can't see the problem on my platform

> end up with a lot of sub-makes waiting for a token, but they are also
> all supposed to _release_ a token. So you don't have enough tokens to
> go around. In the worst case, _everybody_ who has a token is also not
> releasing it, and then you end up triggering the timeout code (after
> one second), which will make things really go into a crawl.
>
> And by a crawl I mean that worst-case you really end up with just one
> job per second per sub-make. It will take _hours_ to compile the
> kernel at that speed, when it normally finishes in 15 minutes on my
> machine even when I do a from-scratch allmodconfig build.
>
> It does seem to be a major bug in the jobserver code. In particular
> with the trial fair and exclusive wakeup patch that I sent out in the
> other thread, it seems to be _reliably_ much worse and triggers 100%
> of the time for me.
>
> It's possible that my trial patch is buggy, but everything else looks
> fine, and with a fixed make the trial patch works for me.
>
> I'll include the trial patch here too, I think I cc'd you on the other
> thread too, but hey..
>
> Anyway, it looks like the sync wakeup thing is more of a "get timing
> right by luck" thing than anything else. Possibly it actually causes
> the reverse order of reader wakeups more often (ie the most _recent_
> reader is most likely to get woken up synchronously) and that may be
> what really ends up masking the jobserver problem, since apparently
> doing wakeups in the fair and proper order makes things much worse..
>
> What a horrible pain that pipe rework ended up being. But I think
> we're in better shape now than we used to be, it just had very
> unfortunate timing issues and several real bugs.
>
> But sadly, there's no way I can push that fair pipe wakeup thing as
> long as this horribly buggy version of make is widespread.
>
>                  Linus
