Return-Path: <linux-fsdevel+bounces-19536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51108C6A1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226861C2131D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 16:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32391156245;
	Wed, 15 May 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="t/rLh24W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7B155723;
	Wed, 15 May 2024 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788811; cv=none; b=ptsoebGvfYnxP7mAi0paQA7f3E9ZhgPmL3m5SroC/YDMOrgoXQqTVkqOaZW9qP7b6pZUE1P5oQRTKa8cC2RI/P+bHHrcQJIQtOkxp51KSgnQHIbnaLeflVYhqi8R7lSCtsbOBhrU3A2vtALIFRVyPsiIoiyAxFev8PIimMLwZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788811; c=relaxed/simple;
	bh=2K2Ha1fZlj6ET1LRckvObJr1sy7mYKHUgUvkAgVBRj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIyZGJuNkoQln8TDsb3vZyxmWFt+wkEkcb2uS3S2wOSC56xeobcnMmHwCcwNUecfu6nYmJCVkHNRSko+fCBJ8rmv0jBnWgucETF1+XK6lsXzSXvw3kiddSn06QhuC4QQYIsXB9CiCAdMFL6OKd9/ATpE0VuMxyoBHO0W8v2NSEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=t/rLh24W; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VfdGP6QFYz9sSl;
	Wed, 15 May 2024 17:59:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715788797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCQ5EwlnBaVjjGBU3qX9WnT4s0ilKb0cfBcFSyoSM6k=;
	b=t/rLh24W0RY6M4EoaSW/hUED3I3C6M87G+4uVJfnfbFTkkFszL2pKyCJqCbwdytSw5Ze1m
	Q5dhksBxEbN4R6uRkpzlg5IX+Y4p85aSf0clO8MyulvvYL/71VC5gyC8H86cb/0aDZGZaz
	K2des+IBCFa3WPHGm/BP1yMvJgcru8EDx2cvVhPZ12AEvJiuWk0wUq8R9UurxmcsHCX5RH
	vZz3O8OLvoB1QKhzETWlTv2I+jYJHhoT59qEq5Xly2fLyITn8dtxOC+0+4yyTMDWPMVm7f
	J+hGeREPyQ5bOXxlPwFpvQhwamx/qZAX173rWmCV1wdVJnZ4e0xmBTDMK/Fx5w==
Date: Wed, 15 May 2024 15:59:43 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>, david@fromorbit.com,
	djwong@kernel.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, mcgrof@kernel.org,
	akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, gost.dev@samsung.com, hare@suse.de,
	john.g.garry@oracle.com, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <20240515155943.2uaa23nvddmgtkul@quentin>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZkQG7bdFStBLFv3g@casper.infradead.org>
 <ZkQfId5IdKFRigy2@kbusch-mbp>
 <ZkQ0Pj26H81HxQ_4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkQ0Pj26H81HxQ_4@casper.infradead.org>
X-Rspamd-Queue-Id: 4VfdGP6QFYz9sSl

> so unless submit_bio() can handle the fallback to "create a new bio
> full of zeroes and resubmit it to the device" if the original fails,
> we're a little mismatched.  I'm not really familiar with either part of
> this code, so I don't have much in the way of bright ideas.  Perhaps
> we go back to the "allocate a large folio at filesystem mount" plan.

So one thing that became clear after yesterday's discussion was to
**not** use a PMD page for sub block zeroing as in some architectures
we will be using a lot of memory (such as ARM) to zero out a 64k FS block.

So Chinner proposed the idea of using iomap_init function to alloc
large zero folio that could be used in iomap_dio_zero().

The general agreement was 64k large folio is enough for now. We could
always increase it and optimize it in the future when required.

This is a rough prototype of what it might look like:

diff --git a/fs/internal.h b/fs/internal.h
index 7ca738904e34..dad5734b2f75 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -35,6 +35,12 @@ static inline void bdev_cache_init(void)
 int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
                get_block_t *get_block, const struct iomap *iomap);
 
+/*
+ * iomap/buffered-io.c
+ */
+
+extern struct folio *zero_fsb_folio;
+
 /*
  * char_dev.c
  */
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..48235765df7a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -42,6 +42,7 @@ struct iomap_folio_state {
 };
 
 static struct bio_set iomap_ioend_bioset;
+struct folio *zero_fsb_folio;
 
 static inline bool ifs_is_fully_uptodate(struct folio *folio,
                struct iomap_folio_state *ifs)
@@ -1985,8 +1986,15 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
+
 static int __init iomap_init(void)
 {
+       void            *addr = kzalloc(16 * PAGE_SIZE, GFP_KERNEL);
+
+       if (!addr)
+               return -ENOMEM;
+
+       zero_fsb_folio = virt_to_folio(addr);
        return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
                           offsetof(struct iomap_ioend, io_bio),
                           BIOSET_NEED_BVECS);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..59a65c3ccf13 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -236,17 +236,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
                loff_t pos, unsigned len)
 {
        struct inode *inode = file_inode(dio->iocb->ki_filp);
-       struct page *page = ZERO_PAGE(0);
        struct bio *bio;
 
-       bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
+       /*
+        * The zero folio used is 64k.
+        */
+       WARN_ON_ONCE(len > (16 * PAGE_SIZE));
+
+       bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
+                                 REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
        fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
                                  GFP_KERNEL);
+
        bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
        bio->bi_private = dio;
        bio->bi_end_io = iomap_dio_bio_end_io;
 
-       __bio_add_page(bio, page, len, 0);
+       bio_add_folio_nofail(bio, zero_fsb_folio, len, 0);
        iomap_dio_submit_bio(iter, dio, bio, pos);
 }


