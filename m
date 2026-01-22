Return-Path: <linux-fsdevel+bounces-75008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICYuMQr8cWmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:29:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9E65445
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22BE8665F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA843C199E;
	Thu, 22 Jan 2026 10:21:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8235BDDE;
	Thu, 22 Jan 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077264; cv=none; b=DYgFEDuZTMlqSWvWgsfiwqXilVdhJ+nW6IGy56Ofsgv1bbuSA+GnA0j7gwHF/xDHV4ENhassSPbI+fARg3VCWk7mhuiG+4HHMzOzsCJaXzzZ+4kwLzgw10yqFWWEoK+aD0hAageRagm48RkWj/fzioBXYsmzIfjLNPu86oeIrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077264; c=relaxed/simple;
	bh=6nqciMtGWcSJ3zgXx56AJVo1otmahHWhqTwT6kwZMzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsJjIjWSfkU1Jjr++UVGwk6uxBnGM/o2ZhXxpKBu7Geuqgd9l3s9FZGrYBNTh9usV6nR03Iq+1QvGVJOqGR34aeBtBbnjTGRAWJAdRcopk/ReLeGndzSQXP8LHxYyFAbvTXn/aSheFj6H16gXxOuBYXLFm47Bx+cs9W60C1D/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id C256DE09AE;
	Thu, 22 Jan 2026 11:20:51 +0100 (CET)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 22 Jan 2026 11:20:50 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Harvey <mharvey@jumptrading.com>, 
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <aXH48-QCxUU4TlNk@fedora.fritz.box>
References: <aWFcmSNLq9XM8KjW@fedora>
 <877bta26kj.fsf@wotan.olymp>
 <aXEVjYKI6qDpf-VW@fedora>
 <03ea69f4-f77b-4fe7-9a7c-5c5ca900e4bf@bsbernd.com>
 <aXEbnMNbE4k6WI7j@fedora>
 <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
 <aXEhTi2-8DRZKb_I@fedora>
 <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
 <aXEjX7MD4GzGRvdE@fedora>
 <87pl726kko.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pl726kko.fsf@wotan.olymp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75008-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[ddn.com,bsbernd.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EB9E65445
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:52:23AM +0000, Luis Henriques wrote:
> Hi!
> 
> On Wed, Jan 21 2026, Horst Birthelmer wrote:
> 
> > On Wed, Jan 21, 2026 at 08:03:32PM +0100, Bernd Schubert wrote:
> >> 
> >> 
> >> On 1/21/26 20:00, Horst Birthelmer wrote:
> >> > On Wed, Jan 21, 2026 at 07:49:25PM +0100, Bernd Schubert wrote:
> >> >>
> >> >>
> >> > ...
> >> >>> The problem Luis had was that he cannot construct the second request in the compound correctly
> >> >>> since he does not have all the in parameters to write complete request.
> >> >>
> >> >> What I mean is, the auto-handler of libfuse could complete requests of
> >> >> the 2nd compound request with those of the 1st request?
> >> >>
> >> > With a crazy bunch of flags, we could probably do it, yes.
> >> > It is way easier that the fuse server treats certain compounds
> >> > (combination of operations) as a single request and handles
> >> > those accordingly.
> 
> Right, I think that at least the compound requests that can not be
> serialised (i.e. those that can not be executed using the libfuse helper
> function fuse_execute_compound_sequential()) should be flagged as such.
> An extra flag to be set in the request should do the job.
> 
> This way, if this flag isn't set in a compound request and the FUSE server
> doesn't have a compound handle, libfuse could serialise the requests.
> Otherwise, it would return -ENOTSUPP.
> 
> >> Hmm, isn't the problem that each fuse server then needs to know those
> >> common compound combinations? And that makes me wonder, what is the
> >> difference to an op code then?
> >
> > I'm pretty sure we both have some examples and counter examples in mind.
> >
> > Let's implement a couple of the suggested compounds and we will see 
> > if we can make generic rules. I'm not convinced yet, that we want to
> > have a generic implementation in libfuse.
> >
> > The advantage to the 'add an opcode' for every combination 
> > (and there are already a couple of those) approach is that
> > you don't need more opcodes, so no changes to the kernel.
> > You need some code in the fuse server, though, which to me is
> > fine, since if you have atomic operations implemented there,
> > why not actually use them.
> >
> > The big advantage is, choice.
> >
> > There will be some examples (like the one from Luis)
> > where you don't actually have a generic choice,
> > or you create some convention, like you just had in mind.
> > (put the result of the first operation into the input
> > of the next ... or into some fields ... etc.)
> 
> So, to summarise:
> 
> In the end, even FUSE servers that do support compound operations will
> need to check the operations within a request, and act accordingly.  There
> will be new combinations that will not be possible to be handle by servers
> in a generic way: they'll need to return -EOPNOTSUPP if the combination of
> operations is unknown.  libfuse may then be able to support the
> serialisation of that specific operation compound.  But that'll require
> flagging the request as "serialisable".

OK, so this boils down to libfuse trying a bit harder than it does at the moment.
After it calls the compound handler it should check for EOPNOTSUP and the flag
and then execute the single requests itself.

At the moment the fuse server implementation itself has to do this.
Actually the patched passthrough_hp does exactly that.

I think I can live with that.

> 
> Cheers,
> -- 
> Luís

Thanks,
Horst

