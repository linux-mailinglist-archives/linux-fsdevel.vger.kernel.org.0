Return-Path: <linux-fsdevel+bounces-29996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C247984B82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D6B1C23023
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 19:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80211A4F0C;
	Tue, 24 Sep 2024 19:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="quld+fji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD612D1F1;
	Tue, 24 Sep 2024 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205856; cv=none; b=lX6lkPjH38uIK1L0PRSMIIQqzeN2jfa5GJJyT8BD1cS0OGYO8GBJu1apqmF2PmzE4kn2AqRe8tHXmX3Xpvnxmms3m6vbG01EVxzWjOBSexuniSxoud/8G9zYmZGujlvNz/qQGied7/2zqjoBRaIF/46FtK/ZKZE0ASHwBKhWdck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205856; c=relaxed/simple;
	bh=0s6cwSvjN7F3YMoaMLVmKNEbM2+8ApQcoGW6ym8fUzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+brqOhzVe5fIpA5bGliMuvB4WBqoUH01K0G1v/JpjPZQtglFBDhggPLE1n3Ss7cDHluxQh/eQ5ojw31P/Lp807GWB+V4mHUxYURNBQom11RI60Z6MA9xY4Pm4tRy6Bm+LG1L0x2t1QQCXklPceI49h/rK0MvJ86fEI/j/bSktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=quld+fji; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XCqY12xnYz9tYw;
	Tue, 24 Sep 2024 21:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1727205845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U09YIrJ1rTrNYNR6aljoqFaAa55MjJXw4x7cHzq7sa4=;
	b=quld+fji3c9zZ+Xaqhwneoqyr9jMcU020sND0mwU3HSyVmOHUgD5FyaRBZXpLTNKbzGunl
	Gp7DnrMIihzukfQQccI59Dv1WtKaHYY6UMTpRZe0iV4gU621WggifOwkxzkfbEyPaa2hsS
	Rlqv/5IED284FCTAIi71Oq4ex8AzZSVdPy81B4CjrMJP74hNDKd+pIq7Zl1jJRhnv3xtOT
	v5h3F6eFdtSl7jt+xLi6GrVAcRnYpjylXEtsFtA050o8GXac8tNgAIhbac+4BkAn75Pztg
	N9cw6yDZCCPd+IGq5Bl9rBN/OLr+iYRUKLSVAfqwX0CytwJjWmgBY0w5Tw/64w==
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
Subject: [PATCH 2/2] ramfs: enable block size > page size
Date: Tue, 24 Sep 2024 21:23:51 +0200
Message-ID: <20240924192351.74728-3-kernel@pankajraghav.com>
In-Reply-To: <20240924192351.74728-1-kernel@pankajraghav.com>
References: <20240924192351.74728-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Use page cache's minimum folio order infrastructure to support block
size > page size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/ramfs/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index d846345a0f4b1..5ac41115d9c62 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -74,6 +74,9 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 		case S_IFREG:
 			inode->i_op = &ramfs_file_inode_operations;
 			inode->i_fop = &ramfs_file_operations;
+			mapping_set_folio_min_order(inode->i_mapping,
+						    sb->s_blocksize_bits -
+							    PAGE_SHIFT);
 			break;
 		case S_IFDIR:
 			inode->i_op = &ramfs_dir_inode_operations;
@@ -211,6 +214,8 @@ static int ramfs_show_options(struct seq_file *m, struct dentry *root)
 
 	if (fsi->mount_opts.mode != RAMFS_DEFAULT_MODE)
 		seq_printf(m, ",mode=%o", fsi->mount_opts.mode);
+	if (fsi->mount_opts.blocksize != PAGE_SIZE)
+		seq_printf(m, ",blocksize=%u", fsi->mount_opts.blocksize);
 	return 0;
 }
 
@@ -235,6 +240,7 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct fs_parse_result result;
 	struct ramfs_fs_info *fsi = fc->s_fs_info;
+	size_t max_blocksize = mapping_max_folio_size_supported();
 	int opt;
 
 	opt = fs_parse(fc, ramfs_fs_parameters, param, &result);
@@ -263,8 +269,8 @@ static int ramfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 		fsi->mount_opts.blocksize = rounddown_pow_of_two(result.uint_32);
 
-		if (fsi->mount_opts.blocksize > PAGE_SIZE)
-			fsi->mount_opts.blocksize = PAGE_SIZE;
+		if (fsi->mount_opts.blocksize > max_blocksize)
+			fsi->mount_opts.blocksize = max_blocksize;
 
 		if (fsi->mount_opts.blocksize < PAGE_SIZE)
 			fsi->mount_opts.blocksize = PAGE_SIZE;
-- 
2.44.1


