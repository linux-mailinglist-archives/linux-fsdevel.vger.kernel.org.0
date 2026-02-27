Return-Path: <linux-fsdevel+bounces-78709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPd3IFSCoWkUtgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:39:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D201B6ABF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0753D30FE8D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CED3ED127;
	Fri, 27 Feb 2026 11:37:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp02-ext3.udag.de (smtp02-ext3.udag.de [62.146.106.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5177437A490;
	Fri, 27 Feb 2026 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772192277; cv=none; b=tWve86MUOrkb8zlC/We3eihFzkW+AVMb2yrIujRmkcPhUaOPKSR7tFC5FDhdmEbNkcvQk8Ea6km2r8tHIHxT0M/uO9v0tQfk8HONm3EPJkAkQsOD2zwHSZ/zzg38YELi8DHCkRZif5MVJajl/UbL6+f7O4WLQ1qG9tmE/pX0TvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772192277; c=relaxed/simple;
	bh=4dQLacNTmqo95rbQ0DgIh1Ww0hVfKTNLacN4JHuSpmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqqfDpWeOnB+pAwvrZNFbLuK4U+pwqwYtz2qCMts04bXfZCSHHpjlX3Nj0pDRiuyVhtsgwfljAoT5z6LdZVSwYjYSA99yN9hmLC9rdiwM7DqvytPBN6IfqtozBfAKP/zqsjwHRPxdAfavUdaMQAvIi4/BuQCOKwXM3ZvZUr4tJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp02-ext3.udag.de (Postfix) with ESMTPA id 08BBFE02E5;
	Fri, 27 Feb 2026 12:37:52 +0100 (CET)
Authentication-Results: smtp02-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Fri, 27 Feb 2026 12:37:52 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Bernd Schubert <bschubert@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH v6 1/3] fuse: add compound command to combine
 multiple requests
Message-ID: <aaGA2YnQnlB27xAu@fedora.fritz.box>
References: <20260226-fuse-compounds-upstream-v6-0-8585c5fcd2fc@ddn.com>
 <20260226-fuse-compounds-upstream-v6-1-8585c5fcd2fc@ddn.com>
 <CAJfpegsNpWb-miyx+P-W_=11dB3Shz6ikNOQ6Qp_hyOp1DqE9A@mail.gmail.com>
 <aaFyQX9ZI4KmqtFQ@fedora.fritz.box>
 <CAJfpegun=NNM099f6GC2_E2TbG0s936V_sW5SExt6mOEC0_WMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegun=NNM099f6GC2_E2TbG0s936V_sW5SExt6mOEC0_WMQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78709-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[birthelmer.com,ddn.com,gmail.com,igalia.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birthelmer.de:email]
X-Rspamd-Queue-Id: D0D201B6ABF
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 12:29:00PM +0100, Miklos Szeredi wrote:
> On Fri, 27 Feb 2026 at 11:48, Horst Birthelmer <horst@birthelmer.de> wrote:
> 
> > > FUSE_SUB_IS_ENTRY - this sub request will return a new entry on
> > > success (nodeid, filehandle)
> > > FUSE_SUB_DEP_ENTRY - this sub request depends on the result of a previous lookup
> > >
> >
> > we don't need this if we use my converters from above.
> 
> Dependencies need to be handled by the kernel and libfuse as well.
> Makes no sense to have two separate mechanisms for handling
> dependencies, so the kernel should use the same flags.
> 
OK, got it.

> > Could you maybe provide some examples of usecases, that I should try to drill the
> > new logic?
> 
> - LOOKUP + GETATTR[L]
> - MKOBJ + (SETXATTR[L]  (only for posix_acl inheritance)) + GETATTR[L]
> + (OPEN[L] (optional)
> - SETATTR + SETXATTR (setting posix_acl that modifies mode or setting
> mode on file with posix_acl)
> - INIT + LOOKUP_ROOT + GETATTR[L]
> - OPEN + IOCTL[O] + RELEASE[O] (fileattr_get/set)
> 
> Only two dependencies here: lookup or open.  Both are simple in terms
> of just needing to copy a field from a previous request to the current
> one with fixed positions in all of the above cases.
> 
> The LOOKUP + MKNOD one *is* more complicated, because it makes
> execution of the MKNOD dependent on the result of the LOOKUP, so the
> dependency handler needs to look inside the result and decide how to
> proceed based on that.  Some pros and cons of both approaches, so I'm
> curious to see how yours looks like.
> 

I really am greateful for this list. Helps me a lot, since I was looking at this from the 
perspective of the fuse server, which truns out to be different.

> > I have used compounds to send groups of semantically linked requests to the fuse server
> > signalling to it if the kernel expects it to be one atomic operation or a preferred
> > 'group' of requests (like open+getattr, nothing happens if those are not processed atomic
> > in a distributed file system)
> 
> Which is the case where the kernel expects them to be atomic?
> 

I naively thought that fuse_atomic_open() was actually there to do an atomic open ... ;-)

> Thanks,
> Miklos
> 

Thanks,
Horst

