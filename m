Return-Path: <linux-fsdevel+bounces-1175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1DC7D6DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA45281DEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BB728E07;
	Wed, 25 Oct 2023 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQRkPIW0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05628E01
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:02:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113D5D5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698242556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XEx2f+3WyjfEN8nno/L3GWupAAdRJt4O0xkLy6vl9ko=;
	b=GQRkPIW0vpmcAzdgGeNrqFcR3d5SBjsJA2ne+zNlQavgDcjaunfUfcw4EefY6Xur9KOUoV
	mA39vhq+r6oAGAg8gBQkhoApdgUS5Poqi/mZr4oGGLJScLdl2IZeazXYIpZbYUGQLJ87pL
	p40QS/PRTvaIGvIwx08QeWIlGAVPf6Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-w-WDITc0PDiYBlzVJB0TzA-1; Wed, 25 Oct 2023 10:02:15 -0400
X-MC-Unique: w-WDITc0PDiYBlzVJB0TzA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c983b42c3bso96765766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242534; x=1698847334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEx2f+3WyjfEN8nno/L3GWupAAdRJt4O0xkLy6vl9ko=;
        b=wJh+io55VhmTad7uMsovsrwu6VWW8h+sACSN0Or0QBGTmKyRNXTMGNMbzZvSr+qF1x
         h8m+jH7FKRqX5QVKUpBQsCK78D4rqk8m3qMEBB7tY5YMu2dUhinOA4wN9xo5FdjD96G/
         TUipogJ5gGSMobiaRjglaMnfjbxxHypbpeB148pgIW5iGwGDVOvajKePN8tMm0SsGFt9
         +mYV16hbuN6CT3PLWUFFg4t+uD+jlNBuVm6w6K2EQrcBTA3AHUkivwXYmPZqaiW2DhXp
         EP+zP3SdQpVjP1MfZUm4UgX5D17lFR4mA/zOTIaQuC+HUOyVwCqkzBBCnDOY1rTv7ewm
         OHYQ==
X-Gm-Message-State: AOJu0YxNimGxxo1acHk3r02AdyvXAtG3H9yWm1Ka8yDOYc1ULafBnlRd
	odk8qMkr9OE0EwdOm5Godz3UI4txVLzfSZ4u9cVqsMbWM6WJ3DSk+wt159Nnd7Op7y+PUPVT7iF
	eYZINi5RPs7DZfgpY3I6mPzYB7KKRAtoM5OkNJzhPsmqwKwWYssp3TL2InHejjZ5elXIqucLtoS
	lrURDmmRTjPA==
X-Received: by 2002:a17:907:97cc:b0:9a5:9f3c:961e with SMTP id js12-20020a17090797cc00b009a59f3c961emr14833605ejc.18.1698242533518;
        Wed, 25 Oct 2023 07:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmce8EbgYDdhdsywUowDHi/7yLCcYQCCY7TtCnZTLmu1xGtDmupYnM1RFd/HemJA2KX7UkXg==
X-Received: by 2002:a17:907:97cc:b0:9a5:9f3c:961e with SMTP id js12-20020a17090797cc00b009a59f3c961emr14833549ejc.18.1698242532906;
        Wed, 25 Oct 2023 07:02:12 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:12 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <christian@brauner.io>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew House <mattlloydhouse@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 4/6] add statmount(2) syscall
Date: Wed, 25 Oct 2023 16:02:02 +0200
Message-ID: <20231025140205.3586473-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a way to query attributes of a single mount instead of having to parse
the complete /proc/$PID/mountinfo, which might be huge.

Lookup the mount the new 64bit mount ID.  If a mount needs to be queried
based on path, then statx(2) can be used to first query the mount ID
belonging to the path.

Design is based on a suggestion by Linus:

  "So I'd suggest something that is very much like "statfsat()", which gets
   a buffer and a length, and returns an extended "struct statfs" *AND*
   just a string description at the end."

The interface closely mimics that of statx.

Handle ASCII attributes by appending after the end of the structure (as per
above suggestion).  Pointers to strings are stored in u64 members to make
the structure the same regardless of pointer size.  Strings are nul
terminated.

