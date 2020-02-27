Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964941729F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 22:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgB0VLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 16:11:14 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54820 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgB0VLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:11:14 -0500
Received: by mail-pj1-f67.google.com with SMTP id dw13so313540pjb.4;
        Thu, 27 Feb 2020 13:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vn2qdMNVtzmTptemarLkmeAQtuC77a4d836dzPxB5VY=;
        b=AONhiIW3W0Ge7r2OROQVTEDOY/Muz6N+l/AJQzVAQTeiymt7Ls7JttstYeqYGLjLJV
         fBU+97SrxyDB4jStEuufV+ZiGmMQtDNJCi44m9c7hMoIuwCMlAG0XKKRutTKxKKvKC0F
         9xx6fj8RxOTY+aglMrEMhXQMEjazSVjBQlMsxW0WhZz4InOzRiIYlDU/4WjJ8kJl7ty+
         LUVvi4vatINRq5BdBV9V+4TxtA8bhrtFbR2xoy0B0/z/hXlh8xRnrNr8xwKYrE99RRwz
         +zFFtYFwiUx5r61wlNGeu8d9d/Dbtptyr4uTKSwdidYvSykkZ5Io6GYj7XlGUleud57H
         N1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vn2qdMNVtzmTptemarLkmeAQtuC77a4d836dzPxB5VY=;
        b=FDLg7SegWMuMjjZ8nrQkOPf0gOcuZQJZsB9OkdXguZGk6FlnxyLHL3YpnE6CAFaM98
         pCX9gjT3/fmC4/+n2JV2sTqxOqj+C/ekplfY9J+6FF6wQedvSI9XZK5QD1Yr4qtxkaIa
         E0OA6uUwB0PTEF4NHGUHUMFn7SMXy2S9qlBCL4yDUDq7Rc7SVSJ7dGtF1J8CcjGyY4zy
         bepcj1pvpNqCghh7YsY9nzVlx3DxLQ8JpuVxhZQmmkUaW5MLambp33ZJc+BfLSyELPFo
         BRpK5bXaRU9co7MtU5Q3dNyXGabSvoMB9EwMq9cbLloJdi2n02eD+xYMMvnFI+YCE49A
         yBkg==
X-Gm-Message-State: APjAAAXnRQtHxGzdoJQ8AXsFtMSUMxBc5U6EOk28Nfnp21nqKYCTkGGD
        BdbEceDPVMXhIn6gbLo+8g==
X-Google-Smtp-Source: APXvYqxoQQj1fnYLsu6+7XFbap7bfIOGjDd5lJFw8GC9SapC3mUGkSf3sK+q2+ztL0Gc2aOZBbTGMw==
X-Received: by 2002:a17:90b:3590:: with SMTP id mm16mr878870pjb.112.1582837873689;
        Thu, 27 Feb 2020 13:11:13 -0800 (PST)
Received: from localhost.localdomain ([157.41.21.90])
        by smtp.gmail.com with ESMTPSA id z27sm8548016pfj.107.2020.02.27.13.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Feb 2020 13:11:13 -0800 (PST)
From:   vivek m <bitu.kv@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        vivek m <bitu.kv@gmail.com>
Subject: [PATCH] Staging: exfat: fixed a long line coding style issue
Date:   Thu, 27 Feb 2020 21:11:05 +0000
Message-Id: <1582837865-2219-1-git-send-email-bitu.kv@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Vivek M <bitu.kv@gmail.com>
---
 drivers/staging/exfat/exfat_blkdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 0a3dc35..ddff019 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -30,8 +30,9 @@ void exfat_bdev_close(struct super_block *sb)
 	p_bd->opened = false;
 }
 
-int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
-		    u32 num_secs, bool read)
+int exfat_bdev_read(struct super_block *sb, sector_t secno,
+		    struct buffer_head **bh, u32 num_secs,
+		    bool read)
 {
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -65,7 +66,8 @@ int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head *
 	return -EIO;
 }
 
-int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
+int exfat_bdev_write(struct super_block *sb, sector_t secno,
+		     struct buffer_head *bh,
 		     u32 num_secs, bool sync)
 {
 	s32 count;
-- 
2.7.4

