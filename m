Return-Path: <linux-fsdevel+bounces-12931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6CF868C56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04D51C22330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD481369B0;
	Tue, 27 Feb 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="GMTPJcrf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A291369A4;
	Tue, 27 Feb 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709026411; cv=none; b=pcrgCPezf3N72MM+txGNLL83F/7rp023GMuo7b+uJzGXvbKpD0/V7RrwgYKN3L1W2OcxE3sfKBwOElKfKZPSkIwT0zpto9AAHC9dW7fiKJjvnOI1BoY+yZ76ZJylz8ISksKB3r9sILZbYRG1iXe6Ed6bH0d61jEmRR9tAc7vF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709026411; c=relaxed/simple;
	bh=ihSb31MveA511qLCYqgRAbr0VwITsxdL+t6Pn6z4hzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oag7/HPqWDCCPT9X9XjGfmTe4lFScqsvg1/RYGnuvav0skgRFPMaypq5EI/XtXZpYPxbk00+5p83DYltmtkXqvl5+baGzynrmdmmDcQ9x/wE4oAAZ0JwoRJOlySGZ5cHFTWBh/AqrP4QwjivoMdJzvnY2mU1mLAjLRVion0hw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=GMTPJcrf; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TkXNP5Jv6z9smD;
	Tue, 27 Feb 2024 10:33:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1709026405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50P6BtmSu6TZY3fumWs04okJUU6PUrVTmELjj8/MjQM=;
	b=GMTPJcrfqTMcvvlrwwI/f3bHzERGH6KsPCu9OUPYazsskmeLvpmeO2lKMnMCcfDSSOAL/R
	dvmZqZmKX3dpt0/QjiDz34yjHWSWM4GA9r3AYl9RpAD3SGErX8Nxkx2bkbWZTV5mIHcmE8
	5gXSdvlqZLUCp3JKTKITpHBav6Ci6w6NNuL96JeCu8vQUDzSLs0RN533WXRkPxFnEZFlBr
	6spw7PuDKhZl5kqWFsLeXR4kLcSs98VHR4rxMlaeTg/OpZvqxllaR/OfDKv5fiD59OKo60
	a6E2UIlHVi6c4Wy5PW8/I/+BcTT4z41Myx2eckvXAhAtwQeMCWJk3mF0tQzk0w==
Date: Tue, 27 Feb 2024 10:33:21 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, david@fromorbit.com, chandan.babu@oracle.com, 
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com, hare@suse.de, 
	djwong@kernel.org, gost.dev@samsung.com, linux-mm@kvack.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 10/13] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <3pqmgrlewo6ctcwakdvbvjqixac5en6irlipe5aiz6vkylfyni@2luhrs36ke5r>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-11-kernel@pankajraghav.com>
 <ZdzRU0sMqFYlNC01@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdzRU0sMqFYlNC01@casper.infradead.org>

> I thought we were going to use the huge_zero_page for this?

Yes. We discussed that huge_zero_page might fail, so we concluded that
we needed an api that can return arbitrary folio order that will not
fail:
```
your point about it possibly failing is correct.  so i think we need an
api which definitely returns a folio, but it might be of arbitrary
order.
```

I couldn't come up with implementing your latter suggestion, so I
informed darrick that let's use this patch for now, and add the
arbitrary folio order with zero as a later enhancement.

If we want to use mm_huge_zero_page, then this should work:

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 04f6c5548136..b6a3f52f48da 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -237,10 +237,17 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 {
        struct inode *inode = file_inode(dio->iocb->ki_filp);
        struct page *page = ZERO_PAGE(0);
+       struct folio *folio = NULL;
        struct bio *bio;
 
        WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
 
+       if (len > PAGE_SIZE) {
+               page = mm_get_huge_zero_page(current->mm);
+               if (!page)
+                       page = ZERO_PAGE(0);
+       }
+
        bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
                                  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
        fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
@@ -249,13 +256,15 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
        bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
        bio->bi_private = dio;
        bio->bi_end_io = iomap_dio_bio_end_io;
+       folio = page_folio(page);
 
        while (len) {
-               unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
+               size_t size = min(len, folio_size(folio));
 
-               __bio_add_page(bio, page, io_len, 0);
-               len -= io_len;
+               bio_add_folio_nofail(bio, folio, size, 0);
+               len -= size;
        }
+
        iomap_dio_submit_bio(iter, dio, bio, pos);
 }

Let me know if we should go for this or let's keep the original patch
and add a ZERO_FOLIO_ORDER API that will not fail and use it as a later
enhancement.

