Return-Path: <linux-fsdevel+bounces-36903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC7A9EAD15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 10:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A416E28C3FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B332623DEAF;
	Tue, 10 Dec 2024 09:46:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590D23D422;
	Tue, 10 Dec 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824004; cv=none; b=MLbsGK5xj53Xql5NOVOHrnZDqSRAjyzPxzQfYM9jqOjHvkz5J8CpsgZ8Cz9Xj8R3c6n9F/7WzgkOb4c25fe7krUM4yp5yHvZkXCfqQIXh7EMPgHvn/hZ1CjvHAr25r9otMoHfS6BkysYTDtE3xuf6VGMd2OrVuVTJsO9ueeDJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824004; c=relaxed/simple;
	bh=rVrVYAeSB1gXsFY2HLhe6dTAdbP5Xn56IBBWQJWNcZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UZGvabAwkOxfSdY+wHCI7CTKwUxBXa3uOk7OvtfauxJguEwaknjqcavciW7K9PwPiLdtnlO2cEpnc8LldrN+j513ll+kpIemJHvj2HY0O86CdT6o+O26QeRm9oI1SI7m80cfbApRgMAfalOvghwejhnT8CSTs7Jkk69lw6drcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9de720e0b6db11efa216b1d71e6e1362-20241210
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, UD_UNTRUSTED, UD_UNFAMILIAR, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_UNKNOWN, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:611557c4-0c3d-48f9-97ae-f4d1c046dbce,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.41,REQID:611557c4-0c3d-48f9-97ae-f4d1c046dbce,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:3e97f371733e5246cd8ff0bb397c11bc,BulkI
	D:2412101737144WS4RCGO,BulkQuantity:1,Recheck:0,SF:17|19|24|38|44|66|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 9de720e0b6db11efa216b1d71e6e1362-20241210
X-User: husong@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <husong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1811606421; Tue, 10 Dec 2024 17:46:23 +0800
From: Hu Song <husong@kylinos.cn>
To: gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	husong@kylinos.cn,
	liuye@kylinos.cn
Subject: [PATCH 4.19.y] fs/iomap: use consistent gfp flags during xfs readpages
Date: Tue, 10 Dec 2024 17:46:17 +0800
Message-Id: <20241210094617.66152-1-husong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In low memory situations(Specifically in docker),xfs_vm_readpages
path might declare memcg oom during fs pagefault and kill applications.

