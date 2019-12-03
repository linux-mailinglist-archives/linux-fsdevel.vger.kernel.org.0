Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C072110025
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCOai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 09:30:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41656 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOai (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:30:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id s18so1937809pfd.8;
        Tue, 03 Dec 2019 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=J2Bki53qX313b1AARXHLy2ucszmnsdlQKT35x42nCu8=;
        b=OKCh36lZ9pDx0Y8bc0qMl7g8YiKhOooNxDwawYU4yO7Dq7rTfzWx9N8HEHwFNhc5xS
         kTPmwwfJFv6q3zqRx6wJyoiGlRRuOFDasaCW45wzungTG/Z6ASkTzKO02JOMGEC14Lqx
         8vbjT7THR5CWyoeSy7ZcjBMQgA9Dk9GsLU3wCm58lcK7iYIyyeB/qQfotew+ztsiVO1m
         vBKsh1+FoSFggHoEIRSZtREx/ICfREIqhbLqIyT18zZTVy6ed1YZKrSAf8xsBzLnVAzc
         aUJ0B35mKG5i6A+eTPcK32med0uhmvSTN7NYfC/pH2v50jtJri9OOaYoUwQEipv/UjjD
         U8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=J2Bki53qX313b1AARXHLy2ucszmnsdlQKT35x42nCu8=;
        b=cDjomdguZEnm1wQhAM3LWA1aINvHyp7JqFvNKFotqiwfGTid/ojUdjHxCh6VMtta9Q
         mQ5AiX37Ws173+hRnbcxwmO02u+t8Vcw2hHSJgfGkPveyRzG2HSqxeOdZ+CWaVoKDx1P
         YrkxfW0CXOMx7ohufv5h225s6VjG5dB9LT+7sbQNeIoLgO095s372L33jZPyzfc5rYS8
         eUNKcMrdhzj4VjH79wnDwzFndRemnzpCSxj18MMH1PZRsZi9fHp84PySFR9n8hRG9pZW
         L2QTyojhhPrWZTyAi6ZEl1DQ1y1ihQRhgdFAQPsPI+qCi0LyAl4pLvSKlKtsw+2uDdqj
         y5mQ==
X-Gm-Message-State: APjAAAVS7N9W7FWHppYhZzJTCRRIZFxe2+gNdrc3RyCtQs65HCmOogCe
        jltI/GgZBdD0GyxoMzZHAWk=
X-Google-Smtp-Source: APXvYqxd9orlFfynhShIrO9O1xR/zQV3ibpOIf2jcASyL8fEZuhTT6fLlphL85Wkw/2sKrMEmZkXCw==
X-Received: by 2002:a62:2cd7:: with SMTP id s206mr5081621pfs.106.1575383437811;
        Tue, 03 Dec 2019 06:30:37 -0800 (PST)
Received: from localhost.localdomain ([2406:b400:a2:3691:8da9:a1b8:23c9:e525])
        by smtp.gmail.com with ESMTPSA id z10sm3756468pgg.39.2019.12.03.06.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 06:30:36 -0800 (PST)
From:   Susarla Nikhilesh <nikhilesh1294@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: fix spelling mistake
Date:   Tue,  3 Dec 2019 20:00:23 +0530
Message-Id: <20191203143023.2786-1-nikhilesh1294@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <43e42d774081d2edeaf826845915348209152756>
References: <43e42d774081d2edeaf826845915348209152756>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CHECK: 'propogate' may be misspelled - perhaps 'propagate'?
FILE: drivers/staging/exfat/exfat_super.c:1484

CHECK: 'propogate' may be misspelled - perhaps 'propagate'?
FILE: drivers/staging/exfat/exfat_super.c:1551

Signed-off-by: Susarla Nikhilesh <nikhilesh1294@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 6e481908c59f..d1c1e50fb492 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1481,7 +1481,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 			count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 			if (count < 0) {
-				ret = count; /* propogate error upward */
+				ret = count; /* propagate error upward */
 				goto out;
 			}
 			info->NumSubdirs = count;
@@ -1548,7 +1548,7 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 		count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 		if (count < 0) {
-			ret = count; /* propogate error upward */
+			ret = count; /* propagate error upward */
 			goto out;
 		}
 		info->NumSubdirs += count;
-- 
2.17.1

