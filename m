Return-Path: <linux-fsdevel+bounces-19588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E69D8C78DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 17:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3351F241D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635F14D444;
	Thu, 16 May 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="o7RyCWrg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E9314B971;
	Thu, 16 May 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871746; cv=none; b=Vj/bKM9bDlzi40DJQ4ZPXA2MrMEyH+l1Ryo9HJ5v3glLuLgBlSO+axgsRpaeJWELGHerswE8DkdO1itnW89Uttyq99MZbmngrv1mr3xvQEGEhsvrlVbUxVenTjplJlTSuknyWhyEgNsg/geYI7DWupfuGYCgmCNYeDM5cI9jDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871746; c=relaxed/simple;
	bh=NdRI/Y36TueoklqIJdLfj5Gr6dkrpxBWjR7/vkP2/QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h37pobWFaIDBsh/XEQXIEijOMSpQ5gYNBwghB6d1vT6ZxA9I413pBc9Vc/5TUpmykSz2sqP4uZvgofm2L9Uzp4OmfNNqFzDc9QeUQvPUx7inLJCGp369Vy75RkSHDd3o1dN02SSbp1yZmmS31y7yNmP6VcEG4qjv8BoYm85QJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=o7RyCWrg; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VgCxS6Pcdz9sHh;
	Thu, 16 May 2024 17:02:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715871740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxNAEyW9ggRd+sEfela/enfZjPtD+w15s4sCnmMcAME=;
	b=o7RyCWrgTggNBmoO3IGUfYqLO6BZRxxScT26H5+As2pU3NVo+pQT/GHYEQUIjtpNlNEHJA
	fWDQuVcDQie2arLUzDbZKnj3gUnWiGXphVcTqTb02eXTT2wFEzFmP3ivkCQi//nvQyuQdS
	aizIQkT9OuyBBX6hd1phh5L7w7gpHLbPLRurQVTpr3vxzslPEQB2gIdn87cql+fLA+ZE3+
	+7SN8ru4NNTXE8MkXE2lwCpTQF/HKOlx91tX5Hc1U9TxgQ+hOq4/WYfPzVWwRRFPX53K3m
	PmQEh31fMQpGg3t89QINzdUQ29WDq5GXl+t2RSPkdWK3k4XFZRmHmkZpDi7OkQ==
Date: Thu, 16 May 2024 15:02:06 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, mcgrof@kernel.org,
	akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, gost.dev@samsung.com, hare@suse.de,
	john.g.garry@oracle.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240516150206.d64eezbj3waieef5@quentin>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZkQG7bdFStBLFv3g@casper.infradead.org>
 <ZkQfId5IdKFRigy2@kbusch-mbp>
 <ZkQ0Pj26H81HxQ_4@casper.infradead.org>
 <20240515155943.2uaa23nvddmgtkul@quentin>
 <ZkT46AsZ3WghOArL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkT46AsZ3WghOArL@casper.infradead.org>

On Wed, May 15, 2024 at 07:03:20PM +0100, Matthew Wilcox wrote:
> On Wed, May 15, 2024 at 03:59:43PM +0000, Pankaj Raghav (Samsung) wrote:
> >  static int __init iomap_init(void)
> >  {
> > +       void            *addr = kzalloc(16 * PAGE_SIZE, GFP_KERNEL);
> 
> Don't use XFS coding style outside XFS.
> 
> kzalloc() does not guarantee page alignment much less alignment to
> a folio.  It happens to work today, but that is an implementation
> artefact.
> 
> > +
> > +       if (!addr)
> > +               return -ENOMEM;
> > +
> > +       zero_fsb_folio = virt_to_folio(addr);
> 
> We also don't guarantee that calling kzalloc() gives you a virtual
> address that can be converted to a folio.  You need to allocate a folio
> to be sure that you get a folio.
> 
> Of course, you don't actually need a folio.  You don't need any of the
> folio metadata and can just use raw pages.
> 
> > +       /*
> > +        * The zero folio used is 64k.
> > +        */
> > +       WARN_ON_ONCE(len > (16 * PAGE_SIZE));
> 
> PAGE_SIZE is not necessarily 4KiB.
> 
> > +       bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> > +                                 REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> 
> The point was that we now only need one biovec, not MAX.
> 

Thanks for the comments. I think it all makes sense:

diff --git a/fs/internal.h b/fs/internal.h
index 7ca738904e34..e152b77a77e4 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -35,6 +35,14 @@ static inline void bdev_cache_init(void)
 int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
                get_block_t *get_block, const struct iomap *iomap);
 
+/*
+ * iomap/buffered-io.c
+ */
+
+#define ZERO_FSB_SIZE (65536)
+#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
+extern struct page *zero_fs_block;
+
 /*
  * char_dev.c
  */
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..36d2f7edd310 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -42,6 +42,7 @@ struct iomap_folio_state {
 };
 
 static struct bio_set iomap_ioend_bioset;
+struct page *zero_fs_block;
 
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
                struct iomap_folio_state *ifs)
@@ -1985,8 +1986,13 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
+
 static int __init iomap_init(void)
 {
+       zero_fs_block = alloc_pages(GFP_KERNEL | __GFP_ZERO, ZERO_FSB_ORDER);
+       if (!zero_fs_block)
+               return -ENOMEM;
+
        return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
                           offsetof(struct iomap_ioend, io_bio),
                           BIOSET_NEED_BVECS);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..50c2bca8a347 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -236,17 +236,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
                loff_t pos, unsigned len)
 {
        struct inode *inode = file_inode(dio->iocb->ki_filp);
-       struct page *page = ZERO_PAGE(0);
        struct bio *bio;
 
+       /*
+        * Max block size supported is 64k
+        */
+       WARN_ON_ONCE(len > ZERO_FSB_SIZE);
+
        bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
        fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
                                  GFP_KERNEL);
+
        bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
        bio->bi_private = dio;
        bio->bi_end_io = iomap_dio_bio_end_io;
 
-       __bio_add_page(bio, page, len, 0);
+       __bio_add_page(bio, zero_fs_block, len, 0);
        iomap_dio_submit_bio(iter, dio, bio, pos);
 }


