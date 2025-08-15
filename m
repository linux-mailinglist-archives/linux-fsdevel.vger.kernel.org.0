Return-Path: <linux-fsdevel+bounces-58062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233ECB288E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 01:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692D2B6663F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 23:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D62D5439;
	Fri, 15 Aug 2025 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tp/EqI5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Anh4ktML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F54926E6FF;
	Fri, 15 Aug 2025 23:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301198; cv=none; b=q8aqTDouXVDjQfXYjJ7AsvN2a3QLgKuPjY+5bRqZ/eKiT5GhyST+4brfMwPlL8AJRV6AS0Tsbo+siPwajYLLlqjarxhfygrQEXhGZ4PnFXww2LWY7mkt3ASc2zkGhnziQVXefN58oB5N7ddod240skrS9cRPVrtaVZJB1Rh0CT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301198; c=relaxed/simple;
	bh=bUnGZhoTuWQYa9OlSuxO67+wIetuBM4icl7K4K7BBls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHGj+1F0r3/xLzK0iydQ8C1vl2dj7mTNewBqSOu5/XVm1f/tCopL/BAhjWAf4Os+ve2i5jUL9hUsp0j6ZrYO3saLnpiBly0qkLtIY0vRsHtmy4mJFO2rwfioHA6yzjyJXlODyESjO5rOHdJ/S3wNecVnXA4Wd/rYBf4yg5wDoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=tp/EqI5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Anh4ktML; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 12335EC0105;
	Fri, 15 Aug 2025 19:39:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 15 Aug 2025 19:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1755301195; x=
	1755387595; bh=UmTC3EDeGw6G18ZhnPvPy7FSHrY+VoBy9Wew8lrgMlY=; b=t
	p/EqI5j+3HFY949isxvTPgP21vEaMoJFxcbis/AZu7FRjgKS0RLaT3sf96RC4efA
	lg8pQomdYVV0YRX7JEMC9LbYxi7tGBpFcNvUkpG41wV69tg7+szYmNowE245qv0X
	ANcu4aW0wtuNismWBIK+NPeRO7gwUWZO/VzaMFpsGnlpQ2H9xMmKVq/JwUzG8Syq
	tWS/c9LLqrbKUuTp8C6twncwbZLFUhskxM7P2Q9C3OS+G6GkbJTS4FYwSdBr/fdF
	hS48+srXbaI+ogK/S5axO6grkAilPw5MMuaDBMDE0RB4evwm0Tw7KK2vOFjgBmHR
	9uBz916/68o3hAJDWVsRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755301195; x=1755387595; bh=U
	mTC3EDeGw6G18ZhnPvPy7FSHrY+VoBy9Wew8lrgMlY=; b=Anh4ktMLc6k5v1sxr
	48SH1hyeFHL0qxMUA6XJQBhj6Css7ZfMfboylKSQ34rgmrB2giJqxBHMix7tFUk4
	LzyfAJAmFA0+Bxlk/LujAtezMWS7cSai6NJN3b44H8m2YdcR2PTtAfH/4I0G/1+t
	4YBbm9RyBAceJua7DY8sJXwCyKcYg5BJDsrY4uRajNmHvucFH0mEBfhFqk/6wtTb
	vcsjnAVzo1sW1UBHhqRWD/xzfTSG7qSj+M4w+2ViYNgOaBZxVnSmu6di2VX74peu
	rgGAIWtjm9ljqQ38PQKVvSnwXJ+N8br7rGle7ZklF3yFAXTYpWx4SMnE/HkZtQT9
	gD3uw==
X-ME-Sender: <xms:SsWfaPFB4CtNrpC5kjJ3PlnTErfVlTjsK7FLyurww62hBJipx34e4g>
    <xme:SsWfaAJumzm_n2NFj95tAaxqD8oWQIs6NS02g3woLsTiwgbJ_DPRryDDET7uDfqB3
    nLpCHzP9of8RpLK8fI>
X-ME-Received: <xmr:SsWfaKMCKaSjBDvurjzUjnEunLG8DOLNrV50e8mTzFxxPCTZkPPOQj_pyZlisaXpzJBoN2PiKRCv8OhbY264mMdopuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephfevke
    ffkeffheeffffhuefggffhhedugfetudetudetueefveeijeefvdduudegnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghp
    thhtohepshhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohepfi
    hquhesshhushgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdr
    ohhrgh
X-ME-Proxy: <xmx:SsWfaAnt8vn_5MXPNF_CJ0qFa6AlrhudmAMKCoYuASVL3pVGglMEQA>
    <xmx:SsWfaO79GY718zGpGe83y_jagxFJkExzLVEMY1t1L2x9s3Ck6XhBsw>
    <xmx:SsWfaE2wKeolHsN9YDG16YkATzWoApeBZ8bRk6RQFaU1P6fcIoVcbw>
    <xmx:SsWfaJFcCurQpoq8-SQjG6Bcs9gLWXg2HGjW1Ucw8nTNj30f1NCSgg>
    <xmx:S8WfaNHolf58oLio2ooRBuNQKMgFfRJzvckAVWFmFgkWhp-7sVIh9_ix>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 19:39:54 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	wqu@suse.com,
	willy@infradead.org
Subject: [PATCH v2 1/3] mm/filemap: add AS_UNCHARGED
Date: Fri, 15 Aug 2025 16:40:31 -0700
Message-ID: <38448707b0dfb7fabae28cbebba3481eec6f2f4e.1755300815.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755300815.git.boris@bur.io>
References: <cover.1755300815.git.boris@bur.io>
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
Signed-off-by: Boris Burkov <boris@bur.io>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..1ca63761a13a 100644
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
index 751838ef05e5..6046e7f27709 100644
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


