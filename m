Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEA0577ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 08:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiGRGFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 02:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGRGFm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:05:42 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60F10FC5;
        Sun, 17 Jul 2022 23:05:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VJcmUQk_1658124335;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VJcmUQk_1658124335)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 14:05:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs/buffer: Fix some kernel-doc comments
Date:   Mon, 18 Jul 2022 14:05:33 +0800
Message-Id: <20220718060533.99184-1-yang.lee@linux.alibaba.com>
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

Remove warnings found by running scripts/kernel-doc, which is caused by
using 'make W=1'.

fs/buffer.c:2756: warning: Excess function parameter 'op_flags' description in 'll_rw_block'
fs/buffer.c:2756: warning: Excess function parameter 'op' description in 'll_rw_block'
fs/buffer.c:2756: warning: Function parameter or member 'opf' not described in 'll_rw_block'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b98fbc80b44c..b750d95ef6f3 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2728,8 +2728,7 @@ EXPORT_SYMBOL(submit_bh);
 
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
- * @op: whether to %READ or %WRITE
- * @op_flags: req_flag_bits
+ * @opf: operation and flags for bio
  * @nr: number of &struct buffer_heads in the array
  * @bhs: array of pointers to &struct buffer_head
  *
-- 
2.20.1.7.g153144c

