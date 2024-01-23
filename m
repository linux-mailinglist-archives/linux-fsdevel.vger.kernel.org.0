Return-Path: <linux-fsdevel+bounces-8533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F23838C36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4DD1F226AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF005D8FA;
	Tue, 23 Jan 2024 10:35:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165475C8EC;
	Tue, 23 Jan 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006157; cv=none; b=mqmAEK0AIudk8qCN+M+tzZ+xtlepMxsPL9+9P49glHQsp5FsvJCPAq3lKWKRNZdKGpdz+Iz+wDgrdZfmY7J+KoP+sqWuiPflRzgg+7xyW70mxu5717N9P9vH2K/lMF0B9uEsg9/R7NLYFdJQy0M6GyHMtZteBbojVaBCXMqPb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006157; c=relaxed/simple;
	bh=Palg1KdWtRSP5vUrITO34TYaEObNWtzTfafQ1wBNc1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMryJiO5kVDa3QFLXj0NAnrBCPNEpURbCkWfl9M7Y28KW33Uc2N5YMnjjG1AALTMGzFoSR/I9jLTcVYHrMkdCQM+j8iosRoD+8kLaV8FwG5wh8FOOgcyGW0zbkyEYUNqBTFnzzqH420vSNIWL5My8su+9B3wwk+F1TLqbk5CVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TK3QV6Nqsz4f3m73;
	Tue, 23 Jan 2024 18:35:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2D97E1A016E;
	Tue, 23 Jan 2024 18:35:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3Bg+Flq9ly6DjBg--.30161S7;
	Tue, 23 Jan 2024 18:35:52 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: tj@kernel.org,
	hcochran@kernelspring.com,
	mszeredi@redhat.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] mm: remove stale comment __folio_mark_dirty
Date: Wed, 24 Jan 2024 02:33:32 +0800
Message-Id: <20240123183332.876854-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240123183332.876854-1-shikemeng@huaweicloud.com>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3Bg+Flq9ly6DjBg--.30161S7
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr18Zw1ktF1UJFWktryUtrb_yoW3XFb_u3
	Z7Jr1kXa9Fgr1xJay29as3Aw1v9a1DCr1xZF1SqFnrAa4Fyrs5Zws5tr4Dtr1DKr4UWFZr
	KF1UZr45ArsrKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The __folio_mark_dirty will not mark inode dirty any longer. Remove the
stale comment of it.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f25393034c76..03e2797bc983 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2647,8 +2647,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
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


