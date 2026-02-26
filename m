Return-Path: <linux-fsdevel+bounces-78634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNkZLriroGlulgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:23:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 272C41AF0BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 21:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 771D3302866E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0AD3A4F48;
	Thu, 26 Feb 2026 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEsRA5G9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A746AEED
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137320; cv=pass; b=BSZBElJR7qz/d/wjLGgemOKVvD8hhvdA4dDq/ZnaLXDKRO2F4FwFSFYDPto355Mf4uPHtXh5E5GaxAwdNlqjDl6lEplDG3HjDR2TkNwsvx67PCKEaQF23DesWqylEAaIxK9/D6Mk59tFpSWCsR8GIgLNGTxwX24p661OO5WF7lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137320; c=relaxed/simple;
	bh=8c7uCUYYH11kGv7d2ey4imyEzIpBQMxd2AC0mtGXN5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RvuCBI5gGDPD+lLUbGyUrOTtLuvFvlZuIcKJW7wasBAi+bljF5X0qTu+TCPtceK6iF9doalPvNWgzmJmzo2UVWVAib49rqpVDTNYov3B9IV22CL/iuE0+jIsiKUwgbTYaHkoqRMXv8S9TJKXEvgSUQ5I9nMmHuMMFHPHq/U7ghA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEsRA5G9; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5069b3e0c66so32937371cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 12:21:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772137315; cv=none;
        d=google.com; s=arc-20240605;
        b=GTWdE+dBg6HV+eIpVtDi4NXamOF2gTKcbuAfCwbeChH+TDH9KK0WUNjR4nGr/RJWNV
         NlHjXszrvpYovklNAHwJmaTlF1bsuSTPg+26dMb2cSQnTnsj3rbNE5Xsd+qa27ZydsGG
         notG7whkNap8Ls5xXkZYI9Wy8zzo/57mynQ+xLXH1nzXuwvD3mnW8CB8OjPDGzd/bUUr
         PZoWbNwG9T0LZ806Mn6OzRkXHnyQSW1t7stFWTZfrJlQE1Qj+gkrPapcUDooiyr2FXCe
         yssqClKWwfUw7SC1BLHK+a6JE/XvEyQlu4DVudaPyhHvv+32/VUIj3/aQmQm+nNFRAiZ
         uKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cea5Zzej3BUs3UTCHK1lK0dhc/dD6I7lzLy6XzVpxmk=;
        fh=jHmB4oXgosyeC9blVlxvPDRTUP9m5VTBkTrJdJeBkPo=;
        b=E70lB08Q1an/gZgiCO3EoxoKv9NtUDdum+0LpBAY4er8XzYZNehNo1nGDqMzU0vMhD
         dyYr0W1Lpo/Xx9KgFrrQX9IiXT2umu0jsteRvi8O3DsYV+zuIfZl3k4cz0JnPSg1nAEm
         Hv/0fSy8P1tzIaUWih77bh9Se/kYR23w6I+C8w+pYZuxQWlI095UjKBSouCxbWzyyPpF
         X2uerNZ1CTb+cw7J8882Wv3xiZdcnUySy5nfO8JXMKvZw+KyX/jL6FTUVl4nPDcvbxAy
         NZtziqqPzdQW8I6/aHkcmPCiMphew72u3GuzkqXJCOrcCl4oEjvYCp3Q3zThV9o3xnRd
         iU5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772137315; x=1772742115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cea5Zzej3BUs3UTCHK1lK0dhc/dD6I7lzLy6XzVpxmk=;
        b=lEsRA5G9Q2u6ftRAQqhusLz6VKxS5wZlL0lImdQpR+QaqZ7Au/FgDiRb9+ZxAW9J2u
         1mKHxlvnYEnfHWSVGeuv+59i6TgnArzyAoUbzEBq1FCPkis0sQ+xFQBxfAj58gmE1YRR
         URoSLGSasQJRdRP+7RhN2jOAmozBHjfmistmc5ERJ3v4+ENfUxfNAtOJoc3KnyzRc/Sx
         NgeVziODMFqZC62k1DxuF4QeBzpuMPw+Ep3wkIECnTmzwYahlvbNcUTkpnRUK7gBnD+a
         Gen7TGXqBo7gulW8tLCg5Qo8mRxbgFpMxDYLRx90kY3JR85xtc2BOGQOwBdx18adAaus
         9aPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772137315; x=1772742115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cea5Zzej3BUs3UTCHK1lK0dhc/dD6I7lzLy6XzVpxmk=;
        b=KIcahlU179fcfHFzdoX8H7EuODUJ9wD4TU09KQiZmDvLdHpWZJDrdyW4AngLBJlVQ/
         4AtBiCOaPRfeVzEwDPdWj0G29GuzTmdSg5o+OVL43Yda5WaFi12MhLXIDMbG87YZpLw2
         P2hjFiYIMrdq1iMEDhsJ8EmNfescAwkZ21OlUt0PBCiKds4kV8dAf9nRDjezjnG8ZLWz
         LI38fV6xx234s1jTRP5N5PrQB2mUY9jOEB4VzPHlIBywDYrOYl1adFxoSPWpW6FYuyw/
         2lnyEESXyf4vNG8caCHOtzvyTpy4a4N0WQ4PSae3ou03SJPkgJ6v+LSEnJB2HZrgcry9
         ROaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCSdJHJxcMgndu/B3F5ejm/8BMsIRBoUWnvR8vY0rPO4wDAlZbDhuZfOAIr/9ET9+gHme3MsWixJ5s5uP9@vger.kernel.org
