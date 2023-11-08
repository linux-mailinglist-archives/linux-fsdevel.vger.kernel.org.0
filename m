Return-Path: <linux-fsdevel+bounces-2340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFD97E4DFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 01:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F41E2815EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD2EECB;
	Wed,  8 Nov 2023 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="QIq2goWi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fz1WfUQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF062A;
	Wed,  8 Nov 2023 00:28:02 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F096A10F9;
	Tue,  7 Nov 2023 16:28:01 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 6B0715C0290;
	Tue,  7 Nov 2023 19:28:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Nov 2023 19:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1699403281; x=
	1699489681; bh=TbF6zPfzxxV0kGGWfpgEVbl7j+eZNTv8euliBworYKU=; b=Q
	Iq2goWi+968KzrES1iSO5tfei7fuL9s/g1bj7JdKrTtKG1B7QtvDBsd9u38VBJKK
	Y5XixC/JSolGC6lwFVFo718V3IoAc3SxVh8gQSgS0r/jn1MQzePvpFRz9fJG5KD+
	OZ5+LCKeeTXV7JTb/HhxJsP2WwgT/AQxBhVGphYybOvDijIHZ5RbwQTROfyf5Aq3
	BqqAZyYh9RVK7gobvPrMyfUnSvWVCGqRsJS9E6E7RKl+i3liHZBpKKuTfCN83W7e
	Lk0P8ynehFgC2YfTLUI+rFxsd8uJ48+bsPpAaKcIuVCPlBBXzVAY51fMZ8kxF1l9
	0R8f071oQm6+9jEgBPCLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699403281; x=
	1699489681; bh=TbF6zPfzxxV0kGGWfpgEVbl7j+eZNTv8euliBworYKU=; b=f
	z1WfUQv4ZqKINp+kXdcPhXKtXLm5E/yOYCDtejT84lw+3bYb2E23XcUP3mrEg4PJ
	iC0DpPhqcxjtXkbOrvv9PQarApOsQjSp83kXEiP2TuzqN9T3ausHzl372wkiiub4
	SRgUfe8IISIRt97HMvHMvNCTXn+WxLgHKCqw5Nx5b7tys/tSHJwjZiW0FFoJHVQe
	uqtg++YZpVNP1ltAXogcubZ7hAzvLZwz58rP2SvYasmmd0oSFdKtgT5JtJlFuC9v
	TpdNAIZWDqs+DHlw9m1/z/dmQNraJf7Y43lW7/0G1nRaS56XXm44oJMA7EQcXfsy
	CKM8evL1hnZovjHsxa03Q==
X-ME-Sender: <xms:EdZKZbvl-N4RiZUep28VBkkE4PKbeWkwPeoDlKmdCOBMJj4oR5umRQ>
    <xme:EdZKZcfuucgKWcueSDwLRyjT_-m5IxKLStPlGOEZ-hQf9yq4C1G2LP7bsT9xfs3XR
    kl6NGlitOzfxCdhr6w>
X-ME-Received: <xmr:EdZKZezMhSz1w0zXYPeowIc-qhKHtnNy3spmleGfNlRnShkE0X8t79DQLIfyQpHjobbtQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfihtghh
    ohcutehnuggvrhhsvghnuceothihtghhohesthihtghhohdrphhiiiiirgeqnecuggftrf
    grthhtvghrnhephfevhfdvvdffueffgfffjeehlefffeefffeuheegvedvgefgueefkedu
    ieekgfelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihii
    iigr
X-ME-Proxy: <xmx:EdZKZaO0hwFzQaH6JS3WfRfl0hUgGPk6-XNdedT5_J5s87cy6DRNvQ>
    <xmx:EdZKZb8fmq-MAquK14X9ItW9qwoMN9F1hCORXnOPbaprDupVrpuRLw>
    <xmx:EdZKZaW6H6SR4YCcUlQRuAbndDmHq-yp6zHImtfN1VlycuTSZhCwWg>
    <xmx:EdZKZXTIMew_VJs0-FXr39kICgksNR7kZ4EUskJQ1Ttir8juau65xA>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 19:27:59 -0500 (EST)
From: Tycho Andersen <tycho@tycho.pizza>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Tycho Andersen <tandersen@netflix.com>
Subject: [RFC 4/6] misc cgroup: introduce an fd counter
Date: Tue,  7 Nov 2023 17:26:45 -0700
Message-Id: <20231108002647.73784-5-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108002647.73784-1-tycho@tycho.pizza>
References: <20231108002647.73784-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tycho Andersen <tandersen@netflix.com>

This idea is not new [1], but I'm hoping using the "new" misc controller to
avoid having to introduce a completely new controller will make it more
tenable.

