Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584A458FE09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Aug 2022 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiHKOGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Aug 2022 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiHKOGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:06:07 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316FD45;
        Thu, 11 Aug 2022 07:06:04 -0700 (PDT)
X-QQ-mid: bizesmtp76t1660226759t2bg2eg8
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 22:05:58 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: izenvNSMpb1BPjvdj7mJp/JbTssCSwzXvexRmCy7J6IWgM7nds+XO9ZCnKFQj
        38YWA3NSDuCTs+DKutMq2K6KWluRilAJE1Oz38BEoqvGIdQyoMl4uNKXTLeoYdW+yGYE2rv
        XX9n1vBAjYRGfcLx/1uyUaxfz70iHWM2sxFCNbYl8KDgTSUwtF0bMa6OdJP3lyybIs+16kP
        6LW6kLmLvpv5C15fquTyvpiTLH6GW1zTfY5rdK1r7WFwRyR3ZYXMfke2YZX0pExzwt9l9XB
        EFu8Yt5XR4E8Yz81NUxKR+IjyN+c6rk8z9LMIcIUriogISHquaFGi19Z+t3Xm7o5HcbmxUf
        m+0J1LtpZTQVfEnCgCpv1p4FUBgm+Lz6DeqtRnwne3qkxdqqJ204x7VLXWUShk4JfJwXGGc
        cJkOxHEapl0=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] procfs: Fix comment typo
Date:   Thu, 11 Aug 2022 22:05:52 +0800
Message-Id: <20220811140552.34130-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ac7742a37cb9..5b75b2ed5471 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3074,7 +3074,7 @@ extern void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
- * Userspace may rely on the the inode number being non-zero. For example, glibc
+ * Userspace may rely on the inode number being non-zero. For example, glibc
  * simply ignores files with zero i_ino in unlink() and other places.
  *
  * As an additional complication, if userspace was compiled with
-- 
2.36.1

