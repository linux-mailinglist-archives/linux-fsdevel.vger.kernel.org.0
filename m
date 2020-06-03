Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21081ECB7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFCI33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 04:29:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35495 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCI33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:29:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id q25so1066810wmj.0;
        Wed, 03 Jun 2020 01:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=I+vhTKpYAPlshcNSeSPucXhRElY2YCUAChm3OCWyRiQ=;
        b=rpjBWmAlBvCFYGKH5AsQilvWZNyFKEdLc7wQbcBPl331vqpibvq9GxFiKpkE3CQIIB
         g7DyqJqGlcxXCNtEKNhYY66RavFAiWTyh7h2vfvQCr6IDqrgwgshENI1cPxIJvsTcSGT
         04HUAoR1aRSKC7Mi3LKaFEq2I3GvU6Sj4e2zNRxzEjX6yYxNyda2TEjwu9cdT3EOxeMM
         +yX2M6gOhkllexmlH0ThfocKAGOj7aRuJT+1+8aRXa1XZp8H6+tnnPPiEEpgaI1YmtWy
         XJnV5c1dYGEglgyPqCQIBUuv6KTdhUikvo22FxgH2rJHYf7yAkrYMaFROwk0PCFZfeNR
         5wNQ==
X-Gm-Message-State: AOAM531CAyY8Uz83NutxUygh7NxTU+OM/zvqUyai6n8Dp+/LbkGCPXVz
        U8IwXGUIp8c3Ei9aF/KOCbpXO9pN
X-Google-Smtp-Source: ABdhPJzvMh3euRizCMKz1isadTXsib5ORujZ3ARoD3BHZQ9tmzIz15FMc5DBwKbrMSSuA7MNqF3Q2A==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr8089383wmd.53.1591172965400;
        Wed, 03 Jun 2020 01:29:25 -0700 (PDT)
Received: from darkstar ([51.154.17.58])
        by smtp.gmail.com with ESMTPSA id l204sm1919788wmf.19.2020.06.03.01.29.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 01:29:23 -0700 (PDT)
References: <20200511154053.7822-1-qais.yousef@arm.com> <20200528132327.GB706460@hirez.programming.kicks-ass.net> <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com> <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200529100806.GA3070@suse.de> <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
User-agent: mu4e 1.4.3; emacs 26.3
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default boost value
In-reply-to: <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com>
Message-ID: <87v9k84knx.derkling@matbug.net>
Date:   Wed, 03 Jun 2020 10:29:22 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Dietmar,
thanks for sharing these numbers.

On Tue, Jun 02, 2020 at 18:46:00 +0200, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote...

[...]

> I ran these tests on 'Ubuntu 18.04 Desktop' on Intel E5-2690 v2
> (2 sockets * 10 cores * 2 threads) with powersave governor as:
>
> $ numactl -N 0 ./run-mmtests.sh XXX

Great setup, it's worth to rule out all possible noise source (freq
scaling, thermal throttling, NUMA scheduler, etc.).
Wondering if disabling HT can also help here in reducing results "noise"?

> w/ config-network-netperf-unbound.
>
> Running w/o 'numactl -N 0' gives slightly worse results.
>
> without-clamp      : CONFIG_UCLAMP_TASK is not set
> with-clamp         : CONFIG_UCLAMP_TASK=y,
>                      CONFIG_UCLAMP_TASK_GROUP is not set
> with-clamp-tskgrp  : CONFIG_UCLAMP_TASK=y,
>                      CONFIG_UCLAMP_TASK_GROUP=y
>
>
> netperf-udp
>                                 ./5.7.0-rc7            ./5.7.0-rc7            ./5.7.0-rc7
>                               without-clamp             with-clamp      with-clamp-tskgrp

Can you please specify how to read the following scores? I give it a run
to my local netperf and it reports Throughput, thous I would expect the
higher the better... but... this seems something different.

> Hmean     send-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> Hmean     send-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> Hmean     send-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> Hmean     send-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> Hmean     send-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.96 *   1.24%*
> Hmean     send-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> Hmean     send-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> Hmean     send-8192     14961.77 (   0.00%)    14418.92 *  -3.63%*    14908.36 *  -0.36%*
> Hmean     send-16384    25799.50 (   0.00%)    25025.64 *  -3.00%*    25831.20 *   0.12%*

If I read it as the lower the score the better, all the above results
tell us that with-clamp is even better, while with-clamp-tskgrp
is not that much worst.

The other way around (the higher the score the better) would look odd
since we definitively add in more code and complexity when uclamp has
the TG support enabled we would not expect better scores.

