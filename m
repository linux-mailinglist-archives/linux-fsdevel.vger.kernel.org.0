Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A8518431
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiECM1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiECM1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 08:27:07 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D08D344F2
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 05:23:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id be20so19627567edb.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 May 2022 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TE1k+xyihTMSWkSGzrDneVkAum46sMwYkJNJnhAJ764=;
        b=XyhJnktM7U2LlMZ7TisGrY3ZYOKepHADKspM0LQsbvVOn0BWP5LLxykI4JI7RZisns
         SdTvPSppnRAC9XndqSQl4Grl1zEqP6CWD5NgcATdrh044EoAzu1MBRGdAzdBmcdfKzPW
         BMbJ27IvW+Zc2Es3sW4c07lOWRYCbgyOY4VoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TE1k+xyihTMSWkSGzrDneVkAum46sMwYkJNJnhAJ764=;
        b=ANvaCzBlm0EO+MmkQGCL55Yi3HKeNcwNG7uVPLKZxLlCZF/jzoCl9Ha9vQf+aAILpG
         hJJ1dEaZvNjUrcJ0jWzrW5tqHsA33WOzcbFZ7OUQ1IN8yfkevacv5U0PdkM0vr2/Domd
         HFDgv4Lt9usMFY/M0XZR3p9Sg3jOzzKoiwzAf0VST0CuRAG07ELruJHalrTlac1/fY9C
         BiRA5MaNgnfXgexuvqMZTCwr6251mKF+wlp9719m5NZhRSjhfOXYeqz3kaAO3ZMRudUC
         r6rCjVSQxDUtLt+fNqA/pBf5gX8+WLDeZmwEAVYC7Te41u1/CwZxMaev1dZGDAZz6wOS
         dcQA==
X-Gm-Message-State: AOAM532CbiWe+God2gmtETq5nhc79K4FgNkqlHH8hqY2NdrXlf8+r4k+
        hqOW/IzsgbDYxcOD40qKQS6+iE8XOJiplrPG
X-Google-Smtp-Source: ABdhPJyidd0sNK3Dvs85E/mvMVYwF6knm8hinBxEIIcMNfcF+DOmOJKgvd2JlTGJ/5dOeoGxnT8HpA==
X-Received: by 2002:a50:c014:0:b0:41d:5ee9:f354 with SMTP id r20-20020a50c014000000b0041d5ee9f354mr17536367edb.257.1651580606617;
        Tue, 03 May 2022 05:23:26 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-178-48-189-3.catv.fixed.vodafone.hu. [178.48.189.3])
        by smtp.gmail.com with ESMTPSA id p14-20020a056402154e00b0042617ba63a8sm7742405edx.50.2022.05.03.05.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 05:23:25 -0700 (PDT)
Date:   Tue, 3 May 2022 14:23:23 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
        Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a simplification of the getvalues(2) prototype and moving it to the
getxattr(2) interface, as suggested by Dave.

The patch itself just adds the possibility to retrieve a single line of
/proc/$$/mountinfo (which was the basic requirement from which the fsinfo
patchset grew out of).

But this should be able to serve Amir's per-sb iostats, as well as a host of
other cases where some statistic needs to be retrieved from some object.  Note:
a filesystem object often represents other kinds of objects (such as processes
in /proc) so this is not limited to fs attributes.

This also opens up the interface to setting attributes via setxattr(2).

After some pondering I made the namespace so:

: - root
bar - an attribute
foo: - a folder (can contain attributes and/or folders)

The contents of a folder is represented by a null separated list of names.

Examples:

$ getfattr -etext -n ":" .
# file: .
:="mnt:\000mntns:"

$ getfattr -etext -n ":mnt:" .
# file: .
:mnt:="info"

$ getfattr -etext -n ":mnt:info" .
# file: .
:mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"

$ getfattr -etext -n ":mntns:" .
# file: .
:mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"

$ getfattr -etext -n ":mntns:28:" .
# file: .
:mntns:28:="info"

Comments?

Thanks,
Miklos

---
 fs/Makefile            |    2 
 fs/mount.h             |    8 +
 fs/namespace.c         |   15 ++-
 fs/pnode.h             |    2 
 fs/proc_namespace.c    |   15 ++-
 fs/values.c            |  242 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xattr.c             |   16 ++-
 include/linux/values.h |   11 ++
 8 files changed, 295 insertions(+), 16 deletions(-)

