Return-Path: <linux-fsdevel+bounces-77263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DbKNqWrkmlPwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:31:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49015140FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 06:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8909E3021E7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149292D1F64;
	Mon, 16 Feb 2026 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o2EdonjP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA022D4D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771219831; cv=none; b=EpZT37eH5P5cXbM320F6j/6Grf+tU0838EMeTgoDWZsugtaUOkc+f4GNikRugjginc1325CcJnHbjN/lzBJXWi6w/meIIH0o2ikc+fZplw6a1323ugNkCegBCbRF5G4OuptXT7Iu78jKT2y0t0n5+wGht9+OI1gb9yYpvncwl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771219831; c=relaxed/simple;
	bh=GCwWTdKzQzSoP2ZmBMqOylVALTBLszYgs9ixSxTEcZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JKCO7+UzcbtYRbzygttW+KT3mbfo87QM4NWXV8aA2AVs1os0GLImHFdVqW4AbbkcAaZL6d9dXqsXt8f7lvjE7kZnUe5FvbYNj8DAu6DXqR6lgPlWtRSKdMFp3woHeZ82+dgU8G3GDhV9AOg/mLW7JSkIv6CPQpbY0iMOeSbj998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=o2EdonjP; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260216053027epoutp046c59a1160f0f188302c9509aa8ee8b45~UowyWpI8E0340703407epoutp04H
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 05:30:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260216053027epoutp046c59a1160f0f188302c9509aa8ee8b45~UowyWpI8E0340703407epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771219827;
	bh=6LCbgLZh6NTpV0YmSoqb4jWH4j9aZFSnY2GuLyWAYFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2EdonjPmRn73zjL03tfe186LOWGZFi/zUf32Fn6+1FBXbld8uBNnsa1UcFUgUqlV
	 3pqzvxw5I7OgQMKz6Kz2ZDiTD1ubkyQqmf5W9oo8a220rDFakKguTgwdeJMpMQUq41
	 MvfSa/2cnqVcBK0BTxmAwzDQF4bCUFdH5DdD53ns=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260216053027epcas5p4592fcded38b550c3a7e22301408c4d73~Uowx8UNZx2662326623epcas5p4J;
	Mon, 16 Feb 2026 05:30:27 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fDrvk5f6Mz3hhTB; Mon, 16 Feb
	2026 05:30:26 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260216053026epcas5p10d892b855cd2de2e7334019c5feb5281~Uoww5AHXW1743017430epcas5p1J;
	Mon, 16 Feb 2026 05:30:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260216053024epsmtip1e4524802355427ff2496024f9eda5570~UowvcbX9t1594915949epsmtip1O;
	Mon, 16 Feb 2026 05:30:24 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, brauner@kernel.org, jack@suse.cz, djwong@kernel.org,
	axboe@kernel.dk, kbusch@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 3/4] iomap: introduce and propagate write_stream
Date: Mon, 16 Feb 2026 10:55:39 +0530
Message-Id: <20260216052540.217920-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260216052540.217920-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260216053026epcas5p10d892b855cd2de2e7334019c5feb5281
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260216053026epcas5p10d892b855cd2de2e7334019c5feb5281
References: <20260216052540.217920-1-joshi.k@samsung.com>
	<CGME20260216053026epcas5p10d892b855cd2de2e7334019c5feb5281@epcas5p1.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-77263-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 49015140FFC
X-Rspamd-Action: no action

Add a new write_stream field to struct iomap. Existing hole is used to
place the new field.
Propagate write_stream from iomap to bio in both direct I/O and buffered
writeback paths.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/iomap/direct-io.c  | 1 +
 fs/iomap/ioend.c      | 3 +++
 include/linux/iomap.h | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 8c1fd7573aee..1fc7e1831b1c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -333,6 +333,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 			pos >> iter->inode->i_blkbits, GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_write_hint = iter->inode->i_write_hint;
+	bio->bi_write_stream = iter->iomap.write_stream;
 	bio->bi_ioprio = dio->iocb->ki_ioprio;
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index e4d57cb969f1..bb5886c1e5a0 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -113,6 +113,7 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_write_hint = wpc->inode->i_write_hint;
+	bio->bi_write_stream = wpc->iomap.write_stream;
 	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
 	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
@@ -133,6 +134,8 @@ static bool iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t pos,
 	if (!(wpc->iomap.flags & IOMAP_F_ANON_WRITE) &&
 	    iomap_sector(&wpc->iomap, pos) != bio_end_sector(&ioend->io_bio))
 		return false;
+	if (wpc->iomap.write_stream != ioend->io_bio.bi_write_stream)
+		return false;
 	/*
 	 * Limit ioend bio chain lengths to minimise IO completion latency. This
 	 * also prevents long tight loops ending page writeback on all the
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 99b7209dabd7..e087818d11d4 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -113,6 +113,8 @@ struct iomap {
 	u64			length;	/* length of mapping, bytes */
 	u16			type;	/* type of mapping */
 	u16			flags;	/* flags for mapping */
+	/* 4-byte padding hole here */
+	u8			write_stream; /* write stream for I/O */
 	struct block_device	*bdev;	/* block device for I/O */
 	struct dax_device	*dax_dev; /* dax_dev for dax operations */
 	void			*inline_data;
-- 
2.25.1


