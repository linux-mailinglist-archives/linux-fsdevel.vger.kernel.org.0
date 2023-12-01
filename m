Return-Path: <linux-fsdevel+bounces-4665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C780166A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B09B1F21013
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71F3F8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KN8r0N3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE210DB
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:53 -0800 (PST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-5cece20f006so29775557b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468772; x=1702073572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnBFsSJF3IsR7DnmwzCPuaucSteetnKny36hQz4x9Tc=;
        b=KN8r0N3ZyGwFepUQuSKlKaHl9V5mCT2yLnm636K/gn2OtfyIpO5rbJOQ81KKm1d7Lt
         NWgoz192ZtLxPWxeVpZPBBehKGLFXaOxTWEjHMEg3aPWVMJaEgVTqLNxa2p1lHuO6P0W
         ocy6c7zGUuHlOjfwmPpnHfK9eJYvPQgFjETf1hPps7KpDOzIfNH1oe7U9nmJxIX9Pztg
         x2gzGFfgpIFYQgSVUXnzFf96NiuyAOxc8Oxz9cbaPget362mXF2yXrHAWTvLVOZWHsHk
         ttwErjhMAbPkmIcA2dzutT4xBBs5ol7fzGojNzTe6NdrVaPNZAgdaHmds3MgNc9Hh5AD
         ZThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468772; x=1702073572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnBFsSJF3IsR7DnmwzCPuaucSteetnKny36hQz4x9Tc=;
        b=aw0GBAuGOPGEgtmBz2HzehUjP/D8Oa16HZ3eNEi4pYQcnk065l8WhRawx00QEziGkU
         024BjZ1bN63koaOSYW3CsKw0wX7u/Sk6px07h/k0Ah/Ba+lMKmkE09GAenzZLGB9m1nQ
         bOiU2Z8GYmYhKt1De13rR+b1sTUM5quoJ0hrBflMqO6cwlMCChJg8/thkEvL30XQ5j+m
         A8U3ANQPaWb/s9+QFPFhOHgwzeo/NpKtvdMESy3zdWYU+iYQhWRUicWaAhhKvHkeJgBE
         skW70MucKM5clfXwF1wQQyYMauU1QBARP1C4a0CrW7uQ3Hj6uNAqt1CK6D7rdp4hTpy1
         PL9Q==
X-Gm-Message-State: AOJu0YywBY05BxTwLd24Fm4S5OBekkh78j3bYrtiozpQ5CW3kMDXq9R3
	D4vcNMdmanWdl+RAYmPAPax8pGbA3WKDdq0SlmfduPTq
X-Google-Smtp-Source: AGHT+IFHE/NvnM2BVqABU7Hu3PtQOXzgb9ekQXJwRFI8JzofsueQL+LkwFcUZdc+HgFvkpWH16Xy2g==
X-Received: by 2002:a05:690c:711:b0:5d4:3013:25d2 with SMTP id bs17-20020a05690c071100b005d4301325d2mr324407ywb.12.1701468772305;
        Fri, 01 Dec 2023 14:12:52 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id i190-20020a0dc6c7000000b005d25be5c7f4sm1385122ywd.73.2023.12.01.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:52 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 45/46] btrfs: decrypt file names for send
Date: Fri,  1 Dec 2023 17:11:42 -0500
Message-ID: <ba81531dc639edddba297442fda6d7fc3b455e3e.1701468306.git.josef@toxicpanda.com>
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

In send we're going to be looking up file names from back references and
putting them into the send stream.  If we are encrypted use the helper
for decrypting names and copy the decrypted name into the buffer.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/send.c | 51 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ee5ea16423bb..de77321777f4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -33,6 +33,7 @@
 #include "ioctl.h"
 #include "verity.h"
 #include "lru_cache.h"
+#include "fscrypt.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
@@ -585,13 +586,42 @@ static int fs_path_add_path(struct fs_path *p, struct fs_path *p2)
 	return ret;
 }
 
-static int fs_path_add_from_extent_buffer(struct fs_path *p,
+static int fs_path_add_from_encrypted(struct btrfs_root *root,
+				      struct fs_path *p,
+				      struct extent_buffer *eb,
+				      unsigned long off, int len,
+				      u64 parent_ino)
+{
+	struct fscrypt_str fname = FSTR_INIT(NULL, 0);
+	int ret;
+
+	ret = fscrypt_fname_alloc_buffer(BTRFS_NAME_LEN, &fname);
+	if (ret)
+		return ret;
+
+	ret = btrfs_decrypt_name(root, eb, off, len, parent_ino, &fname);
+	if (ret)
+		goto out;
+
+	ret = fs_path_add(p, fname.name, fname.len);
+out:
+	fscrypt_fname_free_buffer(&fname);
+	return ret;
+}
+
+static int fs_path_add_from_extent_buffer(struct btrfs_root *root,
+					  struct fs_path *p,
 					  struct extent_buffer *eb,
-					  unsigned long off, int len)
+					  unsigned long off, int len,
+					  u64 parent_ino)
 {
 	int ret;
 	char *prepared;
 
+	if (root && btrfs_fs_incompat(root->fs_info, ENCRYPT))
+		return fs_path_add_from_encrypted(root, p, eb, off, len,
+						  parent_ino);
+
 	ret = fs_path_prepare_for_add(p, len, &prepared);
 	if (ret < 0)
 		goto out;
@@ -1074,8 +1104,8 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 			}
 			p->start = start;
 		} else {
-			ret = fs_path_add_from_extent_buffer(p, eb, name_off,
-							     name_len);
+			ret = fs_path_add_from_extent_buffer(root, p, eb, name_off,
+							     name_len, dir);
 			if (ret < 0)
 				goto out;
 		}
@@ -1792,7 +1822,7 @@ static int read_symlink_unencrypted(struct btrfs_root *root, u64 ino,
 	off = btrfs_file_extent_inline_start(ei);
 	len = btrfs_file_extent_ram_bytes(path->nodes[0], ei);
 
-	ret = fs_path_add_from_extent_buffer(dest, path->nodes[0], off, len);
+	ret = fs_path_add_from_extent_buffer(NULL, dest, path->nodes[0], off, len, 0);
 
 out:
 	btrfs_free_path(path);
@@ -2090,18 +2120,19 @@ static int get_first_ref(struct btrfs_root *root, u64 ino,
 		iref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				      struct btrfs_inode_ref);
 		len = btrfs_inode_ref_name_len(path->nodes[0], iref);
-		ret = fs_path_add_from_extent_buffer(name, path->nodes[0],
-						     (unsigned long)(iref + 1),
-						     len);
 		parent_dir = found_key.offset;
+		ret = fs_path_add_from_extent_buffer(root, name, path->nodes[0],
+						     (unsigned long)(iref + 1),
+						     len, parent_dir);
 	} else {
 		struct btrfs_inode_extref *extref;
 		extref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 					struct btrfs_inode_extref);
 		len = btrfs_inode_extref_name_len(path->nodes[0], extref);
-		ret = fs_path_add_from_extent_buffer(name, path->nodes[0],
-					(unsigned long)&extref->name, len);
 		parent_dir = btrfs_inode_extref_parent(path->nodes[0], extref);
+		ret = fs_path_add_from_extent_buffer(root, name, path->nodes[0],
+					(unsigned long)&extref->name, len,
+					parent_dir);
 	}
 	if (ret < 0)
 		goto out;
-- 
2.41.0


