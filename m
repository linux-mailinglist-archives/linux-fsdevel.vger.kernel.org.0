Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0495B339B6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 03:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhCMCzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 21:55:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:14324 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbhCMCzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 21:55:08 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Dy6gc1L4gz8xFC;
        Sat, 13 Mar 2021 10:53:16 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 13 Mar 2021
 10:54:58 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <jack@suse.cz>
CC:     <tytso@mit.edu>, <viro@zeniv.linux.org.uk>, <hch@infradead.org>,
        <axboe@kernel.dk>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <yi.zhang@huawei.com>
Subject: [RFC PATCH 3/3] block_dump: remove comments in docs
Date:   Sat, 13 Mar 2021 11:01:46 +0800
Message-ID: <20210313030146.2882027-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210313030146.2882027-1-yi.zhang@huawei.com>
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now block_dump feature is gone, remove all comments in docs.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 Documentation/admin-guide/laptops/laptop-mode.rst | 11 -----------
 Documentation/admin-guide/sysctl/vm.rst           |  8 --------
 2 files changed, 19 deletions(-)

diff --git a/Documentation/admin-guide/laptops/laptop-mode.rst b/Documentation/admin-guide/laptops/laptop-mode.rst
index c984c4262f2e..b61cc601d298 100644
--- a/Documentation/admin-guide/laptops/laptop-mode.rst
+++ b/Documentation/admin-guide/laptops/laptop-mode.rst
@@ -101,17 +101,6 @@ this results in concentration of disk activity in a small time interval which
 occurs only once every 10 minutes, or whenever the disk is forced to spin up by
 a cache miss. The disk can then be spun down in the periods of inactivity.
 
-If you want to find out which process caused the disk to spin up, you can
-gather information by setting the flag /proc/sys/vm/block_dump. When this flag
-is set, Linux reports all disk read and write operations that take place, and
-all block dirtyings done to files. This makes it possible to debug why a disk
-needs to spin up, and to increase battery life even more. The output of
-block_dump is written to the kernel output, and it can be retrieved using
-"dmesg". When you use block_dump and your kernel logging level also includes
-kernel debugging messages, you probably want to turn off klogd, otherwise
-the output of block_dump will be logged, causing disk activity that is not
-normally there.
-
 
 Configuration
 -------------
diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 586cd4b86428..3ca6679f16ea 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -25,7 +25,6 @@ files can be found in mm/swap.c.
 Currently, these files are in /proc/sys/vm:
 
 - admin_reserve_kbytes
-- block_dump
 - compact_memory
 - compaction_proactiveness
 - compact_unevictable_allowed
@@ -106,13 +105,6 @@ On x86_64 this is about 128MB.
 Changing this takes effect whenever an application requests memory.
 
 
-block_dump
-==========
-
-block_dump enables block I/O debugging when set to a nonzero value. More
-information on block I/O debugging is in Documentation/admin-guide/laptops/laptop-mode.rst.
-
-
 compact_memory
 ==============
 
-- 
2.25.4

