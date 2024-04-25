Return-Path: <linux-fsdevel+bounces-17743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 307EF8B207C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 13:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826B9B2498C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCC12AAF9;
	Thu, 25 Apr 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="f7jcKlQP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D712CDB6;
	Thu, 25 Apr 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045112; cv=none; b=i2nNJHAO4+Jz2qBY8alMohiOa1sZ5FA8mzA5L4QyIUpGvmDSgPpeGrKJzfJuMPBVT2mBMrqBhjLNvU5PQAHZIO+woF1ra+NUy1TFWP/spixtJAYIx4qZKw54OeOnPJ21K0AE6MGZvTB0gYla00EYBavrxu9083fV0CXPnO4Y+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045112; c=relaxed/simple;
	bh=AkFwetJcCpUdzy6sBiMN1jiqOGm0+x3tDAtBnHtc4hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNbdkVlcW1hjuknxqjTqWpX/xNxLtkm3nU9Gh/jtEPA9XYfgFXxed/10UwZnUiXAq76CLZy4jFeFwNiop1v71zhcoFIC85U6pMlq/EXGWCxfgrx8sSZOdTkOysjDOr3ptyXsmb5G52sC8ie3a1fSPucoNl4jzyehmAwQfWxND7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=f7jcKlQP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VQDPt54hLz9t5C;
	Thu, 25 Apr 2024 13:38:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1714045106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIfjpeeNWGR8UToHGDXkOnyh18tKvUHuNUnl0OPj7BI=;
	b=f7jcKlQPBfdo5JDYXYUH/c0DKe3CXWPCsikhLprRpyztxc8+iqGjrFBcNznlGqrPUwXRyx
	YTp848BJW14DQgetVXZGZZkTeXzlZAplKzBtUVlM5VtIGjhRth78SC/bFtY5audPmOVkJT
	ZnH3F4hsDAVwQJnu3cR+/wI1iEVhY2fq4GhjTek/n+/rmLF4gyj4ASTvHU9Jn2eD71W8Tl
	UMVSJSMo0ypnXW0grvP6XvCXs78G+Mg7PewCr9m/ZBJRX7pTzCJDU8eAHNf7ZgP41ltNd4
	L+QempcsCIUIXA283kl/HsUM7k9QZbYJnfMBWfcPNBW7gXkVAHZI3eypTvhWmw==
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
Subject: [PATCH v4 09/11] xfs: expose block size in stat
Date: Thu, 25 Apr 2024 13:37:44 +0200
Message-Id: <20240425113746.335530-10-kernel@pankajraghav.com>
In-Reply-To: <20240425113746.335530-1-kernel@pankajraghav.com>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

For block size larger than page size, the unit of efficient IO is
the block size, not the page size. Leaving stat() to report
PAGE_SIZE as the block size causes test programs like fsx to issue
illegal ranges for operations that require block size alignment
(e.g. fallocate() insert range). Hence update the preferred IO size
to reflect the block size in this case.

This change is based on a patch originally from Dave Chinner.[1]

[1] https://lwn.net/ml/linux-fsdevel/20181107063127.3902-16-david@fromorbit.com/

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/xfs/xfs_iops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 66f8c47642e8..77b198a33aa1 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -543,7 +543,7 @@ xfs_stat_blksize(
 			return 1U << mp->m_allocsize_log;
 	}
 
-	return PAGE_SIZE;
+	return max_t(uint32_t, PAGE_SIZE, mp->m_sb.sb_blocksize);
 }
 
 STATIC int
-- 
2.34.1


