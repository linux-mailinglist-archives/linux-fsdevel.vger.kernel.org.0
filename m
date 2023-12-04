Return-Path: <linux-fsdevel+bounces-4717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF4802A52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 03:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0EDB207D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA258F60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5Kov8FW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F28D9
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Dec 2023 18:23:30 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6cdfcef5f8aso1534291b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Dec 2023 18:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701656610; x=1702261410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3xNcKrD9dea+UteRRTX24fJHEgiyJLePFuQNFjZYig=;
        b=j5Kov8FWlOBmO5kuJr9RHuTH3KhmPSWo2Q6k4hiddBFBohVHkzR2V1+oR/xs2MweQt
         wA2To57NOWyj2K6MVdIRksy2UjgiGEx2OoOPXZRk+xa2BBpxF76YSn8xsynEFI0pCm1z
         qkRI2nazCcLm119/YhXtycyr47/TGH4VwOjcp+MUmEEhOPHarUIUvcIkZB87MFd9z5hy
         8gAkUuTqNwZul7fvB/VgIlY/kC2ch65nH7YbtPEMqmw6XEXZsRXWmJPfmGW3Dstc2Rg1
         iuPiEp84AZxlJL6/sdF4hbNnLlDX9l6mbchh03GhPuVIFnwgRZOX7kusTzRLlj/JoWLS
         N8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701656610; x=1702261410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3xNcKrD9dea+UteRRTX24fJHEgiyJLePFuQNFjZYig=;
        b=LRrp2F5H5n8BJCbKTkuA3vOe55BfhUZjSeEY1LCGN2GCoEf6OX6YcfPVogxshndV+v
         3H0lJO4OHe3EOr4/Rcct9LvssyJ5GifunUdyrlef7bLUnygSl4zvi/4NLHbFZSCFdnkl
         80rHV6SuCUhkqRLbejfZHyk8kzaEem0t27rawgp1qK5wE4cio9eM9KK9+6UaEPVP13sz
         /DqC/KOzMuamvLQk3Ol5GSgRnY4hIYX7sH58g07d9Fz0/ceH3VK6kPQpT3mxXpMeFVsX
         1LharBsgwZqcGhaJGV4Ao3AFMQ/CCUFsijgoHxsDt+nKy975Zfh2TyUd8AXLhASM9dHI
         +6uQ==
X-Gm-Message-State: AOJu0YwhQn8CgkuoxlrdjHpH7f1R/ePzsesmh8WxZeIJ4eYkd/AaxKg4
	Ma2Xt0dwfAdZ9Gk+Gu8MeaLvZEtGXSv17zDAvmdQ/w==
X-Google-Smtp-Source: AGHT+IFob2x1IlfccG5Yn8mEV5LVcL5pNeQV9xOip2L1/RX+gYVNHpzB4RoP/NGMw3wV7MvC7kSfVQ==
X-Received: by 2002:a05:6a20:12c3:b0:18f:97c:5b83 with SMTP id v3-20020a056a2012c300b0018f097c5b83mr830002pzg.81.1701656610280;
        Sun, 03 Dec 2023 18:23:30 -0800 (PST)
Received: from localhost ([2409:8a3c:3647:2160:38b2:24ff:fe76:bb76])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b001d07f28461esm2584247plh.279.2023.12.03.18.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 18:23:30 -0800 (PST)
From: John Sanpe <sanpeqf@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Andy.Wu@sony.com,
	Wataru.Aoyama@sony.com,
	cpgs@samsung.com,
	John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] exfat/balloc: using hweight instead of internal logic
Date: Mon,  4 Dec 2023 10:22:58 +0800
Message-ID: <20231204022258.1297277-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the internal table lookup algorithm with the hweight
library, which has instruction set acceleration.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 fs/exfat/balloc.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index e918decb3735..3ca1f40237ad 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -26,22 +26,6 @@ static const unsigned char free_bit[] = {
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
@@ -252,7 +236,7 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
 	total_clus &= ~last_mask;
 	for (i = 0; i < total_clus; i += BITS_PER_BYTE) {
 		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
-		count += used_bit[clu_bits];
+		count += hweight8(clu_bits);
 		if (++map_b >= (unsigned int)sb->s_blocksize) {
 			map_i++;
 			map_b = 0;
@@ -262,7 +246,7 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count)
 	if (last_mask) {
 		clu_bits = *(sbi->vol_amap[map_i]->b_data + map_b);
 		clu_bits &= last_bit_mask[last_mask];
-		count += used_bit[clu_bits];
+		count += hweight8(clu_bits);
 	}
 
 	*ret_count = count;
-- 
2.43.0


