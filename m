Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E472EFD53
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 04:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbhAIDMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 22:12:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10480 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAIDMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 22:12:35 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DCQ3414tKzj0gj;
        Sat,  9 Jan 2021 11:10:56 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 9 Jan 2021 11:11:49 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] syscalls: add comments show the define file for aio
Date:   Sat, 9 Jan 2021 11:14:16 +0800
Message-ID: <20210109031416.1375292-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fs/aio.c define the syscalls for aio.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 include/uapi/asm-generic/unistd.h       | 1 +
 tools/include/uapi/asm-generic/unistd.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 728752917785..84022c87ed49 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -30,6 +30,7 @@
 #define __SC_COMP_3264(_nr, _32, _64, _comp) __SC_3264(_nr, _32, _64)
 #endif
 
+/* fs/aio.c */
 #define __NR_io_setup 0
 __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
 #define __NR_io_destroy 1
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 728752917785..84022c87ed49 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -30,6 +30,7 @@
 #define __SC_COMP_3264(_nr, _32, _64, _comp) __SC_3264(_nr, _32, _64)
 #endif
 
+/* fs/aio.c */
 #define __NR_io_setup 0
 __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
 #define __NR_io_destroy 1
-- 
2.25.4

