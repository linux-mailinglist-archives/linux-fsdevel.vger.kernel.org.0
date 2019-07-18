Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B606CFFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfGROlN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 10:41:13 -0400
Received: from ucol19pa10.eemsg.mail.mil ([214.24.24.83]:49309 "EHLO
        UCOL19PA10.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGROlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:41:13 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 10:41:11 EDT
X-EEMSG-check-017: 697214974|UCOL19PA10_EEMSG_MP8.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,278,1559520000"; 
   d="scan'208";a="697214974"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA10.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Jul 2019 14:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1563460258; x=1594996258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ApWw5pWiPXLOd1e0K+779P3wRy0Py/qzYDJQX1jLBOM=;
  b=ZAQSauvm5cV3R/s4QYb8Amc50IfT1HFjaMoRa0YDD7vAx+gOVXg2jDRg
   e1TmRbwvlNEpEhQsuqzFwHsb2ieT7xY7gGhLNaMCF6Lj6AeQYoa0vQ87A
   T7U1E9ULCVGSV3sPwmz7NCgy9Gh/rA17pYt6SHzy29nXHC07cX3Z0iMVH
   2CB7yJWXFuMmi/QSRumaUY9Gr/GMw2KL0u2nvvD+EVtQZaDpi7NaVuAEe
   PdJbwomLCKq3OoiPx/eiTYknSByKXOnQx5lZD840c4EGbfurKrqk3Wc0l
   FVnsAdnib7n0DZTgkvqYiTFxKP5V68Ia0o68ttp+/z+shaJIWxP48VJ2d
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,278,1559520000"; 
   d="scan'208";a="25845912"
IronPort-PHdr: =?us-ascii?q?9a23=3AgVv46RFgzj7SGoSVer5Eyp1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76pc+zbnLW6fgltlLVR4KTs6sC17OM9f69EjNQqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5sIBmsrAjctsYajIlhJ60s1h?=
 =?us-ascii?q?bHv3xEdvhMy2h1P1yThRH85smx/J5n7Stdvu8q+tBDX6vnYak2VKRUAzs6PW?=
 =?us-ascii?q?874s3rrgTDQhCU5nQASGUWkwFHDBbD4RrnQ5r+qCr6tu562CmHIc37SK0/VD?=
 =?us-ascii?q?q+46t3ThLjlSkINyQ98GrKlMJ+iqxVqw+lqxBmw4PZZISZOfxjda3fYNwaX3?=
 =?us-ascii?q?JMUMZPWSJcDI2ybIwBAOUOM+tDs4XwpEEDoQekCAWwGO/izCJDiH/s3a091u?=
 =?us-ascii?q?QsCR3L0xY6H9IJtnTfsdT7NKATUe+o0qbIySjIYvRM1jjh54jIdREhruySUr?=
 =?us-ascii?q?9rbcrQyVUgFwPCjlmKr4zlJCma2v4Cs2ic8eptTOSigHMkpQFpujWj28ghh4?=
 =?us-ascii?q?bTio8V11zI7zt1zYkrKdGiVUJ2Z8OvHoFKuCGALYR2R9svQ2RvuCkn1LILoY?=
 =?us-ascii?q?W7fC0WyJQ/wB7fduCHf5CI4h39UOaRJi91hG5/d7Klhhay7FOgxvfgVsi0zF?=
 =?us-ascii?q?lKri1FnsPKtn8RzBzc9tKLSv58/kelwTqP1gbT5f9YIU0siKbWJJEszqQwm5?=
 =?us-ascii?q?YOq0jPACD7lFvsgKOLbkkk//Kn6+XjYrXovJ+cMIp0hxnkPasylcy/BuU4PR?=
 =?us-ascii?q?UQUGWA5eS91KHs/U3+QLlQiP02ibPWvIrVJcQcuK61GxVV3Zo76xajEzem18?=
 =?us-ascii?q?wVnX0GLFJDZRKGgJHlO1LQL/DiC/ewnVCsnSx1x/DJILLhGI/BLnvdn7f7e7?=
 =?us-ascii?q?Zy9UpcxBA0zdBF6JJeEqsBL+7rWk/tqNzYCQc0Mw6xw+bgEtV9zIIeWXmUD6?=
 =?us-ascii?q?+fKqzStEGH5uM1L+mLfo8Vty73K+I56P72kX85hVgdcLGz0psSaXC4BPZrLk?=
 =?us-ascii?q?uYYXromdoBHmIKsRA/TOzuklGNTTlTZ3OqVaIm+j47EJ6mDZvERo21gryOxj?=
 =?us-ascii?q?u0Hp5Na2BdF1CMCmnne5+YVPYNcCiSONNukiQYVbi9TI8szQyhtA/9y7tpMO?=
 =?us-ascii?q?XU/ikYtYn42dhv+eLciBEy+iZoD8iHz26NSGR0lHsSRzAqxKB/vVB9ylCb3K?=
 =?us-ascii?q?h8gvxYE8FT5vxQXgc0Lp7T0vJ1C87sVQLFZdqJVlmmTcu8AT0rTdI+3cUOY0?=
 =?us-ascii?q?BjFNWmlBzD2DCqA7ANnbyRGJM06r7c32T2J8tlz3bG1a8hj0QpQ8dWLm2pmL?=
 =?us-ascii?q?Jw9xXJB47Ij0WYl7+mdaEb3CHQ6WeDyXSBsVpGUA5/T6rFR2oTZkjIotTj4E?=
 =?us-ascii?q?PNUbuuBa4gMgtbxs6IMrFKZcHxjVVaWPfjP8zTY3mvlGe0BBaIwK6MbYXxdm?=
 =?us-ascii?q?UD0yXSFlIEnxoQ/XmYLwg+ADmuo2bEADxpD1LvbFvm8fNip3OjUk800waKYl?=
 =?us-ascii?q?V517Wv5x4VgeeRS+sJ0bIZvCctsjB0HFG639LMFdWMvRZufKJZYYB13FASzW?=
 =?us-ascii?q?vEsyRlN4GkaqVlgUQTNQ9wuhDAzRJyX6xJi88s5FwtzQZ/LerM2VhOcDKU0L?=
 =?us-ascii?q?jsK7bXLS/05xnpZKnIjAKNmO2K87sCvaxr427ouxukQw9/ong=3D?=
X-IPAS-Result: =?us-ascii?q?A2C2BAD3gTBd/wHyM5BmHAEBAQQBAQcEAQGBZ4FoBSqBP?=
 =?us-ascii?q?gEyKpZ7AQEBAQEBBoI0iGSRFwkBAQEBAQEBAQEbGQECAQGEQIJOIzgTAQMBA?=
 =?us-ascii?q?QEEAQEBAQQBAWyFSII6KYMVCwFEAoFRglcMP4F3FK1XM4h+gUiBNIcIZoNxF?=
 =?us-ascii?q?3iBB4ERgl1zg34SGIV/BJQVlk4JghuLRog6DBuCLYsxiiynFCGBWCsIAhgII?=
 =?us-ascii?q?Q+DJ4JNFxSOKSMDMIEGAQGLFA0XB4IlAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Jul 2019 14:30:57 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6IEUrXH017190;
        Thu, 18 Jul 2019 10:30:53 -0400
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, Aaron Goidel <acgoide@tycho.nsa.gov>
Subject: [RFC PATCH v2] fanotify, inotify, dnotify, security: add security hook for fs notifications
Date:   Thu, 18 Jul 2019 10:30:42 -0400
Message-Id: <20190718143042.11059-1-acgoide@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As of now, setting watches on filesystem objects has, at most, applied a
check for read access to the inode, and in the case of fanotify, requires
CAP_SYS_ADMIN. No specific security hook or permission check has been
provided to control the setting of watches. Using any of inotify, dnotify,
or fanotify, it is possible to observe, not only write-like operations, but
even read access to a file. Modeling the watch as being merely a read from
the file is insufficient for the needs of SELinux. This is due to the fact
that read access should not necessarily imply access to information about
when another process reads from a file. Furthermore, fanotify watches grant
more power to an application in the form of permission events. While
notification events are solely, unidirectional (i.e. they only pass
information to the receiving application), permission events are blocking.
Permission events make a request to the receiving application which will
then reply with a decision as to whether or not that action may be
completed. This causes the issue of the watching application having the
ability to exercise control over the triggering process. Without drawing a
distinction within the permission check, the ability to read would imply
the greater ability to control an application. Additionally, mount and
superblock watches apply to all files within the same mount or superblock.
Read access to one file should not necessarily imply the ability to watch
all files accessed within a given mount or superblock.

In order to solve these issues, a new LSM hook is implemented and has been
placed within the system calls for marking filesystem objects with inotify,
fanotify, and dnotify watches. These calls to the hook are placed at the
point at which the target inode has been resolved and are provided with the
inode, the mask of requested notification events, and the type of object on
which the mark is being set (inode, superblock, or mount). The mask and
mark_type have already been translated into common FS_* values shared by
the entirety of the fs notification infrastructure.

This only provides a hook at the point of setting a watch, and presumes
that permission to set a particular watch implies the ability to receive
all notification about that object which match the mask. This is all that
is required for SELinux. If other security modules require additional hooks
or infrastructure to control delivery of notification, these can be added
by them. It does not make sense for us to propose hooks for which we have
no implementation. The understanding that all notifications received by the
requesting application are all strictly of a type for which the application
has been granted permission shows that this implementation is sufficient in
its coverage.

Security modules wishing to provide complete control over fanotify must
also implement a security_file_open hook that validates that the access
requested by the watching application is authorized. Fanotify has the issue
that it returns a file descriptor with the file mode specified during
fanotify_init() to the watching process on event. This is already covered
by the LSM security_file_open hook if the security module implements
checking of the requested file mode there. Otherwise, a watching process
can obtain escalated access to a file for which it has not been authorized.

The selinux_inode_notify hook implementation works by adding five new file
permissions: watch, watch_mount, watch_sb, watch_reads, and watch_with_perm
(descriptions about which will follow), and one new filesystem permission:
watch (which is applied to superblock checks). The hook then decides which
subset of these permissions must be held by the requesting application
based on the contents of the provided mask and the mark_type. The
selinux_file_open hook already checks the requested file mode and therefore
ensures that a watching process cannot escalate its access through
fanotify.

The watch, watch_mount, and watch_sb permissions are the baseline
permissions for setting a watch on an object and each are a requirement for
any watch to be set on a file, mount, or superblock respectively. It should
be noted that having either of the other two permissions (watch_reads and
watch_with_perm) does not imply the watch, watch_mount, or watch_sb
permission. Superblock watches further require the filesystem watch
permission to the superblock. As there is no labeled object in view for
mounts, there is no specific check for mount watches beyond watch_mount to
the inode. Such a check could be added in the future, if a suitable labeled
object existed representing the mount.

The watch_reads permission is required to receive notifications from
read-exclusive events on filesystem objects. These events include accessing
a file for the purpose of reading and closing a file which has been opened
read-only. This distinction has been drawn in order to provide a direct
indication in the policy for this otherwise not obvious capability. Read
access to a file should not necessarily imply the ability to observe read
events on a file.

Finally, watch_with_perm only applies to fanotify masks since it is the
only way to set a mask which allows for the blocking, permission event.
This permission is needed for any watch which is of this type. Though
fanotify requires CAP_SYS_ADMIN, this is insufficient as it gives implicit
trust to root, which we do not do, and does not support least privilege.

Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
---
v2:
  - Adds support for mark_type
    - Adds watch_sb and watch_mount file permissions
    - Adds watch as new filesystem permission
    - LSM hook now recieves mark_type argument
    - Changed LSM hook logic to implement checks for corresponding mark_types
  - Adds missing hook description comment
  - Fixes extrainous whitespace
  - Updates patch description based on feedback

 fs/notify/dnotify/dnotify.c         | 14 +++++++--
 fs/notify/fanotify/fanotify_user.c  | 27 +++++++++++++++--
 fs/notify/inotify/inotify_user.c    | 13 ++++++--
 include/linux/lsm_hooks.h           |  6 ++++
 include/linux/security.h            |  9 +++++-
 security/security.c                 |  5 +++
 security/selinux/hooks.c            | 47 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  5 +--
 8 files changed, 116 insertions(+), 10 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 250369d6901d..4690d8a66035 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -22,6 +22,7 @@
 #include <linux/sched/signal.h>
 #include <linux/dnotify.h>
 #include <linux/init.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/fdtable.h>
@@ -288,6 +289,16 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 		goto out_err;
 	}
 
