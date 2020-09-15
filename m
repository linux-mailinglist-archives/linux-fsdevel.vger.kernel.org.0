Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE85226A6B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgION5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:57:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12269 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbgIONtl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:49:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0223428B378948B843DE;
        Tue, 15 Sep 2020 21:31:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 21:31:51 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] fs: fix ioctl.c kernel-doc warnings
Date:   Tue, 15 Sep 2020 21:30:35 +0800
Message-ID: <1600176635-3717-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix following warnings:
fs/ioctl.c:109: warning: Excess function parameter 'fieinfo' description in 'SET_UNKNOWN_FLAGS'
fs/ioctl.c:109: warning: Excess function parameter 'logical' description in 'SET_UNKNOWN_FLAGS'
fs/ioctl.c:109: warning: Excess function parameter 'phys' description in 'SET_UNKNOWN_FLAGS'
fs/ioctl.c:109: warning: Excess function parameter 'len' description in 'SET_UNKNOWN_FLAGS'
fs/ioctl.c:109: warning: Excess function parameter 'flags' description in 'SET_UNKNOWN_FLAGS'

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 fs/ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4e6cc0a..81b028f 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -91,6 +91,9 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	return error;
 }
 
+#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
+#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
+#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
 /**
  * fiemap_fill_next_extent - Fiemap helper function
  * @fieinfo:	Fiemap context passed into ->fiemap
@@ -106,9 +109,6 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
  * Returns 0 on success, -errno on error, 1 if this was the last
  * extent that will fit in user array.
  */
-#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
-#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
-#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
 int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
 			    u64 phys, u64 len, u32 flags)
 {
-- 
2.8.1

