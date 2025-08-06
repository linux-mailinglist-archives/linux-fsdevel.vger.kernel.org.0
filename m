Return-Path: <linux-fsdevel+bounces-56798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBF9B1BDBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 02:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4EE18A5489
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 00:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D3610D;
	Wed,  6 Aug 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="b2VGQyJ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbuodmXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC14DF58;
	Wed,  6 Aug 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439055; cv=none; b=gvvxKgOAIpVpbkdvz3Y5fCmte7XAp6A6zBt9oEFbuFjBKzL8gzIirjPt9UDuHRuOjflwblv+jX436kwzV1HCtcrUGxi52ktL+4bNz+cU/cJ7ciJetYWB0T3W3dkiMB+KUZXwciLTH9u/wCDCBQhO8FXXpN5PmLI93mraLpwvtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439055; c=relaxed/simple;
	bh=iCBtnbFBd4/MKXgAKP70JePuMqMQHD2DxiUuw8V52q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5EaGV0P2o4albb3uKgKDnT0dz7ykkdrOyLRbuIPpBPy/PHzJ0RGsdyrcPcaCCYvJQNeNoIILG3uafk7qIzqWXXkZ7agtzdGMpx3/MsTj27otS03k8H25LXNA9213cabeW76zRiknj7ryd+Vsq0earrx8TaYKGKJHsMRwjinSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=b2VGQyJ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbuodmXH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C31E7A025F;
	Tue,  5 Aug 2025 20:10:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 05 Aug 2025 20:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1754439051; x=1754525451; bh=qNeHkb7L1un5p2eTx7uId
	xYIPGuHDlQVkoD4AYWoiJ0=; b=b2VGQyJ/0bf0SX9w19YPsGuxCZ+3+W0+Q/mWw
	1sFWJJuLiPBbPaG0GXRnwrwky0IoK9AGiyxOyuQMCCk4oqPSik5sk9HiNUkNjuJh
	ZlTW+dLHsxQbngeKWQMneLvE0uYlTEnv5idU1dKne7UW2girqgoaM/LPKaJyQ7rf
	8wlgpw6dsdEBVGvBJs3bvZRB1+hq9iITsp7uWE6HsNEGtMf3igWxxL87kREtPWNz
	4OTXgmYdB7JnLquK6MQ+dFDcqQ+wyNomrE2swadGqeozhS3OADvH0RYedORIiyir
	eZgX510VaLcnwtFYDpVeDIf58NH+J+oPNW3ByYpHvl1eV4gvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754439051; x=1754525451; bh=qNeHkb7L1un5p2eTx7uIdxYIPGuHDlQVkoD
	4AYWoiJ0=; b=AbuodmXHTESCuBGgcAe0jaivKpessMpvmMA7tr42LjmiCkQXA3K
	Pc0/r/MmWi6KolnmBDYf1P/XnULiUPUzPuCcyEqxS/4Vzp2JgVEYXMD8jWFU2a/0
	mPAJVEKM5oa802fINCPJ7qUSF+VeqEysYsgCNQZF3NmXUI5AmLXXowRLHK9X0Qc3
	BX/KPIu4nRk5e2LptfEerZ7SY07dPj0PxQbaaTzWF9zlJ4Num5qeHw5ngueD4xNb
	2paju4g8cGHWjTlDfW4kTj9hW6h4elNT/rTpyszZtm4hVecHt3OrtKxIY8Pfp6VP
	m674UmkXfCAgsogZYafTOTIUM/1Zn1F67hA==
X-ME-Sender: <xms:i52SaA0sqWuvQbAftwx1_hVGKq6EVkgelkil3Q1qFLdSlhO9GBj_kw>
    <xme:i52SaO5DTP5V7o8vBxBgJPX559FjReufAUwSd6KeU-UkXbOJn1vDoZXu-D9fBbHQv
    c4k1KNKBVhUV4ysHik>
X-ME-Received: <xmr:i52SaB8gNiEq997kXBLKklCeBgYleu5UtWJ7X3bfkKx0kF-oQaFofKd4OEUnJRpjpst51TyyGYFOH4GBBt5ao2ll7aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeiheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgoufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhr
    khhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepieegleehje
    elfeeifeeiuefhfefgvefgkedtjefhiedvveetgfduleejheeifffgnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthht
    ohepshhhrghkvggvlhdrsghuthhtsehlihhnuhigrdguvghvpdhrtghpthhtohephhgthh
    esihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:i52SaNXiVbelmAyZhA-GZZHs6bXZyZSpJ3mJe4aW5Yfd2xvT24t2RQ>
    <xmx:i52SaMrtIZompcUTUHirU7Eoil2nJRLOOlMmg-KEMlt5Cgig9aRbqA>
    <xmx:i52SaPl42hGL_7meT9BV5_AMx0Ji04Nfd7DSCGEuKZb-mJOffRkyPA>
    <xmx:i52SaM1VKstmP-cGUUXd0Fwfv7tdEd4dJ_HC927XHO_DEietJcgs5A>
    <xmx:i52SaD0PosXDOWilIQRb0GWoPs73cwVx3BSfuVgrTPwVAAbl9wNOh7jw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 20:10:50 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Cc: shakeel.butt@linux.dev,
	hch@infradead.org,
	wqu@suse.com
Subject: [PATCH 0/3] filemap_add_folio_nocharge()
Date: Tue,  5 Aug 2025 17:11:46 -0700
Message-ID: <cover.1754438418.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would like to revisit Qu's proposal to not charge btrfs extent_buffer
allocations to the user's cgroup.

https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/

I believe it is detrimental to randomly account these global pages to
the cgroup using them, basically at random. A bit more justification
and explanation in the patches themselves.

Three meta-considerations/questions:
1. Which tree should this go through, assuming it is acceptable?
   For now, I have based it off btrfs/for-next as that is what I am
   used to doing, but I am happy to re-send it based off the appropriate mm
   branch.
2. Christoph wrote the first patch as-is in his suggestion to Qu. I am happy
   to replace it with his authorship/s-o-b, I just didn't want to do that
   without asking. For now, I put his "Suggested-by".
3. The previous suggestion also requested "proper" documentation. I don't
   know what that entails in this case, and was unable to find corresponding
   documentation for filemap_add_folio() in the code or in Documentation/.
   Please let me know what I should be doing there, as well.

Boris Burkov (3):
  mm/filemap: add filemap_add_folio_nocharge()
  btrfs: use filemap_add_folio_nocharge() for extent_buffers
  mm: add vmstat for cgroup uncharged pages

 fs/btrfs/extent_io.c    |  4 ++--
 include/linux/mmzone.h  |  3 +++
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 41 +++++++++++++++++++++++++++++++++++------
 mm/vmstat.c             |  3 +++
 5 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.50.1


