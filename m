Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6811438BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAUItc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 03:49:32 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:42064 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728799AbgAUItb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0ToHXcZl_1579596569;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXcZl_1579596569)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:29 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: remove Hangul_LCount
Date:   Tue, 21 Jan 2020 16:49:27 +0800
Message-Id: <1579596567-258038-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This macro is never used from first git commit Linux-2.6.12-rc2. Maybe
better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/hfsplus/unicode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
index c8d1b2be7854..969203b61596 100644
--- a/fs/hfsplus/unicode.c
+++ b/fs/hfsplus/unicode.c
@@ -93,7 +93,6 @@ int hfsplus_strcmp(const struct hfsplus_unistr *s1,
 #define Hangul_VBase	0x1161
 #define Hangul_TBase	0x11a7
 #define Hangul_SCount	11172
-#define Hangul_LCount	19
 #define Hangul_VCount	21
 #define Hangul_TCount	28
 #define Hangul_NCount	(Hangul_VCount * Hangul_TCount)
-- 
1.8.3.1

