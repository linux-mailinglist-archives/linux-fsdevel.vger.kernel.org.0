Return-Path: <linux-fsdevel+bounces-4660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632DA801666
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B46281C23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DE93F8C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="x2lSjB0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC6810EA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:48 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-db548da6e3bso883824276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468768; x=1702073568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNzP1vT2MMiAz4RLg2RxHLY9i1rfgpPqOOdGqsEPy8U=;
        b=x2lSjB0T3qZ4eCdC+jrA7XI2Eje/EQpnWQtbCJ4wGFMYr9HwNXvSpAIuGXqBS5x+8m
         G+pvMyW3Ir7HfGZNyeHG22IO8ui9hVeecJdpb73rzqtR2NmTrunimIMConidZMA7itZp
         6vUbaed1T7lzTGJppkNcZgjdR2cdP5mFedBo0o8Sr8++yL0cBaTCHOc2kemNJEi/RsCk
         ulwv2Si/eMptzj6EBf6Jal7I9ut5hFOLZDhA5pHSme0/+vVXhDdkKcs6zb83kwAkyS0j
         i/CO7MTfSdUTklmgkcmsHLaqx6xAH6NqL7pkIUCr3cKOxqsLd521ooykCx3vbX0jsfmB
         s5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468768; x=1702073568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNzP1vT2MMiAz4RLg2RxHLY9i1rfgpPqOOdGqsEPy8U=;
        b=YzY0HdmTG9D4xLI/xHWVd8M9IcsP3/1mfMTRj3JmgB3wi3xztpCvh1ZnXWjKt9Kyuh
         V1fcLjbz8wtAAV3yM2CFT0AXlPSoDSbRQemmbvdxDDXN4wj4FFmnQRMgdvrLHR4vkewv
         hlz2e2y8fSC84pGeAHBQv9US43BotFKOhvqoYOMX/JuWjhdkLxDtOB2l8o0LMpzisr6z
         3hRWWOoIZ+0/dyFcRkvAmtWfGMd4YZ/L3kwQeSnE43OzDAYnzigh5qDbiasa+64rbilT
         yWbQAc3AmiZ8ustxtZmueQ1MRINqHiliBjhMBPhxveXunqeZccpLpdCHhvGEpNmt2guA
         vr1w==
X-Gm-Message-State: AOJu0Yyc+oCMfskMTK80bqHivGP5nmFc+WmrATmYqRdLbm2OYGQluMno
	q+jomqzbozOhfXQUDYKQvKTqRW799dflZv3r+TP1Hg==
X-Google-Smtp-Source: AGHT+IFwWPI7hv4vRSmcqpd3J+W/DuiDZgkzRZsnuFD1zb8SSLMs9GuVdwO1oAeXjx9/JJ6xRTYUpg==
X-Received: by 2002:a81:a184:0:b0:5d3:b71b:4d30 with SMTP id y126-20020a81a184000000b005d3b71b4d30mr305795ywg.17.1701468768158;
        Fri, 01 Dec 2023 14:12:48 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z83-20020a814c56000000b005d3c950160csm1011189ywa.4.2023.12.01.14.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:47 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 41/46] btrfs: move inode_to_path higher in backref.c
Date: Fri,  1 Dec 2023 17:11:38 -0500
Message-ID: <3ff858fdc4b3b4b3735289999ba652939b2343ab.1701468306.git.josef@toxicpanda.com>
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

We have a prototype and then the definition lower below, we don't need
to do this, simply move the function to where the prototype is.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c | 69 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index beed7e459dab..f58fe7c745c2 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2578,8 +2578,40 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 				     build_ino_list, ctx);
 }
 
+/*
+ * returns 0 if the path could be dumped (probably truncated)
+ * returns <0 in case of an error
+ */
 static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, struct inode_fs_paths *ipath);
+			 struct extent_buffer *eb, struct inode_fs_paths *ipath)
+{
+	char *fspath;
+	char *fspath_min;
+	int i = ipath->fspath->elem_cnt;
+	const int s_ptr = sizeof(char *);
+	u32 bytes_left;
+
+	bytes_left = ipath->fspath->bytes_left > s_ptr ?
+					ipath->fspath->bytes_left - s_ptr : 0;
+
+	fspath_min = (char *)ipath->fspath->val + (i + 1) * s_ptr;
+	fspath = btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, name_len,
+				   name_off, eb, inum, fspath_min, bytes_left);
+	if (IS_ERR(fspath))
+		return PTR_ERR(fspath);
+
+	if (fspath > fspath_min) {
+		ipath->fspath->val[i] = (u64)(unsigned long)fspath;
+		++ipath->fspath->elem_cnt;
+		ipath->fspath->bytes_left = fspath - fspath_min;
+	} else {
+		++ipath->fspath->elem_missed;
+		ipath->fspath->bytes_missing += fspath_min - fspath;
+		ipath->fspath->bytes_left = 0;
+	}
+
+	return 0;
+}
 
 static int iterate_inode_refs(u64 inum, struct inode_fs_paths *ipath)
 {
@@ -2704,41 +2736,6 @@ static int iterate_inode_extrefs(u64 inum, struct inode_fs_paths *ipath)
 	return ret;
 }
 
-/*
- * returns 0 if the path could be dumped (probably truncated)
- * returns <0 in case of an error
- */
-static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, struct inode_fs_paths *ipath)
-{
-	char *fspath;
-	char *fspath_min;
-	int i = ipath->fspath->elem_cnt;
-	const int s_ptr = sizeof(char *);
-	u32 bytes_left;
-
-	bytes_left = ipath->fspath->bytes_left > s_ptr ?
-					ipath->fspath->bytes_left - s_ptr : 0;
-
-	fspath_min = (char *)ipath->fspath->val + (i + 1) * s_ptr;
-	fspath = btrfs_ref_to_path(ipath->fs_root, ipath->btrfs_path, name_len,
-				   name_off, eb, inum, fspath_min, bytes_left);
-	if (IS_ERR(fspath))
-		return PTR_ERR(fspath);
-
-	if (fspath > fspath_min) {
-		ipath->fspath->val[i] = (u64)(unsigned long)fspath;
-		++ipath->fspath->elem_cnt;
-		ipath->fspath->bytes_left = fspath - fspath_min;
-	} else {
-		++ipath->fspath->elem_missed;
-		ipath->fspath->bytes_missing += fspath_min - fspath;
-		ipath->fspath->bytes_left = 0;
-	}
-
-	return 0;
-}
-
 /*
  * this dumps all file system paths to the inode into the ipath struct, provided
  * is has been created large enough. each path is zero-terminated and accessed
-- 
2.41.0


