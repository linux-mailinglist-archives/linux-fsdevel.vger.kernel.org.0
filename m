Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C51B158EB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 13:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgBKMlK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 07:41:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgBKMlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so5468197pfc.1;
        Tue, 11 Feb 2020 04:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OG3I8u1BtQ4O9rV9GY+FzQTWCyxjIaclYE/ENRCShQ8=;
        b=HLOD7EcgD8fNUAboICtjctQfRY8PFaAl4y583wpQIelBhhlNFszqkyU1Yj9w42eO2F
         lVZpl2VfJgKlrINOE6AeD45iNQT1RLsNItFN1NXLfxgkqOFu4pH5fyE8mG01/iESrZMC
         vbAf4lITfsnxkGkdOBjvNuC38GrE12x6NwO1zZTFeVfJY+oSYr8rCkyMzIo2SCywjBJF
         X/+T10M6BbXeoUa2wLsamgNyq5DAz2GMfr8kFKEYvhXQjl42qYQmmQ16PwlBRlHxaUft
         Ze5zBaw4gnQKS/b8eQ3lx8xaXU0n5TQ5b3frMKkxnuh6sMgLD5yWAWuI2Gz1SDs2DJNr
         yATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OG3I8u1BtQ4O9rV9GY+FzQTWCyxjIaclYE/ENRCShQ8=;
        b=lbiwEVxfM0eWsArrNHwU1dkdDhfkGqjvY/u5/vwOWyF2BNGa0FB8P9y/5DOIOZK7me
         s60zvwCRUYOKVIVkgCdexva3rAA/sTtlnom8ih1G9gaOzjqpA9tcbIEqykEfO7nJ1G3w
         PV7billcrwQ7ntTY5+Cdn8xHIQXwJKrvFXHAlvgJgfFcQCyqiDlZk63GHuMadLJO45kA
         9FQFaNgJKbAHpqh6Nz9YVZsf8n1xRO3bjYrSVLR11RrIS6JyVIm8qbR3+scp0HsUR3OO
         9Ace+9l/qVVOQnkTaxPMaEBJNzdwdXLYDPK4//EUHY2i2EJpFtvFYUmMEHGJC3DLgEzF
         xNZg==
X-Gm-Message-State: APjAAAVJa50RorIEfz+XSn9DCR43j3QMfse+QtKUul9FALD/gqF/p/pT
        rsZBqsWmlOE/qVJhCm4RlbbMN9J3tvs=
X-Google-Smtp-Source: APXvYqyaVllHPFWdIBZNuHzH1mtLPLmniZsElBuH4IFElvC8CM7gTjB8Ldnssx9rRS3Kutgip5Q2NQ==
X-Received: by 2002:a63:131f:: with SMTP id i31mr4067979pgl.101.1581424868948;
        Tue, 11 Feb 2020 04:41:08 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:08 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 09/18] staging: exfat: Rename function "ffsTruncateFile" to "ffs_truncate_file"
Date:   Tue, 11 Feb 2020 18:08:50 +0530
Message-Id: <20200211123859.10429-10-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsTruncateFile" to
"ffs_truncate_file" in source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index d4e6f6a210e9..5bbd31e6ba3c 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1031,7 +1031,7 @@ static int ffs_write_file(struct inode *inode, struct file_id_t *fid,
 	return ret;
 }
 
-static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
+static int ffs_truncate_file(struct inode *inode, u64 old_size, u64 new_size)
 {
 	s32 num_clusters;
 	u32 last_clu = CLUSTER_32(0);
@@ -2763,7 +2763,7 @@ static void exfat_truncate(struct inode *inode, loff_t old_size)
 	if (EXFAT_I(inode)->fid.start_clu == 0)
 		goto out;
 
-	err = ffsTruncateFile(inode, old_size, i_size_read(inode));
+	err = ffs_truncate_file(inode, old_size, i_size_read(inode));
 	if (err)
 		goto out;
 
-- 
2.17.1

