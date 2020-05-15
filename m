Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA21D559B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEOQI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 12:08:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOQI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 12:08:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id n18so1153658pfa.2;
        Fri, 15 May 2020 09:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H+PdilDu8ruhovusRLuDWIoOytOsNC45mjFKSkSZvSQ=;
        b=IIMg95bHO6BTwe21jbKMa5P645n/gFYl2JYNxkXhQQGcLgVb1d3kZ8mO4rpi+ZLHxu
         qBMMiepi3fYB7sCyJK/QBMNy/Cl3F0TlwN5i4FWuiYP3FWcg9WCk1AZiqxrR9dwDl4qn
         t0daqYBOp9ffz0uc2Q/IguZHpdQwKKV3p5AOVeopsYn8r29qc4AWLv40TOoEgRNuqesf
         cVr6W2vml3oyq6+ishO5cl7Z4QHpGhm1f+5DZha7ZE1rJyAX7EALZ7vH96gF8dBvhDzh
         J8vEyph71HH36yIuIW7IQg0GkSqFehy7TxPoc0EklVTNtLpsYEEUF05CgaruCxrTpSCB
         ytFg==
X-Gm-Message-State: AOAM533+dLQj95qX1QrzE26vStcVif3li1zqaaywludkoyrh9NzYG1Qo
        dsMM30jZXEnu3tctSffRQAw=
X-Google-Smtp-Source: ABdhPJxj8Mkl3TM5swZdVtFjzlu0vEf1tOu1ImKaduMInP4ZGe3eYbYQ71IsFIW3pS9jvTsUR2k5Qg==
X-Received: by 2002:a63:9558:: with SMTP id t24mr3911678pgn.48.1589558935263;
        Fri, 15 May 2020 09:08:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g14sm2266885pfh.49.2020.05.15.09.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:08:52 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C7BCC40246; Fri, 15 May 2020 16:08:51 +0000 (UTC)
Date:   Fri, 15 May 2020 16:08:51 +0000
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
Message-ID: <20200515160851.GU11244@42.do-not-panic.com>
References: <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
 <20200512172413.GC11244@42.do-not-panic.com>
 <87k11hrqzc.fsf@x220.int.ebiederm.org>
 <20200512220341.GE11244@42.do-not-panic.com>
 <3ccd08a5-cac6-3ca1-ed33-3cb62c982443@huawei.com>
 <20200513125057.GM11244@42.do-not-panic.com>
 <2f8363b3-781e-b065-82f4-f84e6e787fad@huawei.com>
 <aaae0a1e-8b80-7d31-d747-a2e350e3b247@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaae0a1e-8b80-7d31-d747-a2e350e3b247@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 12:17:52AM +0800, Xiaoming Ni wrote:
