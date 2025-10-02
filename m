Return-Path: <linux-fsdevel+bounces-63329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A43BB5A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 01:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D87488188
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 23:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AB928488F;
	Thu,  2 Oct 2025 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b="mf9i2fKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985C3BB44
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449366; cv=none; b=DJ/1cwCMAXQWl88exPjVp1C5V9I3nsdRdcdibTa5dTGUGYSRAaIvoIanyPneAbunn0q9ebFGR7MOozx2WEsh9OjMVhmCYksXsPUb+E49OhclXEuTwFv2waKi9o1ifNlYLZWgrV9ZQfbPPLlGrf0LX043nTVUm+H39ZmQ4wf7+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449366; c=relaxed/simple;
	bh=Eb5OQR27ga/yjnkst0mpugvtgWDcxwNr0mU+lkYSMr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP0ZveaQyG0+FfTIZ0FkSChnj/qhC03O9KCbEmJ7aO4e43MYckYv242rTFMe+W9Pu5oy/aNGSpQDPfj5ckMXn4lHMgfgEQV3WY6z2ndKOpEnwQ+1UChb7NgdKYpv0Ei1olDDwYLrWcAgXgEeTvkueNHt9tJSov0SFwFqZj1e5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com; spf=pass smtp.mailfrom=gvernon.com; dkim=pass (2048-bit key) header.d=gvernon.com header.i=@gvernon.com header.b=mf9i2fKM; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gvernon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gvernon.com
Date: Fri, 3 Oct 2025 00:55:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gvernon.com; s=key1;
	t=1759449351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/yi1yEqAwTei7shT0eMG6OETQS6KDTsPMIjRznx84I=;
	b=mf9i2fKMfu4NSJVwaGCCrDEaA3tvS7wZCFnwQDJpGc60+9Bm2wHVZ0Pk9KYAnESjj6Nogw
	z5EWMrj7TINjpzr+30xi3LQRMpQMDAa4UNTsKFRdkNyC/Xu/g3zovZ12h7IiVppK7Y6ayl
	4xc3R9peKElKrN6zWifdcweEW/BDgHcfuWEAS1EgsUn331MPc25syxXpd8SYIdyNNzDvr7
	4PvpGqfe5MBlB9BkaWHuhK0xqksIuivH6bAxou6UQlqUSjcF1W/an9TTPifkVEP1aJxa/q
	iIlrHuSI9/YYdP3f42uGIycvf1GxMQ5UGtHJzz8kL1SU1j/hsqRyVbqnTaLCXQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: George Anthony Vernon <contact@gvernon.com>
To: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
Cc: damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
Message-ID: <aN8RBYdn6lxRz6Wl@Bertha>
References: <aN6laD5P8zq0F5ns@Bertha>
 <68dea8c7.050a0220.25d7ab.07ce.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0hSeNZu02imxeqa6"
Content-Disposition: inline
In-Reply-To: <68dea8c7.050a0220.25d7ab.07ce.GAE@google.com>
X-Migadu-Flow: FLOW_OUT


--0hSeNZu02imxeqa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 02, 2025 at 09:31:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> kernel BUG in hfs_write_inode
> 
> ------------[ cut here ]------------
> kernel BUG at fs/hfs/inode.c:444!

Attaching a patch since I'm failing to reproduce locally on mainline.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.17

Thanks,

George

--0hSeNZu02imxeqa6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-hfs-Validate-CNIDs-in-hfs_read_inode.patch

From 40db09869bfabf51593f9a638aff09c72d9c8f1e Mon Sep 17 00:00:00 2001
From: George Anthony Vernon <contact@gvernon.com>
Date: Fri, 3 Oct 2025 00:32:06 +0100
Subject: [PATCH] hfs: Validate CNIDs in hfs_read_inode

hfs_read_inode previously did not validate CNIDs read from disk,
thereby allowing bad inodes to be placed on the dirty list and written
back.

Validate reserved CNIDs according to Apple technical note TN1150.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Signed-off-by: George Anthony Vernon <contact@gvernon.com>
---
 fs/hfs/inode.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..ab71493cf501 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -310,6 +310,34 @@ static int hfs_test_inode(struct inode *inode, void *data)
 	}
 }
 
+/*
+ * is_valid_cnid
+ *
+ * Validate the catalog number of an inode read from disk
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
@@ -348,6 +376,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		}
 
 		inode->i_ino = be32_to_cpu(rec->file.FlNum);
+		if (!is_valid_cnid(inode->i_ino, HFS_CDR_FIL)) {
+			printk(KERN_WARNING "hfs: rejected cnid %lu\n", inode->i_ino);
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_mode = S_IRUGO | S_IXUGO;
 		if (!(rec->file.Flags & HFS_FIL_LOCK))
 			inode->i_mode |= S_IWUGO;
@@ -361,6 +394,11 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		break;
 	case HFS_CDR_DIR:
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
+		if (!is_valid_cnid(inode->i_ino, HFS_CDR_DIR)) {
+			printk(KERN_WARNING "hfs: rejected cnid %lu\n", inode->i_ino);
+			make_bad_inode(inode);
+			break;
+		}
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
-- 
2.50.1


--0hSeNZu02imxeqa6--

