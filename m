Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A67E1CFC16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 19:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgELRYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 13:24:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44992 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 13:24:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id b8so6427431pgi.11;
        Tue, 12 May 2020 10:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dcdkn+8Y5yBPrArGp86XHP6unAj0YxcB3Hd+tWo8Yjg=;
        b=IyjfHZy6iytVpBvgLxBu072vH0d1L/jvIlljXyM5J2Fnrns208X/aD7S0olWEo0nFR
         8HV9UoseOb1WqV5J0TwRWzz5k3WN58yLoWWGpclpaplpWgyKgeyK04FC7JJAsFSKOdPT
         FdJbCCXLD9DBj0p3YxniN3n16sFflv11BPh2ljXx9741gH+JYmGjDpsQ3cfdqrBQf571
         tVV7j+syG9lcJuSMG8VS8k9Xh8UPv7PpPSH+3JbdkPvFqJ8XR9TrHd1s8gAgwjibg5Ta
         13Fh2xcmY6IzxB6drxQ6nG6TzjdAmg7ydb86Y5nlGSGI5WaW6WggEaEYFJA+kgfauKq0
         2uuQ==
X-Gm-Message-State: AGi0PuYols8eOL4d7mdvAvjrQkXL1l//+t6uD5TzTuBtgAXFyBDS684C
        x45rwd/+0GWNYh9m7434frg=
X-Google-Smtp-Source: APiQypJnFxLzvcTaWa+2Y6oDWm5iEONX7kM4uSNpvwOfnQtK9cQpf+fXrVwOMIbTchbliL/bJ9uDGw==
X-Received: by 2002:a63:d501:: with SMTP id c1mr19999745pgg.186.1589304255599;
        Tue, 12 May 2020 10:24:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p9sm3871513pgb.19.2020.05.12.10.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 10:24:14 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7A68B4063E; Tue, 12 May 2020 17:24:13 +0000 (UTC)
Date:   Tue, 12 May 2020 17:24:13 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
Message-ID: <20200512172413.GC11244@42.do-not-panic.com>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
 <20200512003305.GX11244@42.do-not-panic.com>
 <87y2pxs73w.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2pxs73w.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 06:52:35AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > On Mon, May 11, 2020 at 09:55:16AM +0800, Xiaoming Ni wrote:
> >> On 2020/5/11 9:11, Stephen Rothwell wrote:
> >> > Hi all,
> >> > 
> >> > Today's linux-next merge of the vfs tree got a conflict in:
> >> > 
> >> >    kernel/sysctl.c
> >> > 
> >> > between commit:
> >> > 
> >> >    b6522fa409cf ("parisc: add sysctl file interface panic_on_stackoverflow")
> >> > 
> >> > from the parisc-hd tree and commit:
> >> > 
> >> >    f461d2dcd511 ("sysctl: avoid forward declarations")
> >> > 
> >> > from the vfs tree.
> >> > 
> >> > I fixed it up (see below) and can carry the fix as necessary. This
> >> > is now fixed as far as linux-next is concerned, but any non trivial
> >> > conflicts should be mentioned to your upstream maintainer when your tree
> >> > is submitted for merging.  You may also want to consider cooperating
> >> > with the maintainer of the conflicting tree to minimise any particularly
> >> > complex conflicts.
> >> > 
> >> 
> >> 
> >> Kernel/sysctl.c contains more than 190 interface files, and there are a
> >> large number of config macro controls. When modifying the sysctl interface
> >> directly in kernel/sysctl.c , conflicts are very easy to occur.
> >> 
> >> At the same time, the register_sysctl_table() provided by the system can
> >> easily add the sysctl interface, and there is no conflict of kernel/sysctl.c
> >> .
> >> 
> >> Should we add instructions in the patch guide (coding-style.rst
> >> submitting-patches.rst):
> >> Preferentially use register_sysctl_table() to add a new sysctl interface,
> >> centralize feature codes, and avoid directly modifying kernel/sysctl.c ?
> >
> > Yes, however I don't think folks know how to do this well. So I think we
> > just have to do at least start ourselves, and then reflect some of this
> > in the docs.  The reason that this can be not easy is that we need to
> > ensure that at an init level we haven't busted dependencies on setting
> > this. We also just don't have docs on how to do this well.
> >
> >> In addition, is it necessary to transfer the architecture-related sysctl
> >> interface to arch/xxx/kernel/sysctl.c ?
> 
> 
> >
> > Well here's an initial attempt to start with fs stuff in a very
> > conservative way. What do folks think?
> 
> I don't see how any of that deals with the current conflict in -next.

The point is to cleanup the kitchen sink full of knobs everyone from
different subsystem has put in place for random things so to reduce
the amount of edits on the file, so to then avoid the possibility
of merge conflicts.

