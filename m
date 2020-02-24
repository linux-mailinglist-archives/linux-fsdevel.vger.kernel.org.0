Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38D16AB8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBXQbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:31:46 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:48478 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgBXQbq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:31:46 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6Ge1-0004uo-5E; Mon, 24 Feb 2020 09:31:45 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j6Gdx-00052X-3L; Mon, 24 Feb 2020 09:31:44 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
        <87v9odlxbr.fsf@x220.int.ebiederm.org>
        <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
        <87tv3vkg1a.fsf@x220.int.ebiederm.org>
        <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
        <87v9obipk9.fsf@x220.int.ebiederm.org>
        <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
        <20200212200335.GO23230@ZenIV.linux.org.uk>
        <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
        <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <871rqk2brn.fsf_-_@x220.int.ebiederm.org>
Date:   Mon, 24 Feb 2020 10:29:38 -0600
In-Reply-To: <871rqk2brn.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 24 Feb 2020 10:25:16 -0600")
Message-ID: <8736b00wzx.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j6Gdx-00052X-3L;;;mid=<8736b00wzx.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19MH8OOLAnkeXKMBLr4LWC1fUGnAEgCvqg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_FILL_THIS_FORM_SHORT,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3638 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 8 (0.2%), b_tie_ro: 5 (0.1%), parse: 2.2 (0.1%),
        extract_message_metadata: 24 (0.7%), get_uri_detail_list: 6 (0.2%),
        tests_pri_-1000: 26 (0.7%), tests_pri_-950: 1.80 (0.0%),
        tests_pri_-900: 1.11 (0.0%), tests_pri_-90: 52 (1.4%), check_bayes: 50
        (1.4%), b_tokenize: 23 (0.6%), b_tok_get_all: 14 (0.4%), b_comp_prob:
        4.3 (0.1%), b_tok_touch_all: 6 (0.2%), b_finish: 0.72 (0.0%),
        tests_pri_0: 580 (15.9%), check_dkim_signature: 0.93 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 2927 (80.4%),
        tests_pri_10: 2.2 (0.1%), tests_pri_500: 2937 (80.7%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH v2 6/6] proc: Use a list of inodes to flush from proc
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Rework the flushing of proc to use a list of directory inodes that
need to be flushed.

The list is kept on struct pid not on struct task_struct, as there is
a fixed connection between proc inodes and pids but at least for the
case of de_thread the pid of a task_struct changes.

This removes the dependency on proc_mnt which allows for different
mounts of proc having different mount options even in the same pid
namespace and this allows for the removal of proc_mnt which will
trivially the first mount of proc to honor it's mount options.

This flushing remains an optimization.  The functions
pid_delete_dentry and pid_revalidate ensure that ordinary dcache
management will not attempt to use dentries past the point their
respective task has died.  When unused the shrinker will
eventually be able to remove these dentries.

There is a case in de_thread where proc_flush_pid can be
called early for a given pid.  Which winds up being
safe (if suboptimal) as this is just an optiimization.

Only pid directories are put on the list as the other
per pid files are children of those directories and
d_invalidate on the directory will get them as well.

So that the pid can be used during flushing it's reference count is
taken in release_task and dropped in proc_flush_pid.  Further the call
of proc_flush_pid is moved after the tasklist_lock is released in
release_task so that it is certain that the pid has already been
unhashed when flushing it taking place.  This removes a small race
where a dentry could recreated.

As struct pid is supposed to be small and I need a per pid lock
I reuse the only lock that currently exists in struct pid the
the wait_pidfd.lock.

The net result is that this adds all of this functionality
with just a little extra list management overhead and
a single extra pointer in struct pid.

v2: Initialize pid->inodes.  I somehow failed to get that
    initialization into the initial version of the patch.  A boot
    failure was reported by "kernel test robot <lkp@intel.com>", and
    failure to initialize that pid->inodes matches all of the reported
    symptoms.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c          | 111 +++++++++++++---------------------------
 fs/proc/inode.c         |   2 +-
 fs/proc/internal.h      |   1 +
 include/linux/pid.h     |   1 +
 include/linux/proc_fs.h |   4 +-
 kernel/exit.c           |   4 +-
 kernel/pid.c            |   1 +
 7 files changed, 45 insertions(+), 79 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index c7c64272b0fa..e7efe9d6f3d6 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1834,11 +1834,25 @@ void task_dump_owner(struct task_struct *task, umode_t mode,
 	*rgid = gid;
 }
 
