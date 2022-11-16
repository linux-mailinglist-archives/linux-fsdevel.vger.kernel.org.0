Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41A562C10C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 15:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiKPOiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 09:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKPOiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:38:20 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866532EF16
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 06:38:18 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y6so13312651iof.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Nov 2022 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4nW3VJI1lfeD4fySwB9DzBzi1swDIer5Gyl0OAqvGE=;
        b=OaL/LEF0d+5PYrXpA+O3Qqc74mnM0KjMdinxbvepma7nRVQizJz/IXFf7UjEzzI1Ox
         N6u9b1DkOtyQvHshQ0oRC1uQG8A4edQ/rTh0nDSgcEteUlIvYoNSCSjhU91DUL6gQOvu
         K8IS51aZmzsWPjeunquUg0ZfjOW3sjnqZcFB8kQ/RngtuORk7L+BnIgpi/ZtFmY+xs0n
         UegouY38awN0u8WNa4dMq6Lb9O/vrkCgssy+MBSKoEH5OHvnvqbNXNzUr7rbQ7OF2Iim
         zDdW7DbI0YYSEgzZ5dXF5Tbfk/4Vzz9VPCyyNsJ2LcTg10Xnux14TOE+iocMf6LN6sGt
         v2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4nW3VJI1lfeD4fySwB9DzBzi1swDIer5Gyl0OAqvGE=;
        b=m7G4axCcTflLXHQvj3sdeOWyzIItyOUqstToMjvvP5ZNMCgTtB2rkrzrrhhSa9YRLE
         aSH13JvKOGeUV4D8MyKB/GInZBVR6c2ikKAyh0GstY0BoSGJt/c3rkNnnMeWETG7LlQT
         mICTmhkeQNJutCutVo8NuS7XcPINW5YF8O5EEHP/PGgWiIW8MXNK7DuRgPZiw4eG0eYu
         hEO1AFsSSLQrLvLRS76POg60Hj789P7dQIpw4zwekMGySWi/htXn/Q/HxEVDLncelu1t
         lscvX3GZ4LvyLvwo64hdPHEclcoRxbKqe6S5n2V7km07ffZY6iQOA4J8ae1IbNLAkJ04
         MQ3w==
X-Gm-Message-State: ANoB5pk39U0JawXeW/nX+NjTxLYz9aLrmBrTJ6EePptxyraqp5S40QXA
        f6mjSqQakL5+bsnfl5/p3K6obLddOA17IIJ39iHSgg==
X-Google-Smtp-Source: AA0mqf6USQf14kRtWcVjc7+0+jhF4sesd5MnF+iPpoCjeAxGmqwWMavbJVlnKVm5Mde5BZ1wB1JNwjn4iAEpIFfBN+Q=
X-Received: by 2002:a6b:6401:0:b0:6bc:a758:9546 with SMTP id
 t1-20020a6b6401000000b006bca7589546mr9935308iog.78.1668609497766; Wed, 16 Nov
 2022 06:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20221102035301.512892-1-zhangsong34@huawei.com>
 <CAKfTPtCcYySw2ZC_pr8=3KFPmAAVN=1h8=5jWkW5YXyy11sehg@mail.gmail.com>
 <b45f96b6-e0b2-22bb-eda1-2468d6fbe104@huawei.com> <CAKfTPtDrWCenxtVcunjS3pGD81TdLf2EkhO_YcdfxnUHXpVF3w@mail.gmail.com>
 <4bad43c0-40a4-dc39-7214-f2c3321a47ee@huawei.com> <CAKfTPtCwUvkqnzs9n0G+cyE5h5QdgwoKF-gNu+4A5g4NHNRe9w@mail.gmail.com>
 <7d887171-491a-1d36-0926-d0486aacc9c2@huawei.com> <CAKfTPtCHZm2AKemnpE1UvQPsgpB5ycFdjkJa1pHQS-=DYJ2-KA@mail.gmail.com>
 <CAKfTPtAMdQD9S-mbLszeu2pjB4YB2A+1OM5NUV_2xDzCTCc7Qw@mail.gmail.com> <241e837b-056a-4fde-0673-205bd7400e82@huawei.com>
