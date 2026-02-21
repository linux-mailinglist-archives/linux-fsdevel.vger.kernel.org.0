Return-Path: <linux-fsdevel+bounces-77840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gVS6IWz+mGl3OwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:38:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B660B16B938
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 01:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14978302BDDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Feb 2026 00:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583EF2BD01B;
	Sat, 21 Feb 2026 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6E42dtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12E280A5B
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Feb 2026 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634276; cv=none; b=tw2+sWN0UjShCPEeoacdHv8W6XGdataZCRUFOw0D0IThqIWp+EJkguPvK8FVydxVlW09jFlakCxRNP/LUOnC7wjTBtk9Vjd/XOoRCDWzwl3ohAB+NZQRL9f0VCTgLILd/SPTcg7GuSRDWP3vD3/GdeUcVpNvOijDfQQVDsjHD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634276; c=relaxed/simple;
	bh=7nSvUYHNKjqv0Yilq55npde3leZYIoywcKzPoMS3i2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICZS8v8gBdbYVpy3y9eZU+Bz1pAyX7Rb6zHis5MjjsMZ5nZr4Y6MCItfnxkT3CswR0MruY0XdIqvTHYnP6fwXpwq9a1niTWO+fuyOK2ZppZX94hOQAsxkF6RrSx62jwOQe30fQTX3yQ6v2NOBcVVCeXLhQbws/qzkHZcYS9QCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6E42dtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1B8C116C6;
	Sat, 21 Feb 2026 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634276;
	bh=7nSvUYHNKjqv0Yilq55npde3leZYIoywcKzPoMS3i2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6E42dtJeNpZKA8xsfADO+gytV1ODW4/Fs0SIbDJ3tn+W5S0irydTbZLJR4bF8jbc
	 3nGb8cDn+qZ7ft6tow8hL58ZjWKQ1E2i6qR1QRbUnIrVDzeoUOMLh3y7DNfgLGu/fc
	 xkilFkDOD7cJb3lvUFwnfOqktcSwUfApkTknfi+Dbt4N4MZunvaY0MMsOtunYElHG8
	 xaDPEJwAOJ3T8sfEFUV2cgZHEYIQvUFXdUO1j7+dL6dg5+Uexdm9mNU+s3VbPN9LrX
	 Do+2d2icmXtur7TngiyKc2NkS6o6qmuToHnVM5RwtJmTH1VXiyKkST6CKfwAJ0nisy
	 aTB2LT2wrHXig==
