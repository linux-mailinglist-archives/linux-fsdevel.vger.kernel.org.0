Return-Path: <linux-fsdevel+bounces-17767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F3C8B226B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FC91C212FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE38914A0A9;
	Thu, 25 Apr 2024 13:17:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08431494B7;
	Thu, 25 Apr 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051053; cv=none; b=sFto4U6brmRMARZU+DP+wX0aVL4Vb11xiZhNMc0452nCweCQP61gB1TAyodldrjL+AtGYm6TCwfz5z/AURT3s8ZzKX4zr1G0i0uyit2aRSUFF9XXeorjdgMKOn7FrSetWUbW/uFI5GagD+R102BYYp3in4EMuoZ0N+Cb78PI+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051053; c=relaxed/simple;
	bh=D6O8AVGVe+mDlFUo72uYrqzLauiwiw7dUD3+ikZ9rkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VK1/e3YKuAwtkTMQEZZ347pojvmjIKWlRts4WKWjzpo048j3eqNVCunkFBchSC9mieOprw8fJbb4SPFVE/+nmkP5asv2hRpkR5h9ju5bTGvl3pRPBAfrt/xug5TYERiBFJs84eiV1vGuT0mLYPwFyT8DpxHbBfjfyzQiGGO1/FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VQGc309hqz4f3kKn;
	Thu, 25 Apr 2024 21:17:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E2BD31A108E;
	Thu, 25 Apr 2024 21:17:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgA3+J_kVypmFDcOKw--.42283S6;
	Thu, 25 Apr 2024 21:17:27 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	jack@suse.cz,
	hcochran@kernelspring.com,
	axboe@kernel.dk,
	mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mm: remove stale comment __folio_mark_dirty
Date: Thu, 25 Apr 2024 21:17:24 +0800
Message-Id: <20240425131724.36778-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240425131724.36778-1-shikemeng@huaweicloud.com>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3+J_kVypmFDcOKw--.42283S6
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr18Zw1ktF4rGFy3JF1kXwb_yoW3uwb_u3
	W8trn8X3y7Kr1xAay2vas3Aw1v9a1DCFy8ZF1ftFnrCa4Fyrs5ZFs5trs0yr1DKr4UWFZF
	kFnrZr45Ar9rKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The __folio_mark_dirty will not mark inode dirty any longer. Remove the
stale comment of it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 22e1acec899e..692c0da04cbd 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2721,8 +2721,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 }
 
 /*
- * Mark the folio dirty, and set it dirty in the page cache, and mark
- * the inode dirty.
+ * Mark the folio dirty, and set it dirty in the page cache.
  *
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
-- 
2.30.0


