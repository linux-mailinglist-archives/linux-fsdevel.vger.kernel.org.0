Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB0262193
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 22:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgIHU4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 16:56:42 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48199 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgIHU4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:56:38 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MNbtD-1jv3QV27kh-00P7vm; Tue, 08 Sep 2020 22:56:36 +0200
Received: by mail-qt1-f182.google.com with SMTP id y11so310649qtn.9;
        Tue, 08 Sep 2020 13:56:36 -0700 (PDT)
X-Gm-Message-State: AOAM531ldlojCKnKAwLQ24gQISKK4G7TWR3/GMzc7tHxusKf4pKC95Vk
        ftZeSB4wfPlosy0ynS5vYU3ScinZlkfb5XT/qgc=
X-Google-Smtp-Source: ABdhPJw01K4SmzGcD/b5sCr5TVIohl7CD4hX2My20XCnkE0ssRILx71GeRB7UxQ0ChxMfJ5jNEb1Xhh9GXXfgpFYgXA=
X-Received: by 2002:aed:2414:: with SMTP id r20mr314758qtc.304.1599598594985;
 Tue, 08 Sep 2020 13:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-6-arnd@arndb.de>
 <20200908062002.GD13930@lst.de>
In-Reply-To: <20200908062002.GD13930@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Sep 2020 22:56:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a30Ezn9MhN6YG+c_eCedo=HGp2-uUN6fC218f96TBFK=Q@mail.gmail.com>
Message-ID: <CAK8P3a30Ezn9MhN6YG+c_eCedo=HGp2-uUN6fC218f96TBFK=Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] ARM: oabi-compat: rework epoll_wait/epoll_pwait emulation
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux- <kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ONFItD4L9ZUfs9c7cyDdLEcuWb4tDmr1dxAFxBmlvQBgCY+AyBQ
 5yGSNs4HcpwVXao6W8rKb/wo5lHk9sJbaBaAfKu5QOfmlkdNU9s6H/Fxvyf6/zlZlgm+6x4
 7sWLlUIXP+Y+4lL7FIOvAUEa9CSUbtRv8UQHr+Aq3qrcpgslls4Zz7TuaRttakGwoVBeobp
 SzdOKPKVLMh57itI2U2sg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Amv1wSt9wms=:C2yWf5pqS1J9wAPWLAOJ7j
 HhNwC4qRElRzIhaA+gd5scasCJXkPld8HiJ2TSEzEO+4Dp/GHK1Eypfu9Vy6BybgIzyd7bG7N
 cegJjIW4JPs5rf5rCE0QGgvDaxcXJIisxn5T/3IXCediq6LRceDzetvkx/5bEnpFR9M3GkMnK
 wTPaJSOJqlfed1H2/oVVjwVY0lOZxGeIqOBlCXZh+sbbi4V0AUm0sgBUcoQMon+Jce1wKeJiK
 tRGtvRy4dzY/ERLhqYbSZ/NTkONkqymgra/Qxn/3JeewSw0ysFhCUcX5LIZ8SleK4HhdziLOI
 O5PvGeVmO1s8MGJMUONT/LdTqEdNB50R8NQy/ayko39jvAsQ/PWnkaRarutKCpm9u8WNC9EgH
 Tz7WBdIA5JTOAk+e4jyhxzC0PMa+iL9BSR96ej0joNhju1DDIWEp7HR/EVitVBsWyrRRc6oVC
 iZXzSmGR2tMYqohqopENFWD5m4HLI6OdLf4ijbdjo6Y6P/PU2Dm4NZ3PInxD2UC3JxjVs/KMV
 v+L+TpevMIRFiLPJpbe5MwusY5KpfZ6rI1XEAmfGVyGBqVJ4T22Dx9KDwxVeAYFIKVSLrGUxz
 ANVdU87H21c/aaEBJnBbvmYOVQPKwh2O89Xnp1frGYti+Ack2YiFxpXdpwPs4wYrs7tAjqY7g
 yBt7G+0ibJyVmymcDIAuk0caY2Y2l6XxJ9FuLW8y+2nKUlD5i/V2ri/Aj7E9sbWmT5IjUu+oM
 FJzrxU2kTN27lh8KVxZIQfpbg/rLRFtQ0XKVdyC+libWL+LcIgPmIP+rk2SJGi/LMEiNT3vP2
 St6zRYGlHJ94IXl1rq5pHefT0zoBNZVL/rffsL/xVBujOv+7T0d8iIDfnK0WFA27SvDbLQn
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:20 AM Christoph Hellwig <hch@lst.de> wrote:
> > @@ -264,68 +266,24 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
> >       return do_epoll_ctl(epfd, op, fd, &kernel, false);
> >  }
> >
> > -static long do_oabi_epoll_wait(int epfd, struct oabi_epoll_event __user *events,
> > -                            int maxevents, int timeout)
> > +struct epoll_event __user *
> > +epoll_put_uevent(__poll_t revents, __u64 data, struct epoll_event __user *uevent)
> >  {
> > +     if (in_oabi_syscall()) {
> > +             struct oabi_epoll_event *oevent = (void __user *)uevent;
> >
> > +             if (__put_user(revents, &oevent->events) ||
> > +                 __put_user(data, &oevent->data))
> > +                     return NULL;
> >
> > +             return (void __user *)uevent+1;

FWIW, this line needs to be

         return (void __user *)(oevent+1);

It turns out that while I thought I had tested this already, my earlier
tests were on the EABI Debian 5 instead of the OABI version of the
same distro. I reproduced it both ways now and LTP successfully
found that bug ;-)

> I wonder if we'd be better off doing the in_oabi_syscall() branch in
> the common code.  E.g. rename in_oabi_syscall to in_legacy_syscall and
> stub it out for all other architectures.  Then just do
>
>         if (in_oabi_syscall()
>                 legacy_syscall_foo_bit();
>         else
>                 normal_syscall_foo_bit();
>
> in common code, where so far only arm provides
> legacy_syscall_foo_bit().

I tried out different ways, the first one I had was with an #ifdef in the
C code that I did not like much.

Moving the different code path into common code would avoid that
#ifdef but also put the rather obscure oabi-compat code into a
much more prominent location. I'd prefer to keep it out of there
as much as possible and hope we don't need to do this anywhere
else. x86-32 has some similar issues with struct layout, but that
already goes through the normal compat layer on 64-bit kernels.

> Tons of long lines again in this patch..

Fixed now.

       Arnd
