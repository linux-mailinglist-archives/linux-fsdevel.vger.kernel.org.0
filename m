Return-Path: <linux-fsdevel+bounces-74901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMy4FysrcWniewAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:38:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C641D5C555
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3499E373D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3DA27055D;
	Wed, 21 Jan 2026 19:12:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C3364E91;
	Wed, 21 Jan 2026 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022775; cv=none; b=YZLmFiEBbcSG5jAWFeyrWkQ9u/5CqFhSErIpjOiJxp71Kz3SOJCUnVAg6DnnwVPPAGLxihYH3k0JAgdFWFPpsIcSKTQ/QxJDY3mqFAb1m2APxWQAzYwDtpC5ioNPcBUyKU62Q+uqJfUm3p/nmde1Dh48jOUfuUo1RrApyIiT4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022775; c=relaxed/simple;
	bh=qMOz+yEkA/rkjen0l+JehhX4t4nu9fAUE9DUzbDC2QQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuQGc8Pd7rEYg8pzvkAqLBQF2MyP155nhFJhP5YUGgBbiELq37ZpALB0kda6Szpyh74o4zNJgoWbyN7k2dg1WwL5Q54gd4qEEsxyTyaoyy0iow0cSbnMgQxHdvgxet1WJm06gF1DL/8LOlGphTxottBg2DTzZXDH4IrICL6diQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id 1F304E0430;
	Wed, 21 Jan 2026 20:12:50 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 21 Jan 2026 20:12:49 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aXEjX7MD4GzGRvdE@fedora>
References: <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
 <645edb96-e747-4f24-9770-8f7902c95456@ddn.com>
 <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp>
 <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
 <aXEbnMNbE4k6WI7j@fedora>
 <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
 <aXEhTi2-8DRZKb_I@fedora>
 <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-74901-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[bsbernd.com,igalia.com,gmail.com,szeredi.hu,kernel.org,ddn.com,vger.kernel.org,jumptrading.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C641D5C555
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:03:32PM +0100, Bernd Schubert wrote:
> 
> 
> On 1/21/26 20:00, Horst Birthelmer wrote:
> > On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
> >>
> >>
> > ...
> >>> The problem Luis had was that he cannot construct the second request in the compound correctly
> >>> since he does not have all the in parameters to write complete request.
> >>
> >> What I mean is, the auto-handler of libfuse could complete requests of
> >> the 2nd compound request with those of the 1st request?
> >>
> > With a crazy bunch of flags, we could probably do it, yes.
> > It is way easier that the fuse server treats certain compounds
> > (combination of operations) as a single request and handles
> > those accordingly.
> 
> Hmm, isn't the problem that each fuse server then needs to know those
> common compound combinations? And that makes me wonder, what is the
> difference to an op code then?

I'm pretty sure we both have some examples and counter examples in mind.

Let's implement a couple of the suggested compounds and we will see 
if we can make generic rules. I'm not convinced yet, that we want to
have a generic implementation in libfuse.

The advantage to the 'add an opcode' for every combination 
(and there are already a couple of those) approach is that
you don't need more opcodes, so no changes to the kernel.
You need some code in the fuse server, though, which to me is
fine, since if you have atomic operations implemented there,
why not actually use them.

The big advantage is, choice.

There will be some examples (like the one from Luis)
where you don't actually have a generic choice,
or you create some convention, like you just had in mind.
(put the result of the first operation into the input
of the next ... or into some fields ... etc.)

> 
> 
> Thanks,
> Bernd

Horst

