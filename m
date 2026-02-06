Return-Path: <linux-fsdevel+bounces-76545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HC7EteJhWkWDQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:27:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F37FCFAA96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFFD73015100
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214AC3385A3;
	Fri,  6 Feb 2026 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enwQcnT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F53382DF
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359215; cv=none; b=RAAUeRfD7xYeGjX4vkbiyMLT/yoPuXH9AG3HpjIU2/Ovj9MlMSR3vRSBUcXIwsi9+onVYFFQi0JHZ4EmOtvEwKXTxcidixpbk6+4pSrddAm/qAqdsdDyQPUPelt0NiMvoypxDceXq8jbAOwTudEIQ1bG2USciJVpK2d0sWhTtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359215; c=relaxed/simple;
	bh=XhU8Qoh5dtPBKStKad9CzzN9lgP3YPtPMriWYmrqSmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqxRD0difRzLhiW6oXMWWgZfJWtGeeoWHl9z8WnHf1Wz3B5mQ7KNcU6c9YMwCtAGY1Z+JlrxWh/Luw9QtyGhxTRdsnmfKVro9mZTf4RBdj+C5l6AqZJx2vE4BTZSQJi2fA/lpcKAi5aJtqUyQP8gg/cX1TyDfB+pArLQ98WBgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enwQcnT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D10C19424;
	Fri,  6 Feb 2026 06:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770359215;
	bh=XhU8Qoh5dtPBKStKad9CzzN9lgP3YPtPMriWYmrqSmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enwQcnT7YHhRVoGA8o/R+Yxr5n+aerEJQbgG3C/pJ3CO3an/DIJTM51ogP/coKc/E
	 egIYkDEd0o729IBQcy2RF35K9NIYSqEt2Q/fmwjOK/qF0Rz4x68DLVnZ4vF+NufevP
	 yfb0j4SxKOfpAcVHJ7aYV2t+EaswnSi0KvbB4iwQw3rDdB3noaxw8NHv3Szp/gPPCP
	 sepucSDZNy3FWpeudmg8JIpcTcATsWgXXGtMxKXJKJeQQ3aykYQQmPbhSm3LXRIkyT
	 Z6WrN55GTG/Z0E++VPX7ak0ZnfDy4C5WkWlJX9d4gH8foCY5gienqFLZGytXMWV/wF
	 yl93MuG2siidg==
Date: Thu, 5 Feb 2026 22:26:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>,
	Bernd Schubert <bernd@bsbernd.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260206062654.GH7693@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
 <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YKDi9e-eTQyGBD-rFScxGTcsfz3tnmnE_EshPd18aMrw@mail.gmail.com>
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
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,vger.kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76545-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: F37FCFAA96
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:22:02AM -0800, Joanne Koong wrote:
> On Mon, Feb 2, 2026 at 11:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 2 Feb 2026 at 17:14, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > All important topics which I am sure will be discussed on a FUSE BoF.
> 
> Two other items I'd like to add to the potential discussion list are:
> 
> * leveraging io-uring multishot for batching fuse writeback and
> readahead requests, ie maximizing the throughput per roundtrip context
> switch [1]
> 
> * settling how load distribution should be done for configurable
> queues. We came to a bit of a standstill on Bernd's patchset [2] and
> it would be great to finally get this resolved and the feature landed.
> imo configurable queues and incremental buffer consumption are the two
> main features needed to make fuse-over-io-uring more feasible on
> large-scale systems.
> 
> >
> > I see your point.   Maybe the BPF one could be useful as a cross track
> > discussion, though I'm not sure the fuse side of the design is mature
> > enough for that.  Joanne, you did some experiments with that, no?
> 
> The discussion on this was started in response [3] to Darrick's iomap
> containerization patchset. I have a prototype based on [4] I can get
> into reviewable shape this month or next, if there's interest in
> getting something concrete before May. I did a quick check with the

(Which we're working on :D)

> bpf team a few days ago and confirmed with them that struct ops is the
> way to go for adding the hook point for fuse. For attaching the bpf
> progs to the fuse connection, going through the bpf link interface is
> the modern/preferred way of doing this.

Yes.  That conversion turned out not to be too difficult, but the
resulting uapi is a little awkward because you have to pass the
/dev/fuse fd in one of the structs that you pass to the bpf syscall,
and then the bpf functions have to go find the struct file and use that
to get back to the fuse_conn.

> Discussion wise, imo on the
> fuse side what would be most useful to discuss in May would be what
> other interception points do we think would be the most useful in fuse
> and what should the API interfaces that we expose for those look like
> (eg should these just take the in/out request structs already defined
> in the uapi? or expose more state information?). imo, we should take
> an incremental approach and add interception points more
> conservatively than liberally, on a per-need basis as use cases
> actually come up.

I would start by only allowing iomap_{begin,end,ioend} bpf functions,
and only let them access the same in-arguments and outarg struct as the
fuse server upcall would have.

(I don't have any opinions on the fuse-bpf filtering stuff that was
discussed at lsfmm 2023)

> > > I think that at least one question of interest to the wider fs audience is
> > >
> > > Can any of the above improvements be used to help phase out some
> > > of the old under maintained fs and reduce the burden on vfs maintainers?
> 
> I think it might be helpful to know ahead of time where the main
> hesitation lies. Is it performance? Maybe it'd be helpful if before
> May there was a prototype converting a simpler filesystem (Darrick and
> I were musing about fat maybe being a good one) and getting a sense of
> what the delta is between the native kernel implementation and a
> fuse-based version? In the past year fuse added a lot of new
> capabilities that improved performance by quite a bit so I'm curious
> to see where the delta now lies. Or maybe the hesitation is something
> else entirely, in which case that's probably a conversation better
> left for May.

TBH I think it's mostly inertia because the current solutions aren't so
bad that our managers are screaming at us to get 'er done now. :P

That and conversion is a lot of work.

--D

> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1Z3mTdZdfe5rTukKOnU0y5dpM8aFTCqbctBWsa-S301TQ@mail.gmail.com/
> 
> [2] https://lore.kernel.org/linux-fsdevel/20251013-reduced-nr-ring-queues_3-v3-4-6d87c8aa31ae@ddn.com/t/#u
> 
> [3] https://lore.kernel.org/linux-fsdevel/CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com/t/#u
> 
> [4] https://lore.kernel.org/linux-fsdevel/176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs/T/#m4998d92f6210d50d0bf6760490689c029bda9231
> 
> >
> > I think the major show stopper is that nobody is going to put a major
> > effort into porting unmaintained kernel filesystems to a different
> > framework.
> >
> > Alternatively someone could implement a "VFS emulator" library.  But
> > keeping that in sync with the kernel, together with all the old fs
> > would be an even greater burden...
> >
> > Thanks,
> > Miklos
> 

