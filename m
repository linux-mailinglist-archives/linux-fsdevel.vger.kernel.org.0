Return-Path: <linux-fsdevel+bounces-75031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNibJ9kecmmPdQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:58:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6166F1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 428987EB27F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0D038F22A;
	Thu, 22 Jan 2026 12:35:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF2A34A76B;
	Thu, 22 Jan 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085304; cv=none; b=JGQMfIZ+1ypKG6n4wBTwQhBw0O979xKkWpp6vT8TXkr2ZdiiIGixaVSm7UARGOl0+TJyaFHMYR0EqZ2Jlh5j/oNzaOX6x5im8JFbQ1EYs7fvhhzEBEErFX9WPKwdAdKlVLju78VYGTcUSHusoHG6BPn4p6PWfbVVd9W31UKogUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085304; c=relaxed/simple;
	bh=AQranA+mAob550Z8OvBX2YiMoiC83eu4LXiRZQB+TS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3tCxKUZJUsm5b/5btLU/cXWRT2W4XAnxfQq9OuuxeDPopDxdAFwZmK+1+kfgPIn8QZ8PHFMRzVxCXf51BdMn5Tsu5bAYT2RogIZo95z+Yz/NsXwIjWkIO/qV/IKy8O93arpgLO21T9W//sq6NzrSnlpaTUCASVq495L8hm5v04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id EDAF9E0935;
	Thu, 22 Jan 2026 13:34:51 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 22 Jan 2026 13:34:50 +0100
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
Message-ID: <aXIX80iwiQ621DM6@fedora>
References: <aXEbnMNbE4k6WI7j@fedora>
 <5d022dc0-8423-4af2-918f-81ad04d50678@ddn.com>
 <aXEhTi2-8DRZKb_I@fedora>
 <e761b39b-79c7-40d4-947e-a209fcf2bb6b@ddn.com>
 <aXEjX7MD4GzGRvdE@fedora>
 <87pl726kko.fsf@wotan.olymp>
 <aXH48-QCxUU4TlNk@fedora.fritz.box>
 <87ldhp7wbf.fsf@wotan.olymp>
 <aXICIREIL46NcaK8@fedora.fritz.box>
 <87h5sd7uu5.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5sd7uu5.fsf@wotan.olymp>
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-75031-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ddn.com,bsbernd.com,gmail.com,szeredi.hu,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 55D6166F1F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:25:22AM +0000, Luis Henriques wrote:
> On Thu, Jan 22 2026, Horst Birthelmer wrote:
> 
> > On Thu, Jan 22, 2026 at 10:53:24AM +0000, Luis Henriques wrote:
> >> On Thu, Jan 22 2026, Horst Birthelmer wrote:
> > ...
> >> >> 
> >> >> So, to summarise:
> >> >> 
> >> >> In the end, even FUSE servers that do support compound operations will
> >> >> need to check the operations within a request, and act accordingly.  There
> >> >> will be new combinations that will not be possible to be handle by servers
> >> >> in a generic way: they'll need to return -EOPNOTSUPP if the combination of
> >> >> operations is unknown.  libfuse may then be able to support the
> >> >> serialisation of that specific operation compound.  But that'll require
> >> >> flagging the request as "serialisable".
> >> >
> >> > OK, so this boils down to libfuse trying a bit harder than it does at the moment.
> >> > After it calls the compound handler it should check for EOPNOTSUP and the flag
> >> > and then execute the single requests itself.
> >> >
> >> > At the moment the fuse server implementation itself has to do this.
> >> > Actually the patched passthrough_hp does exactly that.
> >> >
> >> > I think I can live with that.
> >> 
> >> Well, I was trying to suggest to have, at least for now, as little changes
> >> to libfuse as possible.  Something like this:
> >> 
> >> 	if (req->se->op.compound)
> >> 		req->se->op.compound(req, arg->count, arg->flags, in_payload);
> >> 	else if (arg->flags & FUSE_COMPOUND_SERIALISABLE)
> >> 		fuse_execute_compound_sequential(req);
> >> 	else
> >> 		fuse_reply_err(req, ENOSYS);
> >> 
> >> Eventually, support for specific non-serialisable operations could be
> >> added, but that would have to be done for each individual compound.
> >> Obviously, the server itself could also try to serialise the individual
> >> operations in the compound handle, and use the same helper.
> >> 
> >
> > Is there a specific reason why you want that change in lowlevel.c?
> > The patched passthrouhg_hp does this implicitly, actually without the flag.
> > It handles what it knows as 'atomic' compound and uses the helper for the rest.
> > If you don't want to handle specific combinations, just check for them 
> > and return an error.
> 
> Sorry, I have the feeling that I'm starting to bikeshed a bit...
> 
> Anyway, I saw the passthrough_hp code, and that's why I thought it would
> be easy to just move that into the lowlevel API.  I assumed this would be
> a very small change to your current code that would also allow to safely
> handle "serialisable" requests in servers that do not have the
> ->compound() handler.  Obviously, the *big* difference from your code
> would be that the kernel would need to flag the non-serialisable requests,
> so that user-space would know whether they could handle requests
> individually or not.
> 
> And another thought I just had (more bikeshedding!) is that if the server
> will be allowed to call fuse_execute_compound_sequential(), then this
> function would also need to check that flag and return an error if the
> request can't be serialisable.
> 
> Anyway, I'll stop bothering you now :-)  These comments should probably
> have been done in the libfuse PR anyway.

You are not bothering me at all. I am actually very greatful for those comments
since you are the first user of compounds and that is a very important part.
All the scenarios we clarify now will not bite us later.

I'm still a bit in doubt, that adding that to libfuse will help for all
cases.

> 
> Cheers,
> -- 
> Luís
> 

