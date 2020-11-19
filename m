Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CD82B9481
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 15:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKSOUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbgKSOUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:20:14 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6910C0613CF;
        Thu, 19 Nov 2020 06:20:12 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id a15so6019036edy.1;
        Thu, 19 Nov 2020 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QwvHWyjm2wcldjK61oFjlwpsQ75cfT2gBprzbpLYnLY=;
        b=jx/swEARBHRosuMvJG/M9T4ZX1FurGIOkJyXU9qEjw8W6Subpm+7QeKTTpvzVA2R5Z
         fT3egWJ2I6mRdxoocJUh9nmuWnfx0j9/AxMaE+Lg2pQlOF5RBEWIBmHK1KDxULb5ag1f
         dJOdXKs6i7Qljiz7h8iZPTyQcF7Hk482OhLTYI/SXgr94uBuFrUFrqRDusM7hGthecco
         QZi8VwYvX9Pi92B7f6fxUrYa4tLrSLfu8G+Zs/4dEJjHi2ARZyDf2Bsue00ZT9DxD7E6
         xNavBGc8Gnu5yfqUylNtc7g8+LCgtYlYxRR+Si3OJL8+yK8ZKeSqFlVBgc7cH6mZvHwm
         zMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QwvHWyjm2wcldjK61oFjlwpsQ75cfT2gBprzbpLYnLY=;
        b=QwzpULGpusrAdVBGQ/JQDHhGIzpCBCG+N0blfYO92kzrIhsi34yV3HrwTT61BB7ORU
         b5nUVPnWxk/dy6ZCkU1jX4RAH1zNpnVm0WJBDfZ5BFdI7ZJDD86W1EjKYTLPlbuPPA7O
         22+KLygboPNnOWfxpaRu9Mue73U7O3iehfctEAvZJjSTLEI3uRUs5dWtCg6e0m6GH4UO
         mskkkZaWDkBS+3ZFT0ZcH1t6UQX7ClQxNVd+vu8HZbFjRervKF5xEtIGvga6MhV2R81E
         BvZjkf2KbQ3DTBvPHdFUrQ9GpD0Z9/SS/QD5Dl5ulq3jS1Eup83u2XAuYiI4p3nOaOIe
         ElSg==
X-Gm-Message-State: AOAM531mS9Q2VGQIQrAogKfOQkMWdhNL3twXVD90tC/kKZfFtHYOgLQh
        08Whm6eiKDDSrIgNBLd/TY8C+7FtHlsAsgPMfs02OZBa
X-Google-Smtp-Source: ABdhPJwB70YDAjb9RAn7fKpMLVBXxEHViBfoa+WZOLcRD6fPPr30JMR8nXOQhLjlosVh75Bp6UP3o0qNJ8MJEz0wrx4=
X-Received: by 2002:a50:8a9c:: with SMTP id j28mr29878100edj.254.1605795611350;
 Thu, 19 Nov 2020 06:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com> <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com>
In-Reply-To: <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 19 Nov 2020 09:19:35 -0500
Message-ID: <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
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

On Wed, Nov 18, 2020 at 10:59 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arnd Bergmann
> > Sent: 18 November 2020 15:38
> >
> > On Wed, Nov 18, 2020 at 4:10 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > > On Wed, Nov 18, 2020 at 10:00 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Nov 18, 2020 at 09:46:15AM -0500, Willem de Bruijn wrote:
> > > > > -static inline struct timespec64 ep_set_mstimeout(long ms)
> > > > > +static inline struct timespec64 ep_set_nstimeout(s64 timeout)
> > > > >  {
> > > > > -     struct timespec64 now, ts = {
> > > > > -             .tv_sec = ms / MSEC_PER_SEC,
> > > > > -             .tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
> > > > > -     };
> > > > > +     struct timespec64 now, ts;
> > > > >
> > > > > +     ts = ns_to_timespec64(timeout);
> > > > >       ktime_get_ts64(&now);
> > > > >       return timespec64_add_safe(now, ts);
> > > > >  }
> > > >
> > > > Why do you pass around an s64 for timeout, converting it to and from
> > > > a timespec64 instead of passing around a timespec64?
> > >
> > > I implemented both approaches. The alternative was no simpler.
> > > Conversion in existing epoll_wait, epoll_pwait and epoll_pwait
> > > (compat) becomes a bit more complex and adds a stack variable there if
> > > passing the timespec64 by reference. And in ep_poll the ternary
> > > timeout test > 0, 0, < 0 now requires checking both tv_secs and
> > > tv_nsecs. Based on that, I found this simpler. But no strong
> > > preference.
> >
> > The 64-bit division can be fairly expensive on 32-bit architectures,
> > at least when it doesn't get optimized into a multiply+shift.
>
> I'd have thought you'd want to do everything in 64bit nanosecs.
> Conversions to/from any of the 'timespec' structure are expensive.

I took another look at this.

The only real reason for the timespec64 is that
select_estimate_accuracy takes that type. Which makes sense, because
do_select does.

But for epoll, this is inefficient: in ep_set_mstimeout it calls
ktime_get_ts64 to convert timeout to an offset from current time, only
to pass it to select_estimate_accuracy to then perform another
ktime_get_ts64 and subtract this to get back to (approx.) the original
timeout.

How about a separate patch that adds epoll_estimate_accuracy with
the same rules (wrt rt_task, current->timer_slack, nice and upper bound)
but taking an s64 timeout.

One variation, since it is approximate, I suppose we could even replace
division by a right shift?

After that, using s64 everywhere is indeed much simpler. And with that
I will revise the new epoll_pwait2 interface to take a long long
instead of struct timespec.

Apologies for the delay. I forgot that I'm only subscribed to netdev@
in my main email account.