+void proc_pid_evict_inode(struct proc_inode *ei)
+{
+	struct pid *pid = ei->pid;
+
+	if (S_ISDIR(ei->vfs_inode.i_mode)) {
+		spin_lock(&pid->wait_pidfd.lock);
+		hlist_del_init_rcu(&ei->sibling_inodes);
+		spin_unlock(&pid->wait_pidfd.lock);
+	}
+
+	put_pid(pid);
+}
+
 struct inode *proc_pid_make_inode(struct super_block * sb,
 				  struct task_struct *task, umode_t mode)
 {
 	struct inode * inode;
 	struct proc_inode *ei;
+	struct pid *pid;
 
 	/* We need a new inode */
 
@@ -1856,10 +1870,18 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	/*
 	 * grab the reference to task.
 	 */
-	ei->pid = get_task_pid(task, PIDTYPE_PID);
-	if (!ei->pid)
+	pid = get_task_pid(task, PIDTYPE_PID);
+	if (!pid)
 		goto out_unlock;
 
+	/* Let the pid remember us for quick removal */
+	ei->pid = pid;
+	if (S_ISDIR(mode)) {
+		spin_lock(&pid->wait_pidfd.lock);
+		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
+		spin_unlock(&pid->wait_pidfd.lock);
+	}
+
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 	security_task_to_inode(task, inode);
 
@@ -3230,90 +3252,29 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
 	.permission	= proc_pid_permission,
 };
 
-static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
-{
-	struct dentry *dentry, *leader, *dir;
-	char buf[10 + 1];
-	struct qstr name;
-
-	name.name = buf;
-	name.len = snprintf(buf, sizeof(buf), "%u", pid);
-	/* no ->d_hash() rejects on procfs */
-	dentry = d_hash_and_lookup(mnt->mnt_root, &name);
-	if (dentry) {
-		d_invalidate(dentry);
-		dput(dentry);
-	}
-
-	if (pid == tgid)
-		return;
-
-	name.name = buf;
-	name.len = snprintf(buf, sizeof(buf), "%u", tgid);
-	leader = d_hash_and_lookup(mnt->mnt_root, &name);
-	if (!leader)
-		goto out;
-
-	name.name = "task";
-	name.len = strlen(name.name);
-	dir = d_hash_and_lookup(leader, &name);
-	if (!dir)
-		goto out_put_leader;
-
-	name.name = buf;
-	name.len = snprintf(buf, sizeof(buf), "%u", pid);
-	dentry = d_hash_and_lookup(dir, &name);
-	if (dentry) {
-		d_invalidate(dentry);
-		dput(dentry);
-	}
-
-	dput(dir);
-out_put_leader:
-	dput(leader);
-out:
-	return;
-}
-
 /**
- * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
- * @task: task that should be flushed.
+ * proc_flush_pid -  Remove dcache entries for @pid from the /proc dcache.
+ * @pid: pid that should be flushed.
  *
- * When flushing dentries from proc, one needs to flush them from global
- * proc (proc_mnt) and from all the namespaces' procs this task was seen
- * in. This call is supposed to do all of this job.
- *
- * Looks in the dcache for
- * /proc/@pid
- * /proc/@tgid/task/@pid
- * if either directory is present flushes it and all of it'ts children
- * from the dcache.
+ * This function walks a list of inodes (that belong to any proc
+ * filesystem) that are attached to the pid and flushes them from
+ * the dentry cache.
  *
  * It is safe and reasonable to cache /proc entries for a task until
  * that task exits.  After that they just clog up the dcache with
  * useless entries, possibly causing useful dcache entries to be
- * flushed instead.  This routine is proved to flush those useless
- * dcache entries at process exit time.
+ * flushed instead.  This routine is provided to flush those useless
+ * dcache entries when a process is reaped.
  *
  * NOTE: This routine is just an optimization so it does not guarantee
- *       that no dcache entries will exist at process exit time it
- *       just makes it very unlikely that any will persist.
+ *       that no dcache entries will exist after a process is reaped
+ *       it just makes it very unlikely that any will persist.
  */
 
