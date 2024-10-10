Return-Path: <linux-fsdevel+bounces-31539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7DC99848B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 13:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC211F24E89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5E1C3F13;
	Thu, 10 Oct 2024 11:11:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B031C232C;
	Thu, 10 Oct 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558677; cv=none; b=jFNziA7U4gRvLd+SlIapYFTWOgtirbhri+xXhEidXsXI2kIdxlx5L9xtDrLuzFPRuySngfqhvjx3c3INdhWTZE4GP0vRah8YiBhO9/OCYFYSDF+7Qb/hzf48bZvKfnUMBDXcTMhYhUslDjyeXbBfB/Q+sPMa14rHV9n6kGokZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558677; c=relaxed/simple;
	bh=vBHTQ3ikgMDpFYYlH9F7zDQg4le2xfA5vS2Z0MoAwNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uambZzOr/zxjr6UKexxtNHWCu6p0oKtAwkPw+AOGi1SKtqu04+/NFPj2uumr2IPX4ZIYTvVHtZdgKN+5RdIF5EAsdXNO3SF8kAU6VdqFS3V5AOmjmxj4CCCTdQ+mFBPw+eHRpAZcwyVB8H35ghIxlm6wEzAYw3yswJCYuPNag50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XPRrZ3y6Cz4f3jXb;
	Thu, 10 Oct 2024 19:10:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6C5F61A0359;
	Thu, 10 Oct 2024 19:11:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sZMtgdnmHXPDg--.37048S7;
	Thu, 10 Oct 2024 19:11:11 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 3/3] Documentation: add instructions for using 'drop_fs_caches sysctl' sysctl
Date: Thu, 10 Oct 2024 19:25:43 +0800
Message-Id: <20241010112543.1609648-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241010112543.1609648-1-yebin@huaweicloud.com>
References: <20241010112543.1609648-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sZMtgdnmHXPDg--.37048S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3Gw18ZrWfJF1kCFy7GFg_yoW8Zr1UpF
	ZrAryIgw18XFyxGryfAry7tFySvay8JFWaqas29r1Fv3ZxC34qvrnFyF1YqFy7GFW8C3yS
	qrZ8tr90gw1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
	v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1ByIUUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Add instructions for 'drop_fs_caches sysctl' sysctl in 'vm.rst'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f48eaa98d22d..4648ac1ac66c 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -36,6 +36,7 @@ Currently, these files are in /proc/sys/vm:
 - dirtytime_expire_seconds
 - dirty_writeback_centisecs
 - drop_caches
+- drop_fs_caches
 - enable_soft_offline
 - extfrag_threshold
 - highmem_is_dirtyable
@@ -268,6 +269,32 @@ used::
 These are informational only.  They do not mean that anything is wrong
 with your system.  To disable them, echo 4 (bit 2) into drop_caches.
 
+drop_fs_caches
+==============
+
+Writing to this will cause the kernel to drop clean for a specific file system
+caches, as well as reclaimable slab objects like dentries and inodes. Once
+dropped, their memory becomes free. Except for specifying the device number for
+a specific file system, everything else is consistent with drop_caches. The
+device number can be viewed through "cat /proc/self/montinfo" or 'lsblk'.
+
+To free pagecache::
+
+	echo "MAJOR:MINOR:1" > /proc/sys/vm/drop_caches
+
+To free reclaimable slab objects (includes dentries and inodes)::
+
+	echo "MAJOR:MINOR:2" > /proc/sys/vm/drop_caches
+
+To free slab objects and pagecache::
+
+	echo "MAJOR:MINOR:3" > /proc/sys/vm/drop_caches
+
+You may see informational messages in your kernel log when this file is
+used::
+
+	echo (1234): drop_fs_caches: MAJOR:MINOR:3
+
 enable_soft_offline
 ===================
 Correctable memory errors are very common on servers. Soft-offline is kernel's
-- 
2.31.1


