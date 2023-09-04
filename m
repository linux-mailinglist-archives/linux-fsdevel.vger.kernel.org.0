Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614579115C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 08:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352324AbjIDGav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 02:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345916AbjIDGar (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:30:47 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0E106;
        Sun,  3 Sep 2023 23:30:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RfJff5Hmqz4f3kF7;
        Mon,  4 Sep 2023 14:30:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP1 (Coremail) with SMTP id cCh0CgDnFDGLefVkRQ7ICA--.14846S5;
        Mon, 04 Sep 2023 14:30:38 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH 3/3] fuse: move fuse_put_request a bit to remove forward declaration
Date:   Mon,  4 Sep 2023 22:30:18 +0800
Message-Id: <20230904143018.5709-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230904143018.5709-1-shikemeng@huaweicloud.com>
References: <20230904143018.5709-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDnFDGLefVkRQ7ICA--.14846S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyruF47Xr1fJF1DKF17ZFb_yoW8Cr4Upr
        WfCa12vFZ7XFW7W3y3J34DX3W5tw4xA347tryxJa4fZF15Awn5Z3Z5tFy8XryrJrWxXrsx
        Xr4DKr17urWYvw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zV
        CS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
        WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
        RNBT5UUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move fuse_put_request before fuse_get_req to remove forward declaration.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fuse/dev.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4f49b1946635..deda8b036de7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -101,7 +101,26 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
 	}
 }
 
-static void fuse_put_request(struct fuse_req *req);
+static void fuse_put_request(struct fuse_req *req)
+{
+	struct fuse_conn *fc = req->fm->fc;
+
+	if (refcount_dec_and_test(&req->count)) {
+		if (test_bit(FR_BACKGROUND, &req->flags)) {
+			/*
+			 * We get here in the unlikely case that a background
+			 * request was allocated but not sent
+			 */
+			spin_lock(&fc->bg_lock);
+			if (!fc->blocked)
+				wake_up(&fc->blocked_waitq);
+			spin_unlock(&fc->bg_lock);
+		}
+
+		fuse_drop_waiting(fc);
+		fuse_request_free(req);
+	}
+}
 
 static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
 {
@@ -154,27 +173,6 @@ static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
 	return ERR_PTR(err);
 }
 
-static void fuse_put_request(struct fuse_req *req)
-{
-	struct fuse_conn *fc = req->fm->fc;
-
-	if (refcount_dec_and_test(&req->count)) {
-		if (test_bit(FR_BACKGROUND, &req->flags)) {
-			/*
-			 * We get here in the unlikely case that a background
-			 * request was allocated but not sent
-			 */
-			spin_lock(&fc->bg_lock);
-			if (!fc->blocked)
-				wake_up(&fc->blocked_waitq);
-			spin_unlock(&fc->bg_lock);
-		}
-
-		fuse_drop_waiting(fc);
-		fuse_request_free(req);
-	}
-}
-
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args)
 {
 	unsigned nbytes = 0;
-- 
2.30.0

