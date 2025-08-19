Return-Path: <linux-fsdevel+bounces-58225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FCBB2B55B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 02:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E959624C40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B50117A31E;
	Tue, 19 Aug 2025 00:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GXpGAPq0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxemWkr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2278528E;
	Tue, 19 Aug 2025 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563787; cv=none; b=g7xdz7H7KpOaQeaoF8RtvH5ZRmDaMGvuz7m6rsBE2K2/wy08y78JoseMZKFhwJ3WE7C5AATZPdC/VaxYlQsXO0687m7IEnJTEI/+QVlvG2ElGh/NRxoRbk1fSL3DQemigyVC2UyZGxl/ECwPRyP+5s9nc2G4C4u5oQ+QlK07Um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563787; c=relaxed/simple;
	bh=Hhl0cr5kzBaXYidgd6X37pGiRJnakpCs7geioZha3z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBBAQiLAt3OgTFMRYcR44cpA3vqWxkRrkXnaWKJYt0fjuZ/yn3R4TgJwZLt7HTIGD3vFqa2vwf4QiBTAZglk+o2zwcQytBn/N0oqfJBKrcIlbd9rs6UAcyxZjrm15oyF2RAL02McPB9QlXnxI8yurIRMm67p+qt5od8EvTZboe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GXpGAPq0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MxemWkr0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A7D91400724;
	Mon, 18 Aug 2025 20:36:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 18 Aug 2025 20:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755563784; x=
	1755650184; bh=OWSqEyIvlgjxYOSQ3qRcRu9FlxJpbiB8lkFmvuQAWa4=; b=G
	XpGAPq0D4ExUO0cV3qi7cWH83b02zq5iwSfVkXmh8akVhBtM2O02WYsWV6+x+Cp7
	5zVeSqR3MYwh+lub18+l1nktquudjSI3PFhMsuOAb8gkiCdQy9r5Sa+QBDZI5bUN
	tfPXZmHdlia77mx3UW440osaCKufflUxm+akPFuVrX7RDB7LxODLp2g+Q3fFGdSy
	BiGLtblwpToNrjAtnAwKe15U+CL9r1G3/hQE/ZcPcHvzoffNIZP1oE+jlxxEodxJ
	orT3KOlMq7GT9/Zs9tTiATdC9b0w3AfHCCNQ9MJyoyz5s2cjNN2t1ncHzG4LI3D6
	djxgsN1NzpFd2VcgO48nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755563784; x=1755650184; bh=O
	WSqEyIvlgjxYOSQ3qRcRu9FlxJpbiB8lkFmvuQAWa4=; b=MxemWkr0UHIaqptZQ
	UfVglu08uM98N8zzw3qizMEwMC31SLvlWg66s5VtABcFIJ3m6FQj5/UIjD//7KIp
	TnQLGI0f7LDG5v4eTnnsynVtaibJ/C3wc6snvUd2+M9VZBIQ7h6RRMIXG3JRjEi0
	WKuVd6PhezsFAx7qZmZLfJfxI0f7CNzm71QaofgWGvS9xDS2B1NEhrF63GncI9i9
	qQ5C0o5qzoHahz/MVZlcGV7FLtTIg3cEz5pmVlWUb3Hx0yI5tbVldEgY7+tdEvxF
	Rg9RDZauUEsG4RDMCxbLJvMIdBxG6vm/77dR1hRmG6p678yR/dEPsg2tZ03RAnFo
	DJqfA==
X-ME-Sender: <xms:B8ejaJ0xtSjf3z0AK94Mu5JPVY7776rceqZrHp2DsFFQHB6Pi2Mwtw>
    <xme:B8ejaFnE_0iIP4FOUXi57sq2ytdbyp5QpVFwdLk-Or4s8UgDHjO6lZwN46BlX6C1m
    F52ZbphtTz4vm4-Lks>
X-ME-Received: <xmr:B8ejaI9hWTqYtVXbzfeef41O0ABDiG0qGVnDgGMTbLMJCbEjDrUex29qAYfznA4etHaTpKTduFKCPTimRwY3ePctFOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegtdejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:B8ejaLIRIuF1sPg3MJDFWBC3GpyqXlc_3Dv4pSuK73mHxnR3Bi2oWg>
    <xmx:CMejaFjz6XWIN-PfpTjsuGYmMOSXOAkzwBG5QS0XaUWsZMFPSEkw9g>
    <xmx:CMejaP_NTYeT8OLFEmJuAq4Q7wIK_UKNrdfAEuAoy2oI9fATd6H7cQ>
    <xmx:CMejaCNvtfHNGHXoFyEZY97ehv53SEbSCpi9OATgh2e0cA5hXAgICg>
    <xmx:CMejaAxew4AYN4mVTSwJ8vJAzMn21ZIZKoys7zR3cwL8D6Kxg4KCX7ef>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Aug 2025 20:36:23 -0400 (EDT)
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
Subject: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Date: Mon, 18 Aug 2025 17:36:53 -0700
Message-ID: <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
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

A very similar proposal to use the root cgroup was previously made by
Qu, where he eventually proposed the idea of setting it per
address_space. This makes good sense for the btrfs use case, as the
uncharged behavior should apply to all use of the address_space, not
select allocations. I.e., if someone adds another filemap_add_folio()
call using btrfs's btree_inode, we would almost certainly want the
uncharged behavior.

Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
Suggested-by: Qu Wenruo <wqu@suse.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: syzbot@syzkaller.appspotmail.com
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c9ba69e02e3e..06dc3fae8124 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -211,6 +211,7 @@ enum mapping_flags {
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
 	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
+	AS_UNCHARGED = 10,	/* Do not charge usage to a cgroup */
 	/* Bits 16-25 are used for FOLIO_ORDER */
 	AS_FOLIO_ORDER_BITS = 5,
 	AS_FOLIO_ORDER_MIN = 16,
diff --git a/mm/filemap.c b/mm/filemap.c
index e4a5a46db89b..5004a2cfa0cc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -960,15 +960,19 @@ int filemap_add_folio(struct address_space *mapping, struct folio *folio,
 {
 	void *shadow = NULL;
 	int ret;
+	bool charge_mem_cgroup = !test_bit(AS_UNCHARGED, &mapping->flags);
 
-	ret = mem_cgroup_charge(folio, NULL, gfp);
-	if (ret)
-		return ret;
+	if (charge_mem_cgroup) {
+		ret = mem_cgroup_charge(folio, NULL, gfp);
+		if (ret)
+			return ret;
+	}
 
 	__folio_set_locked(folio);
 	ret = __filemap_add_folio(mapping, folio, index, gfp, &shadow);
 	if (unlikely(ret)) {
-		mem_cgroup_uncharge(folio);
+		if (charge_mem_cgroup)
+			mem_cgroup_uncharge(folio);
 		__folio_clear_locked(folio);
 	} else {
 		/*
-- 
2.50.1


