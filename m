Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C1629257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 08:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiKOHSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 02:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKOHSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:18:25 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA220377
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 23:18:22 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id o13so6980386ilc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 23:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dDOq5hHv6AVi/wyrBOv5M+hykVo3T4Nk4to/mUGyDKs=;
        b=tegEvnzZulUoHKycows8UYUSa1Fr1t9i8JqMMRxEiyZGpKw44PbG7oNArutszNdjz5
         QwhzWmCuAGffg2UpDQefgCp7+hN62skzDZQ8/xMRKAy4RhjAQkhhmnE2GQi/QEkM+0g0
         4C6gXNHASDAVueKeUBXG9Z6QX4VncaxpRTe4lAUY1LzcByz38EKhBzCg6FoCF2V5cM1W
         JXSG2vhSe9PMEx0O+ji0o32Ib7RY2B6N32vF+YSQQ8jgqOcydQpZjoK+LLZKb1Rh9+qs
         SLkoDcMtebP0C9Dj9cSIn8MKJbqmgqDHxa4uHZ9x+COZPHHzHCBLh/l6S/aSZp2yPJSO
         +QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDOq5hHv6AVi/wyrBOv5M+hykVo3T4Nk4to/mUGyDKs=;
        b=iiqsBO/ywG80Gx9Ike66/IGtkVayHaoXR2Y8JLNvox+CxS6z1JKIaaphCfHHCy3Crz
         w0Xc9g457dundJcpcdVUricj+hc99/za4OviiAvcIajhQ3VzfilrbOQOk42FrMrg2Nmt
         gnuEX1bwYRtoi0Mwc2gErC0VFMaDKX18WqoQdayn5tshOFckeHcTwQ+y8aJrMSI7GLcK
         /EU0iMo+5esOZGb2qqO6rmkgE0OKdsgIIsxZWF4GRhXdtIk6GigcEJ3eY6BuS9FjgA+W
         0yYoDAZ03B5ojV+0EAU2bQWPJWmzSs7hFiAQzXy5FF7YUEdXA60rUXqILSlNNN6U/RPR
         c51Q==
X-Gm-Message-State: ANoB5pkp24ukFjjERajV7A5GCliQ4ZM+yMQIBkelytNFN9Y6Q+JxnJ7A
        1fqJlizPc1JfI4Rv/3hUmDu7S+xt/EcynfP7yv+wYg==
X-Google-Smtp-Source: AA0mqf4Sf29emJ35AtROAr+iIyOB/tVwFXqaeA8RmhHDmiRGXi1SiHL7tmyGBtYlosGaCQ0hefr1mtpb6FYSGqBXSTg=
X-Received: by 2002:a05:6e02:cce:b0:300:cf38:174f with SMTP id
 c14-20020a056e020cce00b00300cf38174fmr8031185ilj.22.1668496701950; Mon, 14
 Nov 2022 23:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20221102035301.512892-1-zhangsong34@huawei.com>
 <CAKfTPtCcYySw2ZC_pr8=3KFPmAAVN=1h8=5jWkW5YXyy11sehg@mail.gmail.com>
 <b45f96b6-e0b2-22bb-eda1-2468d6fbe104@huawei.com> <CAKfTPtDrWCenxtVcunjS3pGD81TdLf2EkhO_YcdfxnUHXpVF3w@mail.gmail.com>
 <4bad43c0-40a4-dc39-7214-f2c3321a47ee@huawei.com> <CAKfTPtCwUvkqnzs9n0G+cyE5h5QdgwoKF-gNu+4A5g4NHNRe9w@mail.gmail.com>
 <7d887171-491a-1d36-0926-d0486aacc9c2@huawei.com> <CAKfTPtCHZm2AKemnpE1UvQPsgpB5ycFdjkJa1pHQS-=DYJ2-KA@mail.gmail.com>
In-Reply-To: <CAKfTPtCHZm2AKemnpE1UvQPsgpB5ycFdjkJa1pHQS-=DYJ2-KA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 15 Nov 2022 08:18:10 +0100
Message-ID: <CAKfTPtAMdQD9S-mbLszeu2pjB4YB2A+1OM5NUV_2xDzCTCc7Qw@mail.gmail.com>
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

