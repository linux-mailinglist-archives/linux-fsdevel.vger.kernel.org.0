Return-Path: <linux-fsdevel+bounces-79578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBRuFsOOqml0TQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 09:22:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F8B21D027
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 09:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D61430EA2D1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 08:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D4377ECD;
	Fri,  6 Mar 2026 08:17:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16E315D40;
	Fri,  6 Mar 2026 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785045; cv=none; b=gDDSe1u30GEgVdbgY+k1vAhbIhclI/vnNhDdn5nT6cUsgHbbcOAMoNNeTMTTrldi5a7CEf1RKbGLl3uHuXsbZsbEeu8L4rE4zxwEhaCJUmlb/YDsUGiJFziKLmF/9YOu576nWJu8Yo6aeZUTO7kVO60wPABbSbeUeBzU+vk6D8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785045; c=relaxed/simple;
	bh=IKmuCai+kYoVonCzcAEr2NYIzjK+3Gqf5dNNhPwDpYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/bQqwJ12jOmU1x/68zDawQ5zPOQfXA+Ouat6dWDvPil24btLrNk2xXOCdJxMk8YGAaeDWVeAqTLt1HSr100WXmzm+7etRskDNikgAYkBN6i0uiGP7pCyTRPtvVD0p3lXP2JfOAmBTC8d231yJa7SB8GFDlZHYjo4o1FSd+QBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id 8468AE01BB;
	Fri,  6 Mar 2026 09:17:14 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 6 Mar 2026 09:17:13 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aaqLZ-LKOnH94iwz@fedora.fritz.box>
References: <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
 <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com>
 <aZC0WdZKA7ohRuHN@fedora>
 <CAJnrk1YUf7xw9s8Bo1YZXVvfe8U-D4E+j-3iZNtOkog4QRZaMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YUf7xw9s8Bo1YZXVvfe8U-D4E+j-3iZNtOkog4QRZaMw@mail.gmail.com>
X-Rspamd-Queue-Id: B2F8B21D027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79578-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.851];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fedora.fritz.box:mid]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 04:52:01PM -0800, Joanne Koong wrote:
> On Sat, Feb 14, 2026 at 9:51 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > On Fri, Feb 13, 2026 at 05:35:30PM -0800, Joanne Koong wrote:
> > > On Thu, Feb 12, 2026 at 3:44 AM Horst Birthelmer <horst@birthelmer.de> wrote:
> > > > I have a feeling we have different use cases in mind and misunderstand each other.
> > > >
> > > > As I see it:
> > > > From the discussion a while ago that actually started the whole thing I understand
> > > > that we have combinations of requests that we want to bunch together for a
> > > > specific semantic effect. (see OPEN+GETATTR that started it all)
> > > >
> > > > If that is true, then bunching together more commands to create 'compounds' that
> > > > semantically linked should not be a problem and we don't need any algorithm for
> > > > recosntructing the args. We know the semantics on both ends and craft the compounds
> > > > according to what is to be accomplished (the fuse server just provides the 'how')
> > > >
> > > > From the newer discussion I have a feeling that there is the idea floating around
> > > > that we should bunch together arbitrary requests to have some performance advantage.
> > > > This was not my initial intention.
> > > > We could do that however if we can fill the args and the requests are not
> > > > interdependent.
> > >
> > > I have a series of (very unpolished) patches from last year that does
> > > basically this. When libfuse does a read on /dev/fuse, the kernel
> > > crams in as many requests off the fiq list as it can fit into the
> > > buffer. On the libfuse side, when it iterates through that buffer it
> > > offloads each request to a worker thread to process/execute that
> > > request. It worked the same way on the dev uring side. I put those
> > > changes aside to work on the zero copy stuff, but if there's interest
> > > I can go back to those patches and clean them up and put them through
> > > some testing. I don't think the work overlaps with your compound
> > > requests stuff though. The compound requests would be a request inside
> > > the larger batch.
> >
> > I would like to have your patch for the processing of multiple requests
> > and the compound for handling semantically related requests.
> >
> 
> the kernel-side changes for the /dev/fuse request batching are pretty
> self-contained [1] but the libfuse changes are very ugly. The
> benchmarks didn't look promising. I think it only really helps if the
> server has metadata-heavy bursty behavior that saturates all the
> libfuse threads, but I don't think that's typical. I dont think it's
> worth pursuing further.

Thanks for the patch. I agree completely. However I wrote that in the context
where I thought that people wanted to achieve something different with compound
requests, like processing parts of a queue depending on some or no criteria.
That's why I stressed the semantic relation of the requests in a compound.

I'm almost willing to bet that in the future we will see someone get
the idea of LOOKUP+OPEN+READ+CLOSE, which would practically
create exactly those bursts when not done as a compound.
Just as a side note ...

> 
> Thanks,
> Joanne
> 
> [1]  https://github.com/joannekoong/linux/commit/308ebbde134ac98d3b3d3e2f3abc2c52ef444759

