Return-Path: <linux-fsdevel+bounces-26233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751829564CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32070281381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAE41581E0;
	Mon, 19 Aug 2024 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Kiv6Zvc3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A93199B9;
	Mon, 19 Aug 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053082; cv=none; b=L7hyuEP5N9JGKRplCNKfEJYNQ7JK9URVuhP89i/EUSimvKBJ88AKTDJpfbNEjDyCV/bitLWp1fZPYdyaq//IoTJrxHpISvETTh9NSeWNJz0yXwVD3xzKXe7uE++Sd0ip0dKtPQsMq/mbo722cMk/UaD/BgjU33RSp7Z7/87nZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053082; c=relaxed/simple;
	bh=a/FGlat47ime/nwybgnEJP+svbaKuPXpSelvJuR8a5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkwFsTcdapuhqELn5uvIol4zza7JWFY05jrWTuKSx3wKKoQZAy28KIS4Mvgu7ufCZ5Rk7oQuIVQr9TZj+uHd+fuI8hxp2Fy2YFVQe4dkmimpcr15k8UJ5KvkQ3XTzCecPpPQf1rBD3nUxyo6dMebzNzD1TT+tYNUFAHhjurIysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Kiv6Zvc3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WnPZh6dx0z9sS4;
	Mon, 19 Aug 2024 09:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724053069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJkwHXhW1pyUg2A3OtTuCVYWWX/pQvICQgZce5b09dI=;
	b=Kiv6Zvc3GH4pHILeeyyIsuen6YNQt8fsJ6DlA2KW8qCldQSZ/Oml6KOpFQbYYIbxWxFksm
	duoxHAULNvQYGSb2SCwhpjvnXUdjuNdrfjqkWX9KGnAv3xPe0soOlgGTzTtywObrk5YMBV
	en1XXx1fAiod/oTLbBUGbBxBYQf+ZAxWszA25fY7YWlIkStgdhI/TjlY1hjPLGfT5NYde8
	JcYjjA/127+QoklIaTOnlZc5YkwtYDmH+hcx+dDmJzjtdB1kTcNpBu3d5Ek/LwOSSCipgp
	+N6jPZ1cc5030AVDWsZW9jrElTzk3FzsYTHYC19Rv8+8of/tpNoVQj7p8/JqjQ==
Date: Mon, 19 Aug 2024 07:37:42 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: David Howells <dhowells@redhat.com>, brauner@kernel.org,
	akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Message-ID: <20240819073742.uwrx6ldk6j3wde5j@quentin>
References: <20240818165124.7jrop5sgtv5pjd3g@quentin>
 <20240815090849.972355-1-kernel@pankajraghav.com>
 <2924797.1723836663@warthog.procyon.org.uk>
 <3141777.1724012176@warthog.procyon.org.uk>
 <df26beed-97c7-44e4-b380-2260b8331ea9@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df26beed-97c7-44e4-b380-2260b8331ea9@suse.de>
X-Rspamd-Queue-Id: 4WnPZh6dx0z9sS4

On Mon, Aug 19, 2024 at 09:24:11AM +0200, Hannes Reinecke wrote:
> On 8/18/24 22:16, David Howells wrote:
> > Pankaj Raghav (Samsung) <kernel@pankajraghav.com> wrote:
> > 
> > > I am no expert in network filesystems but are you sure there are no
> > > PAGE_SIZE assumption when manipulating folios from the page cache in
> > > AFS?
> > 
> > Note that I've removed the knowledge of the pagecache from 9p, afs and cifs to
> > netfslib and intend to do the same to ceph.  The client filesystems just
> > provide read and write ops to netfslib and netfslib uses those to do ordinary
> > buffered I/O, unbuffered I/O (selectable by mount option on some filesystems)
> > and DIO.
> > 
> > That said, I'm not sure that I haven't made some PAGE_SIZE assumptions.  I
> > don't *think* I have since netfslib is fully multipage folio capable, but I
> > can't guarantee it.
> > 
> I guess you did:
> 
> static int afs_fill_super(struct super_block *sb, struct afs_fs_context
> *ctx)
> {
>         struct afs_super_info *as = AFS_FS_S(sb);
>         struct inode *inode = NULL;
>         int ret;
> 
>         _enter("");
> 
>         /* fill in the superblock */
>         sb->s_blocksize         = PAGE_SIZE;
>         sb->s_blocksize_bits    = PAGE_SHIFT;
>         sb->s_maxbytes          = MAX_LFS_FILESIZE;
>         sb->s_magic             = AFS_FS_MAGIC;
>         sb->s_op                = &afs_super_ops;
> 
> IE you essentially nail AFS to use PAGE_SIZE.
> Not sure how you would tell AFS to use a different block size;
> maybe a mount option?

I saw this as well, but I didn't see this variable being used anywhere.
Probably this has no meaning in a network-based FSs?

> And there are several other places which will need to be modified;
> eg afs_mntpt_set_params() is trying to read from a page which
> won't fly with large blocks (converted to read_full_folio()?),
> and, of course, the infamous AFS_DIR_BLOCKS_PER_PAGE which will
> overflow for large blocks.

But the min folio order is set only for AFS_FTYPE_FILE and not
for AFS_FTYPE_DIR.

> 
> So some work is required, but everything looks doable.
> Maybe I can find some time until LPC.
> 
> > Mostly this was just a note to you that there might be an issue with your code
> > - but I haven't investigated it yet and it could well be in my code.
> > 
> Hmm. I'd rather fix the obvious places in afs first; just do a quick
> grep for 'PAGE_', that'll give you a good impression of places to look at.
> 
Agree.

> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

