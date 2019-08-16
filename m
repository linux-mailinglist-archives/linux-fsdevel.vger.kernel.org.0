Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9569063D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 18:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHPQzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 12:55:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41864 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfHPQzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:55:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id m24so5875467ljg.8;
        Fri, 16 Aug 2019 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnA2Hi587HpAY+vMzCUnzpDdgs4QOMI2ZHnlLxFisIQ=;
        b=Fe9iSDkOND1l9HNmW3AcpL5XfQvaS1SSBUH8WFJkOtQSru3ptC2Y1hZwPwlB3WyN5q
         TIiOzkBjlWFdCLTSLCh1J3EbeFYKJuy/re1+TNxGWDYL7V8UO6zFelU5YeLrVFYCztlB
         uVBtewWZ+sEKJU2HwjuDtbtCuScBStAvfjrhkALrofDHtQUDVQgEHKcy7a3OFWnCuKVW
         nA6ba2c4+Jvo/5AFnfHF+JIYnpn9O+MDYEvJQBsfFa6n7klwSxRlv4ybzcf1IfkRJFj6
         7Ui0Aiba5WmJW/PtFAM5KW8KnamhG8gEyAEhdBAvkBr89onaAgkNIY/Jpb4TaH1NP/6u
         nlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnA2Hi587HpAY+vMzCUnzpDdgs4QOMI2ZHnlLxFisIQ=;
        b=eDnIpLYUoB9gB0P8NqttJLSSeVC8ixE9qAIj8TAAgTMMLXhMErVTT1zfA0bn7VtoFW
         uRXWXA258c1+7HMgKVZDc9mH7+iMGZyWgwhf18aIGIS38GzQjkhBeAAXZzzhSJ9MKHQ7
         38ubJKtQMH8T7fmg0iqwisBDZxJZ7e0LkNm/7bqCUGYxAnhUL81Q1vZU0gP6Ya4b9fXN
         03aTG68bbx3AKhBfPh5JI06hwHiEjkWqXsIFtHmugKC+elpEJkVHlRlURtgYqsdzpik/
         vzuTHjl+hy6G2287Lr/a9fnAPu5YIwI0pU8+kC9yE3VB7ZAnF7oMnuMf+L9YkR8rP2qY
         0tJA==
X-Gm-Message-State: APjAAAW7ydHfvH/bvLFrwiDuHMVz93h5pwwqeIbzSOVaKSsbYFXBt3np
        Bvmj+3yrEVvzTvm8fdumzOLtnJMl5hfkFPyODOM=
X-Google-Smtp-Source: APXvYqxqb91sqNNqy9y8LRzbK57oLvfm80ZM2mSWzTt8pG7wpCRcJo5ot6kCpM5qJWj5RqSc4WYW9McBQzNck99q7Iw=
X-Received: by 2002:a2e:a0c6:: with SMTP id f6mr6204011ljm.102.1565974529247;
 Fri, 16 Aug 2019 09:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com> <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Fri, 16 Aug 2019 22:25:17 +0530
Message-ID: <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi tglx,

Thank you for your comments.
Please find my commend in-lined

On Fri, Aug 16, 2019 at 4:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Arul,
>
> On Fri, 16 Aug 2019, Arul Jeniston wrote:
>
> > Subject: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
>
> The prefix is not 'FS: timerfd:'
>
> 1) The usual prefix for fs/* is: 'fs:' but...
>
> 2) git log fs/timerfd.c gives you a pretty good hint for the proper
>    prefix. Look at the commits which actually do functional changes to that
>    file, not at those which do (sub)system wide cleanups/adjustments.
>
> Also 'timerfd_read function' can be written as 'timerfd_read()' which
> spares the redundant function and clearly marks it as function via the
> brackets.
>
> > 'hrtimer_forward_now()' returns zero due to bigger backward time drift.
> > This causes timerfd_read to return 0. As per man page, read on timerfd
> >  is not expected to return 0.
> > This problem is well explained in https://lkml.org/lkml/2019/7/31/442
>
> 1) The explanation needs to be in the changelog itself. Links can point to
>    discussions, bug-reports which have supplementary information.
>
> 2) Please do not use lkml.org links.
>
> Again: Please read and follow Documentation/process/submitting-patches.rst
>
> > . This patch fixes this problem.
> > Signed-off-by: Arul Jeniston <arul.jeniston@gmail.com>
>
> Missing empty line before Signed-off-by. Please use git-log to see how
> changelogs are properly formatted.
>
> Also: 'This patch fixes this problem' is not helpful at all. Again see the
> document I already pointed you to.
>

Agreed. Would incorporate all the above comments.

> > ---
> >  fs/timerfd.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/timerfd.c b/fs/timerfd.c
> > index 6a6fc8aa1de7..f5094e070e9a 100644
> > --- a/fs/timerfd.c
> > +++ b/fs/timerfd.c
> > @@ -284,8 +284,16 @@ static ssize_t timerfd_read(struct file *file,
> > char __user *buf, size_t count,
> >                                         &ctx->t.alarm, ctx->tintv) - 1;
> >                                 alarm_restart(&ctx->t.alarm);
> >                         } else {
> > -                               ticks += hrtimer_forward_now(&ctx->t.tmr,
> > -                                                            ctx->tintv) - 1;
> > +                               u64 nooftimeo = hrtimer_forward_now(&ctx->t.tmr,
> > +                                                                ctx->tintv);
>
> nooftimeo is pretty non-intuitive. The function documentation of
> hrtimer_forward_now() says:
>
>       Returns the number of overruns.
>
> So the obvious variable name is overruns, right?
>

Agreed. Would change the variable name to overruns.

> > +                               /*
> > +                                * ticks shouldn't become zero at this point.
> > +                                * Ignore if hrtimer_forward_now returns 0
> > +                                * due to larger backward time drift.
>
> Again. This explanation does not make any sense at all.
>
> Time does not go backwards, except if it is CLOCK_REALTIME which can be set
> backwards via clock_settime() or settimeofday().
>
> > +                                */
> > +                               if (likely(nooftimeo)) {
> > +                                       ticks += nooftimeo - 1;
> > +                               }
>
> Again: Pointless brackets.
>
> If you disagree with my review comment, then tell me in a reply. If not,
> then fix it. If you decide to ignore my comments, then don't wonder if I
> ignore your patches.
>

We use CLOCK_REALTIME while creating timer_fd.
Can read() on timerfd return 0 when the clock is set to CLOCK_REALTIME?

We have Intel rangely 4 cpu system running debian stretch linux
kernel. The current clock source is set to tsc. During our testing, we
observed the time drifts backward occasionally. Through kernel
instrumentation, we observed, sometimes clocksource_delta() finds the
current time lesser than last time. and returns 0 delta.
This causes  the following code flow to return 0
 ktime_get()-->timekeeping_get_ns()-->timekeeping_get_delta()-->clocksource_delta()

> Thanks,
>
>         tglx
