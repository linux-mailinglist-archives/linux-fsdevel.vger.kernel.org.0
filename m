Return-Path: <linux-fsdevel+bounces-950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0647D3E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9640A2812C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D9B21358;
	Mon, 23 Oct 2023 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4MTG7lQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989221340
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:08:19 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5F10D;
	Mon, 23 Oct 2023 11:08:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083cd39188so27974375e9.2;
        Mon, 23 Oct 2023 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698084495; x=1698689295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tOR1AnPiV86SfZe4OnAbQ+ckmKrdHU3txk2iNYjBpc=;
        b=I4MTG7lQUC60oLvJSZYAPoViBBRpUNmXjWUiSsMB0RvUBljuJy6fQKF9xYJcI2b1c6
         WZhDwvdmfbGRgZ3v2C16YFQfxosIi1YOgs3AW2kkqkE8l2fxcEvdXoxPq0H2eZPL1UH8
         iaR3VpHYa1PpTiw5EgWpB8NRofAXG4p3E/lfZiBurNDWDYky2cOeUdf2p8ZNxaMYxsfi
         fLb+LZSZBn0lMW0u0vn8sTVTCqT9HgJdh9ZYXWJWqt23OQ08V5aNARtyNLF7BCEN+EAn
         6u663wozmT9f2wED4egtllQlRO9t39fPKz51fgGFMK7G4qghecCuJWIc6KKArCXB6UTd
         SRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084495; x=1698689295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tOR1AnPiV86SfZe4OnAbQ+ckmKrdHU3txk2iNYjBpc=;
        b=tPaF1GKNegelm0MkF3aRrTVVfmGwrms8kkhwcoJyU8E3caF7Pz/W1k0l50Cs6Gw2JB
         ejMj8AIFH9OD1MEawazM8LpbSLSlgCokiYu8AIkaH0E+0qRcYPWIDyMlr5GAA7vYyF/D
         QnF1rR4H7iczu0ZEqC00rx5Cjs5TssRnnTQQszclLOj+muXh9NsKr8LhTvg91XsLzaqr
         nx45M0IaM7pUG1LdvJZ4c8+St+dKNU2lp4Mo8H824tHOVItVSOZh26WU5pj22FCWFLGn
         sgIDcCQ/mKwAIdQSqOKba+rQ3wO8GFravjyxDcQNQJSqNhUG1ZT4JSRkVQM7QmnCpBHW
         9SPA==
X-Gm-Message-State: AOJu0YzmowV4m6RKFqZk+PbjzYK08ol7y19DWCLevtVh55padcXsVirY
	L3NZIBno6GAML1gso6KFxPQ=
X-Google-Smtp-Source: AGHT+IHwlhC0sZ9nz37LUDcS8funTiaT0lHXr+R6Uu/ceSORkpBYOEHtXDyRJ4ejVmnMWNubXmY3Pg==
X-Received: by 2002:a05:600c:1546:b0:3fe:4cbc:c345 with SMTP id f6-20020a05600c154600b003fe4cbcc345mr7394278wmg.41.1698084495437;
        Mon, 23 Oct 2023 11:08:15 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id c39-20020a05600c4a2700b0040588d85b3asm14391492wmp.15.2023.10.23.11.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:08:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/4] exportfs: support encoding non-decodeable file handles by default
Date: Mon, 23 Oct 2023 21:08:01 +0300
Message-Id: <20231023180801.2953446-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023180801.2953446-1-amir73il@gmail.com>
References: <20231023180801.2953446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AT_HANDLE_FID was added as an API for name_to_handle_at() that request
the encoding of a file id, which is not intended to be decoded.

This file id is used by fanotify to describe objects in events.

So far, overlayfs is the only filesystem that supports encoding
non-decodeable file ids, by providing export_operations with an
->encode_fh() method and without a ->decode_fh() method.

Add support for encoding non-decodeable file ids to all the filesystems
that do not provide export_operations, by encoding a file id of type
FILEID_INO64_GEN from { i_ino, i_generation }.

A filesystem may that does not support NFS export, can opt-out of
encoding non-decodeable file ids for fanotify by defining an empty
export_operations struct (i.e. with a NULL ->encode_fh() method).

This allows the use of fanotify events with file ids on filesystems
like 9p which do not support NFS export to bring fanotify in feature
parity with inotify on those filesystems.

Note that fanotify also requires that the filesystems report a non-null
fsid.  Currently, many simple filesystems that have support for inotify
(e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not be
used with fanotify in file id reporting mode.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c      | 32 +++++++++++++++++++++++++++++---
 include/linux/exportfs.h | 10 +++++++---
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 8f883c4758f5..7d9fdcc187b7 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -383,6 +383,32 @@ int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
 }
 EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
 
+#define FILEID_INO64_GEN_LEN 3
+
+/**
+ * exportfs_encode_ino64_fid - encode non-decodeable 64bit ino file id
+ * @inode:   the object to encode
+ * @fid:     where to store the file handle fragment
+ * @max_len: maximum length to store there (in 4 byte units)
+ *
+ * This generic function is used to encode a non-decodeable file id for
+ * fanotify for filesystems that do not support NFS export.
+ */
+static int exportfs_encode_ino64_fid(struct inode *inode, struct fid *fid,
+				     int *max_len)
+{
+	if (*max_len < FILEID_INO64_GEN_LEN) {
+		*max_len = FILEID_INO64_GEN_LEN;
+		return FILEID_INVALID;
+	}
+
+	fid->i64.ino = inode->i_ino;
+	fid->i64.gen = inode->i_generation;
+	*max_len = FILEID_INO64_GEN_LEN;
+
+	return FILEID_INO64_GEN;
+}
+
 /**
  * exportfs_encode_inode_fh - encode a file handle from inode
  * @inode:   the object to encode
@@ -401,10 +427,10 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 	if (!exportfs_can_encode_fh(nop, flags))
 		return -EOPNOTSUPP;
 
-	if (nop && nop->encode_fh)
-		return nop->encode_fh(inode, fid->raw, max_len, parent);
+	if (!nop && (flags & EXPORT_FH_FID))
+		return exportfs_encode_ino64_fid(inode, fid, max_len);
 
-	return -EOPNOTSUPP;
+	return nop->encode_fh(inode, fid->raw, max_len, parent);
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 4119d3ee72eb..21bae8bfeef1 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -134,7 +134,11 @@ struct fid {
 			u32 parent_ino;
 			u32 parent_gen;
 		} i32;
- 		struct {
+		struct {
+			u64 ino;
+			u32 gen;
+		} __packed i64;
+		struct {
  			u32 block;
  			u16 partref;
  			u16 parent_partref;
@@ -246,7 +250,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 
 static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
 {
-	return nop && nop->encode_fh;
+	return !nop || nop->encode_fh;
 }
 
 static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
@@ -259,7 +263,7 @@ static inline bool exportfs_can_encode_fh(const struct export_operations *nop,
 {
 	/*
 	 * If a non-decodeable file handle was requested, we only need to make
-	 * sure that filesystem can encode file handles.
+	 * sure that filesystem did not opt-out of encoding fid.
 	 */
 	if (fh_flags & EXPORT_FH_FID)
 		return exportfs_can_encode_fid(nop);
-- 
2.34.1


