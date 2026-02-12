Return-Path: <linux-fsdevel+bounces-77014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDa9ESC9jWnL6QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:44:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 656AA12D1B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 12:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B794930CA028
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 11:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934A345738;
	Thu, 12 Feb 2026 11:44:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222B2D8387;
	Thu, 12 Feb 2026 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896649; cv=none; b=UZGBnFxCAxTzarjVqAQy5VYq410GrTh0BwiR/iyKGKqor5+7w6sspmg8blNCGaf3YC/6nQtZddmYRf8gvZONAWDcaW16M8VTDqkYN4EWseanjrdaWHeuMFjLPTq+n3KmGbE0yaduAdcmzBRSMPm0TpxH/ZRbmI1Zjj21UdzZr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896649; c=relaxed/simple;
	bh=1iOpcD8cAW9p3j1KP3XLR5LSGQN5xBh/93k9ztmSUkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiPp2TXHEPvB7V/V620ASwkuDbpeSMMiugXURwSH42JuwdBLMuTWjHEQJurv0qaJNwn1UayeFtmVF7PqPF3tJ6DPsMeD4kbCrF3WLfvO3c/h+dn6/RaUhreb16/JN6RUq+o5sSzJKBaNGC1KbOMoZAMbsvvMbAymFDQwAeuJYII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id 74050E05AB;
	Thu, 12 Feb 2026 12:44:04 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 12 Feb 2026 12:44:03 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aY25uu56irqfFVxG@fedora-2.fritz.box>
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com>
 <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com>
 <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77014-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[szeredi.hu,birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 656AA12D1B5
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 11:43:12AM +0100, Bernd Schubert wrote:
> 
> 
> On 2/12/26 11:16, Miklos Szeredi wrote:
> > On Thu, 12 Feb 2026 at 10:48, Bernd Schubert <bernd@bsbernd.com> wrote:
> >> On 2/12/26 10:07, Miklos Szeredi wrote:
> >>> On Wed, 11 Feb 2026 at 21:36, Bernd Schubert <bernd@bsbernd.com> wrote:
> >>>
> > 
> >>> So as a first iteration can we just limit compounds to small in/out sizes?
> >>
> >> Even without write payload, there is still FUSE_NAME_MAX, that can be up
> >> to PATH_MAX -1. Let's say there is LOOKUP, CREATE/OPEN, GETATTR. Lookup
> >> could take >4K, CREATE/OPEN another 4K. Copying that pro-actively out of
> >> the buffer seems a bit overhead? Especially as libfuse needs to iterate
> >> over each compound first and figure out the exact size.
> > 
> > Ah, huge filenames are a thing.  Probably not worth doing
> > LOOKUP+CREATE as a compound since it duplicates the filename.  We
> > already have LOOKUP_CREATE, which does both.  Am I missing something?
> 
> I think you mean FUSE_CREATE? Which is create+getattr, but always
> preceded by FUSE_LOOKUP is always sent first? Horst is currently working
> on full atomic open based on compounds, i.e. a totally new patch set to
> the earlier versions. With that LOOKUP
> 
> Yes, we could use the same file name for the entire compound, but then
> individual requests of the compound rely on an uber info. This info
> needs to be created, it needs to be handled on the other side as part of
> the individual parts. Please correct me if I'm wrong, but this sounds
> much more difficult than just adding an info how much space is needed to
> hold the result?

I have a feeling we have different use cases in mind and misunderstand each other.

As I see it:
From the discussion a while ago that actually started the whole thing I understand
that we have combinations of requests that we want to bunch together for a 
specific semantic effect. (see OPEN+GETATTR that started it all)

If that is true, then bunching together more commands to create 'compounds' that
semantically linked should not be a problem and we don't need any algorithm for 
recosntructing the args. We know the semantics on both ends and craft the compounds
according to what is to be accomplished (the fuse server just provides the 'how')

From the newer discussion I have a feeling that there is the idea floating around
that we should bunch together arbitrary requests to have some performance advantage.
This was not my initial intention.
We could do that however if we can fill the args and the requests are not 
interdependent.

If we can signal to the fuse server what we expect as result 
(at least the allocated memory) I think we can do both, but I would like to have the
emphasis more on the semantic grouping for the moment.

Do you guys think that there will ever be a fuse server that doesn't support compounds
and all of them are handled by something like libfuse and the request handlers are just 
called without having to handle not even one unseparatebale semantic 'group'?

> 
> Thanks,
> Bernd

