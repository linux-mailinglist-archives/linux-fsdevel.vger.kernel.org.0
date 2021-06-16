Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34C43A9EE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhFPPYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 11:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbhFPPYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:24:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F989C061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 08:22:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b37so4332886ljr.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ukyOAmpzQWdmpmUsMzfBm79YkK27laiGKotM430XzI=;
        b=EkMIOR/PiXLp54WcwHksaJA9STCAGH6XFItpd/u6uetS/tFJbAkSo5TUW9dDdAPUwm
         qdw4wP6RH//rcPEqpzsG5At1Yc6a3AltYSGYhmB0Z9Vl2omGzB1LAIrBhr4nf6c1xJnZ
         UEusPQ7BHmCzGvMnCnEINXLmBfjz+GQ2ARt0A1lCXjEdeHbhsOsEr1mhRxWioafCDueu
         FL383FSjLuSaeIkB6XLtV1ZzbVV04pzn7s7RzzYm4+C513U0UdqtT6GjHULiLkjL8pYd
         9nhz0KFPqD6MMMnIyrcCDAVMudnWicQT16jHrcXc0NKX00dJ+AR03w+/i8Q1L/pF8bj6
         x8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ukyOAmpzQWdmpmUsMzfBm79YkK27laiGKotM430XzI=;
        b=UzhOLf6lNy6dNvLv1QOIkXD0iiifUQ7HoqEpIWAHjdcRXKMtqmWOntxsjlVPN3Pexx
         F7PUJ8pEhUQcu/5Xw3FTxu/TaPxopc0BlrzjZNhZnH+C143D3Uc4cggSoi9/xcj3zGgR
         q8hU9m5+W7KQW1hF2umi5w94dXi04yqnUlKLZUzPwsxptxZykvYk8/9/hwn910G0TP09
         uCCM64qOcZZ/+2umgYr/RpuIXSKNeisDzfxGZZQyRYuKwyNKKHuQW1eabmX9bo99LxQ/
         YnePjvBp5SV6drt3bLnNShKaaqnIP+lTAVEOQLJuTrZheQDIV4cMrljWl0ik0SxCMQkR
         +T3w==
X-Gm-Message-State: AOAM532Li7FvOUp+ZrKQEQdYsv73rJZyLDANJVnWfbjA00WgfFpO07Br
        kOZY8rbXq99/W4clmST0RjmBz/Wq5hqqkJedfRf1qw==
X-Google-Smtp-Source: ABdhPJw84LuQUqmTdWOdf0vTCuN4kM/khUBiuNSfgQsV9GgaawL246DIVJT4/L60uE2YPOylDsN6BhSj2t9R0rZ/V7I=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr307435lji.209.1623856949636;
 Wed, 16 Jun 2021 08:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <1623855954-6970-1-git-send-email-yt.chang@mediatek.com>
In-Reply-To: <1623855954-6970-1-git-send-email-yt.chang@mediatek.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Jun 2021 17:22:18 +0200
Message-ID: <CAKfTPtBZi60fmCGkOYoRmJ4YVE4523VQfeTgnbUGzaTEk9aq=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: Add tunable capacity margin for fis_capacity
To:     YT Chang <yt.chang@mediatek.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Paul Turner <pjt@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Jun 2021 at 17:06, YT Chang <yt.chang@mediatek.com> wrote:
>
> Currently, the margin of cpu frequency raising and cpu overutilized are
> hard-coded as 25% (1280/1024). Make the margin tunable

cpu_overutilized is 20% not 25%. Even if they light looks similar
these 2 margins are differents

> to control the aggressive for placement and frequency control. Such as
> for power tuning framework could adjust smaller margin to slow down
> frequency raising speed and let task stay in smaller cpu.
>
> For light loading scenarios, like beach buggy blitz and messaging apps,
> the app threads are moved big core with 25% margin and causing
> unnecessary power.
> With 0% capacity margin (1024/1024), the app threads could be kept in
> little core and deliver better power results without any fps drop.
>
> capacity margin        0%          10%          20%          30%
>                      current        current       current      current
>                   Fps  (mA)    Fps    (mA)   Fps   (mA)    Fps  (mA)
> Beach buggy blitz  60 198.164  60   203.211  60   209.984  60  213.374
> Yahoo browser      60 232.301 59.97 237.52  59.95 248.213  60  262.809

Would be good to know the impact of each part:
 Changing the +25% in cpufreq governor
 Changing the 20% margin to detect overloaded CPU