This patch introduces cgroup migration primitives to the misc cgroup, which
didn't have them before. I didn't know what to do in the face of kvm
migrations, so I left those as no-ops for now. I also did not do any
abstraction of the migration primitives. We are interested in adding other
rlimit-y things to the misc cgroup if this approach looks reasonable, for
the same reasons described above. I tried writing both dynamic-dispatch and
static-dispatch versions, but they introduced a lot of noise that seemed
unnecessary for this first draft. I'm happy to take suggestions here.

One oddity here is when the migration happens, which is in the
can_attach/can_fork() family vs. doing it in the actual attach/fork()
functions. This saves us from having to track some delta, or walk the fd
table twice, at the expense of a more costly revert.

As a result, the cancel_fork/cancel_attach functions do nontrivial things,
which are hard to test form userspace as far as I can tell. I did some
manual hacky fault injection, but if there is an official way to test these
I'm happy to add that.

Finally, this exposes misc.current at the root level. This was useful for
testing, but perhaps is not something we need/want in the final version.

[1]: https://lore.kernel.org/all/1404311407-4851-1-git-send-email-merimus@google.com/

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
---
 fs/file.c                   |  68 +++++++++++-
 include/linux/fdtable.h     |   4 +
 include/linux/misc_cgroup.h |   1 +
 kernel/cgroup/misc.c        | 200 +++++++++++++++++++++++++++++++++++-
 4 files changed, 270 insertions(+), 3 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 539bead2364e..b27ec5c9d77e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
+#include <linux/misc_cgroup.h>
 #include <net/sock.h>
 
 #include "internal.h"
@@ -318,6 +319,45 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
 	return ALIGN(min(count, max_fds), BITS_PER_LONG);
 }
 
+#ifdef CONFIG_CGROUP_MISC
+static int charge_current_fds(struct files_struct *files, unsigned int count)
+{
+	return misc_cg_try_charge(MISC_CG_RES_NOFILE, files->mcg, count);
+}
+
+static void uncharge_current_fds(struct files_struct *files, unsigned int count)
+{
+	misc_cg_uncharge(MISC_CG_RES_NOFILE, files->mcg, count);
+}
+
+static void files_get_misc_cg(struct files_struct *newf)
+{
+	newf->mcg = get_current_misc_cg();
+}
+
+static void files_put_misc_cg(struct files_struct *newf)
+{
+	put_misc_cg(newf->mcg);
+}
+#else
+static int charge_current_fds(struct files_struct *files, unsigned int count)
+{
+	return 0;
+}
+
+static void uncharge_current_fds(struct files_struct *files, unsigned int count)
+{
+}
+
+static void files_get_misc_cg(struct files_struct *newf)
+{
+}
+
+static void files_put_misc_cg(struct files_struct *newf)
+{
+}
+#endif
+
 /*
  * Allocate a new files structure and copy contents from the
  * passed in files structure.
@@ -341,6 +381,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 	newf->resize_in_progress = false;
 	init_waitqueue_head(&newf->resize_wait);
 	newf->next_fd = 0;
+	files_get_misc_cg(newf);
 	new_fdt = &newf->fdtab;
 	new_fdt->max_fds = NR_OPEN_DEFAULT;
 	new_fdt->close_on_exec = newf->close_on_exec_init;
@@ -350,6 +391,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
+
 	open_files = sane_fdtable_size(old_fdt, max_fds);
 
 	/*
@@ -411,9 +453,22 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 	rcu_assign_pointer(newf->fdt, new_fdt);
 
-	return newf;
+	if (!charge_current_fds(newf, count_open_files(new_fdt)))
+		return newf;
+
+	new_fds = new_fdt->fd;
+	for (i = open_files; i != 0; i--) {
+		struct file *f = *new_fds++;
+
+		if (f)
+			fput(f);
+	}
+	if (new_fdt != &newf->fdtab)
+		__free_fdtable(new_fdt);
+	*errorp = -EMFILE;
 
 out_release:
+	files_put_misc_cg(newf);
 	kmem_cache_free(files_cachep, newf);
 out:
 	return NULL;
@@ -439,6 +494,7 @@ static struct fdtable *close_files(struct files_struct * files)
 			if (set & 1) {
 				struct file * file = xchg(&fdt->fd[i], NULL);
 				if (file) {
+					uncharge_current_fds(files, 1);
 					filp_close(file, files);
 					cond_resched();
 				}
@@ -448,6 +504,8 @@ static struct fdtable *close_files(struct files_struct * files)
 		}
 	}
 
+	files_put_misc_cg(files);
+
 	return fdt;
 }
 
@@ -542,6 +600,10 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (error)
 		goto repeat;
 
+	error = -EMFILE;
+	if (charge_current_fds(files, 1) < 0)
+		goto out;
+
 	if (start <= files->next_fd)
 		files->next_fd = fd + 1;
 
@@ -578,6 +640,8 @@ EXPORT_SYMBOL(get_unused_fd_flags);
 static void __put_unused_fd(struct files_struct *files, unsigned int fd)
 {
 	struct fdtable *fdt = files_fdtable(files);
+	if (test_bit(fd, fdt->open_fds))
+		uncharge_current_fds(files, 1);
 	__clear_open_fd(fd, fdt);
 	if (fd < files->next_fd)
 		files->next_fd = fd;
@@ -1248,7 +1312,7 @@ __releases(&files->file_lock)
 	 */
 	fdt = files_fdtable(files);
 	tofree = fdt->fd[fd];
