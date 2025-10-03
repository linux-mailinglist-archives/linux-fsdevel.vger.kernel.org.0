Return-Path: <linux-fsdevel+bounces-63331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650B7BB5B35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6E51AE1FDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 01:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F41DEFE9;
	Fri,  3 Oct 2025 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="l8JPcz7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D11D88AC
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453409; cv=none; b=mp9PF9uOsYH+Sqd54tPFIqRntXejfnYp2pKpsGOjYdYD53iEbdhSBQECbBEJ0jc8Yd9BIlJOt1DsprIed9t8Pap/0PWnAX83C6qIQfTxmMY/O2UL4Qc2Qe6mm7eLg8wVUVXCannSBlEC+unpJTP06r8v+Y+bS2yzezdCl0IX/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453409; c=relaxed/simple;
	bh=k4olXZDPeb+G26aKPKTTVdR8KdrflEg7mIAJV2iX4jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVaLpGd0UOJEeJD9MlVYcrZqLUvOO0GHAgE5Yo3Bzu/Ulc2u03w/tIcDlJkD9M6yT1pWyMZwMrF9YMvfTYg/6E1RosKohO1XH8lKM+jbgvBTRIfwBk3rmdIMCHOTZ/M1R7+spY+v+ctGyfqt5cVibKwgQwoOLfN7Hy+nihE/l+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=l8JPcz7b; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Fri, 3 Oct 2025 02:03:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1759453404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TjsimwOst1vzRVadPFbkxpui3dYsM90Q3EJc3UtLHgU=;
	b=l8JPcz7bWhyZn9V/OT2jakUqc1MiKFhOQOY1oruXX/0NXk+Jr6VvTDig19urE92MBi6eGw
	z/OzxqZOo5Nnnxr4X7ZBejP28M/70UmVCtF8C6a1DJkEJgKxFtFHLyC2uQtb2MXOxGSmYT
	d9st0J+Yn73OwYKmo1RZw/Lzl7MOSJifEIG3t2VwHAifSFwzr5nsh4rqEtubjI1m93Y9nh
	WpFQOZpHQne0ReIUZYfgkKNzSgTSwGOYh2Fl32aodX6a/ttDhB0imY+HfRJZZw6gzHjj7L
	odtCfM0z67HkQEGu2ER/Y6l+HmdvT1EAUszbOPQqDZGedvh/JK7z+5e1s1bW3A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Cc: damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
Message-ID: <aN8g1OkBMndiyKyd@Bertha>
References: <aN8RBYdn6lxRz6Wl@Bertha>
 <68df163b.050a0220.2c17c1.000a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1jPToeCDY8B8MXLW"
Content-Disposition: inline
In-Reply-To: <68df163b.050a0220.2c17c1.000a.GAE@google.com>
X-Migadu-Flow: FLOW_OUT


--1jPToeCDY8B8MXLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2025 at 05:18:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e5f0a698 Linux 6.17
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.17
> console output: https://syzkaller.appspot.com/x/log.txt?x=160acee2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
> dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=11089334580000
> 
> Note: testing is done by a robot and is best-effort only.

#syz test

--1jPToeCDY8B8MXLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-hfs-Validate-CNIDs-in-hfs_read_inode.patch

From 5ff1f6bf582a643bce73f6a1c431bfe540f76b8a Mon Sep 17 00:00:00 2001
From: George Anthony Vernon <contact@gvernon.com>
Date: Fri, 3 Oct 2025 01:41:24 +0100
Subject: [PATCH] hfs: Validate CNIDs in hfs_read_inode

hfs_read_inode previously did not validate CNIDs read from disk, thereby
allowing bad inodes to be constructed and placed on the dirty list,
eventually hitting a bug on writeback.

Validate reserved CNIDs according to Apple technical note TN1150.

This issue was discussed on LKML previously:
https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5b@
I-love.SAKURA.ne.jp/T/

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 fs/hfs/inode.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 9cd449913dc8..da6a6b32d8c2 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -321,6 +321,34 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	}
 }
 
+/*
+ * is_valid_cnid
+ *
+ * Validate the CNID of a catalog record read from disk
+ */
+static bool is_valid_cnid(unsigned long cnid, s8 type)
+{
+	if (likely(cnid >= HFS_FIRSTUSER_CNID))
+		return true;
+
+	switch (cnid) {
+	case HFS_POR_CNID:
+		return type == HFS_CDR_DIR;
+	case HFS_ROOT_CNID:
+		return type == HFS_CDR_DIR;
+	case HFS_EXT_CNID:
+		return type == HFS_CDR_FIL;
+	case HFS_CAT_CNID:
+		return type == HFS_CDR_FIL;
+	case HFS_BAD_CNID:
+		return type == HFS_CDR_FIL;
+	case HFS_EXCH_CNID:
+		return type == HFS_CDR_FIL;
+	default:
+		return false;
+	}
+}
+
 /*
  * hfs_read_inode
  */
@@ -359,6 +387,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		}
 
 		inode->i_ino = be32_to_cpu(rec->file.FlNum);
+		if (!is_valid_cnid(inode->i_ino, HFS_CDR_FIL)) {
+			pr_warn("rejected cnid %lu\n", inode->i_ino);
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_mode = S_IRUGO | S_IXUGO;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
@@ -372,6 +405,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		break;
 	case HFS_CDR_DIR:
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
+		if (!is_valid_cnid(inode->i_ino, HFS_CDR_DIR)) {
+			pr_warn("rejected cnid %lu\n", inode->i_ino);
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
-- 
2.50.1


--1jPToeCDY8B8MXLW--

