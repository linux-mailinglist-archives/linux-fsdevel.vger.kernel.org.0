Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57C486AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 21:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbiAFUDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 15:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiAFUDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:03:34 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3C2C061245
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jan 2022 12:03:34 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id p15so10583240ybk.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jan 2022 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=70M1OWXHUOeWdY5V1Tvpq+AtYB0saWSNzIdMX2VjKV4=;
        b=FyG8ekLLjhoijZqWPDM5xPKidzow7y2C6Ghx4Crbe/H4WXNYhX6AJNZ/eewiTFKQQ7
         gH/zkJ3x1MFlh0OrE5YxD856aXUdBRxUF1se1lYzrnF4dbUYeoSXor+BggdCb5e66B6L
         E9DhYVtaaky+sFf3AHSZjnwLT+qxukUdl8Hi9EDpQb8TiW0tyIWRXEwa+O7nASYwwOeh
         /oJ62TYI+AG58XWdi5mmhcYW0pCmsgPMuxvTooCZb/3pNtj4+K7jhXSdSoUCdiOQ7TZ/
         Y333pa6ThaXI3AoRDfjoSGUr43quAxhrvSEX8HClVWmIgs20SSQETMFff/qdVNz+OZ2v
         ka+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=70M1OWXHUOeWdY5V1Tvpq+AtYB0saWSNzIdMX2VjKV4=;
        b=7RXLNbwMJRbZWUcPHIB8KRt/n+wmMmjkd52r7VRIdjrMPzEwSjUktNIw6XtQhcJR+3
         Y3OcfT/Ke7qKNW74E5Iv48wLAHC9DJi/dmJRshgCxxoN3Vw2wX7JTrtcKJ2qoJR0K2PK
         5aEi0FIWcXhRRC1/imCK1V/OemaI5kYZhYg+B8lcZH9N4bwtuA9lLTg+fvwsMKfKbit5
         qIhG0rrQ0YBgcXUMn3LC/1wzbt14jFZBqZBmu9MK7/cjm/VgCW0G6iBy07akNHlb45NW
         8u8vdrbwQjrrUcYjY/SiR1FuvSHBVAIdpl7Abc3pBQDxwrDXOxEWrojPiQLQQ1tRIDia
         20xg==
X-Gm-Message-State: AOAM533JoT9X/dvCC1BP6rYx6yZtcF5l1FDDexxHlgEqj4BtmcaLd1oD
        g1MDIYnASd+yW7xAHkD+h5B2ANM8zrt8sTcbTGSXJA==
X-Google-Smtp-Source: ABdhPJw89k9TysJGaev98wXI7WHOMoJOINGotZBTI7r+WMM8saSahB1ZI0vIe7f8uCizsk36XxZfXd2qerxSwUqhmYo=
X-Received: by 2002:a25:7754:: with SMTP id s81mr69645942ybc.9.1641499412571;
 Thu, 06 Jan 2022 12:03:32 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-3-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NsP+sMQPRwS2e3zoeBsX1+p2aevFFO+i9GdB5VQ0ujEbA@mail.gmail.com>
 <8be4679f-632b-97e5-9e48-1e1a37727ddf@linux.alibaba.com> <CABk29Nv4OXnNz5-ZdYmAE8o0YpmhkbH=GooksaKYY7n0YYUQxg@mail.gmail.com>
 <3dc03eec-e88c-f886-efd5-81162350f12c@linux.alibaba.com>
In-Reply-To: <3dc03eec-e88c-f886-efd5-81162350f12c@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 6 Jan 2022 12:03:21 -0800
Message-ID: <CABk29Nt9TMyQJWSYRzWMmmHpT5z85npganZKAF9vkBqJWDhx6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/core: Uncookied force idle accounting per cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:05 AM cruzzhao <cruzzhao@linux.alibaba.com> wrote:
>
>
> =E5=9C=A8 2022/1/6 =E4=B8=8A=E5=8D=884:59, Josh Don =E5=86=99=E9=81=93:
>
> It's a good idea to combine them into a single sum. I separated them in
> order to be consistent with the task accounting and for easy to understan=
d.
> As for change the task accounting, I've tried but I haven't found a
> proper method to do so. I've considered the following methods:
> 1. Account the uncookie'd force idle time to the uncookie'd task, but
> it'll be hard to trace the uncookie'd task.

Not sure what you mean there, I think you just need to add

--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -294,7 +294,7 @@ void sched_core_account_forceidle(struct rq *rq)
                rq_i =3D cpu_rq(i);
                p =3D rq_i->core_pick ?: rq_i->curr;

-               if (!p->core_cookie)
+               if (p =3D=3D rq_i->idle)
                        continue;

                __schedstat_add(p->stats.core_forceidle_sum, delta)

> 2. Account the uncookie'd force idle time to the cookie'd task in the
> core_tree of the core, but it will cost a lot on traversing the core_tree=
.
>
> Many thanks for suggestions.
> Best,
> Cruz Zhao
>
> > Why do you need this separated out into two fields then? Could we just
> > combine the uncookie'd and cookie'd forced idle into a single sum?
> >
> > IMO it is fine to account the forced idle from uncookie'd tasks, but
> > we should then also change the task accounting to do the same, for
> > consistency.
