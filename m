Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBB1D1324
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 14:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEMMvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 08:51:01 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34125 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgEMMvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 08:51:01 -0400
Received: by mail-pj1-f66.google.com with SMTP id l73so1683023pjb.1;
        Wed, 13 May 2020 05:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6BvwL5VtTpPQh7+ZmwOEfJsJh+MpmaSNjEDc7fe17Cg=;
        b=Fkek79DlDffswWdHSOgeeE7JK4Q/5BG/IxxYMALliBPZ5WbyphGOLhXmhVkebRAvTg
         v8IlOEBvzLj1d5koNKZgt6vdKy3SgAJzUzUgmWJ1uKs/ratWFUf0nUbH1krQhlN+luFG
         Y3LCmkKeCjnbeYihblv/ijWZf2m/SN7qvNjF8oZFLSB0Y45lDHwH8MtTmqNqGZpi6X0b
         6RUCFy8g6HpymFDmsFoCTFrcINoMi4zvxh82M5k4e4i2y0Ai/NVxsNyXopU1W4Y5tR0Q
         wtv/XEqJaM9+XZzQQSY7s6rIov/8jXJnxGVsBVr6IzPPCRPjuMsC1Z4NDhenIxJNwHLJ
         ZVNw==
X-Gm-Message-State: AOAM5335OwijoB4CYaSFOS7/hg/AfmvlEqwPa0zucC5I4YhCTub+opW1
        xMqzGVtr4Zo8dWP+UiSEsVs=
X-Google-Smtp-Source: ABdhPJxU6OZTFJl9CuEar2G//kflpf1HvLC9sMqCBGP9NVlaiP14CRGt8VPr7k+V9EoPThlFqVPOjg==
X-Received: by 2002:a17:90a:2051:: with SMTP id n75mr9566197pjc.112.1589374259957;
        Wed, 13 May 2020 05:50:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id z5sm14825173pfz.109.2020.05.13.05.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 05:50:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C87234063E; Wed, 13 May 2020 12:50:57 +0000 (UTC)
Date:   Wed, 13 May 2020 12:50:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
Message-ID: <20200513125057.GM11244@42.do-not-panic.com>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
 <20200512172413.GC11244@42.do-not-panic.com>
 <87k11hrqzc.fsf@x220.int.ebiederm.org>
 <20200512220341.GE11244@42.do-not-panic.com>
 <3ccd08a5-cac6-3ca1-ed33-3cb62c982443@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ccd08a5-cac6-3ca1-ed33-3cb62c982443@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 12:04:02PM +0800, Xiaoming Ni wrote:
