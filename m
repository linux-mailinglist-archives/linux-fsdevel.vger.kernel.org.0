Return-Path: <linux-fsdevel+bounces-23813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662BB933AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969B01C20930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525417E8F5;
	Wed, 17 Jul 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Dlo4sxwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55FF315BA;
	Wed, 17 Jul 2024 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210554; cv=none; b=XgihtuGL1S2Qjz/0XNj82wv9xscfvB6VEhujIzjzg8M5fMRXydxKgh9ymFGia76fno/9uPVRXAmEO9OzLZk8N6MgOngTCqA9dz8dyqU1jSeLCiLskJ996BU344EMM1ced8wruZXLYNfi3qhTAjO7IkRdWPpGMZbZGuZaPHxstnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210554; c=relaxed/simple;
	bh=wtpFfXg5Ih+huG17ZouYCcg6wA6oZZeWVE5iv6Q/A6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAaHGnoNXD8tvvqOWONFdXviiH+mEL6RXUlAfFuw1qqTtI378cwtF2a4Hn5e/2Abrwa4lDsUhh8jqtEsouMsVspdr6gChRr+IZWViOdofuDHUagQjEDhRBTOOnwqaNbeBcy//wRmZkwAHah+Sf9pAoakx8QpIo5MoVeYLw+1+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Dlo4sxwn; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WPBLn4xyMz9sbt;
	Wed, 17 Jul 2024 12:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721210545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQLwtMiKThXyfOPp8jc/dtC59kYpr5zUV9WlubZ4kZM=;
	b=Dlo4sxwnsrXcYrRd8hBQHZv4Bc3AnO/xq1e/zndQbW4aEkYWYOzqAun7Eo/A9x2pra12bH
	21EOkvFljmpzmsAl+7MEpx/RUx96v2tqgp0Ied/a5J7DHSQpsOOvgaB5XLjexMuI6opnzZ
	qBzsPXzCMR4Pu93beFjHlZD4RdvaRSKkwGpB7fW1M8ZvlkSX4GjQswsam0XQTBOUuWqxjl
	gMWvtY7gqD1M6m0hWsbQX4/f+VNl/ks9JcdpylrITjnUdTmtwkIwxVdN/eojXe0Q50dlMN
	X+3GpMcJ7xLQ4tciFbseeqfWxE0KKIDyJZ6+vW7flWX8YWXOlzDHu6P1S8Gkcw==
Date: Wed, 17 Jul 2024 10:02:19 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, david@fromorbit.com,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 10/10] xfs: enable block size larger than page size
 support
Message-ID: <20240717100219.ntadlclud6eabrso@quentin>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-11-kernel@pankajraghav.com>
 <ZpaRwdi3Vo3qutyk@casper.infradead.org>
 <20240716174016.GZ1998502@frogsfrogsfrogs>
 <ZpayAGWQdw1rbCng@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpayAGWQdw1rbCng@casper.infradead.org>
X-Rspamd-Queue-Id: 4WPBLn4xyMz9sbt

On Tue, Jul 16, 2024 at 06:46:40PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 16, 2024 at 10:40:16AM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 16, 2024 at 04:29:05PM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 15, 2024 at 11:44:57AM +0200, Pankaj Raghav (Samsung) wrote:
> > > > +++ b/fs/xfs/xfs_super.c
> > > > @@ -1638,16 +1638,30 @@ xfs_fs_fill_super(
> > > >  		goto out_free_sb;
> > > >  	}
> > > >  
> > > > -	/*
> > > > -	 * Until this is fixed only page-sized or smaller data blocks work.
> > > > -	 */
> > > >  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > > > -		xfs_warn(mp,
> > > > -		"File system with blocksize %d bytes. "
> > > > -		"Only pagesize (%ld) or less will currently work.",
> > > > +		size_t max_folio_size = mapping_max_folio_size_supported();
> > > > +
> > > > +		if (!xfs_has_crc(mp)) {
> > > > +			xfs_warn(mp,
> > > > +"V4 Filesystem with blocksize %d bytes. Only pagesize (%ld) or less is supported.",
> > > >  				mp->m_sb.sb_blocksize, PAGE_SIZE);
> > > > -		error = -ENOSYS;
> > > > -		goto out_free_sb;
> > > > +			error = -ENOSYS;
> > > > +			goto out_free_sb;
> > > > +		}
> > > > +
> > > > +		if (mp->m_sb.sb_blocksize > max_folio_size) {
> > > > +			xfs_warn(mp,
> > > > +"block size (%u bytes) not supported; maximum folio size supported in "\
> > > > +"the page cache is (%ld bytes). Check MAX_PAGECACHE_ORDER (%d)",
> > > > +			mp->m_sb.sb_blocksize, max_folio_size,
> > > > +			MAX_PAGECACHE_ORDER);
> > > 
> > > Again, too much message.  Way too much.  We shouldn't even allow block
> > > devices to be created if their block size is larger than the max supported
> > > by the page cache.
> > 
> > Filesystem blocksize != block device blocksize.  xfs still needs this
> > check because one can xfs_copy a 64k-fsblock xfs to a hdd with 512b
> > sectors and try to mount that on x86.
> > 
> > Assuming there /is/ some fs that allows 1G blocksize, you'd then really
> > want a mount check that would prevent you from mounting that.
> 
> Absolutely, we need to have an fs blocksize check in the fs (if only
> because fs fuzzers will put random values in fields and expect the system
> to not crash).  But that should have nothing to do with page cache size.

Ok, now I am not sure if I completely misunderstood the previous
comments. 

One of the comments you gave in the previous series is this[1]:

```
> What are callers supposed to do with an error? In the case of
> setting up a newly allocated inode in XFS, the error would be
> returned in the middle of a transaction and so this failure would
> result in a filesystem shutdown.

I suggest you handle it better than this.  If the device is asking for a
blocksize > PMD_SIZE, you should fail to mount it.  If the device is
asking for a blocksize > PAGE_SIZE and CONFIG_TRANSPARENT_HUGEPAGE is
not set, you should also decline to mount the filesystem.
```

That is exactly what we are doing here. We check for what can page cache
support and decline to mount if the max order supported is less than the
block size of the filesystem.

Maybe we can trim the the error message to just:

"block size (%u bytes) not supported; Only block size (%ld) or less is supported "\
					mp->m_sb.sb_blocksize,
					max_folio_size);

Let me know what you think.

[1]https://lore.kernel.org/linux-fsdevel/Zoc2rCPC5thSIuoR@casper.infradead.org/