-	if (!tofree && fd_is_open(fd, fdt))
+	if (!tofree && (fd_is_open(fd, fdt) || charge_current_fds(files, 1) < 0))
 		goto Ebusy;
 	get_file(file);
 	rcu_assign_pointer(fdt->fd[fd], file);
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index d74234c5d4e9..b8783fa0f63f 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/misc_cgroup.h>
 
 #include <linux/atomic.h>
 
@@ -65,6 +66,9 @@ struct files_struct {
 	unsigned long open_fds_init[1];
 	unsigned long full_fds_bits_init[1];
 	struct file __rcu * fd_array[NR_OPEN_DEFAULT];
+#ifdef CONFIG_CGROUP_MISC
+	struct misc_cg *mcg;
+#endif
 };
 
 struct file_operations;
diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index 6ddffeeb6f97..a675be53c875 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -18,6 +18,7 @@ enum misc_res_type {
 	/* AMD SEV-ES ASIDs resource */
 	MISC_CG_RES_SEV_ES,
 #endif
+	MISC_CG_RES_NOFILE,
 	MISC_CG_RES_TYPES
 };
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index bbce097270cf..a28f97307b3e 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -12,6 +12,8 @@
 #include <linux/atomic.h>
 #include <linux/slab.h>
 #include <linux/misc_cgroup.h>
+#include <linux/mm.h>
+#include <linux/fdtable.h>
 
 #define MAX_STR "max"
 #define MAX_NUM U64_MAX
@@ -24,6 +26,7 @@ static const char *const misc_res_name[] = {
 	/* AMD SEV-ES ASIDs resource */
 	"sev_es",
 #endif
+	"nofile",
 };
 
 /* Root misc cgroup */
@@ -37,7 +40,9 @@ static struct misc_cg root_cg;
  * more than the actual capacity. We are using Limits resource distribution
  * model of cgroup for miscellaneous controller.
  */
