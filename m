Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0F592924
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 07:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiHOFoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 01:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHOFoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 01:44:21 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509514081;
        Sun, 14 Aug 2022 22:44:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMDjRLc_1660542252;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VMDjRLc_1660542252)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 13:44:13 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs/kernel_read_file: Fix some kernel-doc comments
Date:   Mon, 15 Aug 2022 13:44:11 +0800
Message-Id: <20220815054411.68818-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a colon between the parameter name and description to meet the
scripts/kernel-doc.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1901
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/kernel_read_file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 5d826274570c..c4fc84e6d099 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -8,16 +8,16 @@
 /**
  * kernel_read_file() - read file contents into a kernel buffer
  *
- * @file	file to read from
- * @offset	where to start reading from (see below).
- * @buf		pointer to a "void *" buffer for reading into (if
+ * @file:	file to read from
+ * @offset:	where to start reading from (see below).
+ * @buf:	pointer to a "void *" buffer for reading into (if
  *		*@buf is NULL, a buffer will be allocated, and
  *		@buf_size will be ignored)
- * @buf_size	size of buf, if already allocated. If @buf not
+ * @buf_size:	size of buf, if already allocated. If @buf not
  *		allocated, this is the largest size to allocate.
- * @file_size	if non-NULL, the full size of @file will be
+ * @file_size:	if non-NULL, the full size of @file will be
  *		written here.
- * @id		the kernel_read_file_id identifying the type of
+ * @id:	the kernel_read_file_id identifying the type of
  *		file contents being read (for LSMs to examine)
  *
  * @offset must be 0 unless both @buf and @file_size are non-NULL
-- 
2.20.1.7.g153144c

