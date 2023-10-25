Return-Path: <linux-fsdevel+bounces-1172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA2C7D6DF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D922B281DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 14:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DC228E0D;
	Wed, 25 Oct 2023 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbosK9Rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00D28E01
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 14:02:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC4F1B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698242543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bwGq/C+5APOsCqFrwpf0XoGoPuUJR4+QLSXHx9atCw=;
	b=LbosK9Rw7pwGZE6yeUZloVzMpDUjE31R+wRGDFnM8OEKtZa0vb98Z9KtaBGt46NjobP5Ht
	aX+6WFmaK3LgnMy9j1lXy2WCS0/r6pZi5cY0bfk8o8eadsWnZySSf4Z/XUJ1P6K3/BMFeX
	QEBS1APW5iJ5TQvxvLhPuZIcWjtdYXs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-OONb5JzCNwG2661wPR2G4g-1; Wed, 25 Oct 2023 10:02:17 -0400
X-MC-Unique: OONb5JzCNwG2661wPR2G4g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso288779466b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242535; x=1698847335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bwGq/C+5APOsCqFrwpf0XoGoPuUJR4+QLSXHx9atCw=;
        b=BVqSpEhe0aFIPh7AmEbVylxglr3CeLwhFoXgbVy/fSUk+/SBgoM6s/b8/20fyFTWn3
         tPehlekuqBBUu8TtiK0MPt4vI23k3A7+qXACHGm9QHIiO9uvSnnGoTMQ6JcZW+022GIN
         qk27rf79CJnt6HCTW5nTpzEuLk/uDr2A+LPHGebhL9vi5rugU9LTNTxsj8fWCugVgkw2
         CKfqwHgeXw8i2ar/FZtcEn4PzA8Hsbe5T7xr5A/HbpA4WGabxP4sdReMIlW8ki+SKV36
         AUhJQ3qLIaZpmyqGveoWJHm3bf5Gx3JOS2k3vPnEau2UuL77ZNdQIQMwiYvbtvrzDNUH
         e21Q==
X-Gm-Message-State: AOJu0Yz+OWks9nAnxVf7cl42llE/ar0wTyU3aAvXUGcXKtlW+9l9UNmh
	zyaqcPTlgNCg13bZm6wpu0vCiVcIC9H4jgKqEzLR/3/kBfkBd0WMQWByZydtidZqmF3tKMjBMkU
	S8+CttpfaV/A6Z0N/n1KjgSJbNY1JCnzAd00YJES6MvO2DZCkrdzm01Jq1H85r3hynQgua/0IWd
	v3yS4rl5qHhQ==
X-Received: by 2002:a17:906:3e54:b0:9c3:bb0e:d4c7 with SMTP id t20-20020a1709063e5400b009c3bb0ed4c7mr9498302eji.28.1698242535443;
        Wed, 25 Oct 2023 07:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP25qBhJxT4qXiqjdZQb/HVco5wkgj/lhRNtDMYF4zMn2TOmKwTlFkjQyOsrNX64rUB3w+YQ==
X-Received: by 2002:a17:906:3e54:b0:9c3:bb0e:d4c7 with SMTP id t20-20020a1709063e5400b009c3bb0ed4c7mr9498262eji.28.1698242534928;
        Wed, 25 Oct 2023 07:02:14 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:13 -0700 (PDT)
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
Subject: [PATCH v4 5/6] add listmount(2) syscall
Date: Wed, 25 Oct 2023 16:02:03 +0200
Message-ID: <20231025140205.3586473-6-mszeredi@redhat.com>
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

Add way to query the children of a particular mount.  This is a more
flexible way to iterate the mount tree than having to parse the complete
/proc/self/mountinfo.

Allow listing either

 - immediate child mounts only, or

 - recursively all descendant mounts (depth first).

Lookup the mount by the new 64bit mount ID.  If a mount needs to be queried
based on path, then statx(2) can be used to first query the mount ID
belonging to the path.

Return an array of new (64bit) mount ID's.  Without privileges only mounts
are listed which are reachable from the task's root.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 93 ++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h   |  3 ++
 include/uapi/linux/mount.h |  9 ++++
 3 files changed, 105 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index a980c250a3a6..0afe2344bba6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4958,6 +4958,99 @@ SYSCALL_DEFINE4(statmount, const struct __mount_arg __user *, req,
 	return ret;
 }
 
