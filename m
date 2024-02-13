Return-Path: <linux-fsdevel+bounces-11435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3ED853D23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B05BB26053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826F261676;
	Tue, 13 Feb 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="l2Rj7DFF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4260866;
	Tue, 13 Feb 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859661; cv=none; b=W09AgmPCaTpUsNfmjnGFPdbttyRgBA8XbbOOVkXivDQvLag0g+0XzT0N3vrMiQFAgC0H2bUjaYJ3KC6rtyZRUnZZYIjaeBmxQmwd4yCZOgv/EXlsasvhl7LD2wvvNFCaowHsyQGplWU5moZBy++YJn7pJ4NR1ouMJBwxTPWMXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859661; c=relaxed/simple;
	bh=iQss9ct+4twg7GFbDG7JJx8trexhGHAAqudZp8H8iMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSlA9XYLF53UuaTZxmdasRDWINERC5x7DBF1VqwCUf/imrGFydGUSt1RGqACdGIFACUBmtbo2ESsoEbjDje+j6OM9C5IqUSIC2Kf3mRzhuEsrpAviiEBNUbUdVdImyBKj+nZDuPbd7Oeei5Vy5O+D6fJ9i4+TYc5A3V/UYzc+IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=l2Rj7DFF; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TZDtw0hKTz9stm;
	Tue, 13 Feb 2024 22:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707859656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mh3OjUTOfcYW8zRUtE1UxIazXj8XXK2Ld1abdP7LWMU=;
	b=l2Rj7DFF8BtL1ntuFgQ9i5ScpOASIaaFA5ar8kj490Zv3SkIEd9AH/eEM1E78dlbSlGSGQ
	sd+OyvOwurdpsV7420vYWp0WQ1KQyzbmS8dGj7vkBLGr5fdVHdOcHDySp1mvCxGfT5/6Ik
	ja0uxapoErU/J5zC4gAsNQYhmiSoLpxBUyB1RAlJkDRlIjVQoNNVHlsdGwSn0IZXdYPdXn
	zG6U1SzzOdF5Jgsnh1tx2U6CIghm2WterEHaSiWqTcAbXo8U1Z8UzaMxGkEDeTVWfkjN+b
	jnJSAfPoBqpWU4lx6ZYe4Rd7AnBxIGoDkJU+vl8CAFiAoHypUpzqv6IY9/EPJA==
Date: Tue, 13 Feb 2024 22:27:32 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org, 
	kbusch@kernel.org, chandan.babu@oracle.com, p.raghav@samsung.com, 
	linux-kernel@vger.kernel.org, hare@suse.de, willy@infradead.org, linux-mm@kvack.org, 
	david@fromorbit.com
Subject: Re: [RFC v2 10/14] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <5kodxnrvjq5dsjgjfeps6wte774c2sl75bn3fg3hh46q3wkwk5@2tru4htvqmrq>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-11-kernel@pankajraghav.com>
 <20240213163037.GR6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213163037.GR6184@frogsfrogsfrogs>

On Tue, Feb 13, 2024 at 08:30:37AM -0800, Darrick J. Wong wrote:
> On Tue, Feb 13, 2024 at 10:37:09AM +0100, Pankaj Raghav (Samsung) wrote:
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > iomap_dio_zero() will pad a fs block with zeroes if the direct IO size
> > < fs block size. iomap_dio_zero() has an implicit assumption that fs block
> > size < page_size. This is true for most filesystems at the moment.
> > 
> > If the block size > page size, this will send the contents of the page
> > next to zero page(as len > PAGE_SIZE) to the underlying block device,
> > causing FS corruption.
> > 
> > iomap is a generic infrastructure and it should not make any assumptions
> > about the fs block size and the page size of the system.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > ---
> >  fs/iomap/direct-io.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index bcd3f8cf5ea4..04f6c5548136 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -239,14 +239,23 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> >  	struct page *page = ZERO_PAGE(0);
> >  	struct bio *bio;
> >  
> > -	bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> > +	WARN_ON_ONCE(len > (BIO_MAX_VECS * PAGE_SIZE));
> > +
> > +	bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
> > +				  REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
> >  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> >  				  GFP_KERNEL);
> > +
> >  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
> >  	bio->bi_private = dio;
> >  	bio->bi_end_io = iomap_dio_bio_end_io;
> >  
> > -	__bio_add_page(bio, page, len, 0);
> > +	while (len) {
> > +		unsigned int io_len = min_t(unsigned int, len, PAGE_SIZE);
> 
> What was the result of all that discussion about using the PMD-sized
> zero-folio the last time this patch was submitted?  Did that prove to be
> unwieldly, or did it require enough extra surgery to become its own
> series?
> 

It proved a bit unwieldly to me at least as I did not know any straight
forward way to do it at the time. So I thought I will keep this approach
as it is, and add support for the PMD-sized zero folio for later
improvement.

> (The code here looks good to me.)

Thanks!
> 
> --D
> 
> > +
> > +		__bio_add_page(bio, page, io_len, 0);
> > +		len -= io_len;
> > +	}
> >  	iomap_dio_submit_bio(iter, dio, bio, pos);
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> > 