In-Reply-To: <241e837b-056a-4fde-0673-205bd7400e82@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Nov 2022 15:38:06 +0100
Message-ID: <CAKfTPtCGSSmN+GBFf7F1sXvQKAxQbXm3rS3dXvdA4ERFs9h3hQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Introduce priority load balance for CFS
To:     Song Zhang <zhangsong34@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Nov 2022 at 08:37, Song Zhang <zhangsong34@huawei.com> wrote:
>
>
>
> On 2022/11/15 15:18, Vincent Guittot wrote:
> > On Mon, 14 Nov 2022 at 17:42, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Sat, 12 Nov 2022 at 03:51, Song Zhang <zhangsong34@huawei.com> wrote:
> >>>
> >>> Hi, Vincent
> >>>
> >>> On 2022/11/3 17:22, Vincent Guittot wrote:
> >>>> On Thu, 3 Nov 2022 at 10:20, Song Zhang <zhangsong34@huawei.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2022/11/3 16:33, Vincent Guittot wrote:
> >>>>>> On Thu, 3 Nov 2022 at 04:01, Song Zhang <zhangsong34@huawei.com> wrote:
> >>>>>>>
> >>>>>>> Thanks for your reply!
> >>>>>>>
> >>>>>>> On 2022/11/3 2:01, Vincent Guittot wrote:
> >>>>>>>> On Wed, 2 Nov 2022 at 04:54, Song Zhang <zhangsong34@huawei.com> wrote:
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> This really looks like a v3 of
> >>>>>>>> https://lore.kernel.org/all/20220810015636.3865248-1-zhangsong34@huawei.com/
> >>>>>>>>
> >>>>>>>> Please keep versioning.
> >>>>>>>>
> >>>>>>>>> Add a new sysctl interface:
> >>>>>>>>> /proc/sys/kernel/sched_prio_load_balance_enabled
> >>>>>>>>
> >>>>>>>> We don't want to add more sysctl knobs for the scheduler, we even
> >>>>>>>> removed some. Knob usually means that you want to fix your use case
> >>>>>>>> but the solution doesn't make sense for all cases.
> >>>>>>>>
> >>>>>>>
> >>>>>>> OK, I will remove this knobs later.
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>> 0: default behavior
> >>>>>>>>> 1: enable priority load balance for CFS
> >>>>>>>>>
> >>>>>>>>> For co-location with idle and non-idle tasks, when CFS do load balance,
> >>>>>>>>> it is reasonable to prefer migrating non-idle tasks and migrating idle
> >>>>>>>>> tasks lastly. This will reduce the interference by SCHED_IDLE tasks
> >>>>>>>>> as much as possible.
> >>>>>>>>
> >>>>>>>> I don't agree that it's always the best choice to migrate a non-idle task 1st.
> >>>>>>>>
> >>>>>>>> CPU0 has 1 non idle task and CPU1 has 1 non idle task and hundreds of
> >>>>>>>> idle task and there is an imbalance between the 2 CPUS: migrating the
> >>>>>>>> non idle task from CPU1 to CPU0 is not the best choice
> >>>>>>>>
> >>>>>>>
> >>>>>>> If the non idle task on CPU1 is running or cache hot, it cannot be
> >>>>>>> migrated and idle tasks can also be migrated from CPU1 to CPU0. So I
> >>>>>>> think it does not matter.
> >>>>>>
> >>>>>> What I mean is that migrating non idle tasks first is not a universal
> >>>>>> win and not always what we want.
> >>>>>>
> >>>>>
> >>>>> But migrating online tasks first is mostly a trade-off that
> >>>>> non-idle(Latency Sensitive) tasks can obtain more CPU time and minimize
> >>>>> the interference caused by IDLE tasks. I think this makes sense in most
> >>>>> cases, or you can point out what else I need to think about it ?
> >>>>>
> >>>>> Best regards.
> >>>>>
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>> Testcase:
> >>>>>>>>> - Spawn large number of idle(SCHED_IDLE) tasks occupy CPUs
> >>>>>>>>
> >>>>>>>> What do you mean by a large number ?
> >>>>>>>>
> >>>>>>>>> - Let non-idle tasks compete with idle tasks for CPU time.
> >>>>>>>>>
> >>>>>>>>> Using schbench to test non-idle tasks latency:
> >>>>>>>>> $ ./schbench -m 1 -t 10 -r 30 -R 200
> >>>>>>>>
> >>>>>>>> How many CPUs do you have ?
> >>>>>>>>
> >>>>>>>
> >>>>>>> OK, some details may not be mentioned.
> >>>>>>> My virtual machine has 8 CPUs running with a schbench process and 5000
> >>>>>>> idle tasks. The idle task is a while dead loop process below:
> >>>>>>
> >>>>>> How can you care about latency when you start 10 workers on 8 vCPUs
> >>>>>> with 5000 non idle threads ?
> >>>>>>
> >>>>>
> >>>>> No no no... spawn 5000 idle(SCHED_IDLE) processes not 5000 non-idle
> >>>>> threads, and with 10 non-idle schbench workers on 8 vCPUs.
> >>>>
> >>>> yes spawn 5000 idle tasks but my point remains the same
> >>>>
> >>>
> >>> I am so sorry that I have not received your reply for a long time, and I
> >>> am still waiting for it anxiously. In fact, migrating non-idle tasks 1st
> >>> works well in most scenarios, so it maybe possible to add a
> >>> sched_feat(LB_PRIO) to enable or disable that. Finally, I really hope
> >>> you can give me some better advice.
> >>
> >> I have seen that you posted a v4 5 days ago which is on my list to be reviewed.
> >>
> >> My concern here remains that selecting non idle task 1st is not always
> >> the best choices as for example when you have 1 non idle task per cpu
> >> and thousands of idle tasks moving around. Then regarding your use
> >> case, the weight of the 5000 idle threads is around twice more than
> >> the weight of your non idle bench: sum weight of idle threads is 15k
> >> whereas the weight of your bench is around 6k IIUC how RPS run. This
> >> also means that the idle threads will take a significant times of the
> >> system: 5000 / 7000 ticks. I don't understand how you can care about
> >> latency in such extreme case and I'm interested to get the real use
> >> case where you can have such situation.
> >>
> >> All that to say that idle task remains cfs task with a small but not
> >> null weight and we should not make them special other than by not
> >> preempting at wakeup.
> >
> > Also, as mentioned for a previous version, a task with nice prio 19
> > has a weight of 15 so if you replace the 5k idle threads with 1k cfs
> > w/ nice prio 19 threads, you will face a similar problem. So you can't
> > really care only on the idle property of a task
> >
>
> Well, my original idea was to consider interference between tasks of
> different priorities when doing CFS load balancing to ensure that
> non-idle tasks get more CPU scheduler time without changing the native
> CFS load balancing policy.
>
> Consider a simple scenario. Assume that CPU 0 has two non-idle tasks
> whose weight is 1024 * 2 = 2048, also CPU 0 has 1000 idle tasks whose
> weight is 1K x 15 = 15K. CPU 1 is idle. Therefore, IDLE load balance is

