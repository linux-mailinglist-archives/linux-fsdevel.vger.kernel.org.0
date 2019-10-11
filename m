Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A4DD365E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 02:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbfJKAkf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 20:40:35 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44728 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfJKAkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:40:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id q12so5721068lfc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2019 17:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCEP7qB3GzqBwKUjXrPpebibZKO1XQqLNLbhlrB2o3E=;
        b=Ode2StGqxHsnxHEGGTE3HLNMobXIF5IZ/OqxGpl8IF35NIz+jdNAY4QmhCTeZt7bzf
         RIouuQ5ZFY9iPPPH6W+K/p/hXGh4cgkT0H7toCQy7pVdb68g3Z4YUM9zznH9VgEl21VC
         XzFbi3oO9JsfFbBfkQV5GyaSud7A0V8C75pIKhGNO43vlfbqDiWVkDN78XfMVcsJxpkT
         uWX+QkjYEo6I8kcxtCgFJfmzpIeQoHkwHpG2iQnCFeHE6uu2dpDnWEIYBfJubRp3kgZ4
         MDFwyruRud7cN3h62qeSkmLZgf58oqDvxgGRlvkFbA3m2Wge2p8u4totjJ9iUBQVeSwQ
         iH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCEP7qB3GzqBwKUjXrPpebibZKO1XQqLNLbhlrB2o3E=;
        b=P9BHyd0bIEOeo1u9KEClgZlHMeVrL8AtqVizOSYlolCAiWiNfk9VZRRCrZnFRTxRFH
         NgmTc7qZqoCnEocA8DRJ9vVP3Iv3+etPB5LezhZemfcK7iqwSX5AgGM2uIdSUVsSaBk5
         hiPf0/vG/NNJQ8bmBhrWyMNSD9LnaEwyH3Zg7pC0S/NYdFY40w1LhnfY4Y+spoGmy2mV
         6YTlDMpnDWpuL3DTIbcvyppF7yHIeRc0XQ3l6WGNT/Cqp8AggaeMSGVEVqmRRj5AZ5RB
         VWC4jXqAoL6vHm4ZqwR7uqzrJc0Y9Sk4fQBO6rQwQu/Ip5p/OMrgThvCITdvOS+w9vXf
         xidg==
X-Gm-Message-State: APjAAAVXpY8jX8ldagYi9lEUXRvS8jLcIWF/2vyYasF6nIiNgJIWpz+d
        nzJhxblaTQ2FR83OUzFxM/MnqSIAFNK8ZD0/diCn
X-Google-Smtp-Source: APXvYqz16bFvgvk/JkcjSMw56nSPRPd44/zVDjOFHMxgu5aRVm+fbiLkj2RCNM3iXc/7qoqooc4/nPHxYsWCtiTm0X8=
X-Received: by 2002:ac2:428b:: with SMTP id m11mr7385787lfh.64.1570754428347;
 Thu, 10 Oct 2019 17:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568834524.git.rgb@redhat.com> <ff8a73c7841ef788c60f13f90d036b321af0e431.1568834524.git.rgb@redhat.com>
In-Reply-To: <ff8a73c7841ef788c60f13f90d036b321af0e431.1568834524.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Oct 2019 20:40:17 -0400
Message-ID: <CAHC9VhRSpuNZTFvFmZ50M4bQS8raAJb_mX5qvnPWdPM71YqUwg@mail.gmail.com>
Subject: Re: [PATCH ghak90 V7 15/21] sched: pull task_is_descendant into kernel/sched/core.c
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 9:26 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Since the task_is_descendant() function is used in YAMA and in audit,
> pull the function into kernel/core/sched.c
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/sched.h    |  3 +++
>  kernel/audit.c           | 33 ---------------------------------
>  kernel/sched/core.c      | 33 +++++++++++++++++++++++++++++++++
>  security/yama/yama_lsm.c | 33 ---------------------------------
>  4 files changed, 36 insertions(+), 66 deletions(-)

