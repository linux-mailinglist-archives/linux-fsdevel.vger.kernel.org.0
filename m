Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E195716FD00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBZLLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:11:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727954AbgBZLLs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:11:48 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5C21E9D6AA8E520C65F5;
        Wed, 26 Feb 2020 19:11:45 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 26 Feb 2020
 19:11:39 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>
Subject: [PATCH v2 1/7] blk-wbt: use bdi_dev_name() to get device name
Date:   Wed, 26 Feb 2020 19:18:45 +0800
Message-ID: <20200226111851.55348-2-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
In-Reply-To: <20200226111851.55348-1-yuyufen@huawei.com>
References: <20200226111851.55348-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the common interface bdi_dev_name() to get device name.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 include/trace/events/wbt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 37342a13c9cb..9996420d7ec4 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
@@ -68,7 +68,7 @@ TRACE_EVENT(wbt_lat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->lat = div_u64(lat, 1000);
 	),
@@ -105,7 +105,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->msg	= msg;
 		__entry->step	= step;
@@ -141,7 +141,7 @@ TRACE_EVENT(wbt_timer,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, dev_name(bdi->dev),
+		strlcpy(__entry->name, bdi_dev_name(bdi),
 			ARRAY_SIZE(__entry->name));
 		__entry->status		= status;
 		__entry->step		= step;
-- 
2.16.2.dirty

