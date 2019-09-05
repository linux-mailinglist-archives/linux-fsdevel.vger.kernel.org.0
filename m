Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77BE6A9D7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 10:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfIEIsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 04:48:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38362 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbfIEIsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:48:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so1235147ljn.5;
        Thu, 05 Sep 2019 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oy29wNN9GBy6oSj45jOS/QHPM0DY0tBLUEAftah8sTE=;
        b=ITyY5ftE0PtxiOfAbdw2dZnImhJ5EBWByceWCJTbpRO3bEby7KXirCi7019eeolL45
         MJm0G2lLR+piUv9ajwQ42pQT8w/2IH4W/dde+7HVrZIpZp54xhiX/kto3yhU4/cvfALd
         2mMoCpPk8D7Kt9az2GbhB/npqA2iQ52ThYNXzXzoRB5gzPbArjvp1PpiQb74UZ0DLbJN
         RxKkZqxji2vrwZP2DFilo7Ip5oSJSF+JdezUq4HWulqcm6e9bMXkEyjAMX53f+QJGT3q
         OyBdR97XMSGLX6zcEnApJf1PeHCkk3hfnbZw+NRE+HADWPlUs71HV5pH4wOHKPFBmNHc
         hobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oy29wNN9GBy6oSj45jOS/QHPM0DY0tBLUEAftah8sTE=;
        b=eU1H3WxiAe+5vJ8h7bmjUMUVQvYFI6QHa2Zpl7dmcSvOrKvbSVa/Y/rUxDB3WpnmLo
         x+IO9yyg/9LIZ4leGoNqO8rRo34Q33rNQhSeYN4NNZLlSZcdYfCjyWZp2CsT/cJHA8mX
         5JIFjFdKlyNgEwSF8CJQc+dZbFSYWSN43/gIuhjDrZOB8cD+K0AjpbTvYpOdF2BEvdX/
         wWUFmeFUGLwBxw9XBe5SKXXLfbKPxLeR27jXIg0xFdYybvHyg0HzSnbZnne4LRRvUK1L
         mynxWCuV7RerFCi1mgsU5KuZGHd720oj7zHjlI955aqhtZpjMvjIECxNT3f8MCDR8NJd
         w61Q==
X-Gm-Message-State: APjAAAUg2cu8aerDdkRdUCmrgyaH/z3TLGKaJV+nC8pX5nPDF91RZ4mG
        8FqnE2W9t+gxIjnlv4ll+y1KRj3w0jF6G9BwWgE=
X-Google-Smtp-Source: APXvYqw5H8SZwQoyAtrKfjh/mwGOJc9Eb4I00QEytWllJ72qbjJcwVd9hZ7x2/aATQBs6JykQGFFsBnFRMEaKg+gKco=
X-Received: by 2002:a2e:4601:: with SMTP id t1mr1276999lja.102.1567673308960;
 Thu, 05 Sep 2019 01:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
 <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
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
 <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de> <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com>
In-Reply-To: <CACAVd4jT4Ke7giPmKSzt+Wo3Ro-g9zWDRz_GHaRcs0Nb3_rkBw@mail.gmail.com>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Thu, 5 Sep 2019 14:18:17 +0530
Message-ID: <CACAVd4gRoQih6f_K7kMzr=AwA_DvP0OksxBKj1bGPsP2F_9sFg@mail.gmail.com>
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

When we adjust the date setting using date command we observed
'timerfd_read()' on CLOCK_REALTIME (TFD_TIMER_ABSTIME flag is set)
returns 0.
we don't see any hardware influence here and we are able to recreate
it consistently. Is it expected? if yes, isn't it something to be
documented in timerfd read() man page?

Steps followed to make timerfd read to return 0.

1. run the following script in background to move the date front and back

root@sonic:~/test/exp2# cat ./clock_change_test.sh
while [ 1 ]
do
date --set="04 sep 2019 09:50:21" > /dev/null
date --set="04 sep 2019 09:58:21" > /dev/null
done

root@sonic:~/test/exp2# ./clock_change_test.sh

2. Execute the following program to do read on CLOCK_REALTIME timer.

root@sonic:~/test/exp2# cat timerfdtest.c
#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/epoll.h>
#include <sys/timerfd.h>

int main()
{
        int tfd;
        struct itimerspec ts;
        tfd = timerfd_create(CLOCK_REALTIME, 0);
        ts.it_interval.tv_sec = 0;
        ts.it_interval.tv_nsec = 10;
        ts.it_value.tv_sec = 10;
        ts.it_value.tv_nsec = 1000;
        if (timerfd_settime(tfd, TFD_TIMER_ABSTIME, &ts, NULL) < 0) {
          return EXIT_FAILURE;
        }

        while(1) {
                uint64_t noftimeo;
                if (read(tfd, &noftimeo, sizeof(noftimeo)) == 0) {
                   printf("read returned 0 nooftimeo:%d\n", noftimeo);
                }
        }
        /* not reached */
        return EXIT_SUCCESS;
}

3. Observed the following read failure logs within few minutes.
root@sonic:~/test/exp2# ./timerfdtest
read returned 0 nooftimeo:1392


Regards,
Arul


On Tue, Aug 20, 2019 at 3:12 PM Arul Jeniston <arul.jeniston@gmail.com> wrote:
>
> Hi Tglx,
>
> > Can you please boot something more recent - at least 4.19 LTS - on that
> > machine and let it run for a couple of days to check whether there are 'TSC
> > ADJUST' related entries in dmesg?
>
> Sure. Would check and update.
>
> Regards,
> Arul
