Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C41481AB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 09:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhL3IRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 03:17:06 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33688 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231140AbhL3IRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:17:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V0KXNtQ_1640852223;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V0KXNtQ_1640852223)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Dec 2021 16:17:03 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     bhe@redhat.com
Cc:     vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs/proc/vmcore: Fix vmcore_alloc_buf() kernel-doc comment
Date:   Thu, 30 Dec 2021 16:17:01 +0800
Message-Id: <20211230081701.42593-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a spelling mistake sizez -> size, to remove some warnings
found by running scripts/kernel-doc, which is caused by using
'make W=1'.
fs/proc/vmcore.c:489: warning: Function parameter or member 'size' not
described in 'vmcore_alloc_buf'
fs/proc/vmcore.c:489: warning: Excess function parameter 'sizez'
description in 'vmcore_alloc_buf'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 702754dd1daf..cbb3ac5ca0c4 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -477,7 +477,7 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
- * @sizez: size of buffer
+ * @size: size of buffer
  *
  * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
  * the buffer to user-space by means of remap_vmalloc_range().
-- 
2.20.1.7.g153144c