--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
-		kernel_read_file.o remap_range.o
+		kernel_read_file.o remap_range.o values.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o direct-io.o mpage.o
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -148,3 +148,11 @@ static inline bool is_anon_ns(struct mnt
 }
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
+
+struct mount *mnt_list_next(struct mnt_namespace *ns, struct list_head *p);
+extern void namespace_lock_read(void);
+extern void namespace_unlock_read(void);
+extern int show_mountinfo_root(struct seq_file *m, struct vfsmount *mnt,
+			       struct path *root);
+extern bool is_path_reachable(struct mount *, struct dentry *,
+			      const struct path *root);
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1332,9 +1332,7 @@ struct vfsmount *mnt_clone_internal(cons
 	return &p->mnt;
 }
 
-#ifdef CONFIG_PROC_FS
-static struct mount *mnt_list_next(struct mnt_namespace *ns,
-				   struct list_head *p)
+struct mount *mnt_list_next(struct mnt_namespace *ns, struct list_head *p)
 {
 	struct mount *mnt, *ret = NULL;
 
@@ -1351,6 +1349,7 @@ static struct mount *mnt_list_next(struc
 	return ret;
 }
 
+#ifdef CONFIG_PROC_FS
 /* iterator; we want it to have access to namespace_sem, thus here... */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
@@ -1507,6 +1506,16 @@ static inline void namespace_lock(void)
 	down_write(&namespace_sem);
 }
 