+static struct mount *listmnt_first(struct mount *root)
+{
+	return list_first_entry_or_null(&root->mnt_mounts, struct mount, mnt_child);
+}
+
+static struct mount *listmnt_next(struct mount *curr, struct mount *root, bool recurse)
+{
+	if (recurse)
+		return next_mnt(curr, root);
+	if (!list_is_head(curr->mnt_child.next, &root->mnt_mounts))
+		return list_next_entry(curr, mnt_child);
+	return NULL;
+}
+
+static long do_listmount(struct vfsmount *mnt, u64 __user *buf, size_t bufsize,
+			 const struct path *root, unsigned int flags)
+{
+	struct mount *r, *m = real_mount(mnt);
+	struct path rootmnt = {
+		.mnt = root->mnt,
+		.dentry = root->mnt->mnt_root
+	};
+	long ctr = 0;
+	bool reachable_only = true;
+	bool recurse = flags & LISTMOUNT_RECURSIVE;
+	int err;
+
+	err = security_sb_statfs(mnt->mnt_root);
+	if (err)
+		return err;
+
+	if (flags & LISTMOUNT_UNREACHABLE) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		reachable_only = false;
+	}
+
+	if (reachable_only && !is_path_reachable(m, mnt->mnt_root, &rootmnt))
+		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
+
+	for (r = listmnt_first(m); r; r = listmnt_next(r, m, recurse)) {
+		if (reachable_only &&
+		    !is_path_reachable(r, r->mnt.mnt_root, root))
+			continue;
+
+		if (ctr >= bufsize)
+			return -EOVERFLOW;
+		if (put_user(r->mnt_id_unique, buf + ctr))
+			return -EFAULT;
+		ctr++;
+		if (ctr < 0)
+			return -ERANGE;
+	}
+	return ctr;
+}
+
+SYSCALL_DEFINE4(listmount, const struct __mount_arg __user *, req,
+		u64 __user *, buf, size_t, bufsize, unsigned int, flags)
+{
+	struct __mount_arg kreq;
+	struct vfsmount *mnt;
+	struct path root;
+	u64 mnt_id;
+	long err;
+
+	if (flags & ~(LISTMOUNT_UNREACHABLE | LISTMOUNT_RECURSIVE))
+		return -EINVAL;
+
+	if (copy_from_user(&kreq, req, sizeof(kreq)))
+		return -EFAULT;
+	mnt_id = kreq.mnt_id;
+
+	down_read(&namespace_sem);
+	if (mnt_id == LSMT_ROOT)
+		mnt = &current->nsproxy->mnt_ns->root->mnt;
+	else
+		mnt = lookup_mnt_in_ns(mnt_id, current->nsproxy->mnt_ns);
+
+	err = -ENOENT;
+	if (mnt) {
+		get_fs_root(current->fs, &root);
+		/* Skip unreachable for LSMT_ROOT */
+		if (mnt_id == LSMT_ROOT && !(flags & LISTMOUNT_UNREACHABLE))
+			mnt = root.mnt;
+		err = do_listmount(mnt, buf, bufsize, &root, flags);
+		path_put(&root);
+	}
+	up_read(&namespace_sem);
+
+	return err;
+}
+
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index ba371024d902..38f3da7e04d1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -413,6 +413,9 @@ asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
 asmlinkage long sys_statmount(const struct __mount_arg __user *req,
 			      struct statmnt __user *buf, size_t bufsize,
 			      unsigned int flags);
+asmlinkage long sys_listmount(const struct __mount_arg __user *req,
+			      u64 __user *buf, size_t bufsize,
+			      unsigned int flags);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index d2c988ab526b..704c408cc662 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -194,4 +194,13 @@ struct __mount_arg {
 #define STMT_MNT_POINT		0x00000010U	/* Want/got mnt_point */
 #define STMT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 
+/* listmount(2) flags */
+#define LISTMOUNT_UNREACHABLE	0x01	/* List unreachable mounts too */
+#define LISTMOUNT_RECURSIVE	0x02	/* List a mount tree */
+
+/*
+ * Special @mnt_id values that can be passed to listmount
+ */
+#define LSMT_ROOT		0xffffffffffffffff	/* root mount */
+
 #endif /* _UAPI_LINUX_MOUNT_H */
-- 
2.41.0


