Return-Path: <linux-fsdevel+bounces-14745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822087EC8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A1E280FB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CA52F77;
	Mon, 18 Mar 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="cnmFKxKn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046444F5FE
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776938; cv=none; b=mJleUlgeYFWrXobIU+mxWgif9VBSKYomnRsn0PxNOo63NLPhQew0U68d8ETyLjGIuCrTTH6k7EW4jBZ9LCqoCI1t1tB0gRsVdxxUPx10mJJ5Em1sZnM9Qtk6tb/c6eGxEYV3K5J9FduEIU9PjrUREpy9mJ4VmwLpsiRLmdbk46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776938; c=relaxed/simple;
	bh=P2mrvSmlzie7vQSmXFC32spGcjtp7fqRoyCIPryRSRs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Duw67FfhcNRUEJzR1ilsydTCjZTBACS59HimdxxmI2yJ/dJMRz/R5xC09Lv8GbBCKKZJFVRBUkgigWAvrA995V+QQuB5jcmulSXuNCkHv6y4PNslEqFIpkEKB4esX+0aM4Ml8t/EwPe2gs9oBQOityQNpue+gvMgSWP0c3T1hpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=cnmFKxKn; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 5BA91240104
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 16:48:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1710776928; bh=P2mrvSmlzie7vQSmXFC32spGcjtp7fqRoyCIPryRSRs=;
	h=Content-Type:Mime-Version:Subject:From:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:To:From;
	b=cnmFKxKn0+APiCmv+eTDjs1YIjZIlKWbTZGXwgTagExa64Mhli4fMPXr0gnetBNEE
	 1PmCuYANO3Z2waQvNfuC4vSRhFJRkIj7lxsW7UCxKzjLrWMfTArP0GiMZ5T7LPnc0G
	 tab6HG4Hdu8DvlWZpw4fXzT5Mev3PjDpz9XhE4vLn9FN8mS9JVyvh8MJ0Hx590SBJy
	 gCa5yIJSVml3mRFzchAbFO32u7R1sTN+vfX3b+Ey2oS7jbgzAKvR5ZOMQNXgMvo0uh
	 r374aMUqrPHsBQJbBjpPlR9sRAbgpyjkoK1ZLJsSlXkFK0Dce9YsrRR7SYRVtKKQjN
	 /9KS3YrhMM5eQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4TyzmD52ZWz9rxN;
	Mon, 18 Mar 2024 16:48:44 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: Charalampos Mitrodimas <charmitro@posteo.net>
In-Reply-To: <0000000000002750950613c53e72@google.com>
Date: Mon, 18 Mar 2024 15:48:11 +0000
Cc: asmadeus@codewreck.org,
 ericvh@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux_oss@crudebyte.com,
 lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com,
 v9fs@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6E22992-FF45-44E3-8FBE-D157BED7B922@posteo.net>
References: <0000000000002750950613c53e72@google.com>
To: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>

please test uv in v9fs_evict_inode

#syz test =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 360a5304ec03..5d046f63e5fa 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -353,7 +353,8 @@ void v9fs_evict_inode(struct inode *inode)
 	filemap_fdatawrite(&inode->i_data);

 #ifdef CONFIG_9P_FSCACHE
-	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
+	if (v9fs_inode_cookie(v9inode))
+		fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), =
false);
 #endif
 }=