This patch extends the commit 8a5c743e308d ("mm, memcg: use consistent
gfp flags during readahead") to include XFS by modifying its readahead
path to use readahead_gfp_mask.Specifically, the gfp_mask logic in
xfs_vm_readpages and related functions is now aligned with
readahead_gfp_mask to ensure consistent behavior during readahead.
This prevents potential OOMs caused by discrepancies in gfp_mask handling.

Test Results:
run docker:docker container run --name wget.100m.ky -d
	--memory 104857600 --memory-swap 104857600;
docker : wget http://172.17.0.1/testfile(2G largely file)

Before the fix:
printk:try_to_free_mem_cgroup_pages's parameters: gfp_mask=0x62004a
(GFP_NOFS|__GFP_HIGHMEM |__GFP_HARDWALL|__GFP_MOVABLE)
and return value:nr_reclaimed: 0

[  153.390196] CPU: 1 PID: 5405 Comm: wget Kdump: loaded Not tainted 4.19.90-25+ #24
[  153.390197] Hardware name: American Megatrends Inc. To be filled by O.E.M./To be filled by O.E.M., BIOS ITSW3001 09/14/2020
[  153.390197] Call Trace:
[  153.390199]  dump_stack+0x64/0x88
[  153.390200]  try_to_free_mem_cgroup_pages.cold+0x30/0x3e
[  153.390201]  try_charge+0x2d9/0x7a0
[  153.390202]  ? memcg_check_events+0xdd/0x250
[  153.390203]  mem_cgroup_try_charge+0x8b/0x180
[  153.390204]  __add_to_page_cache_locked+0x64/0x240
[  153.390205]  add_to_page_cache_lru+0x48/0xe0
[  153.390206]  iomap_readpages_actor+0x10e/0x240
[  153.390207]  iomap_apply+0xc3/0x130
[  153.390208]  ? iomap_write_begin.constprop.0+0x310/0x310
[  153.390209]  iomap_readpages+0xa4/0x190
[  153.390210]  ? iomap_write_begin.constprop.0+0x310/0x310
[  153.390211]  read_pages.isra.0+0x72/0x190
[  153.390212]  __do_page_cache_readahead+0x1b2/0x1d0
[  153.390214]  filemap_fault+0x2d6/0x570
[  153.390235]  __xfs_filemap_fault+0x6b/0x200 [xfs]
[  153.390236]  __do_fault+0x38/0x120
[  153.390237]  do_fault+0x119/0x3e0
[  153.390238]  __handle_mm_fault+0x455/0x5d0
[  153.390239]  handle_mm_fault+0x90/0x1b0
[  153.390240]  __do_page_fault+0x2ea/0x540
[  153.390242]  do_page_fault+0x33/0x120
[  153.390243]  ? page_fault+0x8/0x30
[  153.390243]  page_fault+0x1e/0x30
[  153.390244] RIP: 0033:0x7f5404794514
[  153.390246] Code: Bad RIP value.
[  153.390246] RSP: 002b:00007fff244f0728 EFLAGS: 00010246
[  153.390246] RAX: 0000000000001000 RBX: 0000000000001000 RCX: 00007f5404794514
[  153.390247] RDX: 0000000000001000 RSI: 000055ef7f87e640 RDI: 0000000000000004
[  153.390247] RBP: 000055ef7f87e640 R08: 0000000000000000 R09: 000055ef7f87e670
[  153.390248] R10: 000055ef7f87e620 R11: 0000000000000246 R12: 000055ef7f879d80
[  153.390248] R13: 0000000000001000 R14: 00007f540485d7c0 R15: 0000000000001000
[  153.390257] wget invoked oom-killer: gfp_mask=0x600040(GFP_NOFS), nodemask=(null), order=0, oom_score_adj=0
[  153.390257] wget cpuset=bae816dd30bd6e193684d5580f57fd54df29c0a695dec5b7606931d248c18dd2 mems_allowed=0

wget downloads a 2G file and oom kills the process almost every time

After the fix:
printk:try_to_free_mem_cgroup_pages's parameters: gfp_mask=0x62124a
(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|
__GFP_HARDWALL|__GFP_MOVABLE)
and return value: nr_reclaimed: 55

[  196.970857] CPU: 9 PID: 5326 Comm: wget Kdump: loaded Not tainted 4.19.90-25+ #23
[  196.970858] Hardware name: American Megatrends Inc. To be filled by O.E.M./To be filled by O.E.M., BIOS ITSW3001 09/14/2020
[  196.970858] Call Trace:
[  196.970860]  dump_stack+0x64/0x88
[  196.970861]  try_to_free_mem_cgroup_pages.cold+0x30/0x3e
[  196.970862]  try_charge+0x2d9/0x7a0
[  196.970863]  ? memcg_check_events+0xdd/0x250
[  196.970865]  mem_cgroup_try_charge+0x8b/0x180
[  196.970865]  __add_to_page_cache_locked+0x64/0x240
[  196.970866]  add_to_page_cache_lru+0x48/0xe0
[  196.970868]  iomap_readpages_actor+0x125/0x250
[  196.970869]  iomap_apply+0xc3/0x130
[  196.970870]  ? iomap_write_begin.constprop.0+0x310/0x310
[  196.970871]  iomap_readpages+0xa4/0x190
[  196.970872]  ? iomap_write_begin.constprop.0+0x310/0x310
[  196.970873]  read_pages.isra.0+0x72/0x190
[  196.970875]  __do_page_cache_readahead+0x160/0x1d0
[  196.970876]  filemap_fault+0x2d6/0x570
[  196.970897]  __xfs_filemap_fault+0x6b/0x200 [xfs]
[  196.970899]  __do_fault+0x38/0x120
[  196.970900]  do_fault+0x119/0x3e0
[  196.970901]  __handle_mm_fault+0x455/0x5d0
[  196.970903]  handle_mm_fault+0x90/0x1b0
[  196.970905]  __do_page_fault+0x2ea/0x540
[  196.970906]  do_page_fault+0x33/0x120
[  196.970907]  ? page_fault+0x8/0x30
[  196.970908]  page_fault+0x1e/0x30
[  196.970909] RIP: 0033:0x7fed5d34b340
[  196.970911] Code: Bad RIP value.
[  196.970912] RSP: 002b:00007ffcf231fd68 EFLAGS: 00010246
[  196.970913] RAX: 0000000000000000 RBX: 000055f860649030 RCX: 00000000061a9000
[  196.970913] RDX: 000055f860664980 RSI: 0000000000000000 RDI: 000055f860649030
[  196.970913] RBP: 000000000000003b R08: 7fffffffffffffff R09: 7ffffffff9e58fff
[  196.970914] R10: 000055f860667620 R11: 0000000000000246 R12: 00000000061a9000
[  196.970914] R13: 0000000000000000 R14: 000055f860664b50 R15: 000055f860664980

wget downloads a 2G file and is tested 500 times without being killed

Fixes: 8a5c743e308d ("mm, memcg: use consistent gfp flags during readahead")
Signed-off-by: Hu Song <husong@kylinos.cn>
---
 fs/iomap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 04e82b6bd9bf..a34e4ec874f0 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -424,6 +424,7 @@ static struct page *
 iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
 		loff_t length, loff_t *done)
 {
+	gfp_t gfp_mask = readahead_gfp_mask(inode->i_mapping);
 	while (!list_empty(pages)) {
 		struct page *page = lru_to_page(pages);
 
@@ -432,7 +433,7 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
 
 		list_del(&page->lru);
 		if (!add_to_page_cache_lru(page, inode->i_mapping, page->index,
-				GFP_NOFS))
+				gfp_mask | GFP_NOFS))
 			return page;
 
 		/*
-- 
2.25.1


