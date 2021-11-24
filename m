Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476A645B3AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 05:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhKXE4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 23:56:52 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:38922 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhKXE4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 23:56:52 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:33450)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpkHp-005N71-8W; Tue, 23 Nov 2021 21:53:37 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:38058 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpkHn-006EeM-QR; Tue, 23 Nov 2021 21:53:36 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, peterz@infradead.org,
        gregkh@linuxfoundation.org, pjt@google.com,
        liu.hailong6@zte.com.cn, andriy.shevchenko@linux.intel.com,
        sre@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        pmladek@suse.com, senozhatsky@chromium.org, wangqing@vivo.com,
        bcrl@kvack.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211123202347.818157-1-mcgrof@kernel.org>
        <20211123202347.818157-3-mcgrof@kernel.org>
Date:   Tue, 23 Nov 2021 22:51:47 -0600
In-Reply-To: <20211123202347.818157-3-mcgrof@kernel.org> (Luis Chamberlain's
        message of "Tue, 23 Nov 2021 12:23:40 -0800")
Message-ID: <87k0gygnq4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mpkHn-006EeM-QR;;;mid=<87k0gygnq4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ekv6XuYbHi1dh2QcgbGqyi2zi7VU2Y6Q=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMBody_17,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XMBody_17 BODY: Spammy words in all caps
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 804 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.43
        (0.2%), extract_message_metadata: 18 (2.2%), get_uri_detail_list: 4.4
        (0.5%), tests_pri_-1000: 17 (2.1%), tests_pri_-950: 1.23 (0.2%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 80 (9.9%), check_bayes: 78
        (9.7%), b_tokenize: 17 (2.1%), b_tok_get_all: 13 (1.6%), b_comp_prob:
        4.4 (0.5%), b_tok_touch_all: 39 (4.9%), b_finish: 0.90 (0.1%),
        tests_pri_0: 653 (81.1%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 3.2 (0.4%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        3.1 (0.4%), tests_pri_500: 15 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/9] sysctl: Move some boundary constants from sysctl.c to sysctl_vals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> From: Xiaoming Ni <nixiaoming@huawei.com>
>
> sysctl has helpers which let us specify boundary values for a min or
> max int value. Since these are used for a boundary check only they don't
> change, so move these variables to sysctl_vals to avoid adding duplicate
> variables. This will help with our cleanup of kernel/sysctl.c.

Ouch.

I kind of, sort of, have to protest.

Where the macros that use sysctl_vals don't have a type they have caused
mysterious code breakage because people did not realize they can not be
used with sysctls that take a long instead of an int.

This came up with when the internal storage for ucounts see
kernel/ucount.c changed from an int to a long.  We were quite a while
tracking what was going on until we realized that the code could not use
SYSCTL_ZERO and SYSCTL_INT_MAX and that we had to defined our own that
were long.

So before we extend something like this can we please change the
macro naming convention so that it includes the size of the type
we want.


I am also not a fan of sysctl_vals living in proc_sysctl.  They
have nothing to do with the code in that file.  They would do much
better in kernel/sysctl.c close to the helpers that use them.

Eric


> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> [mcgrof: major rebase]
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/proc/proc_sysctl.c  |  2 +-
>  include/linux/sysctl.h | 12 +++++++++---
>  kernel/sysctl.c        | 44 ++++++++++++++++++------------------------
>  3 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b4950843d90a..6d462644bb00 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -26,7 +26,7 @@ static const struct file_operations proc_sys_dir_file_operations;
>  static const struct inode_operations proc_sys_dir_operations;
>  
>  /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { 0, 1, INT_MAX };
> +const int sysctl_vals[] = { -1, 0, 1, 2, 4, 100, 200, 1000, INT_MAX };
>  EXPORT_SYMBOL(sysctl_vals);
>  
>  /* Support for permanently empty directories */
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index d3ab7969b6b5..718492057c70 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -38,9 +38,15 @@ struct ctl_table_header;
>  struct ctl_dir;
>  
>  /* Keep the same order as in fs/proc/proc_sysctl.c */
> -#define SYSCTL_ZERO	((void *)&sysctl_vals[0])
> -#define SYSCTL_ONE	((void *)&sysctl_vals[1])
> -#define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
> +#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[0])
> +#define SYSCTL_ZERO			((void *)&sysctl_vals[1])
> +#define SYSCTL_ONE			((void *)&sysctl_vals[2])
> +#define SYSCTL_TWO			((void *)&sysctl_vals[3])
> +#define SYSCTL_FOUR			((void *)&sysctl_vals[4])
> +#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
> +#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
> +#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
> +#define SYSCTL_INT_MAX			((void *)&sysctl_vals[8])
>  
>  extern const int sysctl_vals[];
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 857c1ccad9e8..3097f0286504 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -113,15 +113,9 @@
>  static int sixty = 60;
>  #endif
>  
> -static int __maybe_unused neg_one = -1;
> -static int __maybe_unused two = 2;
> -static int __maybe_unused four = 4;
>  static unsigned long zero_ul;
>  static unsigned long one_ul = 1;
>  static unsigned long long_max = LONG_MAX;
> -static int one_hundred = 100;
> -static int two_hundred = 200;
> -static int one_thousand = 1000;
>  #ifdef CONFIG_PRINTK
>  static int ten_thousand = 10000;
>  #endif
> @@ -1962,7 +1956,7 @@ static struct ctl_table kern_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= &neg_one,
> +		.extra1		= SYSCTL_NEG_ONE,
>  		.extra2		= SYSCTL_ONE,
>  	},
>  #endif
> @@ -2304,7 +2298,7 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax_sysadmin,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two,
> +		.extra2		= SYSCTL_TWO,
>  	},
>  #endif
>  	{
> @@ -2564,7 +2558,7 @@ static struct ctl_table kern_table[] = {
>  		.maxlen		= sizeof(int),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= &neg_one,
> +		.extra1		= SYSCTL_NEG_ONE,
>  	},
>  #endif
>  #ifdef CONFIG_RT_MUTEXES
> @@ -2626,7 +2620,7 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= perf_cpu_time_max_percent_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &one_hundred,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
>  	},
>  	{
>  		.procname	= "perf_event_max_stack",
> @@ -2644,7 +2638,7 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= perf_event_max_stack_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &one_thousand,
> +		.extra2		= SYSCTL_ONE_THOUSAND,
>  	},
>  #endif
>  	{
> @@ -2675,7 +2669,7 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= bpf_unpriv_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two,
> +		.extra2		= SYSCTL_TWO,
>  	},
>  	{
>  		.procname	= "bpf_stats_enabled",
> @@ -2729,7 +2723,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= overcommit_policy_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two,
> +		.extra2		= SYSCTL_TWO,
>  	},
>  	{
>  		.procname	= "panic_on_oom",
> @@ -2738,7 +2732,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two,
> +		.extra2		= SYSCTL_TWO,
>  	},
>  	{
>  		.procname	= "oom_kill_allocating_task",
> @@ -2783,7 +2777,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= dirty_background_ratio_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &one_hundred,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
>  	},
>  	{
>  		.procname	= "dirty_background_bytes",
> @@ -2800,7 +2794,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= dirty_ratio_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &one_hundred,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
>  	},
>  	{
>  		.procname	= "dirty_bytes",
> @@ -2840,7 +2834,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two_hundred,
> +		.extra2		= SYSCTL_TWO_HUNDRED,
>  	},
>  #ifdef CONFIG_HUGETLB_PAGE
>  	{
> @@ -2897,7 +2891,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0200,
>  		.proc_handler	= drop_caches_sysctl_handler,
>  		.extra1		= SYSCTL_ONE,
> -		.extra2		= &four,
> +		.extra2		= SYSCTL_FOUR,
>  	},
>  #ifdef CONFIG_COMPACTION
>  	{
> @@ -2914,7 +2908,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= compaction_proactiveness_sysctl_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &one_hundred,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
>  	},
>  	{
>  		.procname	= "extfrag_threshold",
> @@ -2959,7 +2953,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= watermark_scale_factor_sysctl_handler,
>  		.extra1		= SYSCTL_ONE,
> -		.extra2		= &one_thousand,
> +		.extra2		= SYSCTL_ONE_THOUSAND,
>  	},
>  	{
>  		.procname	= "percpu_pagelist_high_fraction",
> @@ -3038,7 +3032,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &one_hundred,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
>  	},
>  	{
>  		.procname	= "min_slab_ratio",
> @@ -3047,7 +3041,7 @@ static struct ctl_table vm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &one_hundred,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
>  	},
>  #endif
>  #ifdef CONFIG_SMP
> @@ -3337,7 +3331,7 @@ static struct ctl_table fs_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two,
> +		.extra2		= SYSCTL_TWO,
>  	},
>  	{
>  		.procname	= "protected_regular",
> @@ -3346,7 +3340,7 @@ static struct ctl_table fs_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two,
> +		.extra2		= SYSCTL_TWO,
>  	},
>  	{
>  		.procname	= "suid_dumpable",
> @@ -3355,7 +3349,7 @@ static struct ctl_table fs_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax_coredump,
>  		.extra1		= SYSCTL_ZERO,
> -		.extra2		= &two,
> +		.extra2		= SYSCTL_TWO,
>  	},
>  #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
>  	{
