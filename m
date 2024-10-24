Return-Path: <linux-fsdevel+bounces-32732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B09AE615
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE632B26F5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC51EB9E8;
	Thu, 24 Oct 2024 13:23:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E6C1E765A;
	Thu, 24 Oct 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776187; cv=none; b=P4/dRG/m/ivEX7BIi5lui5OPHSS/iGi3VXmMnNI9jXyJbUaDU2RmzGAxV4/WBdjpDIhGuqeri53xNMKUwycMkO7ZTaXh8qtA7Bt6VYLe9dbhqcfn84X4dD3GVge8NupUIznwyt7ZYo2KS+QVAM0yw7VOCAzg9CXnHle/n1hg43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776187; c=relaxed/simple;
	bh=1EX5uIXT5gL8qdio8RoAllYmcluOgBpxl50iEl0yYak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s90JLoJ94D6Xb+Qsp7n0vxyjQsvOKl3QTJO8yfjI44T12W1xE9S0pEziUN7GR9Nk0ZPrGv9ElXRDY3mTyuPvSmKdtdA8Ee0zC58/4qIDEBbqYJtwa5z2lgknkD2hiJ77Tml09Iy5YxEhGByfSQH27TArUr+6DETf8MbQiFJKAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZ66D045kz4f3jdV;
	Thu, 24 Oct 2024 21:22:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 752F61A018D;
	Thu, 24 Oct 2024 21:23:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHusYpShpn7tb6Ew--.444S10;
	Thu, 24 Oct 2024 21:23:00 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	chuck.lever@oracle.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.6 06/28] maple_tree: remove unnecessary default labels from switch statements
Date: Thu, 24 Oct 2024 21:19:47 +0800
Message-Id: <20241024132009.2267260-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHusYpShpn7tb6Ew--.444S10
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1rJr45Gw4xtrW5XFW8WFg_yoWrZF43pa
	1UGryDK39rtF1vk3y0yr4fX3WfWwsxGay2ya1qgw1vvF45Cr93XFnYka4xCF15CaySvFW3
	ta1Yv348C3ZrZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRAR6zUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

commit 37a8ab24d3d4c465b070bd704e2ad2fa277df9d7 upstream.

Patch series "maple_tree: iterator state changes".

These patches have some general cleanup and a change to separate the maple
state status tracking from the maple state node.

The maple state status change allows for walks to continue from previous
places when the status needs to be recorded to make logical sense for the
next call to the maple state.  For instance, it allows for prev/next to
function in a way that better resembles the linked list.  It also allows
switch statements to be used to detect missed states during compile, and
the addition of fast-path "active" state is cleaner as an enum.

While making the status change, perf showed some very small (one line)
functions that were not inlined even with the inline key word.  Making
these small functions __always_inline is less expensive according to perf.
As part of that change, some inlines have been dropped from larger
functions.

Perf also showed that the commonly used mas_for_each() iterator was
spending a lot of time finding the end of the node.  This series
introduces caching of the end of the node in the maple state (and updating
it during writes).  This caching along with the inline changes yielded at
23.25% improvement on the BENCH_MAS_FOR_EACH maple tree test framework
benchmark.

I've also included a change to mtree_range_walk and mtree_lookup_walk to
take advantage of Peng's change [1] to the initial pivot setup.

mmtests did not produce any significant gains.

[1] https://lore.kernel.org/all/20230711035444.526-1-zhangpeng.00@bytedance.com/T/#u

This patch (of 12):

Removing the default types from the switch statements will cause compile
warnings on missing cases.

Link: https://lkml.kernel.org/r/20231101171629.3612299-2-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/maple_tree.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 97a610307d38..9de2e3dfdfcc 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -771,7 +771,6 @@ static inline void mte_set_pivot(struct maple_enode *mn, unsigned char piv,
 
 	BUG_ON(piv >= mt_pivots[type]);
 	switch (type) {
-	default:
 	case maple_range_64:
 	case maple_leaf_64:
 		node->mr64.pivot[piv] = val;
@@ -795,7 +794,6 @@ static inline void mte_set_pivot(struct maple_enode *mn, unsigned char piv,
 static inline void __rcu **ma_slots(struct maple_node *mn, enum maple_type mt)
 {
 	switch (mt) {
-	default:
 	case maple_arange_64:
 		return mn->ma64.slot;
 	case maple_range_64:
@@ -804,6 +802,8 @@ static inline void __rcu **ma_slots(struct maple_node *mn, enum maple_type mt)
 	case maple_dense:
 		return mn->slot;
 	}
+
+	return NULL;
 }
 
 static inline bool mt_write_locked(const struct maple_tree *mt)
@@ -7013,7 +7013,6 @@ static void mt_dump_range(unsigned long min, unsigned long max,
 		else
 			pr_info("%.*s%lx-%lx: ", depth * 2, spaces, min, max);
 		break;
-	default:
 	case mt_dump_dec:
 		if (min == max)
 			pr_info("%.*s%lu: ", depth * 2, spaces, min);
@@ -7053,7 +7052,6 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 		case mt_dump_hex:
 			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
 			break;
-		default:
 		case mt_dump_dec:
 			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
 		}
@@ -7083,7 +7081,6 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
 				break;
-			default:
 			case mt_dump_dec:
 				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
 					node, last, max, i);
@@ -7108,7 +7105,6 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 		case mt_dump_hex:
 			pr_cont("%lx ", node->gap[i]);
 			break;
-		default:
 		case mt_dump_dec:
 			pr_cont("%lu ", node->gap[i]);
 		}
@@ -7119,7 +7115,6 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 		case mt_dump_hex:
 			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
 			break;
-		default:
 		case mt_dump_dec:
 			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
 		}
-- 
2.39.2