> Hmean     recv-64         153.62 (   0.00%)      151.80 *  -1.19%*      155.60 *   1.28%*
> Hmean     recv-128        306.77 (   0.00%)      306.27 *  -0.16%*      309.39 *   0.85%*
> Hmean     recv-256        608.54 (   0.00%)      604.28 *  -0.70%*      613.42 *   0.80%*
> Hmean     recv-1024      2395.80 (   0.00%)     2365.67 *  -1.26%*     2409.50 *   0.57%*
> Hmean     recv-2048      4608.70 (   0.00%)     4544.02 *  -1.40%*     4665.95 *   1.24%*
> Hmean     recv-3312      7223.97 (   0.00%)     7158.88 *  -0.90%*     7331.23 *   1.48%*
> Hmean     recv-4096      8729.53 (   0.00%)     8598.78 *  -1.50%*     8860.47 *   1.50%*
> Hmean     recv-8192     14961.61 (   0.00%)    14418.88 *  -3.63%*    14908.30 *  -0.36%*
> Hmean     recv-16384    25799.39 (   0.00%)    25025.49 *  -3.00%*    25831.00 *   0.12%*
>
> netperf-tcp
>  
> Hmean     64              818.65 (   0.00%)      812.98 *  -0.69%*      826.17 *   0.92%*
> Hmean     128            1569.55 (   0.00%)     1555.79 *  -0.88%*     1586.94 *   1.11%*
> Hmean     256            2952.86 (   0.00%)     2915.07 *  -1.28%*     2968.15 *   0.52%*
> Hmean     1024          10425.91 (   0.00%)    10296.68 *  -1.24%*    10418.38 *  -0.07%*
> Hmean     2048          17454.51 (   0.00%)    17369.57 *  -0.49%*    17419.24 *  -0.20%*
> Hmean     3312          22509.95 (   0.00%)    22229.69 *  -1.25%*    22373.32 *  -0.61%*
> Hmean     4096          25033.23 (   0.00%)    24859.59 *  -0.69%*    24912.50 *  -0.48%*
> Hmean     8192          32080.51 (   0.00%)    31744.51 *  -1.05%*    31800.45 *  -0.87%*
> Hmean     16384         36531.86 (   0.00%)    37064.68 *   1.46%*    37397.71 *   2.37%*
>
> The diffs are smaller than on openSUSE Leap 15.1 and some of the
> uclamp taskgroup results are better?
>
> With this test setup we now can play with the uclamp code in
> enqueue_task() and dequeue_task().
>
> ---
>
> W/ config-network-netperf-unbound (only netperf-udp and buffer size 64):
>
> $ perf diff 5.7.0-rc7_without-clamp/perf.data 5.7.0-rc7_with-clamp/perf.data | grep activate_task
>
> # Event 'cycles:ppp'
> #
> # Baseline  Delta Abs  Shared Object            Symbol
>
>      0.02%     +0.54%  [kernel.vmlinux]         [k] activate_task
>      0.02%     +0.38%  [kernel.vmlinux]         [k] deactivate_task
>
> $ perf diff 5.7.0-rc7_without-clamp/perf.data 5.7.0-rc7_with-clamp-tskgrp/perf.data | grep activate_task
>
>      0.02%     +0.35%  [kernel.vmlinux]         [k] activate_task
>      0.02%     +0.34%  [kernel.vmlinux]         [k] deactivate_task

These data makes more sense to me, AFAIR we measured <1% impact in the
wakeup path using cycletest.

I would also suggest to always report the overheads for 
  __update_load_avg_cfs_rq()
as a reference point. We use that code quite a lot in the wakeup path
and it's a good proxy for relative comparisons.


> I still see 20 out of 90 tests with the warning message that the
> desired confidence was not achieved though.

Where the 90 comes from? From the above table we run 9 sizes for
{udp-send, udp-recv, tcp} and 3 kernels. Should not give us 81 results?

Maybe the Warning are generated only when a test has to be repeated?
Thus, all the numbers above are granted to be within the specific CI?

> "
> !!! WARNING
> !!! Desired confidence was not achieved within the specified iterations.
> !!! This implies that there was variability in the test environment that
> !!! must be investigated before going further.
> !!! Confidence intervals: Throughput      : 6.727% <-- more than 5% !!!
> !!!                       Local CPU util  : 0.000%
> !!!                       Remote CPU util : 0.000%
> "
>
> mmtests seems to run netperf with the following '-I' and 'i' parameter
> hardcoded: 'netperf -t UDP_STREAM -i 3,3 -I 95,5' 

This means that we compute a score's (average +-2.5%) with a 95% confidence.

Does not that means that every +-2.5% difference in the results
above should be considered in the noise?

I would say that it could be useful to run with more iterations
and, given the small numbers we are looking at (apparently we are
scared by a 1% overhead), we should better use a more aggressive CI.

What about something like:

   netperf -t UDP_STREAM -i 3,30 -I 99,1

?

