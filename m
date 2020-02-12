Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3515AF85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 19:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgBLSOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 13:14:32 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37452 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgBLSOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:14:32 -0500
Received: by mail-vk1-f195.google.com with SMTP id b2so791102vkk.4;
        Wed, 12 Feb 2020 10:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnO+YjEhAA1fR16vRtKkqQ6IaKqDgHiXesjpy2PtN38=;
        b=ZR+9YgBakxEstBEDPenyc6ChESRa252lsrlSKvqnb3RdE17Tknmw3nDprL82eXvsAT
         NNgGEdeiP+K41L1y/+LbPA+oqmywkUiWEmw/uKFkoy4FGzBtr5VUzn4aNdDtC2RYFg1W
         i4ZGB1foaZ+ESxAkGyNrdlTcePmocNnnSmaHZ57iRvEBrolpknswOdsJC0EX7BgP8hUz
         Kp8iHxZ1bpY314pJ6NCT5NBpuaXnfrNzrDdsDsMcdqKbirrpTk+WFQlntM4QJO+KSZrL
         4q8HhyQqDzLTs8xH02u0jE/99x3FRK9K7zgtB+1aZoDm8pvn7qb/KqRkH1Jis0sJWwQm
         z8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnO+YjEhAA1fR16vRtKkqQ6IaKqDgHiXesjpy2PtN38=;
        b=c/rtaCWyPxtqzkjs+Y8+Bc+di4MfUOulz5+sPD7+PBoLakZ7TcA1lOWVLxx0wJs4DW
         S6r0wzCTJGORHUC+90sPOCaBG1vxTfzI2BAWUgLNIu4kXaCXeIkYFyx5hBcJfHRbEscS
         zxtmoMxgV0eRUtRHHA8u+cH/GogssfHWaUlikXhdLjB8mT4gglCyvZtJSAD++ESkPTgH
         fFs27YcYlOgxb2SCxtfB/jHCkjzsXnUFsOh5FEHDW/l1taynD74R+ezy/jYcirdJw/O9
         1Z6ZP3iJ2nsCi6Anq8AHyNFKCAWvqbvKEV9vkL95dC1IUxaIEPT5AnL0m5RVq2yLZjlx
         jQVg==
X-Gm-Message-State: APjAAAXVanQpYuevZH+mTWI3ATa8W7qaBN5ziFZtP4sfyAd9M5JkTKg1
        DqisqQgwmwTgj51TVhulqo9Dj8Pkqe7IjS3ueb8=
X-Google-Smtp-Source: APXvYqwo//dw2Lz6KTEw7WfIO4RNGL+6Go6fPHggeMQ4aTz85IGc9hcU42s1bKUl8TDwUZspWcItcXYkgakCnjAu/Gg=
X-Received: by 2002:a1f:9d16:: with SMTP id g22mr8454036vke.22.1581531270966;
 Wed, 12 Feb 2020 10:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
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
 <CACAVd4hS1i--fxWaarXP2psagW-JmBoLAJRrfu9gkRc49Ja4pg@mail.gmail.com>
 <alpine.DEB.2.21.1909071630000.1902@nanos.tec.linutronix.de>
 <CACAVd4grhGVVSYpwjof5YiS1duZ2_SFjvXtctP+cmR5Actkjyg@mail.gmail.com>
 <alpine.DEB.2.21.1911051100471.17054@nanos.tec.linutronix.de> <CACAVd4geU0aFqvFhNQ4YGHDtLPwcqhubh8hcu4CT7CN+G2zpdA@mail.gmail.com>
In-Reply-To: <CACAVd4geU0aFqvFhNQ4YGHDtLPwcqhubh8hcu4CT7CN+G2zpdA@mail.gmail.com>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Wed, 12 Feb 2020 23:44:20 +0530
Message-ID: <CACAVd4iH3e+V3VTJhEOabn46mosL-ntOgjJm_mMjnnwKtcpAjw@mail.gmail.com>
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

Did you get a chance to update the timerfd man page?
Our customers are expecting these changes to happen asap.

Regards,
Arul

On Wed, Nov 6, 2019 at 9:08 AM Arul Jeniston <arul.jeniston@gmail.com> wrote:
>
> hi Tglx,
>
> Thank you for the update. We have few customers who are waiting for
> this patch. Please prioritize it.
>
> Regards,
> Arul
>
> On Tue, Nov 5, 2019 at 3:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Arul,
> >
> > On Tue, 5 Nov 2019, Arul Jeniston wrote:
> > > >  So I'm going to send a patch to document that in the manpage.
> > >
> > > Did you get a chance to make the manpage patch? if yes, please help us
> > > by sharing the link where we can find the patch.
> >
> > No. I would have Cc'ed you when posting. It's somewhere on my todo list.
> >
> > Thanks,
> >
> >         tglx
