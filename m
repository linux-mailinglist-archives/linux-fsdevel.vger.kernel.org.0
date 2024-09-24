Return-Path: <linux-fsdevel+bounces-29921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ED6983B62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 04:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42AA1F22394
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 02:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2B14F90;
	Tue, 24 Sep 2024 02:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AoPj7dor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AB12E7E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146566; cv=none; b=bRu/zVCRNqdYSnhSSQw4+2zJ5CqtdzVyDQq1+UFEhE2+jRfCZoZmtJShPz4QMiVz/QR4TzeEHlCrFUAp7MirTH6jmjwzOeATqNiorJuH+cLYrFZ2Kxs3noqRZv8EDjsQC38A6kO7SfZhOo9H66NI4xG8tPtVYzRp37RG1Ps7+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146566; c=relaxed/simple;
	bh=L8hUgKfg86tZvM0cve+PTBxrXPKqG2h8HYIh4A0Gs+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdVt/OwKdms+8XSLvMg7vOP9Px7SgUQ6fLllqGmOBpuizAFUdMY7wmD04delXfQwYut/DQ36bqiV8usQSLhyw2sv8tMRYv30huPH9W+vFtLGqtdLLz/MsQujiRfmq2MN72ff5F9ZVuH1vxe0CtJ5sET5mr/x78jXrXO0MkPX7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AoPj7dor; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 23 Sep 2024 22:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727146562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELo+ULv8YDEvPyxBHuOn8sAdlPAUaZpqZf+a7Q2vueE=;
	b=AoPj7dornC8/o9eZb5S075tvbhvsC44Q2ApWLUBGt6Nk9+tcqdNbk2JHs4uZlx0HBx6h0r
	kCdJuowTwGycnErv7LfGy4gSlK3jfOOxVFXARtijyH64D+hBjvI40oceYxoV4MRSF3BMpO
	E5aAQjpBSs/YU2uvOkkd7GwwYMUitWQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <74sgzrvtnry4wganaatcmxdsfwauv6r33qggxo27yvricrzxvq@77knsf6cfftl>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 23, 2024 at 07:26:31PM GMT, Linus Torvalds wrote:
> On Mon, 23 Sept 2024 at 17:27, Dave Chinner <david@fromorbit.com> wrote:
> >
> > However, the problematic workload is cold cache operations where
> > the dentry cache repeatedly misses. This places all the operational
> > concurrency directly on the inode hash as new inodes are inserted
> > into the hash. Add memory reclaim and that adds contention as it
> > removes inodes from the hash on eviction.
> 
> Yeah, and then we spend all the time just adding the inodes to the
> hashes, and probably fairly seldom use them. Oh well.
> 
> And I had missed the issue with PREEMPT_RT and the fact that right now
> the inode hash lock is outside the inode lock, which is problematic.
> 
> So it's all a bit nasty.
> 
> But I also assume most of the bad issues end up mainly showing up on
> just fairly synthetic benchmarks with ramdisks, because even with a
> good SSD I suspect the IO for the cold cache would still dominate?

Not for bcachefs, because filling into the vfs inode cache doesn't
require a disk read - they're cached in the inodes btree and much
smaller there. We use a varint encoding so they're typically 50-100
bytes, last I checked.

Compare to ~1k, plus or minus, in the vfs inode cache.

Thomas Bertshinger has been working on applications at LANL where
avoiding pulling into the vfs inode cache seems to make a significant
difference (file indexing in his case) - it turns out there's an xattr
syscall that's missing, which I believe he'll be submitting a patch for.

But stat/statx always pulls into the vfs inode cache, and that's likely
worth fixing.

