Return-Path: <linux-fsdevel+bounces-45220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F4A74E0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 16:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A22188F38F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Mar 2025 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4F41D63D9;
	Fri, 28 Mar 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHg5laPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810C1C84C8;
	Fri, 28 Mar 2025 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176910; cv=none; b=sdWEORBdXxcd1LL+ir4oIWtFkKEWZxf7+xg5i+6/BqAIRpyw6Q7cPrsSZxK/mBVHwBpuq2SaMFDRyoasPnKOWCpuzIwn48WKPLTGUlWZO/VNkRtcM/9MOT0p/lItbCBlebVtsgX7EkSwl66lAKVlbtN39LOoNo8ajoOq2AAhEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176910; c=relaxed/simple;
	bh=/1EXUcnEzRipk1mkzFu009xvcPfXe0nSr81MdlJpBTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5l6jgtpi9FsT0dcJJhyBuj4Ug8WWaT/SfAy5bUaKlFIc2gT9abIyqxTFbSdr9uS5FfHLXZ4o8rd8eOuZyILXbwk/8uFgo53euxnWoAVDwu7GPUOg/sCVdaLXTYCP230PNJss/VA/7xsaX7jfxU4+anHkUG5sGKI46Bt8Q4fAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHg5laPe; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Mar 2025 11:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743176896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wY2rJ58CuGhHvpCweL3K5CZDmMKrY2RaGPFz90RJmzg=;
	b=tHg5laPeCVbttwGqKM8rvmBG8YWbzFkj6NvM98oCXflUk7cfi/rkjdYrF52oBO2ihBHUdQ
	OtGWM2sJB2h3J/zx1086V7uapv1LccjoUVc6ZTc5lFaQSscnny0iCmq60fN9pAx/I3UcVL
	RCH5a2B5i7IcOgbcnmWhaSOrOokemcY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, tech-board-discuss@lists.linux.dev
Subject: Re: [GIT PULL] bcachefs for 6.15, v2...
Message-ID: <ighuwxny4a3obxwbmfsblz4lzpc2qubqqu4nqf6yvqsttuqffc@hs2tbqrwjo4v>
References: <wg47lanrvfqkqdospive4b3ymc5snuhqdygcle33q3cxudw3xl@rkllblbmre4v>
 <5b02fcfedcd006d202d38e2ec16b477919264408.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b02fcfedcd006d202d38e2ec16b477919264408.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 26, 2025 at 04:46:21PM -0400, James Bottomley wrote:
> On Mon, 2025-03-24 at 14:56 -0400, Kent Overstreet wrote:
> > The following changes since commit
> > 1a2b74d0a2a46c219b25fdb0efcf9cd7f55cfe5e:
> > 
> >   bcachefs: fix build on 32 bit in get_random_u64_below() (2025-03-14
> > 19:45:54 -0400)
> > 
> > are available in the Git repository at:
> > 
> >   git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-03-24
> > 
> > for you to fetch changes up to
> > d8bdc8daac1d1b0a4efb1ecc69bef4eb4fc5e050:
> > 
> >   bcachefs: Kill unnecessary bch2_dev_usage_read() (2025-03-24
> > 09:50:37 -0400)
> > 
> > ----------------------------------------------------------------
> > bcachefs updates for 6.15
> 
> I note that the controversial block changes that got NAK'd but which
> you tried to put into your first pull request are now removed from this
> v2 pull request, thanks.
> 
> I also thought it was time to state more formally what's been
> circulating around a few maintainers as shared knowledge: any tree you
> send a pull request for that includes changes outside of bcachefs won't
> be accepted by Linus.

We had a situation where the process clearly broke down in -block, and I
opted to let Linus make the call (knowing he'd already been CC'd on the
previous thread).

