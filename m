Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD61438BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAUIta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 03:49:30 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60386 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728512AbgAUIt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToHY-sz_1579596565;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHY-sz_1579596565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:26 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/select: remove __COMPAT_NFDBITS
Date:   Tue, 21 Jan 2020 16:49:24 +0800
Message-Id: <1579596564-257998-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No one use this macro after commit 464d62421cb8 ("select: switch
compat_{get,put}_fd_set() to compat_{get,put}_bitmap()")
so remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk> 
Cc: linux-fsdevel@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/select.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/select.c b/fs/select.c
index 11d0285d46b7..f2f4fbcf0c93 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1130,7 +1130,6 @@ static long do_restart_poll(struct restart_block *restart_block)
 #endif
 
 #ifdef CONFIG_COMPAT
-#define __COMPAT_NFDBITS       (8 * sizeof(compat_ulong_t))
 
 /*
  * Ooo, nasty.  We need here to frob 32-bit unsigned longs to
-- 
1.8.3.1

