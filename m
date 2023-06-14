Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916F372F2FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbjFNDVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 23:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242392AbjFNDU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:20:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BFC196;
        Tue, 13 Jun 2023 20:20:55 -0700 (PDT)
X-UUID: 76115b980a6211ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w48tSpLqh1bjHgLcJdsXqvkcCf7nU4CX/ADnj4B4dnk=;
        b=WVi6RE4eL72h0ItIjr69r/D4N7M9q45UPK3mGZQ3sMqUgG5nNUO20RSrL9uAEfkQACtT3Ys+Gsg/dz8NzB/0RzQ8HjLq6Sv8U2+14IEAu1Yo4M33HtKh/qXsM1IDPUNB4AKz7N6khn8f8JPZGw0WVrnaauBkIOjB1qgIHcasFXU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:58c44784-1a93-475a-a639-9ef4b69fb3df,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:de9b8b3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 76115b980a6211ee9cb5633481061a41-20230614
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1036596478; Wed, 14 Jun 2023 11:20:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 11:20:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 11:20:48 +0800
From:   Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <wei-chin.tsai@mediatek.com>,
        <mel.lee@mediatek.com>, <ivan.tseng@mediatek.com>,
        Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 2/3] memory: export symbols for memory related functions
Date:   Wed, 14 Jun 2023 11:20:34 +0800
Message-ID: <20230614032038.11699-3-Wei-chin.Tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In this patch, we modified 3 files and export symbols
for 2 functions.
Export symbols for "smap_gather_stats" functions so that
user can have an idea for each user process memory's usage.
Export symbols for "arch_vma_name" functions so that
user can know the heap usage for each user process.
According to these two information, user can do the memory
statistics and anaysis.

Signed-off-by: Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
---
 arch/arm/kernel/process.c | 1 +
 fs/proc/task_mmu.c        | 5 +++--
 kernel/signal.c           | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 0e8ff85890ad..df91412a1069 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -343,6 +343,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	return is_gate_vma(vma) ? "[vectors]" : NULL;
 }
+EXPORT_SYMBOL_GPL(arch_vma_name);
 
 /* If possible, provide a placement hint at a random offset from the
  * stack for the sigpage and vdso pages.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 6259dd432eeb..814d7829a20b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -773,8 +773,8 @@ static const struct mm_walk_ops smaps_shmem_walk_ops = {
  *
  * Use vm_start of @vma as the beginning address if @start is 0.
  */
-static void smap_gather_stats(struct vm_area_struct *vma,
-		struct mem_size_stats *mss, unsigned long start)
+void smap_gather_stats(struct vm_area_struct *vma,
+		       struct mem_size_stats *mss, unsigned long start)
 {
 	const struct mm_walk_ops *ops = &smaps_walk_ops;
 
@@ -809,6 +809,7 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 	else
 		walk_page_range(vma->vm_mm, start, vma->vm_end, ops, mss);
 }
+EXPORT_SYMBOL_GPL(smap_gather_stats);
 
 #define SEQ_PUT_DEC(str, val) \
 		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
diff --git a/kernel/signal.c b/kernel/signal.c
index b5370fe5c198..a1abe77fcdc3 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4700,6 +4700,7 @@ __weak const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(arch_vma_name);
 
 static inline void siginfo_buildtime_checks(void)
 {
-- 
2.18.0

