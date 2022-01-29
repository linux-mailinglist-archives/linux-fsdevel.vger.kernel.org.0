Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F404A2AEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 02:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352007AbiA2BO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 20:14:58 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36496 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229812AbiA2BOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 20:14:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V34G8yp_1643418891;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V34G8yp_1643418891)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 09:14:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bhe@redhat.com
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] proc/vmcore: Fix vmcore_alloc_buf() kernel-doc comment
Date:   Sat, 29 Jan 2022 09:14:49 +0800
Message-Id: <20220129011449.105278-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a spelling problem to remove warnings found
by running scripts/kernel-doc, which is caused by
using 'make W=1'.

fs/proc/vmcore.c:492: warning: Function parameter or member 'size' not
described in 'vmcore_alloc_buf'
fs/proc/vmcore.c:492: warning: Excess function parameter 'sizez'
description in 'vmcore_alloc_buf'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index edeb01dfe05d..6f1b8ddc6f7a 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -480,7 +480,7 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
- * @sizez: size of buffer
+ * @size: size of buffer
  *
  * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
  * the buffer to user-space by means of remap_vmalloc_range().
-- 
2.20.1.7.g153144c

