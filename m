Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795686475E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfGJNo5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 09:44:57 -0400
Received: from uhil19pa11.eemsg.mail.mil ([214.24.21.84]:13889 "EHLO
        uhil19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfGJNo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:44:57 -0400
X-Greylist: delayed 644 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 09:44:55 EDT
X-EEMSG-check-017: 426977097|UHIL19PA11_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 10 Jul 2019 13:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562765649; x=1594301649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PTdEfZV8kGhu/+TJ3EIKXBMjLDqSiQT/UZHKphaKcSQ=;
  b=g9KdYbbntZa72dVFATov4e4u6zgnaYXLm1Cl1vrAvARD3A190U0CVXPP
   p5gEuHlcCUxkuCSOebwKK9LuyI/LFP1fnrImZLdRn+uFpNzVwf0ySOYxX
   khriBSZ8p3GS9DXmd2SmCU6lV2sAeMmuMUlTy72aGf52wDpkzcqo5TefC
   nKeMIvijhjMgL9LliTFupR/wRz6/PzqQ+ENXc3AlPz1INNXvraYacW0At
   7RHPg9Hk05URg/pbACM58oMJQH422zUYznoL6S02CNrQCbHBLN4NBC4QL
   AkQWsaQvX9NGimFt+PfbxLzccRRx0S6CBmKrXrXH7vXiP0mGxlX5Xs4QD
   g==;
X-IronPort-AV: E=Sophos;i="5.63,474,1557187200"; 
   d="scan'208";a="29951448"
IronPort-PHdr: =?us-ascii?q?9a23=3AAy1MhBamTRkgkc1hYpRg3xD/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZps65bR7h7PlgxGXEQZ/co6odzbaP6ea8Bydevd6oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMhm6twrcu8gZjYZjJas61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzoJOD4j9GHcl9J+gqRVrhm8oxBz2o7ZbYWQOPd4Y6jTf84VRX?=
 =?us-ascii?q?BZU8hRSSJPH42yYYgIAeUOMuhVtJXxqlgUoBeiHwSgGP/jxzlVjXH2x6061O?=
 =?us-ascii?q?EhHBna0QM6BdIOt3LUp8j0OqcVUOC60bfHzTHeZP5Rwzjy9IfIchcgof6RQ7?=
 =?us-ascii?q?19atbRyEkzGAPFiVWcs4rlPyiP2egXvGib6PRgWPuphmU6qA9xuiCiytojh4?=
 =?us-ascii?q?TGnI4Yyk3I+T9nzIs6O9G0UlN3bNi5G5VKrS6aLZF5QsY6TmFtvyY116MJtI?=
 =?us-ascii?q?agfCgP1JQn3xnfa+Gbc4SQ4hLsSuKRITBgiXJ5Yr2/nRey8VW7yuHmSsm10E?=
 =?us-ascii?q?pFripCktXWsHACywfT5dSdRvt4/0eh3S6D1wHV6u5aPUA5jbfXJpEuz7Iqlp?=
 =?us-ascii?q?cfrF7PEjH5lUnolqOaa10o+u2y5OTmZrXmqIWcN4hxigzmKKshhsO/AeM5Mg?=
 =?us-ascii?q?cTQWeW4vi81b3/8k35R7VGlPs2krLDv5zAKsQbobC5DxdP0ok/8xa/Eyum0N?=
 =?us-ascii?q?MAkHkDLVJFfg+HjofwN1HNPv/4F/G/jEqokDpw2fDGMaPuAo/XInjAjrjhZ7?=
 =?us-ascii?q?B95FBYyAYpytBf/Z1UAKkbIP3vQk/xqMDYDhghPgy2xubnD8991pkfWWKUGa?=
 =?us-ascii?q?KZNrndsVqW6eIuOeWMY5UVuDnlIfg/+/HulWM5mUMafaSxx5QXbXG4Hu5kLk?=
 =?us-ascii?q?iXYHrshswMEWgPvgUkTezqjEeOXiJUZ3a3R6g8/C00CJq6DYffQYCgmL6B0z?=
 =?us-ascii?q?2nEZ1VfW1GEU2MEWz2eImeR/gNaTqYItV9nTwcSbihV4gh2Amzuw/6zLpmIP?=
 =?us-ascii?q?Tb+ikctZL4z9V1/fPcmgwy9TNuE8SRyX2CT2ZxnmkQXT85wLh/oVBhyleEya?=
 =?us-ascii?q?V4h/1YFdpO5/JGSws6O4XcwPFkBNDsRA3BesyESEipQtq4GzE9VNExzMEUY0?=
 =?us-ascii?q?Z7BdqiigrP3y2wA78aj7aLHoA78rrA33jtIMZw03LG1Kgnj1k7TcpDLHamib?=
 =?us-ascii?q?Bj+AjOHY7JklmZlqazeaQZ2y7C6XqDzW6Qs0xDTg5wXrvKXWoFakvVs9v5/E?=
 =?us-ascii?q?XCQKGqCbg9NQtB08GCILNQatL1lVVGWOvjONPGbmKqhWiwAReIxrWRbIvlYG?=
 =?us-ascii?q?gdwirdB1YekwwJ/naJKxI+BiG/rGLaFjBuEkjvY0z0++lktHy7VlM0zx2Nb0?=
 =?us-ascii?q?B5z7q64AMVhfiHRvMLxL0EpSMhpyxxHFa62NLWEcSPqxB9c6VbZNNuqGtAgH?=
 =?us-ascii?q?rQqghVJpW9K+VngVkEfkJ8uEa9+Q9wD9BpmNItqjsFywt+JKbQhFpKeDSZ0Z?=
 =?us-ascii?q?3YJqzcKm60+gumLaHRxAeNg56t5q4T5aFg+B3YtwazGx9nriRq?=
X-IPAS-Result: =?us-ascii?q?A2C4AAAc6CVd/wHyM5BlHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WcFKoE7ATIol0UBAQEBAQEGixORFAkBAQEBAQEBAQEbGQECAQGEQIJQIzcGD?=
 =?us-ascii?q?gEDAQEBBAEBAQEEAQFshUiCOimDFQsBRAKBUYJXDD+BdxSvGzOIcYFHgTQBh?=
 =?us-ascii?q?weEVxd4gQeDbnODfhIYhX4ElA6WSAmCG4tEiDYMG4Isiy2KJgGmfSKBWCsIA?=
 =?us-ascii?q?hgIIQ+DJ4JNFxSOKSMDMIEGAQGMG4JDAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 10 Jul 2019 13:34:08 +0000
Received: from moss-callisto.infosec.tycho.ncsc.mil (moss-callisto [192.168.25.136])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6ADY4Rg024736;
        Wed, 10 Jul 2019 09:34:06 -0400
From:   Aaron Goidel <acgoide@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        amir73il@gmail.com, jmorris@namei.org, sds@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, Aaron Goidel <acgoide@tycho.nsa.gov>
Subject: [RFC PATCH] fanotify, inotify, dnotify, security: add security hook for fs notifications
Date:   Wed, 10 Jul 2019 09:34:03 -0400
Message-Id: <20190710133403.855-1-acgoide@tycho.nsa.gov>
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
the file is insufficient. Furthermore, fanotify watches grant more power to
an application in the form of permission events. While notification events
are solely, unidirectional (i.e. they only pass information to the
receiving application), permission events are blocking. Permission events
make a request to the receiving application which will then reply with a
decision as to whether or not that action may be completed.

In order to solve these issues, a new LSM hook is implemented and has been
placed within the system calls for marking filesystem objects with inotify,
fanotify, and dnotify watches. These calls to the hook are placed at the
point at which the target inode has been resolved and are provided with
both the inode and the mask of requested notification events. The mask has
already been translated into common FS_* values shared by the entirety of
the fs notification infrastructure.

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

Fanotify further has the issue that it returns a file descriptor with the
file mode specified during fanotify_init() to the watching process on
event. This is already covered by the LSM security_file_open hook if the
security module implements checking of the requested file mode there.

The selinux_inode_notify hook implementation works by adding three new
file permissions: watch, watch_reads, and watch_with_perm (descriptions
about which will follow). The hook then decides which subset of these
permissions must be held by the requesting application based on the
contents of the provided mask. The selinux_file_open hook already checks
the requested file mode and therefore ensures that a watching process
cannot escalate its access through fanotify.

The watch permission is the baseline permission for setting a watch on an
object and is a requirement for any watch to be set whatsoever. It should
be noted that having either of the other two permissions (watch_reads and
watch_with_perm) does not imply the watch permission, though this could be
changed if need be.

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
 fs/notify/dnotify/dnotify.c         | 14 +++++++++++---
 fs/notify/fanotify/fanotify_user.c  | 11 +++++++++--
 fs/notify/inotify/inotify_user.c    | 12 ++++++++++--
 include/linux/lsm_hooks.h           |  2 ++
 include/linux/security.h            |  7 +++++++
 security/security.c                 |  5 +++++
 security/selinux/hooks.c            | 22 ++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +-
 8 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index 250369d6901d..e91ce092efb1 100644
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
+	error = security_inode_notify(inode, mask);
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
index a90bb19dcfa2..c0d9fa998377 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -528,7 +528,7 @@ static const struct file_operations fanotify_fops = {
 };
 
 static int fanotify_find_path(int dfd, const char __user *filename,
-			      struct path *path, unsigned int flags)
+			      struct path *path, unsigned int flags, __u64 mask)
 {
 	int ret;
 
@@ -567,8 +567,15 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 
 	/* you can only watch an inode if you have read permissions on it */
 	ret = inode_permission(path->dentry->d_inode, MAY_READ);
+	if (ret) {
+		path_put(path);
+		goto out;
+	}
+
+	ret = security_inode_notify(path->dentry->d_inode, mask);
 	if (ret)
 		path_put(path);
+
 out:
 	return ret;
 }
