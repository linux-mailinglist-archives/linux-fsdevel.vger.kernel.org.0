Return-Path: <linux-fsdevel+bounces-602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D107CD8C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3FE0B21399
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10818E35;
	Wed, 18 Oct 2023 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGv4PQOM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22018C1E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 10:00:15 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E4EF7;
	Wed, 18 Oct 2023 03:00:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-407da05f05aso12060155e9.3;
        Wed, 18 Oct 2023 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697623213; x=1698228013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qi4Eam5aGrJY9E/N/+2uzFyjTVYPfYz5piRCWTEPBA=;
        b=dGv4PQOMj1EypfVtWvGp7pUdnXBCrgfHaM2p5adnCt63AfNYh2mx5P8BPDHOtMFYGj
         VbTqDD4aB8yuWRhKDuuup4cyuw6/9fOV+gAF95KnZwJ+TEMQZzrL2cPSXZKRQo5sL40Y
         o3Qv0avC5ivIOnETTgI9RAc9iDy3s9LkRnEsqjp7hzblkylCdjbSpEnM1C2t0KADxoVb
         PfNU4wMns0F/ThvetrXSVudutoCvSangowdIA3c34ACTo909fLde+etpy5KAO0VQA9gL
         mEyEt8Nq1aZZpKLsUzI1a7VZOtX5a93va9+hiDmoATVnrven7KLs2sEUZx8qyecVV/EH
         fLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697623213; x=1698228013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Qi4Eam5aGrJY9E/N/+2uzFyjTVYPfYz5piRCWTEPBA=;
        b=RMaEh6ZHzYEv7BXbZQ4SlUnfqEJh/XKIVWD7kdWsXnYc4D//BbYrdHBIgEcJu/N6GO
         kuAuOCGtBQKUXpfROMH3JzXLVIbmcElm1qVx/LavUqBVEUIu7Ojr/iApjwdGplWiOXVt
         zaUHx0DVtpwj9wYggD61mgHaJN5ZQon5OkWp/ZxvEGgqEDlMoy8FKLCzaN295oLFuFVs
         Ee+ul0VFMgnOftxa+vNcx9QwqfNA4Et2TtHQrwwwczqZNeEjoRIAhShm28R+IzAHlY+K
         DASSjM7ZtD+OqM2ni1sUTH91meMYjmwLX6kaPJwIAV3AiBJX3WAIb3D+N8gtZWWeitP8
         nUaA==
X-Gm-Message-State: AOJu0YyVF/KhBA4BQk8uWHuqWGux20YN6Na6sWQZEO73Nh+BvTdIcvj9
	+4qMh1gF5BMytUj9kAt85U8=
X-Google-Smtp-Source: AGHT+IG61vqYE8SoscH6m48jqjti4rHvc/VWtX153DLhQAC7m2GbXOZywMSf3+/crQjy2LA/wlTk3g==
X-Received: by 2002:a05:600c:1ca0:b0:408:3e41:aea with SMTP id k32-20020a05600c1ca000b004083e410aeamr742399wms.1.1697623212464;
        Wed, 18 Oct 2023 03:00:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id y34-20020a05600c342200b004063977eccesm1222017wmp.42.2023.10.18.03.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:00:11 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH 4/5] exportfs: define FILEID_INO64_GEN* file handle types
Date: Wed, 18 Oct 2023 12:59:59 +0300
Message-Id: <20231018100000.2453965-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018100000.2453965-1-amir73il@gmail.com>
References: <20231018100000.2453965-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similar to the common FILEID_INO32* file handle types, define common
FILEID_INO64* file handle types.

The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
values returned by fuse and xfs for 64bit ino encoded file handle types.

Note that these type value are filesystem specific and they do not define
a universal file handle format, for example:
fuse encodes FILEID_INO64_GEN as [ino-hi32,ino-lo32,gen] and xfs encodes
FILEID_INO64_GEN as [hostr-order-ino64,gen] (a.k.a xfs_fid64).

The FILEID_INO64_GEN fhandle type is going to be used for file ids for
fanotify from filesystems that do not support NFS export.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/inode.c          |  7 ++++---
 include/linux/exportfs.h | 11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb..e63f966698a5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1002,7 +1002,7 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	}
 
 	*max_len = len;
-	return parent ? 0x82 : 0x81;
+	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
 }
 
 static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
@@ -1010,7 +1010,8 @@ static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
 {
 	struct fuse_inode_handle handle;
 
-	if ((fh_type != 0x81 && fh_type != 0x82) || fh_len < 3)
+	if ((fh_type != FILEID_INO64_GEN &&
+	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
 		return NULL;
 
 	handle.nodeid = (u64) fid->raw[0] << 32;
@@ -1024,7 +1025,7 @@ static struct dentry *fuse_fh_to_parent(struct super_block *sb,
 {
 	struct fuse_inode_handle parent;
 
-	if (fh_type != 0x82 || fh_len < 6)
+	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
 		return NULL;
 
 	parent.nodeid = (u64) fid->raw[3] << 32;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 6b6e01321405..21eeb9f6bdbd 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -98,6 +98,17 @@ enum fid_type {
 	 */
 	FILEID_FAT_WITH_PARENT = 0x72,
 
+	/*
+	 * 64 bit inode number, 32 bit generation number.
+	 */
+	FILEID_INO64_GEN = 0x81,
+
+	/*
+	 * 64 bit inode number, 32 bit generation number,
+	 * 64 bit parent inode number, 32 bit parent generation.
+	 */
+	FILEID_INO64_GEN_PARENT = 0x82,
+
 	/*
 	 * 128 bit child FID (struct lu_fid)
 	 * 128 bit parent FID (struct lu_fid)
-- 
2.34.1


