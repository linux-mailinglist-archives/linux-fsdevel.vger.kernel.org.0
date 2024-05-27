Return-Path: <linux-fsdevel+bounces-20201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D18CF757
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 03:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B096B281BC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 01:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FFD9463;
	Mon, 27 May 2024 01:47:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667679CC;
	Mon, 27 May 2024 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716774419; cv=none; b=fK7itCB2jYS5XXAHT810qJSadAxmpN/TnGoIcvv+kLziKllhhrKTCjatwTfol8HN2I61/kZi8j5NKmMzfGZ12NMCu8sqqNxvAV1yKu37RlJYfihX01CKbyvpILGCybKi5D98R17HyzN9L2GO5M7ju+hNpcQjIr48lJE7O29orQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716774419; c=relaxed/simple;
	bh=JsbtzFmMrXkiPE+4xeDuM6sPF/ybWU4Z8X620EBPfp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdRR2/aZ2VvNoGDmG+YevfOIhtFfdSfOirQS2x06R8R2LQ+6gItMyXyYJilLx3zlJOQfjEfguC3vdxJXqwrH8KewVyCeh+P6D4oqZmRv22vATqbekA0IsNL2y54gnsl2uEY/J5t2oVdwYBxM2g4QLw0qWcLR2RWEDjAp/BDT1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VndhF1WhLzxQCF;
	Mon, 27 May 2024 09:43:09 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id B0532180AA0;
	Mon, 27 May 2024 09:46:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 09:46:55 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH 4/4] fs: remove fs_lookup_param and its description.
Date: Mon, 27 May 2024 09:47:17 +0800
Message-ID: <20240527014717.690140-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527014717.690140-1-lihongbo22@huawei.com>
References: <20240527014717.690140-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

After `fs_param_is_blockdev` and `fs_param_is_path` are implemented,
there are no need to lookup the path with `fs_lookup_param`, and
`fs_parse` is sufficient.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 Documentation/filesystems/mount_api.rst | 17 +-------
 fs/fs_parser.c                          | 56 -------------------------
 include/linux/fs_parser.h               |  6 ---
 3 files changed, 1 insertion(+), 78 deletions(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index 9aaf6ef75eb5..f92d96758e57 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -253,7 +253,7 @@ manage the filesystem context.  They are as follows:
      will have been weeded out and fc->sb_flags updated in the context.
      Security options will also have been weeded out and fc->security updated.
 
-     The parameter can be parsed with fs_parse() and fs_lookup_param().  Note
+     The parameter can be parsed with fs_parse().  Note
      that the source(s) are presented as parameters named "source".
 
      If successful, 0 should be returned or a negative error code otherwise.
@@ -796,18 +796,3 @@ process the parameters it is given.
      If the parameter isn't matched, -ENOPARAM will be returned; if the
      parameter is matched, but the value is erroneous, -EINVAL will be
      returned; otherwise the parameter's option number will be returned.
-
-   * ::
-
-       int fs_lookup_param(struct fs_context *fc,
-			   struct fs_parameter *value,
-			   bool want_bdev,
-			   unsigned int flags,
-			   struct path *_path);
-
-     This takes a parameter that carries a string or filename type and attempts
-     to do a path lookup on it.  If the parameter expects a blockdev, a check
-     is made that the inode actually represents one.
-
-     Returns 0 if successful and ``*_path`` will be set; returns a negative
-     error code if not.
diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index c41a13e564c4..071c0f9d0121 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -133,62 +133,6 @@ int __fs_parse(struct p_log *log,
 }
 EXPORT_SYMBOL(__fs_parse);
 
-/**
- * fs_lookup_param - Look up a path referred to by a parameter
- * @fc: The filesystem context to log errors through.
- * @param: The parameter.
- * @want_bdev: T if want a blockdev
- * @flags: Pathwalk flags passed to filename_lookup()
- * @_path: The result of the lookup
- */
-int fs_lookup_param(struct fs_context *fc,
-		    struct fs_parameter *param,
-		    bool want_bdev,
-		    unsigned int flags,
-		    struct path *_path)
-{
-	struct filename *f;
-	bool put_f;
-	int ret;
-
-	switch (param->type) {
-	case fs_value_is_string:
-		f = getname_kernel(param->string);
-		if (IS_ERR(f))
-			return PTR_ERR(f);
-		put_f = true;
-		break;
-	case fs_value_is_filename:
-		f = param->name;
-		put_f = false;
-		break;
-	default:
-		return invalf(fc, "%s: not usable as path", param->key);
-	}
-
-	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
-	if (ret < 0) {
-		errorf(fc, "%s: Lookup failure for '%s'", param->key, f->name);
-		goto out;
-	}
-
-	if (want_bdev &&
-	    !S_ISBLK(d_backing_inode(_path->dentry)->i_mode)) {
-		path_put(_path);
-		_path->dentry = NULL;
-		_path->mnt = NULL;
-		errorf(fc, "%s: Non-blockdev passed as '%s'",
-		       param->key, f->name);
-		ret = -ENOTBLK;
-	}
-
-out:
-	if (put_f)
-		putname(f);
-	return ret;
-}
-EXPORT_SYMBOL(fs_lookup_param);
-
 static int fs_param_bad_value(struct p_log *log, struct fs_parameter *param)
 {
 	return inval_plog(log, "Bad value for '%s'", param->key);
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 489c71d06a5f..fa2745254818 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -74,12 +74,6 @@ static inline int fs_parse(struct fs_context *fc,
 	return __fs_parse(&fc->log, desc, param, result);
 }
 
-extern int fs_lookup_param(struct fs_context *fc,
-			   struct fs_parameter *param,
-			   bool want_bdev,
-			   unsigned int flags,
-			   struct path *_path);
-
 extern int lookup_constant(const struct constant_table tbl[], const char *name, int not_found);
 
 #ifdef CONFIG_VALIDATE_FS_PARSER
-- 
2.34.1


