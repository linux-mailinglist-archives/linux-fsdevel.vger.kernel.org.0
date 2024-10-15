Return-Path: <linux-fsdevel+bounces-32011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DEA99F2E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A41B1C215E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C511F76AD;
	Tue, 15 Oct 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="UPJz3miN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCC1B3931
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010483; cv=none; b=cB8slMwEuQkhyM2cJ5DpT2alnRuMzAkDiiXQJygERRzUQhF9b5rfuQI1yEDB0x7ixcqPKf6nUw2IgohlkxWDIYGufyJtuMxIotYd0GqhcLNvKuILETsVb03//eX8t6/4fHZ49Oxo1LA3dMciaT9GsK5BJKhB0CgvQ7uGtx8BQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010483; c=relaxed/simple;
	bh=mjpJvQF6rABzW8S5SV9hQf11anHKHVy31OBwcfXEzHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCh3LgLmW4Q+aQL+QeStKhYeYreUU3kbuWuE2jQnCwzZNi94CY2s65YPqDpby+URhmYb7041eW8F8uoIKBF/lPhF8A/uK4fdgPDXHHwnQZ/5kPwLtwTCxAoNaikNZQt7GJ8sdX3Fv2SzKVN6DVvEWFDkkbzaxogrW0vQyWEcrNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=UPJz3miN; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XSfxK5960z9sv3;
	Tue, 15 Oct 2024 18:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729010469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MocHuP0EhrLPN/nAkv+wZUpjwH3uim1hitLn0pXPYFA=;
	b=UPJz3miNQ52YWS/6Q66WKBZk160F0liquQwrCTWyelkPTDcQTvR3eEa4GrN8SbGCOiCU+a
	4RNhyDnreaHPFkaTC1VrR51TcPkU3dVCZ7Duyaua2YLbAeIw1XfGK0nK5frBqNBdLFkPGI
	C1tYeUHuGRM90SLpNmFADNZ+gTfzXbFyCzn+/OAGOkrn/BQLy5THUZZ4aA8mJfUvlbvruG
	vznqpa0w1e5z0vsniL9u/gcT7gohOtk6N6YvPySSaLEyClJLZeFehlj6/nebWAfNVJO4WM
	TGiUfQh9jYfBhMQt2LDTQ+lue+VAoYpQ2OMmDqdfbI31Nfp2Hx0VY2faKAlbRQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v14] mm: don't set readahead flag on a folio when lookahead_size > nr_to_read
Date: Tue, 15 Oct 2024 18:41:06 +0200
Message-ID: <20241015164106.465253-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

The readahead flag is set on a folio based on the lookahead_size and
nr_to_read. For example, when the readahead happens from index to index
+ nr_to_read, then the readahead `mark` offset from index is set at
nr_to_read - lookahead_size.

There are some scenarios where the lookahead_size > nr_to_read. If this
happens, readahead flag is not set on any folio on the current
readahead window.

There are two problems at the moment in the way `mark` is calculated
when lookahead_size > nr_to_read:

- unsigned long `mark` will be assigned a negative value which can lead
  to unexpected results in extreme cases due to wrap around.

- The current calculation for `mark` with mapping_min_order > 0 gives
  incorrect results when lookahead_size > nr_to_read due to rounding
  up operation.

Explicitly initialize `mark` to be ULONG_MAX and only calculate it
when lookahead_size is within the readahead window.

Fixes: 26cfdb395eef ("readahead: allocate folios with mapping_min_order in readahead")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..475d2940a1ed 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -206,9 +206,9 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct address_space *mapping = ractl->mapping;
-	unsigned long ra_folio_index, index = readahead_index(ractl);
+	unsigned long index = readahead_index(ractl);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	unsigned long mark, i = 0;
+	unsigned long mark = ULONG_MAX, i = 0;
 	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
 
 	/*
@@ -232,9 +232,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	 * index that only has lookahead or "async_region" to set the
 	 * readahead flag.
 	 */
-	ra_folio_index = round_up(readahead_index(ractl) + nr_to_read - lookahead_size,
-				  min_nrpages);
-	mark = ra_folio_index - index;
+	if (lookahead_size <= nr_to_read) {
+		unsigned long ra_folio_index;
+
+		ra_folio_index = round_up(readahead_index(ractl) +
+					  nr_to_read - lookahead_size,
+					  min_nrpages);
+		mark = ra_folio_index - index;
+	}
 	nr_to_read += readahead_index(ractl) - index;
 	ractl->_index = index;
 

base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
-- 
2.44.1


