Return-Path: <linux-fsdevel+bounces-79621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPNOG0zkqmkTYAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:27:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 113F4222A85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 621C7300CA1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F270F372671;
	Fri,  6 Mar 2026 14:27:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51213002B9;
	Fri,  6 Mar 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807237; cv=none; b=I3zoxyW9wlyBmljXoaUFX0uIuzmHFobsT3MV/LwPxA/jTcGiw7Or07VFhW5CAg9kYsh74WjLTINbhaC38MXXEGuHPv+XVr/OFVijQ2pBovlfw6xFwji54130E5S7qaYw/QjSz0aaJBOnwe7SBi3IFqVvUG10TMD+03Du7qAK/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807237; c=relaxed/simple;
	bh=WMZhtsmc7pG8rOMjqTn+5TSplFIvAewCbvCcGXUHa+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpj3gufh4q2n+vH0uvI0pBZwfxwby2VTMgP6eJmYo1wBTMWTU2VkO3l9XluYEQvLbdfeIg2ycE1kVGoBEbLUEwbnUC3NSpiFNC4aE7NSLfyB/XztzojmIoCfggnya7PgdXiE3ukkIclNDaFVnr2CyaL/umG5Z4zUiLSeYAWA2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id B4EFAE01B1;
	Fri,  6 Mar 2026 15:27:06 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 6 Mar 2026 15:27:06 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aarhiEz5nuveOQdP@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
X-Rspamd-Queue-Id: 113F4222A85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79621-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 10:45:36AM +0100, Miklos Szeredi wrote:
> On Thu, 26 Feb 2026 at 17:43, Horst Birthelmer <horst@birthelmer.com> wrote:
> 
> > +
> > +fallback_separate:
> > +       /* Kernel tries to fallback to separate requests */
> > +       if (!(compound->compound_header.flags & FUSE_COMPOUND_ATOMIC))
> > +               ret = fuse_compound_fallback_separate(compound);
> > +
> > +out:
> > +       kfree(resp_payload_buffer);
> > +out_free_buffer:
> > +       kfree(buffer);
> > +       return ret;
> > +}
> 
> If we go with the list of fuse_args, then all the above logic could go
> into the lower layer (dev.c) which already handles fuse_args ->
> request -> fuse_args conversion.  What's needed is mostly just a loop
> that repeats this for all the sub requests.
> 
> 

I have actually implemented this idea and avoided any memory allocation.
So the short version is, it can be done.

But to me this looks kinda ugly and a bit wrong. I have to check in the 
lower layer for an opcode from the upper layer and 'stream' the args.
(in fuse_dev_do_read() or somewhere in that region there has to be 
a check for FUSE_COMPOUND and then call into different code)

When handled on that level it has to be handled for io-uring
slightly differently as well. 

I will test this a bit more and provide a new version unless someone 
tells me that this is not the right direction.

> 
> Thanks,
> Miklos

Thanks,
Horst

