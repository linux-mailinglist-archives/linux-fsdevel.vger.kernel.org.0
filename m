Return-Path: <linux-fsdevel+bounces-17747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFAC8B209E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEA1C2422D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D155E12AAEF;
	Thu, 25 Apr 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Z0huUBl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC82212AAD1;
	Thu, 25 Apr 2024 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045637; cv=none; b=QoYHLFSur2WAnwTSz074F/3lxdBLraAK5ugwNjnyxK+SHrtcS+qkbBfRHZv5nfDxRmjJFnAM/MIoLXZB/BrAIlYjo8IcPr5DUgDIKulnJW/LHoUOcf6nCO2y8YyWOPnmHa0J95xluN8OOMvq5iUMT1BWOyv22fokLbAKJvR+dp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045637; c=relaxed/simple;
	bh=kwE4kRA1hN9mlG3PCM2KBf+7t4fXGBB1vmxwnpdjqlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxyOLozbBEQSuOysrhk764p74i0OcexzJ5XTjR1CSqE1DI5OhGvQUfH6w8LBYQwOzodvx24gwhj1xsCPuWe0cb8dTIfJbnoJJ8G4W5ROFOdMlPvRna3eolpOAItSkNrSNhe4+fXIywYmO5ghLOxgO3Y03BMBTPS8jca/vnLnGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Z0huUBl7; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VQDPZ0yvLz9ssM;
	Thu, 25 Apr 2024 13:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fVr4b9yY0BnR40etXyUF6I1OzhNW3adroiSkIr7JfI=;
	b=Z0huUBl7vPYkwQXuGJvayILrp8fqw1XoWWWGfZA54Jz3eGBIbjPv2tzkb8U2hzLbN9kbzH
	CBVqCH1M87ltsgLZgkAJDtRtQTRwDdciiRm8HxJazZR48lp0lxZ0HZ8xH80ehB/Wf3AoJN
	KAh4mmedJIL72xLuMNS89gd6IW+Lksmwj+8MN4t+fBP+/YCC/PcX+i5CO1HDAW2CxtGWAG
	hdYShbikqRUAeOGRKvcwOevAF3K5a5ptRScXTkN4OOAADyrRpBA9eZ0HXPI8lSfNdVd5rm
	EGAr6TPGPpBEx6EBqTDWeGxgwBtvn53q1W5q5/KLLowSAgqffxK5VDdfhFhgcg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: willy@infradead.org,
	djwong@kernel.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandan.babu@oracle.com,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	mcgrof@kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: [PATCH v4 05/11] mm: do not split a folio if it has minimum folio order requirement
Date: Thu, 25 Apr 2024 13:37:40 +0200
Message-Id: <20240425113746.335530-6-kernel@pankajraghav.com>
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VQDPZ0yvLz9ssM

From: Pankaj Raghav <p.raghav@samsung.com>

Splitting a larger folio with a base order is supported using
split_huge_page_to_list_to_order() API. However, using that API for LBS
is resulting in an NULL ptr dereference error in the writeback path [1].

Refuse to split a folio if it has minimum folio order requirement until
we can start using split_huge_page_to_list_to_order() API. Splitting the
folio can be added as a later optimization.

[1] https://gist.github.com/mcgrof/d12f586ec6ebe32b2472b5d634c397df

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/huge_memory.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..dadf1e68dbdc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3117,6 +3117,15 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			goto out;
 		}
 
+		/*
+		 * Do not split if mapping has minimum folio order
+		 * requirement.
+		 */
+		if (mapping_min_folio_order(mapping)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
-- 
2.34.1


