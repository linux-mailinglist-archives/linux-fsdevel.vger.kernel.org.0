Return-Path: <linux-fsdevel+bounces-58694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB4B308AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 23:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4431C28524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A422EA75F;
	Thu, 21 Aug 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZliUIqZz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MyQ/SECt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A952EA49E;
	Thu, 21 Aug 2025 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813316; cv=none; b=f7b0HQSM8Lt7Q/dCTvJF2KM1sLA+JijLf3ONVh60CyFdE0oKAMYc4QxXqISe/liY/enuuadvDtnE6K4A2ZOZZv9DSwq8MEj+3pUkOu8outWJ1CyDvv+MfVtGp6GHMS6pIGSECZYf05P4ZyJyD7apsfcP8/XZQvzN5CSAyoDqFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813316; c=relaxed/simple;
	bh=A5UKWU0qdxNX4elEcAdRgAcWHa82UeHBvpyRIO/3xCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Swi+JLQmmonXlC63tZCu7P4HuJfhXpCNuaqMf+pAcPDMB99cKnRI/bHycX071Qkq/SJwse4UjzUW4tOH/L4nMba2POB2pWht5F49woQAp4hOQ1eUQvBowhwTu+JB8uLTwdsUCxn551RNrpXlU6fZNLfynRPlpzxVbE1qnWlbTv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZliUIqZz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MyQ/SECt; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE3157A0119;
	Thu, 21 Aug 2025 17:55:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 Aug 2025 17:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755813313; x=
	1755899713; bh=nqjmOG7AetCjXRm+3fjXeKcj0uJWknxrBI8B7x2fxgY=; b=Z
	liUIqZz6ANVuxcMBevSJ7rGSbuVR8NeCuoYlPCyegwFHmgm3kyQwH08bhhh74a/u
	1E/OyFkduL2OKm8oms3pSwAmfngxhora6yLBNS6gbRSYtEFPKU9ytpLKzUvOIINg
	htwv89LSHXgwMWJ0XLmvXuL9NAZfQi1Q/NLtU1O7Y5C52/iBkblcnAv41ZFX8c+U
	FHgDaIS4G7oHPAvOCgl40SaEl1VugPEqRpQOnrlZzSeNuHaPo1tm+cTyDffO3KTf
	gVBnBs/rjR+xk57H0c4KBmFiTGm2uVwJfnwsvAZG21Xd6K6lc/ICXT2btwA5HulQ
	vmO1Y6aG+zDUFF9vd4Ypg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755813313; x=1755899713; bh=n
	qjmOG7AetCjXRm+3fjXeKcj0uJWknxrBI8B7x2fxgY=; b=MyQ/SECt4H3X6baiB
	2xd7fQp2eTClIWp1ptcXQO/GHsEw0t4K47oeYSfXrSDLv4diOpT9W1jsqW7RRO0B
	WNKFJSOke2goC68FvvRgab3CqTdGuFYz7/z7V4LV1sk0R12N2IUgRTe+3AXRXN8T
	w1JGGECerAePtCFtQzelCSP6Rw067vu3QnH7od/SLsszvQt6fNLOnEoUHWw2wyAU
	OKlSdQHeferfT8vrznXZnkUNjbLHai3sdHO189ukGfEZ9NtHipmGuTimRhO2cpB/
	/j1OMaeTV8zD4mOwa5fcK4W2Z9MmPQDXlX0Bm/Tid1HjQ7y2DNgz1BxOZ2sAOoR2
	3ulTA==
X-ME-Sender: <xms:wZWnaM0qvTgSNrGpqMZBJm_7UW7zhkUzB1Xt1lwtEjcbo9pYgICJ7A>
    <xme:wZWnaMn9hZ7Bo7M78Bssk7Ho3Y9DESaJq9iEJ8zCywNs0CQRgLL0_UR24AsQTmXam
    21K44YFjjdSr7lAYnQ>
X-ME-Received: <xmr:wZWnaD92Wk_0xAhRBtLH6n0-Y76E_or2eEo4bZwR7sD6KhZZO1fJoz0V5u9l1qHZMXo8yrD6QTbrLDGCmj1erQf8qEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:wZWnaKIAbn2E68OZAUwx6keXs5Rr_kJepx0AO6ObYGNPS4Sm-v690w>
    <xmx:wZWnaIhPKqADRjDWWp4pozZa8UsRVGTBYnkYu8vlP53Wnfxkkw_iXg>
    <xmx:wZWnaG8uyPNuWlGt1BlKS_XE7oV1ZZ4pr1wu9s6KOyi4RmIiUZ9ecQ>
    <xmx:wZWnaNMetRvX1GvB9K22w0MTxhUtuu2qhCX642k4DKHNEUSMY2oOFg>
    <xmx:wZWnaDwPub9bf9ZF2lj6heYwwlKWvbm59hn9YYaONVNkH4_tVkmGF48M>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:55:13 -0400 (EDT)
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
Subject: [PATCH v4 2/3] mm: add vmstat for kernel_file pages
Date: Thu, 21 Aug 2025 14:55:36 -0700
Message-ID: <08ff633e3a005ed5f7691bfd9f58a5df8e474339.1755812945.git.boris@bur.io>
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

Kernel file pages are tricky to track because they are indistinguishable
from files whose usage is accounted to the root cgroup.

To maintain good accounting, introduce a vmstat counter tracking kernel
file pages.

Confirmed that these work as expected at a high level by mounting a
btrfs using AS_KERNEL_FILE for metadata pages, and seeing the counter
rise with fs usage then go back to a minimal level after drop_caches and
finally down to 0 after unmounting the fs.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/mmzone.h | 1 +
 mm/filemap.c           | 7 +++++++
 mm/vmstat.c            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fe13ad175fed..f3272ef5131b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -259,6 +259,7 @@ enum node_stat_item {
 	NR_HUGETLB,
 #endif
 	NR_BALLOON_PAGES,
+	NR_KERNEL_FILE_PAGES,
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 05c1384bd611..344ab106c21c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -190,6 +190,9 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 		__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
+	if (test_bit(AS_KERNEL_FILE, &folio->mapping->flags))
+		mod_node_page_state(folio_pgdat(folio),
+				    NR_KERNEL_FILE_PAGES, -nr);
 
 	/*
 	 * At this point folio must be either written or cleaned by
@@ -989,6 +992,10 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		if (!(gfp & __GFP_WRITE) && shadow)
 			workingset_refault(folio, shadow);
 		folio_add_lru(folio);
+		if (kernel_file)
+			mod_node_page_state(folio_pgdat(folio),
+					    NR_KERNEL_FILE_PAGES,
+					    folio_nr_pages(folio));
 	}
 	return ret;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index e74f0b2a1021..e522decf6a72 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1290,6 +1290,7 @@ const char * const vmstat_text[] = {
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
 	[I(NR_BALLOON_PAGES)]			= "nr_balloon_pages",
+	[I(NR_KERNEL_FILE_PAGES)]		= "nr_kernel_file_pages",
 #undef I
 
 	/* system-wide enum vm_stat_item counters */
-- 
2.50.1


