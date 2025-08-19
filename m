Return-Path: <linux-fsdevel+bounces-58226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350CB2B55E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15A81968477
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4518FC92;
	Tue, 19 Aug 2025 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="d4Nt403U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m8tmXP1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B715D5B6;
	Tue, 19 Aug 2025 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563788; cv=none; b=BPIxlPpAdBayQ1yNvbkzREJj6JsMM8o1YMlarCBLXN7rZb6faEpLBBBSIMxHAVLA5ZTQVQSY7Q5FE7GOy5XoDcrdqEGC9Rud2XSy+S896/wsgN1LJjfEI+2WsoXcdkllAbRvpkaCVruUW4ooGpaE0SITak7Ah7xGmdMuiH3ylxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563788; c=relaxed/simple;
	bh=TN0829sJDvByvPXeG0AiaFFcnJJZkUsTJiUqGM0rghE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY1Ke/lHkB7JFOlVrHhnaCxSv/4c42Ai20fgJwO8g37Ba4FYHB57mti1GqWuiUEcfkbF7iC+MB6e26cROVy1eBzXmO6eTImmYqJWJd4BUCHZyXiAYHYj2uF2JyKff6/DCs7JmS075WYYxyjHBfBM2/5OH+iuMTRx/Wvda1CdKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=d4Nt403U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m8tmXP1C; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 09B30EC0854;
	Mon, 18 Aug 2025 20:36:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 18 Aug 2025 20:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755563786; x=
	1755650186; bh=GPjinPryqKE8wodzlS0UT5WmvwkmRSTuvMPtWRHQfsk=; b=d
	4Nt403Um8onGOK5nba99lUX4pCVianZMMsm2p3xrGwXe1jVwMwD7UkUeWYjWMc52
	uNSgdy8wEIjoJNaEgvDnHOTkNJfsEEEsxqZ4wXIntQtlVeWn28wiud04/Q9axs5Z
	G7Ma3lP9CHE6GLPE9sGKUYe6+cBQ5NZbW93UKoIdOQ1WYb7/gHeMAPGFUAZgi1CX
	jpAxgko7hh1ymCQYIb1vooivsRqvUE22xyeUvrCWvXEoUgXbPVEuTSEWwbsCBrBG
	MJXUyMimcc7JAnT7YPHC3GLr4LDZaQKpUIoTYh5h9uDSP7WhNHDJwoA4jnarZw9l
	UaawLknvaJqb1MfpMpBKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755563786; x=1755650186; bh=G
	PjinPryqKE8wodzlS0UT5WmvwkmRSTuvMPtWRHQfsk=; b=m8tmXP1CfMgFj5UuG
	0SJljaKebIRye8Ts8eyYMEr0kclKqkLxCuPld565DH/Ta0wHmVVSYlhAx8Dl6rmZ
	Lg1eXy7WgDWb3vtFCQzLDP/HZKw6wcN3gIrNLmqh0Qf04RcClEAuPhuJBr32J7Fe
	742GiDuAXWIsLpVzGbIlmM544/USBoG3mN0bQg+XWaiDpz62iHC7i+ayMe+m7SvH
	nXb1PjyDDMuelYd6VzXkqNpw/PoeqAUNtsNu+fepP7BfYZXdHQfCjgcqWinlyAML
	Z+viHHRNylKVyPQIMZepWo7OJdurGkP64TMLUlfGPjOeE3xdGgfNFOJ3JXAZ5p1d
	Gp7jQ==
X-ME-Sender: <xms:CcejaDT5s4XZvaF7XhlmgkDqP9LXx2b3EoCNZBY4FOUSZU2aBFzVKg>
    <xme:CcejaKRpALqVGue8uunsTQVPvJtumzzcs0tKEGDLI1rvnM5PhEToGgRAgxPm9Ce8k
    qjew-HQgcyjn0sULKE>