Link: https://lore.kernel.org/all/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 277 +++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h   |   5 +
 include/uapi/linux/mount.h |  56 ++++++++
 3 files changed, 338 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7a33ea391a02..a980c250a3a6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4681,6 +4681,283 @@ int show_path(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+static struct vfsmount *lookup_mnt_in_ns(u64 id, struct mnt_namespace *ns)
+{
+	struct mount *mnt = mnt_find_id_at(ns, id);
+
+	if (!mnt || mnt->mnt_id_unique != id)
+		return NULL;
+
+	return &mnt->mnt;
+}
+
+struct stmt_state {
+	struct statmnt __user *const buf;
+	size_t const bufsize;
+	struct vfsmount *const mnt;
+	u64 const mask;
+	struct seq_file seq;
+	struct path root;
+	struct statmnt sm;
+	size_t pos;
+	int err;
+};
+
+typedef int (*stmt_func_t)(struct stmt_state *);
+
+static int stmt_string_seq(struct stmt_state *s, stmt_func_t func)
+{
+	size_t rem = s->bufsize - s->pos - sizeof(s->sm);
+	struct seq_file *seq = &s->seq;
+	int ret;
+
+	seq->count = 0;
+	seq->size = min(seq->size, rem);
+	seq->buf = kvmalloc(seq->size, GFP_KERNEL_ACCOUNT);
+	if (!seq->buf)
+		return -ENOMEM;
+
+	ret = func(s);
+	if (ret)
+		return ret;
+
+	if (seq_has_overflowed(seq)) {
+		if (seq->size == rem)
+			return -EOVERFLOW;
+		seq->size *= 2;
+		if (seq->size > MAX_RW_COUNT)
+			return -ENOMEM;
+		kvfree(seq->buf);
+		return 0;
+	}
+
+	/* Done */
+	return 1;
+}
+
+static void stmt_string(struct stmt_state *s, u64 mask, stmt_func_t func,
+		       u32 *str)
+{
+	int ret = s->pos + sizeof(s->sm) >= s->bufsize ? -EOVERFLOW : 0;
+	struct statmnt *sm = &s->sm;
+	struct seq_file *seq = &s->seq;
+
+	if (s->err || !(s->mask & mask))
+		return;
+
+	seq->size = PAGE_SIZE;
+	while (!ret)
+		ret = stmt_string_seq(s, func);
+
+	if (ret < 0) {
+		s->err = ret;
+	} else {
+		seq->buf[seq->count++] = '\0';
+		if (copy_to_user(s->buf->str + s->pos, seq->buf, seq->count)) {
+			s->err = -EFAULT;
+		} else {
+			*str = s->pos;
+			s->pos += seq->count;
+		}
+	}
+	kvfree(seq->buf);
+	sm->mask |= mask;
+}
+
+static void stmt_numeric(struct stmt_state *s, u64 mask, stmt_func_t func)
+{
+	if (s->err || !(s->mask & mask))
+		return;
+
+	s->err = func(s);
+	s->sm.mask |= mask;
+}
+
+static u64 mnt_to_attr_flags(struct vfsmount *mnt)
+{
+	unsigned int mnt_flags = READ_ONCE(mnt->mnt_flags);
+	u64 attr_flags = 0;
+
+	if (mnt_flags & MNT_READONLY)
+		attr_flags |= MOUNT_ATTR_RDONLY;
+	if (mnt_flags & MNT_NOSUID)
+		attr_flags |= MOUNT_ATTR_NOSUID;
+	if (mnt_flags & MNT_NODEV)
+		attr_flags |= MOUNT_ATTR_NODEV;
+	if (mnt_flags & MNT_NOEXEC)
+		attr_flags |= MOUNT_ATTR_NOEXEC;
+	if (mnt_flags & MNT_NODIRATIME)
+		attr_flags |= MOUNT_ATTR_NODIRATIME;
+	if (mnt_flags & MNT_NOSYMFOLLOW)
+		attr_flags |= MOUNT_ATTR_NOSYMFOLLOW;
+
+	if (mnt_flags & MNT_NOATIME)
+		attr_flags |= MOUNT_ATTR_NOATIME;
+	else if (mnt_flags & MNT_RELATIME)
+		attr_flags |= MOUNT_ATTR_RELATIME;
+	else
+		attr_flags |= MOUNT_ATTR_STRICTATIME;
+
+	if (is_idmapped_mnt(mnt))
+		attr_flags |= MOUNT_ATTR_IDMAP;
+
+	return attr_flags;
+}
+
+static u64 mnt_to_propagation_flags(struct mount *m)
+{
+	u64 propagation = 0;
+
+	if (IS_MNT_SHARED(m))
+		propagation |= MS_SHARED;
+	if (IS_MNT_SLAVE(m))
+		propagation |= MS_SLAVE;
+	if (IS_MNT_UNBINDABLE(m))
+		propagation |= MS_UNBINDABLE;
+	if (!propagation)
+		propagation |= MS_PRIVATE;
+
+	return propagation;
+}
+
+static int stmt_sb_basic(struct stmt_state *s)
+{
+	struct super_block *sb = s->mnt->mnt_sb;
+
+	s->sm.sb_dev_major = MAJOR(sb->s_dev);
+	s->sm.sb_dev_minor = MINOR(sb->s_dev);
+	s->sm.sb_magic = sb->s_magic;
+	s->sm.sb_flags = sb->s_flags & (SB_RDONLY|SB_SYNCHRONOUS|SB_DIRSYNC|SB_LAZYTIME);
+
+	return 0;
+}
+
+static int stmt_mnt_basic(struct stmt_state *s)
+{
+	struct mount *m = real_mount(s->mnt);
+
+	s->sm.mnt_id = m->mnt_id_unique;
+	s->sm.mnt_parent_id = m->mnt_parent->mnt_id_unique;
+	s->sm.mnt_id_old = m->mnt_id;
+	s->sm.mnt_parent_id_old = m->mnt_parent->mnt_id;
+	s->sm.mnt_attr = mnt_to_attr_flags(&m->mnt);
+	s->sm.mnt_propagation = mnt_to_propagation_flags(m);
+	s->sm.mnt_peer_group = IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
+	s->sm.mnt_master = IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_id : 0;
+
+	return 0;
+}
+
+static int stmt_propagate_from(struct stmt_state *s)
+{
+	struct mount *m = real_mount(s->mnt);
+
+	if (!IS_MNT_SLAVE(m))
+		return 0;
+
+	s->sm.propagate_from = get_dominating_id(m, &current->fs->root);
+
+	return 0;
+}
+
+static int stmt_mnt_root(struct stmt_state *s)
+{
+	struct seq_file *seq = &s->seq;
+	int err = show_path(seq, s->mnt->mnt_root);
+
+	if (!err && !seq_has_overflowed(seq)) {
+		seq->buf[seq->count] = '\0';
+		seq->count = string_unescape_inplace(seq->buf, UNESCAPE_OCTAL);
+	}
+	return err;
+}
+
+static int stmt_mnt_point(struct stmt_state *s)
+{
+	struct vfsmount *mnt = s->mnt;
+	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
+	int err = seq_path_root(&s->seq, &mnt_path, &s->root, "");
+
+	return err == SEQ_SKIP ? 0 : err;
+}
+
+static int stmt_fs_type(struct stmt_state *s)
+{
+	struct seq_file *seq = &s->seq;
+	struct super_block *sb = s->mnt->mnt_sb;
+
+	seq_puts(seq, sb->s_type->name);
+	return 0;
+}
+
+static int do_statmount(struct stmt_state *s)
+{
+	struct statmnt *sm = &s->sm;
+	struct mount *m = real_mount(s->mnt);
+	size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));
+	int err;
+
+	err = security_sb_statfs(s->mnt->mnt_root);
+	if (err)
+		return err;
+
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !is_path_reachable(m, m->mnt.mnt_root, &s->root))
+		return -EPERM;
+
+	stmt_numeric(s, STMT_SB_BASIC, stmt_sb_basic);
+	stmt_numeric(s, STMT_MNT_BASIC, stmt_mnt_basic);
+	stmt_numeric(s, STMT_PROPAGATE_FROM, stmt_propagate_from);
+	stmt_string(s, STMT_FS_TYPE, stmt_fs_type, &sm->fs_type);
+	stmt_string(s, STMT_MNT_ROOT, stmt_mnt_root, &sm->mnt_root);
+	stmt_string(s, STMT_MNT_POINT, stmt_mnt_point, &sm->mnt_point);
+
+	if (s->err)
+		return s->err;
+
+	/* Return the number of bytes copied to the buffer */
+	sm->size = copysize + s->pos;
+
+	if (copy_to_user(s->buf, sm, copysize))
+		return -EFAULT;
+
+	return 0;
+}
+
+SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
+		struct statmnt __user *, buf, size_t, bufsize,
+		unsigned int, flags)
+{
+	struct vfsmount *mnt;
+	struct __mount_arg kreq;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (copy_from_user(&kreq, req, sizeof(kreq)))
+		return -EFAULT;
+
+	down_read(&namespace_sem);
+	mnt = lookup_mnt_in_ns(kreq.mnt_id, current->nsproxy->mnt_ns);
+	ret = -ENOENT;
+	if (mnt) {
+		struct stmt_state s = {
+			.mask = kreq.request_mask,
+			.buf = buf,
+			.bufsize = bufsize,
+			.mnt = mnt,
+		};
+
+		get_fs_root(current->fs, &s.root);
+		ret = do_statmount(&s);
+		path_put(&s.root);
+	}
+	up_read(&namespace_sem);
+
+	return ret;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc147f8..ba371024d902 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -74,6 +74,8 @@ struct landlock_ruleset_attr;
 enum landlock_rule_type;
 struct cachestat_range;
 struct cachestat;
+struct statmnt;
+struct __mount_arg;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -408,6 +410,9 @@ asmlinkage long sys_statfs64(const char __user *path, size_t sz,
 asmlinkage long sys_fstatfs(unsigned int fd, struct statfs __user *buf);
 asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 				struct statfs64 __user *buf);
+asmlinkage long sys_statmount(const struct __mount_arg __user *req,
+			      struct statmnt __user *buf, size_t bufsize,
+			      unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index bb242fdcfe6b..d2c988ab526b 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -138,4 +138,60 @@ struct mount_attr {
 /* List of all mount_attr versions. */
 #define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
 
+
+/*
+ * Structure for getting mount/superblock/filesystem info with statmount(2).
+ *
+ * The interface is similar to statx(2): individual fields or groups can be
+ * selected with the @mask argument of statmount().  Kernel will set the @mask
+ * field according to the supported fields.
+ *
+ * If string fields are selected, then the caller needs to pass a buffer that
+ * has space after the fixed part of the structure.  Nul terminated strings are
+ * copied there and offsets relative to @str are stored in the relevant fields.
+ * If the buffer is too small, then EOVERFLOW is returned.  The actually used
+ * size is returned in @size.
+ */
+struct statmnt {
+	__u32 size;		/* Total size, including strings */
+	__u32 __spare1;
+	__u64 mask;		/* What results were written */
+	__u32 sb_dev_major;	/* Device ID */
+	__u32 sb_dev_minor;
+	__u64 sb_magic;		/* ..._SUPER_MAGIC */
+	__u32 sb_flags;		/* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
+	__u32 fs_type;		/* [str] Filesystem type */
+	__u64 mnt_id;		/* Unique ID of mount */
+	__u64 mnt_parent_id;	/* Unique ID of parent (for root == mnt_id) */
+	__u32 mnt_id_old;	/* Reused IDs used in proc/.../mountinfo */
+	__u32 mnt_parent_id_old;
+	__u64 mnt_attr;		/* MOUNT_ATTR_... */
+	__u64 mnt_propagation;	/* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
+	__u64 mnt_peer_group;	/* ID of shared peer group */
+	__u64 mnt_master;	/* Mount receives propagation from this ID */
+	__u64 propagate_from;	/* Propagation from in current namespace */
+	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
+	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
+	__u64 __spare2[50];
+	char str[];		/* Variable size part containing strings */
+};
+
+/*
+ * To be used on the kernel ABI only for passing 64bit arguments to statmount(2)
+ */
+struct __mount_arg {
+	__u64 mnt_id;
+	__u64 request_mask;
+};
+
+/*
+ * @mask bits for statmount(2)
+ */
+#define STMT_SB_BASIC		0x00000001U     /* Want/got sb_... */
+#define STMT_MNT_BASIC		0x00000002U	/* Want/got mnt_... */
+#define STMT_PROPAGATE_FROM	0x00000004U	/* Want/got propagate_from */
+#define STMT_MNT_ROOT		0x00000008U	/* Want/got mnt_root  */
+#define STMT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
+#define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.41.0