On Mon, 14 Nov 2022 at 17:42, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sat, 12 Nov 2022 at 03:51, Song Zhang <zhangsong34@huawei.com> wrote:
> >
> > Hi, Vincent
> >
> > On 2022/11/3 17:22, Vincent Guittot wrote:
> > > On Thu, 3 Nov 2022 at 10:20, Song Zhang <zhangsong34@huawei.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2022/11/3 16:33, Vincent Guittot wrote:
> > >>> On Thu, 3 Nov 2022 at 04:01, Song Zhang <zhangsong34@huawei.com> wrote:
> > >>>>
> > >>>> Thanks for your reply!
> > >>>>
> > >>>> On 2022/11/3 2:01, Vincent Guittot wrote:
> > >>>>> On Wed, 2 Nov 2022 at 04:54, Song Zhang <zhangsong34@huawei.com> wrote:
> > >>>>>>
> > >>>>>
> > >>>>> This really looks like a v3 of
> > >>>>> https://lore.kernel.org/all/20220810015636.3865248-1-zhangsong34@huawei.com/
> > >>>>>
> > >>>>> Please keep versioning.
> > >>>>>
> > >>>>>> Add a new sysctl interface:
> > >>>>>> /proc/sys/kernel/sched_prio_load_balance_enabled
> > >>>>>
> > >>>>> We don't want to add more sysctl knobs for the scheduler, we even
> > >>>>> removed some. Knob usually means that you want to fix your use case
> > >>>>> but the solution doesn't make sense for all cases.
> > >>>>>
> > >>>>
> > >>>> OK, I will remove this knobs later.
> > >>>>
> > >>>>>>
> > >>>>>> 0: default behavior
> > >>>>>> 1: enable priority load balance for CFS
> > >>>>>>
> > >>>>>> For co-location with idle and non-idle tasks, when CFS do load balance,
> > >>>>>> it is reasonable to prefer migrating non-idle tasks and migrating idle
> > >>>>>> tasks lastly. This will reduce the interference by SCHED_IDLE tasks
> > >>>>>> as much as possible.
> > >>>>>
> > >>>>> I don't agree that it's always the best choice to migrate a non-idle task 1st.
> > >>>>>
> > >>>>> CPU0 has 1 non idle task and CPU1 has 1 non idle task and hundreds of
> > >>>>> idle task and there is an imbalance between the 2 CPUS: migrating the
> > >>>>> non idle task from CPU1 to CPU0 is not the best choice
> > >>>>>
> > >>>>
> > >>>> If the non idle task on CPU1 is running or cache hot, it cannot be
> > >>>> migrated and idle tasks can also be migrated from CPU1 to CPU0. So I
> > >>>> think it does not matter.
> > >>>
> > >>> What I mean is that migrating non idle tasks first is not a universal
> > >>> win and not always what we want.
> > >>>
> > >>
> > >> But migrating online tasks first is mostly a trade-off that
> > >> non-idle(Latency Sensitive) tasks can obtain more CPU time and minimize
> > >> the interference caused by IDLE tasks. I think this makes sense in most
> > >> cases, or you can point out what else I need to think about it ?
> > >>
> > >> Best regards.
> > >>
> > >>>>
> > >>>>>>
> > >>>>>> Testcase:
> > >>>>>> - Spawn large number of idle(SCHED_IDLE) tasks occupy CPUs
> > >>>>>
> > >>>>> What do you mean by a large number ?
> > >>>>>
> > >>>>>> - Let non-idle tasks compete with idle tasks for CPU time.
> > >>>>>>
> > >>>>>> Using schbench to test non-idle tasks latency:
> > >>>>>> $ ./schbench -m 1 -t 10 -r 30 -R 200
> > >>>>>
> > >>>>> How many CPUs do you have ?
> > >>>>>
> > >>>>
> > >>>> OK, some details may not be mentioned.
> > >>>> My virtual machine has 8 CPUs running with a schbench process and 5000
> > >>>> idle tasks. The idle task is a while dead loop process below:
> > >>>
> > >>> How can you care about latency when you start 10 workers on 8 vCPUs
> > >>> with 5000 non idle threads ?
> > >>>
> > >>
> > >> No no no... spawn 5000 idle(SCHED_IDLE) processes not 5000 non-idle
> > >> threads, and with 10 non-idle schbench workers on 8 vCPUs.
> > >
> > > yes spawn 5000 idle tasks but my point remains the same
> > >
> >
> > I am so sorry that I have not received your reply for a long time, and I
> > am still waiting for it anxiously. In fact, migrating non-idle tasks 1st
> > works well in most scenarios, so it maybe possible to add a
> > sched_feat(LB_PRIO) to enable or disable that. Finally, I really hope
> > you can give me some better advice.
>
> I have seen that you posted a v4 5 days ago which is on my list to be reviewed.
>
> My concern here remains that selecting non idle task 1st is not always
> the best choices as for example when you have 1 non idle task per cpu
> and thousands of idle tasks moving around. Then regarding your use
> case, the weight of the 5000 idle threads is around twice more than
> the weight of your non idle bench: sum weight of idle threads is 15k
> whereas the weight of your bench is around 6k IIUC how RPS run. This
> also means that the idle threads will take a significant times of the
> system: 5000 / 7000 ticks. I don't understand how you can care about
> latency in such extreme case and I'm interested to get the real use
> case where you can have such situation.
>
> All that to say that idle task remains cfs task with a small but not
> null weight and we should not make them special other than by not
> preempting at wakeup.

Also, as mentioned for a previous version, a task with nice prio 19
has a weight of 15 so if you replace the 5k idle threads with 1k cfs
w/ nice prio 19 threads, you will face a similar problem. So you can't
really care only on the idle property of a task

>
> >
> > Best regards.
> >
> > Song Zhang
