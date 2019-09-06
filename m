Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0EEABDD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 18:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbfIFQgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 12:36:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36431 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfIFQgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:36:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id l20so6604191ljj.3;
        Fri, 06 Sep 2019 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3nw5KJgvoogjXUpclfafJOXkBikfp0oqPVUV7e3hUA=;
        b=a8VpDudn+L1zKw5NgFwUkIPMMw9Tnx+IYueVVEwHZLswUHPq5bDGV6RdlBvy15H1BP
         f++2UOR2BcXu5NK7Xo13aa1dVXiVIFaGGA4JBqdnU9q7UnjIiQKbOJHXHnU9O896pFH6
         MYNZng7KLPumqC1aQIElot0/QZ5Fe/fTmAWkPltcW8E6sUMFimIZ66FyPv9b3y7g/fiN
         3DQeci9XrRonhkAmB/zw6XiS7+u+rHGIqy27yCncpBVd9wGHA6A+UrdWVwAripHzdhlN
         qD321mS0fma4Ir3FUYjz0HcYLY41/jpP5EkKyNoD3HWMiGvLLdEIs63XTBGphVAM97kv
         /Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3nw5KJgvoogjXUpclfafJOXkBikfp0oqPVUV7e3hUA=;
        b=OBlpt06/5/a8q6/g8hRMM/uUMI/nMaZC1fiX1tAgqPhjjOU8p0m/hLjDqBHYeQHzxs
         qYqE1zk9Db3axWAfS1Bgbmj6jHdJ+T5Xt19K8uk2vJviISNfgFhpjj05BS41Yse7KRMp
         u/FLlyN3efVoAmWn15wIs5tWUMYybfXo81ly3LtgQF2fcJAdu5o1KRbaz0AUGrCjMVJL
         Y22BnaOzwqGHAc2AQWzCfvqS8yy9wcEG4j8K8i1cAmfcmFLlatBWPan5ajbKsxiCgBYP
         Wk9DraQvja9fNUqXoX2P+ChatCorS4UlHk2bbRyj/9LrzPM4at0piFiYEjKgMfzjC+AG
         IrQw==
X-Gm-Message-State: APjAAAUt9MIDiZLWEPJ5xN3t2Sst9ES/8PEL45Kj07+xpHg63qKlNQjd
        nbQV0nz3ERjHMsAjkKWZG1nT8SNBWuhhbg3/UZ4j4HX3
X-Google-Smtp-Source: APXvYqwxVBhjms0lsdGKAK1nR3MSZGIPAxrNcdmhdfP+nXSUvuAleSgmHEBhCM6/9ljBMOM9ncj0gpauSKtec1qW3Bc=
X-Received: by 2002:a2e:1648:: with SMTP id 8mr6027913ljw.194.1567787812149;
 Fri, 06 Sep 2019 09:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com>
 <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
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
 <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com> <alpine.DEB.2.21.1909051707150.1902@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1909051707150.1902@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Fri, 6 Sep 2019 22:06:39 +0530
Message-ID: <CACAVd4hS1i--fxWaarXP2psagW-JmBoLAJRrfu9gkRc49Ja4pg@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi tglx,

>Changing the return value to 1 would be just a cosmetic workaround.

Agreed. Returning 1 is incorrect as It causes the next read() to
return before the interval time passed.

>So I rather change the documentation (this applies only to CLOCK_REALTIME
>and CLOCK_REALTIME_ALARM) and explain the rationale.

When timerfd_read() returns 0, hrtimer_forward() doesn't change expiry
time, So, instead of modifying the man page, can we call
timerfd_read() functionality once again from kernel.

For example:-
timerfd_read_wrapper()
{
   do {
     ret = timerfd_read(...);
   } while (ret == 0);
}

Let us know whether you see any problem in handling this race in kernel.

Regards,
Arul


On Thu, Sep 5, 2019 at 9:04 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Arul,
>
> On Thu, 5 Sep 2019, Arul Jeniston wrote:
> > When we adjust the date setting using date command we observed
> > 'timerfd_read()' on CLOCK_REALTIME (TFD_TIMER_ABSTIME flag is set)
> > returns 0.
> > we don't see any hardware influence here and we are able to recreate
> > it consistently. Is it expected? if yes, isn't it something to be
> > documented in timerfd read() man page?
>
> It's expected, yes. Simply because it hits the following condition:
>
>      armtimer(T1)
>
>      settime(T1 + X)  --> causes timer to fire
>
>                                  wakeup reader
>      settime(T0)
>
>                                  read number of intervals: 0
>
>                                  i.e. timer did not expire
>
> Changing the return value to 1 would be just a cosmetic workaround. We
> could also jump back and wait again. But that's all not consistent because
>
>      armtimer(T1)
>
>      settime(T1 + X)  --> causes timer to fire
>
>                                  wakeup reader
>
>                                  read number of intervals: 1
>      settime(T0)
>
>                                  user space reads time and figures that
>                                  the returned tick is bogus.
>
> So I rather change the documentation (this applies only to CLOCK_REALTIME
> and CLOCK_REALTIME_ALARM) and explain the rationale.
>
> For applications which care about notifications when the time was set,
> timerfd_settime() provides TFD_TIMER_CANCEL_ON_SET which causes the timer
> to be canceled when time is set and returns -ECANCELED from the
> read. That's unambiguous.
>
> Thanks,
>
>         tglx