X-Gm-Message-State: AOJu0YzSSeAJSPMNs2KpMlTiRC1nYLL4YXooxXpC7zRfg7dVUbunp8kh
	Ibom5arw+ivRR3tDm+GFrPvr6UMG0BC2aksEY6mkvHIzyCbz3TdMfhxeWTkyqWYH7SseyCXTRBV
	mWtE7gmXjCb16jHrtnnUUx7FX0QLwI64=
X-Gm-Gg: ATEYQzxkUDRjy1y3DNVMZj7S1LeOJZju/L6qBUA+gXFLMT7vNKojPenvoF8Tr9pdPUH
	b7o9BF2vPXqXgKQbA1Kt2O/1djMjJ/RUOI28XLWPldnJ1/K+1SETddBJISJeft36KU9pz+BkK9a
	x6ffeYVoMP+rt7HFRt9zdd6q6Hq6lW7sgUbCYfX9n5iDJFjk+vlKEvSZgoY4ovtUCizMW5RKFC0
	s0s4A8xfzFvhXB8+iognbdu1QLeisKwCb1GFmr7FFBToS9Qy4fvJpuXWh6jOsCcig+/Nd6hF1Gv
	JMV5SMSkXSNPHnMZ
X-Received: by 2002:a05:622a:1a85:b0:4ed:a2dc:9e51 with SMTP id
 d75a77b69052e-507443e205cmr55155911cf.21.1772137315032; Thu, 26 Feb 2026
 12:21:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <aYQNcagFg6-Yz1Fw@groves.net> <20260204190649.GB7693@frogsfrogsfrogs>
 <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
 <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
 <20260206055247.GF7693@frogsfrogsfrogs> <aYZOVWXGxagpCYw5@groves.net>
 <CAJnrk1Za2SdCkpJ=sZR8LJ1qvBn8dd3CCsH=PvMrg=_0Jv+40Q@mail.gmail.com>
 <CAJnrk1YMqDKA5gDZasrxGjJtfdbhmjxX5uhUv=OSPyA=G5EE+Q@mail.gmail.com> <20260221003756.GD11076@frogsfrogsfrogs>
