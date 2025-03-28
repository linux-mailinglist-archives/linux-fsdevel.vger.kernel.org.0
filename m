Return-Path: <linux-fsdevel+bounces-45232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1376A74EA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 17:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C781896EE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D501D88AC;
	Fri, 28 Mar 2025 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD/ky/xu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A117F7;
	Fri, 28 Mar 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743180374; cv=none; b=neMXGRgZurZeOZZCKg6mINVpHOksy0Zv1vfIo4YoEEMKjO0SgSjMGQNh3ASR80XVYpDhjYexb9MgiFt8J8tiQg5PR/Mu1Ypbv1tR0ITcRgGuFXNNY3BG01vzdH56o4JuSbmqk5u8EbWRsQgtpVLYXKjG1FDv9j2jR4aBw+/qvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743180374; c=relaxed/simple;
	bh=9/Bw7M/XYqVHYUJz1MA4yttxFIDV6Z0kPxkjNHndnBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKwjJ6RUOd8q/r8935cwNgW1/1fd+Ar/Z5WxpRaS5609/jwgsA67qtMIUCb8Qfjp80A4RLkl5elp+i+0uKrK5scLuOS6FyEZx0ml+ZT5xZm13pXzYXI9uS4OekT9l9ki9ZIZP9E9gDMYYvIYSQy5P3EwbCpjgt9zP+IwFv1n1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD/ky/xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A3FC4CEE4;
	Fri, 28 Mar 2025 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743180373;
	bh=9/Bw7M/XYqVHYUJz1MA4yttxFIDV6Z0kPxkjNHndnBw=;
	h=From:To:Cc:Subject:Date:From;
	b=vD/ky/xurUVJ2mmdFX6xQ2BPYI8Yce85ATNMJ3Yi+kg3ViSasazgLzCU1kIaZG43F
	 YIGdoOO07myMPuIloj0UBEESi/hq16qqr2hxgdmPJSS71biYlBwN9wd/F44SiBhAMm
	 boAQSFw40Mw1A9ZPOg4RV2RM68PCTverANVEjEbtDZpbLSUwJm03mGre5o4VgT17w5
	 v6tiO4WQf1OPTndLAt5G31DUzVRjuIJ+K5g0a3gyo4hxr0SSPXSENqtSaghNbpALm+
	 lgmacTUX8X3M7DkWqDgD7qsCBheFxaHrDYG+0hmEumfh6CSn0bBxWeJVo3xs7dPTVU
	 f/VitloQs54gw==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] README: add supported fs list
Date: Sat, 29 Mar 2025 00:46:09 +0800
Message-ID: <20250328164609.188062-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To clarify the supported filesystems by fstests, add a fs list to
README file.

Signed-off-by: Zorro Lang <zlang@kernel.org>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---

The v1 patch and review points:
https://lore.kernel.org/fstests/20250227200514.4085734-1-zlang@kernel.org/

V2 did below things:
1) Fix some wrong english sentences
2) Explain the meaning of "+" and "-".
3) Add a link to btrfs comment.
4) Split ext2/3/4 to 3 lines.
5) Reorder the fs list by "Level".

Thanks,
Zorro

 README | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/README b/README
index 024d39531..5ceaa0c1e 100644
--- a/README
+++ b/README
@@ -1,3 +1,93 @@
+_______________________
+SUPPORTED FS LIST
+_______________________
+
+History
+-------
+
+Firstly, xfstests is the old name of this project, due to it was originally
+developed for testing the XFS file system on the SGI's Irix operating system.
+When xfs was ported to Linux, so was xfstests, now it only supports Linux.
+
+As xfstests has many test cases that can be run on some other filesystems,
+we call them "generic" (and "shared", but it has been removed) cases, you
+can find them in tests/generic/ directory. Then more and more filesystems
+started to use xfstests, and contribute patches. Today xfstests is used
+as a file system regression test suite for lots of Linux's major file systems.
+So it's not "xfs"tests only, we tend to call it "fstests" now.
+
+Supported fs
+------------
+
+Firstly, there's not hard restriction about which filesystem can use fstests.
+Any filesystem can give fstests a try.
+
+Although fstests supports many filesystems, they have different support level
+by fstests. So mark it with 4 levels as below:
+
+L1: Fstests can be run on the specified fs basically.
+L2: Rare support from the specified fs list to fix some generic test failures.
+L3: Normal support from the specified fs list, has some own cases.
+L4: Active support from the fs list, has lots of own cases.
+
+("+" means a slightly higher than the current level, but not reach to the next.
+"-" is opposite, means a little bit lower than the current level.)
+
++------------+-------+---------------------------------------------------------+
+| Filesystem | Level |                       Comment                           |
++------------+-------+---------------------------------------------------------+
+| XFS        |  L4+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Btrfs      |  L4   | https://btrfs.readthedocs.io/en/latest/dev/Development-\|
+|            |       | notes.html#fstests-setup                                |
++------------+-------+---------------------------------------------------------+
+| Ext4       |  L4   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Ext2       |  L3   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Ext3       |  L3   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| overlay    |  L3   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| f2fs       |  L3-  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| tmpfs      |  L3-  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| NFS        |  L2+  | https://linux-nfs.org/wiki/index.php/Xfstests           |
++------------+-------+---------------------------------------------------------+
+| Ceph       |  L2   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| CIFS       |  L2-  | https://wiki.samba.org/index.php/Xfstesting-cifs        |
++------------+-------+---------------------------------------------------------+
+| ocfs2      |  L2-  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Bcachefs   |  L1+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Exfat      |  L1+  | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| AFS        |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| FUSE       |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| GFS2       |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Glusterfs  |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| JFS        |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| pvfs2      |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Reiser4    |  L1   | Reiserfs has been removed, only left reiser4            |
++------------+-------+---------------------------------------------------------+
+| ubifs      |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| udf        |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| Virtiofs   |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+| 9p         |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
+
 _______________________
 BUILDING THE FSQA SUITE
 _______________________
-- 
2.47.1


