Return-Path: <linux-fsdevel+bounces-77004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE3OJLeljWlh5gAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:04:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E912C32A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 985EB30E5E75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED722E7167;
	Thu, 12 Feb 2026 10:01:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22D286416;
	Thu, 12 Feb 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890513; cv=none; b=M6pA74thOvdhtikjIamARipQ/7Z5axia2zvwOTS3X97tY1ZpBisXlD6YCRmEGQVn3KAAFuslz2urRSNbmhNb5imyNnGsGHM4HVnXqT0OlwkvjHw6zRjWkmUQ+hyMtXYtFSLv8QZ6dnudhXn2MIoRAq2I91oA1R6rq3tiTeQecf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890513; c=relaxed/simple;
	bh=sqM5uidyw/i5Gwi1M1tkqn1is+J7Wo1VqIc0bKEe3rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLeXqHn/LvKq94QQSHz+FMwJm4ARxy2jWkQgC6AnIFmS+Kjas3V+lXoZIB8S1JibWlYjzo+TjHnURgHeIUnYQD+lsuGDNQdORAZJjsdaEbat0P7taAZBbWEfHXpVNMYsvKsOURgS/Cfq7LRoIjJXTCPciDyLEYzjdyfOjcQOyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id 0240BE01DC;
	Thu, 12 Feb 2026 10:53:29 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 12 Feb 2026 10:53:29 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aY2gS8q0AclXbXJT@fedora-2.fritz.box>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <aYysaoP0y4_j9erG@fedora-2.fritz.box>
 <CAJfpegsoF3dgBpiO=96HPS_xckfWbP2dF2Ne94Qdb5M743kuJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsoF3dgBpiO=96HPS_xckfWbP2dF2Ne94Qdb5M743kuJw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77004-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 108E912C32A
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 10:38:25AM +0100, Miklos Szeredi wrote:
> On Wed, 11 Feb 2026 at 17:35, Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > >
> > > > +#define FUSE_MAX_COMPOUND_OPS   16        /* Maximum operations per compound */
> > >
> > > Don't see a good reason to declare this in the API.   More sensible
> > > would be to negotiate a max_request_size during INIT.
> > >
> >
> > Wouldn't that make for a very complicated implementation of larger compounds.
> > If a fuse server negotiates something like 2?
> 
> I didn't mean negotiating the number of ops, rather the size of the
> buffer for the compound.
> 
OK, so the current limit would be the size of the whole operation.

> But let's not overthink this.   If compound doesn't fit in 4k, then it
> probably not worth doing anyway.

Got it!
Unless some people have the idea of doing some atomic operation with
WRITE+<some attribute operation> ;-)

> 
> > > > +
> > > > +#define FUSE_COMPOUND_SEPARABLE (1<<0)
> > > > +#define FUSE_COMPOUND_ATOMIC (1<<1)
> > >
> > > What is the meaning of these flags?
> >
> > FUSE_COMPOUND_SEPARABLE is a hint for the fuse server that the requests are all
> > complete and there is no need to use the result of one request to complete the input
> > of another request further down the line.
> 
> Aha, so it means parallel execution is allowed.

Yes.

> 
> > Think of LOOKUP+MKNOD+OPEN ... that would never be 'separable'.
> 
> Right.  I think for the moment we don't need to think about parallel
> execution within a compound.

Not only for parallel execution. You cannot craft the args for this to be
complete, independent of parallel execution.

You will need the result of LOOKUP to know what to do with MKNOD and to fill the args for OPEN.

> 
> > At the moment I use this flag to signal libfuse that it can decode the compund
> > and execute sequencially completely in the lib and just call the separate requests
> > of the fuse server.
> 
> I think decoding and executing the ops sequentially should always be
> possible, and it would be one of the major advantages of the compound
> architecture: kernel packs a number of requests that it would do
> sequentially, sends to server, server decodes and calls individual
> callbacks in filesystem, then replies with the compound result.  This
> reduces the number of syscalls/context switches which can be a win
> even with an unchanged library API.

Yes, but some combinations are not complete when you have interdependencies
within the packed requests.

> 
> The trick in a case like MKNOD + OPEN is to let the server know how to
> feed the output of one request to the input of the next.
> 

Exactly. And the FUSE_COMPOUND_SEPARABLE was actually there to tell the fuse server,
that we know that this is not done in this case, so the requests can be processed
'separately'.
If that is missing the fuse server has to look at the combination and decide wether it
will execute it as a 'compound' or return an error.

> > FUSE_COMPOUND_ATOMIC was an idea to hint to the fuse server that the kernel treats
> > the compound as one atomic request. This can maybe save us some checks for some
> > compounds.
> 
> Do you have an example?

Yes, I have used it for my (not yet ready for scrutiny) implementation of atomic open.
If you know that LOOKUP got a valid result and the operation was atomic on fuse server side,
you don't have to check for MKNODs result.

> 
> Thanks,
> Miklos

Thanks,
Horst

