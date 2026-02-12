Return-Path: <linux-fsdevel+bounces-77011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ1oCRCwjWmz5wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:48:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC7412CAEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9D0230148B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C879629D297;
	Thu, 12 Feb 2026 10:48:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54D347C6;
	Thu, 12 Feb 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893316; cv=none; b=NCSxB8m0ykFwVM+SCC8v5cjsaknu4e/AU0a09Nn0ZVdcr0ulzcGtEVrDpro+JqAaDwZ0JNCCCzFg8kBx3Mx0zGfKdrWGYWg4v2/lt29luJcNPzrSivINpbIgHefHkxWVpVjXEh4dObI94TmCLY8Ab9FMrYifoyrFfKjeWYQwFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893316; c=relaxed/simple;
	bh=dgTMkNjLGPLTX90eDVfrLdQtVosNFLaKqV6FGQmeCKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOo3x3RIkFrfJIHur0rSlhdWqPqJCp/Q5fabu2ZsqT1KK64lfaKZx+1spF4FCy7PBPwSZloSoLxpZTZ1CAgEEniZlQ76ieTiYOb2GK0KkwfXr3nNZfoTYQ/LpJ3I4Y0K/8YcjJQGRc7knoW2yuFka3t7puYPqM35rzWUS6mWafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id B6117E0522;
	Thu, 12 Feb 2026 11:48:32 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 12 Feb 2026 11:48:32 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aY2sZifjV-Hl3t_j@fedora-2.fritz.box>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <aYysaoP0y4_j9erG@fedora-2.fritz.box>
 <CAJfpegsoF3dgBpiO=96HPS_xckfWbP2dF2Ne94Qdb5M743kuJw@mail.gmail.com>
 <aY2gS8q0AclXbXJT@fedora-2.fritz.box>
 <CAJfpegvQPKEP_fYE0xg1RCN9dd4Fb8-eom3o53ewqgboRXW4hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvQPKEP_fYE0xg1RCN9dd4Fb8-eom3o53ewqgboRXW4hA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77011-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,birthelmer.de:email]
X-Rspamd-Queue-Id: 3EC7412CAEF
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:23:56AM +0100, Miklos Szeredi wrote:
> On Thu, 12 Feb 2026 at 10:53, Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> >
> > Exactly. And the FUSE_COMPOUND_SEPARABLE was actually there to tell the fuse server,
> > that we know that this is not done in this case, so the requests can be processed
> > 'separately'.
> > If that is missing the fuse server has to look at the combination and decide wether it
> > will execute it as a 'compound' or return an error.
> 
> I'd rather add some sub-op header flag that how to fill the missing
> input.  E.g. use the nodeid from the previous op's result.
> 
> If there's no flag, then the op is "separable".
> 

This makes the handling on the fuse server side unnecessarily harder.
With the current way I can check the flag in the compound header and let libfuse handle the
compound by calling the request handlers separately, and not worry about a thing.

If the flag is not there, the fuse server itself 
(passthrough_hp from the PR already demonstrates this) has to handle the whole compound
as a whole. I'm confident that this way we can handle pretty much every semantically
overloaded combination.

The other way would make the handling in libfuse or in the lowest level of the fuse server
(for fuse servers that don't use libfuse) almost impossible without parsing all the requests
and all the flags to know that we would have been able to get away with very little work.

I had thought of a hierarchical parsing of the compound.
The fuse server can decide
1. does it handle compounds at all
2. does it support this particular compound (based on the opcodes and the compound flags
and the particular capabilities of the fuse server)
3. if the particular compound can not be handled can libfuse handle it for us?

This way we can have real atomic operations in fuse server, where it supports it.

> > > > FUSE_COMPOUND_ATOMIC was an idea to hint to the fuse server that the kernel treats
> > > > the compound as one atomic request. This can maybe save us some checks for some
> > > > compounds.
> > >
> > > Do you have an example?
> >
> > Yes, I have used it for my (not yet ready for scrutiny) implementation of atomic open.
> > If you know that LOOKUP got a valid result and the operation was atomic on fuse server side,
> > you don't have to check for MKNODs result.
> 
> As noted in my reply to Bernd the LOOKUP+MKNOD may not be the best way
> to use compounds. May be better off sticking with an actual atomic op
> for this.
> 

I don't understand yet, why.
I think we could actually implement a real atomic open if we craft a compound for it and
the fuse server supports it. If not, we can go back to the way it is handled now.

What am I missing here?

> Thanks,
> Miklos

Thanks,
Horst

