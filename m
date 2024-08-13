Return-Path: <linux-fsdevel+bounces-25781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C455C95054E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1691F253B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4B319EED2;
	Tue, 13 Aug 2024 12:39:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935A19E7F8;
	Tue, 13 Aug 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552770; cv=none; b=YWDtmTv+qyDGD8FM43gb8iuQ71ySGWcXfxVIg6a1kUwrIETHgzf552Dvs2ZvDGvRS7iJA54y5zw9EEBs2iqSW8NdITmJk+2NKf+QAtyGKYlcSBUzeos/79I+UmueS6musqZkW6HHE/qVaf8e7g5h4elm8Lyoq55YnwErKq5YiUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552770; c=relaxed/simple;
	bh=OUvOd5cE3JQLaGwFPL8TMCXDbjI+f0n3onvmDO8Ton4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtRPrUEjZFtKoWxZyUS+V6zBjV175AwqKI3Ui49jXzgW8x+tZXmh3lxbDNCsgt7RoqVXwYDn2N5zAiurMkj0HNwnol2qdyapUeqkyJKnGZ+01ABc90TGthI4CKKd5rK8fpgiV0Jk8lg1k50c+gW0VnWukdzfjJ3fjY2HO/UpyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjrYC4JNSz4f3k6W;
	Tue, 13 Aug 2024 20:39:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DBCA41A0568;
	Tue, 13 Aug 2024 20:39:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4XkU7tmejNSBg--.17625S13;
	Tue, 13 Aug 2024 20:39:20 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 09/12] ext4: drop unused ext4_es_store_status()
Date: Tue, 13 Aug 2024 20:34:49 +0800
Message-Id: <20240813123452.2824659-10-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4XkU7tmejNSBg--.17625S13
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1UZF1DJw18WFW5Cw4xXrb_yoWfGFgEva
	42kr1UWF1ayrs3uF1UAr18JrWj9rn7W3WxWay8tFWku34UXrWxAF4DZr1fZrW5Wr43Ar17
	ursrJw1jkFyqvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7VUbPC7UUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

The helper ext4_es_store_status() is unused now, just drop it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 47b3b55a852c..3ca40f018994 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -224,13 +224,6 @@ static inline void ext4_es_store_pblock(struct extent_status *es,
 	es->es_pblk = block;
 }
 
-static inline void ext4_es_store_status(struct extent_status *es,
-					unsigned int status)
-{
-	es->es_pblk = (((ext4_fsblk_t)status << ES_SHIFT) & ES_MASK) |
-		      (es->es_pblk & ~ES_MASK);
-}
-
 static inline void ext4_es_store_pblock_status(struct extent_status *es,
 					       ext4_fsblk_t pb,
 					       unsigned int status)
-- 
2.39.2


