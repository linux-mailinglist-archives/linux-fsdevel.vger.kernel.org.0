Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891E72B9BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 21:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKSUNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 15:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKSUNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 15:13:45 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22399C0613CF;
        Thu, 19 Nov 2020 12:13:43 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id o21so9718369ejb.3;
        Thu, 19 Nov 2020 12:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytDY3lgvXULFrVxphJeXz69M1pGNIZ7Kfu6CGGtsbzU=;
        b=lUt0gpgOQcWF+BPObZOrL66x7ZT/EeuqT9y9GIp1uLdh3KeAh4nHO1G7Zo3IHB0nqG
         wPlUIYb404F1DWOejOsrC6M93xFU3AChVkOKyce4qlolngQnD1Vws1sGqASnTBLij2tn
         Qjo0jwOGV+cGFita5U/R66O0Mo2iuco5r8YPDO2Cozs1mgoT54RDmeoZMbyXqb2Kv/Wu
         vP5RxehI39U0lKZj/ViZQS7ENTL4tAMXhLU+6sjMQkxD5xZS74KqTV4TMxv0cb9UCks3
         Gc0a+gnPjCScLj6BhqraWYyXaQRM8/AToTErKzLIvh56aeoa0XgOtjZzTnKbQiplWw/e
         DuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytDY3lgvXULFrVxphJeXz69M1pGNIZ7Kfu6CGGtsbzU=;
        b=Y11CLsKbHFEHlcwUF2K66zZJhInn2dFrvweEUhcQzDcy/2KFnvPFcs0uMxniafGTws
         Tq/kwoZH/fYLvVKwEBnpBEVOhdMseoCHsCrtSvUwdP5xwRfeubkh4Z3A3HNLtaZQqvtL
         aQqosjfZ5SVa4HRQwgGwrO+qlMTRJtbaqO5Yvs1aC//sOSpOIGOXJKktTqSwmt3Cekye
         9H48b0zD+aBDFbcXSgmopCxgktVVNHooKKkqgaPsj+8NyS7IsdzBOvIlh1QlHYqdr33k
         Uzz2s8Teg8mmzZSzAU9EvledWc6PX9iKeb/Rx/6lftD4dW8lw31jGk5bcuoXDQrskmFc
         T+Fw==
X-Gm-Message-State: AOAM533E3l7MmCbZpiqzxr1bFZVZcQ05N2A/2d7R2yOdlH14o7u8D8Op
        JI7iXpRQv/geh90to3c58EXaLyijy9H81jsOkAo=
X-Google-Smtp-Source: ABdhPJyEQJUZJTBbjnme7vrNNluonOh9/+gzEn6XzuK9sHgg2qDy1W0EuCGBe9VRPK7ceUEEKr9+XWOxBtr91WHaZlo=
X-Received: by 2002:a17:906:a4b:: with SMTP id x11mr30882606ejf.11.1605816821857;
 Thu, 19 Nov 2020 12:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
In-Reply-To: <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 19 Nov 2020 15:13:05 -0500
Message-ID: <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Nov 19, 2020 at 3:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Nov 19, 2020 at 09:19:35AM -0500, Willem de Bruijn wrote:
> > > But for epoll, this is inefficient: in ep_set_mstimeout it calls
> > > ktime_get_ts64 to convert timeout to an offset from current time, only
> > > to pass it to select_estimate_accuracy to then perform another
> > > ktime_get_ts64 and subtract this to get back to (approx.) the original
> > > timeout.
>
> Right, it would be good to avoid the second ktime_get_ts64(), as reading
> the clocksource itself can be expensive.
>
> > > How about a separate patch that adds epoll_estimate_accuracy with
> > > the same rules (wrt rt_task, current->timer_slack, nice and upper bound)
> > > but taking an s64 timeout.
> > >
> > > One variation, since it is approximate, I suppose we could even replace
> > > division by a right shift?
>
> The right shift would work indeed, but it's also a bit ugly unless
> __estimate_accuracy() is changed to always use the same shift.
>
> I see that on 32-bit ARM, select_estimate_accuracy() calls
> the external __aeabi_idiv() function to do the 32-bit division, so
> changing it to a shift would speed up select as well.
>
> Changing select_estimate_accuracy() to take the relative timeout
> as an argument to avoid the extra ktime_get_ts64() should
> have a larger impact.

It could be done by having poll_select_set_timeout take an extra u64*
slack, call select_estimate_accuracy before adding in the current time
and then pass the slack down to do_select and do_sys_poll, also
through core_sys_select and compat_core_sys_select.

It could be a patch independent from this new syscall. Since it changes
poll_select_set_timeout it clearly has a conflict with the planned next
revision of this. I can include it in the next patchset to decide whether
it's worth it.

> > > After that, using s64 everywhere is indeed much simpler. And with that
> > > I will revise the new epoll_pwait2 interface to take a long long
> > > instead of struct timespec.
> >
> > I think the userspace interface should take a struct timespec
> > for consistency with ppoll and pselect.  And epoll should use
> > poll_select_set_timeout() to convert the relative timeout to an absolute
> > endtime.  Make epoll more consistent with select/poll, not less ...
>
> I don't see a problem with an s64 timeout if that makes the interface
> simpler by avoiding differences between the 32-bit and 64-bit ABIs.
>
> More importantly, I think it should differ from poll/select by calculating
> and writing back the remaining timeout.
>
> I don't know what the latest view on absolute timeouts at the syscall
> ABI is, it would probably simplify the implementation, but make it
> less consistent with the others. Futex uses absolute timeouts, but
> is itself inconsistent about that.

If the implementation internally uses poll_select_set_timeout and
passes around timespec64 *, it won't matter much in terms of
performance or implementation. Then there seems to be no downside to
following the consistency argument.
