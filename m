Return-Path: <linux-fsdevel+bounces-20063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD7F8CD690
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7A9B215BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26A79E0;
	Thu, 23 May 2024 15:03:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471F6FA8
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476588; cv=none; b=Xa62rCZXm/p2TpvZh22L4ZZs7/zABSwD0N/2KgGt02teDU7G49ooMXd7a0Ys0za7l0PJX31IjJMuExbIZFsFEB42PbdwRaUw1mks699eryck9IM6bVloKf3Q32OSENoCYtC2GZ+DRrO7t49doDqbbwi8qAZ3hGFsWzGOdjwIzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476588; c=relaxed/simple;
	bh=twdAQSQ4pY1IrTJShZdtFLlpbzih4TYlorJR0qG7QSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUTMn5o2xm3yKCgZQoVMYqFiYhjWj/IZHx4L1yUCUYsy/ZwhNKsH82YIXZO8GPvwCd0Z477RULZe+iYbJfgVHwgtaqk8hKngjYjCTXtRyMtaCvZzckP9ptIr33wsicLYUMwEiUCQGBOigawfm6w66won8iwwipB+O/oPEgjsgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fd5dc0439so21630985e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 08:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476585; x=1717081385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQ78SQgBj4W2Av8YJDAEJ0IvBwRvPOsoy8bHefpPz4I=;
        b=Z1jf0AG0+TUiJsUKiMAWubBa4Dsd3s1ROHDSQdBoJKATdcT3Wx2jy1LryKG5PuPUw5
         /qr9wDLOxKHcYwVpw4oEh83eASRi8Z5pIM0CIDlsWWrLaSK3YNXbh0yA4KW8bN8+a9+t
         YuvTjfLSOse1V5olzy8W7o3wSsWD/8vMzj4Z0H6GJ8EJ5srd2UOM1+WpI2okai/wYhAV
         KmD2ezsP6KWRzpOSgs4a1dchejNQ2J7Egy463BYhBDpqspUW1byuyINheeKb1yJuA1Ej
         RdePJJbnmwyPQeqpqZxNFLCmMF0jq3/KaE/LZWIy+n27lw0U88lOu1XjnI3KiXSm9TnW
         TUUA==
X-Gm-Message-State: AOJu0Yx4mnJdIRXedlCdi2HSTLcroqCjuvqotAY2wknl98NIJ5oUKeQx
	Cvy42/dUTThFp++vtD9H9IIgwMoXHmcsBh57KbKDP8m/Kj4DHQbL
X-Google-Smtp-Source: AGHT+IGZZ8QelYL8v2CH7Z7VYLvuyrz4smburQkxmoLzqRumHIKNt0gWNtEZeT5sC1O1ybJ34Ryprw==
X-Received: by 2002:a7b:ce0f:0:b0:420:215c:b010 with SMTP id 5b1f17b1804b1-420fd38064bmr38160405e9.41.1716476584416;
        Thu, 23 May 2024 08:03:04 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f709b700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f709:b700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100fad965sm27646255e9.34.2024.05.23.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 08:03:03 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3] zonefs: move super block reading from page to folio
Date: Thu, 23 May 2024 17:02:53 +0200
Message-ID: <20240523150253.3288-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Move reading of the on-disk superblock from page to folios.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Changes to v2:
- Rebase onto Linus' master
- Remove now unused varuabls
- Return read_mapping_folio()s error in case it fails

 fs/zonefs/super.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb87895d..e2bb7556a364 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1109,30 +1109,21 @@ static int zonefs_init_zgroups(struct super_block *sb)
 static int zonefs_read_super(struct super_block *sb)
 {
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct address_space *address_space = sb->s_bdev->bd_mapping;
 	struct zonefs_super *super;
 	u32 crc, stored_crc;
-	struct page *page;
-	struct bio_vec bio_vec;
-	struct bio bio;
+	struct folio *folio;
 	int ret;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-
-	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = 0;
-	__bio_add_page(&bio, page, PAGE_SIZE, 0);
-
-	ret = submit_bio_wait(&bio);
-	if (ret)
-		goto free_page;
+	folio = read_mapping_folio(address_space, 0, NULL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	super = page_address(page);
+	super = folio_address(folio);
 
 	ret = -EINVAL;
 	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
-		goto free_page;
+		goto put_folio;
 
 	stored_crc = le32_to_cpu(super->s_crc);
 	super->s_crc = 0;
@@ -1140,14 +1131,14 @@ static int zonefs_read_super(struct super_block *sb)
 	if (crc != stored_crc) {
 		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
 			   crc, stored_crc);
-		goto free_page;
+		goto put_folio;
 	}
 
 	sbi->s_features = le64_to_cpu(super->s_features);
 	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
 		zonefs_err(sb, "Unknown features set 0x%llx\n",
 			   sbi->s_features);
-		goto free_page;
+		goto put_folio;
 	}
 
 	if (sbi->s_features & ZONEFS_F_UID) {
@@ -1155,7 +1146,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_uid));
 		if (!uid_valid(sbi->s_uid)) {
 			zonefs_err(sb, "Invalid UID feature\n");
-			goto free_page;
+			goto put_folio;
 		}
 	}
 
@@ -1164,7 +1155,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_gid));
 		if (!gid_valid(sbi->s_gid)) {
 			zonefs_err(sb, "Invalid GID feature\n");
-			goto free_page;
+			goto put_folio;
 		}
 	}
 
@@ -1173,14 +1164,14 @@ static int zonefs_read_super(struct super_block *sb)
 
 	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
 		zonefs_err(sb, "Reserved area is being used\n");
-		goto free_page;
+		goto put_folio;
 	}
 
 	import_uuid(&sbi->s_uuid, super->s_uuid);
 	ret = 0;
 
-free_page:
-	__free_page(page);
+put_folio:
+	folio_put(folio);
 
 	return ret;
 }
-- 
2.43.0


