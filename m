Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD16156C76
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2020 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBIU4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Feb 2020 15:56:00 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54286 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgBIU4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Feb 2020 15:56:00 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so3274569pjb.4;
        Sun, 09 Feb 2020 12:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+26FYn1Jtrvl0Tdo43WhoX99YiKtnwNRDS1kjmkTi2M=;
        b=t0Vul+D0Xjo3QkfANq67nPW+JcvR+fnNlBs1wiGKUKYAQez/rJl2QQT89j3MTOg6fo
         0ephBTYaZSHyYKWdDq/1wKMVXPpYA8IHTaS94oFhe6WfUGdtzsGqoHHb8k2fUPVzCQzb
         BI0JcrZ8oak/B0fwFWNep5p7PTyTbH7smS569iHlZF4w2usJ6KYvchcRFcQviLZbUAlk
         6wGy4PVuoNehHJEG/bI6oQ45+1qOWCtddYO0u+rVSKI1XqZ+Utcg68a2HmPsmsEqeA3E
         QqFF1cOh/Z8DSxOS5YN+PIlrpKJSTdHieCWG181R5pMl+fInqag4d5qOoJGC7Yg6HkfL
         DZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+26FYn1Jtrvl0Tdo43WhoX99YiKtnwNRDS1kjmkTi2M=;
        b=DVIVs7/vT5GOg87UER7pXC6kt3CBqluGQaNeyeTfwwr3KGjNCqm0jX1lOcRUqEY5s7
         lhzFpZCauaiIhv2Owj1OtjV3TkYa5Rkc02bIjyvIk1h+vVk/idbngsCgfcYZk/4ykR7A
         Uq3KGQqRLUPus5Y7WEeIzk3vcKuauj72t/+aRICDr3I3u39zoCrqXfA8jpt0XdVLELIo
         C8EohrBSm6nPp+wflBPYcOWzXOY8qErxOOQiu8teC31WXA/rwWNPo+z5yCDEh6cRTLBW
         MVdZI2Ms77Mxl90kMsJfG3nAmttVjLY/qrMDqtAScZXI3hVo2GS+pkW/itUTAgmNd6AV
         tTxQ==
X-Gm-Message-State: APjAAAWkuj7tEynLkY2n31XCMftCrMmQr0reaDTeVzfgTIzaW3lyBvIc
        F9xtog/qZa6GszxgH4ZI/ZE=
X-Google-Smtp-Source: APXvYqw8VhcIRxAHx/n78QIiNmOW7ezsRzYLfnmLCgZ6CnDw7qDMRc+fLNCB0O0iNgPsRs/m2r95rw==
X-Received: by 2002:a17:902:b617:: with SMTP id b23mr9796027pls.285.1581281759041;
        Sun, 09 Feb 2020 12:55:59 -0800 (PST)
Received: from localhost.localdomain ([116.126.226.81])
        by smtp.googlemail.com with ESMTPSA id k123sm7075722pgk.48.2020.02.09.12.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 12:55:58 -0800 (PST)
From:   JieunKim <jieun.kim4758@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, JieunKim <jieun.kim4758@gmail.com>
Subject: [PATCH] staging: exfat: Replace printk with pr_info
Date:   Mon, 10 Feb 2020 05:48:10 +0900
Message-Id: <20200209204810.9899-1-jieun.kim4758@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pr_info is preferred to use than printk.
pr_info calls printk with KERN_INFO macros by itself.
---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index b81d2a87b82e..3806036c0ef6 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -364,7 +364,7 @@ static int ffsMountVol(struct super_block *sb)
 	exfat_bdev_open(sb);
 
 	if (p_bd->sector_size < sb->s_blocksize) {
-		printk(KERN_INFO "EXFAT: mount failed - sector size %d less than blocksize %ld\n",
+		pr_info("EXFAT: mount failed - sector size %d less than blocksize %ld\n",
 		       p_bd->sector_size,  sb->s_blocksize);
 		ret = -EINVAL;
 		goto out;
-- 
2.17.1

