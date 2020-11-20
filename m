Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747BB2BB8FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 23:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgKTW2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 17:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgKTW2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:28:51 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DC1C0613CF;
        Fri, 20 Nov 2020 14:28:51 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cf17so7534873edb.2;
        Fri, 20 Nov 2020 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bPP3As9sr0v1f+/yehTTDQxkHbGSRzSC3dhYRMl9WY=;
        b=lNZsWOsJX/RpEAr78ngzx1oJ+FXJY+MxRq0dIpY95DXfgpTb3jukXQRFDscyhRXOp0
         wK2yT0ZiaiCsH8cx/hgqRAcpR5rDCT+QbIf7eZ+EhT7Z4iJXlia+rpi9UG7Qlaa3kr8w
         8visf3y266Y2gTVpvazr9GpH+21bF/ZhbMXQMM90PuiiD91zgzLEhRPJTe0x2MPsVi4d
         fvrnGJ10G8Nt7K3+fjWXOYgdF90CiJwfR4bODfZ/RhpEXHb3MafvZ7QcfTTo/uWgIDbH
         j4YY3lJaPhjeXHW8f327bzYTIHjXP/WuMVXTS0+F6n1HHfnVOkF556Bos+r4Ze3hy7tS
         lZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bPP3As9sr0v1f+/yehTTDQxkHbGSRzSC3dhYRMl9WY=;
        b=Uw5DFxgwLjphhwRUuCuW1k2/CrjnKLA5wr2DscV+3TXp876cI6HHDBAqIVl+wT4itM
         2WkCb2ZU4HZk3wseKdn+q685AdvMpUMYa3H2G1nAoyT2Z76QO4o5UGMx08mAnjU+Rkpz
         ptrhr0fe5r9W1MTQSZBTMcQSVbB3IIdrJCVX/rfpt7DM3v5L/7qWaGsJdYqFLbroYDbE
         ooDq1linAtX2gGecbj1fIACShcPMDefSKhhuGNkqqWHWfQq+27NUkq08AlYcJ9871l44
         mzDK063ctnubMug2oJ+thCeG8HrTN/h+IJxpTNzyl72bhweIntU4PCRG9dpQuXbyBQEK
         /nsQ==
X-Gm-Message-State: AOAM532tHvTA21eBmKEktcDSkv+Mi21X90Psy2riRM9oyZzdNYsiF4Tu
        DU7zJ5PkCO2yJvcQOSMdB6FwvS9k5op6KlqROOI=
X-Google-Smtp-Source: ABdhPJzTjjJR8nA08kjyngDU0dMh9utoN+/4Dmf3awCry5swLXK5EOFg6rvodXtZpZTLrEzysAJT6qCd09PEGDmthgA=
X-Received: by 2002:aa7:ce82:: with SMTP id y2mr38173000edv.6.1605911330221;
 Fri, 20 Nov 2020 14:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
 <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
 <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
 <CAF=yD-Lzu9j6T4ubRjawF-EKOC3pkQTkpigg=PugWwybY-1ZyQ@mail.gmail.com> <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com>
In-Reply-To: <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 20 Nov 2020 17:28:12 -0500
Message-ID: <CAF=yD-LdtCCY=Mg9CruZHdjBXV6VmEPydzwfcE2BHUC8z7Xgng@mail.gmail.com>
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

On Fri, Nov 20, 2020 at 2:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Nov 20, 2020 at 5:01 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Fri, Nov 20, 2020 at 3:13 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Thu, Nov 19, 2020 at 9:13 PM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > On Thu, Nov 19, 2020 at 10:45 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > Thanks for the suggestion.
> >
> > I do have an initial patchset. As expected, it does involve quite a
> > bit of code churn to pass slack through the callers. I'll take a look
> > at your suggestion to simplify it.
> >
> > As is, the patchset is not ready to send to the list for possible
> > merge. In the meantime, I did push the patchset to github at
> > https://github.com/wdebruij/linux/commits/epoll-nstimeo-1 . I can send
> > a version marked RFC to the list if that's easier.
>
> Looks all good to me, just two small things I noticed that you can
> address before sending the new series:
>
> * The div_u64_rem() in ep_timeout_to_timespec() looks wrong, as
>   you are actually dividing a 'long' that does not need it.
>
> * In "epoll: wire up syscall epoll_pwait2", the alpha syscall has the
> wrong number, it
>    should be 110 higher than the others, not 109.

Thanks! I'll fix these up.

> > Btw, the other change, to convert epoll implementation to timespec64
> > before adding the syscall, equally adds some code churn compared to
> > patch v3. But perhaps the end state is cleaner and more consistent.
>
> Right, that's what I meant. If it causes too much churn, don't worry
> about it it.

I think it'll be better to split the patchsets:

epoll: convert internal api to timespec64
epoll: add syscall epoll_pwait2
epoll: wire up syscall epoll_pwait2
selftests/filesystems: expand epoll with epoll_pwait2

and

select: compute slack based on relative time
epoll: compute slack based on relative time

and judge the slack conversion on its own merit.

I also would rather not tie this up with the compat deduplication.
Happy to take a stab at that though. On that note, when combining
functions like

  int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
                           fd_set __user *exp, struct timespec64 *end_time,
                           u64 slack)

and

  static int compat_core_sys_select(int n, compat_ulong_t __user *inp,
        compat_ulong_t __user *outp, compat_ulong_t __user *exp,
        struct timespec64 *end_time, u64 slack)

by branching on in_compat_syscall() inside get_fd_set/set_fd_set and
deprecating their compat_.. counterparts, what would the argument
pointers look like? Or is that not the approach you have in mind?
