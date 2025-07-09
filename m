Return-Path: <linux-fsdevel+bounces-54323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00157AFDD41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 04:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EA91BC6523
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 02:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20D11C861B;
	Wed,  9 Jul 2025 02:08:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EA2182
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026935; cv=none; b=KTYo5LjvKK6Or3qwG5jP3qqxpW0FfoncKs/iEHYFUaet6ydeiOI3xlwDHQVZ+f3Z34lNdA5/mtgmOqgQS2rgyTIqd/p6HKF/uPqBiKKWRgUEPxTFbuTR7vFYUimK5n6bvdlTR242Tq4R9d5ngJ0VVjS4iPz6KuIIn1mISl0dOoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026935; c=relaxed/simple;
	bh=a2IoXRWXRZuworFNVd9uu3xJH9GL6riJr0D+zvxGM6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8lrHB8+s7ESSs2MT2ktCswH+fGNIPTslyEXVfLjw7+1yJXRlr2Ji8PnliRYL1DjwPz9q4kADoKCOkDsia/DBscjwycg8SvjVpAUU44TGffokwM9xZ+kgGJ081kqqeBl8dDLiopQRIWMWy2vqepMDoEDVcsShgFeb3zBEUKxt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bcLxT6PMgzYQvSy
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 10:08:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B1F6C1A084E
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 10:08:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP3 (Coremail) with SMTP id _Ch0CgAHtSIqz21oXWVwBA--.7814S4;
	Wed, 09 Jul 2025 10:08:44 +0800 (CST)
From: leo.lilong@huaweicloud.com
To: miklos@szeredi.hu
Cc: leo.lilong@huawei.com,
	linux-fsdevel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lonuxli.64@gmail.com
Subject: [PATCH] fuse: show io_uring mount option in /proc/mounts
Date: Wed,  9 Jul 2025 10:02:29 +0800
Message-Id: <20250709020229.1425257-1-leo.lilong@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHtSIqz21oXWVwBA--.7814S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4UAF1UAw4rtw1xJry5urg_yoWkGwb_A3
	4xGw18Xa18Jw1rJayUCr4FqrWkurn7CF1DZr4SkFn5Xa47Zasaqr90vFy8CFsxGrsrWFZ8
	Wws5Xa43Zw1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzOJ5UUUUU
X-CM-SenderInfo: hohrhzxlor0w46kxt4xhlfz01xgou0bp/

From: Long Li <leo.lilong@huawei.com>

When mounting a FUSE filesystem with io_uring option and using io_uring
for communication, this option was not shown in /proc/mounts or mount
command output. This made it difficult for users to verify whether
io_uring was being used for communication in their FUSE mounts.

Add io_uring to the list of mount options displayed in fuse_show_options()
when the fuse-over-io_uring feature is enabled and being used.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ecb869e895ab..a6a8cd84fdde 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -913,6 +913,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 			seq_puts(m, ",default_permissions");
 		if (fc->allow_other)
 			seq_puts(m, ",allow_other");
+		if (fc->io_uring)
+			seq_puts(m, ",io_uring");
 		if (fc->max_read != ~0)
 			seq_printf(m, ",max_read=%u", fc->max_read);
 		if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
-- 
2.39.2


