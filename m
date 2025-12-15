Return-Path: <linux-fsdevel+bounces-71307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A37CBD7B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C91D3025316
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDFF330335;
	Mon, 15 Dec 2025 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="S+rF9uWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC433032F;
	Mon, 15 Dec 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797384; cv=none; b=l/rfnaFkSwHXwbYaL+S3usz04kIFw58lbkmz6/1vdWES2BBv9NYBAsQihVd572EZFyOZOCrdUbOE9ShQk//qYu7ocb4d996dOaNHrKf3Ei2AOm5KcKd0MekM1qIyGUOIrZ16owDgKDbvCVaJ4z9l0BgYc06IoXMoqaOGYtgRh54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797384; c=relaxed/simple;
	bh=EuSiIuyRALw+TdcF14QddpLJOwbNYrv2UImUyp6ZNh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUH2nd15MpHUu54Pxk2VUv1EIakQCPmpoR6yT39NRcqqqPX/h+KfuS8PEpq52h883n+jowAQimKvejp+d6macrmyA8X4wHno69Qi73fePIHf1caRNdimsgeLY63qFeiIz92y0d1avKOqBkZabqzYGBZ2Tk8VVDLcMCbGffKMtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=S+rF9uWk; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=hP/U9X3ek/QPwoi3hGCAMfuswx9V7+TFBIHg3O2P6rc=; b=S+rF9uWkZtNiWd/8J8ou1tmFj8
	9YuwD6EmL+i3avVYw4IEyLfND/tWoVcKkp/cVbKMw1ejAMRubvxTAXfiJczfv3vALZ7rlgh9X0oS5
	tl7poU4qLn60GJ3XU+oDqtNR+1Y4bqOwTXzguO6D2bMKCI3jHNiX985n9zoUJc7vJNWjpVUwVH74z
	EllTfZYCeYaQT/kgoPC94FsdUTPi0yNrzRR+8KNrKj2IxHcHiJGZOKXY+2oM5C7F+sHDWb3rGqTAy
	A6YymweDqLbpcL4o0BaZ2bodgaReivKG0VJl6t0v39JgELAzcze5jYIjwtaR/Xv50FakOZhZLpQ92
	PlJqCMbsqsUAf1ab4OdXA2TFLqcWfuSYn+3vzQSMrYG9ojiFxD3JNkXnUmaVuJ/yYAagY0p4Yirp3
	D4aQRHo9vP62RntLW4qCAniGztY94QOSpm+aMTselahAE7m6XPqSgGMqdGj54CmEsAMNX2HmYsmSY
	uB79S7zMbBg2hLiiF3y9Hg4e085edg+k7T4YC+gfNct1Qy7BYQCqIt2anicmF8ZGDsJOgqnH3v4qB
	reSssMpwgnpC9aCgzbjKfZA5zLXfpzxPyrg0RTGYDZz9hPHOIPu9/axT72B3kpgB3tHVtyahUui7C
	8XdcGrkStSiggcGu+o997hiBHXZvgSQdU2zfIUcjA=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Christoph Hellwig <hch@infradead.org>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 Chris Arges <carges@cloudflare.com>
Subject:
 Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter() iovec
Date: Mon, 15 Dec 2025 12:16:07 +0100
Message-ID: <3918430.kQq0lBPeGt@weasel>
In-Reply-To: <aT-59HURCGPDUJnZ@codewreck.org>
References:
 <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aT-iwMpOfSoRzkTF@infradead.org> <aT-59HURCGPDUJnZ@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 15 December 2025 08:34:12 CET Dominique Martinet wrote:
> Thanks for having a look
> 
> Christoph Hellwig wrote on Sun, Dec 14, 2025 at 09:55:12PM -0800:
> > > Ok, I don't understand why the current code locks everything down and
> > > wants to use a single scatterlist shared for the whole channel (and
> > > capped to 128 pages?), it should only need to lock around the
> > > virtqueue_add_sg() call, I'll need to play with that some more.
> > 
> > What do you mean with "lock down"?
> 
> Just the odd (to me) use of the chan->lock around basically all of
> p9_virtio_request() and most of p9_virtio_zc_request() -- I'm not pretty
> sure this was just the author trying to avoid an allocation by recycling
> the chan->sg array around though, so ignore this.

The lock protects the channel wide, shared scatterlist while the scatterlist 
is filled from the linear buffers by pack_sg_list(). Then virtqueue_add_sgs() 
pushes scatterlist's segments as virtio descriptors into the virtio FIFOs. 
From this point it safe to unlock as the scatterlist is no longer needed.

And yes, the assumption probably was that handling the scatterlist as a 
temporary was more expensive due to allocation.

> > > Looking at other virtio drivers I could probably use a sg_table and
> > > have extract_iter_to_sg() do all the work for us...
> > 
> > Looking at the code I'm actually really confused.  Both because I
> > actually though we were talking about the 9fs direct I/O code, but
> > that has actually been removed / converted to netfs a long time ago.
> > 
> > But even more so what the net/9p code is actually doing..  How do
> > we even end up with user addresses here at all?
> 
> FWIW I tried logging and saw ITER_BVEC, ITER_KVEC and ITER_FOLIOQ --
> O_DIRECT writes are seen as BVEC so I guess it's not as direct as I
> expected them to be -- that code could very well be leftovers from
> the switch to iov_iter back in 2015...
> 
> (I'm actually not sure why Christian suggested checking for is_iovec()
> in https://lkml.kernel.org/r/2245723.irdbgypaU6@weasel -- then I
> generalized it to user_backed_iter() and it just worked because checking
> for that moved out bvec and folioq from iov_iter_get_pages_alloc2()
> to... something that obviously should not work in my opinion but
> apparently was enough to not trigger this particular BUG.)

Sorry, I should have explained why I suggested that change: My understanding 
of the p9_get_mapped_pages() code was that the original author intended to go 
down the iov_iter_get_pages_alloc2() path only for user space memory 
exclusively and that he assumed that his preceding !iov_iter_is_kvec(data) 
check would guard this appropriately. But apparently there are several other 
iterator types that are kernel memory as well. So I thought switching the 
check to is_iovec() would be better as these are user space memory, however I 
missed that there is also ITER_UBUF with user space memory, which you realized 
fortunately by suggesting user_backed_iter() check instead.

/Christian



