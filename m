Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0FA39D2FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 04:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFGCjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 22:39:04 -0400
Received: from m12-12.163.com ([220.181.12.12]:55873 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhFGCjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=OfzJG
        36BQSalpQwM1+OlG2qFTfDa7OWPrE8r5mmHEd0=; b=ns2gVlWkQlnsjkJ678uPU
        1UxKPeQ1i2F4IwrVTojr2ji8U6quCGbaflb8LI6mybr2F2LzVtd/iWz76mm6A7P7
        jfyQyHD3MKpm5HtCLgYl5BKK4xCC/d/wszH9854NxTFNF37VhA3PvizXKiBJXCO7
        rblFRIMoegwCvaBUSaJA/U=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowAAnI2BUhr1gwDUAIg--.368S2;
        Mon, 07 Jun 2021 10:37:10 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: direct-io: Fix a typo
Date:   Mon,  7 Jun 2021 10:36:11 +0800
Message-Id: <20210607023611.81413-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAnI2BUhr1gwDUAIg--.368S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF17ur4xWFykuFWkKr4kWFg_yoW3Cwc_Ww
        n2yayv9FykCFZxCay3Xr4fXFs29w1rAF45CF4FgF13t345Jay0y3ZFyr9FvrnIgrW7X343
        WFn7uryqyr1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnKg43UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/xtbBERaqUFaEEoaETQAAsy
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'submition' to 'submission'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a..dea9ad204acb 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -86,7 +86,7 @@ struct dio_submit {
 	sector_t final_block_in_request;/* doesn't change */
 	int boundary;			/* prev block is at a boundary */
 	get_block_t *get_block;		/* block mapping function */
-	dio_submit_t *submit_io;	/* IO submition function */
+	dio_submit_t *submit_io;	/* IO submission function */
 
 	loff_t logical_offset_in_bio;	/* current first logical block in bio */
 	sector_t final_block_in_bio;	/* current final block in bio + 1 */
-- 
2.25.1


