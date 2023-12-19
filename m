Return-Path: <linux-fsdevel+bounces-6485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951CE818549
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 11:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5071F2242E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96A014F9F;
	Tue, 19 Dec 2023 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AlEoq3cC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8C114F77;
	Tue, 19 Dec 2023 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702981518; bh=atxKJG/+oOQOf1n8hjqc88GOaBMrWZfLPQjGsiRwgSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AlEoq3cCCXt+aNM2aKsmVzCLXrnDWDvS2w5VykAoffC/pxKn9K7Fk8n6FAoslwafe
	 5U6TcP7VOxdwAAw8a9l+ZXs4oxnymGK5YAULKTfJvldsEHggsjNAgZ4o7bzKafCGlP
	 kZIa6MFTzkyGDLdxtWjFyuZqYlRnZ1XX39TnbvcU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 4C98AAE1; Tue, 19 Dec 2023 18:19:09 +0800
X-QQ-mid: xmsmtpt1702981149t023sln67
Message-ID: <tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujEmdmqzMjwNHgjylki1TMvdz8WrMzVegcBdlk2NNeYBWMItDqSi
	 pp9rTBFNHYT6tR2W0IPBna9Z8CWlTDm2+VRenPQ7rOxHgrHXtS+ZLpoc2/Ep380ZQ2G6Kbtxm3VA
	 TggA7n/2eJmTsl+TtpqqCTDmKmMkthyo0pFL+dj8Pt28b+LU+qhfB8t0SJnt6TIfskKMZnn7jX+E
	 GCOXEarhSulPZKeyvH906JSoS33bTR9Cvem9wnSmvfJcMAW/kWjKdcUDnkVJKv0Zq+ruKil5qfT3
	 qirf6QVUXnxKjyaDiigd9dIJ8bUFCigVWb92IVRypkUwQ+7IyBytDA098Pyukq2WhDoTMByMdksO
	 nOJa4ZwMaMn9CLu+GmTIhhTXgVSmojO3JqX3otQ+lEUjB8KXG7CU5A6zOCmTa8W1h3It04mpk3kg
	 uHWKeUueuVNqzDyqiv8FNjFE78xN8Dij4w3Weva/5TvvIWiMq1kqq8ZJm0rUtu5N+EPR4EIV35gY
	 7vorusd1idyYrntPqZtHYZVbMdF/DdEqv4oP0LSwCaLBvw61mKOigvB20gIbIN/m2I8iBqXnFPfd
	 RhoR7tj7p0pvDZrH1FsOVzkQhRxzxYtM72aT58IqhllRUCk+TgRukgsPNXYqUntwC7NFv+xjKBoh
	 gO+hWARINeGkrzG1Dflr2ueVyUxN9RAJnnSZVBKSAu9jgnv43Z05dTjmdRYlheNEsvfcZaCDVsof
	 1p4I3OSvcNPfTFeQHvVYfRjfX1yJ0zXrC5UKJYQip3sa2ZTCEG3MoSbp1lncHuajzQ+oCFToghLO
	 jai+zsOUQtgX2SRo8r+Rv6/JKpUV6FqUjhQBzZeAdX3m3sHsat6OEhRB3p+hXQ7TTtT/gES7W64n
	 4G5+U8IdqeEAALVyMoRHjPeK3HzX3QEhOb8MeIJyCjyjJQr9AK10YKRCmdO2IE+ujIrvAZg4Rp3c
	 A//KQWZGbxovH5miC0pA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: clm@fb.com,
	daniel@iogearbox.net,
	dsterba@suse.com,
	john.fastabend@gmail.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liujian56@huawei.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: fix oob Read in getname_kernel
Date: Tue, 19 Dec 2023 18:19:10 +0800
X-OQ-MSGID: <20231219101909.2058476-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000d1a1d1060cc9c5e7@google.com>
References: <000000000000d1a1d1060cc9c5e7@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ioctl does not pass in the correct tgtdev_name string, oob will occur because
"\0" cannot be found.

Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/dev-replace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f9544fda38e9..e7e96e57f682 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -730,7 +730,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 			    struct btrfs_ioctl_dev_replace_args *args)
 {
-	int ret;
+	int ret, len;
 
 	switch (args->start.cont_reading_from_srcdev_mode) {
 	case BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS:
@@ -740,8 +740,10 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 		return -EINVAL;
 	}
 
+	len = strnlen(args->start.tgtdev_name, BTRFS_DEVICE_PATH_NAME_MAX + 1);
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
+	    args->start.tgtdev_name[0] == '\0' ||
+	    len == BTRFS_DEVICE_PATH_NAME_MAX + 1)
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
-- 
2.43.0


