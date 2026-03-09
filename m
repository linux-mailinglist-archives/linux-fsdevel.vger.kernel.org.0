Return-Path: <linux-fsdevel+bounces-79732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NIBEAxcrmkMCgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:35:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7654233F18
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 06:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 986113032F68
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 05:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8923318ED7;
	Mon,  9 Mar 2026 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="caqkc1w9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C0314B6B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773034482; cv=none; b=ET+Y05dfFkXYGrf14U0JPlbsTyW6f7q91J2NL96MM768YXL+7etIgARGkNwrDoUVMkt67rKmdtz0g4Ld7WPHNZOJe3TtDC9q4UWKPEKyMNWFii1mfACrlKaTsC9y/uTBnw+hwGkiyqi4rgmFSIVgK/EFRZpLUXqrV/98JojRaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773034482; c=relaxed/simple;
	bh=PLqAP2WIpGyYvuWhMB8WoCRg3Rkrg5lpta0ujTFkVAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=m83lTCf9YVuFFAB7UpAbo4fXhQDEs+Ox1TmTdF4EJsAcYKmh8RVJM5GDW8XT0JLOGtyN7s8VT+tFiskeM4x7qEWW3NO2KJvQjKKGo+PM19xcFtLI3ngU5JmZrZMIHz5AeYu7z+aGrvq60PULdsvcXMsD8S+SLsUQAACKJ+Pf1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=caqkc1w9; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260309053436epoutp043b987585cc0b850f6a711b1ba3543b35~bFXZsraJq0406104061epoutp04B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 05:34:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260309053436epoutp043b987585cc0b850f6a711b1ba3543b35~bFXZsraJq0406104061epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773034476;
	bh=KL9tCf1S3mrIdzKtBLtGF7PaXrepLaovO5eyqrwtmLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=caqkc1w92qdYSH2I6f0YgqvnPuK6iuzi6QIzctQck93IDrCloLz75z4irtk9HwLoZ
	 fJT7b2TOOA3fJt5TXmEVJ1mKn2/DZmu8AH1fQPNJRYWWqBxUao7KE99U+dHiG9Mj49
	 Q/BZTcDaEsBckbufqZxVkt1ZpytePiTIGfnRL9Us=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260309053435epcas5p31bb50447a0700517259ca11d51f7b8bf~bFXY1hTNF0576205762epcas5p3I;
	Mon,  9 Mar 2026 05:34:35 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fTm0p52QXz3hhTB; Mon,  9 Mar
	2026 05:34:34 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260309053434epcas5p308acff894c6735e382c0e5e1e737c9de~bFXXadg050576205762epcas5p3G;
	Mon,  9 Mar 2026 05:34:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260309053432epsmtip28f95a06b0d672b27fd695e047cf8780b~bFXVy7JlB1941719417epsmtip2j;
	Mon,  9 Mar 2026 05:34:32 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: brauner@kernel.org, hch@lst.de, djwong@kernel.org, jack@suse.cz,
	cem@kernel.org, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 4/5] xfs: steer allocation using write stream
Date: Mon,  9 Mar 2026 10:59:43 +0530
Message-Id: <20260309052944.156054-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260309052944.156054-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260309053434epcas5p308acff894c6735e382c0e5e1e737c9de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260309053434epcas5p308acff894c6735e382c0e5e1e737c9de
References: <20260309052944.156054-1-joshi.k@samsung.com>
	<CGME20260309053434epcas5p308acff894c6735e382c0e5e1e737c9de@epcas5p3.samsung.com>
X-Rspamd-Queue-Id: A7654233F18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79732-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,samsung.com:email,samsung.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

When write stream is set on the file, override the default
directory-locality heuristic with a new heuristic that maps
available AGs into streams.

Isolating distinct write streams into dedicated allocation groups helps
in reducing the block interleaving of concurrent writers. Keeping these
streams spatially separated reduces AGF lock contention and logical file
fragmentation.

If AGs are fewer than write streams, write streams are distributed into
available AGs in round robin fashion.
If not, available AGs are partitioned into write streams. Since each
write stream maps to a partition of multiple contiguous AGs, the inode hash
is used to choose the specific AG within the stream partition. This can
help with intra-stream concurency when multiple files are being written in
a single stream that has 2 or more AGs.

