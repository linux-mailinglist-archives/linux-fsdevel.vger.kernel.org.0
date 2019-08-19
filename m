Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7F12926A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 16:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHSOZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 10:25:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45415 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHSOZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:25:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id a30so1538010lfk.12;
        Mon, 19 Aug 2019 07:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xW4SbUbBrR7IZ2iuavDafioa85MLGYucANcU3EzeSsI=;
        b=NYNeplhiIjJJ4KoiRzXiB4QuCgPYCfrWp14tXf3xHTakbaZu211UHFr6eaqhqcJ/Wa
         jpNcRNefjLS7wYXQrYfY/0OlXXGWb0SiN1myI1KZCTRDh3aMLXln0S97mDWjWHsRTaFd
         bz5IlSm+sXJhZmbNIGZuSFuINzXObiQiwUDAQ30j6BvJzV91pStuH4tmlyeHXu5Opiep
         BpXjJBJei/DwEi/TD4zkDRzcshsPJwLwIJT5WG9yCYYRDwxE46ZK5AvMeWZvnetGHoWx
         gVGYWoizI/zulcg2mpzLT0ohZR8dOCvlEtncn++9xa4jCUxrFdGLYesQDsAQNwrQvOos
         vloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xW4SbUbBrR7IZ2iuavDafioa85MLGYucANcU3EzeSsI=;
        b=baQgPuxWanHfAnW+2r7iQjuvW1oEU1Naq6co1rpCzyLrwJyA969YpnDkb9OxDtPPYO
         rRbR+//df6eHHU3WY4pZg6Ck5cjBshPLr4l/Yx4sAO5BW1tZOXF9Uu9Mct1FSiUNLf9l
         xsl5SwVHy8SjNQf6irxgYoqaSkplIbAWar6kAmPdHlaL1wR32Bf6/Hz5vWCSKcJCnT8k
         gTCi/sdJHIL9uZJhub+YwK7lnXFFcuKWEM/kVE5+zbVSUsWQOVbfWK0GxuSyNWVM62+r
         7+Ifj5XR/r5jewiTFwCGSO9MaPG/+HjRv4tA9Zsb0+7sNeiDgJseNXpKeqJ7U1OFxL4z
         kXPQ==
X-Gm-Message-State: APjAAAXO/XytHcZ230uu0KdPZx8OOYi05Bnpl9iWSTURtRy0ljbXusId
        Wub0pz02xdKKqQ0dwtBt8p7nN9hRy1EKSAca3kQ=
X-Google-Smtp-Source: APXvYqxla4D/Yt023bMWhSPNnxV9BS218rcry1EpcZmv0TEajsTOFA8fZTgCv4FVyzOlqtQJzINke6qSuLDzwmykiWQ=
X-Received: by 2002:ac2:42c3:: with SMTP id n3mr4613814lfl.117.1566224752080;
 Mon, 19 Aug 2019 07:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
 <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de>
 <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
 <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
 <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com>
 <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com> <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Mon, 19 Aug 2019 19:55:40 +0530
Message-ID: <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
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

...
> > > Is the timer expiry and the timerfd_read() on the same CPU or on different
> > > ones?
> >

We have 10000+ units running in production. We see this problem ~20
switches in a span of one year time.
The problem is not seen more than once in the same unit. The
occurrence is random and unpredictable.
We tried to recreate this problem in LAB by loading the units similar
to the production unit.
so far we are not able to recreate it. It is very difficult to predict
what triggered this in the production units.
So, to find root cause, we studied and instrumented kernel code.

>   1) TSCs are out of sync or affected otherwise

If the TSC clock is unstable and not synchronized, Linux kernel throws
dmesg logs and changes the current clock source to next best timer
(hpet). But we didn't see these logs in any of the 10000 units.

>   2) Timekeeping has a bug.

As per our analysis,

After the timer expiry, after tsc is read in hrtimer_forward_now()
-->ktime_get()-->timekeeping_get_ns(), if the current thread (t1) is
interrupted and/or some other thread running in different CPU (t2)
updates timekeeper cycle_last value with a latest tsc than t1,
clocksource_delta() and timekeeping_get_delta() would return 0.
Eventually   timekeeping_delta_to_ns() would return a smaller value
based on the other two parameters (mult, xtime_nsec). If
base(timekeeper.tkr_mono.base) is not updated all this time, then
ktime_get() could return a value lesser than expiry time.
Note: CONFIG_DEBUG_TIMEKEEPING is not configured in our system.

> I was asking for a full boot log for a reason. Is it impossible to stick
> that into a mail?

Give me a day time to sync-up internally and update.

Regards,
Arul
