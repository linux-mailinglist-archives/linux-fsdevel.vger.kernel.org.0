Return-Path: <linux-fsdevel+bounces-76989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEd6BTlbjWmw1QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 05:46:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64A12A52D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 05:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01D0330EB79B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Feb 2026 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71961A38F9;
	Thu, 12 Feb 2026 04:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIUpt2/R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB1134AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 04:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770871600; cv=pass; b=JADIW44hKDNAHEpRplhZDcCbLioo3Z1wj5WnFB6Wkm6+kNfrNjd8czna93u3PNN/PRY8kTH5v1mhM5/yy9TcA8t6VhlsonxO9lM7S3E2bhgfjt5DB59FraJ2BJIGB776/eLdC/3RnDGP7jGU8V0MH/fo90mv7YQJ3kVvVNMWdLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770871600; c=relaxed/simple;
	bh=YFieCLwnmzLgnJ+JpH91cZmczewVJfTZqSUI64SS6Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qolghBtrZgv7TLk1b8W3Zwa+S8ozaB3pU0F9MO5s2HrHeQg8FU7KFWi+Qk/zcBgYitRlvXEW8aZwe3vUVYwH+JtC+Z3YBASY43Hyp8eWT3ZH2+KcWDNKLyaHRmP+T8toWMwwHb3X2ANH+9CwL/5fuzKCuPf+Z0eNf66GjtDx0bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIUpt2/R; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-502acd495feso67000131cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 20:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770871598; cv=none;
        d=google.com; s=arc-20240605;
        b=JLj1qTh6twomcOX5z2ODjuzJlCQSocNsaJ0r+xe9Q1N38/Kjg3VDT9+AIeVq6Gk+zX
         ZcbJv2feia1GMxjHqvxr1ojrKPPJq8u3PV5h+sLuMSz6qVrA8G2QfCu+mnVw+pcwrBix
         /mJe/F07yNPnnzQLVG64VxzV0Ols9HsekJw1mIl35NkUVTxrpl5gZXYKBhObOduOf0l6
         mQkdRjEH9rTdA3PzN6FGNpXGSjSstoCQHAyc1ogU6RJkbraCEQBnjnhD2y2QCW7dpudJ
         PxZt3WSv2EpGeLs9E2VDu9YuBzUNSiyyUM5hSIK2XP9MfeSFTBP5H3XUHnJ/AmMEdgnU
         9HCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZHOoSCUCTlS+rDb4HQIaNpIxuyIjSeoJM+Mim8mRjyk=;
        fh=q83CbfvMG1w98XLkPs9lXOK6LFzbOkm7Kpt2+g0vn20=;
        b=k8G9sdTDd/xCFTlPnrnUvfz3zsyP90TTBRWZRnw7jlfu8gVnYPzJF/ZR6QQYBQVBsL
         F9F6PBcz6Tojo6XzEHlMgh+q5pExat6QM1dtwuGZF05qcIVTLOf+Q0CJPVekc3YAVN9L
         VheZTafagvQAEvh2sxX+zU75b060OPibDjBZKXhBdA9IboxzyhluyVTbXzUV/zIhtJWO
         yLcCcxXKPaQBtP+07tWsMZGBmukbdDGhf2AU/etTBHev39pnYrbAJ3UrqY0RzLF8I5Rs
         jAJdOkdibZ1/UU6fWeaUYLaHNPnza+MB8htqrKo3aZNy/plStZT2kViVctxldPA4Rb4a
         tn+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770871598; x=1771476398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHOoSCUCTlS+rDb4HQIaNpIxuyIjSeoJM+Mim8mRjyk=;
        b=iIUpt2/RZJVECoOSRon41iTLwKeoIKHLTjKZB0aQ+U/XvKrCo3X/24z9555jfABM4c
         h9d1tufAV6WvpIrYX4YhQphuwof+93fTunVsBj4AD59K98zbwm4hdC7UPlpo5z+N9e86
         oF5Xva0oe4FCqHWyQk5/uS83bL7/WBQNBOHmzf498FhxuCGt4M0gqPPfCwSNKWeEpV/m
         bgxeTTMZnYIo2pj11jVqQc54hILkqpv2jrBOHYbK/auFWfoUw0I3EgM7EWQyiJcanIRE
         LUENRo1TmKJBp608FVoR2rYMfYAArlE55fqG33qMRW/beAYMQzrBDXPenEqsshDGco4e
         49ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770871598; x=1771476398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHOoSCUCTlS+rDb4HQIaNpIxuyIjSeoJM+Mim8mRjyk=;
        b=gBHV008uotKrkoL7TMT7jX8UN1EdAML0GzsSCA0if1DtusYQIcKI8EXJx2byWzWNui
         1GTnXIbr4yt0pFDhkh1ptFMCHDGFJDZrxhkN5SdGiVTJ25z48YPJYjp7FL9HBGZIQDU9
         JvXzBUFGu4+j8s//1jaK1yK23WFMcarsXlW/DbZNak5a3CVtMU5JHTrshm4XTin2a7gl
         0t/5CWD3v2k/bL+/sVzJpHxp6xnNvyQ/ol8NrIsznYjGCsT0khkqI8HX9HL7qNHV+Chb
         Sh2/vM8b21datUjDOC56Yb2o+PRhKMOIS0nnWuY7dFRuckycwb47vhD+BYaq56dCBQiw
         vyhg==