Example: 8 Allocation Groups, 4 Streams
Partition Size = 2 AGs per Stream

   Stream 1 (ID: 1)         Stream 2 (ID: 2)         Streams 3 & 4
 +---------+---------+    +---------+---------+    +-------------
 |   AG0   |   AG1   |    |   AG2   |   AG3   |    |  AG4...AG7
 +---------+---------+    +---------+---------+    +-------------
      ^         ^              ^         ^
      |         |              |         |
      | File B (ino: 101)      | File D (ino: 201)
      | 101 % 2 = 1 -> AG 1    | 201 % 2 = 1 -> AG 3
      |                        |
 File A (ino: 100)        File C (ino: 200)
 100 % 2 = 0 -> AG 0      200 % 2 = 0 -> AG 2

If AGs can not be evenly distributed among streams, the last stream will
absorb the remaining AGs.

Note that there are no hard boundaries; this only provides explicit
routing hint to xfs allocator so that it can group/isolate files in the way
application has decided to group/isolate. We still try to preserve file
contiguity, and the full space can be utilized even with a single stream.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/xfs/libxfs/xfs_bmap.c |  9 +++++++++
 fs/xfs/xfs_inode.c       | 33 +++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.h       |  1 +
 3 files changed, 43 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 7a4c8f1aa76c..facf56e8e01d 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3591,6 +3591,15 @@ xfs_bmap_btalloc_best_length(
 	int			error;
 
 	ap->blkno = XFS_INO_TO_FSB(args->mp, ap->ip->i_ino);
+
+	/* override the default allocation heuristic if write stream is set */
+	if (ap->ip->i_write_stream && ap->datatype & XFS_ALLOC_USERDATA) {
+		xfs_agnumber_t stream_ag = xfs_inode_write_stream_to_ag(ap->ip);
+
+		if (stream_ag != NULLAGNUMBER)
+			ap->blkno = XFS_AGB_TO_FSB(args->mp, stream_ag, 0);
+	}
+
 	if (!xfs_bmap_adjacent(ap))
 		ap->eof = false;
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 9b88b2d1cf9a..e93141d2cd8b 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -93,6 +93,39 @@ xfs_inode_set_write_stream(
 	return 0;
 }
 
+xfs_agnumber_t
+xfs_inode_write_stream_to_ag(
+	struct xfs_inode	*ip)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	uint8_t			stream_id = ip->i_write_stream;
+	uint32_t		max_streams = xfs_inode_max_write_streams(ip);
+	uint32_t		nr_ags;
+	xfs_agnumber_t		start_ag, ags_per_stream;
+
+	if (XFS_IS_REALTIME_INODE(ip) || !max_streams)
+		return NULLAGNUMBER;
+
+	stream_id -= 1; /* for 0-based math, stream-ids are 1-based */
+
+	nr_ags = mp->m_sb.sb_agcount;
+	ags_per_stream = nr_ags / max_streams;
+
+	/* for the case when we have fewer AGs than streams */
+	if (ags_per_stream == 0) {
+		start_ag = stream_id % nr_ags;
+		ags_per_stream = 1;
+	} else {
+		/* otherwise AGs are partitioned into N streams */
+		start_ag = stream_id * ags_per_stream;
+		/* uneven distribution case: last stream may contain extra */
+		if (stream_id == max_streams-1)
+			ags_per_stream = nr_ags - start_ag;
+	}
+	/* intra-stream concurrency: hash inode to choose AG within partition */
+	return start_ag + (ip->i_ino % ags_per_stream);
+}
+
 /*
  * These two are wrapper routines around the xfs_ilock() routine used to
  * centralize some grungy code.  They are used in places that wish to lock the
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 9f6cab729924..9ab31ff6b5e1 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -682,4 +682,5 @@ int xfs_icreate_dqalloc(const struct xfs_icreate_args *args,
 int xfs_inode_max_write_streams(struct xfs_inode *ip);
 uint8_t xfs_inode_get_write_stream(struct xfs_inode *ip);
 int xfs_inode_set_write_stream(struct xfs_inode *ip, uint8_t stream_id);
+xfs_agnumber_t xfs_inode_write_stream_to_ag(struct xfs_inode *ip);
 #endif	/* __XFS_INODE_H__ */
-- 
2.25.1


