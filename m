Return-Path: <linux-fsdevel+bounces-4630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5B3801685
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF4B1C20AD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16BF3F8CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="c5flg0IY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C578B10D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:08 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db549f869a3so1039729276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468728; x=1702073528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zekUBEhgbNi0HfwU098E6XmEani+U8g9YV01dVhfdc=;
        b=c5flg0IYHONBK1uHnwwDIrSM5tsq5WqkLnNyOeyDZdw4Cek/S8XI1NRW/OH0Z7hmKI
         q2ecoQIh0dImJIihzHPV5bcsrVbwgxhJVF9iCvSoIIN5c1BwdDZB0hSHMc00zldH3USm
         pB2xbEb/h1frpmX/X+Pc1dP0soFnGP/XgUUdprFoDT60Iixn2OYQesTVAvAS/1boN1TI
         FuKw4y6c2IZJrV6jiSfcKA58tLoN1pyspfywI5nOZ92rf/QiDMqjoAc6e5eWtuoCxYYW
         1CseaUPjurqy9/kCyYc+iAuBnVr9v1WzQo1CWBiwPSrZCdYUXGvHQ5EfVkr9v3DjnnIw
         /fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468728; x=1702073528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zekUBEhgbNi0HfwU098E6XmEani+U8g9YV01dVhfdc=;
        b=NJ3RJnpNMwrrWExsPTuUw6Uhk0mgrntnhvRkBVGQLT+lp9xmtQb3Cy/uCROLQG9I6Y
         7wxKhnqpfjGWYWGicqc8i7La0LsZ6tL4ml4pTM3Aj6n4Hv5rn4c1Y5cLatjzfq3CDSu1
         7YNDqmMRq8VRQE9KpgK2WwLwhnCyc9soiYxUeSDwLM5icJQ6lSgcbqBKpArUZsL6Att6
         FlJdC2phTpnIRf9YU8PyJpL+I6//jJ0C+dUibeDHrzEjCmbe8YnSdpTahug+j9RaHI1w
         FUGTKGfSOAV+jbIhAQ8ebZh6KrximCJmaAcO6GmV2YGNCWP6D5inAc3W4lJj48lelowg
         CX6A==
X-Gm-Message-State: AOJu0Yy5SVEh7YGuccZOyVrmSTtZEeLfDEn4WNGEEjRXceGOenbrV2GZ
	RaGIvErJD604id7sYFnPZ0TaukdVSqpCKsnUpOal/A==
X-Google-Smtp-Source: AGHT+IHdXU2/Jh3qAQldWEuZBxSlRBsjxJbIlZeUKBhMVnmgxxxL+0vhQT6tfNT26G7KvrcvZ+lgNw==
X-Received: by 2002:a81:d549:0:b0:5c9:9097:6427 with SMTP id l9-20020a81d549000000b005c990976427mr221928ywj.44.1701468727997;
        Fri, 01 Dec 2023 14:12:07 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w20-20020a81a214000000b005d40a826831sm754821ywg.115.2023.12.01.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 09/46] btrfs: disable various operations on encrypted inodes
Date: Fri,  1 Dec 2023 17:11:06 -0500
Message-ID: <bde2ecbb043a39344d450cd996520e0e40bb8043.1701468306.git.josef@toxicpanda.com>
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

From: Omar Sandoval <osandov@osandov.com>

Initially, only normal data extents will be encrypted. This change
forbids various other bits:
- allows reflinking only if both inodes have the same encryption status
- disable inline data on encrypted inodes

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c   | 3 ++-
 fs/btrfs/reflink.c | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8647d8271b7..108804a5ba82 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -639,7 +639,8 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 size,
 	 * compressed) data fits in a leaf and the configured maximum inline
 	 * size.
 	 */
-	if (size < i_size_read(&inode->vfs_inode) ||
+	if (IS_ENCRYPTED(&inode->vfs_inode) ||
+	    size < i_size_read(&inode->vfs_inode) ||
 	    size > fs_info->sectorsize ||
 	    data_len > BTRFS_MAX_INLINE_DATA_SIZE(fs_info) ||
 	    data_len > fs_info->max_inline)
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f88b0c2ac3fe..c39de2a43a00 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/blkdev.h>
+#include <linux/fscrypt.h>
 #include <linux/iversion.h>
 #include "ctree.h"
 #include "fs.h"
@@ -809,6 +810,12 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 		ASSERT(inode_in->i_sb == inode_out->i_sb);
 	}
 
+	/*
+	 * Can only reflink encrypted files if both files are encrypted.
+	 */
+	if (IS_ENCRYPTED(inode_in) != IS_ENCRYPTED(inode_out))
+		return -EINVAL;
+
 	/* Don't make the dst file partly checksummed */
 	if ((BTRFS_I(inode_in)->flags & BTRFS_INODE_NODATASUM) !=
 	    (BTRFS_I(inode_out)->flags & BTRFS_INODE_NODATASUM)) {
-- 
2.41.0


