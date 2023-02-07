Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9A868CBA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 02:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBGBDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 20:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBGBDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:03:43 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BACD34327
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 17:03:34 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id cz14so1959736oib.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 17:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QSj4kxFW4AgQmOuVcsVA7yLCKNqRzPt1gHsxIC0alFE=;
        b=L57lsC6qkeqMTuw6hr/sTfMoa5MUkXLdaizJFyr40dHUdl3mVF97SJV36EqzzxZs3o
         pkExpmDw8bY3kUlDPthP/aGRPXpXK5lptMD1jaJy114p+fhq68OVIkvxXF0jzNpAK8KV
         Y0hSYRmYo+B03JIiIrmSz0rJt6D9Cr2HTpHJr2I5c4fGs19YXl5Kobq7mMlw+vnNBcnI
         mTnZhfcdxwbeaYAr/ngC1R1aaucVGhglTc+lwjXkjo1MSVW3J9Ega6SWdGrdK9Yxb2j8
         oxR4o9BuFNyyc6sq5i5VIiJCi5o7/zJQXHNvExGIlwBq+73KxP8rzIhYspN1xGHZiRvZ
         Ab1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSj4kxFW4AgQmOuVcsVA7yLCKNqRzPt1gHsxIC0alFE=;
        b=xAOo4WKGEYEFc7T2DlsK08O05+bjmGgcZRvtI1sN4UaJFZproE0DaAJ3VhP2sAodzI
         /Hk++dMSEf7LC7xEyu7N8RcsyrkycWFIPUyW3YZOoUh5Md7z8M0qKZUZ/lf7iha9rvxc
         FkaBSdyAg9k7+qWSQ8a0WnAC8N5j37nbnJqFZCd34gMRy9nTkFg97nZClxzTxhn4tgGd
         yHEcY+XebJdTap7SPzIGM+bQvWVlsYbeUDjvh5d7ErRTz8sgQLddcVszvqv7uwygFIUj
         gLpAS+DTUm0FNUUxQ4JyL0Dv4fvS5OLCC9UYhpScCvC/8kI27heI/j3da5C//GzbGBof
         IjIA==
X-Gm-Message-State: AO0yUKUz/RK9Z3c+cXJGXXAnShQsq2Zbt+Sdbm+WeY26C9zlVuub2UOI
        0ZnWov7T7gldVaHZukrwD1YWWfGcfff+5SrghUGyag==
X-Google-Smtp-Source: AK7set8oQ2fhqwdZaeCylXp1oQ6nmp4ffA2mFC+unSf2a292VCob5bsMWAYY2XfAY6I8HxWS+iyTqKWwJmfqdFX/Cvs=
X-Received: by 2002:a05:6808:2c6:b0:367:eed:a770 with SMTP id
 a6-20020a05680802c600b003670eeda770mr1247775oid.282.1675731812227; Mon, 06
 Feb 2023 17:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20230201012032.2874481-1-xii@google.com> <Y9zZDcIua63WOdG7@hirez.programming.kicks-ass.net>
 <CAOBoifgz0pRCBUqo7+X2BKgSuHmQLB6X0LZ9D2eYvboO5yzybg@mail.gmail.com> <CAKfTPtCpfrCbi+ZRtBFV0NfQfv9r1oe30BZM4D3_70PQGkxCdw@mail.gmail.com>
In-Reply-To: <CAKfTPtCpfrCbi+ZRtBFV0NfQfv9r1oe30BZM4D3_70PQGkxCdw@mail.gmail.com>
From:   Xi Wang <xii@google.com>
Date:   Mon, 6 Feb 2023 17:03:21 -0800
Message-ID: <CAOBoifh_=fJe6Qk7=Qi+R1fXyjmpVHpHsceUwKrX2e9oVAd5AQ@mail.gmail.com>
Subject: Re: [PATCH] sched: Consider capacity for certain load balancing decisions
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 6, 2023 at 1:28 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 3 Feb 2023 at 19:47, Xi Wang <xii@google.com> wrote:
> >
> > On Fri, Feb 3, 2023 at 1:51 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jan 31, 2023 at 05:20:32PM -0800, Xi Wang wrote:
> > > > After load balancing was split into different scenarios, CPU capacity
> > > > is ignored for the "migrate_task" case, which means a thread can stay
> > > > on a softirq heavy cpu for an extended amount of time.
> > > >
> > > > By comparing nr_running/capacity instead of just nr_running we can add
> > > > CPU capacity back into "migrate_task" decisions. This benefits
> > > > workloads running on machines with heavy network traffic. The change
> > > > is unlikely to cause serious problems for other workloads but maybe
> > > > some corner cases still need to be considered.
> > > >
> > > > Signed-off-by: Xi Wang <xii@google.com>
> > > > ---
> > > >  kernel/sched/fair.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 0f8736991427..aad14bc04544 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -10368,8 +10368,9 @@ static struct rq *find_busiest_queue(struct lb_env *env,
> > > >                       break;
> > > >
> > > >               case migrate_task:
> > > > -                     if (busiest_nr < nr_running) {
> > > > +                     if (busiest_nr * capacity < nr_running * busiest_capacity) {
> > > >                               busiest_nr = nr_running;
> > > > +                             busiest_capacity = capacity;
> > > >                               busiest = rq;
> > > >                       }
> > > >                       break;
> > >
> > > I don't think this is correct. The migrate_task case is work-conserving,
> > > and your change can severely break that I think.
> > >
> >
> > I think you meant this kind of scenario:
> > cpu 0: idle
> > cpu 1: 2 tasks
> > cpu 2: 1 task but only has 30% of capacity
> > Pulling from cpu 2 is good for the task but lowers the overall cpu
> > throughput.
> >
> > The problem we have is:
> > cpu 0: idle
> > cpu 1: 1 task
> > cpu 2: 1 task but only has 60% of capacity due to net softirq
> > The task on cpu 2 stays there and runs slower. (This can also be
> > considered non work-conserving if we account softirq like a task.)
>
> When load_balance runs for this 2 cpus, cpu2 should be tagged as
> misfit_task because of reduce_capacity and should be selected in
> priority by cpu0 to pull the task. Do you have more details on your
> topology ?

The topology is 64 core AMD with 2 hyperthreads.

I am not familiar with the related code but I think there are cases
where a task fits cpu capacity but it can still run faster elsewhere,
e.g.: Bursty workloads. Thread pool threads with variable utilization
because it would process more or less requests based on cpu
availability (pick the next request from a shared queue when the
previous one is done). A thread having enough cpu cycles but runs
slower due to softirqs can also directly affect application
performance.

> >
> > Maybe the logic can be merged like this: Use capacity but pick from
> > nr_running > 1 cpus first, then nr_running == 1 cpus if not found.