-static u64 misc_res_capacity[MISC_CG_RES_TYPES];
+static u64 misc_res_capacity[MISC_CG_RES_TYPES] = {
+	[MISC_CG_RES_NOFILE] = MAX_NUM,
+};
 
 /**
  * parent_misc() - Get the parent of the passed misc cgroup.
@@ -445,10 +450,203 @@ static void misc_cg_free(struct cgroup_subsys_state *css)
 	kfree(css_misc(css));
 }
 
+static void revert_attach_until(struct cgroup_taskset *tset, struct task_struct *stop)
+{
+	struct task_struct *task;
+	struct cgroup_subsys_state *dst_css;
+
+	cgroup_taskset_for_each(task, dst_css, tset) {
+		struct misc_cg *misc, *old_misc;
+		struct cgroup_subsys_state *old_css;
+		struct files_struct *files;
+		struct fdtable *fdt;
+		unsigned long nofile;
+
+		if (task == stop)
+			break;
+
+		misc = css_misc(dst_css);
+		old_css = task_css(task, misc_cgrp_id);
+		old_misc = css_misc(old_css);
+
+		if (misc == old_misc)
+			continue;
+
+		task_lock(task);
+		files = task->files;
+		spin_lock(&files->file_lock);
+		fdt = files_fdtable(files);
+
+		if (old_misc == files->mcg)
+			goto done;
+
+		WARN_ON_ONCE(misc != files->mcg);
+
+		nofile = count_open_files(fdt);
+		misc_cg_charge(MISC_CG_RES_NOFILE, old_misc, nofile);
+		misc_cg_uncharge(MISC_CG_RES_NOFILE, misc, nofile);
+
+		put_misc_cg(files->mcg);
+		css_get(old_css);
+		files->mcg = old_misc;
+
+done:
+		spin_unlock(&files->file_lock);
+		task_unlock(task);
+	}
+}
+
+static int misc_cg_can_attach(struct cgroup_taskset *tset)
+{
+	struct task_struct *task;
+	struct cgroup_subsys_state *dst_css;
+
+	cgroup_taskset_for_each(task, dst_css, tset) {
+		struct misc_cg *misc, *old_misc;
+		struct cgroup_subsys_state *old_css;
+		unsigned long nofile;
+		struct files_struct *files;
+		struct fdtable *fdt;
+		int ret;
+
+		misc = css_misc(dst_css);
+		old_css = task_css(task, misc_cgrp_id);
+		old_misc = css_misc(old_css);
+
+		if (misc == old_misc)
+			continue;
+
+		task_lock(task);
+		files = task->files;
+		spin_lock(&files->file_lock);
+		fdt = files_fdtable(files);
+
+		/*
+		 * If this task->files was already in the right place (either
+		 * because of dup_fd() or because some other thread had already
+		 * migrated it), we don't need to do anything.
+		 */
+		if (misc == files->mcg)
+			goto done;
+
+		WARN_ON_ONCE(old_misc != files->mcg);
+
+		nofile = count_open_files(fdt);
+		ret = misc_cg_try_charge(MISC_CG_RES_NOFILE, misc, nofile);
+		if (ret < 0) {
+			spin_unlock(&files->file_lock);
+			task_unlock(task);
+			revert_attach_until(tset, task);
+			return ret;
+		}
+		misc_cg_uncharge(MISC_CG_RES_NOFILE, old_misc, nofile);
+
+		/*
+		 * let's ref the new table, install it, and
+		 * deref the old one.
+		 */
+		put_misc_cg(files->mcg);
+		css_get(dst_css);
+		files->mcg = misc;
+
+done:
+		spin_unlock(&files->file_lock);
+		task_unlock(task);
+
+	}
+
+	return 0;
+}
+
+static void misc_cg_cancel_attach(struct cgroup_taskset *tset)
+{
+	revert_attach_until(tset, NULL);
+}
+
+static int misc_cg_can_fork(struct task_struct *task, struct css_set *cset)
+{
+	struct misc_cg *dst_misc, *init_misc;
+	struct files_struct *files;
+	struct fdtable *fdt;
+	unsigned long nofile;
+	struct cgroup_subsys_state *dst_css, *cur_css;
+	int ret;
+
+	init_misc = css_misc(init_css_set.subsys[misc_cgrp_id]);
+	cur_css = task_get_css(task, misc_cgrp_id);
+
+	WARN_ON_ONCE(init_misc != css_misc(cur_css));
+
+	dst_css = cset->subsys[misc_cgrp_id];
+	dst_misc = css_misc(dst_css);
+
+	/*
+	 * When forking, tasks are initially put into the init_css_set (see
+	 * cgroup_fork()). Then, we do a dup_fd() and charge init_css_set for
+	 * the new task's fds. We need to migrate from the init_css_set to the
+	 * target one so we can charge the right place.
+	 */
+	task_lock(task);
+	files = task->files;
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+
+	ret = 0;
+	if (files->mcg == dst_misc)
+		goto out;
+
+	nofile = count_open_files(fdt);
+	ret = misc_cg_try_charge(MISC_CG_RES_NOFILE, dst_misc, nofile);
+	if (ret < 0)
+		goto out;
+
+	misc_cg_uncharge(MISC_CG_RES_NOFILE, init_misc, nofile);
+
+	put_misc_cg(files->mcg);
+	css_get(dst_css);
+	files->mcg = dst_misc;
+	ret = 0;
+
+out:
+	spin_unlock(&files->file_lock);
+	task_unlock(task);
+
+	return ret;
+}
+
+static void misc_cg_cancel_fork(struct task_struct *task, struct css_set *cset)
+{
+	struct misc_cg *dst_misc;
+	struct files_struct *files;
+	struct fdtable *fdt;
+	unsigned long nofile;
+	struct cgroup_subsys_state *dst_css;
+
+	dst_css = cset->subsys[misc_cgrp_id];
+	dst_misc = css_misc(dst_css);
+
+	task_lock(task);
+	files = task->files;
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+
+	/*
+	 * we don't need to re-charge anyone, since this fork is going away.
+	 */
+	nofile = count_open_files(fdt);
+	misc_cg_uncharge(MISC_CG_RES_NOFILE, dst_misc, nofile);
+	spin_unlock(&files->file_lock);
+	task_unlock(task);
+}
+
 /* Cgroup controller callbacks */
 struct cgroup_subsys misc_cgrp_subsys = {
 	.css_alloc = misc_cg_alloc,
 	.css_free = misc_cg_free,
 	.legacy_cftypes = misc_cg_files,
 	.dfl_cftypes = misc_cg_files,
+	.can_attach = misc_cg_can_attach,
+	.cancel_attach = misc_cg_cancel_attach,
+	.can_fork = misc_cg_can_fork,
+	.cancel_fork = misc_cg_cancel_fork,
 };
-- 
2.34.1


