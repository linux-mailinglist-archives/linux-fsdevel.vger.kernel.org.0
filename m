Return-Path: <linux-fsdevel+bounces-56982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5360B1D7B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 14:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A373D3B911D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A425264602;
	Thu,  7 Aug 2025 12:15:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96467246779;
	Thu,  7 Aug 2025 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754568925; cv=none; b=iH6dZstbC/ghJThPSObIf8tQGMCPVm6qvwxWB037khyCPMGHNF7EzoM220l6VMpJRlPjIxLRybD0MoMawcBMrG4dwQ9g0Rrwg7NGM0PLBgmd2Tb7dwkFtBTu3VInvS2gtKevT4ffaYlj431+CG3w9OvVJNJeeOPT6KrNmGuEkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754568925; c=relaxed/simple;
	bh=l38keMA1spohuhmIndrpLKx86PGXdFzls9phBtXxR30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LT1OVRQLWQHpLxHnMAmKnwZvbzAp1FZfJHC4NSqbHngoKPMIZ5bMXm1d4xs+XW1/CdMh+FzsIoBRsVf9ERzXb1aG+Me6ebuwtW9/PS+wjLk03o1arf1wQ8jaYRDGq1JkNBTaBM/xjHvhpamabsDJ5H0EGQitattrGrsJPZ7XNrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2dda5884738811f0b29709d653e92f7d-20250807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c9f6a6e8-399a-490e-8347-7d1f4825cb24,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:6169b3659762d4f1f45ccf9d34c3b578,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2dda5884738811f0b29709d653e92f7d-20250807
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1235472273; Thu, 07 Aug 2025 20:15:17 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 93F64E01A758;
	Thu,  7 Aug 2025 20:15:16 +0800 (CST)
X-ns-mid: postfix-689498D4-37051772
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 07760E0000B0;
	Thu,  7 Aug 2025 20:15:12 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	len brown <len.brown@intel.com>,
	pavel machek <pavel@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>,
	xu xin <xu.xin16@zte.com.cn>,
	wangfushuai <wangfushuai@baidu.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [RFC PATCH v1 9/9] proc: Add /proc/<pid>/freeze_priority interface
Date: Thu,  7 Aug 2025 20:14:18 +0800
Message-Id: <20250807121418.139765-10-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
References: <20250807121418.139765-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch introduces a new proc file `/proc/[pid]/freeze_priority`
that allows reading and writing the freeze priority of a task.

This is useful for  process freezing mechanisms that wish to prioritize
which tasks to freeze first during suspend or hibernation.

To avoid misuse and for system integrity, userspace is not permitted to
assign the `FREEZE_PRIORITY_NEVER` level to any task.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 Documentation/filesystems/proc.rst | 14 ++++++-
 fs/proc/base.c                     | 64 ++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
index 2971551b7235..4b7bc695b249 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -48,7 +48,8 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold=
.net>    June 9 2009
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
   3.13  /proc/<pid>/fd - List of symlinks to open files
-  3.14  /proc/<pid/ksm_stat - Information about the process's ksm status=
.
+  3.14  /proc/<pid>/ksm_stat - Information about the process's ksm statu=
s
+  3.15  /proc/<pid>/freeze_priority - Information about freeze_priority.
=20
   4	Configuring procfs
   4.1	Mount options
@@ -2349,6 +2350,17 @@ applicable to KSM.
 More information about KSM can be found in
 Documentation/admin-guide/mm/ksm.rst.
=20
+3.15	/proc/<pid>/freeze_priority - Information about freeze_priority
+-----------------------------------------------------------------------
+This file exposes the `freeze_priority` value of a given task.
+
+The freezer subsystem uses `freeze_priority` to determine the order
+in which tasks are frozen during suspend/hibernate. Tasks with
+lower values are frozen earlier. Higher values defer the task to
+later freeze rounds.
+
+Writing a value to this file allows user space to adjust the
+priority of the task in the freezer traversal.
=20
 Chapter 4: Configuring procfs
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 62d35631ba8c..724145356128 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -86,6 +86,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_parser.h>
 #include <linux/fs_struct.h>
+#include <linux/freezer.h>
 #include <linux/slab.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/mm.h>
@@ -3290,6 +3291,66 @@ static int proc_pid_ksm_stat(struct seq_file *m, s=
truct pid_namespace *ns,
 }
 #endif /* CONFIG_KSM */
=20
+#ifdef CONFIG_FREEZER
+static int freeze_priority_show(struct seq_file *m, void *v)
+{
+	struct inode *inode =3D m->private;
+	struct task_struct *p;
+
+	p =3D get_proc_task(inode);
+	if (!p)
+		return -ESRCH;
+
+	task_lock(p);
+	seq_printf(m, "%u\n", p->freeze_priority);
+	task_unlock(p);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
+static ssize_t freeze_priority_write(struct file *file, const char __use=
r *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct inode *inode =3D file_inode(file);
+	struct task_struct *p;
+	u64 freeze_priority;
+	int err;
+
+	err =3D kstrtoull_from_user(buf, count, 10, &freeze_priority);
+	if (err < 0)
+		return err;
+
+	if (freeze_priority >=3D FREEZE_PRIORITY_NEVER)
+		return -EINVAL;
+
+	p =3D get_proc_task(inode);
+	if (!p)
+		return -ESRCH;
+
+	task_lock(p);
+	p->freeze_priority =3D freeze_priority;
+	task_unlock(p);
+
+	put_task_struct(p);
+	return count;
+}
+
+static int freeze_priority_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, freeze_priority_show, inode);
+}
+
+static const struct file_operations proc_pid_freeze_priority =3D {
+	.open		=3D freeze_priority_open,
+	.read		=3D seq_read,
+	.write		=3D freeze_priority_write,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+#endif /* CONFIG_FREEZER */
+
 #ifdef CONFIG_KSTACK_ERASE_METRICS
 static int proc_stack_depth(struct seq_file *m, struct pid_namespace *ns=
,
 				struct pid *pid, struct task_struct *task)
@@ -3407,6 +3468,9 @@ static const struct pid_entry tgid_base_stuff[] =3D=
 {
 	REG("timers",	  S_IRUGO, proc_timers_operations),
 #endif
 	REG("timerslack_ns", S_IRUGO|S_IWUGO, proc_pid_set_timerslack_ns_operat=
ions),
+#ifdef CONFIG_FREEZER
+	REG("freeze_priority",  S_IRUGO|S_IWUSR, proc_pid_freeze_priority),
+#endif
 #ifdef CONFIG_LIVEPATCH
 	ONE("patch_state",  S_IRUSR, proc_pid_patch_state),
 #endif
--=20
2.25.1


