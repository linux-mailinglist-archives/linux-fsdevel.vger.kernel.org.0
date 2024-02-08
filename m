Return-Path: <linux-fsdevel+bounces-10752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7B84DCD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C7C1C25B14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503C46F062;
	Thu,  8 Feb 2024 09:23:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DE6EB75;
	Thu,  8 Feb 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384193; cv=none; b=Q0iErvCqDvW3KYs22BjHOUgcMQi6NkHbJ3GMkwtqsrKM3cbEz7DfRTVPvm4kjGO5L0pP86hzTepIf7G3MDf7vBMf+wWdJwCH/BvPJ+zNaBtW6hEAfTz3d4pJoIcT2viup3NdHCf4bP8d2axUiD+/sscDzHsWTny2RnFPxNnVdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384193; c=relaxed/simple;
	bh=5OM/RsInbbF774iZl5AEDt/9K4ap0ekY6wYxHcth7Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dc3GtmuEfXfiMXMBiWiS5RIXMgA98zUznQvzK5CgWqtKrW4yYcAAC9OLMiEqtS1GcdZnDSsSAOBITtXxqRWgnXht7+nwiE+plHGtqkcRG3dxRVCYs7UrD3aABEKVLGI7Qt+OSvuDZt3qpdyUYqj+Thm/0/p3i1L8Go5KfVrDvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TVs3B6c7Cz4f3js1;
	Thu,  8 Feb 2024 17:23:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6BBC11A09D8;
	Thu,  8 Feb 2024 17:23:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQx4ncRl3tGXDQ--.8574S5;
	Thu, 08 Feb 2024 17:23:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] fs/writeback: remove unused parameter wb of finish_writeback_work
Date: Fri,  9 Feb 2024 01:20:20 +0800
Message-Id: <20240208172024.23625-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240208172024.23625-1-shikemeng@huaweicloud.com>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQx4ncRl3tGXDQ--.8574S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1fCF47Jr4DtFWrKF1xZrb_yoW8JFyrpr
	y5Kr1DJFW2vr47KF4Duay2grnrK3ykKry3Gr4rWa12qr1SvF43Kay0gFy8tr1UJr9xZFWf
	Zr4vvrW8Jr40yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jy0PhUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused parameter wb of finish_writeback_work.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/fs-writeback.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index edb0cff51673..2619f74ced70 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -166,8 +166,7 @@ static void wb_wakeup_delayed(struct bdi_writeback *wb)
 	spin_unlock_irq(&wb->work_lock);
 }
 
-static void finish_writeback_work(struct bdi_writeback *wb,
-				  struct wb_writeback_work *work)
+static void finish_writeback_work(struct wb_writeback_work *work)
 {
 	struct wb_completion *done = work->done;
 
@@ -196,7 +195,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
 		list_add_tail(&work->list, &wb->work_list);
 		mod_delayed_work(bdi_wq, &wb->dwork, 0);
 	} else
-		finish_writeback_work(wb, work);
+		finish_writeback_work(work);
 
 	spin_unlock_irq(&wb->work_lock);
 }
@@ -2285,7 +2284,7 @@ static long wb_do_writeback(struct bdi_writeback *wb)
 	while ((work = get_next_work_item(wb)) != NULL) {
 		trace_writeback_exec(wb, work);
 		wrote += wb_writeback(wb, work);
-		finish_writeback_work(wb, work);
+		finish_writeback_work(work);
 	}
 
 	/*
-- 
2.30.0


