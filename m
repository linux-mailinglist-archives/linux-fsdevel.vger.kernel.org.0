Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DBE26FCBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 14:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIRMlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 08:41:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgIRMll (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:41:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA5805EAE49D8C5F1B8D;
        Fri, 18 Sep 2020 20:41:38 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 20:41:34 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fs/nsfs.c: Fix 'ns_common' kernel-doc warning in nsfs.c
Date:   Fri, 18 Sep 2020 20:38:42 +0800
Message-ID: <20200918123842.73010-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/nsfs.c:264: warning: Excess function parameter 'ns_common' description in 'ns_match'

Rename ns_common to ns.

Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/nsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..fffc5206a23a 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -254,7 +254,7 @@ struct file *proc_ns_fget(int fd)
 
 /**
  * ns_match() - Returns true if current namespace matches dev/ino provided.
- * @ns_common: current ns
+ * @ns: current ns
  * @dev: dev_t from nsfs that will be matched against current nsfs
  * @ino: ino_t from nsfs that will be matched against current nsfs
  *
-- 
2.17.1

