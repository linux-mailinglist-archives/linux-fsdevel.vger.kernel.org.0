Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA315718A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 10:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJJVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 04:21:20 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52201 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBJJVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:21:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so3947272pjb.1;
        Mon, 10 Feb 2020 01:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f3PX1moHFrKZPID9Zj4amuiBq7DdkwwK6egdyOalClc=;
        b=QnQ2Pu8lpasBZ+G1l3xLi1yIiPkVl8JZ6P1tPi2uxADrRo9sQmvr7+7LS7wc8M5Ush
         6cC4R7F6WLRJJIuMmXTmFiTMVjpgmZpPm/QjcAnzjCO45pgBWyNh/74xP/FpU8OxJl+R
         Ilnbe+YnghHTV7Z/t3OmWwPzwo3k2WblyNNxIYNLV6oZXPiZpLQP5chQ7iBK5AH1Hp1Y
         rwelX51HaM0xPz/AURYfADQ9M5gFoJr6dfD23xDB3DQOQjXUiFUH3XhRgt/quJNUmATB
         2edvO2kdOLVLNWGGELtHyxbPuw2DFFWG+4hvz1lK3wsqM/nrvNDvZvbFnxhmTxWAZguD
         wuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f3PX1moHFrKZPID9Zj4amuiBq7DdkwwK6egdyOalClc=;
        b=c5o1ShYP1hPptZbiz+FQK+qw7PkAoaYEFzyKVswy8p7m/OuPdJxN/RNn0f7gEquBqY
         n5nSVACep6iKSy4zju1EIPG/6jFQr+o71hDpOUzG4fhjokjCBmbeTXuOJqkkrj/jzPTd
         gus/ARK5zgWjIcKyj+jPx5p5punQxD6TRafPFpInZABC+KPcY8mOCJnWVrymo+SKF0kS
         S7yUn/ca+7E6/c3bL0oJ5++7ZKYOmkEE6I1twn2ZmJksMRa6gNA1+TP/p4nQR483jX2c
         wibJXiH6yQLdV4DS6a59/gzcImMWvEBoiJWdyi147q00ftz26EECbvm2NgdAx8S9vO56
         19qA==
X-Gm-Message-State: APjAAAVDVAg5T5WxbDbYXgpKLrcxWIo3TL1Z3pNixC3j+EW7uqChYbNt
        dyRjwzo2BgQlm6/bVOs7DJ4=
X-Google-Smtp-Source: APXvYqx3OfZsnRTon5ZuFohlPcKROhm+lKXTEEwlOSP1DbEPiowcEjdZvVM7ZXraZN1ETABz3DTebw==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr596897pjn.141.1581326479064;
        Mon, 10 Feb 2020 01:21:19 -0800 (PST)
Received: from localhost.localdomain ([116.126.226.81])
        by smtp.googlemail.com with ESMTPSA id x143sm12331079pgx.54.2020.02.10.01.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 01:21:18 -0800 (PST)
From:   JieunKim <jieun.kim4758@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, JieunKim <jieun.kim4758@gmail.com>
Subject: [PATCH] staging: exfat: Replace printk with pr_info
Date:   Mon, 10 Feb 2020 18:14:20 +0900
Message-Id: <20200210091421.12335-1-jieun.kim4758@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pr_info is preferred to use than printk.
pr_info calls printk with KERN_INFO macros by itself.

Signed-off-by: JieunKim <jieun.kim4758@gmail.com>
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