+	/*
+	 * convert the userspace DN_* "arg" to the internal FS_*
+	 * defined in fsnotify
+	 */
+	mask = convert_arg(arg);
+
+	error = security_inode_notify(inode, mask, FSNOTIFY_OBJ_TYPE_INODE);
+	if (error)
+		goto out_err;
+
 	/* expect most fcntl to add new rather than augment old */
 	dn = kmem_cache_alloc(dnotify_struct_cache, GFP_KERNEL);
 	if (!dn) {
@@ -302,9 +313,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned long arg)
 		goto out_err;
 	}
 
-	/* convert the userspace DN_* "arg" to the internal FS_* defines in fsnotify */
-	mask = convert_arg(arg);
-
 	/* set up the new_fsn_mark and new_dn_mark */
 	new_fsn_mark = &new_dn_mark->fsn_mark;
 	fsnotify_init_mark(new_fsn_mark, dnotify_group);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a90bb19dcfa2..9e3137badb6b 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -528,9 +528,10 @@ static const struct file_operations fanotify_fops = {
 };
 
 static int fanotify_find_path(int dfd, const char __user *filename,
-			      struct path *path, unsigned int flags)
+			      struct path *path, unsigned int flags, __u64 mask)
 {
 	int ret;
+	unsigned int mark_type;
 
 	pr_debug("%s: dfd=%d filename=%p flags=%x\n", __func__,
 		 dfd, filename, flags);
@@ -567,8 +568,30 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 
 	/* you can only watch an inode if you have read permissions on it */
 	ret = inode_permission(path->dentry->d_inode, MAY_READ);
+	if (ret) {
+		path_put(path);
+		goto out;
+	}
+
+	switch (flags & FANOTIFY_MARK_TYPE_BITS) {
+	case FAN_MARK_MOUNT:
+		mark_type = FSNOTIFY_OBJ_TYPE_VFSMOUNT;
+		break;
+	case FAN_MARK_FILESYSTEM:
+		mark_type = FSNOTIFY_OBJ_TYPE_SB;
+		break;
+	case FAN_MARK_INODE:
+		mark_type = FSNOTIFY_OBJ_TYPE_INODE;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = security_inode_notify(path->dentry->d_inode, mask, mark_type);
 	if (ret)
 		path_put(path);
+
 out:
 	return ret;
 }
@@ -1014,7 +1037,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 	}
 
