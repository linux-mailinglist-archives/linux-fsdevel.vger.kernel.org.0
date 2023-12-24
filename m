Return-Path: <linux-fsdevel+bounces-6868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ECC81D903
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 12:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2893E1C214E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 11:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601A33C10;
	Sun, 24 Dec 2023 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eUqsMIbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AB2101;
	Sun, 24 Dec 2023 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703419144; bh=bwVnJ7f9d4R+HLmdVsQRUR+32VmNaaFUOK0l/TVS0aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUqsMIbqrNUpihWBZuPqLp+yfPFfwqKQXlcYlCaCpwhqTJJ8uMLiTK1H54530nwL8
	 RrPUPxb+7Q8nyYU8PTX4Ny32DvNSoSqKc6gjwUIryBzYaD0BKBBHnQeWSqx/Xwhq+q
	 uHKmM9y3jZ633JOpa81HnhUupX6kfXOG/j8AFNtM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id D3B898C9; Sun, 24 Dec 2023 19:52:59 +0800
X-QQ-mid: xmsmtpt1703418779tale22qig
Message-ID: <tencent_DABB2333139E8D1BCF4B5D1B2725FABA9108@qq.com>
X-QQ-XMAILINFO: NV9lVvsB36OpktO1KCwTUj4smAG+MtweeaJdLuOyDS/Po3/TqA7ngDgHIjmPzH
	 /eOFFFXBWyCNn5bC1+d+Ma2OAKtSQg3d7UgqoYZwpkUbtJc5FNKGwuUauV85azMolsjjQn96txSD
	 sWRvXZNjM/mTQh+gPjgXt0RnJvNJ7mOCVfAXbzpPtQzflxe9fzyXBdwtaFMdBFt7tjLBjrOz7nZJ
	 wgvyEL6RnoRaRtj4uUO+tAKmsrRHOp/gUUwWDH8UJ6phxhY4YPsPgiUMuNx8M8OzPlTNl1pHwfju
	 KH6GPdeiOJWr33Cy73LJJj9eKsLqDw/EONIapusAgRb+5haKQy/bdR69M23UKYh3X3u02LW4vx2y
	 eMz13UuAKQkwKaWevatCqBOs9EU1uJQhxZuGcJe82h11UH2t/YQFZmZ5mtiHPY7C2ciAYT7b4q6p
	 pPcUym10L9S3WPIKhyPN+Ijz9nhTHQ8ZfPCN8d4GJRS1OIKXLGVT/30Pki9Fpkg0sJ/tDAYsUA0h
	 I8vetm5mdpTh3TCazPjHKoO9mu8v9XnMWXCSdMibdcImciNZMNskdELV/geuJ1iFKA/qgNQ5EoQf
	 H2aSJIIUxVt4v19GndQ+F1KeNmcV9XwfFl5ZyYEski62C1HTDbbcSb0wiMf5zKgYCAY+WIHjN0rG
	 AP94jJ7BUOM86aAKFyIZxh6TizNE4rYM3tRoaiMhOYX5khRL4ZZlBXWvO7QJi3hQDYUmZaOjRDes
	 jw7TnP3du919JMXseJGvDmaoi8E4IVJbgPXMII15mFOGokwenqjucHVVKQgQryXNl3QwbaFvInOh
	 ZLBlj+FPk4YgOdlvk4YBkrxvHyF/LeSKMy0iNKOZyM64gDO/cii5UEd5G7o5fEaotddgkGOE50g+
	 y3Fj8boC/xKmKn+FRl5HJ7LIcCx7nGlFeDU7+v/YSdZAqIdVRVD4W475ECBjrQBP4IjfZVqSPCnw
	 JUK7UL/lk=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH] ext4: fix WARNING in lock_two_nondirectories
Date: Sun, 24 Dec 2023 19:53:00 +0800
X-OQ-MSGID: <20231224115259.3685280-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000e17185060c8caaad@google.com>
References: <000000000000e17185060c8caaad@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If inode is the ext4 boot loader inode, then when it is a directory, the inode
should also be set to bad inode.

Reported-and-tested-by: syzbot+2c4a3b922a860084cc7f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 61277f7f8722..b311f610f008 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4944,8 +4944,12 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
 	} else if (S_ISDIR(inode->i_mode)) {
-		inode->i_op = &ext4_dir_inode_operations;
-		inode->i_fop = &ext4_dir_operations;
+		if (ino == EXT4_BOOT_LOADER_INO)
+			make_bad_inode(inode);
+		else {
+			inode->i_op = &ext4_dir_inode_operations;
+			inode->i_fop = &ext4_dir_operations;
+		}
 	} else if (S_ISLNK(inode->i_mode)) {
 		/* VFS does not allow setting these so must be corruption */
 		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {
-- 
2.43.0


