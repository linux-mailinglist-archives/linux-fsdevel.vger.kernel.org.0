Return-Path: <linux-fsdevel+bounces-58693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B559B308AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B0C1C28252
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AB2EA735;
	Thu, 21 Aug 2025 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="o15FyfC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZcoMawA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A742E92D0;
	Thu, 21 Aug 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813314; cv=none; b=A8nXDgKgu6mEXdu5qfl87lzaaU3pB1+qCGjQCXY5//PvfZpXVaH23rO8S8QhXvsNKMb4wuSt/b5UCIuTkxfj2Q2osXYbx5wbcI2Xa7sMrU6y4U0SnUWaX/lQDj9/bVArlUPhD8KKS+EzmixE08EYJSSnWDhUSSllcIB386sDqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813314; c=relaxed/simple;
	bh=GQQZ4/LHZA4wwIm+2DVqeFKvb38DA3XroHGNOKvmQ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVSTmswMGgI/l0lZF0JIKsDKT9bCe2lco0QUiy/U44h32IZl6phP6kgD3GLuaXopy7xrb0uwaXE0VIdssjv16+KmG30az22la7F/Ut/hNjMYXcFaZxirWXxuT9kr7DKjHZcSl6z01OQQaKP+3YUAz3UzSygZCwf13ElVT/8z+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=o15FyfC+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZcoMawA; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F7AE7A013E;
	Thu, 21 Aug 2025 17:55:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 17:55:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755813311; x=
	1755899711; bh=KTjJpIvPC3sSZ8qeQ6s9N5Jc2/0IphFglsc/jRyQy4k=; b=o
	15FyfC+Zds+sXQkGP85yff98CZCNS05vSrD7tg78D8+LPswpNTSfvCOtwaaGl3Eu
	q62CMRF7VGjY9rUw9IaXKIiOKBjUhmxcrQKk22Mcix+lPf64/k5DgEr6WiAY96Aq
	J7uIXFUTxteL8E4AFxecjEnARoYLtIr1yZ5SjtB6M50nUxDIRKR4IrTzK6k3Bp1m
	FJij1tI5QVNgI9DXUiDtwbd//GSCIUruJylUtOa/dPfbsvsOHyESqIzENXXSKB9A
	lJD6FklzUN372LC469iMrM09DRLvlPFKfStmt78DARJE9SJ2lRXHW9q5bVqxC9qz
	ZeDW3wRsHN60OrR0N50kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755813311; x=1755899711; bh=K
	TjJpIvPC3sSZ8qeQ6s9N5Jc2/0IphFglsc/jRyQy4k=; b=FZcoMawA/ebPtt9X8
	amYjTE5rrnagLUkcr9vdFqG3uanNnGsAkaWO22oynxPRexKTsjgQyLz9Yvso3aVy
	WEs6EGonhJctObBS384o0+n97+qiq70jyLkgB7GgtLuZZ9v1WfUWD8TG6/3r7l91
	6iiiLenRNa4ZoN0ANapRN1448n/A9KfYIgKrq58agw/EwgzOcgQyRH9pB9EkrM3w
	tkqIxXCcXB7ZFfI9Gfih2BDdOEA1Kh0gBxGVKhvNC9reMSMr+UodkWv+ITq39FbR
	/+NVlskBSJCvoVJmH3tSSlzgEvZl9S7ujjOJgwBnzNlHyHxXX0zKxyJl9V03NqMk
	BO7TA==
X-ME-Sender: <xms:vpWnaG09pjrcjRvv1n_XQuN6M-uBletMQu1_Dd21mq1cg_Ugek-3zQ>
    <xme:vpWnaOmr_sBi6wNiL0DfapYL8ZW8uKsz_G0xcW_7ixmtfeHr1LjKbC4vcaX10IBli
    BYeroR_6aGHZsrie2g>
X-ME-Received: <xmr:vpWnaN9Zra7jauUSe61g6WfIk8fmD0PfIcb8j4Mgf4vQN3h59h6TNOh7iW997Z6KjqXurQXFIk4mR5_D5kf_DmUUMaY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephfevkeffkeffheeffffhuefggffhhedugfetudetud
    etueefveeijeefvdduudegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghl
    qdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtohepshhhrghkvggvlhdrsghuthhtsehlih
    hnuhigrdguvghvpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtohep
    fihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmhhhotghkoheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vpWnaMKruiPdU6x_UleUEPSEWzdCDBTdOiBhhagNwhADnjcb-lxccA>
    <xmx:vpWnaCjsDdJvZefGmRGi5H_THVIpUQ5X_typei7ANTDfm1at4OddRw>
    <xmx:vpWnaI-e6dN1aX_LIRCXFZHs4l0bubMB5xORYLQEC_lBc600ga4ZQw>
    <xmx:vpWnaHOcLrIl8gHMLNvjzvn4cIilb-Ih3IIjO5IbM8iFVYGkwdIFcQ>
    <xmx:v5WnaNwxx5FGZYMeitHe83t-5KuMs6-IFqArjWql4NPpOHISiQhE50FW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:55:10 -0400 (EDT)
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
Subject: [PATCH v4 1/3] mm/filemap: add AS_KERNEL_FILE
Date: Thu, 21 Aug 2025 14:55:35 -0700
Message-ID: <f09c4e2c90351d4cb30a1969f7a863b9238bd291.1755812945.git.boris@bur.io>
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

Btrfs currently tracks its metadata pages in the page cache, using a
fake inode (fs_info->btree_inode) with offsets corresponding to where
the metadata is stored in the filesystem's full logical address space.

A consequence of this is that when btrfs uses filemap_add_folio(), this
usage is charged to the cgroup of whichever task happens to be running
at the time. These folios don't belong to any particular user cgroup, so
I don't think it makes much sense for them to be charged in that way.
Some negative consequences as a result:
- A task can be holding some important btrfs locks, then need to lookup
  some metadata and go into reclaim, extending the duration it holds
  that lock for, and unfairly pushing its own reclaim pain onto other
  cgroups.
- If that cgroup goes into reclaim, it might reclaim these folios a
  different non-reclaiming cgroup might need soon. This is naturally
  offset by LRU reclaim, but still.

We have two options for how to manage such file pages:
1. charge them to the root cgroup.
2. don't charge them to any cgroup at all.

2. breaks the invariant that every mapped page has a cgroup. This is
workable, but unnecessarily risky. Therefore, go with 1.

A very similar proposal to use the root cgroup was previously made by
Qu, where he eventually proposed the idea of setting it per
address_space. This makes good sense for the btrfs use case, as the
behavior should apply to all use of the address_space, not select
allocations. I.e., if someone adds another filemap_add_folio() call
using btrfs's btree_inode, we would almost certainly want to account
that to the root cgroup as well.

Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
Suggested-by: Qu Wenruo <wqu@suse.com>
Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c9ba69e02e3e..a3e16d74792f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -211,6 +211,8 @@ enum mapping_flags {
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
+	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
+				   account usage to user cgroups */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
diff --git a/mm/filemap.c b/mm/filemap.c
index e4a5a46db89b..05c1384bd611 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -960,8 +960,14 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 {
 	void *shadow = NULL;
 	int ret;
+	struct mem_cgroup *tmp;
+	bool kernel_file = test_bit(AS_KERNEL_FILE, &mapping->flags);
 
+	if (kernel_file)
+		tmp = set_active_memcg(root_mem_cgroup);
 	ret = mem_cgroup_charge(folio, NULL, gfp);
+	if (kernel_file)
+		set_active_memcg(tmp);
 	if (ret)
 		return ret;
 
-- 
2.50.1


