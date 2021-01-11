Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2874B2F2066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 21:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbhAKUHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 15:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390143AbhAKUHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:07:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A9C061795;
        Mon, 11 Jan 2021 12:06:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id dk8so1113781edb.1;
        Mon, 11 Jan 2021 12:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vua/4FAuzJKcybmU96dmSVXE6bAQ11vfonwPty39STU=;
        b=jn/iS6wcEHjTuKOIG5EgLsXBQT5yi8UITaREcgDFXa1OyA9PpNg21X0CURa1dZbccI
         kLm5aLJ/C0ouFXWl2PrVviBsFA2LcdVNtK4/KlZeAL6uNreI1ZqznNthWpzF1kMC5wvE
         5jvDHnNzKshVcPoQ2uXvYt3efl+eHkLJBrCr+km7SFOLC0Ku9SqxqvjJvOZdxFHlPsu7
         F+PPmfJytzn+dEFmwShYtxrQuSxt7iHZ4xNi9LXgfOz9O6Okqv+I1hlDVIiW13Cw0VAn
         TokAs3MmOmZfkqtPZhp/SpTQuXW6lJbeRa5qP0DNu97Z0OxvYiiw+xAIaHdoFDeeWcvt
         0ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vua/4FAuzJKcybmU96dmSVXE6bAQ11vfonwPty39STU=;
        b=TUx7GsanfaRifau7DSsftuhWlYGByg7IRc1IIixjEm18EHVjwGE3lG2Dv0N9B3iHw2
         gdTYwSE357UApjaDlRxSVHayifPWu2xZzKqlOrFn+YnnHT0eVceZsjO3dE2j6lLWeCUi
         rJGmIZDsv9IpdT9z3jz52RR5TMY/gZ72YL1X+rb1BhNk3nUoHsh/gZSO2G1s3zqSKla+
         T9fO2Nqmb5ZdOfgch710hLZryzwCTaJF1UmPB9uqyHPSvtgvEhk0qFE+OJCrva80xJKr
         ot2TfLeqBzRJOeyY1TZd6Mdk9dgiUuisaanNAmReP2p3iqo5hzKbrYMKwHIDh5hZMfv6
         i1Vg==
X-Gm-Message-State: AOAM532uSMiJFTLdHw/tfjP9NX/k6yTjpl49MyZ21EhwIsZA+ZDDXtcc
        9s5K8uV8fqZZ7wz0m5KM3Sbcq/0hnXn77WecD2Q=
X-Google-Smtp-Source: ABdhPJw2JE0XKzdLSRtyimoueQT49YkniTFElT5qp82XIKYeiHDg+pZyGZERgKh4rOTg8hcgpGSHlVp3ZDd0HMD1u+Q=
X-Received: by 2002:a05:6402:350:: with SMTP id r16mr752578edw.176.1610395612650;
 Mon, 11 Jan 2021 12:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
 <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
 <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
 <CAF=yD-Lzu9j6T4ubRjawF-EKOC3pkQTkpigg=PugWwybY-1ZyQ@mail.gmail.com>
 <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com>
 <CAF=yD-LdtCCY=Mg9CruZHdjBXV6VmEPydzwfcE2BHUC8z7Xgng@mail.gmail.com>
 <CAK8P3a2WifcGmmFzSLC4-0SKsv0RT231P6TVKpWm=j927ykmQg@mail.gmail.com>
 <CA+FuTSdPir68M9PwhuCkd_Saz-Wi3xa_rNuwvbNmpAkMjOqhuA@mail.gmail.com>
 <CAK8P3a2Z=X68aU27qQ_0vK6c_oj9CVbThuGscjqKXRCYKfFpgg@mail.gmail.com> <CAF=yD-LAzjyNRy0vqToWqx5LxeQMYY3fVzV0vr0X7Q70ZAR-AQ@mail.gmail.com>
