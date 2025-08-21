Return-Path: <linux-fsdevel+bounces-58695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80DEB308AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EE15A71B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58E62EAB97;
	Thu, 21 Aug 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kespNPe3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LXqRumNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CA62EAB6D;
	Thu, 21 Aug 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813319; cv=none; b=XAsco3bJH0YF8nsG1e8TcJY7jMx9J6U6jaJ8LAjlFZiWg/HPagLI+S2VzR0YZEBSQOptG4D1jSF+CAFejMEdiCB8fNOVReyqueLzeJRQFkHTQs1h61QfByv7zyZUgaB+sDH9Z2ucfJC8Afbw8TcKqZ07mUZNFyd5VqrQzNmQcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813319; c=relaxed/simple;
	bh=NxA4sp3tQYv9PA6qiE7eM8cVlqHOtjGXYDB6fEDR0jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQt8jB4+iECnZ5jBGJtXr52yJDynHEg2pyFntf+72vqJQzMgQVZfZNaf9eGcLig6jFQQ3SFAUpeJXPRevlDLdtcwlA3TBiz7U+WDVO5BLCJ1c/ROuDgNmvYeHRmL6aluZJoQbl3530xkcV3vx36/KS2gYARYbQgGZv1Wh8OyQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kespNPe3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LXqRumNz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C6B41D001B1;
	Thu, 21 Aug 2025 17:55:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 Aug 2025 17:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755813316; x=
	1755899716; bh=+Y/NEyt7ymKiMS/llOk2P8t/dM0OZDpztKj3DY9zQ/I=; b=k
	espNPe33CZp4MkiZnmymRTInr4O6gVX21JVIX1LVEVkUhxfFhoYJvp+U8leobhuy
	R6E09ZhM1ZjyTOusns3MH1OSHwyP8VTPim1WYX8v1axHRpyI08XFB/tGGF+lOsQv
	Sft5VVU66aTU6yln9IFyVYbcqp8RREEnPRLYY/w6qohIW3U43udueydOIl3j76l8
	C85cKMmcl4nG2v0uq57h5E15aVJxjx25nkHpI1oT9nAPeUJI2vp5x2NAsCuGsn10
	jnIlkix+ctQxFV4rritS08Qn6vWV38F2qYorWGR0QJOcWfdGuY7y9ImkZqgprSYD
	vbaFVQUIE+BO86z3Isaqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755813316; x=1755899716; bh=+
	Y/NEyt7ymKiMS/llOk2P8t/dM0OZDpztKj3DY9zQ/I=; b=LXqRumNzkuckFJRPU
	qzJzpfdM3cJvj/6k1ZvGr8VujS1ssmvl0/lqX3wXPAKFpwgq+uux87v9gAQC112C
	13o6qTbGWrOH/CHenhofd5rtvJ9m+PmAEtX2rVOGMxNlW9R9Lin7tGh9jdlxLCGy
	5zeH00caQdwQQbCr0lZWZxnt5fG2+ub5upJHT655RNjEVc1SZLZMdAIr6Foj5jGq
	RSm7j1PaqzrbK4uTLmPeRs+lsSo7Tt7lR+RyaWuStO7iQcaqpDbPtRYNDsh6b7xv
	9ceiGJbBBy0YLcWUsG3UINEr5m0JjHpnwHYy26wNnfnOZxDTSYCPZaPz8XvCk8XM
	Ghbqw==
X-ME-Sender: <xms:w5WnaIOrFOU2YEFkx1D2A_4I5uHbHGUeZ4TGoQFg-9Iq6l3AMe3i_g>
    <xme:w5WnaEdPMxnFe_OpZ9pIZAu-lF6rjj2KH7b_rGulYkNuaBKDnr4AaWa-BL32X5Okm
    V1uZG84YwIOsmuov_k>
X-ME-Received: <xmr:w5WnaOVchaYxyB6SOx34RF8E9yaTODM3UwCHPwnXzdv9_5zch_vLxxoBloJNfgHJGRszNFcqOtqhppw-r2e9LZrgt-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepgeduteffveeileetueejheevveeugfdttddvgfeije
    fhjeetjeduffehkeelkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeduvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgu
    rghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphhtthho
    pehshhgrkhgvvghlrdgsuhhttheslhhinhhugidruggvvhdprhgtphhtthhopeifqhhuse
    hsuhhsvgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepmhhhohgtkhhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w5WnaFBZ87pqek2e3ZxXTRUAJDqKID1CS-K8Bc56OJ0YJm-xhOq37w>
    <xmx:w5WnaJ5lBUTYVO2YthjeG7VrYUHlmRUog3LkfSQt6SjS98znEkcakw>
    <xmx:w5WnaM1ZMP7_c16eUIAJgJFNMu_L0d2prMs_BP7QiBZniUl-SLaIkA>
    <xmx:w5WnaNkJrp9i4GxudzhYN7rhxrbaAVwFAOMHzpG3GMV2t7RkxO9tVg>
    <xmx:xJWnaPJuxooOsIZzeuAG1Ob2seij3jbCgPxyx0XS6M0Hdjso4YcSM1Px>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:55:15 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: akpm@linux-foundation.org
Cc: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com,
	shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	hannes@cmpxchg.org
Subject: [PATCH v4 3/3] btrfs: set AS_KERNEL_FILE on the btree_inode
Date: Thu, 21 Aug 2025 14:55:37 -0700
Message-ID: <2ee99832619a3fdfe80bf4dc9760278662d2d746.1755812945.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755812945.git.boris@bur.io>
References: <cover.1755812945.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extent_buffers are global and shared so their pages should not belong to
any particular cgroup (currently whichever cgroups happens to allocate
the extent_buffer).

Btrfs tree operations should not arbitrarily block on cgroup reclaim or
have the shared extent_buffer pages on a cgroup's reclaim lists.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70fc4e7cc5a0..7fab5057cf8e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1930,6 +1930,7 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	__insert_inode_hash(inode, hash);
+	set_bit(AS_KERNEL_FILE, &inode->i_mapping->flags);
 	fs_info->btree_inode = inode;
 
 	return 0;
-- 
2.50.1


