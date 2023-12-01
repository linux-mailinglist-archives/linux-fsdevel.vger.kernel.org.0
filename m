Return-Path: <linux-fsdevel+bounces-4624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106BA80167F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F4F1C20AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D143F8D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1Fbb68g2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7EE10DB
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:02 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da819902678so984587276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468721; x=1702073521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwoVDhRbNBRkYLjWJpaZS8VmmPHrTCz3YWuznD6d90A=;
        b=1Fbb68g2rALCA+u+VaOrTPdT6I94aoM4QO3mdhydrgNMXOz3smH00mdojY9HRp20e6
         Youf7z46eBOvoTQ6UoHbQPc0/0TG60FqtLL6/qguBVHLiR/ir/QHgUnVSiKoB/nVpzFE
         rFCjBmd6UsixIcbjwAT06h6VTZP4/YMufvQMqp6JoofhN4DPxHhQc3MK771lhhIppcmr
         UE40K4DQ6oh4p/g1mzmGNcCarHR+FJzcft4zEJoZZ+x/xaq/bU/bFNaAbgnX/Xm2//qb
         pIj9k+yRdaQhNKsjDtYEMudMuy0jl0/WY1TkwhwhK6VxPZAr5y75BJpV0gFefgmEKdgT
         Fsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468721; x=1702073521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwoVDhRbNBRkYLjWJpaZS8VmmPHrTCz3YWuznD6d90A=;
        b=fNSt3Jcf3MxCWo0v698g7SISfClJe068uzpM3xQUEeC1PzSxETzTE7bRPchJSqx4UE
         QU2EXTCK3dXKyXo8s2bvFbpmUXAj3GpKpnVtWjFI1yXUgDFOOuc8qqGgP3Wr/vVy4B0T
         7yEg5ZezOylxf2grCyh4Zu3BbDfX8YLGaNh0SdTe9gxDnlaTbgVj6UQG+ar2HvunxdQu
         u3msTFsaaVyoPpjpHVTaEv26oaKuXdIWJADWQY20+VwwixFM+XWliK7zpRJzuqQ5PXXl
         ohHBZC/tVaWw9DoqyqDqSomLyPo+QjMni0BYkz0nn3Xmi1wuWEgIeP2EtGseGJewtxv2
         4nDw==
X-Gm-Message-State: AOJu0YxVzUveiw2aF8NPmPioU+PTur1GqXbLHV2+tuRwCq3DmTLxkgcq
	GyfWY2XphTyNDLeSt9L+tBNnsA==
X-Google-Smtp-Source: AGHT+IEJ3EQBPtAFn6BnCE8kiC40QB1fpP9rsoaSP46Wc/lWnA6QfnAPzO35R0ZT819y9uyx1NP7jw==
X-Received: by 2002:a25:44:0:b0:db5:4764:acad with SMTP id 65-20020a250044000000b00db54764acadmr316235yba.9.1701468721217;
        Fri, 01 Dec 2023 14:12:01 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id u5-20020a25f805000000b00db4d3bf8df5sm633614ybd.27.2023.12.01.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:00 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 03/46] fscrypt: add a fscrypt_inode_open helper
Date: Fri,  1 Dec 2023 17:11:00 -0500
Message-ID: <32beea11211858a998ba2de88d01471c31004f2d.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have fscrypt_file_open() which is meant to be called on files being
opened so that their key is loaded when we start reading data from them.

However for btrfs send we are opening the inode directly without a filp,
so we need a different helper to make sure we can load the fscrypt
context for the inode before reading its contents.

We need a different helper as opposed to simply using
fscrypt_has_permitted_context() directly because of '-o
test_dummy_encryption', which allows for encrypted files to be created
with !IS_ENCRYPTED set on the directory (the root directory in this
case).  fscrypt_file_open() already does the appropriate check where it
simply doesn't call fscrypt_has_permitted_context() if the parent
directory isn't marked with IS_ENCRYPTED in order to facilitate this
invariant when using '-o test_dummy_encryption'.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/crypto/hooks.c       | 42 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fscrypt.h |  8 ++++++++
 2 files changed, 50 insertions(+)

diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
index 52504dd478d3..a391a987c58f 100644
--- a/fs/crypto/hooks.c
+++ b/fs/crypto/hooks.c
@@ -49,6 +49,48 @@ int fscrypt_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(fscrypt_file_open);
 
+/**
+ * fscrypt_inode_open() - prepare to open a possibly-encrypted regular file
+ * @dir: the directory that contains this inode
+ * @inode: the inode being opened
+ *
+ * Currently, an encrypted regular file can only be opened if its encryption key
+ * is available; access to the raw encrypted contents is not supported.
+ * Therefore, we first set up the inode's encryption key (if not already done)
+ * and return an error if it's unavailable.
+ *
+ * We also verify that if the parent directory is encrypted, then the inode
+ * being opened uses the same encryption policy.  This is needed as part of the
+ * enforcement that all files in an encrypted directory tree use the same
+ * encryption policy, as a protection against certain types of offline attacks.
+ * Note that this check is needed even when opening an *unencrypted* file, since
+ * it's forbidden to have an unencrypted file in an encrypted directory.
+ *
+ * File systems should be using fscrypt_file_open in their open callback.  This
+ * is for file systems that may need to open inodes outside of the normal file
+ * open path, btrfs send for example.
+ *
+ * Return: 0 on success, -ENOKEY if the key is missing, or another -errno code
+ */
+int fscrypt_inode_open(struct inode *dir, struct inode *inode)
+{
+	int err;
+
+	err = fscrypt_require_key(inode);
+	if (err)
+		return err;
+
+	if (IS_ENCRYPTED(dir) &&
+	    !fscrypt_has_permitted_context(dir, inode)) {
+		fscrypt_warn(inode,
+			     "Inconsistent encryption context (parent directory: %lu)",
+			     dir->i_ino);
+		err = -EPERM;
+	}
+	return err;
+}
+EXPORT_SYMBOL_GPL(fscrypt_inode_open);
+
 int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 			   struct dentry *dentry)
 {
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index ea8fdc6f3b83..756f23fc3e83 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -394,6 +394,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 
 /* hooks.c */
 int fscrypt_file_open(struct inode *inode, struct file *filp);
+int fscrypt_inode_open(struct inode *dir, struct inode *inode);
 int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 			   struct dentry *dentry);
 int __fscrypt_prepare_rename(struct inode *old_dir, struct dentry *old_dentry,
@@ -738,6 +739,13 @@ static inline int fscrypt_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static inline int fscrypt_inode_open(struct inode *dir, struct inode *inode)
+{
+	if (IS_ENCRYPTED(inode))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 static inline int __fscrypt_prepare_link(struct inode *inode, struct inode *dir,
 					 struct dentry *dentry)
 {
-- 
2.41.0


