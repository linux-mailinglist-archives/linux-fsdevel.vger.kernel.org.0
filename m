Return-Path: <linux-fsdevel+bounces-77108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPt3EvbijmluFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:38:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADB913420E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 09:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A3A6309B430
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 08:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819C33BBDD;
	Fri, 13 Feb 2026 08:37:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE433B97B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770971826; cv=none; b=o0oRdiXp46RFrLnrzBbtvV0AmN4Qv1IM99CYwk87q407Zu0m0BmfBAp05z/i/vJ4EJDJgatC4lxTXFsCuYWpvvlgPIQ5e1s7+F8LbnY6WJtlDAy9dGtksSNvfX1WLgtBP3ri1gRlGRqJ9LbTI6nQt7DwVtBXh2OIwE0G4lEzXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770971826; c=relaxed/simple;
	bh=W5nSCHtyOagL9TbmZ/SsnjQqUukBNpFvkPfMj2bk8h0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dcze/VFdwO/Z5jwqYYuSUlys5zVHKKEyRb0CAY78DPJ4aQn15qUtpqJBwoHyAFe8B8emh6Jvov/R+wpSGkzMgPBwKyo6tMEYEHbhC4J++PZNocu3T66Zo3M13q514ZDo9m8xfgpHT4xeTMG/aez3TY2GwdILbX3/7TH1bGQzGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2aadac3e23dso3063725ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 00:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770971823; x=1771576623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mduh9fE0R1vDyBqx3UYB0Vd0oIghTTV8wTMQqdMQTo=;
        b=dYioFFdmxXIJSniuS9h+EJORhMGA+N1JDQZpgz7Qdsl8YqB8R5Wr8OT+xTzWIXpp0B
         rvV11/BrgWg+AttlCZvVAFj2r+ty1uwWovdvNV9c+xNoYLA2pJHfNiobefU0EmwRcSzK
         7nOq57KoLobP7imyX2yXLeJ3pXA4ex0yHl6+MqN2QWv4RVa+EEJJ1rtewFLPVlrASMRx
         Zj/JoR069V4So/mGK78p0rt871ThhAOgG7Bcwj85/xvLb4NFM6bsFVBxm7MyjauDPzFh
         GJkHo5jUqzJQwcbEUGn/jqcr3Hm2bC8ojeus7dhGfikUoTozGYuSjhnzvKV1RyDBSKSD
         2Ilw==
X-Gm-Message-State: AOJu0Yxi5c8VIdsmy40oiRaD+XO1a6au23lZXDgUUEIciXdXz7f+DkGB
	j5ix53fXIgnLqq0oT06anpTLWKk2hKgB2+Pl8orNEx82ONpams/fjEhI
X-Gm-Gg: AZuq6aJFCtmhUGPJoe0WzFNHdvRYg9d5TQtHUO1eRhNHCNSOvXcHzdvqOvQGYS4S/iz
	8Kjcp90j4ZUj3rKhl3TiRwlYxYO5lw02QErN2vnwmAW6kee1PfBtQiGq4PKBQdzSe4jnwg9te5o
	lVkutZj0MrpUqo5WE7kNpFQBGs89K6lrorU34yW8W+q5o3jxQYYDtdQseaf1wc4ea7aHwUYPT6h
	Nt7vgC0i2MayEOxLzsBKhnCOQ/QMjzL5WLQTxy9cML/EELWx5TgcoYWjxrGuVvp46gp5mF+Iu7g
	lTTJHNycDk2CtZK/oRKOB/4/SILKy12x181YHjGPMfUa+1oBYN1EZP/vo9AJRe8uDdEVkndtoGr
	AIcmcmP+YzMUqLq78RBpdGDbEdfRHsIwonTIlrQcWq2aq6rVu67Dv8oHFQzy5nZPuEZksossAvV
	qp9KIG/vQIBF5PW2qYoHRiQ81xyfAEEDakq6/w8w==
X-Received: by 2002:a17:903:1b28:b0:2aa:e570:6e6d with SMTP id d9443c01a7336-2ab505a35b7mr12924105ad.40.1770971823351;
        Fri, 13 Feb 2026 00:37:03 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm75236495ad.6.2026.02.13.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 00:37:02 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	amir73il@gmail.com,
	xiang@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v9 14/17] ntfs3: remove legacy ntfs driver support
Date: Fri, 13 Feb 2026 17:18:01 +0900
Message-Id: <20260213081804.13351-15-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213081804.13351-1-linkinjeon@kernel.org>
References: <20260213081804.13351-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,lst.de,mit.edu,infradead.org,suse.cz,suse.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-77108-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9ADB913420E
X-Rspamd-Action: no action

