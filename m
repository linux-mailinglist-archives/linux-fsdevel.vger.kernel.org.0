Return-Path: <linux-fsdevel+bounces-19455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72BC8C589F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2447C1C21988
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1592817EB8B;
	Tue, 14 May 2024 15:22:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6256D1A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715700139; cv=none; b=NxfeBEljH2Rp6gkTOB2dDh+aAnp/6pE3oygvqC/z3RJU3MUTdzOGxCVi3I1fTJEs+Z5wKSY/iqHgLx/r9LZLkuhwIvjGWX/iGgX71MYiMuXhD63Pjrm97/GsKNW1ZyWUPzwYWSvGk33T17PDpJyFV4ytbStWoKCdtKMQlhqaz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715700139; c=relaxed/simple;
	bh=nFFymn20w02kg9sppTGmPdI2WOTH7r8QJXaf4SoNPmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rv6eOqJCEl7NhqlsLeFcdCyJ9ZnDDByyWhykQWifb/r/b9FU5VFXPYtJCBw5oQF9Mp619DV6/VxioHlWprVmqVPCY4oICXIUyb8wbrwbr7mzZNB3puZ+AVAdRtQFFsgcZ4+cyciEk7a3NKugfpNOwTl9t81Vm7YCm8xtQAmjbR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a387fbc9so65392066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 08:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715700136; x=1716304936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsCzuGtw3WQzqWSCjWY6/+W9FhDc/Fn0ZAADqBaK58g=;
        b=PRWtU9M4F5UKQOaAQ6yjY7DG52mRAUpt+FZEnYdSTZAJFwlzuHG5RMzWW5e3JKkwRd
         sOrz4NTHPLloU2UNG43Uffd83pj24zs9KPUul/hEOR8g0p55oJdbibM0VYAWgyWUz4rM
         deVAKXb7nt9b5jMkt+zYlagM4RE7WUH0YGH08Htq96CFMbTCOzhLDavXFN5e4srO4DXr
         2bBobdjiJWsx00PNNPGcEn9UWG2J+a9ZN2L8QbyHNMT4XRpvM+cQ2SyKW4JEW/Pa0OTR
         /oVkryVDIvLv21Nbt6ZfhkJJhhSJVQhfpDskkWSThQScAulQPNWrIlCyP4onQOwBAh0F
         1U1w==
X-Gm-Message-State: AOJu0Yz6lHF5ZXKoLMQ4bN3SWI/9GScF/RpuHY8yzIQVzeD0LEwKAkeO
	lGmIvz0IUmSA4o3orqE43PiEQYBrqnHTDgHJ+GkjeMMWMJ+SVJOh4YFnRmUC
X-Google-Smtp-Source: AGHT+IEnAABRCa3Z+oPvF6HYIXbs1Z5QrCNXWzHXbcBDSmny4ywOr5OMZLkPllkCw+8TKlfrMJETyA==
X-Received: by 2002:a17:906:7095:b0:a59:bacc:b07e with SMTP id a640c23a62f3a-a5a2d66a801mr776055766b.59.1715700136246;
        Tue, 14 May 2024 08:22:16 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7e9bsm732203566b.134.2024.05.14.08.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 08:22:15 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: move super block reading from page to folio
Date: Tue, 14 May 2024 17:22:08 +0200
Message-Id: <20240514152208.26935-1-jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Move reading of the on-disk superblock from page to kmalloc()ed memory.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index faf1eb87895d..ebea18da6759 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1111,28 +1111,28 @@ static int zonefs_read_super(struct super_block *sb)
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	struct zonefs_super *super;
 	u32 crc, stored_crc;
-	struct page *page;
 	struct bio_vec bio_vec;
 	struct bio bio;
+	struct folio *folio;
 	int ret;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
+	super = kzalloc(ZONEFS_SUPER_SIZE, GFP_KERNEL);
+	if (!super)
 		return -ENOMEM;
 
+	folio = virt_to_folio(super);
 	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = 0;
-	__bio_add_page(&bio, page, PAGE_SIZE, 0);
+	bio_add_folio_nofail(&bio, folio, ZONEFS_SUPER_SIZE,
+			     offset_in_folio(folio, super));
 
 	ret = submit_bio_wait(&bio);
 	if (ret)
-		goto free_page;
-
-	super = page_address(page);
+		goto free_super;
 
 	ret = -EINVAL;
 	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
-		goto free_page;
+		goto free_super;
 
 	stored_crc = le32_to_cpu(super->s_crc);
 	super->s_crc = 0;
@@ -1140,14 +1140,14 @@ static int zonefs_read_super(struct super_block *sb)
 	if (crc != stored_crc) {
 		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
 			   crc, stored_crc);
-		goto free_page;
+		goto free_super;
 	}
 
 	sbi->s_features = le64_to_cpu(super->s_features);
 	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
 		zonefs_err(sb, "Unknown features set 0x%llx\n",
 			   sbi->s_features);
-		goto free_page;
+		goto free_super;
 	}
 
 	if (sbi->s_features & ZONEFS_F_UID) {
@@ -1155,7 +1155,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_uid));
 		if (!uid_valid(sbi->s_uid)) {
 			zonefs_err(sb, "Invalid UID feature\n");
-			goto free_page;
+			goto free_super;
 		}
 	}
 
@@ -1164,7 +1164,7 @@ static int zonefs_read_super(struct super_block *sb)
 				       le32_to_cpu(super->s_gid));
 		if (!gid_valid(sbi->s_gid)) {
 			zonefs_err(sb, "Invalid GID feature\n");
-			goto free_page;
+			goto free_super;
 		}
 	}
 
@@ -1173,14 +1173,14 @@ static int zonefs_read_super(struct super_block *sb)
 
 	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
 		zonefs_err(sb, "Reserved area is being used\n");
-		goto free_page;
+		goto free_super;
 	}
 
 	import_uuid(&sbi->s_uuid, super->s_uuid);
 	ret = 0;
 
-free_page:
-	__free_page(page);
+free_super:
+	kfree(super);
 
 	return ret;
 }
-- 
2.35.3