+void namespace_lock_read(void)
+{
+	down_read(&namespace_sem);
+}
+
+void namespace_unlock_read(void)
+{
+	up_read(&namespace_sem);
+}
+
 enum umount_tree_flags {
 	UMOUNT_SYNC = 1,
 	UMOUNT_PROPAGATE = 2,
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -50,7 +50,5 @@ void mnt_set_mountpoint(struct mount *,
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp,
 			   struct mount *mnt);
 struct mount *copy_tree(struct mount *, struct dentry *, int);
-bool is_path_reachable(struct mount *, struct dentry *,
-			 const struct path *root);
 int count_mounts(struct mnt_namespace *ns, struct mount *mnt);
 #endif /* _LINUX_PNODE_H */
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -132,9 +132,9 @@ static int show_vfsmnt(struct seq_file *
 	return err;
 }
 
-static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
+int show_mountinfo_root(struct seq_file *m, struct vfsmount *mnt,
+			struct path *root)
 {
-	struct proc_mounts *p = m->private;
 	struct mount *r = real_mount(mnt);
 	struct super_block *sb = mnt->mnt_sb;
 	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
@@ -152,7 +152,7 @@ static int show_mountinfo(struct seq_fil
 	seq_putc(m, ' ');
 
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
-	err = seq_path_root(m, &mnt_path, &p->root, " \t\n\\");
+	err = seq_path_root(m, &mnt_path, root, " \t\n\\");
 	if (err)
 		goto out;
 
@@ -164,7 +164,7 @@ static int show_mountinfo(struct seq_fil
 		seq_printf(m, " shared:%i", r->mnt_group_id);
 	if (IS_MNT_SLAVE(r)) {
 		int master = r->mnt_master->mnt_group_id;
-		int dom = get_dominating_id(r, &p->root);
+		int dom = get_dominating_id(r, root);
 		seq_printf(m, " master:%i", master);
 		if (dom && dom != master)
 			seq_printf(m, " propagate_from:%i", dom);
@@ -194,6 +194,13 @@ static int show_mountinfo(struct seq_fil
 	return err;
 }
 
+static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct proc_mounts *p = m->private;
+
+	return show_mountinfo_root(m, mnt, &p->root);
+}
+
 static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct proc_mounts *p = m->private;
--- /dev/null
+++ b/fs/values.c
@@ -0,0 +1,242 @@
+#include <linux/values.h>
+#include <linux/fs_struct.h>
+#include <linux/seq_file.h>
+#include <linux/nsproxy.h>
+#include "../lib/kstrtox.h"
+#include "mount.h"
+
+struct val_string {
+	const char *str;
+	size_t len;
+};
+
+struct val_iter {
+	struct val_string name;
+	struct seq_file seq;
+	int error;
+};
+
+struct val_desc {
+	struct val_string name;
+	union {
+		u64 idx;
+		int (*get)(struct val_iter *vi, const struct path *path);
+	};
+};
+
+#define VAL_STRING(x) { .str = x, .len = sizeof(x) - 1 }
+#define VD_NAME(x) .name = VAL_STRING(x)
+
+static int val_err(struct val_iter *vi, int err)
+{
+	vi->error = err;
+	return 0;
+}
+
+static int val_end_seq(struct val_iter *vi)
+{
+	if (vi->seq.count == vi->seq.size)
+		return -EOVERFLOW;
+
+	return 0;
+}
+
+static inline void val_string_skip(struct val_string *s, size_t count)
+{
+	WARN_ON(s->len < count);
+	s->str += count;
+	s->len -= count;
+}
+
+static bool val_string_prefix(const struct val_string *p,
+			      const struct val_string *s)
+{
+	return s->len >= p->len && !memcmp(s->str, p->str, p->len);
+}
+
+static struct val_desc *val_lookup(struct val_iter *vi, struct val_desc *vd)
+{
+	for (; vd->name.len; vd++) {
+		if (val_string_prefix(&vd->name, &vi->name)) {
+			val_string_skip(&vi->name, vd->name.len);
+			break;
+		}
+	}
+	return vd;
+}
+
+static int val_get_group(struct val_iter *vi, struct val_desc *vd)
+{
+	for (; vd->name.len; vd++)
+		seq_write(&vi->seq, vd->name.str, vd->name.len + 1);
+
+	return val_end_seq(vi);
+}
+
+enum {
+	VAL_MNT_INFO,
+};
+
+static struct val_desc val_mnt_group[] = {
+	{ VD_NAME("info"),		.idx = VAL_MNT_INFO		},
+	{ }
+};
+
+static int val_mnt_show(struct val_iter *vi, struct vfsmount *mnt)
+{
+	struct val_desc *vd = val_lookup(vi, val_mnt_group);
+	struct path root;
+
+	if (!vd->name.str)
+		return val_err(vi, -ENOENT);
+
+	switch(vd->idx) {
+	case VAL_MNT_INFO:
+		get_fs_root(current->fs, &root);
+		show_mountinfo_root(&vi->seq, mnt, &root);
+		path_put(&root);
+		break;
+	}
+
+	return 0;
+}
+
+static int val_mnt_get(struct val_iter *vi, const struct path *path)
+{
+	int err;
+
+	if (!vi->name.len)
+		return val_get_group(vi, val_mnt_group);
+
+	namespace_lock_read();
+	err = val_mnt_show(vi, path->mnt);
+	namespace_unlock_read();
+
+	return err;
+}
+
+/* called with namespace_sem held for read */
+static struct vfsmount *mnt_lookup_by_id(struct mnt_namespace *ns,
+					 struct path *root, int id)
+{
+	struct mount *m;
+
+	for (m = mnt_list_next(ns, &ns->list); m; m = mnt_list_next(ns, &m->mnt_list)) {
+		if (m->mnt_id == id) {
+			if (is_path_reachable(m, m->mnt.mnt_root, root))
+				return mntget(&m->mnt);
+			else
+				return NULL;
+		}
+	}
+	return NULL;
+}
+
+static void seq_mnt_list(struct seq_file *seq, struct mnt_namespace *ns,
+			 struct path *root)
+{
+	struct mount *m;
+
+	namespace_lock_read();
+	for (m = mnt_list_next(ns, &ns->list); m; m = mnt_list_next(ns, &m->mnt_list)) {
+		if (is_path_reachable(m, m->mnt.mnt_root, root)) {
+			seq_printf(seq, "%i:", m->mnt_id);
+			seq_putc(seq, '\0');
+		}
+	}
+	namespace_unlock_read();
+}
+
+static int val_mntns_get(struct val_iter *vi, const struct path *path)
+{
+	struct mnt_namespace *mnt_ns = current->nsproxy->mnt_ns;
+	struct vfsmount *mnt;
+	struct path root;
+	unsigned long long mnt_id;
+	unsigned int end;
+	int err;
+
+	if (!vi->name.len) {
+		get_fs_root(current->fs, &root);
+		seq_mnt_list(&vi->seq, mnt_ns, &root);
+		path_put(&root);
+		return val_end_seq(vi);
+	}
+
+	end = _parse_integer(vi->name.str, 10, &mnt_id);
+	if (end & KSTRTOX_OVERFLOW)
+		return val_err(vi, -ENOENT);
+	if (vi->name.str[end] != VAL_SEP)
+		return val_err(vi, -ENOENT);
+	val_string_skip(&vi->name, end + 1);
+
+	namespace_lock_read();
+	get_fs_root(current->fs, &root);
+	mnt = mnt_lookup_by_id(mnt_ns, &root, mnt_id);
+	path_put(&root);
+	if (!mnt) {
+		namespace_unlock_read();
+		return val_err(vi, -ENOENT);
+	}
+	if (vi->name.len)
+		err = val_mnt_show(vi, mnt);
+	else
+		err = val_get_group(vi, val_mnt_group);
+
+	namespace_unlock_read();
+	mntput(mnt);
+
+	return err;
+}
+
+
+
+static struct val_desc val_toplevel_group[] = {
+	{ VD_NAME("mnt:"),	.get = val_mnt_get,	},
+	{ VD_NAME("mntns:"),	.get = val_mntns_get,	},
+	{ },
+};
+
+static int getvalues(struct val_iter *vi, const struct path *path)
+{
+	struct val_desc *vd;
+	int err;
+
+	if (!vi->name.len)
+		return val_get_group(vi, val_toplevel_group);
+
+	vd = val_lookup(vi, val_toplevel_group);
+	if (!vd->name.len)
+		err = val_err(vi, -ENOENT);
+	else
+		err = vd->get(vi, path);
+
+	return err ?: vi->error;
+}
+
+ssize_t val_getxattr(struct path *path, const char *name, size_t namelen,
+		     void __user *value, size_t size)
+{
+	int err;
+	char val[1024];
+	struct val_iter vi = {
+		.name = { .str = name, .len = namelen },
+		.seq = { .buf = val, .size = min(sizeof(val), size) },
+	};
+
+	if (!size)
+		return sizeof(val);
+
+	val_string_skip(&vi.name, 1);
+
+	err = getvalues(&vi, path);
+	if (err < 0)
+		return err;
+
+	WARN_ON(vi.seq.count > size);
+	if (copy_to_user(value, vi.seq.buf, vi.seq.count))
+		return -EFAULT;
+
+	return vi.seq.count;
+}
+
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -22,6 +22,7 @@
 #include <linux/audit.h>
 #include <linux/vmalloc.h>
 #include <linux/posix_acl_xattr.h>
+#include <linux/values.h>
 
 #include <linux/uaccess.h>
 
@@ -643,12 +644,13 @@ SYSCALL_DEFINE5(fsetxattr, int, fd, cons
  * Extended attribute GET operations
  */
 static ssize_t
-getxattr(struct user_namespace *mnt_userns, struct dentry *d,
-	 const char __user *name, void __user *value, size_t size)
+getxattr(struct path *path, const char __user *name,
+	 void __user *value, size_t size)
 {
 	ssize_t error;
 	void *kvalue = NULL;
 	char kname[XATTR_NAME_MAX + 1];
+	struct user_namespace *mnt_userns = mnt_user_ns(path->mnt);
 
 	error = strncpy_from_user(kname, name, sizeof(kname));
 	if (error == 0 || error == sizeof(kname))
@@ -656,6 +658,9 @@ getxattr(struct user_namespace *mnt_user
 	if (error < 0)
 		return error;
 
+	if (kname[0] == VAL_SEP)
+		return val_getxattr(path, kname, error, value, size);
+
 	if (size) {
 		if (size > XATTR_SIZE_MAX)
 			size = XATTR_SIZE_MAX;
@@ -664,7 +669,7 @@ getxattr(struct user_namespace *mnt_user
 			return -ENOMEM;
 	}
 
-	error = vfs_getxattr(mnt_userns, d, kname, kvalue, size);
+	error = vfs_getxattr(mnt_userns, path->dentry, kname, kvalue, size);
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
@@ -693,7 +698,7 @@ static ssize_t path_getxattr(const char
 	error = user_path_at(AT_FDCWD, pathname, lookup_flags, &path);
 	if (error)
 		return error;
-	error = getxattr(mnt_user_ns(path.mnt), path.dentry, name, value, size);
+	error = getxattr(&path, name, value, size);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -723,8 +728,7 @@ SYSCALL_DEFINE4(fgetxattr, int, fd, cons
 	if (!f.file)
 		return error;
 	audit_file(f.file);
-	error = getxattr(file_mnt_user_ns(f.file), f.file->f_path.dentry,
-			 name, value, size);
+	error = getxattr(&f.file->f_path, name, value, size);
 	fdput(f);
 	return error;
 }
--- /dev/null
+++ b/include/linux/values.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/types.h>
+
+#define VAL_SEP ':'
+
+struct path;
+
+ssize_t val_getxattr(struct path *path, const char *name, size_t namelen,
+		     void __user *value, size_t size);
+
