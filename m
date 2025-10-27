Return-Path: <linux-fsdevel+bounces-65700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607F9C0D686
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C214267BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4133002DE;
	Mon, 27 Oct 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="JgXUErhS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1+dniXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BADF3002BD;
	Mon, 27 Oct 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566214; cv=none; b=mX53yX1qocFskJ6ZzzhRztQs7InYod3CC4TwXR6Wf8PWnJ8447dJ3zjnPL7BhRrez5jKrrf7Ppbi8InpzsZmr23Is7T/xtFlTAa/eK/0wnBQa+VLnSc/dc9SBvdCNA6E4KM0LJimekX6qQtGZf1vzwfxAnrO3rWZ95Qr1rsyQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566214; c=relaxed/simple;
	bh=jltUd+YsZDBz1K3JVTVPMH5Lps5gj1uliM54pjmNZ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oyf3TKnsLyZu/qGo3NsuzdttjaSzD/zmHtj45ILc18O2dT+FtoupyTdeLvsUikYP+4aZZnzPgSVRgjC8rKUAQyifHV0igNh915uvE/iDpPAeha/eBr5wGM6J7fRJXFMjj7bEZTlPcZnmIww8bSh+O/kz7bc3/rnBhe1t2rgvlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=JgXUErhS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1+dniXl; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 1D85E138026E;
	Mon, 27 Oct 2025 07:56:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 27 Oct 2025 07:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1761566211; x=
	1761573411; bh=K3fQ2fEoyjQsfqeD80DG/98tb3JsUKWLI+ymnihBKZ4=; b=J
	gXUErhSWuZVAtKi8moOJOqmc5aoBDcOEaWX1mwnXUdmPhGK+tIZqpzdUl+FpCvSx
	074QdIvn3KUhh8GwEIddVren7KuYmpE4RprMoQYMtin4SQ1CsUYYL+4p1qwpaOqN
	piTECd0loRLFafAswOP8eHjBX6Hn69qDVSmd5IKnr0mOZcPfLgIM27oSjaf//brV
	L4VkrZ0iuCF13hQLup0736cGRQ1qXKewuIjCeN1ae43Vp4TrNUmnsk0paXPiM9AD
	XpuQOO/3GHxCZFI9yMAMRB5bqBx19MLkVnUqJlfUzbxbk+oOMH2vB9y899m+nK6r
	sD5VS01VbFUB/YAqxrZ0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761566211; x=1761573411; bh=K
	3fQ2fEoyjQsfqeD80DG/98tb3JsUKWLI+ymnihBKZ4=; b=c1+dniXl1Jm+aRbgu
	hNs/r6PllBXokTSetn1vUY/FHeXtwdFyjpIXs0l/yVF097lGFYv6MJQCco+n/Zjj
	rRtKffdZhd4oC/YYDheQHUV6+ow+nMPKYsYMUbMUzKY8jDPTbtbt5dUT28Kbta4h
	/4/3rIT+QM1w6Ei9/LaLr0BT6h9n9hhdrXhPUgJ4Yn09tAy1wer1LxIRDHkIjJQa
	V1N32j/lsCKFcu0x9oZbJyq8RIVGP4Nzeg2mxSzMJpfbwPgAxYbxs8zmevn0dFRV
	y8boD/odka6CE+62LuswRvxVs4CP1MEAS1pxNdJSU0vaTBX+9N/nd+kH22A08PbT
	N3NxQ==
X-ME-Sender: <xms:Al7_aC5IuUdzJqK3iP8eLwKCiHI8gAls2sxDUHgrzo9mU6ZphfpM6A>
    <xme:Al7_aAwDdnG3plAFjSOAuXKUJCQNoXraShk1clljJR9vjNjFl0BVwNl1wjMnyOUaS
    rLVgsVrxyOW1GloZ_J9n9DkjmBjq4JayRjDG0weQWRSZK-gYdyeiLA>
X-ME-Received: <xmr:Al7_aPAkOOXH4XfGVOWUniHLloKqzN80GbDARzvXypfLcf1RGQvVwZWhatfRVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepgeevhedtgfdvhfdugeffueduvdegveejhfevveeghfdvveeiveet
    iedvheejhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:Al7_aBMq-kOmga7bCEzut5AgYefmNmDwOSaZ-O_TGXzLgWzOsMCWkQ>
    <xmx:Al7_aFRVHZOp9IFZGohrX1EBQ_ko5Nt4iCkzd63ee2m7TR400goGag>
    <xmx:Al7_aCsUwU37XITVB9K7Z_eMbIcBZwsjQfeyS1Lidrv_8z-_inEYdw>
    <xmx:Al7_aDV4tb0_boeDmoFDjtwGrSrjWsbzqDsZK0Y6noLl8H0oNaPdrQ>
    <xmx:A17_aLjWiwemAVVxhDloKxT3SckY4vHvc1iyiDO7BYQvIHg6LnCop8mf>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:56:50 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCHv3 2/2] mm/truncate: Unmap large folio on split failure
Date: Mon, 27 Oct 2025 11:56:36 +0000
Message-ID: <20251027115636.82382-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027115636.82382-1-kirill@shutemov.name>
References: <20251027115636.82382-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
supposed to generate SIGBUS.

This behavior might not be respected on truncation.

During truncation, the kernel splits a large folio in order to reclaim
memory. As a side effect, it unmaps the folio and destroys PMD mappings
of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
are preserved.

However, if the split fails, PMD mappings are preserved and the user
will not receive SIGBUS on any accesses within the PMD.

Unmap the folio on split failure. It will lead to refault as PTEs and
preserve SIGBUS semantics.

Make an exception for shmem/tmpfs that for long time intentionally
mapped with PMDs across i_size.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/truncate.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 9210cf808f5c..3c5a50ae3274 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,6 +177,32 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at,
+				    unsigned long min_order)
+{
+	enum ttu_flags ttu_flags =
+		TTU_SYNC |
+		TTU_SPLIT_HUGE_PMD |
+		TTU_IGNORE_MLOCK;
+	int ret;
+
+	ret = try_folio_split_to_order(folio, split_at, min_order);
+
+	/*
+	 * If the split fails, unmap the folio, so it will be refaulted
+	 * with PTEs to respect SIGBUS semantics.
+	 *
+	 * Make an exception for shmem/tmpfs that for long time
+	 * intentionally mapped with PMDs across i_size.
+	 */
+	if (ret && !shmem_mapping(folio->mapping)) {
+		try_to_unmap(folio, ttu_flags);
+		WARN_ON(folio_mapped(folio));
+	}
+
+	return ret;
+}
+
 /*
  * Handle partial folios.  The folio may be entirely within the
  * range if a split has raced with us.  If not, we zero the part of the
@@ -226,7 +252,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 
 	min_order = mapping_min_folio_order(folio->mapping);
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split_to_order(folio, split_at, min_order)) {
+	if (!try_folio_split_or_unmap(folio, split_at, min_order)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -250,13 +276,10 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		if (!folio_trylock(folio2))
 			goto out;
 
-		/*
-		 * make sure folio2 is large and does not change its mapping.
-		 * Its split result does not matter here.
-		 */
+		/* make sure folio2 is large and does not change its mapping */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split_to_order(folio2, split_at2, min_order);
+			try_folio_split_or_unmap(folio2, split_at2, min_order);
 
 		folio_unlock(folio2);
 out:
-- 
2.50.1