> You are putting the fs sysctls in the wrong place.  The should live
> in fs/ not in fs/proc/.

That's an easy fix, sure, I'll do that.

> Otherwise you are pretty much repeating
> the problem the problem of poorly located code in another location.

Sure, alright, well I'll chug on with trying to clean up the kitchen
sink. We can decide where we put items during review.

> >  fs/proc/Makefile          |  1 +
> >  fs/proc/fs_sysctl_table.c | 97 +++++++++++++++++++++++++++++++++++++++
> >  kernel/sysctl.c           | 48 -------------------
> >  3 files changed, 98 insertions(+), 48 deletions(-)
> >  create mode 100644 fs/proc/fs_sysctl_table.c
> >
> > diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> > index bd08616ed8ba..8bf419b2ac7d 100644
> > --- a/fs/proc/Makefile
> > +++ b/fs/proc/Makefile
> > @@ -28,6 +28,7 @@ proc-y	+= namespaces.o
> >  proc-y	+= self.o
> >  proc-y	+= thread_self.o
> >  proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
> > +proc-$(CONFIG_SYSCTL)		+= fs_sysctl_table.o
> >  proc-$(CONFIG_NET)		+= proc_net.o
> >  proc-$(CONFIG_PROC_KCORE)	+= kcore.o
> >  proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
> > diff --git a/fs/proc/fs_sysctl_table.c b/fs/proc/fs_sysctl_table.c
> > new file mode 100644
> > index 000000000000..f56a49989872
> > --- /dev/null
> > +++ b/fs/proc/fs_sysctl_table.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * /proc/sys/fs sysctl table
> > + */
> > +#include <linux/init.h>
> > +#include <linux/sysctl.h>
> > +#include <linux/poll.h>
> > +#include <linux/proc_fs.h>
> > +#include <linux/printk.h>
> > +#include <linux/security.h>
> > +#include <linux/sched.h>
> > +#include <linux/cred.h>
> > +#include <linux/namei.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/bpf-cgroup.h>
> > +#include <linux/mount.h>
> > +#include <linux/dnotify.h>
> > +#include <linux/pipe_fs_i.h>
> > +#include <linux/aio.h>
> > +#include <linux/inotify.h>
> > +#include <linux/kmemleak.h>
> > +#include <linux/binfmts.h>
> > +
> > +static unsigned long zero_ul;
> > +static unsigned long long_max = LONG_MAX;
> > +
> > +static struct ctl_table fs_table[] = {
> > +	{
> > +		.procname	= "inode-nr",
> > +		.data		= &inodes_stat,
> > +		.maxlen		= 2*sizeof(long),
> > +		.mode		= 0444,
> > +		.proc_handler	= proc_nr_inodes,
> > +	},
> > +	{
> > +		.procname	= "inode-state",
> > +		.data		= &inodes_stat,
> > +		.maxlen		= 7*sizeof(long),
> > +		.mode		= 0444,
> > +		.proc_handler	= proc_nr_inodes,
> > +	},
> > +	{
> > +		.procname	= "file-nr",
> > +		.data		= &files_stat,
> > +		.maxlen		= sizeof(files_stat),
> > +		.mode		= 0444,
> > +		.proc_handler	= proc_nr_files,
> > +	},
> > +	{
> > +		.procname	= "file-max",
> > +		.data		= &files_stat.max_files,
> > +		.maxlen		= sizeof(files_stat.max_files),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_doulongvec_minmax,
> > +		.extra1		= &zero_ul,
> > +		.extra2		= &long_max,
> > +	},
> > +	{
> > +		.procname	= "nr_open",
> > +		.data		= &sysctl_nr_open,
> > +		.maxlen		= sizeof(unsigned int),
> > +		.mode		= 0644,
> > +		.proc_handler	= proc_dointvec_minmax,
> > +		.extra1		= &sysctl_nr_open_min,
> > +		.extra2		= &sysctl_nr_open_max,
> > +	},
> > +	{
> > +		.procname	= "dentry-state",
> > +		.data		= &dentry_stat,
> > +		.maxlen		= 6*sizeof(long),
> > +		.mode		= 0444,
> > +		.proc_handler	= proc_nr_dentry,
> > +	},
> > +	{ }
> > +};
> > +
> > +static struct ctl_table fs_base_table[] = {
> > +	{
> > +		.procname	= "fs",
> > +		.mode		= 0555,
> > +		.child		= fs_table,
> > +	},
> > +	{ }
> > +};
>   ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
> > > +static int __init fs_procsys_init(void)
> > +{
> > +	struct ctl_table_header *hdr;
> > +
> > +	hdr = register_sysctl_table(fs_base_table);
>               ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
> 	AKA
>         hdr = register_sysctl("fs", fs_table);

Ah, much cleaner thanks!

  Luis
