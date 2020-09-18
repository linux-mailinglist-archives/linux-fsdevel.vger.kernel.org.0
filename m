Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A46C26FD96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgIRMyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 08:54:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgIRMyt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:54:49 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 883FCF1AEFB3CAB7BEE6;
        Fri, 18 Sep 2020 20:54:44 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 20:54:43 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <dyoung@redhat.com>, <bhe@redhat.com>, <vgoyal@redhat.com>,
        <adobriyan@gmail.com>
CC:     <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH -next] fs/proc/vmcore: Fix 'sizez' kernel-doc warning in vmcore.c
Date:   Fri, 18 Sep 2020 20:51:48 +0800
Message-ID: <20200918125148.8292-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/proc/vmcore.c:458: warning: Excess function parameter 'sizez' description in 'vmcore_alloc_buf'

Rename sizez to size.

Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index c3a345c28a93..bfb0aa4d63e4 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -446,7 +446,7 @@ static const struct vm_operations_struct vmcore_mmap_ops = {
 
 /**
  * vmcore_alloc_buf - allocate buffer in vmalloc memory
- * @sizez: size of buffer
+ * @size: size of buffer
  *
  * If CONFIG_MMU is defined, use vmalloc_user() to allow users to mmap
  * the buffer to user-space by means of remap_vmalloc_range().
-- 
2.17.1

