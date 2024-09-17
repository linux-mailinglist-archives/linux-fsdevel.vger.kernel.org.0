Return-Path: <linux-fsdevel+bounces-29544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0039897AB17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3AF280E02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 05:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC076410;
	Tue, 17 Sep 2024 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n0SLIoxA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17CF4174A;
	Tue, 17 Sep 2024 05:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726551277; cv=none; b=Xn38jdDbL0UEawy010aMWUkdP4moBrZe2PBNZ0Kx5wtGjiVXfD77i3IItIDsBKpUJ1QAbs0a0GTDf1XLAdoMSZWUQIonh1zco6SHDGDHbKNDWLsYyLTHLFyCaTRU5fkF8NJzOrHV+tam7VUhfaGIMBaMWvMHkyQWWnu0PpTGSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726551277; c=relaxed/simple;
	bh=2PPXsB99Wx7DXtoG9gyiqOc62XsvddUP7aAxrHGWr1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf5qjslBHHROR30OqhxOzgnkRWkRWhcICN7NC9aI9PeEmhgqdbUwVeZU7mrbLJ6pPcNUuQS7jMo6cvDdz/Cs9b7qN0x9Jwk7kdMVaPeawIyf+E+/JF1Hrj0oqmmCXEfaJ7/92isnP+YBpxgFl59xGr92QXA/cFjIsrWM0srE6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n0SLIoxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEECC4CEC6;
	Tue, 17 Sep 2024 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726551276;
	bh=2PPXsB99Wx7DXtoG9gyiqOc62XsvddUP7aAxrHGWr1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0SLIoxAk1LOnU11qV51emCyj0yH4TToCO1jWU7PNuQPY5iL5s/5ORtjFFQ7UMIVw
	 EFgRsxoauY9XRIBdJObT15tzs5Yt/b82/dt6mL5rhppovHTdizgQWg9VHoitDBxPGM
	 x6d3BY5xW/AQ4h8lfp4QqhfLSDvtfcJ8ibO4UnUU=
Date: Tue, 17 Sep 2024 07:34:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Yiyang Wu <toolmanp@tlmp.cc>, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Message-ID: <2024091702-easiest-prelude-7d4f@gregkh>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-3-toolmanp@tlmp.cc>
 <2024091655-sneeze-pacify-cf28@gregkh>
 <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7a902a-25f6-491c-88a3-ad0a3204d2ff@linux.alibaba.com>

On Tue, Sep 17, 2024 at 08:18:06AM +0800, Gao Xiang wrote:
> Hi Greg,
> 
> On 2024/9/17 01:55, Greg KH wrote:
> > On Mon, Sep 16, 2024 at 09:56:12PM +0800, Yiyang Wu wrote:
> > > diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
> > > new file mode 100644
> > > index 000000000000..0f1400175fc2
> > > --- /dev/null
> > > +++ b/fs/erofs/rust/erofs_sys.rs
> > > @@ -0,0 +1,22 @@
> > > +#![allow(dead_code)]
> > > +// Copyright 2024 Yiyang Wu
> > > +// SPDX-License-Identifier: MIT or GPL-2.0-or-later
> > 
> > Sorry, but I have to ask, why a dual license here?  You are only linking
> > to GPL-2.0-only code, so why the different license?  Especially if you
> > used the GPL-2.0-only code to "translate" from.
> > 
> > If you REALLY REALLY want to use a dual license, please get your
> > lawyers to document why this is needed and put it in the changelog for
> > the next time you submit this series when adding files with dual
> > licenses so I don't have to ask again :)
> 
> As a new Rust kernel developper, Yiyang is working on EROFS Rust
> userspace implementation too.
> 
> I think he just would like to share the common Rust logic between
> kernel and userspace.

Is that actually possible here?  This is very kernel-specific code from
what I can tell, and again, it's based on the existing GPL-v2 code, so
you are kind of changing the license in the transformation to a
different language, right?

> Since for the userspace side, Apache-2.0
> or even MIT is more friendly for 3rd applications (especially
> cloud-native applications). So the dual license is proposed here,
> if you don't have strong opinion, I will ask Yiyang document this
> in the next version.  Or we're fine to drop MIT too.

If you do not have explicit reasons to do this, AND legal approval with
the understanding of how to do dual license kernel code properly, I
would not do it at all as it's a lot of extra work.  Again, talk to your
lawyers about this please.  And if you come up with the "we really want
to do this," great, just document it properly as to what is going on
here and why this decision is made.

thanks,

greg k-h

