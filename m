Return-Path: <linux-fsdevel+bounces-76018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIqEJFs/gGk65QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:08:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A08C87B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 07:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAB633002D20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 06:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1149F2F39C2;
	Mon,  2 Feb 2026 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sr8htu/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E948CFC;
	Mon,  2 Feb 2026 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770012498; cv=none; b=iHORYeQdoXhYL4SNUjUQhNZN0dJTlOAH/saEonab51D9r49Sw21zRPtSdA+RGV3yOXtFUJUKDB70NJHISQ4SLcC20h9cV/yZwtMPe7L0soJTKQlJptQa5TcaFrXBEahfoGYTYiz71OJigvJZxgntSWlc03gQQyt0UGcyI8SaiUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770012498; c=relaxed/simple;
	bh=emKEvjTPBwTahnSebo7N95uV6qix0T7wU9vnUXowNjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UllYsGk19I2/bvIxiFttzK4sZLdvBC5DUPY7EyZoW3bLHn8Q3WdVXanF6MnfoS3wKeVIQISisqpwOK1aaZ+fyMfoJ6KFCMtUYPrb3LoxHBKz79VDJlTdcxSocMpJ1FWKYMycgTeXdjNRSVCs+97Fj+8g8K3FfjoZ2WgkiGfpBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sr8htu/I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4zvXifu7/G3LbK7p292UW2gwOyz2+BN+bEMUfIr4RF8=; b=sr8htu/IWaOxZ/cXXcqQYxneEE
	BtsMmQ8K4VXfJ+ircRa+/xP64GiWucfOwnEOHRPDykYJTscyVqSfCf7bNYsySu0pgbIdRRmgwHhph
	uXMJlv4D9VGYhgVK7n2PhEKO4v6SIe9cuHPIapw3bekMLuoJc1/nB6KuC5uofAQ9EggN2KQ2HLk3H
	yWsifBWgyxF+SaNIyoxIybcpi9M3lhGDhhsIdBBdp2rZZNCosQgAzBDitDb2BzmoicVSJvJr3iUl1
	0HzhaUzm4MHnS8cN0dr5l3gPLcOtxnMsjUrhmypEWW5XVm8DzISB33m5OrLlHCBfzjDz2IXqj1Xf9
	z2BR8hZg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmn6c-00000004Ujr-2N4Q;
	Mon, 02 Feb 2026 06:08:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: [PATCH 03/11] ext4: move ->read_folio and ->readahead to readahead.c
Date: Mon,  2 Feb 2026 07:06:32 +0100
Message-ID: <20260202060754.270269-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202060754.270269-1-hch@lst.de>
References: <20260202060754.270269-1-hch@lst.de>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76018-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6A08C87B0
X-Rspamd-Action: no action

Keep all the read into pagecache code in a single file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/ext4.h     |  4 ++--
 fs/ext4/inode.c    | 27 ---------------------------
 fs/ext4/readpage.c | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 56112f201cac..a8a448e20ef8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3735,8 +3735,8 @@ static inline void ext4_set_de_type(struct super_block *sb,
 }
 
 /* readpages.c */
-extern int ext4_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct folio *folio);
+int ext4_read_folio(struct file *file, struct folio *folio);
+void ext4_readahead(struct readahead_control *rac);
 extern int __init ext4_init_post_read_processing(void);
 extern void ext4_exit_post_read_processing(void);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8c2ef98fa530..e98954e7d0b3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3380,33 +3380,6 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 	return ret;
 }
 
-static int ext4_read_folio(struct file *file, struct folio *folio)
-{
-	int ret = -EAGAIN;
-	struct inode *inode = folio->mapping->host;
-
-	trace_ext4_read_folio(inode, folio);
-
-	if (ext4_has_inline_data(inode))
-		ret = ext4_readpage_inline(inode, folio);
-
-	if (ret == -EAGAIN)
-		return ext4_mpage_readpages(inode, NULL, folio);
-
-	return ret;
-}
-
-static void ext4_readahead(struct readahead_control *rac)
-{
-	struct inode *inode = rac->mapping->host;
-
-	/* If the file has inline data, no need to do readahead. */
-	if (ext4_has_inline_data(inode))
-		return;
-
-	ext4_mpage_readpages(inode, rac, NULL);
-}
-
 static void ext4_invalidate_folio(struct folio *folio, size_t offset,
 				size_t length)
 {
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 267594ef0b2c..bf84952ebf94 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -45,6 +45,7 @@
 #include <linux/pagevec.h>
 
 #include "ext4.h"
+#include <trace/events/ext4.h>
 
 #define NUM_PREALLOC_POST_READ_CTXS	128
 
@@ -209,7 +210,7 @@ static inline loff_t ext4_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-int ext4_mpage_readpages(struct inode *inode,
+static int ext4_mpage_readpages(struct inode *inode,
 		struct readahead_control *rac, struct folio *folio)
 {
 	struct bio *bio = NULL;
@@ -394,6 +395,34 @@ int ext4_mpage_readpages(struct inode *inode,
 	return 0;
 }
 
+int ext4_read_folio(struct file *file, struct folio *folio)
+{
+	int ret = -EAGAIN;
+	struct inode *inode = folio->mapping->host;
+
+	trace_ext4_read_folio(inode, folio);
+
+	if (ext4_has_inline_data(inode))
+		ret = ext4_readpage_inline(inode, folio);
+
+	if (ret == -EAGAIN)
+		return ext4_mpage_readpages(inode, NULL, folio);
+
+	return ret;
+}
+
+void ext4_readahead(struct readahead_control *rac)
+{
+	struct inode *inode = rac->mapping->host;
+
+	/* If the file has inline data, no need to do readahead. */
+	if (ext4_has_inline_data(inode))
+		return;
+
+	ext4_mpage_readpages(inode, rac, NULL);
+}
+
+
 int __init ext4_init_post_read_processing(void)
 {
 	bio_post_read_ctx_cache = KMEM_CACHE(bio_post_read_ctx, SLAB_RECLAIM_ACCOUNT);
-- 
2.47.3


