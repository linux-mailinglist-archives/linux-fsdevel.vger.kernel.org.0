Return-Path: <linux-fsdevel+bounces-53879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4DAF85C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 04:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ADE3B5304
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6111DF26A;
	Fri,  4 Jul 2025 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jOenLqG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78D1FC3;
	Fri,  4 Jul 2025 02:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597428; cv=none; b=AwsjgQPk/QkKqALxTvdYdqgdXZeLRopF2s0uS8QNmumtEi9e0BTpL2SqFf0Xou25DghX6ZkmdJdx8L5l+BtfhYuwgtvhiN70xDZwkHuoeCiWjbAFWjOwzulql5DSBNg+Xe4trua8MkKpkIFVzEMRaYw0mdw93Su4plgERw+iCqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597428; c=relaxed/simple;
	bh=3kIx5aF6ck51vQf+NJ/6Hu6bYd6KkAM5ELLUCRQeRNg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NWpA1gbd4DnTz4IvGlfw794zEMIl+s0F75TxFK9bJBBF0DaAcNG5XZHVJmhp1v6IkuUiYWczytuBFqZwga5TTElLaBI+UuYYJ3C2yMwE5FQmh7JmOjoUGuIsIvTFXUA1Y5czvQ5aHwv+K4JRa3BRybnBrm5SsHrqn0X/zts+LkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jOenLqG1; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1751597408;
	bh=60C9crPrlso6i63AWM7qFupPHsU4T1ZcqF61uHig4r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jOenLqG1s0RqR18R147QauwaBSLNkcBibe6tDE/gJUwfoGRNZUseOuXP1k/jkU5zB
	 72E5fxYWDoHKaFkCvhyccwxqflQb5Nc3PXg15EPtX5TTPYlWs/BQJMqTRvyqVkPEyU
	 9LGPsdlj5xCw2UYVTiJPdL18uWjncUA7dr2Nfroo=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.73])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id AFA99AEB; Fri, 04 Jul 2025 10:43:58 +0800
X-QQ-mid: xmsmtpt1751597038tlheim36w
Message-ID: <tencent_82716EB4F15F579C738C3CC3AFE62E822207@qq.com>
X-QQ-XMAILINFO: MeRnHSrEJzCrXBD8vlUlbdOjZ64QGNMuOTs64HRplnflQ2Xw47I1asd051G1Fa
	 HkAZe+pG5Sbjn05hu2LVcp+KFz4uvh3/PquiaTE+gcX4JARoZoOB0OoJWMJTOolc6FOfBkx6n7XI
	 omAbVYjDagqD1/Gy1Ln/NNP+1N4UNXOc7/RsczR0Ii36+GXeRzMFw9qVFbxrIdh6h/6H4uI6wQsx
	 uoQmrzd/UY1LgUVPtHzLNd4V61Zb+11WUYcyfHsa1xFHTeTFvJ/uOjBSZ+4rub0Egmn4ZEpkXw0b
	 kzd67z5cntmZLn8wDvd3PtusABNFGV7Ba5vl1JcONR5N0HiqXBakTP8E17XujVxLxMn5QbqlHA7h
	 gFxrgWvnadL8Qz3UEv9J7oMglBfHDGEr2MgdUbdv+wPEO28zZPhszwtvpi4H5bsCzViJuzWYC4XQ
	 VHiW+RxZkEanaotTY2vkMHp6EuqjTl6ygz7QD58vizIvcIgEhobCM5FuRaz/YrfiuLgMYiXx+jlR
	 6rK6TfCET9UKwxXsRPKe29bT0qD9FjmVi+3lSXoTR4i4rG7SNJdut6xPrY/6wfYNt1lrZ6kckqn7
	 Dqps4jlBb7Rtw4OeRRM4AfX28hUeCCRDcRQIrW/dFxoNmqLGc6DyDyq7Av/4wcBUKhx4U96NlGXt
	 CD4jcM2phCSMvg2sG79ynyCuT5zaHo1RBxHEHfzoO9UoJhbqnzbBpPf5jzLsrd7OZ7K2ge0hMQF/
	 DadpAYf7N1DyILLPIOxnxfdDRsv1vwjMo3GsjnBaaueRkVbPMsN1UgmspkATWLRFPOGg7E0dR2eN
	 HLBL690GC+96ltRvV0eJijs+uKtoFtMXsg3i+p6nwxhOUajs1LX9Ij6ffL3aDTWKI7iW3ik/v7AV
	 WfNdSxbou1CzZ4Dj9b5N2hNyTSpexQ1s+juAg4Lf/JwpxyFNcCtDheDAFlY0hcQlvZxEbcYNoV2f
	 +IwGVD0K1UrkN0HrkvYzsspuJb6R6euNA01rbt3nxe8aq6uGJf/7ZEC97TBzTopAkXQ1j8GvCA9H
	 Jon7WENY+5wnQJkfGHVv7K9bjLh3f6LSWRl86vJfWDgod5j3EfaYU7QRvWL6H7iY8bSIu/A0wm0Q
	 LyzxQylUT5qRMypuU=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: hch@infradead.org
