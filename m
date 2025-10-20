Return-Path: <linux-fsdevel+bounces-64725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6ABF2701
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B74189402F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80F295DA6;
	Mon, 20 Oct 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="esxEoVPS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgFwTQ1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2728A731;
	Mon, 20 Oct 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977867; cv=none; b=TyLAhNaE8nQapOqGxEA6kDKSKGvDAP0w7d4lQdSyOtUY0zG2qGZFQ0H3b2st1P8RCmUOa05lOIbwicJWtCXuAh0jCgLWRim1yohqHw3HH2+MhFS8SmD9Z3OGpwua5CRqRkl+6BZura+zV5XszM2HWfGVmp8TlfIkdTyPNh9U9dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977867; c=relaxed/simple;
	bh=mvPxrr95qIzSEAF380/kWf1SjQNBxPwK9J1so35XCno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeHm/EZMTCiGO8Ymjxw0SqzdjRIyYF38udxFnqJ4iPr4zzdKGi5tE+xHVPa3hNwVEBs7+CtpskD/Ytkg00gAWs71BJ/WRSINV2mO0/5NgeIa2CVztObKevdWz18ydTOE6gfhzye0ampXerPyvfLfLOSn2F5igfn23jGZ4oZWQQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=esxEoVPS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgFwTQ1k; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 75CC913803F9;
	Mon, 20 Oct 2025 12:31:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Oct 2025 12:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1760977864; x=
	1760985064; bh=2Xy6EWOYD4UAz4zp+o+bvixxHmLQtxXlubeiPFw8ss4=; b=e
	sxEoVPSi2W1xtgJsouEe7y43NaYbWy5g3RqjYy7jDiU3mA7vupLMXbQL3rGi5EfL
	oveSQMr0pBDuv4oDdKZUm45zBtVdH4x6SSRU0YHcB/UnX/PS4kDL+xaSPKmhYi1u
	aUmuhsMN1kVohnLm/cNGHaR9vXwcOi8WGV65OGg3TLvFFI220PXODyf8UxYHRuf9
	08OfFoZp/R/+3b+9crIcqRjlVjcsrRFjbAmDVMreYAy41cBTheaj2XDLE9Z9wyvu
	SCrxShTK/R+qXm5B9LpO1LP5LZoM+Tdy/qXFFgKltPuAVh7i18P2Slt1BLu133aU
	ak6Q3AIjVCzW/PwguYHWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760977864; x=1760985064; bh=2
	Xy6EWOYD4UAz4zp+o+bvixxHmLQtxXlubeiPFw8ss4=; b=EgFwTQ1kLDHGiZBlb
	ckemRhyM0BSQsYXaWcaeP0uCapsne3I7LBJ6yQX8UeTwvsv1eMweYYhYtIKexLvK
	JLYUo9fPUkOCd/MauKukJFadCfoxtzibqUmYuW4dniGolPn8d62LNna1ZIVzHENp
	mfFySM5EqY8Yv8TJYg06XzGR4CRFiRXO+m03cz3I+S0JuKHFS29yHeI6W2tRwWiY
	KlbX09DNAeU8IoExV9q1k0ppN7aP8FbqPMw0uefnE5Yh+zEsXdTowZ8e3fI+OdS2
	7kvnIW2hoZS5eD8VESkAP+iOH5ePhgCnqPUkR//JuudbyKBh3QQSggoBTCdKc8Ez
	orGHg==
X-ME-Sender: <xms:yGP2aMs-4DWXLytnXZ2S-1Yo13Ckf_VESJWNssW56aK9bs0HWR9BEA>
    <xme:yGP2aGp1QWzhw9KodSo5tZJJPQ0o1xeEtkGcTcqqLXg1qi98gKPn97EX8ig7JpSyd
    EjBHgks4aOXKBbq5GqDiZm9x7z3bW_phxal4tSMW8XxztGjXCUjoMxU>
X-ME-Received: <xmr:yGP2aMSyywhNkWdmsGcFDlpRfot8c53DBWTnYzZMnJIWNnYW6IXbXwMYKspHIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepgeevhedtgfdvhfdugeffueduvdegveejhfevveeghfdvveeiveet
    iedvheejhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifih
    hllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhv
    rdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgii
X-ME-Proxy: <xmx:yGP2aLY80JtbkhfCLa7gysiKzMzZstZ4Gd8lnD90oueAIz1FnOuy6Q>
    <xmx:yGP2aN5Cv6DbkDPeL7T-imR9aTx28o88AwwBhmMYhcwuJJxrFRQEyA>
    <xmx:yGP2aGeTPDbbAoet1vGSuCnQzNVKaNFw8b3MizFI_OrxI2LdZb1vCA>
    <xmx:yGP2aEfpJ4fx0si0VxpU6fPTSHjzfqoRyKoQTQS8p0vOQ6Hlw4bYWA>
    <xmx:yGP2aDQZc_smkf6P_rPDwMqi6pQvtRnNiyw8tiaYTfJ34xxUDKCjBrvx>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 12:31:03 -0400 (EDT)
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
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
Date: Mon, 20 Oct 2025 17:30:54 +0100
Message-ID: <20251020163054.1063646-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020163054.1063646-1-kirill@shutemov.name>
References: <20251020163054.1063646-1-kirill@shutemov.name>
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

Not-yet-signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/truncate.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 91eb92a5ce4f..cdb698b5f7fa 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -177,6 +177,28 @@ int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
 	return 0;
 }
 
+static int try_folio_split_or_unmap(struct folio *folio, struct page *split_at)
+{
+	enum ttu_flags ttu_flags =
+		TTU_RMAP_LOCKED |
+		TTU_SYNC |
+		TTU_BATCH_FLUSH |
+		TTU_SPLIT_HUGE_PMD |
+		TTU_IGNORE_MLOCK;
+	int ret;
+
+	ret = try_folio_split(folio, split_at, NULL);
+
+	/*
+	 * If the split fails, unmap the folio, so it will be refaulted
+	 * with PTEs to respect SIGBUS semantics.
+	 */
+	if (ret)
+		try_to_unmap(folio, ttu_flags);
+
+	return ret;
+}
+
 /*
  * Handle partial folios.  The folio may be entirely within the
  * range if a split has raced with us.  If not, we zero the part of the
@@ -224,7 +246,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		return true;
 
 	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
-	if (!try_folio_split(folio, split_at, NULL)) {
+	if (!try_folio_split_or_unmap(folio, split_at)) {
 		/*
 		 * try to split at offset + length to make sure folios within
 		 * the range can be dropped, especially to avoid memory waste
@@ -249,12 +271,13 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 			goto out;
 
 		/*
+		 * Split the folio.
+		 *
 		 * make sure folio2 is large and does not change its mapping.
-		 * Its split result does not matter here.
 		 */
 		if (folio_test_large(folio2) &&
 		    folio2->mapping == folio->mapping)
-			try_folio_split(folio2, split_at2, NULL);
+			try_folio_split_or_unmap(folio2, split_at2);
 
 		folio_unlock(folio2);
 out:
-- 
2.50.1


