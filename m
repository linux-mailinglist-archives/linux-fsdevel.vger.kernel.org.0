Return-Path: <linux-fsdevel+bounces-78894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RicLC2mOpWmVDwYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:19:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBC1D9A68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35A36303DAB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7A383C75;
	Mon,  2 Mar 2026 13:19:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E72F334681;
	Mon,  2 Mar 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457569; cv=none; b=C3FjieEXapLcHWSSjSP3+2+A9TAicR0xq0qvow1rQq8x7dG8NwZ4+pmuVa5AIE1w6ggERAmTkQMYrFl6t6IP9nhxJSKahntX//A3KVKT7Nl6pyKU7VgzqQQPkkS+nw4eDzEwdsGzSyk14mJvjSd8LZJfB+BjtLi+K9Sek095HqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457569; c=relaxed/simple;
	bh=szXZa/RffQNkLt0qmFKE+NwKIkBxd7BocfgKPvzRcP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsU905dtWmKwHaov4PJFX2MS7KA9wTImy4YkYUnXO2A7KhODAy0MM2L6YWCRmILiqOXPysTwZWlv7QjktwsvhRNMss3KQEfc330wd1wDkJxnvWNsaTFN/EFok3xXmJEihvR+OMNFyrMXvZCd0bPGnGcTMLbeJ5Qm7SONp66vJUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id CA3C7E032E;
	Mon,  2 Mar 2026 14:19:18 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Mon, 2 Mar 2026 14:19:18 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aaWNGdV6XoZZXvJW@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
 <aaVcSK1x7qTr1dlc@fedora.fritz.box>
 <CAJfpegvPD3nrOjuXtQzJpg_krH0SUhSwewAMNfZmGjju50jK2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvPD3nrOjuXtQzJpg_krH0SUhSwewAMNfZmGjju50jK2Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78894-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.680];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fedora.fritz.box:mid]
X-Rspamd-Queue-Id: CBEBC1D9A68
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 12:03:35PM +0100, Miklos Szeredi wrote:
> On Mon, 2 Mar 2026 at 10:56, Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > On Fri, Feb 27, 2026 at 10:45:36AM +0100, Miklos Szeredi wrote:
> > > On Thu, 26 Feb 2026 at 17:43, Horst Birthelmer <horst@birthelmer.com> wrote:
> > > > +
> > > > +       unsigned int max_count;
> > > > +       unsigned int count;
> > > > +};
> > > > +/*
> > > > + * This is a hint to the fuse server that all requests are complete and it can
> > > > + * use automatic decoding and sequential processing from libfuse.
> > > > + */
> > > > +#define FUSE_COMPOUND_SEPARABLE (1 << 0)
> > >
> > > We really need per sub-request flags, not per-compound flags.
> > >
> > > I.e:
> > >
> > > FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
> > > success (nodeid, filehandle)
> > > FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup
> > >
> >
> > Couldn't we just save boolean flags in the fuse_args?
> > Something like 'bool is_sub_entry:1' and so on?
> 
> Sure, that's fine.
> 
> > If we have the automatic separation and call of requests in the kernel
> > when the fuse server returns ENOSYS, I don't see the point in adding this
> > to libfuse as well, since there will never be the case,  that kernel
> > doesn't support compounds but libfuse does.
> > It's either the fuse server handles the whole compound, or the kernel does.
> 
> No, I think the library is in a good position to handle compounds,
> because that can reduce the complexity in the server while keeping
> most of the performance benefits.
> 
> > My point is, we don't need to send that information anywhere.
> 
> We need to send that information in any case.  It needs to be part of
> the matching done by the server to "recognize" a certain compound,
> because the same sequence of operations could have different meaning
> if the dependencies are different.

OK, if I have to send flags, that are only present if the fuse request
is inside a compound then I would suggest that we preface the fuse request
with a small compound header, where we store that information.

I would not want to change the fuse request, especially not define the same
flags for every type of fuse requests.

Would that be acceptable?

> 
> Thanks,
> Miklos
> 

Thanks,
Horst

