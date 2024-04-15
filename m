Return-Path: <linux-fsdevel+bounces-16980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A98A5E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FBE2862DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0997A15921E;
	Mon, 15 Apr 2024 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsBVMpIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C221591F9;
	Mon, 15 Apr 2024 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224386; cv=none; b=jgEpliiAZyUS0A9rhAEbVpVEevikg7pZ01U4cShI1lLPsSONRE1gm+gSq6qLWtYrMv2u8GBmUXpSmsqjq2LIsYZU5KVVzLc9BnbQg5MfEVWY6aO7kaQk6TlSqPAr0QUGfY0E7QKdI6RwsXjCXYQJT3vKfLLCWs9KB4gmItfzgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224386; c=relaxed/simple;
	bh=HwhKuSfEnBb2nKmPWFNwOlZVyDXCDh7JlKVoRY7oNfc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4O9As75O1zXdtZzaKpc/DFCPjfMhRM8g7r+R3Kc1ySxiCG0J775fqoAD2f77MlqphwqXMQGxRNDlwHZngWrX/f5iLW2z3pf6yKmwNkQMLIwoN+W8WPHHqs8STnQXXgQvYN2qZdhYPP7wgFyyQfUSxLqgju+boJQ+iUqWb0ha8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsBVMpIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347E8C2BD11;
	Mon, 15 Apr 2024 23:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224386;
	bh=HwhKuSfEnBb2nKmPWFNwOlZVyDXCDh7JlKVoRY7oNfc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LsBVMpIpJDm2wLut0YPnIFpzRt3dKat+pT54exNYMwmlbOotqIwsuK0Cb73l1zsQH
	 itKNHODB0/5mik+p3LQefmPC6sgLjOOa5VMXW59hjuanNLAENmn6ZFatsodfaUw+XX
	 q8qBBrbhReUTxGz7zd3BqTYXeGGAt4onC4YdkzjFt+A+MVMOPzkARibomJgSL8KEWe
	 ZRhPhG7gxb9YDuF50zN242P9c0YGe+RKjrHZQgqvYZeahjzVWJhKXZTwJRqNU6Ap7o
	 mwEYVN/GoWgu/45qTV+ZluBxWsCafBlrMixx2gPKaWqM88INg67YxlZu6HlThu4mf9
	 ILguwVnceFihQ==
Date: Mon, 15 Apr 2024 16:39:45 -0700
Subject: [PATCH 3/7] xfs: declare xfs_file.c symbols in xfs_file.h
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380778.87068.12250779360411108918.stgit@frogsfrogsfrogs>
In-Reply-To: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
References: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Move the two public symbols in xfs_file.c to xfs_file.h.  We're about to
add more public symbols in that source file, so let's finally create the
header file.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  |    1 +
 fs/xfs/xfs_file.h  |   12 ++++++++++++
 fs/xfs/xfs_ioctl.c |    1 +
 fs/xfs/xfs_iops.c  |    1 +
 fs/xfs/xfs_iops.h  |    3 ---
 5 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 fs/xfs/xfs_file.h


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 40b778415f5f..9961d4b5efbe 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -24,6 +24,7 @@
 #include "xfs_pnfs.h"
 #include "xfs_iomap.h"
 #include "xfs_reflink.h"
+#include "xfs_file.h"
 
 #include <linux/dax.h>
 #include <linux/falloc.h>
diff --git a/fs/xfs/xfs_file.h b/fs/xfs/xfs_file.h
new file mode 100644
index 000000000000..7d39e3eca56d
--- /dev/null
+++ b/fs/xfs/xfs_file.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2000-2005 Silicon Graphics, Inc.
+ * All Rights Reserved.
+ */
+#ifndef __XFS_FILE_H__
+#define __XFS_FILE_H__
+
+extern const struct file_operations xfs_file_operations;
+extern const struct file_operations xfs_dir_file_operations;
+
+#endif /* __XFS_FILE_H__ */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d0e2cec6210d..1397edea20f1 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -39,6 +39,7 @@
 #include "xfs_ioctl.h"
 #include "xfs_xattr.h"
 #include "xfs_rtbitmap.h"
+#include "xfs_file.h"
 
 #include <linux/mount.h>
 #include <linux/namei.h>
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 66f8c47642e8..55ed2d1023d6 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -25,6 +25,7 @@
 #include "xfs_error.h"
 #include "xfs_ioctl.h"
 #include "xfs_xattr.h"
+#include "xfs_file.h"
 
 #include <linux/posix_acl.h>
 #include <linux/security.h>
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index 8a38c3e2ed0e..3c1a2605ffd2 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -8,9 +8,6 @@
 
 struct xfs_inode;
 
-extern const struct file_operations xfs_file_operations;
-extern const struct file_operations xfs_dir_file_operations;
-
 extern ssize_t xfs_vn_listxattr(struct dentry *, char *data, size_t size);
 
 int xfs_vn_setattr_size(struct mnt_idmap *idmap,