> On 2020/5/14 14:05, Xiaoming Ni wrote:
> > On 2020/5/13 20:50, Luis Chamberlain wrote:
> > > On Wed, May 13, 2020 at 12:04:02PM +0800, Xiaoming Ni wrote:
> > > > On 2020/5/13 6:03, Luis Chamberlain wrote:
> > > > > On Tue, May 12, 2020 at 12:40:55PM -0500, Eric W. Biederman wrote:
> > > > > > Luis Chamberlain <mcgrof@kernel.org> writes:
> > > > > > 
> > > > > > > On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
> > > > > > > > Luis Chamberlain <mcgrof@kernel.org> writes:
> > > > > > > > 
> > > > > > > > > +static struct ctl_table fs_base_table[] = {
> > > > > > > > > +    {
> > > > > > > > > +        .procname    = "fs",
> > > > > > > > > +        .mode        = 0555,
> > > > > > > > > +        .child        = fs_table,
> > > > > > > > > +    },
> > > > > > > > > +    { }
> > > > > > > > > +};
> > > > > > > >     ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
> > > > > > > > > > +static int __init fs_procsys_init(void)
> > > > > > > > > +{
> > > > > > > > > +    struct ctl_table_header *hdr;
> > > > > > > > > +
> > > > > > > > > +    hdr = register_sysctl_table(fs_base_table);
> > > > > > > >                 ^^^^^^^^^^^^^^^^^^^^^ Please use
> > > > > > > > register_sysctl instead.
> > > > > > > >     AKA
> > > > > > > >           hdr = register_sysctl("fs", fs_table);
> > > > > > > 
> > > > > > > Ah, much cleaner thanks!
> > > > > > 
> > > > > > It is my hope you we can get rid of register_sysctl_table one of these
> > > > > > days.  It was the original interface but today it is just a
> > > > > > compatibility wrapper.
> > > > > > 
> > > > > > I unfortunately ran out of steam last time before I
> > > > > > finished converting
> > > > > > everything over.
> > > > > 
> > > > > Let's give it one more go. I'll start with the fs stuff.
> > > > > 
> > > > >     Luis
> > > > > 
> > > > > .
> > > > > 
> > > > 
> > > > If we register each feature in its own feature code file using
> > > > register() to
> > > > register the sysctl interface. To avoid merge conflicts when different
> > > > features modify sysctl.c at the same time.
> > > > that is, try to Avoid mixing code with multiple features in the
> > > > same code
> > > > file.
> > > > 
> > > > For example, the multiple file interfaces defined in sysctl.c by the
> > > > hung_task feature can  be moved to hung_task.c.
> > > > 
> > > > Perhaps later, without centralized sysctl.c ?
> > > > Is this better?
> > > > 
> > > > Thanks
> > > > Xiaoming Ni
> > > > 
> > > > ---
> > > >   include/linux/sched/sysctl.h |  8 +----
> > > >   kernel/hung_task.c           | 78
> > > > +++++++++++++++++++++++++++++++++++++++++++-
> > > >   kernel/sysctl.c              | 50 ----------------------------
> > > >   3 files changed, 78 insertions(+), 58 deletions(-)
> > > > 
> > > > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> > > > index d4f6215..bb4e0d3 100644
> > > > --- a/include/linux/sched/sysctl.h
> > > > +++ b/include/linux/sched/sysctl.h
> > > > @@ -7,14 +7,8 @@
> > > >   struct ctl_table;
> > > > 
> > > >   #ifdef CONFIG_DETECT_HUNG_TASK
> > > > -extern int         sysctl_hung_task_check_count;
> > > > -extern unsigned int  sysctl_hung_task_panic;
> > > > +/* used for block/ */
> > > >   extern unsigned long sysctl_hung_task_timeout_secs;
> > > > -extern unsigned long sysctl_hung_task_check_interval_secs;
> > > > -extern int sysctl_hung_task_warnings;
> > > > -extern int proc_dohung_task_timeout_secs(struct ctl_table *table, int
> > > > write,
> > > > -                     void __user *buffer,
> > > > -                     size_t *lenp, loff_t *ppos);
> > > >   #else
> > > >   /* Avoid need for ifdefs elsewhere in the code */
> > > >   enum { sysctl_hung_task_timeout_secs = 0 };
> > > > diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> > > > index 14a625c..53589f2 100644
> > > > --- a/kernel/hung_task.c
> > > > +++ b/kernel/hung_task.c
> > > > @@ -20,10 +20,10 @@
> > > >   #include <linux/utsname.h>
> > > >   #include <linux/sched/signal.h>
> > > >   #include <linux/sched/debug.h>
> > > > +#include <linux/kmemleak.h>
> > > >   #include <linux/sched/sysctl.h>
> > > > 
> > > >   #include <trace/events/sched.h>
> > > > -
> > > >   /*
> > > >    * The number of tasks checked:
> > > >    */
> > > > @@ -296,8 +296,84 @@ static int watchdog(void *dummy)
> > > >       return 0;
> > > >   }
> > > > 
> > > > +/*
> > > > + * This is needed for proc_doulongvec_minmax of
> > > > sysctl_hung_task_timeout_secs
> > > > + * and hung_task_check_interval_secs
> > > > + */
> > > > +static unsigned long hung_task_timeout_max = (LONG_MAX / HZ);
> > > 
> > > This is not generic so it can stay in this file.
> > > 
> > > > +static int __maybe_unused neg_one = -1;
> > > 
> > > This is generic so we can share it, I suggest we just rename this
> > > for now to sysctl_neg_one, export it to a symbol namespace,
> > > EXPORT_SYMBOL_NS_GPL(sysctl_neg_one, SYSCTL) and then import it with
> > > MODULE_IMPORT_NS(SYSCTL)
> 
> When I made the patch, I found that only sysctl_writes_strict and
> hung_task_warnings use the neg_one variable, so is it necessary to merge and
> generate the SYSCTL_NEG_ONE variable?

Yes.


> In addition, the SYSCTL symbol namespace has not been created yet. Do I just
> need to add a new member -1 to the sysctl_vals array?

I had forgotten about our sysctl_vals, so disregard my request
to use EXPORT_SYMBOL_NS_GPL(sysctl_neg_one, SYSCTL) and using
MODULE_IMPORT_NS(SYSCTL). Since we are already using these and
have a prefix on the define we should be good.

> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b6f5d45..acae1fa 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -23,7 +23,7 @@
>  static const struct inode_operations proc_sys_dir_operations;
> 
>  /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { 0, 1, INT_MAX };
> +const int sysctl_vals[] = { 0, 1, INT_MAX, -1 };
>  EXPORT_SYMBOL(sysctl_vals);
> 
>  /* Support for permanently empty directories */
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 02fa844..6d741d6 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -41,6 +41,7 @@
>  #define SYSCTL_ZERO    ((void *)&sysctl_vals[0])
>  #define SYSCTL_ONE     ((void *)&sysctl_vals[1])
>  #define SYSCTL_INT_MAX ((void *)&sysctl_vals[2])
> +#define SYSCTL_NEG_ONE       ((void *)&sysctl_vals[3])
> 
>  extern const int sysctl_vals[];

This looks good.

  Luis
