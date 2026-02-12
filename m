Return-Path: <linux-fsdevel+bounces-77018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPFSL5nKjWmC6wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 13:42:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B6612D7E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 13:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F31D300BB94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD434B191;
	Thu, 12 Feb 2026 12:41:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AB358D04;
	Thu, 12 Feb 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900113; cv=none; b=ZjP6gPbThtuARBE7BJBtFozs7of0gfwwqveJY2m315bOvy7aIBvlCRcXVbNzGH5MiYoQg/BVHDXElJOTh9hSmbY6d3YwJ/Lnt/6HAbZbdX9F+5ls/M7Ducg2/t8iItuho2BxRxnp1o59D5r3nPgjwjnvC0LaH1kdX/xJo1KXtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900113; c=relaxed/simple;
	bh=RiyXBXx1/GAilOt2Ec4TB59aJCfd6qTqGSxcM9o+9zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3t4wbNOVtnzPEqb+RU1ORlf2O+B9afBQdRNpfI5oY5aSPL4bAjqg2pVlQCs5DqWs/BZ2OkrcFS3Y+iGMipSj+tkcB6RrWlgIFoyNfOvBG6NinebdqP/r8k2UtGPYyGMPDnGB0BsAe/vRnHTz6ScZuRP9cby4LmBSHxkx3l8Ry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 1E328E049A;
	Thu, 12 Feb 2026 13:33:58 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 12 Feb 2026 13:33:57 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to
 combine multiple requests
Message-ID: <aY3Gkh8DKW_QTuTS@fedora.fritz.box>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <aYysaoP0y4_j9erG@fedora-2.fritz.box>
 <CAJfpegsoF3dgBpiO=96HPS_xckfWbP2dF2Ne94Qdb5M743kuJw@mail.gmail.com>
 <aY2gS8q0AclXbXJT@fedora-2.fritz.box>
 <CAJfpegvQPKEP_fYE0xg1RCN9dd4Fb8-eom3o53ewqgboRXW4hA@mail.gmail.com>
 <aY2sZifjV-Hl3t_j@fedora-2.fritz.box>
 <CAJfpegvZiBb6oJCeTeLDiHdUsKEkSLuifrmmMh3aRnXFBzkRkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvZiBb6oJCeTeLDiHdUsKEkSLuifrmmMh3aRnXFBzkRkw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77018-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birthelmer.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fedora.fritz.box:mid]
X-Rspamd-Queue-Id: 38B6612D7E1
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:10:19PM +0100, Miklos Szeredi wrote:
> On Thu, 12 Feb 2026 at 11:48, Horst Birthelmer <horst@birthelmer.de> wrote:
> > On Thu, Feb 12, 2026 at 11:23:56AM +0100, Miklos Szeredi wrote:
> > > On Thu, 12 Feb 2026 at 10:53, Horst Birthelmer <horst@birthelmer.de> wrote:
> > > >
> > > >
> > > > Exactly. And the FUSE_COMPOUND_SEPARABLE was actually there to tell the fuse server,
> > > > that we know that this is not done in this case, so the requests can be processed
> > > > 'separately'.
> > > > If that is missing the fuse server has to look at the combination and decide wether it
> > > > will execute it as a 'compound' or return an error.
> > >
> > > I'd rather add some sub-op header flag that how to fill the missing
> > > input.  E.g. use the nodeid from the previous op's result.
> > >
> > > If there's no flag, then the op is "separable".
> > >
> >
> > This makes the handling on the fuse server side unnecessarily harder.
> > With the current way I can check the flag in the compound header and let libfuse handle the
> > compound by calling the request handlers separately, and not worry about a thing.
> >
> > If the flag is not there, the fuse server itself
> > (passthrough_hp from the PR already demonstrates this) has to handle the whole compound
> > as a whole. I'm confident that this way we can handle pretty much every semantically
> > overloaded combination.
> 
> Yeah, that's one strategy.  I'm saying that supporting compounds that
> are not "separable" within libfuse should be possible, given a few
> constraints.  Something very similar is done in io-uring.  It adds
> complexity, but I think it's worth it.
> 
> I also have the feeling that decoding requests should always be done
> by the library, and if the server wants to handle compounds in special
> way (because for example the network protocol also supports that),
> then it should be done by bracketing the regular operation callbacks
> with compound callbacks, that can allocate/free context which can be
> used by the operation callbacks.
> 

Right now we don't have it completely like this but very similar.
The fuse server makes the final decision not the library.

If it doesn't support a combination it gives control back to libfuse
and if the FUSE_COMPOUND_SEPARABLE flag is set libfuse calls the handlers
sequencially.

The only drawback here is, (this actually makes handling a lot easier)
that we have to have valid and complete results for all requests 
that are in the compound.

> Not sure if I'm making sense.
> 

I think we're getting there that I understand your perspective better.

> >
> > The other way would make the handling in libfuse or in the lowest level of the fuse server
> > (for fuse servers that don't use libfuse) almost impossible without parsing all the requests
> > and all the flags to know that we would have been able to get away with very little work.
> >
> > I had thought of a hierarchical parsing of the compound.
> > The fuse server can decide
> > 1. does it handle compounds at all
> > 2. does it support this particular compound (based on the opcodes and the compound flags
> > and the particular capabilities of the fuse server)
> > 3. if the particular compound can not be handled can libfuse handle it for us?
> >
> > This way we can have real atomic operations in fuse server, where it supports it.
> 
> Yes, that's something definitely useful.   But I also think that the
> fuse *filesystem* code in the kernel should not have to worry about
> whether a particular server supports a particular combination of
> operations and fall back to calling ops sequentially if it doesn't.
> This could be all handled transparently in the layers below
> (fs/fuse/dev.c, lib/fuse_lowelevel.c).

I actually like this approach.
lib/fuse_lowlevel.c is already there ... the kernel part does not do this yet.
I'll have a look and come up with a new version.

> > I don't understand yet, why.
> > I think we could actually implement a real atomic open if we craft a compound for it and
> > the fuse server supports it. If not, we can go back to the way it is handled now.
> >
> > What am I missing here?
> 
> I'm saying that there's no point in splitting FUSE_CREATE into
> FUSE_LOOKUP + FUSE_MKNOD compound, since that would:
> 
> a) complicate the logic of joining the ops (which I was taking about above)
> b) add redundant information (parent and name are the same in both ops)
> c) we already have an atomic op that does both, so why make it larger
> and less efficient?
> 
> Thanks,
> Miklos

Thanks,
Horst

