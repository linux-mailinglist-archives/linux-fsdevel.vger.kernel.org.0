Return-Path: <linux-fsdevel+bounces-76535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBSyMH+AhWlmCgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:47:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A61FA702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0F54300CA04
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 05:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382771E5018;
	Fri,  6 Feb 2026 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucTI1UEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD643288B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770356858; cv=none; b=lbowQ0E11C2T7GJA00GAsX6bB35i8U1GnbCWAkobw7kxiCPcvJ20IKWKxg3KutU7Fz9/dK1p/bSQk22tO2APCNrI3IwJA4dMBCxsXABXeontnY/I/RI5uuHcRpSqi/IazWW8G4V8sJZpJXS2no7G9MEsxnAIl4zigSdji7Waufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770356858; c=relaxed/simple;
	bh=weQCcnZsjL9bU/MLVvxtiJyvp5HVK4XtfAfYZ7tjx0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE27VteoRNbc+AR0q+DrG4tkxgktVjWWSvkosOdos63/jZMyfmmVCtVfr55lmEw45TQdK4pUZsEHVhmywXB3OEDRrBjz98iubZE1DJ4ztMRR/W/gINEfypb6nowUWIoeaUYB8ZCdJZSGEQH6y2vspPjL/0FelJlMmLPDcDBt1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucTI1UEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F843C116C6;
	Fri,  6 Feb 2026 05:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770356858;
	bh=weQCcnZsjL9bU/MLVvxtiJyvp5HVK4XtfAfYZ7tjx0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucTI1UExErG3TbeTOvwe6QiQd8GARA8YoDOYU4vn1W6bHXqZhfTC5eDFbpVUzT5SY
	 /hB4r4lmGSJbvI6vgIXDotB16JPtJnhJnpcr01E4MaFJXwv+wW0Ejqc6UGGTPcXcqw
	 F8sTr+3JS3lcUT2gi4arliYso7K1u4zlkxWudoTo3BWyxpySNLqRoTPMhMXb1QmaW6
	 CodIPwsA6IHuu5C4rQpIV58XwjxU2oQsy0cZqGGQ0Ne1oNbVmGFYXB8vUUb21OqaTA
	 UtWNetL+8rhg6q7CDwjs7f0mKbFJ9DoQig2x9Zpg4nWH74P7kEznE+4LRD5y+J5las
	 eVZu8Kz4g90ng==
Date: Thu, 5 Feb 2026 21:47:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, f-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Amir Goldstein <amir73il@gmail.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260206054738.GE7693@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <61a68025-f8c9-451a-9df7-a6a70764bf36@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a68025-f8c9-451a-9df7-a6a70764bf36@bsbernd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,igalia.com,birthelmer.de];
	TAGGED_FROM(0.00)[bounces-76535-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 60A61FA702
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:58:51PM +0100, Bernd Schubert wrote:
> 
> 
> On 2/4/26 20:06, Darrick J. Wong wrote:
> > On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:
> >> I propose a session where various topics of interest could be
> >> discussed including but not limited to the below list
> >>
> >> New features being proposed at various stages of readiness:
> >>
> >>  - fuse4fs: exporting the iomap interface to userspace
> > 
> > FYI, I took a semi-break from fuse-iomap for 7.0 because I was too busy
> > working on xfs_healer, but I was planning to repost the patchbomb with
> > many many cleanups and reorganizations (thanks Joanne!) as soon as
> > possible after Linus tags 7.0-rc1.
> > 
> > I don't think LSFMM is a good venue for discussing a gigantic pile of
> > code, because (IMO) LSF is better spent either (a) retrying in person to
> > reach consensus on things that we couldn't do online; or (b) discussing
> > roadmaps and/or people problems.  In other words, I'd rather use
> > in-person time to go through broader topics that affect multiple people,
> > and the mailing lists for detailed examination of a large body of text.
> > 
> > However -- do you have questions about the design?  That could be a good
> > topic for email /and/ for a face to face meeting.  Though I strongly
> > suspect that there are so many other sub-topics that fuse-iomap could
> > eat up an entire afternoon at LSFMM:
> > 
> >  0 How do we convince $managers to spend money on porting filesystems
> >    to fuse?  Even if they use the regular slow mode?
> > 
> >  1 What's the process for merging all the code changes into libfuse?
> >    The iomap parts are pretty straightforward because libfuse passes
> >    the request/reply straight through to fuse server, but...
> 
> To be honest, I'm rather lost with your patch bomb - in which order do I
> need to review what? And what can be merged without?

If there are any fixes they're usually at the beginning.

At the moment you actually /have/ merged everything that can be. :)

The rest relies on kernel patches that aren't upstream.

> Regarding libfuse patches - certainly helpful if you also post them
> here, but I don't want to create PRs out of your series, which then
> might fail the PR tests and I would have to fix it on my own ;)
> So the right order is to create libfuse PRs, let the test run, let
> everyone review here or via PR and then it gets merged.

