Return-Path: <linux-fsdevel+bounces-11336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C3852C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E211C23E2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7AF364C2;
	Tue, 13 Feb 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="uCtQvXEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AB2C692;
	Tue, 13 Feb 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817058; cv=none; b=a/1qoFFAQLdnapZTN26y54d632EWAgxvGcBc5+SEJR92vFQOiyPReYpPfR/DTaqC6CNhvzqnAgUMRQKAgKMiwON+im0FGMwD0pKsG5M119MtFHoUQd8lxSiD7aQ3Y2/l+3Sq4lUN4LCAW8hvMJ03GEWrY7A+muopKllweRrBdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817058; c=relaxed/simple;
	bh=0Ere+VznGanpb//IG2k8d2/r8RcDXiGlh6wtYwlnByw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6mPkflCDYpY0fn8pIyelitDDwUvDPdtlGovRznC+ZNQL92QIMdbBfI9ZuQyVdfurnvFLvQF8viSLFLZFblMQpqdog1jVpTzAdkOV9f/EZfE5X2blzHqz2OnOftoX9JqMeTleMQVOgV1XAcXovtaBNu/33JwCyQ3L0C8iyIpxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=uCtQvXEu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TYx7d50r9z9sTM;
	Tue, 13 Feb 2024 10:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJez9lFGKNHHqjTBT9OvccGI+MEPxelY3zNT/AM7wII=;
	b=uCtQvXEu+6KQlQCiuGw+WSyYea5LbyMcA82MG5gzxpXLndb1cSZu4/VRzPnge4R8I+K8Vv
	NZYcRK9/bHhRkukWeUhawuEyT7UQoBTZC6FyPTvux6qdgEkJRSaHWjRtW4ro1AkXkTAVYT
	b55DDYovZ7PBIf5u/a+N56W/LqXlxCoA8gdeOXImwC/a+P5TrtScQQAr9bWyzAu0aHAE4R
	+oYYuJSkshcJIBYSWUaP265Asnsqute1j4NgcbXErxl+PUNN63BcuLk2DfZLLQiC8PRKf/
	C0JlKO3C/DVbujCqHYe28d3whLpp37YQNKOSWJP8AVdWPnpx2/mbjEOXTMKMFQ==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 04/14] readahead: set file_ra_state->ra_pages to be at least mapping_min_order
Date: Tue, 13 Feb 2024 10:37:03 +0100
Message-ID: <20240213093713.1753368-5-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

Set the file_ra_state->ra_pages in file_ra_state_init() to be at least
mapping_min_order of pages if the bdi->ra_pages is less than that.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/readahead.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 2648ec4f0494..4fa7d0e65706 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -138,7 +138,12 @@
 void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping)
 {
+	unsigned int min_nrpages = mapping_min_folio_nrpages(mapping);
+	unsigned int max_pages = inode_to_bdi(mapping->host)->io_pages;
+
 	ra->ra_pages = inode_to_bdi(mapping->host)->ra_pages;
+	if (ra->ra_pages < min_nrpages && min_nrpages < max_pages)
+		ra->ra_pages = min_nrpages;
 	ra->prev_pos = -1;
 }
 EXPORT_SYMBOL_GPL(file_ra_state_init);
-- 
2.43.0


