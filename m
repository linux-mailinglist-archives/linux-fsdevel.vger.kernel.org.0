Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22182143AF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 11:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgAUKZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 05:25:52 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53349 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729793AbgAUKZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:25:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0ToHewX3_1579602349;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHewX3_1579602349)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 18:25:49 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pankaj gupta <pagupta@redhat.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: remove unused macro
Date:   Tue, 21 Jan 2020 18:25:44 +0800
Message-Id: <1579602344-57171-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KPMBITS is never used from it was introduced. better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: David Hildenbrand <david@redhat.com> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Pankaj gupta <pagupta@redhat.com> 
Cc: Konstantin Khlebnikov <koct9i@gmail.com> 
Cc: linux-kernel@vger.kernel.org 
Cc: linux-fsdevel@vger.kernel.org 
---
 fs/proc/page.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 7c952ee732e6..c4b1005a82bc 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -19,7 +19,6 @@
 
 #define KPMSIZE sizeof(u64)
 #define KPMMASK (KPMSIZE - 1)
-#define KPMBITS (KPMSIZE * BITS_PER_BYTE)
 
 /* /proc/kpagecount - an array exposing page counts
  *
-- 
1.8.3.1

