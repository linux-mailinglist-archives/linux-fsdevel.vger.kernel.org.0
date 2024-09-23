Return-Path: <linux-fsdevel+bounces-29903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270897F172
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A311F229F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B21A08A6;
	Mon, 23 Sep 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wJmWHuak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1B1CA84
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727121512; cv=none; b=gGA7duomsRYeYnyXOEobYgVRr0wir8iDoVSnGwwu+iSpzGYV4wxWCaxwJDguJMRvlhhlm4ycPzfg5HF2aErG6At0/wB9aVCpl4/mX1LF52NlU8GCGpiFussu9eDAAecjYRf2M4/Dk7juig9QZ6hfCjWlNimCTsoSK1xaE7aPOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727121512; c=relaxed/simple;
	bh=yxft5aTPJgFo41egnZNnYL2AdYaotMJT020F3tsr8TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bbm3lpcwNJQ3R1i/hMumkiJGV3Keny3PdyrUD8MHTf9NmZx3DpWCRlrQ2lWxSarpEL7+fzt5BVxCd0v3Kx89vCYHsBJ3JbqHiNysLWMTJUd2b5DIMfQW4BGbqzLOfvoEUI7BA8ruVOtasjmPI6WB0Hq8GLYo4AGmJYcGsik/Ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wJmWHuak; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 15:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727121508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sDZ+6d0KCtNkxJnxHWfLVyKDdWVgUy9qCQtEFEkdszQ=;
	b=wJmWHuakuBAKNAV0WmmPRNZvBeiLWrW1HnWaM14kfpJKFiIjGt93VvqXZnOD/KGRg+x8Z/
	owz+aw8dr2tuMURqjEPlBiRJ1qbAG995D9WMcKPp/b5LyFy7VYCKLrTCnH3OtVVotjyYVF
	lWu/JgjAv7AQmzffAm8tETawvtmzrgI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <5wupeqpme5syfqwleeckmvdv5vtsg7m3fsvc7sr6br45mx4mr4@5y3ylpgdnd46>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <CAHk-=wjEDDexH4DQdmzQMipPPABVoHmXBx_byHkWC3qUM3uamw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjEDDexH4DQdmzQMipPPABVoHmXBx_byHkWC3qUM3uamw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 23, 2024 at 12:07:24PM GMT, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 10:18, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sat, 21 Sept 2024 at 12:28, Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > We're now using an rhashtable instead of the system inode hash table;
> > > this is another significant performance improvement on multithreaded
> > > metadata workloads, eliminating more lock contention.
> >
> > So I've pulled this, but I reacted to this issue - what is the load
> > where the inode hash table is actually causing issues?
> 
> Oh, and I also only now noticed that a third of the commits are fairly
> recent and from after the merge window even started.
> 
> Maybe there's a good reason for that, but it sure wasn't explained in
> the pull request. Grr.

I rebased to drop a patch that conflicts with Andrew's tree (the
PF_MEMALLOC_NORECLAIM stuff, which I would still like to chat with him
about since I missed him at Plumbers...)

