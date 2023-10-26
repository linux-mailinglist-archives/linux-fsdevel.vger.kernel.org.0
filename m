Return-Path: <linux-fsdevel+bounces-1215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F07D79DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 02:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D39A281E51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 00:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E94407;
	Thu, 26 Oct 2023 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A2EBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 00:56:40 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825CE5;
	Wed, 25 Oct 2023 17:56:38 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VuvkxYp_1698281795;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VuvkxYp_1698281795)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 08:56:36 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: akpm@linux-foundation.org,
	oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] fs: Remove unneeded semicolon
Date: Thu, 26 Oct 2023 08:56:34 +0800
Message-Id: <20231026005634.6581-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./fs/proc/base.c:3829:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7057
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index bfe9547d16f9..dd31e3b6bf77 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3826,7 +3826,7 @@ static struct task_struct *first_tid(struct pid *pid, int tid, loff_t f_pos,
 	for_each_thread(task, pos) {
 		if (!nr--)
 			goto found;
-	};
+	}
 fail:
 	pos = NULL;
 	goto out;
-- 
2.20.1.7.g153144c


