Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111F368B8AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBFJ2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 04:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBFJ2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:28:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95151BCA
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 01:28:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g13so6689840ple.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 01:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R04S0qZcEuvqwTFUGr5yTppgbV2UI+APpbonbcIO+xw=;
        b=bkg+x4uqz4aqdpI1qYPCNGQy3d99LN/Lk3ogwj0e3Su3HOA3+VEIUfsHIJuadsccI0
         hSHYiLZ8nxyUln/bI3Jj6t9tJltE3L1tzleDPIBBEk3GBvpcoIbJSnpzNtPYp0j5pUsk
         s081zeo96Fyy+qPOy6VQHR1Sk9lGVrTvqlqZBns0qOJbDdqZGbNy68OPZYTjMu6ZUi4R
         /5ZcCtNqIT/Zo8zndx9Aq4J9ngieXC++B6FrF6OGCi9geP0b2yvPXmRUICBvg8V9bVqO
         +oDU0IIPQlNru8wkpvVcQz/Ii9ZGe4Bvp26EzFuVJla5mpbbs9o2su+AytE9nSDiUNxn
         Y2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R04S0qZcEuvqwTFUGr5yTppgbV2UI+APpbonbcIO+xw=;
        b=7MRd4bBrrfG3wwzl0P8+wMlZtnvLEiEKLQBIwj0Tgc7LGOH5anQRAIUNQW7DoZlDfA
         5+nsdbFLVroYOj9hWYEON/+YryRvbllUyPHdTvYImXwUqtp+kCyZCqZ/LLBGEEHkqaZh
         +dtEz9QJ841iq5dJwHdJ8cClrdYY/WrCa3kycgReQSllZIKK9HTK3bJ3Xk5XVYoTwenP
         SpRSVTZ9CC5KwCD//s22dl9vuuN3YLOM/Lc8DfVT2mXuNphJHBXtw2qigGDyQJN10WFc
         KlybfOVWsCwAKmF1m6PH8xjLFr/mQvvefmWPpALrCBzgnhM3Xli2eP7gK2Y+8Qcd23/a
         mNDQ==
X-Gm-Message-State: AO0yUKVQ7QYrx1Y2HxmBl2COmWe9cl5wMk76KhK76TGSuZKU6zk21fls
        MApFJdo9i5hkKscpeWv0HW14rQAOcZl6660g0YNWwg==
X-Google-Smtp-Source: AK7set9Pu7DRyILz/wqe5rDPOBdJpuT8N7scdJsueOKvz02K8H24Ka27uRrfZIwTKdI/92KjBEcxsQj3YjzqopISKik=
X-Received: by 2002:a17:90a:3844:b0:230:7ea2:1a04 with SMTP id
 l4-20020a17090a384400b002307ea21a04mr1743133pjf.112.1675675693158; Mon, 06
 Feb 2023 01:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20230201012032.2874481-1-xii@google.com> <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
 <CAOBoifgz0pRCBUqo7+X2BKgSuHmQLB6X0LZ9D2eYvboO5yzybg@mail.gmail.com>
In-Reply-To: <CAOBoifgz0pRCBUqo7+X2BKgSuHmQLB6X0LZ9D2eYvboO5yzybg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 6 Feb 2023 10:28:02 +0100
Message-ID: <CAKfTPtCpfrCbi+ZRtBFV0NfQfv9r1oe30BZM4D3_70PQGkxCdw@mail.gmail.com>
Subject: Re: [PATCH] sched: Consider capacity for certain load balancing decisions
To:     Xi Wang <xii@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 3 Feb 2023 at 19:47, Xi Wang <xii@google.com> wrote:
>
> On Fri, Feb 3, 2023 at 1:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jan 31, 2023 at 05:20:32PM -0800, Xi Wang wrote:
> > > After load balancing was split into different scenarios, CPU capacity
> > > is ignored for the "migrate_task" case, which means a thread can stay
> > > on a softirq heavy cpu for an extended amount of time.
> > >
> > > By comparing nr_running/capacity instead of just nr_running we can add
> > > CPU capacity back into "migrate_task" decisions. This benefits
> > > workloads running on machines with heavy network traffic. The change
> > > is unlikely to cause serious problems for other workloads but maybe
> > > some corner cases still need to be considered.
> > >
> > > Signed-off-by: Xi Wang <xii@google.com>
> > > ---
> > >  kernel/sched/fair.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 0f8736991427..aad14bc04544 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > >                       break;
> > >
> > >               case migrate_task:
> > > -                     if (busiest_nr < nr_running) {
> > > +                     if (busiest_nr * capacity < nr_running * busiest_capacity) {
> > >                               busiest_nr = nr_running;
> > > +                             busiest_capacity = capacity;
> > >                               busiest = rq;
> > >                       }
> > >                       break;
> >
> > I don't think this is correct. The migrate_task case is work-conserving,
> > and your change can severely break that I think.
> >
>
> I think you meant this kind of scenario:
> cpu 0: idle
> cpu 1: 2 tasks
> cpu 2: 1 task but only has 30% of capacity
> Pulling from cpu 2 is good for the task but lowers the overall cpu
> throughput.
>
> The problem we have is:
> cpu 0: idle
> cpu 1: 1 task
> cpu 2: 1 task but only has 60% of capacity due to net softirq
> The task on cpu 2 stays there and runs slower. (This can also be
> considered non work-conserving if we account softirq like a task.)

When load_balance runs for this 2 cpus, cpu2 should be tagged as
misfit_task because of reduce_capacity and should be selected in
priority by cpu0 to pull the task. Do you have more details on your
topology ?


>
> Maybe the logic can be merged like this: Use capacity but pick from
> nr_running > 1 cpus first, then nr_running == 1 cpus if not found.
