Return-Path: <linux-fsdevel+bounces-15382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B088D6EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 08:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984C41C251D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A32C848;
	Wed, 27 Mar 2024 07:01:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3C249ED;
	Wed, 27 Mar 2024 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522915; cv=none; b=YzPteBlPo2bgamLWo0Rzlv/jw0z6jtNyNOzZgMe7uQQEMraWxHSGZ13mIIaPi7o6GijYD8cCjod1UF8jwjMpEhFEffvjX5UxqXskK6+UCWN3+S88PmQY3Oo1cWfJ1Uu2rnDMFQW/9841hV3gcKAua2kErPn8lSXNYVxDpNwYBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522915; c=relaxed/simple;
	bh=z3hpLvAqICheWGdppVRowRrjiiDy/NCGgfRnnGCDboA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEC6Uz4gfOmHGwg8nXcqb2BIpEFJpwkkYlfHvNio3AWdySAch4/tCILIqkdZB1ce4P4xW9opaTIncEgggw8lmH9pcR2tbxCQragqasWvVD0Y30OwV+bT0CL5TLHs2fv6JqsJYOUmiVG3THP6/cI2ETqCQy3jd/2eMEsbE51i678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V4Hf16CNQz4f3kpG;
	Wed, 27 Mar 2024 15:01:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E27FB1A016E;
	Wed, 27 Mar 2024 15:01:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgAnSQxYxANmi6+LIQ--.50310S8;
	Wed, 27 Mar 2024 15:01:49 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz,
	bfoster@redhat.com,
	tj@kernel.org
Cc: dsterba@suse.com,
	mjguzik@gmail.com,
	dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/6] writeback: define GDTC_INIT_NO_WB to null
Date: Wed, 27 Mar 2024 23:57:51 +0800
Message-Id: <20240327155751.3536-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240327155751.3536-1-shikemeng@huaweicloud.com>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnSQxYxANmi6+LIQ--.50310S8
X-Coremail-Antispam: 1UD129KBjvJXoWrur1rurW3Ww45Cw4xXF1rCrg_yoW8JrWkpr
	ZxC3y5KF1UAFs293Z3Can2gwnrXa97tFW7G3s0gwsIyF4xJ3W8GFyjgw18tr4jvr93tryx
	ArZ7tFyxXa40y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU0TqcUUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
initialization of gdtc->dom for now.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/page-writeback.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 211565d01600..2fd2fd2e1932 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -147,6 +147,7 @@ struct dirty_throttle_control {
  * reflect changes in current writeout rate.
  */
 #define VM_COMPLETIONS_PERIOD_LEN (3*HZ)
+#define GDTC_INIT_NO_WB
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 
@@ -154,8 +155,6 @@ struct dirty_throttle_control {
 				.dom = &global_wb_domain,		\
 				.wb_completions = &(__wb)->completions
 
-#define GDTC_INIT_NO_WB		.dom = &global_wb_domain
-
 #define MDTC_INIT(__wb, __gdtc)	.wb = (__wb),				\
 				.dom = mem_cgroup_wb_domain(__wb),	\
 				.wb_completions = &(__wb)->memcg_completions, \
@@ -210,7 +209,6 @@ static void wb_min_max_ratio(struct bdi_writeback *wb,
 
 #define GDTC_INIT(__wb)		.wb = (__wb),                           \
 				.wb_completions = &(__wb)->completions
-#define GDTC_INIT_NO_WB
 #define MDTC_INIT(__wb, __gdtc)
 
 static bool mdtc_valid(struct dirty_throttle_control *dtc)
-- 
2.30.0