Also, IIUC your description, the current values are ok with some UCs
but not with others like the 2 aboves. Have you evaluated whether it
was not your power model that was not accurate ?

>
> Change-Id: Iba48c556ed1b73c9a2699e9e809bc7d9333dc004
> Signed-off-by: YT Chang <yt.chang@mediatek.com>
> ---
>  include/linux/sched/cpufreq.h | 19 +++++++++++++++++++
>  include/linux/sched/sysctl.h  |  1 +
>  include/linux/sysctl.h        |  1 +
>  kernel/sched/fair.c           |  4 +++-
>  kernel/sysctl.c               | 15 +++++++++++++++
>  5 files changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index 6205578..8a6c23a1 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -23,6 +23,23 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>  void cpufreq_remove_update_util_hook(int cpu);
>  bool cpufreq_this_cpu_can_update(struct cpufreq_policy *policy);
>
> +#ifdef CONFIG_SMP
> +extern unsigned int sysctl_sched_capacity_margin;
> +
> +static inline unsigned long map_util_freq(unsigned long util,
> +                                         unsigned long freq, unsigned long cap)
> +{
> +       freq = freq * util / cap;
> +       freq = freq * sysctl_sched_capacity_margin / SCHED_CAPACITY_SCALE;
> +
> +       return freq;
> +}
> +
> +static inline unsigned long map_util_perf(unsigned long util)
> +{
> +       return util * sysctl_sched_capacity_margin / SCHED_CAPACITY_SCALE;
> +}
> +#else
>  static inline unsigned long map_util_freq(unsigned long util,
>                                         unsigned long freq, unsigned long cap)
>  {
> @@ -33,6 +50,8 @@ static inline unsigned long map_util_perf(unsigned long util)
>  {
>         return util + (util >> 2);
>  }
> +#endif
> +
>  #endif /* CONFIG_CPU_FREQ */
>
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index db2c0f3..5dee024 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -10,6 +10,7 @@
>
>  #ifdef CONFIG_SMP
>  extern unsigned int sysctl_hung_task_all_cpu_backtrace;
> +extern unsigned int sysctl_sched_capacity_margin;
>  #else
>  #define sysctl_hung_task_all_cpu_backtrace 0
>  #endif /* CONFIG_SMP */
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index d99ca99..af6d70f 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -41,6 +41,7 @@
>  #define SYSCTL_ZERO    ((void *)&sysctl_vals[0])
>  #define SYSCTL_ONE     ((void *)&sysctl_vals[1])
>  #define SYSCTL_INT_MAX ((void *)&sysctl_vals[2])
> +#define SCHED_CAPACITY_MARGIN_MIN   1024
>
>  extern const int sysctl_vals[];
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 20aa234..609b431 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -111,7 +111,9 @@ int __weak arch_asym_cpu_priority(int cpu)
>   *
>   * (default: ~20%)
>   */
> -#define fits_capacity(cap, max)        ((cap) * 1280 < (max) * 1024)
> +unsigned int sysctl_sched_capacity_margin = 1280;
> +EXPORT_SYMBOL_GPL(sysctl_sched_capacity_margin);
> +#define fits_capacity(cap, max)        ((cap) * sysctl_sched_capacity_margin < (max) * 1024)
>
>  /*
>   * The margin used when comparing CPU capacities.
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 14edf84..d6d2b84 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -127,6 +127,11 @@
>  static int six_hundred_forty_kb = 640 * 1024;
>  #endif
>
> +/* this is needed for the proc of sysctl_sched_capacity_margin */
> +#ifdef CONFIG_SMP
> +static int min_sched_capacity_margin = 1024;
> +#endif /* CONFIG_SMP */
> +
>  /* this is needed for the proc_doulongvec_minmax of vm_dirty_bytes */
>  static unsigned long dirty_bytes_min = 2 * PAGE_SIZE;
>
> @@ -1716,6 +1721,16 @@ int proc_do_static_key(struct ctl_table *table, int write,
>                 .mode           = 0644,
>                 .proc_handler   = proc_dointvec,
>         },
> +#ifdef CONFIG_SMP
> +       {
> +               .procname       = "sched_capcity_margin",
> +               .data           = &sysctl_sched_capacity_margin,
> +               .maxlen         = sizeof(unsigned int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec_minmax,
> +               .extra1         = &min_sched_capacity_margin,
> +       },
> +#endif
>  #ifdef CONFIG_SCHEDSTATS
>         {
>                 .procname       = "sched_schedstats",
> --
> 1.9.1
>