-void proc_flush_task(struct task_struct *task)
+void proc_flush_pid(struct pid *pid)
 {
-	int i;
-	struct pid *pid, *tgid;
-	struct upid *upid;
-
-	pid = task_pid(task);
-	tgid = task_tgid(task);
-
-	for (i = 0; i <= pid->level; i++) {
-		upid = &pid->numbers[i];
-		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
-					tgid->numbers[i].nr);
-	}
+	proc_invalidate_siblings_dcache(&pid->inodes, &pid->wait_pidfd.lock);
+	put_pid(pid);
 }
 
 static struct dentry *proc_pid_instantiate(struct dentry * dentry,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index d9243b24554a..1e730ea1dcd6 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -40,7 +40,7 @@ static void proc_evict_inode(struct inode *inode)
 
 	/* Stop tracking associated processes */
 	if (ei->pid) {
-		put_pid(ei->pid);
+		proc_pid_evict_inode(ei);
 		ei->pid = NULL;
 	}
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index fd470172675f..9e294f0290e5 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -158,6 +158,7 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
 extern const struct dentry_operations pid_dentry_operations;
 extern int pid_getattr(const struct path *, struct kstat *, u32, unsigned int);
 extern int proc_setattr(struct dentry *, struct iattr *);
+extern void proc_pid_evict_inode(struct proc_inode *);
 extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
 extern void pid_update_inode(struct task_struct *, struct inode *);
 extern int pid_delete_dentry(const struct dentry *);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 998ae7d24450..01a0d4e28506 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -62,6 +62,7 @@ struct pid
 	unsigned int level;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
+	struct hlist_head inodes;
 	/* wait queue for pidfd notifications */
 	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 3dfa92633af3..40a7982b7285 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -32,7 +32,7 @@ struct proc_ops {
 typedef int (*proc_write_t)(struct file *, char *, size_t);
 
 extern void proc_root_init(void);
-extern void proc_flush_task(struct task_struct *);
+extern void proc_flush_pid(struct pid *);
 
 extern struct proc_dir_entry *proc_symlink(const char *,
 		struct proc_dir_entry *, const char *);
@@ -105,7 +105,7 @@ static inline void proc_root_init(void)
 {
 }
 
-static inline void proc_flush_task(struct task_struct *task)
+static inline void proc_flush_pid(struct pid *pid)
 {
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 2833ffb0c211..502b4995b688 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -191,6 +191,7 @@ void put_task_struct_rcu_user(struct task_struct *task)
 void release_task(struct task_struct *p)
 {
 	struct task_struct *leader;
+	struct pid *thread_pid;
 	int zap_leader;
 repeat:
 	/* don't need to get the RCU readlock here - the process is dead and
@@ -199,11 +200,11 @@ void release_task(struct task_struct *p)
 	atomic_dec(&__task_cred(p)->user->processes);
 	rcu_read_unlock();
 
-	proc_flush_task(p);
 	cgroup_release(p);
 
 	write_lock_irq(&tasklist_lock);
 	ptrace_release_task(p);
+	thread_pid = get_pid(p->thread_pid);
 	__exit_signal(p);
 
 	/*
@@ -226,6 +227,7 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
+	proc_flush_pid(thread_pid);
 	release_thread(p);
 	put_task_struct_rcu_user(p);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 0f4ecb57214c..ca08d6a3aa77 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -258,6 +258,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
 	init_waitqueue_head(&pid->wait_pidfd);
+	INIT_HLIST_HEAD(&pid->inodes);
 
 	upid = pid->numbers + ns->level;
 	spin_lock_irq(&pidmap_lock);
-- 
2.25.0

