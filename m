Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A0EF4A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 06:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfKEFBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 00:01:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36982 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfKEFBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 00:01:18 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so14032909lfp.4;
        Mon, 04 Nov 2019 21:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRQ+APr+2BBidMkLxayR8l9LQ01WBemoj2ukfHvIjL8=;
        b=IqjfQO/mMe2vXCuo40urAboeStsULJOKb+ZdYswa4HTnHP5JlbIxM6biRCpuJQOz0F
         Tf2D/2oXagnqvOk5wJfTiFJS1qu9x/rWuOAN7nWGKIHVzXb6ABqj9u74N2tnXEbGQ1wK
         NZtfwW5em0/1Fh0rBuxEtSID6A16JA8wwHKM++BTJzy3xXTpORZakLUwXD59yeTMHfXf
         wjxVZaYl3RXwOuk9mTY12tCx5GUKI7PjwrflrEidfGfOlQwRhHqScrXi7o33DTQlEph8
         xny83u7Qz/93niJuK8wMOO/+gZIsdoYFU01e22d5FQV5SGd0o0p5R0YwVXIm+CVKe6An
         f5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRQ+APr+2BBidMkLxayR8l9LQ01WBemoj2ukfHvIjL8=;
        b=C64NikDAV92gZnVG/oKVftynUB0fgKUqdz3scxmSksRvc5Srs+/cUe24BTzXobF4Dz
         fcFN+DwrkHEJuVP+c2kPSYJ9yaWkkegwcVq3f2C0BgkgDwIYfHdM0SZG8TjcJbZpAC13
         nIGux7qdIpe1BVwk7XJHxcEqonkXcu4fk0WrzeCskni17uPkJN1+M2r0UfK0C2WK6Fu3
         6wmj3Z64qkQAKXCMbVAwNMIgYAnIfuKN/NAyaRjdXykDqEem0b3fem1V6ROo+5HwFm86
         mUJfqj0x6agopZq2+WKDT6ES/3yZAbHo+OYLbAX7/Tlw/JEipyZJ0Uw90JTpWGdsB7RL
         JBoQ==
X-Gm-Message-State: APjAAAVL5KlHFd0JJSdpPwPxGytwQ8UImNV+LZsgar/y0EP/pIpUKxkD
        nw7SnwwQ0rkKqfKJTr3Vuv5sTsqCsNsaCIuUflk=
X-Google-Smtp-Source: APXvYqw3r1fkLqJzcpyzi8/JbHru+GRioUk+tCGgqRYhfbxQUonRWEKzjcn72rroZv0uKUGMFI59ssfmyYXCG47duhA=
X-Received: by 2002:a19:c514:: with SMTP id w20mr19248000lfe.143.1572930074541;
 Mon, 04 Nov 2019 21:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
 <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
 <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
 <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
 <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
 <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de>
 <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com>
 <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de>
 <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com>
 <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de>
 <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com>
 <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com>
 <alpine.DEB.2.21.1909051707150.1902@nanos.tec.linutronix.de>
 <CACAVd4hS1i--fxWaarXP2psagW-JmBoLAJRrfu9gkRc49Ja4pg@mail.gmail.com> <alpine.DEB.2.21.1909071630000.1902@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1909071630000.1902@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Tue, 5 Nov 2019 10:31:03 +0530
Message-ID: <CACAVd4grhGVVSYpwjof5YiS1duZ2_SFjvXtctP+cmR5Actkjyg@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi Tglx,

>  So I'm going to send a patch to document that in the manpage.

Did you get a chance to make the manpage patch? if yes, please help us
by sharing the link where we can find the patch.

Regards,
Arul

On Sat, Sep 7, 2019 at 8:08 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Arul,
>
> On Fri, 6 Sep 2019, Arul Jeniston wrote:
> > >Changing the return value to 1 would be just a cosmetic workaround.
> >
> > Agreed. Returning 1 is incorrect as It causes the next read() to
> > return before the interval time passed.
> >
> > >So I rather change the documentation (this applies only to CLOCK_REALTIME
> > >and CLOCK_REALTIME_ALARM) and explain the rationale.
> >
> > When timerfd_read() returns 0, hrtimer_forward() doesn't change expiry
> > time, So, instead of modifying the man page, can we call
> > timerfd_read() functionality once again from kernel.
> >
> > For example:-
> > timerfd_read_wrapper()
> > {
> >    do {
> >      ret = timerfd_read(...);
> >    } while (ret == 0);
> > }
> >
> > Let us know whether you see any problem in handling this race in kernel.
>
> There is no race. It's defined behaviour and I explained it to you in great
> length why it is correct to return 0 and document that in the man page.
>
> Any CLOCK_REALTIME ABSTIME based interface of the kernel is affected by
> this and no, we are not papering over it in one particular place just
> because.
>
> If clock REALTIME gets set then all bets are off. The syscalls can return
> either early or userspace cam observe that the return value is bogus when
> it actually reads the time. You cannot handle this by any means.
>
> The only way to handle this gracefully is by using the
> TFD_TIMER_CANCEL_ON_SET flag and reevaluate the situation in user space.
>
> So I'm going to send a patch to document that in the manpage.
>
> Thanks,
>
>         tglx
>
>
>
>