-	ret = fanotify_find_path(dfd, pathname, &path, flags);
+	ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
 	if (ret)
 		goto fput_and_out;
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 7b53598c8804..73b321a30bbc 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -39,6 +39,7 @@
 #include <linux/poll.h>
 #include <linux/wait.h>
 #include <linux/memcontrol.h>
+#include <linux/security.h>
 
 #include "inotify.h"
 #include "../fdinfo.h"
@@ -342,7 +343,8 @@ static const struct file_operations inotify_fops = {
 /*
  * find_inode - resolve a user-given path to a specific inode
  */
-static int inotify_find_inode(const char __user *dirname, struct path *path, unsigned flags)
+static int inotify_find_inode(const char __user *dirname, struct path *path,
+						unsigned int flags, __u64 mask)
 {
 	int error;
 
@@ -351,8 +353,15 @@ static int inotify_find_inode(const char __user *dirname, struct path *path, uns
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
 	error = inode_permission(path->dentry->d_inode, MAY_READ);
+	if (error) {
+		path_put(path);
+		return error;
+	}
+	error = security_inode_notify(path->dentry->d_inode, mask,
+				FSNOTIFY_OBJ_TYPE_INODE);
 	if (error)
 		path_put(path);
+
 	return error;
 }
 
@@ -744,7 +753,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	if (mask & IN_ONLYDIR)
 		flags |= LOOKUP_DIRECTORY;
 
-	ret = inotify_find_inode(pathname, &path, flags);
+	ret = inotify_find_inode(pathname, &path, flags, mask);
 	if (ret)
 		goto fput_and_out;
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cfb6a19..9b3f5a5f3246 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -394,6 +394,9 @@
  *	Check permission before removing the extended attribute
  *	identified by @name for @dentry.
  *	Return 0 if permission is granted.
+ * @inode_notify:
+ *	Check permissions before setting a watch on events as defined by @mask,
+ *	on an object @inode, whose type is defined by @mark_type.
  * @inode_getsecurity:
  *	Retrieve a copy of the extended attribute representation of the
  *	security label associated with @name for @inode via @buffer.  Note that
@@ -1571,6 +1574,8 @@ union security_list_options {
 	int (*inode_getxattr)(struct dentry *dentry, const char *name);
 	int (*inode_listxattr)(struct dentry *dentry);
 	int (*inode_removexattr)(struct dentry *dentry, const char *name);
+	int (*inode_notify)(struct inode *inode, u64 mask,
+				unsigned int mark_type);
 	int (*inode_need_killpriv)(struct dentry *dentry);
 	int (*inode_killpriv)(struct dentry *dentry);
 	int (*inode_getsecurity)(struct inode *inode, const char *name,
@@ -1881,6 +1886,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getxattr;
 	struct hlist_head inode_listxattr;
 	struct hlist_head inode_removexattr;
+	struct hlist_head inode_notify;
 	struct hlist_head inode_need_killpriv;
 	struct hlist_head inode_killpriv;
 	struct hlist_head inode_getsecurity;
diff --git a/include/linux/security.h b/include/linux/security.h
index 659071c2e57c..b12666513138 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -301,6 +301,8 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_inode_notify(struct inode *inode, u64 mask,
+					unsigned int mark_type);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
@@ -387,7 +389,6 @@ int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(char *secdata, u32 seclen);
-
 void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
@@ -776,6 +777,12 @@ static inline int security_inode_removexattr(struct dentry *dentry,
 	return cap_inode_removexattr(dentry, name);
 }
 
+static inline int security_inode_notify(struct inode *inode, u64 mask,
+				unsigned int mark_type)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index 613a5c00e602..bc30e201c137 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1251,6 +1251,11 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 	return evm_inode_removexattr(dentry, name);
 }
 
+int security_inode_notify(struct inode *inode, u64 mask, unsigned int mark_type)
+{
+	return call_int_hook(inode_notify, 0, inode, mask, mark_type);
+}
+
 int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return call_int_hook(inode_need_killpriv, 0, dentry);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..c967e46a34ea 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,8 @@
 #include <linux/kernfs.h>
 #include <linux/stringhash.h>	/* for hashlen_string() */
 #include <uapi/linux/mount.h>
+#include <linux/fsnotify.h>
+#include <linux/fanotify.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -3261,6 +3263,50 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
 	return -EACCES;
 }
 
+static int selinux_inode_notify(struct inode *inode, u64 mask,
+						unsigned int mark_type)
+{
+	int ret;
+	u32 perm;
+
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	/*
+	 * Set permission needed based on the type of mark being set.
+	 * Performs an additional check for sb watches.
+	 */
+	switch (mark_type) {
+	case FSNOTIFY_OBJ_TYPE_VFSMOUNT:
+		perm = FILE__WATCH_MOUNT;
+		break;
+	case FSNOTIFY_OBJ_TYPE_SB:
+		perm = FILE__WATCH_SB;
+		ret = superblock_has_perm(current_cred(), inode->i_sb,
+						FILESYSTEM__WATCH, &ad);
+		if (ret)
+			return ret;
+		break;
+	case FSNOTIFY_OBJ_TYPE_INODE:
+		perm = FILE__WATCH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	// check if the mask is requesting ability to set a blocking watch
+	if (mask & (ALL_FSNOTIFY_PERM_EVENTS))
+		perm |= FILE__WATCH_WITH_PERM; // if so, check that permission
+
+	// is the mask asking to watch file reads?
+	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
+		perm |= FILE__WATCH_READS; // check that permission as well
+
+	return inode_has_perm(current_cred(), inode, perm, &ad);
+}
+
 /*
  * Copy the inode security context value to the user.
  *
@@ -6797,6 +6843,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
+	LSM_HOOK_INIT(inode_notify, selinux_inode_notify),
 
 	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 201f7e588a29..32e9b03be3dd 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -7,7 +7,8 @@
 
 #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
     "rename", "execute", "quotaon", "mounton", "audit_access", \
-    "open", "execmod"
+	"open", "execmod", "watch", "watch_mount", "watch_sb", \
+	"watch_with_perm", "watch_reads"
 
 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
     "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
@@ -60,7 +61,7 @@ struct security_class_mapping secclass_map[] = {
 	{ "filesystem",
 	  { "mount", "remount", "unmount", "getattr",
 	    "relabelfrom", "relabelto", "associate", "quotamod",
-	    "quotaget", NULL } },
+	    "quotaget", "watch", NULL } },
 	{ "file",
 	  { COMMON_FILE_PERMS,
 	    "execute_no_trans", "entrypoint", NULL } },
-- 
2.21.0

