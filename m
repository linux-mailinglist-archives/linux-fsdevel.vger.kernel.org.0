Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E22B9659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 16:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKSPhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 10:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgKSPhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:37:41 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A988CC0613CF;
        Thu, 19 Nov 2020 07:37:40 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q3so6243621edr.12;
        Thu, 19 Nov 2020 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4gMOcWlnFb0pTMSF2kWeMu2/q9rHNE4gmklm/yiZ7A=;
        b=UETKaPZa/Pu1lF3CjEfP5RRE0uKWs7ABHzirqjS2wJbF4us8xHz4XfbmfSYLwWe84i
         yZIZy6fkjxr6v9xg7YxPTd/euOF3fiqHERv1dcu26/6sglDbyajLuht54CPhVaWSAOsf
         KrT1+GKguUbHXYAEaQXTOqcfQ0FKZRf3VBK+1gb2jCF3YjfVbJjYjS+coW8SK/wm/C0j
         eApV8DoKN2Ijh+C1KGziaPGu3NOAUkj3y0Zf+cVBFgo5EpcUs+ay4L7OBvD8cizSb/Vc
         Z9p8yFDooWAiFymYYxhGQPmhUxrZY4/GZ2sgyZV51g27ng0cIq65UQPPf9bld2njJCVW
         9kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4gMOcWlnFb0pTMSF2kWeMu2/q9rHNE4gmklm/yiZ7A=;
        b=s3pLgdKHyyOM70VEKj5SH2RdgNSp7HgQADmUq4rsWgudEnjfqQzcZeTYcLiOnVZW1A
         KoIj7nUIqh0XtjoKdNp5NmYC7+s7MXmnewFQs4wapkYp6C5FP3bxIKc6rDW0IqTgKDUN
         mk4j2CfoWUibvTf/W7eWOt3WP5Zdx5TPml+gQyRjfsIdXkNQxupexdXK1+B/1stjiuxv
         eAGjVndRjDPXd+bqxvrxis2hWna+iyzz6C7ZplS1a7NoTv7Z2xkQNLM4/KQ4qKgPi3Ax
         yVJFeyKCMYwYC1eaKlXIklOXtos12mX2SMHnFXPjG56bxy6/pxvuvECWC1KSc/VqP0O7
         BeMA==
X-Gm-Message-State: AOAM530lQPS8j+k71TuZGvy3vUR0W+fDpzyFPKVi9h+8mszSmkEZLFhU
        tWm0uCLmfP7nk0+1LGPcBjxojz7pDsA57xZChlo=
X-Google-Smtp-Source: ABdhPJySAVSl5vKRWWLWWs4qyqHSWl1z+eOESKdyOUWwp5K0oWZhgswzw0WVVDE4LPsiAOao4pOtZ9r9MIM33Brm14w=
X-Received: by 2002:aa7:ce82:: with SMTP id y2mr31737469edv.6.1605800259455;
 Thu, 19 Nov 2020 07:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org>
In-Reply-To: <20201119143131.GG29991@casper.infradead.org>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 19 Nov 2020 10:37:02 -0500
Message-ID: <CAF=yD-+D8E9ksXrWe8ezd-B9pdu7PhMwGjG4gCBvuABRahrsAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@kernel.org>,
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

On Thu, Nov 19, 2020 at 9:31 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 19, 2020 at 09:19:35AM -0500, Willem de Bruijn wrote:
> > But for epoll, this is inefficient: in ep_set_mstimeout it calls
> > ktime_get_ts64 to convert timeout to an offset from current time, only
> > to pass it to select_estimate_accuracy to then perform another
> > ktime_get_ts64 and subtract this to get back to (approx.) the original
> > timeout.
> >
> > How about a separate patch that adds epoll_estimate_accuracy with
> > the same rules (wrt rt_task, current->timer_slack, nice and upper bound)
> > but taking an s64 timeout.
> >
> > One variation, since it is approximate, I suppose we could even replace
> > division by a right shift?
> >
> > After that, using s64 everywhere is indeed much simpler. And with that
> > I will revise the new epoll_pwait2 interface to take a long long
> > instead of struct timespec.
>
> I think the userspace interface should take a struct timespec
> for consistency with ppoll and pselect. And epoll should use
> poll_select_set_timeout() to convert the relative timeout to an absolute
> endtime.  Make epoll more consistent with select/poll, not less ...

Okay. The absolute time is also needed for schedule_hrtimeout_range,
so it could not be entirely avoided, anyway.
