Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9F1CE9B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 02:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgELAdJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 20:33:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33560 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgELAdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 20:33:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id x77so5531871pfc.0;
        Mon, 11 May 2020 17:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wh0CPafLzUjJXBYGRq3dJLjsezbs2TE2R6kL31I0Dq4=;
        b=OTzEQowhYaafRDjdr5m1lAG+6+vQ15Pt+AYaQq3NO4zIFKtJjUEgy5zoBIkuAASQBE
         UdF5qa7YC2ssCgUhsWL/f8KH1DBsHKVLI/0WYbmnpiiSXYk5mlt0YNmwLWgKTfoYM1Dx
         Z7JBHLeMnBL6NCRa5jNMzvyDBbxiYtXn6C9T73M45yWxzMPGXjluWoaCs5qUMidOn1vB
         WF3S9WmouMrXKieTmktOWeNReNm4F8ARb6Mpo4TWbvjztyfoIto7ReUsimipreVJwEdp
         T8f/I+LIAI1TJVqrsPB/D5HRY4jJbqwZXKOoWdompMYOhpq14ERlnhSyGFR2yW8o0hFC
         SkYw==
X-Gm-Message-State: AGi0PuZGczjSbYXl4bYDpRbMJvDN8j9r6vZ9NgAQAIHYn9Cf0bKQ8Y+S
        dfk7dHCOW9JYxQYHUP21kso=
X-Google-Smtp-Source: APiQypKrIZ+6lWZ0LRBsHClUvKvaZokME9Kogdc1eBPHE9IUGqxSwIAAfco6pNFpA2RjoNap9cbZpw==
X-Received: by 2002:aa7:8091:: with SMTP id v17mr18942705pff.93.1589243587566;
        Mon, 11 May 2020 17:33:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r21sm11034364pjo.2.2020.05.11.17.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 17:33:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E3C8540E88; Tue, 12 May 2020 00:33:05 +0000 (UTC)
Date:   Tue, 12 May 2020 00:33:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        keescook@chromium.org, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the vfs tree with the parisc-hd tree
Message-ID: <20200512003305.GX11244@42.do-not-panic.com>
References: <20200511111123.68ccbaa3@canb.auug.org.au>
 <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99095805-8cbe-d140-e2f1-0c5a3e84d7e7@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 09:55:16AM +0800, Xiaoming Ni wrote:
> On 2020/5/11 9:11, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the vfs tree got a conflict in:
> > 
> >    kernel/sysctl.c
> > 
> > between commit:
> > 
> >    b6522fa409cf ("parisc: add sysctl file interface panic_on_stackoverflow")
> > 
> > from the parisc-hd tree and commit:
> > 
> >    f461d2dcd511 ("sysctl: avoid forward declarations")
> > 
> > from the vfs tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> 
> 
> Kernel/sysctl.c contains more than 190 interface files, and there are a
> large number of config macro controls. When modifying the sysctl interface
> directly in kernel/sysctl.c , conflicts are very easy to occur.
> 
> At the same time, the register_sysctl_table() provided by the system can
> easily add the sysctl interface, and there is no conflict of kernel/sysctl.c
> .
> 
> Should we add instructions in the patch guide (coding-style.rst
> submitting-patches.rst):
> Preferentially use register_sysctl_table() to add a new sysctl interface,
> centralize feature codes, and avoid directly modifying kernel/sysctl.c ?

Yes, however I don't think folks know how to do this well. So I think we
just have to do at least start ourselves, and then reflect some of this
in the docs.  The reason that this can be not easy is that we need to
ensure that at an init level we haven't busted dependencies on setting
this. We also just don't have docs on how to do this well.

> In addition, is it necessary to transfer the architecture-related sysctl
> interface to arch/xxx/kernel/sysctl.c ?

Well here's an initial attempt to start with fs stuff in a very
conservative way. What do folks think?

 fs/proc/Makefile          |  1 +
 fs/proc/fs_sysctl_table.c | 97 +++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c           | 48 -------------------
 3 files changed, 98 insertions(+), 48 deletions(-)
 create mode 100644 fs/proc/fs_sysctl_table.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..8bf419b2ac7d 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -28,6 +28,7 @@ proc-y	+= namespaces.o
 proc-y	+= self.o
 proc-y	+= thread_self.o
 proc-$(CONFIG_PROC_SYSCTL)	+= proc_sysctl.o
