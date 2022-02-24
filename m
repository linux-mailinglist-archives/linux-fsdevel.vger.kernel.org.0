Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF484C29D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiBXKtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 05:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiBXKte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:49:34 -0500
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9928A10F;
        Thu, 24 Feb 2022 02:49:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V5O.E4e_1645699734;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V5O.E4e_1645699734)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 18:48:59 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     hdegoede@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] vboxsf: Remove redundant assignment to out_len
Date:   Thu, 24 Feb 2022 18:48:53 +0800
Message-Id: <20220224104853.71844-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clean up the following clang-w1 warning:

fs/vboxsf/utils.c:442:9: warning: variable 'out_len' set but not used
[-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/vboxsf/utils.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index e1db0f3f7e5e..865fe5ddc993 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -439,7 +439,7 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 {
 	const char *in;
 	char *out;
-	size_t out_len;
+	size_t out_len = 0;
 	size_t out_bound_len;
 	size_t in_bound_len;
 
@@ -447,7 +447,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 	in_bound_len = utf8_len;
 
 	out = name;
-	out_len = 0;
 	/* Reserve space for terminating 0 */
 	out_bound_len = name_bound_len - 1;
 
-- 
2.20.1.7.g153144c

