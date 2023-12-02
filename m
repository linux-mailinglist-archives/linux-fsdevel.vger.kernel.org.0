Return-Path: <linux-fsdevel+bounces-4673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81413801B04
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 07:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14ED281D9D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994ABBE5D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpdppZly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026C7D7E;
	Fri,  1 Dec 2023 20:53:21 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d84ddd642fso890500a34.0;
        Fri, 01 Dec 2023 20:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701492800; x=1702097600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9g00jP/4ER4tvLxbzE6HDHKcIJJYt8aypBEvbdrc17k=;
        b=cpdppZlyUEchk0TDhcIEjFfE2eKfIjmOY+fa1mTgvF2efLV/gPN4TYq9d3N56g7Cfd
         JAkU6SW0bqP5HQCwHHd1pVzBUjait3hvm8AxaGW5nx+Cz+7bHvVXxv2EvGK/Q+ad3CRz
         NNVagUiXLuOC7CaclVnBhxUsmbiXJRrlTrB0ERMF6xWqzOlMyxPaUOJK5lleZUeJETaH
         CT/nm/HGywZwqicQ846lejU3RhIUvDKds9i/Q2CXfXCiCYX8Ob55yUdMGTuGt751DuXh
         GXgY2wjt7Frx3OPnB92bx+MGshHqRBYQ1qqILcr0Mh7QmVbkkfCuJUrXfxbwmJxCXJoI
         eYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701492800; x=1702097600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9g00jP/4ER4tvLxbzE6HDHKcIJJYt8aypBEvbdrc17k=;
        b=LGtbhY0QhWu0gpMg8uS1EmMIISL07BnW7FK3Vf2Ih/FQkC5uTohS2kVGXXntoRrmeD
         F+7rjZq+LuKEMeGzIx2TvGmP2j4wluJ2uxgI9u3OFaEu3Nj7CswKFdX3IgY3sbaPACI0
         E1pfOV7KEwA4bzOCBNQ7qC+OT8/kxZfEMzSIVdBDz4NhaO8XVHrdZ+PIeRDELAqDMqp1
         HvSgsGem5INmiJGMD94AyY/Uy2Zh29L8EkwvwKX4VIlx7xXf3fMdazWsyO5j8d/bI8ZN
         x3yxSn1vkAzmVYmat7P/S+lL//Gqm4pwaqDof9Jl8A1i6t+t/f4kmv6cWLNAerEUQHw3
         o8Ag==
X-Gm-Message-State: AOJu0YwcBq5GLah7Z6r/0Yu8eEe6CrKP/p4LZKTGQJlkXGN3XEKBwE7z
	tRfHqdb24hKu+VRxfr6o8ng=
X-Google-Smtp-Source: AGHT+IGaSV0dyhSOKH3ZvNE2tXOOqQtw0bQfuxSB8I7fOHq/OZKK+SJre6OrROocYZSWQcf4+l72ww==
X-Received: by 2002:a05:6359:7414:b0:170:17eb:9c56 with SMTP id va20-20020a056359741400b0017017eb9c56mr605212rwb.55.1701492800109;
        Fri, 01 Dec 2023 20:53:20 -0800 (PST)
Received: from attreyee-HP-Pavilion-Laptop-14-ec0xxx.. ([60.243.28.47])
        by smtp.gmail.com with ESMTPSA id gz9-20020a17090b0ec900b002839679c23dsm4024319pjb.13.2023.12.01.20.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:53:19 -0800 (PST)
From: attreyee-muk <tintinm2017@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: attreyee-muk <tintinm2017@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Tried making changes
Date: Sat,  2 Dec 2023 10:09:00 +0530
Message-Id: <20231202043859.356901-1-tintinm2017@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Respected Maintainers, 

I have tried to solve the bug - UBSAN: shift-out-of-bounds in exfat_fill_super, reported by Syzbot [link - https://syzkaller.appspot.com/bug?extid=d33808a177641a02213e]

Since it didn't have a reproducer, I wasn't able to test the patch
before sending to the maintainers.

The issue is in line 503 of fs/exfat/super.c - by analyzing the code, I
understood that the it is checking if the calculated size of the exFAT
File Allocation Table is very small as compared to the expected
size,based on the number of clusters. If the condition is met, then an
error will be logged. But here inside the if statement, I believe that
the value of number of bits in sbi->num_FAT_sectors ,at some point is
coming more than the value of p_boot->sect_size_bits. As a result, a
shift-out-of-bounds error is being generated. 

I tried using the hweight_long() to find the number of bits in
sbi->num_FAT_sectors in advance and then perform the left shift
operation only if it's total number of bits is greater than or equal to
the value of p_boot->sect_size_bits. 

I think that a new else statement should also be included with that and
I will do that once I get some help from the maintainers and get to know if I
am thinking in the right direction. 
Requesting the maintainers to go through the code once and kindly help me in understanding whether I am 
I am doing it wrong or if I need to add some more things. 

Thank you
Attreyee Mukherjee

Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>
---
 fs/exfat/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index d9d4fa91010b..0d526d9f3e5e 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -18,6 +18,7 @@
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
 #include <linux/magic.h>
+#include <linux/bitops.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -500,11 +501,18 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
 
 	/* check consistencies */
-	if ((u64)sbi->num_FAT_sectors << p_boot->sect_size_bits <
+	u64 num_fat_sectors_u64 = (u64)sbi->num_FAT_sectors;
+	unsigned long num_bits = hweight_long(num_fat_sectors_u64);
+
+	if(num_bits>=p_boot->sect_size_bits){
+
+		if ((u64)sbi->num_FAT_sectors << p_boot->sect_size_bits <
 	    (u64)sbi->num_clusters * 4) {
 		exfat_err(sb, "bogus fat length");
 		return -EINVAL;
+		}
 	}
+	
 
 	if (sbi->data_start_sector <
 	    (u64)sbi->FAT1_start_sector +
-- 
2.34.1


