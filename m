Return-Path: <linux-fsdevel+bounces-76345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LliBNCYg2lnpwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:06:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A6EBDF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 20:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0065E3007BAE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13624428487;
	Wed,  4 Feb 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNHCZFFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986E7347FDE
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770232010; cv=none; b=aHyguQgth2VOZy8XqXtMGh2t5Bx1vpWGv4xUonhaLiAW/MA3a5edHShyWXVRcBAt4ClTUGodK71UxhIHkLIusOPahKVaTvNlIB2iGwkVypfH+NvTBuhGAhZuyVA7paylYgbHu1shRlDPIPGcsLI93c3RuK2Z5XbckB3pK5YYuAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770232010; c=relaxed/simple;
	bh=g1iD8O3Kq7s0vZ0ks8kPUjeEsUcDkzbRUM89b87izWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5CDfLZhgWm69DvfOpDrYEQBjOUHmpMKTxpNTTaxhXcbosi9V9AO52fVPVL/a0aXkYyS3NoR4LQmLv2AZXxb0lOlZtOqeMCY3PzG0VTiFoZp/PPcitJwjYhEka1oR02nOcrf6X/o49PbysWZC7CabG69S44vJTxsIcsbnD9f0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNHCZFFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A05DC4CEF7;
	Wed,  4 Feb 2026 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770232010;
	bh=g1iD8O3Kq7s0vZ0ks8kPUjeEsUcDkzbRUM89b87izWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNHCZFFvWUsgz+JHL7EwbcoVAasuKjBTdhnaRfBhSW5ZTN7DitNvEMyHzF5Aa57qy
	 kPUdntDF1tnQtFvL6orkMAdhQ6A5OHoWG4cm2M1WxfcwikCizah8mRYuPOmCM9EYHr
	 OVC18oqVD6RyKTps3miihu60Z9+SHrZFEwKdQ9U9yoQo4CJtatoZgDrBx9Qg13/50L
	 fuO/6luzX+sXYVyUy63q8Hbl+9rcBtu1b26Gc+3f0/UZRDVByTJipbbFh4KhsULYF/
	 7/WbQoImyg4Y7+2jC/Ypn4isR4wvgayp1AJePcNMEj8QLScuXjOkHMyW6+Xs2wj+rZ
	 JhpT+ziUQnMVA==
Date: Wed, 4 Feb 2026 11:06:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: f-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260204190649.GB7693@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	TAGGED_FROM(0.00)[bounces-76345-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: A54A6EBDF6
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:
> I propose a session where various topics of interest could be
> discussed including but not limited to the below list
> 
> New features being proposed at various stages of readiness:
> 
>  - fuse4fs: exporting the iomap interface to userspace

FYI, I took a semi-break from fuse-iomap for 7.0 because I was too busy
working on xfs_healer, but I was planning to repost the patchbomb with
many many cleanups and reorganizations (thanks Joanne!) as soon as
possible after Linus tags 7.0-rc1.

I don't think LSFMM is a good venue for discussing a gigantic pile of
code, because (IMO) LSF is better spent either (a) retrying in person to
reach consensus on things that we couldn't do online; or (b) discussing
roadmaps and/or people problems.  In other words, I'd rather use
in-person time to go through broader topics that affect multiple people,
and the mailing lists for detailed examination of a large body of text.

However -- do you have questions about the design?  That could be a good
topic for email /and/ for a face to face meeting.  Though I strongly
suspect that there are so many other sub-topics that fuse-iomap could
eat up an entire afternoon at LSFMM:

 0 How do we convince $managers to spend money on porting filesystems
   to fuse?  Even if they use the regular slow mode?

 1 What's the process for merging all the code changes into libfuse?
   The iomap parts are pretty straightforward because libfuse passes
   the request/reply straight through to fuse server, but...

 2 ...the fuse service container part involves a bunch of architecture
   shifts to libfuse.  First you need a new mount helper to connect to
   a unix socket to start the service, pass some resources (fds and
   mount options) through the unix socket to the service.  Obviously
   that requires new library code for a fuse server to see the unix
   socket and request those resources.  After that you also need to
   define a systemd service file that stands up the appropriate
   sandboxing.  I've not written examples, but that needs to be in the
   final product.

 3 What tooling changes to we need to make to /sbin/mount so that it
   can discover fuse-service-container support and the caller's
   preferences in using the f-s-c vs. the kernel and whatnot?  Do we
   add another weird x-foo-bar "mount option" so that preferences may
   be specified explicitly?

 4 For defaults situations, where do we make policy about when to use
   f-s-c and when do we allow use of the kernel driver?  I would guess
   that anything in /etc/fstab could use the kernel driver, and
   everything else should use a fuse container if possible.  For
   unprivileged non-root-ns mounts I think we'd only allow the
   container?

<shrug> If we made progress on merging the kernel code in the next three
months, does that clear the way for discussions of 2-4 at LSF?

Also, I hear that FOSSY 2026 will have kernel and KDE tracks, and it's
in Vancouver BC, which could be a good venu to talk to the DE people.

>  - famfs: export distributed memory

This has been, uh, hanging out for an extraordinarily long time.

>  - zero copy for fuse-io-uring
> 
>  - large folios
> 
>  - file handles on the userspace API

(also all that restart stuff, but I think that was already proposed)

>  - compound requests
> 
>  - BPF scripts

Is this an extension of the fuse-bpf filtering discussion that happened
in 2023?  (I wondered why you wouldn't just do bpf hooks in the vfs
itself, but maybe hch already NAKed that?)

As for fuse-iomap -- this week Joanne and I have been working on making
it so that fuse servers can upload ->iomap_{begin,end,ioend} functions
into the kernel as BPF programs to avoid server upcalls.  This might be
a better way to handle the repeating-pattern-iomapping pattern that
seems to exist in famfs than hardcoding things in yet another "upload
iomap mappings" fuse request.

(Yes I see you FUSE_SETUPMAPPING...)

> How do these fit into the existing codebase?
> 
> Cleaner separation of layers:
> 
>  - transport layer: /dev/fuse, io-uring, viriofs

I've noticed that each thread in the libfuse uring backend collects a
pile of CQEs and processes them linearly.  So if it receives 5 CQEs and
the first request takes 30 seconds, the other four just get stuck in
line...?

>  - filesystem layer: local fs, distributed fs

<nod>

> Introduce new version of cleaned up API?
> 
>  - remove async INIT
> 
>  - no fixed ROOT_ID

Can we just merge this?
https://lore.kernel.org/linux-fsdevel/176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs/

>  - consolidate caching rules
> 
>  - who's responsible for updating which metadata?

These two seem like a good combined session -- "who owns what file
metadata?"

>  - remove legacy and problematic flags
> 
>  - get rid of splice on /dev/fuse for new API version?
> 
> Unresolved issues:
> 
>  - locked / writeback folios vs. reclaim / page migration
> 
>  - strictlimiting vs. large folios

/me has no idea about these last four.

--D

