Return-Path: <linux-fsdevel+bounces-69344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADAC77843
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 07:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183EB4E8404
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE96B2F658D;
	Fri, 21 Nov 2025 06:10:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B52DEA75;
	Fri, 21 Nov 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705431; cv=none; b=ttDyHqcF9fMDM5+IrmVeumgNwy6NsWQlavCIVxr/aOfM4EnrBN1IKZXUPHB2wpQ8/5zixkJ0daubI3YspvBjOZjEXtwUYJoNuqwHznxibvKSK65kc9Gp2pwMkmM/WSYsTFDavmYnVlAqpmgC/dhCbTnY/McI8NWZW65meutWXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705431; c=relaxed/simple;
	bh=AEEiqz0MmrNjByI5u5ZZOfzdxppiSBGwo4kurejNhaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T27VrpBLMzN9/rr28s/4FVSVww5nudEMuBNuAx5twmLvn8jEaHYdq6+9lJPRV/KcXEUVnzgGXpF+xVQG9qLma6O0yqpz10RnJ1JxOcIlMb8/bdrSDyY7bMBnMlD+90cAs4CxsvibnLwXPd6BdnwFcHA5ttDCvqAjGFJgtah8a7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCPvD22SYzYQv4M;
	Fri, 21 Nov 2025 14:09:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 53EA21A0EE7;
	Fri, 21 Nov 2025 14:10:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgD3VHtAAiBp_of0BQ--.63807S17;
	Fri, 21 Nov 2025 14:10:27 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 13/13] ext4: drop the TODO comment in ext4_es_insert_extent()
Date: Fri, 21 Nov 2025 14:08:11 +0800
Message-ID: <20251121060811.1685783-14-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3VHtAAiBp_of0BQ--.63807S17
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4kXw4kAF15Xw13GF4kWFg_yoW8JF4fpr
	sxCw48Jr4fXa1vkayxGF4UXryfGa40krW7Cr97Kw4SkFW5JFyS9F1qyFWYvFyfWrWxXrW5
	ZFW8Kwn8Wa15JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0JUQFxUUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Now we have ext4_es_cache_extent() to cache on-disk extents instead of
ext4_es_insert_extent(), so drop the TODO comment.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index e370240555ec..b681bd0c3dc0 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -898,7 +898,8 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 
 /*
  * ext4_es_insert_extent() adds information to an inode's extent
- * status tree.
+ * status tree. This interface is used for modifying extents. To cache
+ * on-disk extents, use ext4_es_cache_extent() instead.
  */
 void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 			   ext4_lblk_t len, ext4_fsblk_t pblk,
@@ -977,10 +978,6 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		}
 		pending = err3;
 	}
-	/*
-	 * TODO: For cache on-disk extents, there is no need to increment
-	 * the sequence counter, this requires future optimization.
-	 */
 	ext4_es_inc_seq(inode);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
-- 
2.46.1


