Return-Path: <linux-fsdevel+bounces-68716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2757BC63CEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B78564E601A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBCF328B65;
	Mon, 17 Nov 2025 11:27:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF029E0E5;
	Mon, 17 Nov 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763378863; cv=none; b=PckE7eoK1g22fhucCxv56UTvHddnQ1Qw8cS4P5dX7ExcWiyZ83PQ/CDmCbHlIoRNZbHlVZdB08WTkJShget7eq3ImKe6GrfWS51pWPVZLcRjzZY27qKQbqxW5zhqevLetP8FAS6fp5bDeeTiw7Oi0NO/07zzIzZnYaRh7Updmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763378863; c=relaxed/simple;
	bh=mYfhmHwAUSzhInO9DGj+Ff7qiULVZ3pQYTpsAT+Skkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1CLKHlyusmG1aKYjEVSoGpOISBoYfkSwCF0fAEXmmWJ2bN9ZUXSy6i3g8s+Slyfn4SMjLal2K5OxDBnu+G2ZPdlXvoktua0cpOWl2TtTlQhkjEMCIXy3qyWugHETprIOSdyLEMmpGGFI/Zf8fk76h5x3BkAbwq+bPuIgCYFbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d957B1F8yzYQvJn;
	Mon, 17 Nov 2025 19:27:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DB7AE1A0838;
	Mon, 17 Nov 2025 19:27:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP2 (Coremail) with SMTP id Syh0CgAnhXunBhtp39Q6BA--.30165S7;
	Mon, 17 Nov 2025 19:27:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yebin10@huawei.com
Subject: [PATCH v2 3/3] Documentation: add instructions for using 'drop_fs_caches sysctl' sysctl
Date: Mon, 17 Nov 2025 19:27:35 +0800
Message-Id: <20251117112735.4170831-4-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117112735.4170831-1-yebin@huaweicloud.com>
References: <20251117112735.4170831-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAnhXunBhtp39Q6BA--.30165S7
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW3Gw18ZF4fZF1UZr18Zrb_yoW8uF47pF
	ZrAryIgw48WF47Gry3Xr47tFySvay8JFy2q3s7Kr1rZ3W5CryjvrnFyw4aqFy7GFW8Cw4I
	qrZ8Kwn8Ww4DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc4SoDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Add instructions for 'drop_fs_caches sysctl' sysctl in 'vm.rst'.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index ace73480eb9d..c6c29c8cf92e 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -37,6 +37,7 @@ Currently, these files are in /proc/sys/vm:
 - dirtytime_expire_seconds
 - dirty_writeback_centisecs
 - drop_caches
+- drop_fs_caches
 - enable_soft_offline
 - extfrag_threshold
 - highmem_is_dirtyable
@@ -284,6 +285,39 @@ used::
 These are informational only.  They do not mean that anything is wrong
 with your system.  To disable them, echo 4 (bit 2) into drop_caches.
 
+drop_fs_caches
+==============
+
+Writing to this will cause the kernel to drop clean for a specific file system
+caches, as well as reclaimable slab objects like dentries and inodes. Once
+dropped, their memory becomes free. Except for specifying the device number
+or file path for a specific file system, everything else is consistent with
+drop_caches. The device number can be viewed through "cat /proc/self/montinfo"
+or 'lsblk'.
+
+To free pagecache::
+
+	echo "1 MAJOR:MINOR" > /proc/sys/vm/drop_fs_caches
+Or
+	echo "1 /mnt/XX" > /proc/sys/vm/drop_fs_caches
+
+To free reclaimable slab objects (includes dentries and inodes)::
+
+	echo "2 MAJOR:MINOR" > /proc/sys/vm/drop_fs_caches
+Or
+	echo "2 /mnt/XX" > /proc/sys/vm/drop_fs_caches
+
+To free slab objects and pagecache::
+
+	echo "3 MAJOR:MINOR" > /proc/sys/vm/drop_fs_caches
+Or
+	echo "3 /mnt/XX" > /proc/sys/vm/drop_fs_caches
+
+You may see informational messages in your kernel log when this file is
+used::
+
+	echo (1234): drop_fs_caches: 3 MAJOR:MINOR
+
 enable_soft_offline
 ===================
 Correctable memory errors are very common on servers. Soft-offline is kernel's
-- 
2.34.1