I'm not really reviewing this as I'm still a little confused from
patch 14/21, but if 14/21 works out as correct this patch should be
squashed into that one.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index a936d162513a..b251f018f4db 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1988,4 +1988,7 @@ static inline void rseq_syscall(struct pt_regs *regs)
>
>  const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
>
> +extern int task_is_descendant(struct task_struct *parent,
> +                             struct task_struct *child);
> +
>  #endif
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 69fe1e9af7cb..4fe7678304dd 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2560,39 +2560,6 @@ static struct task_struct *audit_cont_owner(struct task_struct *tsk)
>  }
>
>  /*
> - * task_is_descendant - walk up a process family tree looking for a match
> - * @parent: the process to compare against while walking up from child
> - * @child: the process to start from while looking upwards for parent
> - *
> - * Returns 1 if child is a descendant of parent, 0 if not.
> - */
> -static int task_is_descendant(struct task_struct *parent,
> -                             struct task_struct *child)
> -{
> -       int rc = 0;
> -       struct task_struct *walker = child;
> -
> -       if (!parent || !child)
> -               return 0;
> -
> -       rcu_read_lock();
> -       if (!thread_group_leader(parent))
> -               parent = rcu_dereference(parent->group_leader);
> -       while (walker->pid > 0) {
> -               if (!thread_group_leader(walker))
> -                       walker = rcu_dereference(walker->group_leader);
> -               if (walker == parent) {
> -                       rc = 1;
> -                       break;
> -               }
> -               walker = rcu_dereference(walker->real_parent);
> -       }
> -       rcu_read_unlock();
> -
> -       return rc;
> -}
> -
> -/*
>   * audit_set_contid - set current task's audit contid
>   * @task: target task
>   * @contid: contid value
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2b037f195473..7ba9e07381fa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7509,6 +7509,39 @@ void dump_cpu_task(int cpu)
>  }
>
>  /*
> + * task_is_descendant - walk up a process family tree looking for a match
> + * @parent: the process to compare against while walking up from child
> + * @child: the process to start from while looking upwards for parent
> + *
> + * Returns 1 if child is a descendant of parent, 0 if not.
> + */
> +int task_is_descendant(struct task_struct *parent,
> +                             struct task_struct *child)
> +{
> +       int rc = 0;
> +       struct task_struct *walker = child;
> +
> +       if (!parent || !child)
> +               return 0;
> +
> +       rcu_read_lock();
> +       if (!thread_group_leader(parent))
> +               parent = rcu_dereference(parent->group_leader);
> +       while (walker->pid > 0) {
> +               if (!thread_group_leader(walker))
> +                       walker = rcu_dereference(walker->group_leader);
> +               if (walker == parent) {
> +                       rc = 1;
> +                       break;
> +               }
> +               walker = rcu_dereference(walker->real_parent);
> +       }
> +       rcu_read_unlock();
> +
> +       return rc;
> +}
> +
> +/*
>   * Nice levels are multiplicative, with a gentle 10% change for every
>   * nice level changed. I.e. when a CPU-bound task goes from nice 0 to
>   * nice 1, it will get ~10% less CPU time than another CPU-bound task
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 94dc346370b1..25eae205eae8 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -263,39 +263,6 @@ static int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>  }
>
>  /**
> - * task_is_descendant - walk up a process family tree looking for a match
> - * @parent: the process to compare against while walking up from child
> - * @child: the process to start from while looking upwards for parent
> - *
> - * Returns 1 if child is a descendant of parent, 0 if not.
> - */
> -static int task_is_descendant(struct task_struct *parent,
> -                             struct task_struct *child)
> -{
> -       int rc = 0;
> -       struct task_struct *walker = child;
> -
> -       if (!parent || !child)
> -               return 0;
> -
> -       rcu_read_lock();
> -       if (!thread_group_leader(parent))
> -               parent = rcu_dereference(parent->group_leader);
> -       while (walker->pid > 0) {
> -               if (!thread_group_leader(walker))
> -                       walker = rcu_dereference(walker->group_leader);
> -               if (walker == parent) {
> -                       rc = 1;
> -                       break;
> -               }
> -               walker = rcu_dereference(walker->real_parent);
> -       }
> -       rcu_read_unlock();
> -
> -       return rc;
> -}
> -
> -/**
>   * ptracer_exception_found - tracer registered as exception for this tracee
>   * @tracer: the task_struct of the process attempting ptrace
>   * @tracee: the task_struct of the process to be ptraced

--
paul moore
www.paul-moore.com