> On 2020/5/13 6:03, Luis Chamberlain wrote:
> > On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
> > > Luis Chamberlain <mcgrof@kernel.org> writes:
> > > 
> > > > On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
> > > > > Luis Chamberlain <mcgrof@kernel.org> writes:
> > > > > 
> > > > > > +static struct ctl_table fs_base_table[] = {
> > > > > > +	{
> > > > > > +		.procname	= "fs",
> > > > > > +		.mode		= 0555,
> > > > > > +		.child		= fs_table,
> > > > > > +	},
> > > > > > +	{ }
> > > > > > +};
> > > > >    ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
> > > > > > > +static int __init fs_procsys_init(void)
> > > > > > +{
> > > > > > +	struct ctl_table_header *hdr;
> > > > > > +
> > > > > > +	hdr = register_sysctl_table(fs_base_table);
> > > > >                ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
> > > > > 	AKA
> > > > >          hdr = register_sysctl("fs", fs_table);
> > > > 
> > > > Ah, much cleaner thanks!
> > > 
> > > It is my hope you we can get rid of register_sysctl_table one of these
> > > days.  It was the original interface but today it is just a
> > > compatibility wrapper.
> > > 
> > > I unfortunately ran out of steam last time before I finished converting
> > > everything over.
> > 
> > Let's give it one more go. I'll start with the fs stuff.
> > 
> >    Luis
> > 
> > .
> > 
> 
> If we register each feature in its own feature code file using register() to
> register the sysctl interface. To avoid merge conflicts when different
> features modify sysctl.c at the same time.
> that is, try to Avoid mixing code with multiple features in the same code
> file.
> 
> For example, the multiple file interfaces defined in sysctl.c by the
> hung_task feature can  be moved to hung_task.c.
> 
> Perhaps later, without centralized sysctl.c ?
> Is this better?
> 
> Thanks
> Xiaoming Ni
> 
> ---
>  include/linux/sched/sysctl.h |  8 +----
>  kernel/hung_task.c           | 78
> +++++++++++++++++++++++++++++++++++++++++++-
>  kernel/sysctl.c              | 50 ----------------------------
>  3 files changed, 78 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index d4f6215..bb4e0d3 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -7,14 +7,8 @@
>  struct ctl_table;
> 
>  #ifdef CONFIG_DETECT_HUNG_TASK
> -extern int	     sysctl_hung_task_check_count;
> -extern unsigned int  sysctl_hung_task_panic;
> +/* used for block/ */
>  extern unsigned long sysctl_hung_task_timeout_secs;
> -extern unsigned long sysctl_hung_task_check_interval_secs;
> -extern int sysctl_hung_task_warnings;
> -extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int
> write,
> -					 void __user *buffer,
> -					 size_t *lenp, loff_t *ppos);
>  #else
>  /* Avoid need for ifdefs elsewhere in the code */
>  enum { sysctl_hung_task_timeout_secs = 0 };
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 14a625c..53589f2 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -20,10 +20,10 @@
>  #include <linux/utsname.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
> +#include <linux/kmemleak.h>
>  #include <linux/sched/sysctl.h>
> 
>  #include <trace/events/sched.h>
> -
>  /*
>   * The number of tasks checked:
>   */
> @@ -296,8 +296,84 @@ static int watchdog(void *dummy)
>  	return 0;
>  }
> 
> +/*
> + * This is needed for proc_doulongvec_minmax of
> sysctl_hung_task_timeout_secs
> + * and hung_task_check_interval_secs
> + */
> +static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);

This is not generic so it can stay in this file.

> +static int __maybe_unused neg_one = -1;

This is generic so we can share it, I suggest we just rename this
for now to sysctl_neg_one, export it to a symbol namespace,
EXPORT_SYMBOL_NS_GPL(sysctl_neg_one, SYSCTL) and then import it with
MODULE_IMPORT_NS(SYSCTL)


> +static struct ctl_table hung_task_sysctls[] = {

We want to wrap this around with CONFIG_SYSCTL, so a cleaner solution
is something like this:

diff --git a/kernel/Makefile b/kernel/Makefile
index a42ac3a58994..689718351754 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -88,7 +88,9 @@ obj-$(CONFIG_KCOV) += kcov.o
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_FAIL_FUNCTION) += fail_function.o
 obj-$(CONFIG_KGDB) += debug/
-obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
+obj-$(CONFIG_DETECT_HUNG_TASK) += hung_tasks.o
+hung_tasks-y := hung_task.o
+hung_tasks-$(CONFIG_SYSCTL) += hung_task_sysctl.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o

> +/* get /proc/sys/kernel root */
> +static struct ctl_table sysctls_root[] = {
> +	{
> +		.procname       = "kernel",
> +		.mode           = 0555,
> +		.child          = hung_task_sysctls,
> +	},
> +	{}
> +};
> +

And as per Eric, this is not needed, we can simplify this more, as noted
below.

> +static int __init hung_task_sysctl_init(void)
> +{
> +	struct ctl_table_header *srt = register_sysctl_table(sysctls_root);

You want instead something like::

        struct ctl_table_header *srt;

	srt = register_sysctl("kernel", hung_task_sysctls);
> +
> +	if (!srt)
> +		return -ENOMEM;
> +	kmemleak_not_leak(srt);
> +	return 0;
> +}
> +

>  static int __init hung_task_init(void)
>  {
> +	int ret = hung_task_sysctl_init();
> +
> +	if (ret != 0)
> +		return ret;
> +

And just #ifdef this around CONFIG_SYSCTL.

  Luis
