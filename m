Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD57135E0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 00:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfECWyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 18:54:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46729 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfECWyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 18:54:07 -0400
Received: by mail-io1-f68.google.com with SMTP id m14so6499814ion.13;
        Fri, 03 May 2019 15:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpmsefFkKENLhwDrCpj25TPAnORDkEylQ4qkeca+hkQ=;
        b=WniCcG2iJ9enM4hYM+5hQyzBCu07Qqs6sOBsDQG4m51/PHvGW8OGhFgCrAvItUNIcu
         1mKpcAPc59g+Etix2JDZsL+siLgOXFYVPhBPll/ctjIX6BsIx/15NHo7F7Xqna11BD/Q
         rR/SvzKuXmKNRkDegy3m0TZh66MkGWQzJ+cfOIwzmQL8qQ7zkL+kYhPKuSGveGOUBevU
         qkwe5EmxZEJm3POkcoXntoSiNnxjGCzodEsCAxK6TDVzfxWy9xec1xx+FuIjStoK1OXz
         QAW7WpEAIHdjLBN68BgQ49nTVeLvVClfBT2gtD4GVZxZPK2HVHtfYEsgwEH0hkuNUopV
         gnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpmsefFkKENLhwDrCpj25TPAnORDkEylQ4qkeca+hkQ=;
        b=nuMwKry3l0hiHg76Od5s0pQhVdQNlYAyEoD4jllcafMlhiZkIt7ucM2Ly/1kKyOP5q
         Hm3CIjfdTuEDFWTYmUS3KYWwyKpkKrfXEsxs+lZSh8Gcef4Ul0YWiqxuNmC6BnP1M8u8
         StevGri7RCkB8xK6SJWWlVs8p3HcNKRJ8ef5xQ/lR+t6lEB7yMQSxyXX9VGZNKuqCu5t
         rEyCMMW0Q+var+ZiL0lZV9LszSTtC1Qd84at2vMLtrZcX2h1hh26CWxpSgSKLiyDvp7H
         j4IpmHt71/hcsQQ8WILL5oZpVh2w/Pz12kQQ/zuRRt6a1yWmqrolFhuR4HNxVBa4AQj5
         S6Tw==
X-Gm-Message-State: APjAAAVFxTI44kG0eXbXBH4kpJsqbqRqO14yaZXhyffTAvAUOeATSI58
        VzcRQ9A5NA8RYVaqGzksB463uXABPWr3Cr7y3xo=
X-Google-Smtp-Source: APXvYqw8e2TieTfJcCZsv0/c8t+mpDpYPEo9G9zrWgipNP35rHCY92tvfGmdgc/GcEU/NxvR6rgtxcCVOmuxe0JA8Vc=
X-Received: by 2002:a6b:7a09:: with SMTP id h9mr1900505iom.266.1556924046853;
 Fri, 03 May 2019 15:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190503033440.cow6xm4p4hezgkxv@linux-r8p5> <20190503034205.12121-1-deepa.kernel@gmail.com>
 <20190503195148.t6hj4ly3axqosse3@linux-r8p5>
In-Reply-To: <20190503195148.t6hj4ly3axqosse3@linux-r8p5>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Fri, 3 May 2019 15:53:42 -0700
Message-ID: <CABeXuvquQoBTWb3sx0DCkpeSjphF9w6W-dMh0v85N7qrjQJCSg@mail.gmail.com>
Subject: Re: [PATCH] signal: Adjust error codes according to restore_user_sigmask()
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Wong <e@80x24.org>, Omar Kilani <omar.kilani@gmail.com>,
        Jason Baron <jbaron@akamai.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The original patch was merged through the tip tree. Adding tglx just in case.

I will post the revised patch to everyone on this thread.

> >For all the syscalls that receive a sigmask from the userland,
> >the user sigmask is to be in effect through the syscall execution.
> >At the end of syscall, sigmask of the current process is restored
> >to what it was before the switch over to user sigmask.
> >But, for this to be true in practice, the sigmask should be restored
> >only at the the point we change the saved_sigmask. Anything before
> >that loses signals. And, anything after is just pointless as the
> >signal is already lost by restoring the sigmask.
> >
> >The issue was detected because of a regression caused by 854a6ed56839a.
> >The patch moved the signal_pending() check closer to restoring of the
> >user sigmask. But, it failed to update the error code accordingly.
> >
> >Detailed issue discussion permalink:
> >https://lore.kernel.org/linux-fsdevel/20190427093319.sgicqik2oqkez3wk@dcvr/
> >
> >Note that the patch returns interrupted errors (EINTR, ERESTARTNOHAND,
> >etc) only when there is no other error. If there is a signal and an error
> >like EINVAL, the syscalls return -EINVAL rather than the interrupted
> >error codes.
>
> Thanks for doing this; I've reviewed the epoll bits (along with the overall
> idea) and it seems like a sane alternative to reverting the offending patch.

Sorry maybe the description wasn't clear. What I actually am saying is
that all these syscalls were dropping signals before and
854a6ed56839a4 actually did things right by making sure they did not
do so.
But, there was a bug in that it did not communicate to userspace when
the error code was not already set.
However, we could still argue that the check and flipping of the mask
isn't atomic and there is still a way this can theoretically happen.
But, this will also mean that these syscalls will slow down further.
But, they are already expected to be slow so maybe it doesn't matter.
I will note this down in the commit text.
I don't think reverting was an alternative. 854a6ed56839a4 exposed a
bug that was already there.

> Feel free to add:
>
> Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
>
> A small nit, I think we should be a bit more verbose about the return semantics
> of restore_user_sigmask()... see at the end.
>
> >
> >Reported-by: Eric Wong <e@80x24.org>
> >Fixes: 854a6ed56839a40f6b5d02a2962f48841482eec4 ("signal: Add restore_user_sigmask()")
> >Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> >--- a/kernel/signal.c
> >+++ b/kernel/signal.c
> >@@ -2845,15 +2845,16 @@ EXPORT_SYMBOL(set_compat_user_sigmask);
> >  * usigmask: sigmask passed in from userland.
> >  * sigsaved: saved sigmask when the syscall started and changed the sigmask to
> >  *           usigmask.
> >+ * returns 1 in case a pending signal is detected.
>
> How about:
>
> "
> Callers must carefully coordinate between signal_pending() checks between the
> actual system call and restore_user_sigmask() - for which a new pending signal
> may come in between calls and therefore must consider this for returning a proper
> error code.
>
> Returns 1 in case a signal pending is detected, otherwise 0.

Ok, I will add more verbiage here.

Thanks,
Deepa
