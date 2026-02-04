Return-Path: <linux-fsdevel+bounces-76348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H8rJjCig2kLqQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:46:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E18EC35E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CBBA3013862
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF5365A0A;
	Wed,  4 Feb 2026 19:46:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AE933B945
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234410; cv=none; b=MTPQCUzNFdrZKPj2sekPtU6afFIu0dIC/sxCy0d9vXR4JYwN05edsGYNiG2vrS6fJ1jd0D5JkyLSj4CSMulhTYNOffvLULm+OZxk2/B3/jGDXfzu1rVmSwRLvCG2O+h04zo86+F/ltkQqYTYXsOvPWMhkMuz67QWPrViN1BHrIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234410; c=relaxed/simple;
	bh=IKX/LFE8ZmwYk/3sg84rjJgIJQXfx/aumErENzHX5Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUlD6fCSwuZ2Sips+7abIziFhSUgQ1HUJ5aHbn/Ii22yvK77jUrIzRD/W47DsKMPC9b2sTGvYVIDhKOTHmy/O369zQZCDcrjSQ0a+hxkwyDajVBA4NaPbptt3QEwEtENIVVAOV+aGeWw/i4mCJhbM7bjKUM3eWDuViJnfdYF66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id C4433E0498;
	Wed,  4 Feb 2026 20:38:27 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 4 Feb 2026 20:38:27 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, f-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>
Subject: Re: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <aYOeZA7_zzvD0Dyd@fedora.fritz.box>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204190649.GB7693@frogsfrogsfrogs>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[birthelmer.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,bsbernd.com,igalia.com];
	TAGGED_FROM(0.00)[bounces-76348-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horst@birthelmer.de,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fedora.fritz.box:mid]
X-Rspamd-Queue-Id: D6E18EC35E
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:06:49AM -0800, Darrick J. Wong wrote:
> On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:
> > I propose a session where various topics of interest could be
> > discussed including but not limited to the below list
> > 
> > New features being proposed at various stages of readiness:
> > 
> >  - fuse4fs: exporting the iomap interface to userspace
> 
> FYI, I took a semi-break from fuse-iomap for 7.0 because I was too busy
> working on xfs_healer, but I was planning to repost the patchbomb with
> many many cleanups and reorganizations (thanks Joanne!) as soon as
> possible after Linus tags 7.0-rc1.
> 
> I don't think LSFMM is a good venue for discussing a gigantic pile of
> code, because (IMO) LSF is better spent either (a) retrying in person to
> reach consensus on things that we couldn't do online; or (b) discussing
> roadmaps and/or people problems.  In other words, I'd rather use
> in-person time to go through broader topics that affect multiple people,
> and the mailing lists for detailed examination of a large body of text.
> 
> However -- do you have questions about the design?  That could be a good
> topic for email /and/ for a face to face meeting.  Though I strongly
> suspect that there are so many other sub-topics that fuse-iomap could
> eat up an entire afternoon at LSFMM:
> 
>  0 How do we convince $managers to spend money on porting filesystems
>    to fuse?  Even if they use the regular slow mode?
> 
>  1 What's the process for merging all the code changes into libfuse?
>    The iomap parts are pretty straightforward because libfuse passes
>    the request/reply straight through to fuse server, but...
> 
Just convince Bernd ... ;-)

>  2 ...the fuse service container part involves a bunch of architecture
>    shifts to libfuse.  First you need a new mount helper to connect to
>    a unix socket to start the service, pass some resources (fds and
>    mount options) through the unix socket to the service.  Obviously
>    that requires new library code for a fuse server to see the unix
>    socket and request those resources.  After that you also need to
>    define a systemd service file that stands up the appropriate
>    sandboxing.  I've not written examples, but that needs to be in the
>    final product.
> 
This really sounds like a good topic for an afternoon and in person the 
bandwith for passing ideas is higher.
I'd be really interested in what those architectural shifts are. It is
clearly a lot more than the passage above.

> 
> --D

Looking forward to seeing you there.

Horst

