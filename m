Return-Path: <linux-fsdevel+bounces-58227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7DB2B560
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347DC1968539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D0D19C540;
	Tue, 19 Aug 2025 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MfiOEYh7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itIohdwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9018A921;
	Tue, 19 Aug 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563790; cv=none; b=KRQkTJHILSBg4QECjlmKXhHzTWo9UtPlTTYHvsfc+HJQapAjPg+vHXOPxSrv5iJnqN40G7kuJUL+NMLRunwks2y08MhLJp2CFymCc90WGpWxhGCZ8R2iFSy4m2Mzyb/NMSYBt9XCbrd45j6gmQRb3srmHFOIsTiWMIb+yEwhxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563790; c=relaxed/simple;
	bh=Fx/kVm2tUmkdzfKXSxTbYB/Gimwd0cll78ctOYnB9oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip9H/eDtbnrP33zB1ui0CsteMc20cQgTwFxWUMPSytCOauEBApjUERqS2h8MbbTFu4bqlpaxUMyUwToZoZ236wyUGeckv5UojYedMk6fGMScceiRAm6pSDcfM9Lft/pY0YPCkjG0SaXKR5AWgl+Ns46TgGjHPGi0DnZP8tE9fpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MfiOEYh7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itIohdwI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8B6B1400721;
	Mon, 18 Aug 2025 20:36:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 18 Aug 2025 20:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755563787; x=
	1755650187; bh=O4caYZdtkvA1feHd6+f88NqFxyHygxvgA0Mg2AX6ppA=; b=M
	fiOEYh7K0UFAcWaolcZG+Ywr4V0M7ZjmJlJRl2YwTA53RJbfchbriUlhbRFvik/u
	d/t7TPSkCHCJgkRtnr5MvZY0CL3tiMrP2fOGkC15YXLw+DzYbBzuu/B0KoRf5C1i
	XEbhZbHSK8ZZI63hjiwYlACDIqnefW9vHWdLcfWPkV+4L+XAQEmW8gL3UEXNjHrM
	CmVLlpUK/SgDg6h1myEv87ZTZFtSApjcl67Sq/kl/REHGWntF5Trbtu8B6fpsGoz
	NqYh98iZm/WLbNFfmkLQjTEKmYUSC1HGtBAcGsig5CuMl3fZuB/1u3qkZdQAf0wx
	p1MWoV++ehrmDzP/UnbXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755563787; x=1755650187; bh=O
	4caYZdtkvA1feHd6+f88NqFxyHygxvgA0Mg2AX6ppA=; b=itIohdwINivHPQs0b
	S4veB1ym/yBiCJT3Te7pYh1ookGnQHNrlh4wviZe0gOn9F/fpRhku+c8pUxFxNc2
	HA4qRY5/oeC7MyR8d0paISMdGdnfoBN7DvHGcYx8zg471bqZ0xQr21/eCCMw12Z2
	NxOgeOjAj6Ch/oL/mfpInk2VRLdJASKtv72UrPM1qHELYDC+ak9hzoxwpCUSvBW+
	v5U3RryC9R0c8o9IdsR9Hk34zFPh06JYsx2pWkuN6HSs6a5r1a9H677rkb4Q1TAA
	+1TG8N3MyJwOz6DgIKhc0530tQcOl4w1P5Ny/1vTpMmcTMzWSimg1RCb6qL2AfvF
	LnyOw==
X-ME-Sender: <xms:C8ejaC2CsjFhVr2Sqgw1N2dGLM89YH1i_AwILuBs1asgCyK2v6RBLw>
    <xme:C8ejaKlx_Ne-VtgRf5tq_g0O0o_dA1HoGe7mu7oUpn8e9q503POwmSC6MYEhaIlrq
    O3v4lhBKPyCl74TayA>
X-ME-Received: <xmr:C8ejaJ8MZUVMaWQcr0dSgNQWbwZLcXDg19JK3mqN0zBtg3TbQPqfkKqgb-BhVsvaJreUxQpgl72DT8ZzQ9UqeecTOUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:C8ejaIJHiqOL4IWKQYHQmukvJfisvuJTVaVbp3T1e8sF71otkoOSKg>
    <xmx:C8ejaOi8YdgbG8OASKxjLd2ggk_hkrLmQL8EJADC-gHpeztN_MHwkw>
    <xmx:C8ejaE8AJsRWbxGFXWYgCnChUePr3ZOP1Muvf26m2D7J8fjpUhtS4A>
    <xmx:C8ejaDO7ttioRecgQEa63Qf-LEZsLBqVY7jEh3cvRbUvlBSLjEssKA>
    <xmx:C8ejaJxW-ji42xP2a4dcqp30Zi1ihoZfa7VZ8cNp2UVGlAT03eDbKQ89>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 20:36:27 -0400 (EDT)
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
Subject: [PATCH v3 3/4] btrfs: set AS_UNCHARGED on the btree_inode
Date: Mon, 18 Aug 2025 17:36:55 -0700
Message-ID: <cbeb05a98ceac523bce55a0eb12e6d6ad4c98d12.1755562487.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755562487.git.boris@bur.io>
References: <cover.1755562487.git.boris@bur.io>
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

Acked-by: David Sterba <dsterba@suse.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70fc4e7cc5a0..24ac4006dfe2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1930,6 +1930,7 @@ static int btrfs_init_btree_inode(struct super_block *sb)
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	__insert_inode_hash(inode, hash);
+	set_bit(AS_UNCHARGED, &inode->i_mapping->flags);
 	fs_info->btree_inode = inode;
 
 	return 0;
-- 
2.50.1