Reverts the following commits that introduced legacy ntfs
driver alias and related support code:

74871791ffa9 ntfs3: serve as alias for the legacy ntfs driver
1ff2e956608c fs/ntfs3: Redesign legacy ntfs support
9b872cc50daa ntfs3: add legacy ntfs file operations
d55f90e9b243 ntfs3: enforce read-only when used as legacy ntfs driver

The legacy ntfs driver has been remade as a new implementation, so the
alias and related codes in ntfs3 are no longer needed.

Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs3/Kconfig   |  9 -------
 fs/ntfs3/dir.c     | 10 --------
 fs/ntfs3/file.c    | 11 ---------
 fs/ntfs3/inode.c   | 16 ++++---------
 fs/ntfs3/ntfs_fs.h | 11 ---------
 fs/ntfs3/super.c   | 59 +---------------------------------------------
 6 files changed, 5 insertions(+), 111 deletions(-)

diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
index 7bc31d69f680..cdfdf51e55d7 100644
--- a/fs/ntfs3/Kconfig
+++ b/fs/ntfs3/Kconfig
@@ -46,12 +46,3 @@ config NTFS3_FS_POSIX_ACL
 	  NOTE: this is linux only feature. Windows will ignore these ACLs.
 
 	  If you don't know what Access Control Lists are, say N.
-
-config NTFS_FS
-	tristate "NTFS file system support"
-	select NTFS3_FS
-	select BUFFER_HEAD
-	select NLS
-	help
-	  This config option is here only for backward compatibility. NTFS
-	  filesystem is now handled by the NTFS3 driver.
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 596f8c62f033..3eab8609bb6f 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -632,14 +632,4 @@ const struct file_operations ntfs_dir_operations = {
 #endif
 	.setlease	= generic_setlease,
 };
-
-#if IS_ENABLED(CONFIG_NTFS_FS)
-const struct file_operations ntfs_legacy_dir_operations = {
-	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
-	.iterate_shared	= ntfs_readdir,
-	.open		= ntfs_file_open,
-	.setlease	= generic_setlease,
-};
-#endif
 // clang-format on
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 6cb4479072a6..cc8cfbb6e1d6 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1480,15 +1480,4 @@ const struct file_operations ntfs_file_operations = {
 	.release	= ntfs_file_release,
 	.setlease	= generic_setlease,
 };
-
-#if IS_ENABLED(CONFIG_NTFS_FS)
-const struct file_operations ntfs_legacy_file_operations = {
-	.llseek		= generic_file_llseek,
-	.read_iter	= ntfs_file_read_iter,
-	.splice_read	= ntfs_file_splice_read,
-	.open		= ntfs_file_open,
-	.release	= ntfs_file_release,
-	.setlease	= generic_setlease,
-};
-#endif
 // clang-format on
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index edfb973e4e82..de1d6eaf179d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -444,9 +444,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		 * Usually a hard links to directories are disabled.
 		 */
 		inode->i_op = &ntfs_dir_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_dir_operations :
-				       &ntfs_dir_operations;
+		inode->i_fop = &ntfs_dir_operations;
 		ni->i_valid = 0;
 	} else if (S_ISLNK(mode)) {
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
@@ -456,9 +454,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	} else if (S_ISREG(mode)) {
 		ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
 		inode->i_op = &ntfs_file_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_file_operations :
-				       &ntfs_file_operations;
+		inode->i_fop = &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		if (ino != MFT_REC_MFT)
@@ -1590,9 +1586,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 
 	if (S_ISDIR(mode)) {
 		inode->i_op = &ntfs_dir_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_dir_operations :
-				       &ntfs_dir_operations;
+		inode->i_fop = &ntfs_dir_operations;
 	} else if (S_ISLNK(mode)) {
 		inode->i_op = &ntfs_link_inode_operations;
 		inode->i_fop = NULL;
@@ -1601,9 +1595,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		inode_nohighmem(inode);
 	} else if (S_ISREG(mode)) {
 		inode->i_op = &ntfs_file_inode_operations;
-		inode->i_fop = unlikely(is_legacy_ntfs(sb)) ?
-				       &ntfs_legacy_file_operations :
-				       &ntfs_file_operations;
+		inode->i_fop = &ntfs_file_operations;
 		inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
 							      &ntfs_aops;
 		init_rwsem(&ni->file.run_lock);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index f18349689458..93bec795b18a 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -502,7 +502,6 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 			   struct ntfs_fnd *fnd);
 bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;
-extern const struct file_operations ntfs_legacy_dir_operations;
 
 /* Globals from file.c */
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
@@ -517,7 +516,6 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg);
 extern const struct inode_operations ntfs_special_inode_operations;
 extern const struct inode_operations ntfs_file_inode_operations;
 extern const struct file_operations ntfs_file_operations;
