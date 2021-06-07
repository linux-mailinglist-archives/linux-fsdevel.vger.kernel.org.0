Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF8A39D387
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 05:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhFGDlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 23:41:22 -0400
Received: from m12-17.163.com ([220.181.12.17]:49769 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFGDlV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8bb3/
        arATzshbVOCtIxpXZ1GbxdUXtfBuqWkUCoYffo=; b=Zaoa843o6bRryKQo8nAyv
        qW0XTiNxnpB8CJI6hDi+STOIA2juy8w60fG61cnKEl56nRPKHKV8yws4LiPqcg1C
        1ecisFq18akctQYJ3JUjWmgtIhN3F+TDhNaeRzuvXguCIAuosXkKvhroCnok/rZ4
        oT+HxSPV5ItJ7D/TcioRJ4=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowADn7IzrlL1gn+GC5w--.44105S2;
        Mon, 07 Jun 2021 11:39:24 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] fs: block_dev: Fix a typo
Date:   Mon,  7 Jun 2021 11:38:26 +0800
Message-Id: <20210607033826.127596-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADn7IzrlL1gn+GC5w--.44105S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF18ZrWUGrWDtFy5GFy7Awb_yoWxZFb_Xa
        18ZrWkuw4xAw4ruw45Cr1avr1ktr92yrWayFnrJF95uryUWayfXFWDJ3yjvFn8WayUuas8
        ZFWrurW5Cr1kKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnPDGUUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiqwyqUFUMZuZjpgAAsB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'beeing' to 'being'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8abccd03e5d..b696be2c8eb4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -935,7 +935,7 @@ static struct block_device *bdget(dev_t dev)
  * @bdev:	Block device to grab a reference to.
  *
  * Returns the block_device with an additional reference when successful,
- * or NULL if the inode is already beeing freed.
+ * or NULL if the inode is already being freed.
  */
 struct block_device *bdgrab(struct block_device *bdev)
 {
-- 
2.25.1


