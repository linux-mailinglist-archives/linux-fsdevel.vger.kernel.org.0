Return-Path: <linux-fsdevel+bounces-23118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF43927504
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 13:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0804B1F22C61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B271AE85B;
	Thu,  4 Jul 2024 11:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MAKSFZlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C31AE848;
	Thu,  4 Jul 2024 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092247; cv=none; b=MAbUNXAe+mv3do4bp0tH2GhP0UEVLpGMUHsr0B4j41GQvUZVmcaPZBg59HiXRSfv5qNhCd8EMpur1mNVI8v8V5H83To4tlWRfvKqFEIZjBlHwJPuEO66CrvCmkMbfXdy+A1u6+m+aXz0Rs1IkszSI709Bf2/8oGQSIil8tQXSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092247; c=relaxed/simple;
	bh=oVLFbpMiPlCmMAMNE+tGeHJKbYbbrzfNiFNSfbDXslo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8aThyh3cuZOYr9565YNNR/zqdXbdmCVKAr/r2r5qu6Jwuz5e2+BK3S9X3wevRU4yKcXI8f+vw5YFWMnIEUHrgafUu9ZMktddTwA8yFYAbQ99NQJ7x71Mqt6yhuE2TsZA4Ihh/mq41YX6TtE1nIyEFpNvbmdXdPGPfumHxuMRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MAKSFZlI; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WFDmy24b9z9tVW;
	Thu,  4 Jul 2024 13:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720092242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rdOu+47Xth5hXKbmOu06fRFiMFY0Pwf2tkrEBizRPk=;
	b=MAKSFZlI7ZaAEYyHpa4m+b6rHiU+P6QyeLCjZz23UGlI5WftoQSBRtyro7pc9FWT+MVPTZ
	kfKxyyXsGG9jZvTH11CKc9vmmNALVet9Y+7E4B5uSi4gC6mPXQUtTJnRM/JHxSECvsY+gU
	pGJWw57f7jZQbI1thzo6E30jiHbzhQ/iRu5h5APgIs+q8rRhj+zrnctYxJphX872+JkCg2
	rycOGh+225y6SHWO9xoN2nzzQ1LpK3UVAqWeLnjHldadfIH2mjbp5D7bcFTv2OpMzmgqWO
	VYqqRkLd0wF9NvRr5dW0ElnU0AKRa+o0BgzLlkMmwEW5UVXUk0QDizQhRF4Tgg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	willy@infradead.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	brauner@kernel.org,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	Zi Yan <ziy@nvidia.com>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v9 09/10] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Thu,  4 Jul 2024 11:23:19 +0000
Message-ID: <20240704112320.82104-10-kernel@pankajraghav.com>
In-Reply-To: <20240704112320.82104-1-kernel@pankajraghav.com>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_mount.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 09eef1721ef4f..3949f720b5354 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -132,11 +132,16 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
+	uint64_t		max_bytes;
+
 	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 
+	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
+		return -EFBIG;
+
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	if (max_bytes >> PAGE_SHIFT > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
-- 
2.44.1


