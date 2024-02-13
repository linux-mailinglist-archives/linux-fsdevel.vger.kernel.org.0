Return-Path: <linux-fsdevel+bounces-11341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A1C852C92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F501C24F03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92054F1E6;
	Tue, 13 Feb 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="PYSoXXZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998C946444;
	Tue, 13 Feb 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817073; cv=none; b=ngLP1k7FFiQkQN/J4j8svMT7TnBKY0g8g+4drcEAjNlTRUrk92YO95ni5Luq7AoUiOPr9whpHBhh3xkHsCWljEJJFPzCNJjwhYK4eacDejv7Lf50OL+fYIf2DB2mgN2hU+ouyq5ZtMoVSX71UPJBRpFc9bPkeDcwISR2Kuk0zKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817073; c=relaxed/simple;
	bh=aT7myvwbv8s6n+EpwpZGFT8dH3zqU9o7RwFhXcMPQLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXf93ClozDS7ToV449Xu4Ka1F+nU2GpLm+2sgwmgz62ONGG5CwTqIsKX2d4JrgX6nZ/Hu4t5OlK8zytvbufvbB0qIDWkL0hnJBfrPA2tbvMuNkIpts+AgE7FYqtYNk+qnjcRJORHC1swwi3n3BC8HAJhOodRC0WNXXW1qq4sBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=PYSoXXZF; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TYx7v6WyGz9sp2;
	Tue, 13 Feb 2024 10:37:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOt507Ijo5nyZ5wUX3vXhvqctlR5/JOvafIYIWSMCPU=;
	b=PYSoXXZF27fQan8sPatQHAhpAqM4cF203+dvlg+l2btfVaBSRRZiJ1MzdG7gxXCdw/x1xv
	zyTcd5oYO6PhI3ZFTTCL+6yiaM+Y6yFqYDrBTpKbEIBodE2d741iRoZELCaE88A++S1DY4
	rTb77WTAkP4yb3+9A/L0UsVRr/+EI8CsZdN/tVRk429O3hpuT4W5VPTqeszPTncLWrnDU0
	7UA6a6QW14Jlo99OKaM/RQfdVcRG6UsIp0cSAOQ7vP8EVJfGVRCfZwh+Jcy59vj6v6E1ie
	USql3iBXYGMEmlth5qx6Id4J6beIAHNMU9q3QOpfjtUTd+FbUH7EXaWS074UEQ==
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
Subject: [RFC v2 08/14] mm: do not split a folio if it has minimum folio order requirement
Date: Tue, 13 Feb 2024 10:37:07 +0100
Message-ID: <20240213093713.1753368-9-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYx7v6WyGz9sp2

From: Pankaj Raghav <p.raghav@samsung.com>

As we don't have a way to split a folio to a any given lower folio
order yet, avoid splitting the folio in split_huge_page_to_list() if it
has a minimum folio order requirement.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/huge_memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94c958f7ebb5..d897efc51025 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3026,6 +3026,19 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			goto out;
 		}
 
+		/*
+		 * Do not split if mapping has minimum folio order
+		 * requirement.
+		 *
+		 * XXX: Once we have support for splitting to any lower
+		 * folio order, then it could be split based on the
+		 * min_folio_order.
+		 */
+		if (mapping_min_folio_order(mapping)) {
+			ret = -EAGAIN;
+			goto out;
+		}
+
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
-- 
2.43.0


