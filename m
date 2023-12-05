Return-Path: <linux-fsdevel+bounces-4887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBC6805A16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 17:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943611F217E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FBA60BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnYxFPsD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA01C120
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 08:03:03 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id 98e67ed59e1d1-28659b38bc7so4357517a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 08:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701792183; x=1702396983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKR6jBQYsbLX9HPEoSWQhFmH228TI3vUpTG9biugBZ8=;
        b=TnYxFPsD2SqAxP4jPcOBSu1aYGBOhb75MaUcVkBlt7ueQPNtXX4SHTQ25YbXGnOYKy
         7b7Gk1B+ZjolKoKbYbJyKCkNVeWRxEpk7WJZzqLTwyY9MUWjq27gcrHm/yGQQy+P06mW
         ImeZzZsDEXu3DyKWBruUgKuncImEdcwfWpSrEvMFQtteqmnVk6cfZzfi92VuZdInUUZu
         XfXukGI7kVbOnCrCmDO1Ui5ODCR1xQtE94y3hUrmxWdW/A9qT+v9uJojIWykG5IV6r6v
         dcce0o13snpsRkba7jcxR65EfcBLWg/ddqLud80jRYQPin5CirWTYDvZCTBNbGc2UQFr
         ml9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792183; x=1702396983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKR6jBQYsbLX9HPEoSWQhFmH228TI3vUpTG9biugBZ8=;
        b=q2IGgW+q3xblpgshVsg4YXz+fW/hTEFCQkQF8N+lhW4yVMzq++GYiIbVcjeM6nDVRi
         yGFUStoCCdW2PcramarVWKgJljFNkPzZO1tzxUzCMAp2dKIbZ8VirkXx2p3+w5323/vZ
         jri12REsDj++xQ0S/UvWf1cTV4aEAWLp0rYF7mPNh19gPWWXTQ4aA3/40kGR24OOOTs8
         96lY76xGUxcPHisJ4teHArZ/LMMVumhdgXCBe6AgEgWzIyiox9x35s43WPx8tHrSUY8s
         uk/OvKm+fefSgxXXgqOcAsypHG5iJMksmzmHmk0+5y8MZqUVJDmz1pAnhevwYrf92iaM
         LGNQ==
X-Gm-Message-State: AOJu0YyUb6cQOz75TBF5fJbgWkIDYN/7JJFFg8QfSNKpQBhKNXGsgnhC
	n4ncu4elvokJe7I76WXxvewZv0t3I1+/4B3D/jBPPA==
X-Google-Smtp-Source: AGHT+IET6iOJYhwKm7sWWHKT6oSFuHKO0DBIgOk5Bs5JIYc/WrmdopmiqDlzA42bWmKyAYqw4YbNcg==
X-Received: by 2002:a17:90a:bf05:b0:286:6cc0:cabd with SMTP id c5-20020a17090abf0500b002866cc0cabdmr1469563pjs.52.1701792182956;
        Tue, 05 Dec 2023 08:03:02 -0800 (PST)
Received: from localhost ([2409:8a3c:3647:2160:38b2:24ff:fe76:bb76])
        by smtp.gmail.com with ESMTPSA id jg11-20020a17090326cb00b001d078445059sm6302468plb.143.2023.12.05.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:03:02 -0800 (PST)
From: John Sanpe <sanpeqf@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	Wataru.Aoyama@sony.com,
	cpgs@samsung.com,
	John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH v3] exfat/balloc: using hweight instead of internal logic
Date: Tue,  5 Dec 2023 23:58:37 +0800
Message-ID: <20231205155837.1675052-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the internal table lookup algorithm with the hweight
library, which has instruction set acceleration capabilities.

Use it to increase the length of a single calculation of
the exfat_find_free_bitmap function to the long type.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 fs/exfat/balloc.c | 48 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index e918decb3735..69804a1b92d0 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -5,11 +5,22 @@
 
 #include <linux/blkdev.h>
 #include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <linux/buffer_head.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
+#if BITS_PER_LONG == 32
+# define __le_long __le32
+# define lel_to_cpu(A) le32_to_cpu(A)
+#elif BITS_PER_LONG == 64
+# define __le_long __le64
+# define lel_to_cpu(A) le64_to_cpu(A)
+#else
+# error "BITS_PER_LONG not 32 or 64"
+#endif
+
 static const unsigned char free_bit[] = {
 	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 4, 0, 1, 0, 2,/*  0 ~  19*/
 	0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0, 5, 0, 1, 0, 2, 0, 1, 0, 3,/* 20 ~  39*/
@@ -26,22 +37,6 @@ static const unsigned char free_bit[] = {
 	0, 1, 0, 2, 0, 1, 0, 3, 0, 1, 0, 2, 0, 1, 0                /*240 ~ 254*/
 };
 
-static const unsigned char used_bit[] = {
-	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3,/*  0 ~  19*/
-	2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4,/* 20 ~  39*/
-	2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5,/* 40 ~  59*/
-	4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5,/* 60 ~  79*/
-	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4,/* 80 ~  99*/
-	3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6,/*100 ~ 119*/
-	4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4,/*120 ~ 139*/
-	3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6,/*140 ~ 159*/
-	2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5,/*160 ~ 179*/
-	4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4, 5,/*180 ~ 199*/
-	3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6,/*200 ~ 219*/
-	5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7,/*220 ~ 239*/
-	4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7, 8             /*240 ~ 255*/
-};
-
 /*
  *  Allocation Bitmap Management Functions
  */
@@ -244,25 +239,24 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
 	unsigned int count = 0;
 	unsigned int i, map_i = 0, map_b = 0;
 	unsigned int total_clus = EXFAT_DATA_CLUSTER_COUNT(sbi);
-	unsigned int last_mask = total_clus & BITS_PER_BYTE_MASK;
-	unsigned char clu_bits;
-	const unsigned char last_bit_mask[] = {0, 0b00000001, 0b00000011,
-		0b00000111, 0b00001111, 0b00011111, 0b00111111, 0b01111111};
+	unsigned int last_mask = total_clus & (BITS_PER_LONG - 1);
+	unsigned long *bitmap, clu_bits;
 
 	total_clus &= ~last_mask;
-	for (i = 0; i < total_clus; i += BITS_PER_BYTE) {
-		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
-		count += used_bit[clu_bits];
-		if (++map_b >= (unsigned int)sb->s_blocksize) {
+	for (i = 0; i < total_clus; i += BITS_PER_LONG) {
+		bitmap = (void *)(sbi->vol_amap[map_i]->b_data + map_b);
+		count += hweight_long(*bitmap);
+		map_b += sizeof(long);
+		if (map_b >= (unsigned int)sb->s_blocksize) {
 			map_i++;
 			map_b = 0;
 		}
 	}
 
 	if (last_mask) {
-		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
-		clu_bits &= last_bit_mask[last_mask];
-		count += used_bit[clu_bits];
+		bitmap = (void *)(sbi->vol_amap[map_i]->b_data + map_b);
+		clu_bits = lel_to_cpu(*(__le_long *)bitmap);
+		count += hweight_long(clu_bits & BITMAP_LAST_WORD_MASK(last_mask));
 	}
 
 	*ret_count = count;
-- 
2.43.0


