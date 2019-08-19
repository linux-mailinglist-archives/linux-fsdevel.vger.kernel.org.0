Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5574D91CDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 08:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHSGIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 02:08:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHSGIH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:08:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id e24so578247ljg.11;
        Sun, 18 Aug 2019 23:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATIIBWeUbMdPi4D143YEwAHzzotj0ljj+gGqUoi/AYI=;
        b=XZyjMa8B53nWoZJnWPn1W6hhS/Rp2rzsKpkYWnUDrnyyGzw5dJ2FSAUvUNcXSwpj1x
         CkUIXG4lGUAK1LRsvOcxxd7f/8ijLOzvoedeHNRipNx34ryN3c0vV/2IbBPDD8k4/PWq
         AqdPcnyLnhuyoaRszuKkpVwEZDNPFDl8gV0hO0JazzGaunn03JsYzig1tmdB1lVT5/qr
         KJlSnZHwn7pMYS4Aw52eCdnXWdSY3F4GBdBOkVy14Ob42C+OFFYdrIJ8jV4ZocjvR5t2
         dBJzeJlIvx54Nn5MLghzI2XPqGTiELI0gXRk2J4+kdVj5BPSRoMV3b7gzd/bvFo5VIWe
         IGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATIIBWeUbMdPi4D143YEwAHzzotj0ljj+gGqUoi/AYI=;
        b=YNasr8HOjFrW4S6iig5IBwo5y5ICDm2JNFeBkTW6hYBayrubbiYr1ZGC/SpQCFoFtw
         E3yHY/yacJ7tGr8mVuPxktAYJbVhHV8kTkf9VR/Jf2MJcJHScv1FV6r2+LuMy+94oyBh
         YNk/qVKoIy54SzvymKWTX+JAUfUaBzabL8JwY7pknCAEPCjllC8LOn/1QDb2nbxM64rz
         goIe1L3VmEfGMeYqjuRTOrfyYL/jkmAqbBYgPzK34P0tA/22h7mdMweT20CkNoHKDBT/
         fw2QdeteYSWVzY8fAHh0xxkGeYe2duUJee8JVd5INWCaicwYFNjdonOQnlq5d14WjGzH
         nrOA==
X-Gm-Message-State: APjAAAX7RV2rOAHQwMyPnxWtMlo7u5IWdTRmF0GX/Zqy5J6i2UoZuSOe
        rF4eT18l0UX4H///3mF+vF1wi3xDGKcr+jpQl0Nu7Dgg
X-Google-Smtp-Source: APXvYqyIhZF8msosau44Lb+z3Q9vaiXy6u1c97eiJ9Lmf0lhZ+QHxdlMbiahUtXyB2bvD1itohz5jcqVl2uvp08NpPU=
X-Received: by 2002:a2e:7001:: with SMTP id l1mr11906468ljc.48.1566194884267;
 Sun, 18 Aug 2019 23:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
 <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de>
 <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
 <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
 <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com> <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Mon, 19 Aug 2019 11:37:52 +0530
Message-ID: <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi tgls,


> BIOS is the more likely candidate.

We would check BIOS and update.


> We expect TSC not to go backwards. If it does it's broken and not usable as
> a clocksource for the kernel. The problem is that this is not necessarily
> easy to detect.

We used  relative timer with CLOCK_REALTIME which behaves similar to
CLOCK_MONOTONIC.
We are unable to recreate this problem. So, we have instrumented
kernel code to find the possibility.
During normal run, we do see small amount (~1000 cycles) of backward
time drifts one in a while.
This is likely happens due to the race between multiple processors and
ISR routines.
We have added a hook to read_tsc() and observed backward time drift
when isr comes between reading tsc register and returning the value.
This drifting time differs based on the number of isr handled and the
time taken to service each isr.
During our testing, we observed, if the drifting time goes beyond 5000
cycles, timerfd_read() returns 0 sometimes.
We don't see any problem, if the drifting time is lesser than 5000 cycles.


> Again:
>
> You cannot fix a hardware problem by hacking around it at exactly one place
> where you can observe it. If that problem exists on your machine, then any
> other time related function is affected as well.


The system is up and running more than 6 months.
We don't see any log in dmesg to comment on whether it is a hardware issue.
Other than timerfd_read(), we see no functionality issue . Do we have
any data collected in the kernel to help us in analyzing in the
direction of BIOS or hardware?

> Are you going to submit patches against _ALL_ time{r} related syscalls to
> fix^Wpaper over this? Either against the kernel or against the man pages
>
> i.e. time went backwards since the timer was expired. That's absolutely
> unexpected behaviour and no, we are not papering over it.


Agreed. Our intention is not to put a workaround. Intention is to
write a reliable application that handles all values returned by a
system call.
At present, the application doesn't know  whether 0 return value is a
bug or valid case.


> Did you ever quantify how much time goes backwards in that case?

It should be more than 5000 cycles. Found it through kernel instrumentation.


> Is the timer expiry and the timerfd_read() on the same CPU or on different
> ones?


We don't have data to answer this. However, the kernel is configured
to allow timer migration.
So, we believe, the timer expiry and timerfd_read happens on different CPUs.

> Can you please provide a full dmesg from boot to after the point where this
> failure happens?

We don't see any logs in dmesg during the occurrence of this problem.
We may not be able to share complete dmesg logs due to security reasons.
We haven't seen any time drifting related messages too.
Let us know, if you are looking for any specific log message.

Thanks,
Arul