X-Forwarded-Encrypted: i=1; AJvYcCVDA+Zxu8hVpUFLGnyl3gcyailYWz6ELJePLEmQnKDMuX7bY6oOU66jn6SyEniFjTl5tBUWkHEBpUNvHxlm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4DIpRW8mwAoDz1c851dNUmz8TQorJjnAyVDjSWBH4feRUqe5
	T5c2YscArdfkpRFUr/wgPX/klJyNJjPhq4lR3JDFUDURlAvBD00c1KGa0Qwe7E8BI+pOn26M2Dh
	oUBASYZF3UveznopSOk0i5Uzg9ilMHbY=
X-Gm-Gg: AZuq6aLGHgplRZkxHquO3TLvMGfhTo8gNdnqIut+c96X43p2rVp03J2YFsqPNXZ6FB8
	lf3dtqd5gX2DuwErR8nciud5hakweYR/4VJeBhHZq+9yvYF+GTVS0zwkvTLJ8jKRSxMpZopYLB3
	cztLrK+Rb7CgqS3ldDQpYqlViD8VewKg2CUaZ2VsS/mm6RIoFt4LAm331IK0YSVhp5rRj3ZMHL9
	wf4+ZKyIhO5pMi4UhO6mKXn7Y3X6/hqzZ5+vsf/Pk9fMr0AVq1A5y1T0aoRb03zHMRaLDnn6Tt/
	XznN8Q==
X-Received: by 2002:a05:622a:8e:b0:501:5284:c49b with SMTP id
 d75a77b69052e-50691efd73dmr24440781cf.39.1770871597749; Wed, 11 Feb 2026
 20:46:37 -0800 (PST)
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
 <20260206055247.GF7693@frogsfrogsfrogs> <aYZOVWXGxagpCYw5@groves.net> <CAJnrk1Za2SdCkpJ=sZR8LJ1qvBn8dd3CCsH=PvMrg=_0Jv+40Q@mail.gmail.com>
