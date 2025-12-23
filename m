Return-Path: <linux-fsdevel+bounces-71964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 754BBCD872F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E443026508
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4543431BCA3;
	Tue, 23 Dec 2025 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sdESPZwN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD102B2DA;
	Tue, 23 Dec 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766478638; cv=none; b=MQrlQlkp3N+/2u2vmr8XpC6pw8SpqOmzSqMUcpyKm4gknXcbbQcDHBU4Y5QrsVrf21n2ac/fPqa+Pdq2FPouqAS6hHdliKnwkShKncNNs4DYR7JReCXeB7NPIGhGSa+1UVw2dlQhi5JcmnYvstFQWgZn/BLuig/W0yIi8lpkBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766478638; c=relaxed/simple;
	bh=NB9Mc93tt1YWat+gRWd+cifDoMp0fXfaerAEILmLL68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4kxzfZbaX86DvEufRlfI1D5S7klKmOQGF3hSONv+m1qMjRImepXF1uG5QHhy7mPvCxIBBx7zZIOIXUCjj5/AlvSPNaugpJvx3Ks+tcF0RYM/kSGua6yF7hfUgC/xDiooYKvSpwAMGktnKtfRigy8eUUOHYfDK6KCHh4Vc4i8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sdESPZwN; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766478630; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7NSX3ycYQmxGLNK4vFDMYYQPstREQCLVPQ9/mSmRTFU=;
	b=sdESPZwNcuD0VZCL+jkELac2nHcVDpSkJxVAKgcLOMwxn63YxeTbDqR/XP7nWbaaGH1iVPEZIJn1uShRQH6C7HT9MGdY4qLtZvN4Sl4PaePBN7xj3a/+M+u950ImAyUHfL5QjwkHteGaNkYn2RRPtaqbfg4uS7wlRm1ZacECc1Q=
Received: from 30.221.131.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvX6LtN_1766478629 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 16:30:30 +0800
Message-ID: <79c97f96-bb07-46f3-8c9a-5e3c867f6cab@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:30:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/10] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251223015618.485626-1-lihongbo22@huawei.com>
 <20251223015618.485626-5-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251223015618.485626-5-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/23 09:56, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Can you just replace this one with the following patch?


From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue, 23 Dec 2025 16:27:17 +0800
Subject: [PATCH] erofs: decouple `struct erofs_anon_fs_type`

  - Move the `struct erofs_anon_fs_type` to super.c and expose it
    in preparation for the upcoming page cache share feature;

  - Remove the `.owner` field, as they are all internal mounts and
    fully managed by EROFS.  Retaining `.owner` would unnecessarily
    increment module reference counts, preventing the EROFS kernel
    module from being unloaded.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
  fs/erofs/fscache.c  | 13 -------------
  fs/erofs/internal.h |  2 ++
  fs/erofs/super.c    | 14 ++++++++++++++
  3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 7a346e20f7b7..f4937b025038 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -3,7 +3,6 @@
   * Copyright (C) 2022, Alibaba Cloud
   * Copyright (C) 2022, Bytedance Inc. All rights reserved.
   */
-#include <linux/pseudo_fs.h>
  #include <linux/fscache.h>
  #include "internal.h"

@@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
  static LIST_HEAD(erofs_domain_cookies_list);
  static struct vfsmount *erofs_pseudo_mnt;

-static int erofs_anon_init_fs_context(struct fs_context *fc)
-{
-	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
-}
-
-static struct file_system_type erofs_anon_fs_type = {
-	.owner		= THIS_MODULE,
-	.name           = "pseudo_erofs",
-	.init_fs_context = erofs_anon_init_fs_context,
-	.kill_sb        = kill_anon_super,
-};
-
  struct erofs_fscache_io {
  	struct netfs_cache_resources cres;
  	struct iov_iter		iter;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f7f622836198..98fe652aea33 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -188,6 +188,8 @@ static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
  	return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->dif0.file;
  }

+extern struct file_system_type erofs_anon_fs_type;
+
  static inline bool erofs_is_fscache_mode(struct super_block *sb)
  {
  	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 937a215f626c..f18f43b78fca 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,6 +11,7 @@
  #include <linux/fs_parser.h>
  #include <linux/exportfs.h>
  #include <linux/backing-dev.h>
+#include <linux/pseudo_fs.h>
  #include "xattr.h"

  #define CREATE_TRACE_POINTS
@@ -936,6 +937,19 @@ static struct file_system_type erofs_fs_type = {
  };
  MODULE_ALIAS_FS("erofs");

+#if defined(CONFIG_EROFS_FS_ONDEMAND)
+static int erofs_anon_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
+}
+
+struct file_system_type erofs_anon_fs_type = {
+	.name           = "pseudo_erofs",
+	.init_fs_context = erofs_anon_init_fs_context,
+	.kill_sb        = kill_anon_super,
+};
+#endif
+
  static int __init erofs_module_init(void)
  {
  	int err;
--
2.43.5