-extern const struct file_operations ntfs_legacy_file_operations;
 
 /* Globals from frecord.c */
 void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi);
@@ -1161,13 +1159,4 @@ static inline void le64_sub_cpu(__le64 *var, u64 val)
 	*var = cpu_to_le64(le64_to_cpu(*var) - val);
 }
 
-#if IS_ENABLED(CONFIG_NTFS_FS)
-bool is_legacy_ntfs(struct super_block *sb);
-#else
-static inline bool is_legacy_ntfs(struct super_block *sb)
-{
-	return false;
-}
-#endif
-
 #endif /* _LINUX_NTFS3_NTFS_FS_H */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8b0cf0ed4f72..4e0448af3e7e 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -415,12 +415,6 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
 	struct ntfs_mount_options *new_opts = fc->fs_private;
 	int ro_rw;
 
-	/* If ntfs3 is used as legacy ntfs enforce read-only mode. */
-	if (is_legacy_ntfs(sb)) {
-		fc->sb_flags |= SB_RDONLY;
-		goto out;
-	}
-
 	ro_rw = sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY);
 	if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
 		errorf(fc,
@@ -447,7 +441,6 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
 		return -EINVAL;
 	}
 
-out:
 	sync_filesystem(sb);
 	swap(sbi->options, fc->fs_private);
 
@@ -1670,8 +1663,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	ntfs_create_procdir(sb);
 
-	if (is_legacy_ntfs(sb))
-		sb->s_flags |= SB_RDONLY;
 	return 0;
 
 put_inode_out:
@@ -1796,7 +1787,7 @@ static const struct fs_context_operations ntfs_context_ops = {
  * This will called when mount/remount. We will first initialize
  * options so that if remount we can use just that.
  */
-static int __ntfs_init_fs_context(struct fs_context *fc)
+static int ntfs_init_fs_context(struct fs_context *fc)
 {
 	struct ntfs_mount_options *opts;
 	struct ntfs_sb_info *sbi;
@@ -1850,11 +1841,6 @@ static int __ntfs_init_fs_context(struct fs_context *fc)
 	return -ENOMEM;
 }
 
-static int ntfs_init_fs_context(struct fs_context *fc)
-{
-	return __ntfs_init_fs_context(fc);
-}
-
 static void ntfs3_kill_sb(struct super_block *sb)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -1876,47 +1862,6 @@ static struct file_system_type ntfs_fs_type = {
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 
-#if IS_ENABLED(CONFIG_NTFS_FS)
-static int ntfs_legacy_init_fs_context(struct fs_context *fc)
-{
-	int ret;
-
-	ret = __ntfs_init_fs_context(fc);
-	/* If ntfs3 is used as legacy ntfs enforce read-only mode. */
-	fc->sb_flags |= SB_RDONLY;
-	return ret;
-}
-
-static struct file_system_type ntfs_legacy_fs_type = {
-	.owner			= THIS_MODULE,
-	.name			= "ntfs",
-	.init_fs_context	= ntfs_legacy_init_fs_context,
-	.parameters		= ntfs_fs_parameters,
-	.kill_sb		= ntfs3_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
-};
-MODULE_ALIAS_FS("ntfs");
-
-static inline void register_as_ntfs_legacy(void)
-{
-	int err = register_filesystem(&ntfs_legacy_fs_type);
-	if (err)
-		pr_warn("ntfs3: Failed to register legacy ntfs filesystem driver: %d\n", err);
-}
-
-static inline void unregister_as_ntfs_legacy(void)
-{
-	unregister_filesystem(&ntfs_legacy_fs_type);
-}
-bool is_legacy_ntfs(struct super_block *sb)
-{
-	return sb->s_type == &ntfs_legacy_fs_type;
-}
-#else
-static inline void register_as_ntfs_legacy(void) {}
-static inline void unregister_as_ntfs_legacy(void) {}
-#endif
-
 // clang-format on
 
 static int __init init_ntfs_fs(void)
@@ -1945,7 +1890,6 @@ static int __init init_ntfs_fs(void)
 		goto out1;
 	}
 
-	register_as_ntfs_legacy();
 	err = register_filesystem(&ntfs_fs_type);
 	if (err)
 		goto out;
@@ -1965,7 +1909,6 @@ static void __exit exit_ntfs_fs(void)
 	rcu_barrier();
 	kmem_cache_destroy(ntfs_inode_cachep);
 	unregister_filesystem(&ntfs_fs_type);
-	unregister_as_ntfs_legacy();
 	ntfs3_exit_bitmap();
 	ntfs_remove_proc_root();
 }
-- 
2.25.1