In-Reply-To: <CAF=yD-LAzjyNRy0vqToWqx5LxeQMYY3fVzV0vr0X7Q70ZAR-AQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 11 Jan 2021 15:06:15 -0500
Message-ID: <CAF=yD-JskHu0oBBTaRT_v7MZNEdgtYN3BmiexqjAgJV1hBKkEw@mail.gmail.com>
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
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 5:59 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Dec 10, 2020 at 3:34 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Thu, Dec 10, 2020 at 6:33 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > > On Sat, Nov 21, 2020 at 4:27 AM Arnd Bergmann <arnd@kernel.org> wrote=
:
> > > > On Fri, Nov 20, 2020 at 11:28 PM Willem de Bruijn <willemdebruijn.k=
ernel@gmail.com> wrote:
> > > > I would imagine this can be done like the way I proposed
> > > > for get_bitmap() in sys_migrate_pages:
> > > >
> > > > https://lore.kernel.org/lkml/20201102123151.2860165-4-arnd@kernel.o=
rg/
> > >
> > > Coming back to this. Current patchset includes new select and poll
> > > selftests to verify the changes. I need to send a small kselftest
> > > patch for that first.
> > >
> > > Assuming there's no time pressure, I will finish up and send the main
> > > changes after the merge window, for the next release then.
> > >
> > > Current state against linux-next at
> > > https://github.com/wdebruij/linux-next-mirror/tree/select-compat-1
> >
> > Ok, sounds good to me. I've had a (very brief) look and have one
> > suggestion: instead of open-coding the compat vs native mode
> > in multiple places like
> >
> > if (!in_compat_syscall())
> >     =EF=BF=BC return copy_from_user(fdset, ufdset, FDS_BYTES(nr)) ? -EF=
AULT : 0;
> > else
> >     =EF=BF=BC return compat_get_bitmap(fdset, ufdset, nr);
> >
> > maybe move this into a separate function and call that where needed.
> >
> > I've done this for the get_bitmap() function in my series at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/com=
mit/?h=3Dcompat-alloc-user-space-7&id=3Db1b23ebb12b635654a2060df49455167a14=
2c5d2
> >
> > The definition is slightly differrent for cpumask, nodemask and fd_set,
> > so we'd need to try out the best way to structure the code to end
> > up with the most readable version, but it should be possible when
> > there are only three callers (and duplicating the function would
> > be the end of the world either)
>
> For fd_set there is only a single caller for each direction. Do you
> prefer helpers even so?
>
> For sigmask, with three callers, something along the lines of this?
>
>   @@ -1138,10 +1135,7 @@ static int do_ppoll(struct pollfd __user
> *ufds, unsigned int nfds,
>                           return -EINVAL;
>           }
>
>   -       if (!in_compat_syscall())
>   -               ret =3D set_user_sigmask(sigmask, sigsetsize);
>   -       else
>   -               ret =3D set_compat_user_sigmask(sigmask, sigsetsize);
>   +       ret =3D set_maybe_compat_user_sigmask(sigmask, sigsetsize);
>           if (ret)
>                   return ret;
>
>   --- a/include/linux/compat.h
>   +++ b/include/linux/compat.h
>   @@ -942,6 +942,17 @@ static inline bool in_compat_syscall(void) {
> return false; }
>
>   +static inline int set_maybe_compat_user_sigmask(const void __user *sig=
mask,
>   +                                               size_t sigsetsize)
>   +{
>   +#if defined CONFIG_COMPAT
>   +       if (unlikely(in_compat_syscall()))
>   +               return set_compat_user_sigmask(sigmask, sigsetsize);
>   +#endif
>   +
>   +       return set_user_sigmask(sigmask, sigsetsize);
>   +}

set_user_sigmask is the only open-coded variant that is used more than once=
.

Because it is used in both select.c and eventpoll.c, a helper would
have to live in compat.h. This then needs a new dependency on
sched_signal.h.

So given that this is a simple branch, it might just make logic more
complex, instead of less. I can add this change in a separate patch on
top of the original three, to judge whether it is worthwhile.
