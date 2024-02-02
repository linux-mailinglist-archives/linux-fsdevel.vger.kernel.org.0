Return-Path: <linux-fsdevel+bounces-10024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E94D8471C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB7CB27338
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF5D144631;
	Fri,  2 Feb 2024 14:19:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8041C13E20B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883558; cv=none; b=Uo7DXkt/SO2141xpPXNc1DEKMm4uWFf47ITDzmrtSgSf8tD4t/xzbhBQMpkeFkQnmiAApaiUPk75jw+e7iyk1w+6EMIgz+W0a4MJDqj9CgS+exBjGintoEFfMeTFsDO64EY3ZKSholNhse3BtFXPksP66+LyDT6wJSKZ+bWrL2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883558; c=relaxed/simple;
	bh=WaF05etmv6xtJTE48JVQIk8cC0oCi0ltt4j8nJKOOE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH5H8O9qI2QWzsOQ/x0j6iJyJkW/KaMPKJTSesA+hoHltoojBvA3CbFJT203LrCJAqpsetfEmfdjfh0zq7ahJgGCroAePURLv88YFG94m2egPMyQJr1CHLKIIUUAtONy8cjCHJRECtGTzFXWJzOdmLoOhmNmrAX5vumfE6WzPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a4516ec46so8171721cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 06:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706883554; x=1707488354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVCU/QdR6yOLyX27bti1riO+pE3pl8L1u9F5qqx6Qkg=;
        b=jc/1A/807aWzYjKxJJlk+48Arh1o31IOViOoS/rEhks3ArsGFcJ67iVve+xUmgHY2t
         Q4nbZK7aP4kqHXhz1vBFfcVHoxSUI76y+ZO+u5aAarVEQDimsIq4sI6TSObG7M5IxA+s
         IMabGuhPdcYjkED1KonhXujplNTU+G2SXI2cW45iozGw7DozJctHHpWAZrydUI0dDfdO
         XesTONMNBrhlbqa+0/I9FSl4jDWqjIEBoiRzcryyZzm/Xb++sMcMstO5DLmhRRW3O8TP
         Eyjmgf2ASTrwR5m6BMY26srFVlAoibreRUr3/XWm985T5Nim6/3Mv41xBoaVaL3iLlid
         mgOg==
X-Gm-Message-State: AOJu0YyNJ5Gx0qq3f4a6Rc4zw/ZeKAkreCnwq9jE+MM4/aTTFvKwM+32
	JkmWDOg7+wRGCfbcw7NGKH1Gv6kawigFotcsGBEaB81ZXtcYcsAFgxMvLxwhug==
X-Google-Smtp-Source: AGHT+IEhQHanL60HiGDGS5wktHODuGtgnxpWhUHgFtWvSjOpTOhppcIFgAcuMhigP/FHcai4EZhJqw==
X-Received: by 2002:a05:622a:1748:b0:42b:f6a6:4058 with SMTP id l8-20020a05622a174800b0042bf6a64058mr3632398qtk.15.1706883554394;
        Fri, 02 Feb 2024 06:19:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW5ywsfSWxoOXCneHQ193arCv1HiGofCXP9MquEQ/empUbTJttjRivFKD+KnwEX2OLj+A5f1aEr9yLYUa5qZ8AjkA8ZvXZpTKFJQS3dsrO1C30IU+HPlrVB1cjjZmcvyv/AMHE3CvAY/rEYfQBU7wZBv1M8VW+VuJA2ex8qh2Tootn+uaTgnTyf0ZjdSZSztAEe2WvzWJIu6J3TanTtKlobuVMRO8kzofHOpoPGwdv+hSk6SxHREzEqsgUmJn08eE/wOkPXdPwGzSBGaxYiBtNU3APPVYeEV5DsX3JXi59bCFDMOvWJbbOXwf5/2vmHmxX9Eg6VkKsXzntKtE6YpfvxvcTKRzq8ah30mL/Vs572aA==
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id ey22-20020a05622a4c1600b0042bed7dc558sm860739qtb.6.2024.02.02.06.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:19:14 -0800 (PST)
Date: Fri, 2 Feb 2024 09:19:13 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Don Dutile <ddutile@redhat.com>, Rafael Aquini <raquini@redhat.com>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: mm/madvise: set ra_pages as device max request size during
 ADV_POPULATE_READ
Message-ID: <Zbz54MUZ2kZLTQQx@redhat.com>
References: <20240202022029.1903629-1-ming.lei@redhat.com>
 <Zbxy30POPE8rN_YN@redhat.com>
 <ZbzJZji95a1qmhcj@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbzJZji95a1qmhcj@fedora>

