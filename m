Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906BE7B817
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 04:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfGaC5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 22:57:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbfGaC5a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:57:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD64B86C73D9FB5B7E30;
        Wed, 31 Jul 2019 10:57:27 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 31 Jul 2019
 10:57:17 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <mtk.manpages@gmail.com>
CC:     <linux-man@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <bcrl@kvack.org>,
        <viro@zeniv.linux.org.uk>, <jmoyer@redhat.com>, <arnd@arndb.de>,
        <deepa.kernel@gmail.com>, <yi.zhang@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH] io_getevents.2: Add EINVAL for case of timeout parameter out of range
Date:   Wed, 31 Jul 2019 11:03:13 +0800
Message-ID: <1564542193-89171-1-git-send-email-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

io_[p]getevents syscall should return -EINVAL if timeout is out of
range, update description of this error return value.

Link: https://lore.kernel.org/lkml/1564451504-27906-1-git-send-email-yi.zhang@huawei.com/
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
---
 man2/io_getevents.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/io_getevents.2 b/man2/io_getevents.2
index 0eb4b385e..5560bb8ee 100644
--- a/man2/io_getevents.2
+++ b/man2/io_getevents.2
@@ -73,8 +73,9 @@ Interrupted by a signal handler; see
 .TP
 .B EINVAL
 \fIctx_id\fP is invalid.
-\fImin_nr\fP is out of range or \fInr\fP is
-out of range.
+\fImin_nr\fP is out of range or \fInr\fP is out of range, or
+\fItimeout\fP is out of range (\fItv_sec\fP was less than zero, or
+\fItv_nsec\fP was not less than 1,000,000,000).
 .TP
 .B ENOSYS
 .BR io_getevents ()
-- 
2.20.1

