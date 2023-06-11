Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127FE72B1D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjFKMfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKMfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:35:20 -0400
X-Greylist: delayed 99 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Jun 2023 05:35:17 PDT
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9678113;
        Sun, 11 Jun 2023 05:35:17 -0700 (PDT)
X-QQ-mid: bizesmtp64t1686486807t0zq682e
Received: from localhost.localdomain ( [182.148.15.16])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 11 Jun 2023 20:33:15 +0800 (CST)
X-QQ-SSF: 01000000000000D0I000000A0000000
X-QQ-FEAT: f+ZzKTjTzV3oDnnoAz7NwYgbWoGgDpMUsA4vwvuyeDaZEC7EFCdIIo0bVlTpZ
        jAebU6jNUqzPKA5TjUWMLxImtGBsZXhMpLAwK9SQ9kMEGDUPaMdPFlCYO6wxLMYKuy4TKZy
        xt9nV5guq7X7cCz+7hGDE90i/4cBOFn+A/lAed5I9mVrR64yH9n+C5unmeoSM9AI8iJlmS/
        gDf0lyojIoXFItjTZPspGo9fd34u4ukSJ0ZI1lDH2iLDk0rNk1AgovfhJdtw9PSn8HQjufw
        AgnJo0wD+RVg3/HG1wmCRSnXF4pJEQoG4O2dvOX+crzkxbHPMIeeVBxZu45Sk+oPKHNLbeu
        2nXphW/3kB+PYCcsWo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 296039327464568289
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
Subject: [PATCH] fs: Fix comment typo
Date:   Sun, 11 Jun 2023 08:33:14 -0400
Message-Id: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mao Zhu <zhumao001@208suo.com>

Delete duplicated word in comment.

Signed-off-by: Mao Zhu <zhumao001@208suo.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index df6c1817906f..aa870b77cc2b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2675,7 +2675,7 @@ extern void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
- * Userspace may rely on the the inode number being non-zero. For example, glibc
+ * Userspace may rely on the inode number being non-zero. For example, glibc
  * simply ignores files with zero i_ino in unlink() and other places.
  *
  * As an additional complication, if userspace was compiled with
-- 
2.35.1