Cc: adilger.kernel@dilger.ca,
	brauner@kernel.org,
	chao@kernel.org,
	jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	ywen.chen@foxmail.com
Subject: [PATCH v3 1/2] libfs: reduce the number of memory allocations in generic_ci_match
Date: Fri,  4 Jul 2025 10:43:57 +0800
X-OQ-MSGID: <20250704024357.4078753-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aGZFtmIxHDLKL6mc@infradead.org>
References: <aGZFtmIxHDLKL6mc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During path traversal, the generic_ci_match function may be called
multiple times. The number of memory allocations and releases
in it accounts for a relatively high proportion in the flamegraph.
This patch significantly reduces the number of memory allocations
in generic_ci_match through pre - allocation.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 fs/ext4/namei.c    |  2 +-
 fs/f2fs/dir.c      |  2 +-
 fs/libfs.c         | 33 ++++++++++++++++++++++++++++++---
 include/linux/fs.h |  8 +++++++-
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a178ac2294895..f235693bd71aa 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1443,7 +1443,7 @@ static bool ext4_match(struct inode *parent,
 
 		return generic_ci_match(parent, fname->usr_fname,
 					&fname->cf_name, de->name,
-					de->name_len) > 0;
+					de->name_len, NULL) > 0;
 	}
 #endif
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c36b3b22bfffd..4c6611fbd9574 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -197,7 +197,7 @@ static inline int f2fs_match_name(const struct inode *dir,
 	if (fname->cf_name.name)
 		return generic_ci_match(dir, fname->usr_fname,
 					&fname->cf_name,
-					de_name, de_name_len);
+					de_name, de_name_len, NULL);
 
 #endif
 	f.usr_fname = fname->usr_fname;
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a81..d2a6b2a4fe11c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1863,6 +1863,26 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 #endif
 };
 
+#define DECRYPTED_NAME_PREALLOC_MIN_LEN 64
+static inline char *decrypted_name_prealloc_resize(
+		struct decrypted_name_prealloc *prealloc,
+		size_t wantlen)
+{
+	char *retbuf = NULL;
+
+	if (prealloc->name && wantlen >= prealloc->namelen)
+		return prealloc->name;
+
+	retbuf = kmalloc(wantlen + DECRYPTED_NAME_PREALLOC_MIN_LEN, GFP_KERNEL);
+	if (!retbuf)
+		return NULL;
+
+	kfree(prealloc->name);
+	prealloc->name = retbuf;
+	prealloc->namelen = wantlen + DECRYPTED_NAME_PREALLOC_MIN_LEN;
+	return retbuf;
+}
+
 /**
  * generic_ci_match() - Match a name (case-insensitively) with a dirent.
  * This is a filesystem helper for comparison with directory entries.
@@ -1873,6 +1893,7 @@ static const struct dentry_operations generic_ci_dentry_ops = {
  * @folded_name: Optional pre-folded name under lookup
  * @de_name: Dirent name.
  * @de_name_len: dirent name length.
+ * @prealloc: decrypted name memory buffer
  *
  * Test whether a case-insensitive directory entry matches the filename
  * being searched.  If @folded_name is provided, it is used instead of
@@ -1884,7 +1905,8 @@ static const struct dentry_operations generic_ci_dentry_ops = {
 int generic_ci_match(const struct inode *parent,
 		     const struct qstr *name,
 		     const struct qstr *folded_name,
-		     const u8 *de_name, u32 de_name_len)
+		     const u8 *de_name, u32 de_name_len,
+		     struct decrypted_name_prealloc *prealloc)
 {
 	const struct super_block *sb = parent->i_sb;
 	const struct unicode_map *um = sb->s_encoding;
@@ -1899,7 +1921,11 @@ int generic_ci_match(const struct inode *parent,
 		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(parent)))
 			return -EINVAL;
 
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		if (!prealloc)
+			decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
+		else
+			decrypted_name.name = decrypted_name_prealloc_resize(
+					prealloc, de_name_len);
 		if (!decrypted_name.name)
 			return -ENOMEM;
 		res = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
@@ -1928,7 +1954,8 @@ int generic_ci_match(const struct inode *parent,
 		res = utf8_strncasecmp(um, name, &dirent);
 
 out:
-	kfree(decrypted_name.name);
+	if (!prealloc)
+		kfree(decrypted_name.name);
 	if (res < 0 && sb_has_strict_encoding(sb)) {
 		pr_err_ratelimited("Directory contains filename that is invalid UTF-8");
 		return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4ec77da65f144..65307c8c11485 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3651,10 +3651,16 @@ extern int generic_file_fsync(struct file *, loff_t, loff_t, int);
 extern int generic_check_addressable(unsigned, u64);
 
 extern void generic_set_sb_d_ops(struct super_block *sb);
+
+struct decrypted_name_prealloc {
+	char *name;
+	size_t namelen;
+};
 extern int generic_ci_match(const struct inode *parent,
 			    const struct qstr *name,
 			    const struct qstr *folded_name,
-			    const u8 *de_name, u32 de_name_len);
+			    const u8 *de_name, u32 de_name_len,
+			    struct decrypted_name_prealloc *prealloc);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str);
-- 
2.34.1


