Return-Path: <linux-fsdevel+bounces-13305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573386E62C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 17:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CB228C4D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF753D98E;
	Fri,  1 Mar 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="gLQIhxE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D33D55D;
	Fri,  1 Mar 2024 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311508; cv=none; b=PugJo8IGdjQR5Jb7vrUeiDdYv75/HQz9g5Z6QPlMDjXMbj/qF9w5r2ujltkl5f9VEyWvAo+wX3NB7u/cpkxhtzs6Rxh9KRnPww++KMYpm7vTkoJO72R3/I+8tt1PsSwH9juIt0/NdCkPOKqP0/80gaLAxfkEy7kon0qwbjPgm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311508; c=relaxed/simple;
	bh=/yCQWXlfzMMgXB62iTfoUc1cPEUwbGEfOAR7A7EJP58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjRQYb6GwPiubDEh/Tx3yyKpvAAzynzovADe++d6uDK/gn6XGSbgjK6yV0i/Uej33TGvbulfpiMUnehuJzPpTAoREt3djv7myxgaymIRnOgOwQe/Hc4013PWyczvEuPg+tQuZA1HBUh58c/EGgxhsbJcxxJ10uFBJH5snKRuzoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=gLQIhxE+; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TmYq26jcYz9tWM;
	Fri,  1 Mar 2024 17:45:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709311502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TofXuty2ThUTVbSRpvzx3fKuxbhJgVt2hgC/1tt8iys=;
	b=gLQIhxE+TRtwfuu+rkDGqXs9WJziHw+JgFYbs09TJNFTQr/gW51opLqv2FzJyRdjGXp4D+
	ne65X9oZMlHrjtB7n2NoVfWLB7HRk8vf4R2509Dwyk0M0ewQllhPja9qtmtoL4b8sPFTQ+
	nkXNSyx3ulIxKLLguMd3aSVWP1dyntFOl0MdffdljoNDzvM11kcYKpKwACEbRaRp/XCnWk
	3OVsBFM2dylNmecH3BKcdEkp8R+JtceQH/tuSiOi2Mxn50YFHT3Dhlceayzt6YF/1p9wYQ
	959x+3MJa2eWXaXbDEZx1+NDiBkzsl0pBsLvjOU/sWouTcpNx5vpkjIcz7zGbA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Cc: djwong@kernel.org,
	mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	david@fromorbit.com,
	akpm@linux-foundation.org,
	gost.dev@samsung.com,
	linux-kernel@vger.kernel.org,
	chandan.babu@oracle.com,
	willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 04/13] filemap: use mapping_min_order while allocating folios
Date: Fri,  1 Mar 2024 17:44:35 +0100
Message-ID: <20240301164444.3799288-5-kernel@pankajraghav.com>
In-Reply-To: <20240301164444.3799288-1-kernel@pankajraghav.com>
References: <20240301164444.3799288-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

filemap_create_folio() and do_read_cache_folio() were always allocating
folio of order 0. __filemap_get_folio was trying to allocate higher
order folios when fgp_flags had higher order hint set but it will default
to order 0 folio if higher order memory allocation fails.

As we bring the notion of mapping_min_order, make sure these functions
allocate at least folio of mapping_min_order as we need to guarantee it
in the page cache.

Add some additional VM_BUG_ON() in __filemap_add_folio to catch errors
where we add folios that has order less than min_order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 mm/filemap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 96fe5c7fe094..3e621c6344f7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -849,6 +849,8 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping),
+			folio);
 	mapping_set_update(&xas, mapping);
 
 	if (!huge) {
@@ -1886,8 +1888,10 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 		folio_wait_stable(folio);
 no_page:
 	if (!folio && (fgp_flags & FGP_CREAT)) {
-		unsigned order = FGF_GET_ORDER(fgp_flags);
+		unsigned int min_order = mapping_min_folio_order(mapping);
+		unsigned int order = max(min_order, FGF_GET_ORDER(fgp_flags));
 		int err;
+		index = mapping_align_start_index(mapping, index);
 
 		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
 			gfp |= __GFP_WRITE;
@@ -1912,8 +1916,11 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
+			if (order < min_order)
+				order = min_order;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
+
 			folio = filemap_alloc_folio(alloc_gfp, order);
 			if (!folio)
 				continue;
@@ -1927,7 +1934,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 				break;
 			folio_put(folio);
 			folio = NULL;
-		} while (order-- > 0);
+		} while (order-- > min_order);
 
 		if (err == -EEXIST)
 			goto repeat;
@@ -2424,7 +2431,8 @@ static int filemap_create_folio(struct file *file,
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t index;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    min_order);
 	if (!folio)
 		return -ENOMEM;
 
@@ -3666,7 +3674,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
-- 
2.43.0