On Fri, Feb 02 2024 at  5:52P -0500,
Ming Lei <ming.lei@redhat.com> wrote:

> On Thu, Feb 01, 2024 at 11:43:11PM -0500, Mike Snitzer wrote:
> > On Thu, Feb 01 2024 at  9:20P -0500,
> > Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > > madvise(MADV_POPULATE_READ) tries to populate all page tables in the
> > > specific range, so it is usually sequential IO if VMA is backed by
> > > file.
> > > 
> > > Set ra_pages as device max request size for the involved readahead in
> > > the ADV_POPULATE_READ, this way reduces latency of madvise(MADV_POPULATE_READ)
> > > to 1/10 when running madvise(MADV_POPULATE_READ) over one 1GB file with
> > > usual(default) 128KB of read_ahead_kb.
> > > 
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Don Dutile <ddutile@redhat.com>
> > > Cc: Rafael Aquini <raquini@redhat.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> > > Cc: Mike Snitzer <snitzer@kernel.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  mm/madvise.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 51 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index 912155a94ed5..db5452c8abdd 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -900,6 +900,37 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
> > >  		return -EINVAL;
> > >  }
> > >  
> > > +static void madvise_restore_ra_win(struct file **file, unsigned int ra_pages)
> > > +{
> > > +	if (*file) {
> > > +		struct file *f = *file;
> > > +
> > > +		f->f_ra.ra_pages = ra_pages;
> > > +		fput(f);
> > > +		*file = NULL;
> > > +	}
> > > +}
> > > +
> > > +static struct file *madvise_override_ra_win(struct file *f,
> > > +		unsigned long start, unsigned long end,
> > > +		unsigned int *old_ra_pages)
> > > +{
> > > +	unsigned int io_pages;
> > > +
> > > +	if (!f || !f->f_mapping || !f->f_mapping->host)
> > > +		return NULL;
> > > +
> > > +	io_pages = inode_to_bdi(f->f_mapping->host)->io_pages;
> > > +	if (((end - start) >> PAGE_SHIFT) < io_pages)
> > > +		return NULL;
> > > +
> > > +	f = get_file(f);
> > > +	*old_ra_pages = f->f_ra.ra_pages;
> > > +	f->f_ra.ra_pages = io_pages;
> > > +
> > > +	return f;
> > > +}
> > > +
> > 
> > Does this override imply that madvise_populate resorts to calling
> > filemap_fault() and here you're just arming it to use the larger
> > ->io_pages for the duration of all associated faulting?
> 
> Yes.
> 
> > 
> > Wouldn't it be better to avoid faulting and build up larger page
> 
> How can we avoid the fault handling? which is needed to build VA->PA mapping.

I was wondering if it made sense to add fadvise_populate -- but given
my lack of experience with MM I then get handwavvy quick -- I have
more work ahead to round out my MM understanding so that I'm more
informed.
 
> > vectors that get sent down to the block layer in one go and let the
> 
> filemap_fault() already tries to allocate folio in big size(max order
> is MAX_PAGECACHE_ORDER), see page_cache_ra_order() and ra_alloc_folio().
> 
> > block layer split using the device's limits? (like happens with
> > force_page_cache_ra)
> 
> Here filemap code won't deal with block directly because there is VFS &
> FS and io mapping is required, and it just calls aops->readahead() or
> aops->read_folio(), but block plug & readahead_control are applied for
> handling everything in batch.
> 
> > 
> > I'm concerned that madvise_populate isn't so efficient with filemap
> 
> That is why this patch increases readahead window, then
> madvise_populate() performance can be improved by X10 in big file-backed
> popluate read.

Right, as you know I've tested your patch, the larger readahead window
certainly did provide the much more desirable performance.  I'll reply
to your v2 (with reduced negative checks) with my Reviewed-by and
Tested-by.

I was just wondering if there an opportunity to plumb in more a
specific (and potentially better) fadvise_populate for dealing with
file backed pages.

> > due to excessive faulting (*BUT* I haven't traced to know, I'm just
> > inferring that is why twiddling f->f_ra.ra_pages helps improve
> > madvise_populate by having it issue larger IO. Apologies if I'm way
> > off base)
> 
> As mentioned, fault handling can't be avoided, but we can improve
> involved readahead IO perf.

Thanks, and sorry for asking such a naive question (put more pressure
on you to educate than I should have).

Mike