+proc-$(CONFIG_SYSCTL)		+= fs_sysctl_table.o
 proc-$(CONFIG_NET)		+= proc_net.o
 proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
diff --git a/fs/proc/fs_sysctl_table.c b/fs/proc/fs_sysctl_table.c
new file mode 100644
index 000000000000..f56a49989872
--- /dev/null
+++ b/fs/proc/fs_sysctl_table.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * /proc/sys/fs sysctl table
+ */
+#include <linux/init.h>
+#include <linux/sysctl.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/printk.h>
+#include <linux/security.h>
+#include <linux/sched.h>
+#include <linux/cred.h>
+#include <linux/namei.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/bpf-cgroup.h>
+#include <linux/mount.h>
+#include <linux/dnotify.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/aio.h>
+#include <linux/inotify.h>
+#include <linux/kmemleak.h>
+#include <linux/binfmts.h>
+
+static unsigned long zero_ul;
+static unsigned long long_max = LONG_MAX;
+
+static struct ctl_table fs_table[] = {
+	{
+		.procname	= "inode-nr",
+		.data		= &inodes_stat,
+		.maxlen		= 2*sizeof(long),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_inodes,
+	},
+	{
+		.procname	= "inode-state",
+		.data		= &inodes_stat,
+		.maxlen		= 7*sizeof(long),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_inodes,
+	},
+	{
+		.procname	= "file-nr",
+		.data		= &files_stat,
+		.maxlen		= sizeof(files_stat),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_files,
+	},
+	{
+		.procname	= "file-max",
+		.data		= &files_stat.max_files,
+		.maxlen		= sizeof(files_stat.max_files),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &zero_ul,
+		.extra2		= &long_max,
+	},
+	{
+		.procname	= "nr_open",
+		.data		= &sysctl_nr_open,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &sysctl_nr_open_min,
+		.extra2		= &sysctl_nr_open_max,
+	},
+	{
+		.procname	= "dentry-state",
+		.data		= &dentry_stat,
+		.maxlen		= 6*sizeof(long),
+		.mode		= 0444,
+		.proc_handler	= proc_nr_dentry,
+	},
+	{ }
+};
+
+static struct ctl_table fs_base_table[] = {
+	{
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= fs_table,
+	},
+	{ }
+};
+
+static int __init fs_procsys_init(void)
+{
+	struct ctl_table_header *hdr;
+
+	hdr = register_sysctl_table(fs_base_table);
+	kmemleak_not_leak(hdr);
+
+	return 0;
+}
+
+early_initcall(fs_procsys_init);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 3b0cecf57e79..6669d6118974 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -114,9 +114,7 @@ static int sixty = 60;
 static int __maybe_unused neg_one = -1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
-static unsigned long zero_ul;
 static unsigned long one_ul = 1;
-static unsigned long long_max = LONG_MAX;
 static int one_hundred = 100;
 static int one_thousand = 1000;
 #ifdef CONFIG_PRINTK
@@ -3087,52 +3085,6 @@ static struct ctl_table vm_table[] = {
 };
 
 static struct ctl_table fs_table[] = {
-	{
-		.procname	= "inode-nr",
-		.data		= &inodes_stat,
-		.maxlen		= 2*sizeof(long),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_inodes,
-	},
-	{
-		.procname	= "inode-state",
-		.data		= &inodes_stat,
-		.maxlen		= 7*sizeof(long),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_inodes,
-	},
-	{
-		.procname	= "file-nr",
-		.data		= &files_stat,
-		.maxlen		= sizeof(files_stat),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_files,
-	},
-	{
-		.procname	= "file-max",
-		.data		= &files_stat.max_files,
-		.maxlen		= sizeof(files_stat.max_files),
-		.mode		= 0644,
-		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &zero_ul,
-		.extra2		= &long_max,
-	},
-	{
-		.procname	= "nr_open",
-		.data		= &sysctl_nr_open,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &sysctl_nr_open_min,
-		.extra2		= &sysctl_nr_open_max,
-	},
-	{
-		.procname	= "dentry-state",
-		.data		= &dentry_stat,
-		.maxlen		= 6*sizeof(long),
-		.mode		= 0444,
-		.proc_handler	= proc_nr_dentry,
-	},
 	{
 		.procname	= "overflowuid",
 		.data		= &fs_overflowuid,
-- 
2.26.2

