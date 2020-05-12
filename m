Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C941CF3D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 13:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgELL4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 07:56:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53064 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgELL4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 07:56:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYTW3-0000Dd-ND; Tue, 12 May 2020 05:56:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jYTW2-0006WD-Ps; Tue, 12 May 2020 05:56:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Luis Chamberlain <mcgrof@kernel.org>
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
References: <20200511111123.68ccbaa3@canb.auug.org.au>
        <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
        <20200512003305.GX11244@42.do-not-panic.com>
Date:   Tue, 12 May 2020 06:52:35 -0500
In-Reply-To: <20200512003305.GX11244@42.do-not-panic.com> (Luis Chamberlain's
        message of "Tue, 12 May 2020 00:33:05 +0000")
Message-ID: <87y2pxs73w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jYTW2-0006WD-Ps;;;mid=<87y2pxs73w.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Mp2g/GCv9Wkg39vzKmSv+w+sqwRvuPww=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Luis Chamberlain <mcgrof@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 501 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.5 (0.9%), b_tie_ro: 3.0 (0.6%), parse: 1.40
        (0.3%), extract_message_metadata: 7 (1.4%), get_uri_detail_list: 4.4
        (0.9%), tests_pri_-1000: 3.3 (0.7%), tests_pri_-950: 1.10 (0.2%),
        tests_pri_-900: 0.88 (0.2%), tests_pri_-90: 66 (13.3%), check_bayes:
        65 (13.0%), b_tokenize: 10 (2.1%), b_tok_get_all: 11 (2.3%),
        b_comp_prob: 3.3 (0.7%), b_tok_touch_all: 37 (7.3%), b_finish: 0.69
        (0.1%), tests_pri_0: 400 (79.8%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 1.04 (0.2%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Chamberlain <mcgrof@kernel.org> writes:

> On Mon, May 11, 2020 at 09:55:16AM +0800, Xiaoming Ni wrote:
>> On 2020/5/11 9:11, Stephen Rothwell wrote:
>> > Hi all,
>> > 
>> > Today's linux-next merge of the vfs tree got a conflict in:
>> > 
>> >    kernel/sysctl.c
>> > 
>> > between commit:
>> > 
>> >    b6522fa409cf ("parisc: add sysctl file interface panic_on_stackoverflow")
>> > 
>> > from the parisc-hd tree and commit:
>> > 
>> >    f461d2dcd511 ("sysctl: avoid forward declarations")
>> > 
>> > from the vfs tree.
>> > 
>> > I fixed it up (see below) and can carry the fix as necessary. This
>> > is now fixed as far as linux-next is concerned, but any non trivial
>> > conflicts should be mentioned to your upstream maintainer when your tree
>> > is submitted for merging.  You may also want to consider cooperating
>> > with the maintainer of the conflicting tree to minimise any particularly
>> > complex conflicts.
>> > 
>> 
>> 
>> Kernel/sysctl.c contains more than 190 interface files, and there are a
>> large number of config macro controls. When modifying the sysctl interface
>> directly in kernel/sysctl.c , conflicts are very easy to occur.
>> 
>> At the same time, the register_sysctl_table() provided by the system can
>> easily add the sysctl interface, and there is no conflict of kernel/sysctl.c
>> .
>> 
>> Should we add instructions in the patch guide (coding-style.rst
>> submitting-patches.rst):
>> Preferentially use register_sysctl_table() to add a new sysctl interface,
>> centralize feature codes, and avoid directly modifying kernel/sysctl.c ?
>
> Yes, however I don't think folks know how to do this well. So I think we
> just have to do at least start ourselves, and then reflect some of this
> in the docs.  The reason that this can be not easy is that we need to
> ensure that at an init level we haven't busted dependencies on setting
> this. We also just don't have docs on how to do this well.
>
>> In addition, is it necessary to transfer the architecture-related sysctl
>> interface to arch/xxx/kernel/sysctl.c ?


>
> Well here's an initial attempt to start with fs stuff in a very
> conservative way. What do folks think?

I don't see how any of that deals with the current conflict in -next.

You are putting the fs sysctls in the wrong place.  The should live
in fs/ not in fs/proc/.  Otherwise you are pretty much repeating
the problem the problem of poorly located code in another location.


>  fs/proc/Makefile          |  1 +
>  fs/proc/fs_sysctl_table.c | 97 +++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl.c           | 48 -------------------
>  3 files changed, 98 insertions(+), 48 deletions(-)
>  create mode 100644 fs/proc/fs_sysctl_table.c
>
> diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> index bd08616ed8ba..8bf419b2ac7d 100644
> --- a/fs/proc/Makefile
> +++ b/fs/proc/Makefile
> @@ -28,6 +28,7 @@ proc-y	+= namespaces.o
>  proc-y	+= self.o
>  proc-y	+= thread_self.o
>  proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
> +proc-$(CONFIG_SYSCTL)		+= fs_sysctl_table.o
>  proc-$(CONFIG_NET)		+= proc_net.o
>  proc-$(CONFIG_PROC_KCORE)	+= kcore.o
>  proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
> diff --git a/fs/proc/fs_sysctl_table.c b/fs/proc/fs_sysctl_table.c
> new file mode 100644
> index 000000000000..f56a49989872
> --- /dev/null
> +++ b/fs/proc/fs_sysctl_table.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * /proc/sys/fs sysctl table
> + */
> +#include <linux/init.h>
> +#include <linux/sysctl.h>
> +#include <linux/poll.h>
> +#include <linux/proc_fs.h>
> +#include <linux/printk.h>
> +#include <linux/security.h>
> +#include <linux/sched.h>
> +#include <linux/cred.h>
> +#include <linux/namei.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/bpf-cgroup.h>
> +#include <linux/mount.h>
> +#include <linux/dnotify.h>
> +#include <linux/pipe_fs_i.h>
> +#include <linux/aio.h>
> +#include <linux/inotify.h>
> +#include <linux/kmemleak.h>
> +#include <linux/binfmts.h>
> +
> +static unsigned long zero_ul;
> +static unsigned long long_max = LONG_MAX;
> +
> +static struct ctl_table fs_table[] = {
> +	{
> +		.procname	= "inode-nr",
> +		.data		= &inodes_stat,
> +		.maxlen		= 2*sizeof(long),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_inodes,
> +	},
> +	{
> +		.procname	= "inode-state",
> +		.data		= &inodes_stat,
> +		.maxlen		= 7*sizeof(long),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_inodes,
> +	},
> +	{
> +		.procname	= "file-nr",
> +		.data		= &files_stat,
> +		.maxlen		= sizeof(files_stat),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_files,
> +	},
> +	{
> +		.procname	= "file-max",
> +		.data		= &files_stat.max_files,
> +		.maxlen		= sizeof(files_stat.max_files),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &zero_ul,
> +		.extra2		= &long_max,
> +	},
> +	{
> +		.procname	= "nr_open",
> +		.data		= &sysctl_nr_open,
> +		.maxlen		= sizeof(unsigned int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &sysctl_nr_open_min,
> +		.extra2		= &sysctl_nr_open_max,
> +	},
> +	{
> +		.procname	= "dentry-state",
> +		.data		= &dentry_stat,
> +		.maxlen		= 6*sizeof(long),
> +		.mode		= 0444,
> +		.proc_handler	= proc_nr_dentry,
> +	},
> +	{ }
> +};
> +
> +static struct ctl_table fs_base_table[] = {
> +	{
> +		.procname	= "fs",
> +		.mode		= 0555,
> +		.child		= fs_table,
> +	},
> +	{ }
> +};
  ^^^^^^^^^^^^^^^^^^^^^^^^ You don't need this at all.
  
> > +static int __init fs_procsys_init(void)
> +{
> +	struct ctl_table_header *hdr;
> +
> +	hdr = register_sysctl_table(fs_base_table);
              ^^^^^^^^^^^^^^^^^^^^^ Please use register_sysctl instead.
	AKA
        hdr = register_sysctl("fs", fs_table);
> +	kmemleak_not_leak(hdr);
> +
> +	return 0;
> +}
> +
> +early_initcall(fs_procsys_init);
