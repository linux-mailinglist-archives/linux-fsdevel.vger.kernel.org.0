Return-Path: <linux-fsdevel+bounces-76286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN9DBCgJg2lLgwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:54:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB60E359A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C3FC301CFB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487A139A7FA;
	Wed,  4 Feb 2026 08:51:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E172C39A7EA
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195085; cv=none; b=LuNM8tMjBYdgq4bMyb0vqs0FZf2Cqde/vZOX+seeFxiWfjkFWbAKacpFE5KPhSZNd+MgwGjnXcJaOcyG8lJA8uJXC3aagdUhprhLVnH74vmJBtKn6QEHkIEOHY2qn76OxXzF+NRst1sG6tZzSqigllBMnFTR2yQKvU75ZcT8Tb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195085; c=relaxed/simple;
	bh=FtGAImhGqEhVtX0zHRa7DJU+z6h9tTp2OGcS6JMiljQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X47kRpjo/9uCzHZbm5TzLmyKwsXXGCbKvnqE8Dhwm+XrzVCj55z0gbcRusUnhto7r9YC8Jp6p4ulbee4WOG3ifiKZNw2p5WsqEFXrEnbqngCoKEEkz6s3XR+29/FItOo3wJ2YQvx8XtfzvsFgJ1r0Ahh6JTwXx2Pl2KvaYn0qbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4252426a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Feb 2026 00:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770195084; x=1770799884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCAfHrSfR18VntHAODdOnFSa464mI2bSCdLh2YJx6jQ=;
        b=UGTEhVbWy9t0WMMxOeNwHj4sZ52Ayb70uiM7/qu1JSPmX/+y/yif+koyJi4flK7Fr/
         ZiPxANpBoP3IYMIulm/fn3rHdLtKsYEVPMgDOZr4Jfetlg/AqvogRslxRNmZYSuQe5Hu
         IPEP9T0WThdZY/2HXjE4+yaAeun+K4xaAtkhNpKyOaDTVAtM1hE931AYDbeMGT+nLD7a
         j0uNRg3lsZNtRQ0Rb/ML5pejONXLJL7zthYdPkm9sXhBjcpNYDIP6tZ7ohe7vy8+crZw
         xPXrmc3q1k51Q2AKGW5muE0xvkaHZUTmKj1Bjl8WJ53f03TFe1UtIIQtCBtUmug1dbNG
         aJKQ==
X-Gm-Message-State: AOJu0Yw2fkPlOaXSqae+nbTkbyPMur+z2MDwbhxF2RfA3SPn74cGXFsA
	tkDNaQHa3TjQgvrqi/TZZF6z+Ky1nMpkMnvaPLs+K7C9R5hDKi1v4d7QoP2PrA==
X-Gm-Gg: AZuq6aIMZTKtSPc8+3FVCfNxygg1L8uWF0zM5aJXoOCrRwDhgnO+vf3cgNQ9iDFU/Qm
	kahpe5Qprlaq6LV0fGhIpeX7iaBa9Dh+/pz5e99aQV7ylKuFQ9pcunhl515F4pa4d7D6atsX1Tg
	AJiGUOObQ3CfhQVFiCOyo3lw8CvxIKZECdguTxDslMfMgtjqErshojaVu5DlhF4VjKZCOFfH5MX
	A44BayNstlyvexbUVUxJKODLaM0agEsaUh0l/Na9WWxsiccTDwuqzsmI3Ydromr6pXrP00T5bnB
	e8L/Mn8J/hCRFXlAka/HnmmGNUtXpCEWtrHM1vo+LeNEGohhXZR7RTjhewAZXB8k6EIOymm+UrX
	Vo/dvjygqfJWrf+PAmAaWpnIfYKEIpq2CFIdd6/lNgLI/xMCmR5QFIVLKwg4WYCEMSW7bTNzWS0
	EcyCd1oqxPF2LFXuDGVQ/l+AAPpw==
X-Received: by 2002:a05:6a20:c88d:b0:334:a11e:6bed with SMTP id adf61e73a8af0-39372125f7amr2082657637.29.1770195084179;
        Wed, 04 Feb 2026 00:51:24 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851270sm16847735ad.2.2026.02.04.00.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 00:51:23 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH RESEND v7 14/17] ntfs3: remove legacy ntfs driver support
Date: Wed,  4 Feb 2026 17:29:28 +0900
Message-Id: <20260204082931.13915-15-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260204082931.13915-1-linkinjeon@kernel.org>
References: <20260204082931.13915-1-linkinjeon@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76286-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CB60E359A
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
 fs/ntfs3/dir.c     |  9 -------
 fs/ntfs3/file.c    | 10 --------
 fs/ntfs3/inode.c   | 16 ++++---------
 fs/ntfs3/ntfs_fs.h | 11 ---------
 fs/ntfs3/super.c   | 59 +---------------------------------------------
 6 files changed, 5 insertions(+), 109 deletions(-)

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
index b98e95d6b4d9..fc39e7330365 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -631,13 +631,4 @@ const struct file_operations ntfs_dir_operations = {
 	.compat_ioctl   = ntfs_compat_ioctl,
 #endif
 };
-
-#if IS_ENABLED(CONFIG_NTFS_FS)
-const struct file_operations ntfs_legacy_dir_operations = {
-	.llseek		= generic_file_llseek,
-	.read		= generic_read_dir,
-	.iterate_shared	= ntfs_readdir,
-	.open		= ntfs_file_open,
-};
-#endif
 // clang-format on
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe..0faa856fc470 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1478,14 +1478,4 @@ const struct file_operations ntfs_file_operations = {
 	.fallocate	= ntfs_fallocate,
 	.release	= ntfs_file_release,
 };
-
-#if IS_ENABLED(CONFIG_NTFS_FS)
-const struct file_operations ntfs_legacy_file_operations = {
-	.llseek		= generic_file_llseek,
-	.read_iter	= ntfs_file_read_iter,
-	.splice_read	= ntfs_file_splice_read,
-	.open		= ntfs_file_open,
-	.release	= ntfs_file_release,
-};
-#endif
 // clang-format on
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0a9ac5efeb67..826840c257d3 100644
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
index a4559c9f64e6..326644d23110 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -501,7 +501,6 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 			   struct ntfs_fnd *fnd);
 bool dir_is_empty(struct inode *dir);
 extern const struct file_operations ntfs_dir_operations;
-extern const struct file_operations ntfs_legacy_dir_operations;
 
 /* Globals from file.c */
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
@@ -516,7 +515,6 @@ long ntfs_compat_ioctl(struct file *filp, u32 cmd, unsigned long arg);
 extern const struct inode_operations ntfs_special_inode_operations;
 extern const struct inode_operations ntfs_file_inode_operations;
 extern const struct file_operations ntfs_file_operations;
-extern const struct file_operations ntfs_legacy_file_operations;
 
 /* Globals from frecord.c */
 void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi);
@@ -1160,13 +1158,4 @@ static inline void le64_sub_cpu(__le64 *var, u64 val)
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


