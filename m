Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475E11897D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 10:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCRJWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 05:22:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12092 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbgCRJWB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:22:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 75726363B47234D586BD;
        Wed, 18 Mar 2020 17:21:55 +0800 (CST)
Received: from fedora-aep.huawei.cmm (10.175.113.49) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 17:21:48 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <hch@infradead.org>, <darrick.wong@oracle.com>,
        <linux-fsdevel@vger.kernel.org>
CC:     <yangerkun@huawei.com>
Subject: [PATCH] iomap: fix comments in iomap_dio_rw
Date:   Wed, 18 Mar 2020 17:50:22 +0800
Message-ID: <20200318095022.5613-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.49]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Double 'three' exists in the comments of iomap_dio_rw.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..20dde5aadcdd 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -534,8 +534,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	/*
 	 * We are about to drop our additional submission reference, which
-	 * might be the last reference to the dio.  There are three three
-	 * different ways we can progress here:
+	 * might be the last reference to the dio.  There are three different
+	 * ways we can progress here:
 	 *
 	 *  (a) If this is the last reference we will always complete and free
 	 *	the dio ourselves.
-- 
2.17.2

