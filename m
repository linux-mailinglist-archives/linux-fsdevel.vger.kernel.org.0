Return-Path: <linux-fsdevel+bounces-75766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFEJGSk4eml+4gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:24:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E2CA58F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10C9C311F546
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2413148A6;
	Wed, 28 Jan 2026 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZ9u09TC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E63101DC;
	Wed, 28 Jan 2026 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617013; cv=none; b=m3rJwoXS4oiCM102gAwUNDAHWzYx/m+eDQNJTcIgIdvL6pX8wpFMJ5klKQ9LB4bqp1SE4/XwE57LICUNjzWvIBFuKr90m9bJ1rt0mMA3WsQuyTaCsniMXti29I3Egj5bIkIUZ4Vga/csn61vzVRUPq6QBx1eu+0kg6LoVjjwQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617013; c=relaxed/simple;
	bh=a5ldXktxptDKrJ1Hrr1I02dFz4f8JFjMCF3NSx5LHJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uyb/HqSXAAdamHHqx4HVcgOcGmEF39lzHi1zPm7bYlgPkkdscz9n2JQEe6MFByT1VZZKjgIUR8PvVuSIQj7gAguAOoNJQs+LX4T5Ap6PsSixlCaZKG0Asoo1c6njNwpLrVolGnNGqxomQufMciabODbwqMbMRoKGd7TwaFJMJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZ9u09TC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fICjEXODFdn1S8dSuMzr1QpC2CfU0IkTA2E9cMawJjM=; b=dZ9u09TCXQYw2q4BS14+erLqw9
	3hSNP/vzrc6r7OX7zblfDqReGemwFK6qJhQzkJTYinfML5eRewOz7EMW7U2rn0tvvJ3WW/0bhQ4kN
	dJxLg0I+XjuIIDXOkduQZP/3hq0dd/NSzEZyQ0cvClSYZ5zAWb+flsPcpeWeraCpMR4kjpbZpwr8d
	TXfl186atBCVwmVwn8OxqtuXQjWxS3YiGC/5chcGhCgabRzVS5Otp1bKAT+YKy3JAoNjTmr1n1W+d
	SMpBO0oOOQEEB4TbXjS5NMkq4Pu7hPzFiPQEt51CZZx+YwIvfnO5TIvsXVoZ/WNDzEo78a3sacYVK
	YlrqO+vA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl8Dq-0000000GN3F-2pd4;
	Wed, 28 Jan 2026 16:16:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 15/15] xfs: support T10 protection information
Date: Wed, 28 Jan 2026 17:15:10 +0100
Message-ID: <20260128161517.666412-16-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128161517.666412-1-hch@lst.de>
References: <20260128161517.666412-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75766-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[infradead.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:email,samsung.com:email,infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24E2CA58F5
X-Rspamd-Action: no action

Add support for generating / verifying protection information in the file
system.  This is largely done by simply setting the IOMAP_F_INTEGRITY
flag and letting iomap do all of the work.  XFS just has to ensure that
the data read completions for integrity data are run from user context.

For zoned writeback, XFS also has to generate the integrity data itself
as the zoned writeback path is not using the generic writeback_submit
implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Tested-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_aops.c  | 49 ++++++++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_iomap.c |  9 ++++++---
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index c3c1e149fff4..bf985b5e73a0 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -22,6 +22,7 @@
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
+#include <linux/bio-integrity.h>
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -661,6 +662,8 @@ xfs_zoned_writeback_submit(
 		bio_endio(&ioend->io_bio);
 		return error;
 	}
+	if (wpc->iomap.flags & IOMAP_F_INTEGRITY)
+		fs_bio_integrity_generate(&ioend->io_bio);
 	xfs_zone_alloc_and_submit(ioend, &XFS_ZWPC(wpc)->open_zone);
 	return 0;
 }
@@ -741,12 +744,45 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
+static void
+xfs_bio_submit_read(
+	const struct iomap_iter		*iter,
+	struct iomap_read_folio_ctx	*ctx)
+{
+	struct bio			*bio = ctx->read_ctx;
+
+	/* delay read completions to the ioend workqueue */
+	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
+	bio->bi_end_io = xfs_end_bio;
+	submit_bio(bio);
+}
+
+static const struct iomap_read_ops xfs_bio_read_integrity_ops = {
+	.read_folio_range	= iomap_bio_read_folio_range,
+	.submit_read		= xfs_bio_submit_read,
+	.bio_set		= &iomap_ioend_bioset,
+};
+
+static inline const struct iomap_read_ops *
+xfs_bio_read_ops(
+	const struct xfs_inode		*ip)
+{
+	if (bdev_has_integrity_csum(xfs_inode_buftarg(ip)->bt_bdev))
+		return &xfs_bio_read_integrity_ops;
+	return &iomap_bio_read_ops;
+}
+
 STATIC int
 xfs_vm_read_folio(
-	struct file		*unused,
-	struct folio		*folio)
+	struct file			*file,
+	struct folio			*folio)
 {
-	iomap_bio_read_folio(folio, &xfs_read_iomap_ops);
+	struct iomap_read_folio_ctx	ctx = {
+		.cur_folio	= folio,
+		.ops		= xfs_bio_read_ops(XFS_I(file->f_mapping->host)),
+	};
+
+	iomap_read_folio(&xfs_read_iomap_ops, &ctx);
 	return 0;
 }
 
@@ -754,7 +790,12 @@ STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_bio_readahead(rac, &xfs_read_iomap_ops);
+	struct iomap_read_folio_ctx	ctx = {
+		.rac		= rac,
+		.ops		= xfs_bio_read_ops(XFS_I(rac->mapping->host)),
+	};
+
+	iomap_readahead(&xfs_read_iomap_ops, &ctx);
 }
 
 static int
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 04f39ea15898..b5d70bcb63b9 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -143,11 +143,14 @@ xfs_bmbt_to_iomap(
 	}
 	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
 	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
-	if (mapping_flags & IOMAP_DAX)
+	iomap->flags = iomap_flags;
+	if (mapping_flags & IOMAP_DAX) {
 		iomap->dax_dev = target->bt_daxdev;
-	else
+	} else {
 		iomap->bdev = target->bt_bdev;
-	iomap->flags = iomap_flags;
+		if (bdev_has_integrity_csum(iomap->bdev))
+			iomap->flags |= IOMAP_F_INTEGRITY;
+	}
 
 	/*
 	 * If the inode is dirty for datasync purposes, let iomap know so it
-- 
2.47.3


