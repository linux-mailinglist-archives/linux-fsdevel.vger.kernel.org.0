Return-Path: <linux-fsdevel+bounces-32390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C461B9A49E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870DA283C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F8191F71;
	Fri, 18 Oct 2024 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JDTdFaIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AF19049B
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 23:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293560; cv=none; b=bI0t9g0nJX6dLIhcSGYow84U+4v4zndFFA5dRN9evgmJkg3wppNKuIKRNlGsHE2SVW+D4LSTQ6EbL+C4YorATkbZr7c8BCqMPNDLUqiImFw8oNLpSYWtxmumS5z4vneCXxF9owl1N9AcPnse9q/4zcuBwSEacT4G7TuQHdzuEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293560; c=relaxed/simple;
	bh=SEpZ/Iz/JJNcmEV7HnF8Fc0cfRkUwkzMTwJmKWSVB5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr05VPnp3PcD0lJ+AYyAGr7u5iFoZTdD5aE6FHub3hHHTmx7022qds4L1WWN+rsSQ+JCVIRo8rtUobPYHnDHGgF8btG5GqbATbpXz8K1OrWTMRj2b0R7uidhussforOnogzzZZYfrZU4lXeOQPYokj7YgT0XhRNmIYB4r/ctqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JDTdFaIV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rWGCxxFoeLTcVseiekGh5/SBzG4ZPNhsNx2ql0KvaGg=; b=JDTdFaIVYd0ZxSXrsegknxWTtE
	vI85sxj5Q2DdNE+DPnmS+rNEoBH/NDMmoiPztMg/L4LHZXl8CbwAK0zXPATQduq9L64MheDRfzo3h
	tsimL0Ai5LUaqc0xZBozF0kTYvcLCJ99QKUuQOvmE8ZX3UwjR8cYpctzOwYjE1zJmUaQ2ukqKM4gp
	IA9TzGEOeWphNU5lfPctQkEkCjvuwgA+tugvWHqb7dmKpbProF/kOyVvlZb8tmRPaFNLP8e++BAPD
	rWHO6Cvvjb9VDwqzAiKE+TTCKd0YHlddlm5+kQz4yNwJY5IDe0BELi0y/eiaUmXEQrwwlqRkcGcX4
	qXbJzNhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1wFZ-00000005E6y-2T4M;
	Fri, 18 Oct 2024 23:19:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 09/17] ufs_inode_getfrag(): remove junk comment
Date: Sat, 19 Oct 2024 00:19:08 +0100
Message-ID: <20241018231916.1245836-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
References: <20241018231428.GC1172273@ZenIV>
 <20241018231916.1245836-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

It used to be a stubbed out beginning of ufs2 support, which had
been implemented differently quite a while ago.  Remove the
commented-out (pseudo-)code.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ufs/inode.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 5331ae7ebf3e..71d28561200f 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -264,11 +264,6 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 	unsigned nfrags = uspi->s_fpb;
 	void *p;
 
-        /* TODO : to be done for write support
-        if ( (flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
-             goto ufs2;
-         */
-
 	p = ufs_get_direct_data_ptr(uspi, ufsi, index);
 	tmp = ufs_data_ptr_to_cpu(sb, p);
 	if (tmp)
@@ -303,21 +298,6 @@ ufs_inode_getfrag(struct inode *inode, unsigned index,
 	mark_inode_dirty(inode);
 out:
 	return tmp + uspi->s_sbbase;
-
-     /* This part : To be implemented ....
-        Required only for writing, not required for READ-ONLY.
-ufs2:
-
-	u2_block = ufs_fragstoblks(fragment);
-	u2_blockoff = ufs_fragnum(fragment);
-	p = ufsi->i_u1.u2_i_data + block;
-	goal = 0;
-
-repeat2:
-	tmp = fs32_to_cpu(sb, *p);
-	lastfrag = ufsi->i_lastfrag;
-
-     */
 }
 
 /**
-- 
2.39.5


