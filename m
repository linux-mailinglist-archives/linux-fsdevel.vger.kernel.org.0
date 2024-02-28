Return-Path: <linux-fsdevel+bounces-13029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239586A4EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA961F225E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6451CD2A;
	Wed, 28 Feb 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D44E572;
	Wed, 28 Feb 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083394; cv=none; b=SBBDFu3yOjBu4hrxqWeUHgxkEq8qdHXtbrBBw1WFZ5mCfoXGBxCLmi/6zkuLBz8e7nz/BX/Jt9YT7a5wuIJ1/wJIZlCbmuXsQe/n+eJf20uqRZ46hAGB7RMR4YiWlOAU6Pw00MaAgEJ+fNjmyLEbWaL52DviFKowRMZNH14h8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083394; c=relaxed/simple;
	bh=fIv7I7JSYRHanVCmYVQAWWmDR1sHd65BZ4L5pKIMp84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTWMxaThTgDV8vD4qL5WyWqSggpNqyOS7h74RGRQIyu5eyDNlEzhdr14w0DD/EvoM5UuSAX1pevzuXSQAg8vgvqeHM/MKSHFa1lhENA3xYGrNLpSSK9bVdeCow5HGx1NY97wQUxzdf59hfTb11rkPCohehM6PLv9O32ZilieDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkxS90DT6z4f3kF9;
	Wed, 28 Feb 2024 09:23:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 414611A016E;
	Wed, 28 Feb 2024 09:23:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX8gv7it5lqQx6FQ--.57137S5;
	Wed, 28 Feb 2024 09:23:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tim.c.chen@linux.intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] fs/writeback: remove unused parameter wb of finish_writeback_work
Date: Wed, 28 Feb 2024 17:19:55 +0800
Message-Id: <20240228091958.288260-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240228091958.288260-1-shikemeng@huaweicloud.com>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX8gv7it5lqQx6FQ--.57137S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1rXFykGFyUKry3CryUWrg_yoW8GF1rpr
	y5Kr1DJFWjyr47KF4DuFW2vw15K3yDKry3Gr1rWa12qrn2v3W3KayIgFy8tr1UJr9xZFW3
	Zr4vvrW8Jr10yr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3vPSUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused parameter wb of finish_writeback_work.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6fa623277d75..1c3134817865 100644
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
@@ -2272,7 +2271,7 @@ static long wb_do_writeback(struct bdi_writeback *wb)
 	while ((work = get_next_work_item(wb)) != NULL) {
 		trace_writeback_exec(wb, work);
 		wrote += wb_writeback(wb, work);
-		finish_writeback_work(wb, work);
+		finish_writeback_work(work);
 	}
 
 	/*
-- 
2.30.0


