Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 417BE77578
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 02:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfG0Aqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 20:46:33 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47279 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfG0Aqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 20:46:33 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hrAr1-0001rY-0E; Fri, 26 Jul 2019 18:46:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hrAqz-0001vt-DW; Fri, 26 Jul 2019 18:46:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
        <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
        <20190726232220.GM1131@ZenIV.linux.org.uk>
Date:   Fri, 26 Jul 2019 19:46:18 -0500
In-Reply-To: <20190726232220.GM1131@ZenIV.linux.org.uk> (Al Viro's message of
        "Sat, 27 Jul 2019 00:22:20 +0100")
Message-ID: <878sskqp7p.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hrAqz-0001vt-DW;;;mid=<878sskqp7p.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ynbAJkUq6JB7YRCR2JBBqV2gFo6tXjvI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XM_Body_Dirty_Words autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1114 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 4.1 (0.4%), b_tie_ro: 2.9 (0.3%), parse: 2.5
        (0.2%), extract_message_metadata: 33 (2.9%), get_uri_detail_list: 11
        (1.0%), tests_pri_-1000: 24 (2.1%), tests_pri_-950: 1.89 (0.2%),
        tests_pri_-900: 1.58 (0.1%), tests_pri_-90: 58 (5.2%), check_bayes: 56
        (5.0%), b_tokenize: 27 (2.4%), b_tok_get_all: 16 (1.4%), b_comp_prob:
        4.6 (0.4%), b_tok_touch_all: 6 (0.5%), b_finish: 0.73 (0.1%),
        tests_pri_0: 971 (87.1%), check_dkim_signature: 0.90 (0.1%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 0.76 (0.1%), tests_pri_10:
        1.94 (0.2%), tests_pri_500: 11 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka user-namespace-mountable) filesystems
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Fri, Jul 26, 2019 at 03:47:02PM -0700, Linus Torvalds wrote:
>
>> Of course, then later on, commit 20284ab7427f ("switch mount_capable()
>> to fs_context") drops that argument entirely, and hardcodes the
>> decision to look at fc->global.
>> 
>> But that fc->global decision wasn't there originally, and is incorrect
>> since it breaks existing users.
>> 
>> What gets much more confusing about this is that the two different
>> users then moved around. The sget_userns() case got moved to
>> legacy_get_tree(), and then joined together in vfs_get_tree(), and
>> then split and moved out to do_new_mount() and vfs_fsconfig_locked().
>> 
>> And that "joined together into vfs_get_tree()" must be wrong, because
>> the two cases used two different namespace rules. The sget_userns()
>> case *did* have that "global" flag check, while the sget_fc() did not.
>> 
>> Messy. Al?
>
> Digging through that mess...  It's my fuckup, and we obviously need to
> restore the old behaviour, but I really hope to manage that with
> checks _not_ in superblock allocator ;-/

If someone had bothered to actually look at how I was proposing to clean
things up before the new mount api we would already have that.  Sigh.

You should be able to get away with something like this which moves the
checks earlier and makes things clearer.  My old patch against the pre
new mount api code.

I am running at undependable speed due to the new baby so it is probably
better for someone else to forward port this, but I will attempt it
otherwise.

Eric

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 21 Nov 2018 11:17:01 -0600
Subject: [PATCH] vfs: Replace FS_USERNS_MOUNT with file_system_type->permission

Permission checking of the user to see if the can mount an individual
filesystem using FS_USERNS_MOUNT and checks in sget is not very
comprehensible.  Further by pushing the logic down into sget the
attack surface on filesystems that don't support unprivilged mounts is
much larger than it should be.

Now that it is understood what the permission checks need to be refactor the
checks into a simple per filesystme permission check.  If no permission check is
implemented the default check becomes a simple capable(CAP_SYS_ADMIN).

The result is code that is much simpler to understand and much easier to maintain.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/devpts/inode.c      |  2 +-
 fs/fuse/inode.c        |  3 ++-
 fs/namespace.c         | 15 +++++++++++++++
 fs/proc/root.c         |  8 +++++++-
 fs/ramfs/inode.c       |  2 +-
 fs/super.c             | 20 ++++++--------------
 fs/sysfs/mount.c       | 13 +++++++------
 include/linux/fs.h     |  4 +++-
 ipc/mqueue.c           |  8 +++++++-
 kernel/cgroup/cgroup.c | 16 ++++++++--------
 mm/shmem.c             |  4 ++--
 11 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index c53814539070..1418912efc7d 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -519,9 +519,9 @@ static void devpts_kill_sb(struct super_block *sb)
 
 static struct file_system_type devpts_fs_type = {
 	.name		= "devpts",
+	.permission	= userns_mount_permission,
 	.mount		= devpts_mount,
 	.kill_sb	= devpts_kill_sb,
-	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0b94b23b02d4..e9f6aa9974f8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1259,7 +1259,8 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
+	.fs_flags	= FS_HAS_SUBTYPE,
+	.permission	= userns_mount_permission,
 	.mount		= fuse_mount,
 	.kill_sb	= fuse_kill_sb_anon,
 };
diff --git a/fs/namespace.c b/fs/namespace.c
index 74f64294a410..44935dbdb162 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2448,6 +2448,16 @@ static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
 
 static bool mount_too_revealing(struct vfsmount *mnt, int *new_mnt_flags);
 
+static int new_mount_permission(struct file_system_type *type)
+{
+	int err = 0;
+	if (type->permission)
+		err = type->permission();
+	else if (!capable(CAP_SYS_ADMIN))
+		err = -EPERM;
+	return err;
+}
+
 /*
  * create a new mount for userspace and request it to be added into the
  * namespace's tree
@@ -2466,6 +2476,11 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 	if (!type)
 		return -ENODEV;
 
+	/* Verify the mounter has permission to mount the filesystem */
+	err = new_mount_permission(type);
+	if (err)
+		return err;
+
 	mnt = vfs_kern_mount(type, sb_flags, name, data);
 	if (!IS_ERR(mnt) && (type->fs_flags & FS_HAS_SUBTYPE) &&
 	    !mnt->mnt_sb->s_subtype)
diff --git a/fs/proc/root.c b/fs/proc/root.c
index f4b1a9d2eca6..b870eacef952 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -86,6 +86,12 @@ int proc_remount(struct super_block *sb, int *flags, char *data)
 	return !proc_parse_options(data, pid);
 }
 