weight of cfs idle thread is 3, the weight of cfs nice 19 thread is 15

> triggered. CPU 1 needs to pull a certain number of tasks from CPU 0. If
> we do not considerate task priorities and interference between tasks,
> more than 600 idle tasks on CPU 0 may be migrated to CPU 1. As a result,
> two non-idle tasks still compete on CPU 0. However, CPU 1 is running
> with all idle but not non-idle tasks.
>
> Let's calculate the percentage of CPU time gained by non-idle tasks in a
> scheduling period:
>
> CPU 1: time_percent(non-idle tasks) = 0
> CPU 0: time_percent(non-idle tasks) = 2048 * 2 / (2048 + 15000) = 24%

2 cfs task nice 0 with 1000 cfs idle tasks on 2 CPUs. The weight of
the system is:

2*1024 + 1000*3 = 5048 or  2524 per CPU

This means that the cfs nice 0 task should get 1024/(5048) = 20% of
system time which means 40% of CPUs time.

This also means that the 2 cfs tasks on CPU0 is a valid configuration
as they will both have their 40% of CPUs

cfs idle threads have a small weight to be negligible compared to
"normal" threads so they can't normally balance a system by themself
but by spawning 1000+ cfs idle threads, you make them not negligible
anymore. That's the root of your problem. A CPU with only cfs idle
tasks should be seen unbalanced compared to other CPUs with non idle
tasks and this is what is happening with small/normal number of cfs
idle threads

>
> On the other hand, if we consider the interference between different
> task priorities, we change the migration policy to firstly migrate an
> non-idle task on CPU 0 to CPU 1. Migrating idle tasks on CPU 0 maybe
> interfered with the non-idle task on CPU 1. So we decide to migrate idle
> tasks on CPU 0 after non-idle tasks on CPU 1 are completed or exited.
>
> Now the percentage of the CPU time obtained by the non-idle tasks in a
> scheduling period is as follows:
>
> CPU 1: time_percent(non-idle tasks) = 1024 / 1024 = 100%
> CPU 0: time_percent(non-idle tasks) = 1024 / (1024 + 15000) = 6.4%

But this is unfair for one cfs nice 0 thread and all cfs idle threads

>
> Obviously, if load balance migration tasks prefer migrate non-idle tasks
> and suppress the interference of idle tasks migration on non-idle tasks,
> the latency of non-idle tasks can be significantly reduced. Although
> this will cause some idle tasks imbalance between different CPUs and
> reduce throughput of idle tasks., I think this strategy is feasible in
> some real-time business scenarios for latency tasks.

But idle cfs ask remains cfs task and we keep cfs fairness for all threads

Have you tried to :
- Increase nice priority of the non idle cfs task so the sum of the
weight of idle tasks remain a small portion of the total weight ?
- to put your thousands idle tasks in a cgroup and set cpu.idle for
this cgroup. This should also ensure that the weight of idle threads
remains negligible compared to others.

I have tried both setup in my local system and I have 1 non idle task per CPU

Regards,
Vincent

>
> >>
> >>>
> >>> Best regards.
> >>>
> >>> Song Zhang
> > .
