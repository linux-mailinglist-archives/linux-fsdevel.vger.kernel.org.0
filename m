Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5676AFF82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 08:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCHHNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 02:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCHHN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:13:29 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E015506B;
        Tue,  7 Mar 2023 23:13:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VdOP7rA_1678259598;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VdOP7rA_1678259598)
          by smtp.aliyun-inc.com;
          Wed, 08 Mar 2023 15:13:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     brauner@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] fs/locks: Remove redundant assignment to cmd
Date:   Wed,  8 Mar 2023 15:13:16 +0800
Message-Id: <20230308071316.16410-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Variable 'cmd' set but not used.

fs/locks.c:2428:3: warning: Value stored to 'cmd' is never read.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4439
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/locks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 66b4eef09db5..d82c4cacdfb9 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2425,7 +2425,6 @@ int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		cmd = F_GETLK64;
 		fl->fl_flags |= FL_OFDLCK;
 		fl->fl_owner = filp;
 	}
-- 
2.20.1.7.g153144c