In-Reply-To: <20260221003756.GD11076@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Feb 2026 12:21:43 -0800
X-Gm-Features: AaiRm52kh8nmAzlkOVWNwRZqYj2bcoRNNuggsFe27urX-EnbtsToTf3xWcmnoOM
Message-ID: <CAJnrk1ZJksW=uz1itdh+zoaQBo_XQ4ZSF13BSnZXMie5pBCvYA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@groves.net>, Amir Goldstein <amir73il@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, 
	"f-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Bernd Schubert <bernd@bsbernd.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jagalactic.com:email];
	FREEMAIL_CC(0.00)[groves.net,gmail.com,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,bsbernd.com,igalia.com,birthelmer.de];
	TAGGED_FROM(0.00)[bounces-78634-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 272C41AF0BD
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 4:37=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Feb 11, 2026 at 08:46:26PM -0800, Joanne Koong wrote:
> > On Fri, Feb 6, 2026 at 4:22=E2=80=AFPM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > On Fri, Feb 6, 2026 at 12:48=E2=80=AFPM John Groves <john@groves.net>=
 wrote:
> > > >
> > > > On 26/02/05 09:52PM, Darrick J. Wong wrote:
> > > > > On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrote:
> > > > > > On Thu, Feb 5, 2026 at 4:33=E2=80=AFAM John Groves <john@jagala=
ctic.com> wrote:
> > > > > > >
> > > > > > > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> > > > > > >
> > > > > > > [ ... ]
> > > > > > >
> > > > > > > > >  - famfs: export distributed memory
> > > > > > > >
> > > > > > > > This has been, uh, hanging out for an extraordinarily long =
time.
> > > > > > >
> > > > > > > Um, *yeah*. Although a significant part of that time was on m=
e, because
> > > > > > > getting it ported into fuse was kinda hard, my users and I ar=
e hoping we
> > > > > > > can get this upstreamed fairly soon now. I'm hoping that afte=
r the 6.19
> > > > > > > merge window dust settles we can negotiate any needed changes=
 etc. and
> > > > > > > shoot for the 7.0 merge window.
> > > > >
> > > > > I think we've all missed getting merged for 7.0 since 6.19 will b=
e
> > > > > released in 3 days. :/
> > > > >
> > > > > (Granted most of the maintainers I know are /much/ less conservat=
ive
> > > > > than I was about the schedule)
> > > >
> > > > Doh - right you are...
> > > >
> > > > >
> > > > > > I think that the work on famfs is setting an example, and I ver=
y much
> > > > > > hope it will be a good example, of how improving existing infra=
structure
> > > > > > (FUSE) is a better contribution than adding another fs to the p=
ile.
> > > > >
> > > > > Yeah.  Joanne and I spent a couple of days this week coprogrammin=
g a
> > > > > prototype of a way for famfs to create BPF programs to handle
> > > > > INTERLEAVED_EXTENT files.  We might be ready to show that off in =
a
> > > > > couple of weeks, and that might be a way to clear up the
> > > > > GET_FMAP/IOMAP_BEGIN logjam at last.
> > > >
> > > > I'd love to learn more about this; happy to do a call if that's a
> > > > good way to get me briefed.
> > > >
> > > > I [generally but not specifically] understand how this could avoid
> > > > GET_FMAP, but not GET_DAXDEV.
> > > >
> > > > But I'm not sure it could (or should) avoid dax_iomap_rw() and
> > > > dax_iomap_fault(). The thing is that those call my begin() function
> > > > to resolve an offset in a file to an offset on a daxdev, and then
> > > > dax completes the fault or memcpy. In that dance, famfs never knows
> > > > the kernel address of the memory at all (also true of xfs in fs-dax
> > > > mode, unless that's changed fairly recently). I think that's a pret=
ty
> > > > decent interface all in all.
> > > >
> > > > Also: dunno whether y'all have looked at the dax patches in the fam=
fs
> > > > series, but the solution to working with Alistair's folio-ification
> > > > and cleanup of the dax layer (which set me back months) was to crea=
te
> > > > drivers/dax/fsdev.c, which, when bound to a daxdev in place of
> > > > drivers/dax/device.c, configures folios & pages compatibly with
> > > > fs-dax. So I kinda think I need the dax_iomap* interface.
> > > >
> > > > As usual, if I'm overlooking something let me know...
> > >
> > > Hi John,
> > >
> > > The conversation started [1] on Darrick's containerization patchset
> > > about using bpf to a) avoid extra requests / context switching for
> > > ->iomap_begin and ->iomap_end calls and b) offload what would
> > > otherwise have to be hard-coded kernel logic into userspace, which
> > > gives userspace more flexibility / control with updating the logic an=
d
> > > is less of a maintenance burden for fuse. There was some musing [2]
> > > about whether with bpf infrastructure added, it would allow famfs to
> > > move all famfs-specific logic to userspace/bpf.
> > >
> > > I agree that it makes sense for famfs to go through dax iomap
> > > interfaces. imo it seems cleanest if fuse has a generic iomap
> > > interface with iomap dax going through that plumbing, and any
> > > famfs-specific logic that would be needed beyond that (eg computing
> > > the interleaved mappings) being moved to custom famfs bpf programs. I
> > > started trying to implement this yesterday afternoon because I wanted
> > > to make sure it would actually be doable for the famfs logic before
> > > bringing it up and I didn't want to derail your project. So far I onl=
y
> > > have the general iomap interface for fuse added with dax operations
> > > going through dax_iomap* and haven't tried out integrating the famfs
> > > GET_FMAP/GET_DAXDEV bpf program part yet but I'm planning/hoping to
> > > get to that early next week. The work I did with Darrick this week wa=
s
> > > on getting a server's bpf programs hooked up to fuse through bpf link=
s
> > > and Darrick has fleshed that out and gotten that working now. If it
> > > turns out famfs can go through a generic iomap fuse plumbing layer,
> > > I'd be curious to hear your thoughts on which approach you'd prefer.
> >
> > I put together a quick prototype to test this out - this is what it
> > looks like with fuse having a generic iomap interface that supports
> > dax [1], and the famfs custom logic moved to a bpf program [2]. I
>
> The bpf maps that you've used to upload per-inode data into the kernel
> is a /much/ cleaner method than custom-compiling C into BPF at runtime!
> You can statically compile the BPF object code into the fuse server,
> which means that (a) you can take advantage of the bpftool skeletons,
> and (b) you can in theory vendor-sign the BPF code if and when that
> becomes a requirement.
>
> I think that's way better than having to put vmlinux.h and
> fuse_iomap_bpf.h on the deployed system.  Though there's one hitch in
> example/Makefile:
>
> vmlinux.h:
>         $(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > $@
>
> The build system isn't necessarily running the same kernel as the deploy
> images.  It might be for Meta, but it's not unheard of for our build
> system to be running (say) OL10+UEK8 kernel, but the build target is OL8
> and UEK7.
>
> There doesn't seem to be any standardization across distros for where a
> vmlinux.h file might be found.  Fedora puts it under
> /usr/src/$unamestuf, Debian puts it in /usr/include/$gcc_triple, and I
> guess SUSE doesn't ship it at all?
>
> That's going to be a headache for deployment as I've been muttering for
> a couple of weeks now. :(

I don't think this is an issue because bpf does dynamic btf-based
relocations (CO-RE) at load time [1]. On the target machine, when
libbpf loads the bpf object it will read the machine's btf and patch
any offsets in bytecode and load the fixed-up version into the kernel.
All that's needed on the target machine for CO-RE is
CONFIG_DEBUG_INFO_BTF=3Dy which is enabled by default on mainstream
distributions. I think this addresses the deployment headache you've
been running into?

Thanks,
Joanne

[1] https://docs.ebpf.io/concepts/core/

>
> Maybe we could reduce the fuse-iomap bpf definitions to use only
> cardinal types and the types that iomap itself defines.  That might not
> be too hard right now because bpf functions reuse structures from
> include/uapi/fuse.h, which currently use uint{8,16,32,64}_t.  It'll get
> harder if that __uintXX_t -> __uXX transition actually happens.
>
> But getting back to the famfs bpf stuff, I think doing the interleaved
> mappings via BPF gives the famfs server a lot more flexibility in terms
> of what it can do when future hardware arrives with even weirder
> configurations.
>
> --D
>
> > didn't change much, I just moved around your famfs code to the bpf
> > side. The kernel side changes are in [3] and the libfuse changes are
> > in [4].
> >
> > For testing out the prototype, I hooked it up to passthrough_hp to
> > test running the bpf program and verify that it is able to find the
> > extent from the bpf map. In my opinion, this makes the fuse side
> > infrastructure cleaner and more extendable for other servers that will
> > want to go through dax iomap in the future, but I think this also has
> > a few benefits for famfs. Instead of needing to issue a FUSE_GET_FMAP
> > request after a file is opened, the server can directly populate the
> > metadata map from userspace with the mapping info when it processes
> > the FUSE_OPEN request, which gets rid of the roundtrip cost. The
> > server can dynamically update the metadata at any time from userspace
> > if the mapping info needs to change in the future. For setting up the
> > daxdevs, I moved your logic to the init side, where the server passes
> > the daxdev info upfront through an IOMAP_CONFIG exchange with the
> > kernel initializing the daxdevs based off that info. I think this will
> > also make deploying future updates for famfs easier, as updating the
> > logic won't need to go through the upstream kernel mailing list
> > process and deploying updates won't require a new kernel release.
> >
> > These are just my two cents based on my (cursory) understanding of
> > famfs. Just wanted to float this alternative approach in case it's
> > useful.
> >
> > Thanks,
> > Joanne
> >
> > [1] https://github.com/joannekoong/linux/commit/b8f9d284a6955391f00f576=
d890e1c1ccc943cfd
> > [2] https://github.com/joannekoong/libfuse/commit/444fa27fa9fd2118a0dc3=
32933197faf9bbf25aa
> > [3] https://github.com/joannekoong/linux/commits/prototype_generic_ioma=
p_dax/
> > [4] https://github.com/joannekoong/libfuse/commits/famfs_bpf/
> >
> > >
> > > Thanks,
> > > Joanne
> > >
> > > [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxE=
XbcEyKn-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#md1b8003a109760d8ee1d5397e0536=
73c1978ed4d
> > > [2] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxE=
XbcEyKn-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#u
> > >
> > > >
> > > > Regards,
> > > > John
> > > >
> >