+static int proc_mount_permission(void)
+{
+	struct pid_namespace *ns = task_active_pid_ns(current);
+	return ns_capable(ns->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}
+
 static struct dentry *proc_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
@@ -116,9 +122,9 @@ static void proc_kill_sb(struct super_block *sb)
 
 static struct file_system_type proc_fs_type = {
 	.name		= "proc",
+	.permission	= proc_mount_permission,
 	.mount		= proc_mount,
 	.kill_sb	= proc_kill_sb,
-	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 void __init proc_root_init(void)
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 11201b2d06b9..6710cbe5e087 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -261,9 +261,9 @@ static void ramfs_kill_sb(struct super_block *sb)
 
 static struct file_system_type ramfs_fs_type = {
 	.name		= "ramfs",
+	.permission	= userns_mount_permission,
 	.mount		= ramfs_mount,
 	.kill_sb	= ramfs_kill_sb,
-	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 int __init init_ramfs_fs(void)
diff --git a/fs/super.c b/fs/super.c
index ca53a08497ed..0783794e6173 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -474,6 +474,12 @@ void generic_shutdown_super(struct super_block *sb)
 
 EXPORT_SYMBOL(generic_shutdown_super);
 
+int userns_mount_permission(void)
+{
+	return ns_capable(current_user_ns(), CAP_SYS_ADMIN) ? 0 : -EPERM;
+}
+EXPORT_SYMBOL(userns_mount_permission);
+
 /**
  *	sget_userns -	find or create a superblock
  *	@type:	filesystem type superblock should belong to
@@ -493,10 +499,6 @@ struct super_block *sget_userns(struct file_system_type *type,
 	struct super_block *old;
 	int err;
 
-	if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
-	    !(type->fs_flags & FS_USERNS_MOUNT) &&
-	    !capable(CAP_SYS_ADMIN))
-		return ERR_PTR(-EPERM);
 retry:
 	spin_lock(&sb_lock);
 	if (test) {
@@ -563,10 +565,6 @@ struct super_block *sget(struct file_system_type *type,
 	if (flags & SB_SUBMOUNT)
 		user_ns = &init_user_ns;
 
-	/* Ensure the requestor has permissions over the target filesystem */
-	if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
-		return ERR_PTR(-EPERM);
-
 	return sget_userns(type, test, set, flags, user_ns, data);
 }
 
@@ -1059,12 +1057,6 @@ struct dentry *mount_ns(struct file_system_type *fs_type,
 {
 	struct super_block *sb;
 
-	/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
-	 * over the namespace.
-	 */
-	if (!(flags & SB_KERNMOUNT) && !ns_capable(user_ns, CAP_SYS_ADMIN))
-		return ERR_PTR(-EPERM);
-
 	sb = sget_userns(fs_type, ns_test_super, ns_set_super, flags,
 			 user_ns, ns);
 	if (IS_ERR(sb))
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 015a8d95952b..058ebd28c413 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -21,6 +21,12 @@
 static struct kernfs_root *sysfs_root;
 struct kernfs_node *sysfs_root_kn;
 
+static int sysfs_mount_permission(void)
+{
+	struct net *net = current->nsproxy->net_ns;
+	return ns_capable(net->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}
+
 static struct dentry *sysfs_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
@@ -28,11 +34,6 @@ static struct dentry *sysfs_mount(struct file_system_type *fs_type,
 	struct dentry *root;
 	bool new_sb = false;
 
-	if (!(flags & SB_KERNMOUNT)) {
-		if (!ns_capable(net->user_ns, CAP_SYS_ADMIN))
-			return ERR_PTR(-EPERM);
-	}
-
 	net = hold_net(net);
 	root = kernfs_mount_ns(fs_type, flags, sysfs_root,
 				SYSFS_MAGIC, &new_sb, net);
@@ -54,9 +55,9 @@ static void sysfs_kill_sb(struct super_block *sb)
 
 static struct file_system_type sysfs_fs_type = {
 	.name		= "sysfs",
+	.permission	= sysfs_mount_permission,
 	.mount		= sysfs_mount,
 	.kill_sb	= sysfs_kill_sb,
-	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 int __init sysfs_init(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c95c0807471f..61dcd9b98118 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2165,8 +2165,8 @@ struct file_system_type {
 #define FS_REQUIRES_DEV		1 
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
-#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+	int (*permission)(void);
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
@@ -2186,6 +2186,8 @@ struct file_system_type {
 
 #define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
 
+int userns_mount_permission(void);
+
 extern struct dentry *mount_ns(struct file_system_type *fs_type,
 	int flags, void *data, void *ns, struct user_namespace *user_ns,
 	int (*fill_super)(struct super_block *, void *, int));
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index c595bed7bfcb..2c9533082110 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -343,6 +343,12 @@ static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
+static int mqueue_mount_permission(void)
+{
+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+	return ns_capable(ns->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}
+
 static struct dentry *mqueue_mount(struct file_system_type *fs_type,
 			 int flags, const char *dev_name,
 			 void *data)
@@ -1524,9 +1530,9 @@ static const struct super_operations mqueue_super_ops = {
 
 static struct file_system_type mqueue_fs_type = {
 	.name = "mqueue",
+	.permission = mqueue_mount_permission,
 	.mount = mqueue_mount,
 	.kill_sb = kill_litter_super,
-	.fs_flags = FS_USERNS_MOUNT,
 };
 
 int mq_init_ns(struct ipc_namespace *ns)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6aaf5dd5383b..82539ac4fa28 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2030,6 +2030,12 @@ struct dentry *cgroup_do_mount(struct file_system_type *fs_type, int flags,
 	return dentry;
 }
 
+static int cgroup_mount_permission(void)
+{
+	struct cgroup_namespace *ns = current->nsproxy->cgroup_ns;
+	return ns_capable(ns->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;
+}
+
 static struct dentry *cgroup_mount(struct file_system_type *fs_type,
 			 int flags, const char *unused_dev_name,
 			 void *data)
@@ -2040,12 +2046,6 @@ static struct dentry *cgroup_mount(struct file_system_type *fs_type,
 
 	get_cgroup_ns(ns);
 
-	/* Check if the caller has permission to mount. */
-	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN)) {
-		put_cgroup_ns(ns);
-		return ERR_PTR(-EPERM);
-	}
-
 	/*
 	 * The first time anyone tries to mount a cgroup, enable the list
 	 * linking each css_set to its tasks and fix up all existing tasks.
@@ -2101,16 +2101,16 @@ static void cgroup_kill_sb(struct super_block *sb)
 
 struct file_system_type cgroup_fs_type = {
 	.name = "cgroup",
+	.permission = cgroup_mount_permission,
 	.mount = cgroup_mount,
 	.kill_sb = cgroup_kill_sb,
-	.fs_flags = FS_USERNS_MOUNT,
 };
 
 static struct file_system_type cgroup2_fs_type = {
 	.name = "cgroup2",
+	.permission = cgroup_mount_permission,
 	.mount = cgroup_mount,
 	.kill_sb = cgroup_kill_sb,
-	.fs_flags = FS_USERNS_MOUNT,
 };
 
 int cgroup_path_ns_locked(struct cgroup *cgrp, char *buf, size_t buflen,
diff --git a/mm/shmem.c b/mm/shmem.c
index ea26d7a0342d..02f3bdaf7dc2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3654,9 +3654,9 @@ static struct dentry *shmem_mount(struct file_system_type *fs_type,
 static struct file_system_type shmem_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "tmpfs",
+	.permission	= userns_mount_permission,
 	.mount		= shmem_mount,
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 int __init shmem_init(void)
@@ -3799,9 +3799,9 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
 
 static struct file_system_type shmem_fs_type = {
 	.name		= "tmpfs",
+	.permission	= userns_mount_permission,
 	.mount		= ramfs_mount,
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 int __init shmem_init(void)
-- 
2.21.0.dirty


