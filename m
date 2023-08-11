Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6A377850D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 03:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjHKBoG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 21:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjHKBoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:44:05 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE142132;
        Thu, 10 Aug 2023 18:44:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VpVFUaH_1691718240;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VpVFUaH_1691718240)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 09:44:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] fs: Fix one kernel-doc comment
Date:   Fri, 11 Aug 2023 09:43:59 +0800
Message-Id: <20230811014359.4960-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix one kernel-doc comment to silence the warning:

fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b07de77ef126..4771701c896b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
  * @file:	file structure to seek on
  * @offset:	file offset to seek to
  * @whence:	type of seek
- * @size:	max size of this file in file system
+ * @maxsize:	max size of this file in file system
  * @eof:	offset used for SEEK_END position
  *
  * This is a variant of generic_file_llseek that allows passing in a custom
-- 
2.20.1.7.g153144c

