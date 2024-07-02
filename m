Return-Path: <linux-fsdevel+bounces-22966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEAB92446E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2024E1C21B83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D71BE241;
	Tue,  2 Jul 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="eayMpLs3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661B15218A;
	Tue,  2 Jul 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940227; cv=none; b=IY7rBRGssnEHH1zdV1X0a1hvEfw2LjaYNaVGq5lCh0pr2RUAocQ3rzv3DE0G6x4VoKKxaX+FPJmbeWs518nO98EODHBy0mrPmGriOR9DTf1h4D6Rv7wFUz0AQ3yo6MRBGOgNJtd8zHs777Q9TG+em098RiR+sR+Ckpzq6TQxdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940227; c=relaxed/simple;
	bh=8RGz1J85NAvvoYDxp27n3BmZiz19OrcrON1hQUubgrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkOldYzHh+41mFdXRO980I6I1M0d54XvTmPCyKVavu+d7XN7I500ZJy+Xu1BLe+VqrfkEAqBYB+Kv+Ee6JJx94MeSnTR4+JZkGKjBD5BE6zn2GceXTYxEZlS9MBqhOCBGRPqXykZy5YlNOOVSHACIH7e6G5xNipYLsV2kQFT6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=eayMpLs3; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WD8YT4Cmhz9sTd;
	Tue,  2 Jul 2024 19:10:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1719940221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7S8VUQYyvA/hYjxf+VcnjpFycomG4Q9npc7KT3Na+A=;
	b=eayMpLs3XwLuC/DdNErQ6ZCv5mfKT5+W0WH+14922V/+zVlk7DAIc5Qhilq6qnJhn3vzpV
	Per+4UR5bylBDnITjTpBuZxRtlYpRhw5AQeljJpeHHodVSalpAu52j5syGpjBz5zOBZ9yx
	zkdq15e9ib2r3erwIovYKrQ5nOP4WpcDHMU8cRaMtLfcHbTZRhNuO/X86KVi2sftEEjYfU
	MuUTYP7dwCIyN6raWrXNI5Q3IT+Ma0hzhttMFteYHQwXEC7z9Q8EXfgB/JuB8Nwhx1EawL
	mCOf4CtVW/gYrv6XnjrKRCMiGDStEaadznZMZn8bI5LrLVV5WDBlfGj9c2fj+Q==
Date: Tue, 2 Jul 2024 17:10:14 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, david@fromorbit.com,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <20240702171014.reknnw3smasylbtc@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <20240702074203.GA29410@lst.de>
 <20240702101556.jdi5anyr3v5zngnv@quentin>
 <20240702120250.GA17373@lst.de>
 <20240702140123.emt2gz5kbigth2en@quentin>
 <20240702154216.GA1037@lst.de>
 <20240702161329.i4w6ipfs7jg5rpwx@quentin>
 <ZoQwKlYkI5oik32m@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoQwKlYkI5oik32m@casper.infradead.org>
X-Rspamd-Queue-Id: 4WD8YT4Cmhz9sTd

On Tue, Jul 02, 2024 at 05:51:54PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 02, 2024 at 04:13:29PM +0000, Pankaj Raghav (Samsung) wrote:
> > On Tue, Jul 02, 2024 at 05:42:16PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 02, 2024 at 02:01:23PM +0000, Pankaj Raghav (Samsung) wrote:
> > > +static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
> > > >                 loff_t pos, unsigned len)
> > > >  {
> > > >         struct inode *inode = file_inode(dio->iocb->ki_filp);
> > > >         struct bio *bio;
> > > >  
> > > > +       if (!len)
> > > > +               return 0;
> > > >         /*
> > > >          * Max block size supported is 64k
> > > >          */
> > > > -       WARN_ON_ONCE(len > ZERO_PAGE_64K_SIZE);
> > > > +       if (len > ZERO_PAGE_64K_SIZE)
> > > > +               return -EINVAL;
> > > 
> > > The should probably be both WARN_ON_ONCE in addition to the error
> > > return (and ZERO_PAGE_64K_SIZE really needs to go away..)
> > 
> > Yes, I will rename it to ZERO_PAGE_SZ_64K as you suggested.
> 
> No.  It needs a symbolic name that doesn't include the actual size.
> Maybe ZERO_PAGE_IO_MAX.  Christoph suggested using SZ_64K to define
> it, not to include it in the name.

Initially I kept the name as ZERO_FSB_PAGE as it is used to do sub-block
zeroing. But I know John from Oracle is already working on using it for
rt extent zeroing. So I will just go with ZERO_PAGE_IO_MAX for now.
Understood about the SZ_64K part. Thanks for the clarification.