In-Reply-To: <CAJnrk1Za2SdCkpJ=sZR8LJ1qvBn8dd3CCsH=PvMrg=_0Jv+40Q@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 11 Feb 2026 20:46:26 -0800
X-Gm-Features: AZwV_Qj-hwUIYbdnsdsPYMstasOEjSJhdIj14Uq7ZVwNrrDwTsZ2XO25C0pd2nw
Message-ID: <CAJnrk1YMqDKA5gDZasrxGjJtfdbhmjxX5uhUv=OSPyA=G5EE+Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: John Groves <john@groves.net>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76989-lists,linux-fsdevel=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,bsbernd.com,igalia.com,birthelmer.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,groves.net:email,jagalactic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 4E64A12A52D
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 4:22=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Fri, Feb 6, 2026 at 12:48=E2=80=AFPM John Groves <john@groves.net> wro=
te:
> >
> > On 26/02/05 09:52PM, Darrick J. Wong wrote:
> > > On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrote:
> > > > On Thu, Feb 5, 2026 at 4:33=E2=80=AFAM John Groves <john@jagalactic=
.com> wrote:
> > > > >
> > > > > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > >  - famfs: export distributed memory
> > > > > >
> > > > > > This has been, uh, hanging out for an extraordinarily long time=
.
> > > > >
> > > > > Um, *yeah*. Although a significant part of that time was on me, b=
ecause
> > > > > getting it ported into fuse was kinda hard, my users and I are ho=
ping we
> > > > > can get this upstreamed fairly soon now. I'm hoping that after th=
e 6.19
> > > > > merge window dust settles we can negotiate any needed changes etc=
. and
> > > > > shoot for the 7.0 merge window.
> > >
> > > I think we've all missed getting merged for 7.0 since 6.19 will be
> > > released in 3 days. :/
> > >
> > > (Granted most of the maintainers I know are /much/ less conservative
> > > than I was about the schedule)
> >
> > Doh - right you are...
> >
> > >
> > > > I think that the work on famfs is setting an example, and I very mu=
ch
> > > > hope it will be a good example, of how improving existing infrastru=
cture
> > > > (FUSE) is a better contribution than adding another fs to the pile.
> > >
> > > Yeah.  Joanne and I spent a couple of days this week coprogramming a
> > > prototype of a way for famfs to create BPF programs to handle
> > > INTERLEAVED_EXTENT files.  We might be ready to show that off in a
> > > couple of weeks, and that might be a way to clear up the
> > > GET_FMAP/IOMAP_BEGIN logjam at last.
> >
> > I'd love to learn more about this; happy to do a call if that's a
> > good way to get me briefed.
> >
> > I [generally but not specifically] understand how this could avoid
> > GET_FMAP, but not GET_DAXDEV.
> >
> > But I'm not sure it could (or should) avoid dax_iomap_rw() and
> > dax_iomap_fault(). The thing is that those call my begin() function
> > to resolve an offset in a file to an offset on a daxdev, and then
> > dax completes the fault or memcpy. In that dance, famfs never knows
> > the kernel address of the memory at all (also true of xfs in fs-dax
> > mode, unless that's changed fairly recently). I think that's a pretty
> > decent interface all in all.
> >
> > Also: dunno whether y'all have looked at the dax patches in the famfs
> > series, but the solution to working with Alistair's folio-ification
> > and cleanup of the dax layer (which set me back months) was to create
> > drivers/dax/fsdev.c, which, when bound to a daxdev in place of
> > drivers/dax/device.c, configures folios & pages compatibly with
> > fs-dax. So I kinda think I need the dax_iomap* interface.
> >
> > As usual, if I'm overlooking something let me know...
>
> Hi John,
>
> The conversation started [1] on Darrick's containerization patchset
> about using bpf to a) avoid extra requests / context switching for
> ->iomap_begin and ->iomap_end calls and b) offload what would
> otherwise have to be hard-coded kernel logic into userspace, which
> gives userspace more flexibility / control with updating the logic and
> is less of a maintenance burden for fuse. There was some musing [2]
> about whether with bpf infrastructure added, it would allow famfs to
> move all famfs-specific logic to userspace/bpf.
>
> I agree that it makes sense for famfs to go through dax iomap
> interfaces. imo it seems cleanest if fuse has a generic iomap
> interface with iomap dax going through that plumbing, and any
> famfs-specific logic that would be needed beyond that (eg computing
> the interleaved mappings) being moved to custom famfs bpf programs. I
> started trying to implement this yesterday afternoon because I wanted
> to make sure it would actually be doable for the famfs logic before
> bringing it up and I didn't want to derail your project. So far I only
> have the general iomap interface for fuse added with dax operations
> going through dax_iomap* and haven't tried out integrating the famfs
> GET_FMAP/GET_DAXDEV bpf program part yet but I'm planning/hoping to
> get to that early next week. The work I did with Darrick this week was
> on getting a server's bpf programs hooked up to fuse through bpf links
> and Darrick has fleshed that out and gotten that working now. If it
> turns out famfs can go through a generic iomap fuse plumbing layer,
> I'd be curious to hear your thoughts on which approach you'd prefer.

I put together a quick prototype to test this out - this is what it
looks like with fuse having a generic iomap interface that supports
dax [1], and the famfs custom logic moved to a bpf program [2]. I
didn't change much, I just moved around your famfs code to the bpf
side. The kernel side changes are in [3] and the libfuse changes are
in [4].

For testing out the prototype, I hooked it up to passthrough_hp to
test running the bpf program and verify that it is able to find the
extent from the bpf map. In my opinion, this makes the fuse side
infrastructure cleaner and more extendable for other servers that will
want to go through dax iomap in the future, but I think this also has
a few benefits for famfs. Instead of needing to issue a FUSE_GET_FMAP
request after a file is opened, the server can directly populate the
metadata map from userspace with the mapping info when it processes
the FUSE_OPEN request, which gets rid of the roundtrip cost. The
server can dynamically update the metadata at any time from userspace
if the mapping info needs to change in the future. For setting up the
daxdevs, I moved your logic to the init side, where the server passes
the daxdev info upfront through an IOMAP_CONFIG exchange with the
kernel initializing the daxdevs based off that info. I think this will
also make deploying future updates for famfs easier, as updating the
logic won't need to go through the upstream kernel mailing list
process and deploying updates won't require a new kernel release.

These are just my two cents based on my (cursory) understanding of
famfs. Just wanted to float this alternative approach in case it's
useful.

Thanks,
Joanne

[1] https://github.com/joannekoong/linux/commit/b8f9d284a6955391f00f576d890=
e1c1ccc943cfd
[2] https://github.com/joannekoong/libfuse/commit/444fa27fa9fd2118a0dc33293=
3197faf9bbf25aa
[3] https://github.com/joannekoong/linux/commits/prototype_generic_iomap_da=
x/
[4] https://github.com/joannekoong/libfuse/commits/famfs_bpf/

>
> Thanks,
> Joanne
>
> [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcE=
yKn-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#md1b8003a109760d8ee1d5397e053673c1=
978ed4d
> [2] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcE=
yKn-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#u
>
> >
> > Regards,
> > John
> >

