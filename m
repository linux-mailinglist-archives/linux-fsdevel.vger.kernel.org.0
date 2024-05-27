Return-Path: <linux-fsdevel+bounces-20212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF4E8CFABF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A6E1C20E9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890060DCF;
	Mon, 27 May 2024 07:58:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE23BB59;
	Mon, 27 May 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796705; cv=none; b=DnEMGgaodBCbtCUytUv47QNkTxxJkDP3lnxCZXAO751KqQDbx15LXhCVu2DqycKRrAFKyARic2FZRkV9guv4ndsLiyClKYkvbqJ8Da5K6KQuxFIZ0ZTzP05Txxt0HkDOXfZZ37uJWZntawbSZUI2EF/3mEVjFbtAEz11uH85Fwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796705; c=relaxed/simple;
	bh=2pQ8OpyCvyPiThTNccORsiIJoUK+PlaXD5ACjqKjx/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUFBaoDbgGS8WEkb+S/NrsaOxxoKTZkXewyKxqiTGCqz45CypkaTIjdowE/EUbUHzV/HkP6f7SWqzaCukmDy+kbPhrzGvcP0rRVzeeHfEdjvTs8nCa9FyU1GSLsBLnpFN9geYi9jRQBElevbrfklN7FoG4fD3wPHW5UqXMBZL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VnnxT3wyVz1ysVv;
	Mon, 27 May 2024 15:55:09 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 894C81A0188;
	Mon, 27 May 2024 15:58:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 27 May
 2024 15:58:16 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC: <lczerner@redhat.com>, <cmaiolino@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yi.zhang@huawei.com>, <lihongbo22@huawei.com>
Subject: [PATCH v2 4/4] fs: remove fs_lookup_param and its description.
Date: Mon, 27 May 2024 15:58:54 +0800
Message-ID: <20240527075854.1260981-5-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527075854.1260981-1-lihongbo22@huawei.com>
References: <20240527075854.1260981-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
index 5d0adcc514d8..962adb1fec80 100644
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


