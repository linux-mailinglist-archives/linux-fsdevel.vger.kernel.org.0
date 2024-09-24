Return-Path: <linux-fsdevel+bounces-29995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A17F984B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B7E1C23074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85FF1ACDF6;
	Tue, 24 Sep 2024 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="pHGMUCI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE213B58F;
	Tue, 24 Sep 2024 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205848; cv=none; b=bitS/UY5iJhg+sexZDMFaV5+QHxAS0zTiaU4BPfJFdkFUV6aN++E/GwcZffhOB/HTsVcSZFosvpbO5nmXLhUjcecLnX2CHt6GdjVhPY3bvOAvGdIQnibrlfdlQKS4m4jF0tWSHcd2et052nwMo8Z1xOsHgAd8WrDTjvLiWy2I30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205848; c=relaxed/simple;
	bh=oNnGAEcj3/7lfDvnlxPFLGd6H1DIu/5RdpoOHjJidJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOWQvtIhPs5o6EkyxRfj4QvCP8p/RwsjQGuKA4FB8i+EXetHJtKIFbdbckyAoF+qDcKOoZg81A24Uvpdg/NWj7f1g5KQ7qq1BUFpdLND1OKg61xKjtaptDUwigjZ/w/0E4mKGtW8Kr5Nqtyc5vI4C6DuxL6rL8c8Mm7uC6bkVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=pHGMUCI1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XCqXz17g1z9tk3;
	Tue, 24 Sep 2024 21:24:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1727205843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0IK76GF0f4I5CNMIWSRyOvrhnjvYg2BlEw92/pU0RE=;
	b=pHGMUCI1SbCaezK155pQUrkw7MOO99RR2DnBKBiuj9ai1yAperJXhf4mDWFnaEHsjFtqnR
	fUPvUWPaL5HGYg5xnP410C5A18qs4US/ApnYHtvICnJtknqcBRMp2SyGqgr7YV1owfzslM
	2HWZFJglrgFEEEBc6uyCmoKavnVmWkAINzVs+lkORJBe6pAPv9wykT74KCdniO9FnOg3fF
	kO5Gd0soIXj9PPskw40hz+T7HqrqKFwRjVOgxEGwGkiDi3HjxjbpLgcML6Z5IbeMjZZx7f
	RhGok8n8qkMexL5O/rnRVCGSx10WXAW8dKua9iW+X5mVCHsMtabPq5Cu1S+l/g==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kernel@pankajraghav.com,
	Christian Brauner <brauner@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/2] ramfs: add blocksize mount option
Date: Tue, 24 Sep 2024 21:23:50 +0200
Message-ID: <20240924192351.74728-2-kernel@pankajraghav.com>
In-Reply-To: <20240924192351.74728-1-kernel@pankajraghav.com>
References: <20240924192351.74728-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XCqXz17g1z9tk3

From: Pankaj Raghav <p.raghav@samsung.com>

ramfs has only supported blocksize == PAGE_SIZE as page cache's minimum
allocation unit was a PAGE_SIZE.

As the page cache now has minimum folio order support, ramfs can support
different blocksizes.

This is a preparation patch which adds blocksize mount option but still
supporting only blocksize == PAGE_SIZE.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/ramfs/inode.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 8006faaaf0ec7..d846345a0f4b1 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -43,6 +43,7 @@
 
 struct ramfs_mount_opts {
 	umode_t mode;
+	u32 blocksize;
 };
 
 struct ramfs_fs_info {
@@ -221,10 +222,12 @@ static const struct super_operations ramfs_ops = {
 
 enum ramfs_param {
 	Opt_mode,
+	Opt_blocksize,
 };
 
 const struct fs_parameter_spec ramfs_fs_parameters[] = {
 	fsparam_u32oct("mode",	Opt_mode),
+	fsparam_u32("blocksize", Opt_blocksize),
 	{}
 };
 
@@ -254,6 +257,19 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_mode:
 		fsi->mount_opts.mode = result.uint_32 & S_IALLUGO;
 		break;
+	case Opt_blocksize:
+		if (!fsi->mount_opts.blocksize)
+			return -EINVAL;
+
+		fsi->mount_opts.blocksize = rounddown_pow_of_two(result.uint_32);
+
+		if (fsi->mount_opts.blocksize > PAGE_SIZE)
+			fsi->mount_opts.blocksize = PAGE_SIZE;
+
+		if (fsi->mount_opts.blocksize < PAGE_SIZE)
+			fsi->mount_opts.blocksize = PAGE_SIZE;
+
+		break;
 	}
 
 	return 0;
@@ -265,8 +281,8 @@ static int ramfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *inode;
 
 	sb->s_maxbytes		= MAX_LFS_FILESIZE;
-	sb->s_blocksize		= PAGE_SIZE;
-	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_blocksize		= fsi->mount_opts.blocksize;
+	sb->s_blocksize_bits	= ilog2(fsi->mount_opts.blocksize);
 	sb->s_magic		= RAMFS_MAGIC;
 	sb->s_op		= &ramfs_ops;
 	sb->s_time_gran		= 1;
@@ -304,6 +320,7 @@ int ramfs_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	fsi->mount_opts.mode = RAMFS_DEFAULT_MODE;
+	fsi->mount_opts.blocksize = PAGE_SIZE;
 	fc->s_fs_info = fsi;
 	fc->ops = &ramfs_context_ops;
 	return 0;
-- 
2.44.1


