Return-Path: <linux-fsdevel+bounces-1899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BA7DFF65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 08:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF7281DFC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0CF749D;
	Fri,  3 Nov 2023 07:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D227E
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 07:29:14 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF3194;
	Fri,  3 Nov 2023 00:29:11 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SMC310yYgz1P7jH;
	Fri,  3 Nov 2023 15:26:05 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 3 Nov 2023 15:29:08 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, Matthew Wilcox <willy@infradead.org>, David Hildenbrand
	<david@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/5] mm: remove page idle and young wrapper
Date: Fri, 3 Nov 2023 15:29:01 +0800
Message-ID: <20231103072906.2000381-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected

Convert to use folio idle and young functions instead of page ones,
then remove all page idle and young wrapper.

Kefeng Wang (5):
  mm: huge_memory: use more folio api in __split_huge_page_tail()
  mm: task_mmu: use a folio in smaps_account()
  mm: task_mmu: use a folio in clear_refs_pte_range()
  fs/proc/page: use a folio in stable_page_flags()
  page_idle: kill page idle and young wrapper

 fs/proc/page.c            | 22 +++++++++++-----------
 fs/proc/task_mmu.c        | 28 +++++++++++++++-------------
 include/linux/page_idle.h | 25 -------------------------
 mm/huge_memory.c          | 12 ++++++------
 4 files changed, 32 insertions(+), 55 deletions(-)

-- 
2.27.0


