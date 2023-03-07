Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7B6AD986
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 09:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCGIta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 03:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCGIt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:49:29 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99262AD29;
        Tue,  7 Mar 2023 00:49:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VdKkiN1_1678178959;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VdKkiN1_1678178959)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 16:49:25 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] splice: Remove redundant assignment to ret
Date:   Tue,  7 Mar 2023 16:49:18 +0800
Message-Id: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variable ret belongs to redundant assignment and can be deleted.

fs/splice.c:940:2: warning: Value stored to 'ret' is never read.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4406
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/splice.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2e76dbb81a8f..2c3dec2b6dfa 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -937,7 +937,6 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	/*
 	 * Do the splice.
 	 */
-	ret = 0;
 	bytes = 0;
 	len = sd->total_len;
 	flags = sd->flags;
-- 
2.20.1.7.g153144c

