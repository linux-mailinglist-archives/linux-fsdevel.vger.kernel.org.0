Return-Path: <linux-fsdevel+bounces-21396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962DA90380C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177C71F248DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DD176FC6;
	Tue, 11 Jun 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="d95O85Gn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99BA17623B;
	Tue, 11 Jun 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098914; cv=none; b=E/aCZCoSkAAvQBpcSpYPbSduT3UA9DqGw4CVpWAkcii/QU8lFqX6cGpl7D/9gb+Jp+K+Im4YpJ1YvPVqMeuGHTnXH+A9WL/O0iB1VbW2eJ3VzUVaPqtk4o9Mvwakh2pEJmkZZUr8fdNHdKB/LBkU5syr2sFi6Lwclbq1rOsNnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098914; c=relaxed/simple;
	bh=37YAOyLbzHAe/CTu+jh14G55K4UoZ2Y4wMYFT0xQ7uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqF6AEQusZnFDivrRx01G+ppY77D9c5tGwJ6xJkwhiNcvT9YCn0Gl2BX75p1ewHS1jHXssci0mJ9e7PubEBvKwwANBrQ6Lmh7WExtGzRGpS5RNDf8Ekpz9dcjBTZi9IRFYevJEd04CyHmBcZzvuGhA/Z0EMXp7FmMKSEyiwED5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=d95O85Gn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vz3bV1zx3z9sGf;
	Tue, 11 Jun 2024 11:41:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1718098902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zbkiOeCEyPQu0nf19vXRe22PR52sb7jygcpNN/dtAno=;
	b=d95O85GnokMrBOReY4l/P1SXMB5K0c089lZGv3kW963gYYVhEPxc4qUr4cnBcUibeImrTy
	4dmvTMoKr96fPVR6lU6b6nEdupU/yE88lTZfIzJzUl0kK60oWw5MT0S6p/oUUeLAMLHnZx
	eXOvUop11JoBAKgsWMEX+mqJoneMBs5tQZFWYOtaSQyntZUr51DFhjmdXkAsXENbkjtl3Z
	ZbZQqEWx1tI9pKSLYFEYpmVhuLq1/+WqqPQeMkK/kM/1VhDgQKspLucK1INMEIl3i2cnE7
	5GIouw9U+4n5+sxPh6Iv1SvVFrSCMmyZWL04TVpYPrcp3d3ieFeoS2vNHcYgPg==
Date: Tue, 11 Jun 2024 09:41:37 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: John Garry <john.g.garry@oracle.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
	mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com
Subject: Re: [PATCH v7 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240611094137.vxuhldj4b3qslsdj@quentin>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-8-kernel@pankajraghav.com>
 <4c6e092d-5580-42c8-9932-b42995e914be@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6e092d-5580-42c8-9932-b42995e914be@oracle.com>

> > index 49938419fcc7..9f791db473e4 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1990,6 +1990,12 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
> >   static int __init iomap_init(void)
> >   {
> > +	int ret;
> > +
> > +	ret = iomap_dio_init();
> > +	if (ret)
> > +		return ret;
> > +
> >   	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
> >   			   offsetof(struct iomap_ioend, io_bio),
> >   			   BIOSET_NEED_BVECS);
> 
> I suppose that it does not matter that zero_fs_block is leaked if this fails
> (or is it even leaked?), as I don't think that failing that bioset_init()
> call is handled at all.

If bioset_init fails, then we have even more problems than just a leaked
64k memory? ;)

Do you have something like this in mind?

diff --git a/fs/internal.h b/fs/internal.h
index 30217f0ff4c6..def96c7ed9ea 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -39,6 +39,7 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
  * iomap/direct-io.c
  */
 int iomap_dio_init(void);
+void iomap_dio_exit(void);
 
 /*
  * char_dev.c
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9f791db473e4..8d8b9e62201f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1994,10 +1994,16 @@ static int __init iomap_init(void)
 
        ret = iomap_dio_init();
        if (ret)
-               return ret;
+               goto out;
 
-       return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+       ret = bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
                           offsetof(struct iomap_ioend, io_bio),
                           BIOSET_NEED_BVECS);
+       if (!ret)
+               goto out;
+
+       iomap_dio_exit();
+out:
+       return ret;
 }
 fs_initcall(iomap_init);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b95600b254a3..f4c9445ca50d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -69,6 +69,12 @@ int iomap_dio_init(void)
        return 0;
 }
 
+void iomap_dio_exit(void)
+{
+       __free_pages(zero_fs_block, ZERO_FSB_ORDER);
+
+}
+
 static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
                struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {

> 
> > +
> >   static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
> >   		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
> >   {
> > @@ -236,17 +253,22 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> >   		loff_t pos, unsigned len)
> >   {
> >   	struct inode *inode = file_inode(dio->iocb->ki_filp);
> > -	struct page *page = ZERO_PAGE(0);
> >   	struct bio *bio;
> > +	/*
> > +	 * Max block size supported is 64k
> > +	 */
> > +	WARN_ON_ONCE(len > ZERO_FSB_SIZE);
> 
> JFYI, As mentioned in https://lore.kernel.org/linux-xfs/20240429174746.2132161-1-john.g.garry@oracle.com/T/#m5354e2b2531a5552a8b8acd4a95342ed4d7500f2,
> we would like to support an arbitrary size. Maybe I will need to loop for
> zeroing sizes > 64K.

The initial patches were looping with a ZERO_PAGE(0), but the initial
feedback was to use a huge zero page. But when I discussed that at LSF,
the people thought we will be using a lot of memory for sub-block
memory, especially on architectures with 64k base page size.

So for now a good tradeoff between memory usage and efficiency was to
use a 64k buffer as that is the maximum FSB we support.[1]

IIUC, you will be using this function also to zero out the extent and
not just a FSB?

I think we could resort to looping until we have a way to request
arbitrary zero folios without having to allocate at it in
iomap_dio_alloc_bio() for every IO.

[1] https://lore.kernel.org/linux-xfs/20240529134509.120826-8-kernel@pankajraghav.com/

--
Pankaj

