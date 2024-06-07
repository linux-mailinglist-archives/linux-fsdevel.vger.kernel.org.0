Return-Path: <linux-fsdevel+bounces-21250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E2900844
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B321F1F275DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EBC19AA7D;
	Fri,  7 Jun 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Cn0j/AWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C6198E86;
	Fri,  7 Jun 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772786; cv=none; b=Bk35oMO9Hg3zig2DJNq8ILaGRQn3ukv7EIFbEd7q9NhprIB7n5oSZV5MBTQpNs47CTOZhuUiKg5VOEgYBcH+FYyazKVJojiC9AdE0cZCU/HB0KgAhCQRnBl45rkBYvLhImANVSfV9XOj0akQtL8cAW7E5yZM3LepIjdcO6HTmrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772786; c=relaxed/simple;
	bh=+6r70PXGOoDrgZczKyCNEqRz+H9Krx2IBf5jtzdMkms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyBaINdgPiff2608z4qXZg82sgXlbnqWhFoLG390v63sGiQCk4l8mv28oWx4YLF8fBBMvYX1FbKWxea/Lj64zMkegsttTKoDwx2oYDN+sPVl++j+J+qo1ySNFPenqKNciA7MMqB9P1eaDY2NeC3vU22+TREE0rjrHxwSdVmzHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Cn0j/AWN; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VwkrP1CCjz9snn;
	Fri,  7 Jun 2024 16:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717772389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bne/CkGLFb5Q+0r/mTCjdzHVWDyDH0TqoTxmXgBXKCE=;
	b=Cn0j/AWNicr8OHAovh1eFeMf2drV755n5F+zvZ1MdbQyUkqzCsMz2XxYhmPOC2AHubjaPN
	By+3Lnr4JK0aS27yj94k9MEkCJckWgq9jK1c1j3LFluOxy7/JDiNmX3uKasP8JO2jy6GXs
	qtnId+YktikV8HX2Fv9n7TpvJhdGTgqufWtf8fk40FJTjnJd+iomWBoBupp3MQc3ELjc3X
	lWt6MxodQqcZvTxBpdTkn7wBci1296lYMYsDoQYaUOU31D2WNUvNG6Mk1PrmUiDTt3/QKy
	Q7qtduMYWr9zGNNdSdW+wsgGejLyBrAGbz1EjEttBWc9C32hcnrBwyRzNil4Ng==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: david@fromorbit.com,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: mcgrof@kernel.org,
	linux-mm@kvack.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org,
	p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	gost.dev@samsung.com,
	cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: [PATCH v7 10/11] xfs: make the calculation generic in xfs_sb_validate_fsb_count()
Date: Fri,  7 Jun 2024 14:59:01 +0000
Message-ID: <20240607145902.1137853-11-kernel@pankajraghav.com>
In-Reply-To: <20240607145902.1137853-1-kernel@pankajraghav.com>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VwkrP1CCjz9snn

From: Pankaj Raghav <p.raghav@samsung.com>

Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
make the calculation generic so that page cache count can be calculated
correctly for LBS.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_mount.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 09eef1721ef4..46cb0384143b 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -132,11 +132,19 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
+	uint64_t		max_index;
+	uint64_t		max_bytes;
+
 	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 
+	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
+		return -EFBIG;
+
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	max_index = max_bytes >> PAGE_SHIFT;
+
+	if (max_index > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
-- 
2.44.1


