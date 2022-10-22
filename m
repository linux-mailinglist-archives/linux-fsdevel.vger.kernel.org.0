Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C1608547
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Oct 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJVGva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Oct 2022 02:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJVGv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Oct 2022 02:51:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9A26FFBA;
        Fri, 21 Oct 2022 23:51:27 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666421483tq1hppni
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:51:22 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: +bXiSo2NuBcejOLpbJ+aH5jZ9nBF6SF5Z8jITJHzRE2MK1FYlandI5I4xailk
        ywBG/tLKqG/zcYWC7nEbddudnBudMEWC0f7km2JCU9S1HEwHfk3bBYQpBPyScWO43CWI6k8
        Ui8E90LnobR/oj7DowOSedXA4PU92gKleMCJsukT1OvvdaRHrHdXCz4Grtv7Ik+3n6risrp
        YgoQ+oOMnrHvpJLh+k1sAGYakX1oy7SR9FEFvZG7v7tQEsJsdG7J9yPfggdlNSR8ETCFjq1
        Ky9wREZmx/KwsNahg4n0Bw/bhGIw7gEfs0LcXwStSjptSValqvFdbnT3MmiGil8djYiBiwW
        iQhTiE5GUx5G6zoGIkeVXms53XMvr6cFJ6VHtM6pctuK245448=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] include/linux: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:51:16 +0800
Message-Id: <20221022065116.41273-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0ef49fed1300..87a7166730ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2933,7 +2933,7 @@ extern void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
- * Userspace may rely on the the inode number being non-zero. For example, glibc
+ * Userspace may rely on the inode number being non-zero. For example, glibc
  * simply ignores files with zero i_ino in unlink() and other places.
  *
  * As an additional complication, if userspace was compiled with
-- 
2.36.1

