Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54F92BAF7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 17:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgKTQBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 11:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgKTQBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:01:40 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F8C0613CF;
        Fri, 20 Nov 2020 08:01:40 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id cf17so6472870edb.2;
        Fri, 20 Nov 2020 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N5ufS8YhBlGkaOE2GFHQrgFXS65tQKW7VRXvHkB/tBM=;
        b=cqeaWCZSqr4Ubfz70k/UuGdUeCrnTjNc5knHtoLsI2PduXPzqXSaDWxHPnj0fp6Tr1
         AQFhTuEz/TrEJ4C+tj3lwbiT7P2P6dnV7VqEsowVfdW0YPaPuwOINvYxYllQdkhKToFl
         1YTngHBnOMn3dbsMjAqtJA0aBoDpTa7gAh5ykxAebmXAFfUD4R2nK6M0fI3vrUGfQlDV
         UXkN+14b69ZctJJT0xIG5I3abWxxELryPNOWhj87WxasbMnHs4CxGytcHufue6avRlEd
         PZ9FkUWo685FGjfaNpVFL4tRzwc84I1SeSWc4pVuVoI4qHUF3UDaHvM3CnvbIHji9ei+
         eEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N5ufS8YhBlGkaOE2GFHQrgFXS65tQKW7VRXvHkB/tBM=;
        b=PTdNMhvEQPK1vZm1xpi7MK2qav3oCD+LGXwNg8EcqY4N22iLSVDCVvxxhTxliSN0U0
         BfIf9q1RYQiqUelzA6Q5+CDkTgWYUDLEnvuO8YYtVwWSMbQSplY2NAL4wfWv5HBtRWzw
         rHbOgWqIeUXg8le6zGwXr4qAq6uDtrd1RDNZ9k0JUvL4pQsYO3GZREkspVyCg1+1ridV
         tYY7LKk0yhVb0drdSGECpkmMX3uRc3TecKMAOHYyt2+70EEjeUpcIlmS7brpBRAFv3Ty
         mlo4VCWTnocRDMcr0wi6m95kolO6nnnFeE0tOAS7+u4ynQkM6KnGquehfWZiQW05302v
         nRUQ==
X-Gm-Message-State: AOAM5310wlJhq0HFARaY/VrxpdLOGiac3QVjpVMN6cVszJyqS7a310Ad
        CRUTF/mm2LMs0oWsc6xewpzaGmt1c3MK6be+FRk=
X-Google-Smtp-Source: ABdhPJxmQl0Kw6ku/319ebrT/w5tjrPQRtZ46FVMoAgQMAl8AqSNmU8jP0XPBU93BkmncsDOamurV6T8a/7Oc56OGH0=
X-Received: by 2002:aa7:c713:: with SMTP id i19mr35584705edq.296.1605888098848;
 Fri, 20 Nov 2020 08:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
 <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com> <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
In-Reply-To: <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 20 Nov 2020 11:01:01 -0500
Message-ID: <CAF=yD-Lzu9j6T4ubRjawF-EKOC3pkQTkpigg=PugWwybY-1ZyQ@mail.gmail.com>
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

On Fri, Nov 20, 2020 at 3:13 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Nov 19, 2020 at 9:13 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > On Thu, Nov 19, 2020 at 10:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Thu, Nov 19, 2020 at 3:31 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > The right shift would work indeed, but it's also a bit ugly unless
> > > __estimate_accuracy() is changed to always use the same shift.
> > >
> > > I see that on 32-bit ARM, select_estimate_accuracy() calls
> > > the external __aeabi_idiv() function to do the 32-bit division, so
> > > changing it to a shift would speed up select as well.
> > >
> > > Changing select_estimate_accuracy() to take the relative timeout
> > > as an argument to avoid the extra ktime_get_ts64() should
> > > have a larger impact.
> >
> > It could be done by having poll_select_set_timeout take an extra u64*
> > slack, call select_estimate_accuracy before adding in the current time
> > and then pass the slack down to do_select and do_sys_poll, also
> > through core_sys_select and compat_core_sys_select.
> >
> > It could be a patch independent from this new syscall. Since it changes
> > poll_select_set_timeout it clearly has a conflict with the planned next
> > revision of this. I can include it in the next patchset to decide whether
> > it's worth it.
>
> Yes, that sounds good, not sure how much rework this would require.
>
> It would be easier to do if we first merged the native and compat
> native versions of select/pselect/ppoll by moving the
> in_compat_syscall() check into combined get_sigset()
> and get_fd_set() helpers. I would assume you have enough
> on your plate already and don't want to add that to it.

Thanks for the suggestion.

I do have an initial patchset. As expected, it does involve quite a
bit of code churn to pass slack through the callers. I'll take a look
at your suggestion to simplify it.

As is, the patchset is not ready to send to the list for possible
merge. In the meantime, I did push the patchset to github at
https://github.com/wdebruij/linux/commits/epoll-nstimeo-1 . I can send
a version marked RFC to the list if that's easier.

I made the slack specific changes in two separate patches, one to
fs/select.c and one to fs/eventpoll.c, and placed these at the end of
the patchset. So we could first finish the syscall and then send this
as a separate patchset if it proves complex enough.

Btw, the other change, to convert epoll implementation to timespec64
before adding the syscall, equally adds some code churn compared to
patch v3. But perhaps the end state is cleaner and more consistent.

> > > I don't see a problem with an s64 timeout if that makes the interface
> > > simpler by avoiding differences between the 32-bit and 64-bit ABIs.
> > >
> > > More importantly, I think it should differ from poll/select by calculating
> > > and writing back the remaining timeout.
> > >
> > > I don't know what the latest view on absolute timeouts at the syscall
> > > ABI is, it would probably simplify the implementation, but make it
> > > less consistent with the others. Futex uses absolute timeouts, but
> > > is itself inconsistent about that.
> >
> > If the implementation internally uses poll_select_set_timeout and
> > passes around timespec64 *, it won't matter much in terms of
> > performance or implementation. Then there seems to be no downside to
> > following the consistency argument.
>
> Ok. So to clarify, you would stay with relative __kernel_timespec
> pointers and not copy back the remaining time, correct?

That's my understanding, and the current implementation.