X-ME-Received: <xmr:CcejaH4kRVf4DDxqA4aSi04-ZNe-VHFx6xO9Pn9Kc-7KN-il41E_Q84KBr34aX39Se1hRyKPQIUB_QQP68Yl9IKXuSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegtdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CcejaHXL-vgrAnbvQvdVKhdPjjaQNGN6OmCDsGg636Idr-jjJ7cuuw>
    <xmx:CcejaF892q2OWHq4GPQl0BhGk-4L97wQ_cH5xC5HmjK4m8EM-vTUCw>
    <xmx:CcejaPqck4v-mwolxwGl0lTkHLnbDEfXTzKSd8XG8WiHnCIdkk-8cg>
    <xmx:CcejaAISyPSg_VXXjMh5HacqgKMwzz7xCePi1UhbNLj7aTJnDwkGww>
    <xmx:CsejaCObtE0SKkeAiP-V413izPbFNaw_RNRmpf5gkr7e0SMv2zIq81f3>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 20:36:25 -0400 (EDT)
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
Subject: [PATCH v3 2/4] mm: add vmstat for cgroup uncharged pages
Date: Mon, 18 Aug 2025 17:36:54 -0700
Message-ID: <04b3a5c9944d79072d752c85dac1294ca9bee183.1755562487.git.boris@bur.io>
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

Uncharged pages are tricky to track by their essential "uncharged"
nature. To maintain good accounting, introduce a vmstat counter tracking
all uncharged pages. Since this is only meaningful when cgroups are
configured, only expose the counter when CONFIG_MEMCG is set.

Confirmed that these work as expected at a high level by mounting a
btrfs using AS_UNCHARGED for metadata pages, and seeing the counter rise
with fs usage then go back to a minimal level after drop_caches and
finally down to 0 after unmounting the fs.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/mmzone.h |  3 +++
 mm/filemap.c           | 17 +++++++++++++++++
 mm/vmstat.c            |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fe13ad175fed..8166dadb6a33 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -259,6 +259,9 @@ enum node_stat_item {
 	NR_HUGETLB,
 #endif
 	NR_BALLOON_PAGES,
+#ifdef CONFIG_MEMCG
+	NR_UNCHARGED_FILE_PAGES,
+#endif
 	NR_VM_NODE_STAT_ITEMS
 };
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 5004a2cfa0cc..514ccf7c8aa3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -146,6 +146,19 @@ static void page_cache_delete(struct address_space *mapping,
 	mapping->nrpages -= nr;
 }
 
+#ifdef CONFIG_MEMCG
+static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
+{
+	long nr = folio_nr_pages(folio) * sign;
+
+	mod_node_page_state(folio_pgdat(folio), NR_UNCHARGED_FILE_PAGES, nr);
+}
+#else
+static void filemap_mod_uncharged_vmstat(struct folio *folio, int sign)
+{
+}
+#endif
+
 static void filemap_unaccount_folio(struct address_space *mapping,
 		struct folio *folio)
 {
@@ -190,6 +203,8 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 		__lruvec_stat_mod_folio(folio, NR_FILE_THPS, -nr);
 		filemap_nr_thps_dec(mapping);
 	}
+	if (test_bit(AS_UNCHARGED, &folio->mapping->flags))
+		filemap_mod_uncharged_vmstat(folio, -1);
 
 	/*
 	 * At this point folio must be either written or cleaned by
@@ -987,6 +1002,8 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 		if (!(gfp & __GFP_WRITE) && shadow)
 			workingset_refault(folio, shadow);
 		folio_add_lru(folio);
+		if (!charge_mem_cgroup)
+			filemap_mod_uncharged_vmstat(folio, 1);
 	}
 	return ret;
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index e74f0b2a1021..135f7bab4de6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1290,6 +1290,9 @@ const char * const vmstat_text[] = {
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
 	[I(NR_BALLOON_PAGES)]			= "nr_balloon_pages",
+#ifdef CONFIG_MEMCG
+	[I(NR_UNCHARGED_FILE_PAGES)]		= "nr_uncharged_file_pages",
+#endif
 #undef I
 
 	/* system-wide enum vm_stat_item counters */
-- 
2.50.1