I can generate pull requests for the libfuse things, no problem.  The
hard question is, can your CI system build a kernel with the relevant
patches or do we have to wait until Miklos merges them into upstream?

> >  2 ...the fuse service container part involves a bunch of architecture
> >    shifts to libfuse.  First you need a new mount helper to connect to
> >    a unix socket to start the service, pass some resources (fds and
> >    mount options) through the unix socket to the service.  Obviously
> >    that requires new library code for a fuse server to see the unix
> >    socket and request those resources.  After that you also need to
> >    define a systemd service file that stands up the appropriate
> >    sandboxing.  I've not written examples, but that needs to be in the
> >    final product.
> > 
> >  3 What tooling changes to we need to make to /sbin/mount so that it
> >    can discover fuse-service-container support and the caller's
> >    preferences in using the f-s-c vs. the kernel and whatnot?  Do we
> >    add another weird x-foo-bar "mount option" so that preferences may
> >    be specified explicitly?
> > 
> >  4 For defaults situations, where do we make policy about when to use
> >    f-s-c and when do we allow use of the kernel driver?  I would guess
> >    that anything in /etc/fstab could use the kernel driver, and
> >    everything else should use a fuse container if possible.  For
> >    unprivileged non-root-ns mounts I think we'd only allow the
> >    container?
> > 
> > <shrug> If we made progress on merging the kernel code in the next three
> > months, does that clear the way for discussions of 2-4 at LSF?
> > 
> > Also, I hear that FOSSY 2026 will have kernel and KDE tracks, and it's
> > in Vancouver BC, which could be a good venu to talk to the DE people.
> > 
> >>  - famfs: export distributed memory
> > 
> > This has been, uh, hanging out for an extraordinarily long time.
> > 
> >>  - zero copy for fuse-io-uring
> >>
> >>  - large folios
> >>
> >>  - file handles on the userspace API
> > 
> > (also all that restart stuff, but I think that was already proposed)
> > 
> >>  - compound requests
> >>
> >>  - BPF scripts
> > 
> > Is this an extension of the fuse-bpf filtering discussion that happened
> > in 2023?  (I wondered why you wouldn't just do bpf hooks in the vfs
> > itself, but maybe hch already NAKed that?)
> > 
> > As for fuse-iomap -- this week Joanne and I have been working on making
> > it so that fuse servers can upload ->iomap_{begin,end,ioend} functions
> > into the kernel as BPF programs to avoid server upcalls.  This might be
> > a better way to handle the repeating-pattern-iomapping pattern that
> > seems to exist in famfs than hardcoding things in yet another "upload
> > iomap mappings" fuse request.
> > 
> > (Yes I see you FUSE_SETUPMAPPING...)
> > 
> >> How do these fit into the existing codebase?
> >>
> >> Cleaner separation of layers:
> >>
> >>  - transport layer: /dev/fuse, io-uring, viriofs
> > 
> > I've noticed that each thread in the libfuse uring backend collects a
> > pile of CQEs and processes them linearly.  So if it receives 5 CQEs and
> > the first request takes 30 seconds, the other four just get stuck in
> > line...?
> 
> I'm certainly open for suggestions and patches :)

The only things I can think of are

(a) a pool of threads pinned to the same CPU as the CQE reader, but I
don't think that's going to be good for low latency;

(b) as long as the request is still in libfuse, maybe it can decide "I'm
taking too long" and spawn a pthread to hand the request to; or

(c) can other threads steal a CQE to work on if they go idle?  That
might only work for FUSE_DESTROY though, since there won't be new
requests issued after that.

For the particular problems I was seeing with FUSE_DESTROY I picked (b).
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/commit/?h=djwong-wtf&id=e2784aaa0bc0d396fe1c75b826fc140366f576bc

But that also only happens if your kernel has
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=fuse-fixes&id=a9df193a5913e747d8c2830197c4f36d56f42e4c
so there's no action to be taken for libfuse right now.

> At DDN the queues are polled from reactors (co-routine line), that
> additional libfuse API will never go public, but I definitely want to
> finish and if possible implement a new API before I leave (less than 2
> months left). We had a bit of discussion with Stefan Hajnoczi about that
> around last March, but I never came even close that task the whole year.

<nod>

> > 
> >>  - filesystem layer: local fs, distributed fs
> > 
> > <nod>
> > 
> >> Introduce new version of cleaned up API?
> >>
> >>  - remove async INIT
> >>
> >>  - no fixed ROOT_ID
> > 
> > Can we just merge this?
> > https://lore.kernel.org/linux-fsdevel/176169811231.1426070.12996939158894110793.stgit@frogsfrogsfrogs/
> 
> Could you create a libfuse PR please?

Well we'd have to get the kernel patch merged first, and (AFAIK) it's
not queued up for Linux 7.0.

--D

> 
> Thanks,
> Bernd
> 