@@ -1014,7 +1021,7 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 	}
 
-	ret = fanotify_find_path(dfd, pathname, &path, flags);
+	ret = fanotify_find_path(dfd, pathname, &path, flags, mask);
 	if (ret)
 		goto fput_and_out;
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 7b53598c8804..47b079f20aad 100644
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
 
@@ -351,8 +353,14 @@ static int inotify_find_inode(const char __user *dirname, struct path *path, uns
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
 	error = inode_permission(path->dentry->d_inode, MAY_READ);
+	if (error) {
+		path_put(path);
+		return error;
+	}
+	error = security_inode_notify(path->dentry->d_inode, mask);
 	if (error)
 		path_put(path);
+
 	return error;
 }
 
@@ -744,7 +752,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	if (mask & IN_ONLYDIR)
 		flags |= LOOKUP_DIRECTORY;
 
-	ret = inotify_find_inode(pathname, &path, flags);
+	ret = inotify_find_inode(pathname, &path, flags, mask);
 	if (ret)
 		goto fput_and_out;
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cfb6a19..ef6b74938dd8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1571,6 +1571,7 @@ union security_list_options {
 	int (*inode_getxattr)(struct dentry *dentry, const char *name);
 	int (*inode_listxattr)(struct dentry *dentry);
 	int (*inode_removexattr)(struct dentry *dentry, const char *name);
+	int (*inode_notify)(struct inode *inode, u64 mask);
 	int (*inode_need_killpriv)(struct dentry *dentry);
 	int (*inode_killpriv)(struct dentry *dentry);
 	int (*inode_getsecurity)(struct inode *inode, const char *name,
@@ -1881,6 +1882,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getxattr;
 	struct hlist_head inode_listxattr;
 	struct hlist_head inode_removexattr;
+	struct hlist_head inode_notify;
 	struct hlist_head inode_need_killpriv;
 	struct hlist_head inode_killpriv;
 	struct hlist_head inode_getsecurity;
diff --git a/include/linux/security.h b/include/linux/security.h
index 659071c2e57c..50106fb9eef9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -301,6 +301,7 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_inode_notify(struct inode *inode, u64 mask);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
@@ -392,6 +393,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -776,6 +778,11 @@ static inline int security_inode_removexattr(struct dentry *dentry,
 	return cap_inode_removexattr(dentry, name);
 }
 
+static inline int security_inode_notify(struct inode *inode, u64 mask)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index 613a5c00e602..57b2a96c1991 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1251,6 +1251,11 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 	return evm_inode_removexattr(dentry, name);
 }
 
+int security_inode_notify(struct inode *inode, u64 mask)
+{
+	return call_int_hook(inode_notify, 0, inode, mask);
+}
+
 int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return call_int_hook(inode_need_killpriv, 0, dentry);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..1a37966c2978 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -92,6 +92,7 @@
 #include <linux/kernfs.h>
 #include <linux/stringhash.h>	/* for hashlen_string() */
 #include <uapi/linux/mount.h>
+#include <linux/fsnotify.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -3261,6 +3262,26 @@ static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
 	return -EACCES;
 }
 
+static int selinux_inode_notify(struct inode *inode, u64 mask)
+{
+	u32 perm = FILE__WATCH; // basic permission, can a watch be set?
+
+	struct common_audit_data ad;
+
+	ad.type = LSM_AUDIT_DATA_INODE;
+	ad.u.inode = inode;
+
+	// check if the mask is requesting ability to set a blocking watch
+	if (mask & (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | FS_ACCESS_PERM))
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
@@ -6797,6 +6818,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecid, selinux_inode_getsecid),
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
+	LSM_HOOK_INIT(inode_notify, selinux_inode_notify),
 
 	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
 
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 201f7e588a29..0654dd2fbebf 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -7,7 +7,7 @@
 
 #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
     "rename", "execute", "quotaon", "mounton", "audit_access", \
-    "open", "execmod"
+	"open", "execmod", "watch", "watch_with_perm", "watch_reads"
 
 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
     "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
-- 
2.21.0