Date: Fri, 20 Feb 2026 16:37:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <john@groves.net>, Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	"f-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Bernd Schubert <bernd@bsbernd.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260221003756.GD11076@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <aYQNcagFg6-Yz1Fw@groves.net>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
 <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
 <20260206055247.GF7693@frogsfrogsfrogs>
 <aYZOVWXGxagpCYw5@groves.net>
 <CAJnrk1Za2SdCkpJ=sZR8LJ1qvBn8dd3CCsH=PvMrg=_0Jv+40Q@mail.gmail.com>
 <CAJnrk1YMqDKA5gDZasrxGjJtfdbhmjxX5uhUv=OSPyA=G5EE+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1YMqDKA5gDZasrxGjJtfdbhmjxX5uhUv=OSPyA=G5EE+Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77840-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[groves.net,gmail.com,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,bsbernd.com,igalia.com,birthelmer.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[groves.net:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: B660B16B938
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 08:46:26PM -0800, Joanne Koong wrote:
> On Fri, Feb 6, 2026 at 4:22 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Fri, Feb 6, 2026 at 12:48 PM John Groves <john@groves.net> wrote:
> > >
> > > On 26/02/05 09:52PM, Darrick J. Wong wrote:
> > > > On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrote:
> > > > > On Thu, Feb 5, 2026 at 4:33 AM John Groves <john@jagalactic.com> wrote:
> > > > > >
> > > > > > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> > > > > >
> > > > > > [ ... ]
> > > > > >
> > > > > > > >  - famfs: export distributed memory
> > > > > > >
> > > > > > > This has been, uh, hanging out for an extraordinarily long time.
> > > > > >
> > > > > > Um, *yeah*. Although a significant part of that time was on me, because
> > > > > > getting it ported into fuse was kinda hard, my users and I are hoping we
> > > > > > can get this upstreamed fairly soon now. I'm hoping that after the 6.19
> > > > > > merge window dust settles we can negotiate any needed changes etc. and
> > > > > > shoot for the 7.0 merge window.
> > > >
> > > > I think we've all missed getting merged for 7.0 since 6.19 will be
> > > > released in 3 days. :/
> > > >
> > > > (Granted most of the maintainers I know are /much/ less conservative
> > > > than I was about the schedule)
> > >
> > > Doh - right you are...
> > >
> > > >
> > > > > I think that the work on famfs is setting an example, and I very much
> > > > > hope it will be a good example, of how improving existing infrastructure
> > > > > (FUSE) is a better contribution than adding another fs to the pile.
> > > >
> > > > Yeah.  Joanne and I spent a couple of days this week coprogramming a
> > > > prototype of a way for famfs to create BPF programs to handle
> > > > INTERLEAVED_EXTENT files.  We might be ready to show that off in a
> > > > couple of weeks, and that might be a way to clear up the
> > > > GET_FMAP/IOMAP_BEGIN logjam at last.
> > >
> > > I'd love to learn more about this; happy to do a call if that's a
> > > good way to get me briefed.
> > >
> > > I [generally but not specifically] understand how this could avoid
> > > GET_FMAP, but not GET_DAXDEV.
> > >
> > > But I'm not sure it could (or should) avoid dax_iomap_rw() and
> > > dax_iomap_fault(). The thing is that those call my begin() function
> > > to resolve an offset in a file to an offset on a daxdev, and then
> > > dax completes the fault or memcpy. In that dance, famfs never knows
> > > the kernel address of the memory at all (also true of xfs in fs-dax
> > > mode, unless that's changed fairly recently). I think that's a pretty
> > > decent interface all in all.
> > >
> > > Also: dunno whether y'all have looked at the dax patches in the famfs
> > > series, but the solution to working with Alistair's folio-ification
> > > and cleanup of the dax layer (which set me back months) was to create
> > > drivers/dax/fsdev.c, which, when bound to a daxdev in place of
> > > drivers/dax/device.c, configures folios & pages compatibly with
> > > fs-dax. So I kinda think I need the dax_iomap* interface.
> > >
> > > As usual, if I'm overlooking something let me know...
> >
> > Hi John,
> >
> > The conversation started [1] on Darrick's containerization patchset
> > about using bpf to a) avoid extra requests / context switching for
> > ->iomap_begin and ->iomap_end calls and b) offload what would
> > otherwise have to be hard-coded kernel logic into userspace, which
> > gives userspace more flexibility / control with updating the logic and
> > is less of a maintenance burden for fuse. There was some musing [2]
> > about whether with bpf infrastructure added, it would allow famfs to
> > move all famfs-specific logic to userspace/bpf.
> >
> > I agree that it makes sense for famfs to go through dax iomap
> > interfaces. imo it seems cleanest if fuse has a generic iomap
> > interface with iomap dax going through that plumbing, and any
> > famfs-specific logic that would be needed beyond that (eg computing
> > the interleaved mappings) being moved to custom famfs bpf programs. I
> > started trying to implement this yesterday afternoon because I wanted
> > to make sure it would actually be doable for the famfs logic before
> > bringing it up and I didn't want to derail your project. So far I only
> > have the general iomap interface for fuse added with dax operations
> > going through dax_iomap* and haven't tried out integrating the famfs
> > GET_FMAP/GET_DAXDEV bpf program part yet but I'm planning/hoping to
> > get to that early next week. The work I did with Darrick this week was
> > on getting a server's bpf programs hooked up to fuse through bpf links
> > and Darrick has fleshed that out and gotten that working now. If it
> > turns out famfs can go through a generic iomap fuse plumbing layer,
> > I'd be curious to hear your thoughts on which approach you'd prefer.
> 
> I put together a quick prototype to test this out - this is what it
> looks like with fuse having a generic iomap interface that supports
> dax [1], and the famfs custom logic moved to a bpf program [2]. I

The bpf maps that you've used to upload per-inode data into the kernel
is a /much/ cleaner method than custom-compiling C into BPF at runtime!
You can statically compile the BPF object code into the fuse server,
which means that (a) you can take advantage of the bpftool skeletons,
and (b) you can in theory vendor-sign the BPF code if and when that
becomes a requirement.

I think that's way better than having to put vmlinux.h and
fuse_iomap_bpf.h on the deployed system.  Though there's one hitch in
example/Makefile:

vmlinux.h:
	$(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > $@

The build system isn't necessarily running the same kernel as the deploy
images.  It might be for Meta, but it's not unheard of for our build
system to be running (say) OL10+UEK8 kernel, but the build target is OL8
and UEK7.

There doesn't seem to be any standardization across distros for where a
vmlinux.h file might be found.  Fedora puts it under
/usr/src/$unamestuf, Debian puts it in /usr/include/$gcc_triple, and I
guess SUSE doesn't ship it at all?

That's going to be a headache for deployment as I've been muttering for
a couple of weeks now. :(

Maybe we could reduce the fuse-iomap bpf definitions to use only
cardinal types and the types that iomap itself defines.  That might not
be too hard right now because bpf functions reuse structures from
include/uapi/fuse.h, which currently use uint{8,16,32,64}_t.  It'll get
harder if that __uintXX_t -> __uXX transition actually happens.

But getting back to the famfs bpf stuff, I think doing the interleaved
mappings via BPF gives the famfs server a lot more flexibility in terms
of what it can do when future hardware arrives with even weirder
configurations.

--D

> didn't change much, I just moved around your famfs code to the bpf
> side. The kernel side changes are in [3] and the libfuse changes are
> in [4].
> 
> For testing out the prototype, I hooked it up to passthrough_hp to
> test running the bpf program and verify that it is able to find the
> extent from the bpf map. In my opinion, this makes the fuse side
> infrastructure cleaner and more extendable for other servers that will
> want to go through dax iomap in the future, but I think this also has
> a few benefits for famfs. Instead of needing to issue a FUSE_GET_FMAP
> request after a file is opened, the server can directly populate the
> metadata map from userspace with the mapping info when it processes
> the FUSE_OPEN request, which gets rid of the roundtrip cost. The
> server can dynamically update the metadata at any time from userspace
> if the mapping info needs to change in the future. For setting up the
> daxdevs, I moved your logic to the init side, where the server passes
> the daxdev info upfront through an IOMAP_CONFIG exchange with the
> kernel initializing the daxdevs based off that info. I think this will
> also make deploying future updates for famfs easier, as updating the
> logic won't need to go through the upstream kernel mailing list
> process and deploying updates won't require a new kernel release.
> 
> These are just my two cents based on my (cursory) understanding of
> famfs. Just wanted to float this alternative approach in case it's
> useful.
> 
> Thanks,
> Joanne
> 
> [1] https://github.com/joannekoong/linux/commit/b8f9d284a6955391f00f576d890e1c1ccc943cfd
> [2] https://github.com/joannekoong/libfuse/commit/444fa27fa9fd2118a0dc332933197faf9bbf25aa
> [3] https://github.com/joannekoong/linux/commits/prototype_generic_iomap_dax/
> [4] https://github.com/joannekoong/libfuse/commits/famfs_bpf/
> 
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com/t/#md1b8003a109760d8ee1d5397e053673c1978ed4d
> > [2] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyKn-=iFrszqof2c8wGCA@mail.gmail.com/t/#u
> >
> > >
> > > Regards,
> > > John
> > >
> 

