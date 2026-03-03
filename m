Return-Path: <linux-fsdevel+bounces-79273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IbgGWgap2m+dgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 18:29:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C54751F49FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 18:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D025301FD62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C43C2795;
	Tue,  3 Mar 2026 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtt1Nyl1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1383537C5
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772558946; cv=pass; b=cfMCeqHHNUdj2vONZ81SO2TyzR36WYnHPQFuwfP29Eows/hGvbrDLF9G1zrtPqZrx++7XV/6Go/GmCrEkzpPDDLIgmlqRsEkbB5dUB4uo4mGDd4fcq1Ae8bvgJUpui9Yv6r14AgJPNTNRI32tTE43KkHM1hS5ATX6JeZ7HYFQu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772558946; c=relaxed/simple;
	bh=kMmIuP+r3ws6q6LXSNF0u6JZjvCbHFglfQllV2m4H98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZ3lq0ejXTrvd6FpK6FbHWXxsL2ixy6KPNiGVyHRbIUiG8yvzwiMbYDSvX7MDxWDjTBxL6zry+CxIRg7CsfvhkUAHXxN0NMGnUWMecPqZQOGd5tqafaijGogjuXoZCJGckwBweWGxSfAvnUfvbdJB0x7eqKjJ6he4rI6HlNny6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtt1Nyl1; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5069df1d711so52224491cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 09:29:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772558944; cv=none;
        d=google.com; s=arc-20240605;
        b=fTS9FLCJByZnh9QHkaNhvFE0AshoWew5Vr0ea1g7QkN/9irkpAbnrJKJYVco+sMaff
         /Kco8QznQt7aEH4yy7svNVuGAFyT6yo3JKROgKJWnry8zfSTFEgjoAe/NasU6hkVYq5p
         VSMuj3kmJ4k8WjFzfClEBOCsH/rt3r1DFxYTlzO1q1rU9gDV+1+KyU03neKUjulCgtyI
         Jdv79xrZvBfW0tfeEjix8kC36CkYf+rjyi0D5gkTj5lTjJO0xJul1sDTjSWmsfzgZ1Ck
         y7wQODmlM9foFNka8Ns9kVC7V7NR1m/M1eGuNOJ7Y82Wmm3VbIM6Cb4DaddGH6nR1lMf
         AwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Muk7qwXz8QEP9C6kMauoGBSFbu/Buf+kHeYq2d7Ru/c=;
        fh=NpB4T4II1iYV1wIc+FasCv5q7h9kplqh2BYpzw9+0Bg=;
        b=Pr3W+LDiq/WEz3h1G0eU7r1Zeaa6R6WSmzuqryhw3QqJAcJ4RTGXmSPSvi7v7xNvSY
         1Ijc2cEcuKtGi1u4Jm+dT0yWL2Ze0DSbKBQIJb3kOU59o2A3dVTYxGWTi47vYl0kqjKT
         20RzVSSzrtZhpYx0Sy79q0AEtAFLIXKR95AdoMVFmbjsjGUmO73Sup0XybxqDIJRd5sk
         u9XQIwcpfP+FS+8tMqLssG43ZVlE6DgbJwWsmEunMrfv6srdzgoumkzbV3jGVisxBfAZ
         LwBzIY4iTcs3366fTukjnwGnGpCvVHKMHsQWLc2D3e2HH+80lrPjDRkXSdP9wuBE8r8q
         Z+ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772558944; x=1773163744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Muk7qwXz8QEP9C6kMauoGBSFbu/Buf+kHeYq2d7Ru/c=;
        b=Gtt1Nyl11r43T3Twit2bvZXd2sMDXg+NPgDiWFcaBMPabxovd2TuhMTup5+wOd37vb
         2x9AByYoxAEbdj+wQUfRARfRHiyiNIztk4NTLGtcLMoFSagsP3LgL3nQrfPNI+4QQGCf
         1wgbAWwuNs9vUOuoNI2PyY3Hb+/FOeGuuRYRV88W6D0+7Mq6Ik1E4F/dnorW5pjnSTB9
         lMD3FUUcfKXNBz07JMFyI1hd9ymzeMxQOkpFrJ+NjsIQBtkO1s/2VsxAIbmAMdo4NPTh
         05jAsMK54viwIwDQoabVot6L+XqTNzTw953u751iAHYJ6hWncb4M9qU8Ip4o4FqG0RGL
         HsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772558944; x=1773163744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Muk7qwXz8QEP9C6kMauoGBSFbu/Buf+kHeYq2d7Ru/c=;
        b=oGtV1O+j+sC7fOq+A6+mqkbjO9/NMc4yGKplQY/envYxA6r4MBMQNW8L9E1l8W44R1
         2W0o6vL/MQTuU8zh7pcH27isD+B6HipzdEb7M+4IdzjhDD33fubeRc5VUoC49b+4KFt+
         nQHjHzEj6Q8g3Ta3wkmVANbBQNTXT+ONnlcqN5lzRuZ374R3JfKMnZ0LDsGdS2uqxhSq
         DodvSdI4vxpJe67q8Lk816gakZ3DTgojVL2gcHDZG39ZvDJhAOzAzVUT63aFGvZBmcLH
         GGWlafQTZ8JEDkGMoGhZtd8S8nARvQa+ozxK5tzjGfxLE+B1Gq9RhIoFwFb2oaPTGmgX
         juwA==
X-Forwarded-Encrypted: i=1; AJvYcCV15ROOa5wtsqi74WF3pYwz+lmhZsGV/IIaaVXeVaMqNuo5Kr4wNmWTXjUuyytbcA3GF8n+izK1YnOjRTGM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JsrKgzfEOGv7L4G+dpm6cc0AUOprygTs6Y820NF3ztTMfxX8
	aUnM4KA7bayUlg8rKdKi0VUTauRBzXtM+K5W4zW8D/Hg/pu814PBvhWx/I+890zdbLohIrT+qGV
	8doqMV1vRn8PlacZQH/rr3IxW6rep7/Y=
X-Gm-Gg: ATEYQzwInvcQXzffrg9D2BeXsmyaFnSf7Psn82FF13/goN6gi8GBPxHDg0oVVrCtoZZ
	zbWplOCfApG2112vroPLfuYY8LDxnJ7AMWaq7AK4VS88jB9EclpVQbPvjcmR/tfi7C20OfOoUbg
	y+9dLxE576hX0ANVcznl8SiJZP6dA4bw8WiejebNZK5XfjuYRpIzReVTSWArUF+Ju/le1QYORwZ
	K3zED4oBbvo6mj7omm9qJf8UAb6hCTc6sXpajuDkRO/bJwGdmAY52jnZNSF2hVSHQZjrbPIzIl+
	/j9ULWShv7rY9LQ+
X-Received: by 2002:ac8:5f82:0:b0:4ee:2423:d538 with SMTP id
 d75a77b69052e-507526f6b42mr192671041cf.18.1772558943910; Tue, 03 Mar 2026
 09:29:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYQNcagFg6-Yz1Fw@groves.net> <20260204190649.GB7693@frogsfrogsfrogs>
 <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
 <CAOQ4uxhzaTAw_sHVfY05HdLiB7f6Qu3GMZSBuPkmmsua0kqJBQ@mail.gmail.com>
 <20260206055247.GF7693@frogsfrogsfrogs> <aYZOVWXGxagpCYw5@groves.net>
 <CAJnrk1Za2SdCkpJ=sZR8LJ1qvBn8dd3CCsH=PvMrg=_0Jv+40Q@mail.gmail.com>
 <CAJnrk1YMqDKA5gDZasrxGjJtfdbhmjxX5uhUv=OSPyA=G5EE+Q@mail.gmail.com>
 <20260221003756.GD11076@frogsfrogsfrogs> <CAJnrk1ZJksW=uz1itdh+zoaQBo_XQ4ZSF13BSnZXMie5pBCvYA@mail.gmail.com>
 <20260303045755.GN13829@frogsfrogsfrogs>
In-Reply-To: <20260303045755.GN13829@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 3 Mar 2026 09:28:52 -0800
X-Gm-Features: AaiRm52rYVKSB8AkIVHOR_NIfBsMb5ViQYz80E2dtrbHkMyQPorzApTEEyYVy28
Message-ID: <CAJnrk1bMf_xAdbxiyRyWDX_-7n8gwUqYN==Kqcg8ByaSNkk+ZQ@mail.gmail.com>
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
X-Rspamd-Queue-Id: C54751F49FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,groves.net:email,mail.gmail.com:mid,ebpf.io:url];
	FREEMAIL_CC(0.00)[groves.net,gmail.com,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,bsbernd.com,igalia.com,birthelmer.de];
	TAGGED_FROM(0.00)[bounces-79273-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 8:57=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Thu, Feb 26, 2026 at 12:21:43PM -0800, Joanne Koong wrote:
> > On Fri, Feb 20, 2026 at 4:37=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Wed, Feb 11, 2026 at 08:46:26PM -0800, Joanne Koong wrote:
> > > > On Fri, Feb 6, 2026 at 4:22=E2=80=AFPM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > > >
> > > > > On Fri, Feb 6, 2026 at 12:48=E2=80=AFPM John Groves <john@groves.=
net> wrote:
> > > > > >
> > > > > > On 26/02/05 09:52PM, Darrick J. Wong wrote:
> > > > > > > On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrot=
e:
> > > > > > > > On Thu, Feb 5, 2026 at 4:33=E2=80=AFAM John Groves <john@ja=
galactic.com> wrote:
> > > > > > > > >
> > > > > > > > > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> > > > > > > > >
> > > > > > > > > [ ... ]
> > > > > > > > >
> > > > > > > > > > >  - famfs: export distributed memory
> > > > > > > > > >
> > > > > > > > > > This has been, uh, hanging out for an extraordinarily l=
ong time.
> > > > > > > > >
> > > > > > > > > Um, *yeah*. Although a significant part of that time was =
on me, because
> > > > > > > > > getting it ported into fuse was kinda hard, my users and =
I are hoping we
> > > > > > > > > can get this upstreamed fairly soon now. I'm hoping that =
after the 6.19
> > > > > > > > > merge window dust settles we can negotiate any needed cha=
nges etc. and
> > > > > > > > > shoot for the 7.0 merge window.
> > > > > > >
> > > > > > > I think we've all missed getting merged for 7.0 since 6.19 wi=
ll be
> > > > > > > released in 3 days. :/
> > > > > > >
> > > > > > > (Granted most of the maintainers I know are /much/ less conse=
rvative
> > > > > > > than I was about the schedule)
> > > > > >
> > > > > > Doh - right you are...
> > > > > >
> > > > > > >
> > > > > > > > I think that the work on famfs is setting an example, and I=
 very much
> > > > > > > > hope it will be a good example, of how improving existing i=
nfrastructure
> > > > > > > > (FUSE) is a better contribution than adding another fs to t=
he pile.
> > > > > > >
> > > > > > > Yeah.  Joanne and I spent a couple of days this week coprogra=
mming a
> > > > > > > prototype of a way for famfs to create BPF programs to handle
> > > > > > > INTERLEAVED_EXTENT files.  We might be ready to show that off=
 in a
> > > > > > > couple of weeks, and that might be a way to clear up the
> > > > > > > GET_FMAP/IOMAP_BEGIN logjam at last.
> > > > > >
> > > > > > I'd love to learn more about this; happy to do a call if that's=
 a
> > > > > > good way to get me briefed.
> > > > > >
> > > > > > I [generally but not specifically] understand how this could av=
oid
> > > > > > GET_FMAP, but not GET_DAXDEV.
> > > > > >
> > > > > > But I'm not sure it could (or should) avoid dax_iomap_rw() and
> > > > > > dax_iomap_fault(). The thing is that those call my begin() func=
tion
> > > > > > to resolve an offset in a file to an offset on a daxdev, and th=
en
> > > > > > dax completes the fault or memcpy. In that dance, famfs never k=
nows
> > > > > > the kernel address of the memory at all (also true of xfs in fs=
-dax
> > > > > > mode, unless that's changed fairly recently). I think that's a =
pretty
> > > > > > decent interface all in all.
> > > > > >
> > > > > > Also: dunno whether y'all have looked at the dax patches in the=
 famfs
> > > > > > series, but the solution to working with Alistair's folio-ifica=
tion
> > > > > > and cleanup of the dax layer (which set me back months) was to =
create
> > > > > > drivers/dax/fsdev.c, which, when bound to a daxdev in place of
> > > > > > drivers/dax/device.c, configures folios & pages compatibly with
> > > > > > fs-dax. So I kinda think I need the dax_iomap* interface.
> > > > > >
> > > > > > As usual, if I'm overlooking something let me know...
> > > > >
> > > > > Hi John,
> > > > >
> > > > > The conversation started [1] on Darrick's containerization patchs=
et
> > > > > about using bpf to a) avoid extra requests / context switching fo=
r
> > > > > ->iomap_begin and ->iomap_end calls and b) offload what would
> > > > > otherwise have to be hard-coded kernel logic into userspace, whic=
h
> > > > > gives userspace more flexibility / control with updating the logi=
c and
> > > > > is less of a maintenance burden for fuse. There was some musing [=
2]
> > > > > about whether with bpf infrastructure added, it would allow famfs=
 to
> > > > > move all famfs-specific logic to userspace/bpf.
> > > > >
> > > > > I agree that it makes sense for famfs to go through dax iomap
> > > > > interfaces. imo it seems cleanest if fuse has a generic iomap
> > > > > interface with iomap dax going through that plumbing, and any
> > > > > famfs-specific logic that would be needed beyond that (eg computi=
ng
> > > > > the interleaved mappings) being moved to custom famfs bpf program=
s. I
> > > > > started trying to implement this yesterday afternoon because I wa=
nted
> > > > > to make sure it would actually be doable for the famfs logic befo=
re
> > > > > bringing it up and I didn't want to derail your project. So far I=
 only
> > > > > have the general iomap interface for fuse added with dax operatio=
ns
> > > > > going through dax_iomap* and haven't tried out integrating the fa=
mfs
> > > > > GET_FMAP/GET_DAXDEV bpf program part yet but I'm planning/hoping =
to
> > > > > get to that early next week. The work I did with Darrick this wee=
k was
> > > > > on getting a server's bpf programs hooked up to fuse through bpf =
links
> > > > > and Darrick has fleshed that out and gotten that working now. If =
it
> > > > > turns out famfs can go through a generic iomap fuse plumbing laye=
r,
> > > > > I'd be curious to hear your thoughts on which approach you'd pref=
er.
> > > >
> > > > I put together a quick prototype to test this out - this is what it
> > > > looks like with fuse having a generic iomap interface that supports
> > > > dax [1], and the famfs custom logic moved to a bpf program [2]. I
> > >
> > > The bpf maps that you've used to upload per-inode data into the kerne=
l
> > > is a /much/ cleaner method than custom-compiling C into BPF at runtim=
e!
> > > You can statically compile the BPF object code into the fuse server,
> > > which means that (a) you can take advantage of the bpftool skeletons,
> > > and (b) you can in theory vendor-sign the BPF code if and when that
> > > becomes a requirement.
> > >
> > > I think that's way better than having to put vmlinux.h and
> > > fuse_iomap_bpf.h on the deployed system.  Though there's one hitch in
> > > example/Makefile:
> > >
> > > vmlinux.h:
> > >         $(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > $=
@
> > >
> > > The build system isn't necessarily running the same kernel as the dep=
loy
> > > images.  It might be for Meta, but it's not unheard of for our build
> > > system to be running (say) OL10+UEK8 kernel, but the build target is =
OL8
> > > and UEK7.
> > >
> > > There doesn't seem to be any standardization across distros for where=
 a
> > > vmlinux.h file might be found.  Fedora puts it under
> > > /usr/src/$unamestuf, Debian puts it in /usr/include/$gcc_triple, and =
I
> > > guess SUSE doesn't ship it at all?
> > >
> > > That's going to be a headache for deployment as I've been muttering f=
or
> > > a couple of weeks now. :(
> >
> > I don't think this is an issue because bpf does dynamic btf-based
> > relocations (CO-RE) at load time [1]. On the target machine, when
> > libbpf loads the bpf object it will read the machine's btf and patch
> > any offsets in bytecode and load the fixed-up version into the kernel.
> > All that's needed on the target machine for CO-RE is
> > CONFIG_DEBUG_INFO_BTF=3Dy which is enabled by default on mainstream
> > distributions. I think this addresses the deployment headache you've
> > been running into?
>
> Not really -- CO-RE does indeed work quite nicely to smooth over layout
> changes in C structures between a BPF program and the kernel it's being
> loaded into (thanks, whoever came up with that!) but the problem I have
> is how you /get/ those definitions into clang in the first place.
>
> I was under the impression from many of the bpf examples that you're
> supposed to #include a distro-provided "vmlinux.h", but there doesn't
> seem to be a standard way to find that file.  Most -dev packages provide

The

vmlinux.h:
         $(BPFTOOL) btf dump file /sys/kernel/btf/vmlinux format c > $@

line generates the vmlinux.h file. /sys/kernel/btf/vmlinux is a kernel
sysfs path and isn't distro dependent.

Then CO-RE takes care of the rest with fixing any mismatches between
the vmlinux on the build machine vs. the target machine.

Thanks,
Joanne

> a pkgconfig file that give you the appropriate CFLAGS/LDFLAGS to add,
> but apparently this is not the case for BPF...?
>
> Perhaps it's the case that distro packages that are building BPF
> programs simply add a build dependency on the package providing
> vmlinux.h (e.g. Build-Depends: linux-bpf-dev on Debian) and patch in
> "CFLAGS=3D-I/some/path" as needed?
>
> I suppose for a dynamically generated and compiled BPF program, one
> could just "bpftool skel" the /sys/kernel/btf files, capture the output,
> and "#include </dev/fd/XXX>" the results.  Honestly that sounds better
> than trusting some weird system package.
>
> But maybe dynamic compilation is a totally stupid idea.  I did grow up
> in the era of mshtml email wreaking havoc, after all...
>
> --D
>
> > Thanks,
> > Joanne
> >
> > [1] https://docs.ebpf.io/concepts/core/
> >
> > >
> > > Maybe we could reduce the fuse-iomap bpf definitions to use only
> > > cardinal types and the types that iomap itself defines.  That might n=
ot
> > > be too hard right now because bpf functions reuse structures from
> > > include/uapi/fuse.h, which currently use uint{8,16,32,64}_t.  It'll g=
et
> > > harder if that __uintXX_t -> __uXX transition actually happens.
> > >
> > > But getting back to the famfs bpf stuff, I think doing the interleave=
d
> > > mappings via BPF gives the famfs server a lot more flexibility in ter=
ms
> > > of what it can do when future hardware arrives with even weirder
> > > configurations.
> > >
> > > --D
> > >
> > > > didn't change much, I just moved around your famfs code to the bpf
> > > > side. The kernel side changes are in [3] and the libfuse changes ar=
e
> > > > in [4].
> > > >
> > > > For testing out the prototype, I hooked it up to passthrough_hp to
> > > > test running the bpf program and verify that it is able to find the
> > > > extent from the bpf map. In my opinion, this makes the fuse side
> > > > infrastructure cleaner and more extendable for other servers that w=
ill
> > > > want to go through dax iomap in the future, but I think this also h=
as
> > > > a few benefits for famfs. Instead of needing to issue a FUSE_GET_FM=
AP
> > > > request after a file is opened, the server can directly populate th=
e
> > > > metadata map from userspace with the mapping info when it processes
> > > > the FUSE_OPEN request, which gets rid of the roundtrip cost. The
> > > > server can dynamically update the metadata at any time from userspa=
ce
> > > > if the mapping info needs to change in the future. For setting up t=
he
> > > > daxdevs, I moved your logic to the init side, where the server pass=
es
> > > > the daxdev info upfront through an IOMAP_CONFIG exchange with the
> > > > kernel initializing the daxdevs based off that info. I think this w=
ill
> > > > also make deploying future updates for famfs easier, as updating th=
e
> > > > logic won't need to go through the upstream kernel mailing list
> > > > process and deploying updates won't require a new kernel release.
> > > >
> > > > These are just my two cents based on my (cursory) understanding of
> > > > famfs. Just wanted to float this alternative approach in case it's
> > > > useful.
> > > >
> > > > Thanks,
> > > > Joanne
> > > >
> > > > [1] https://github.com/joannekoong/linux/commit/b8f9d284a6955391f00=
f576d890e1c1ccc943cfd
> > > > [2] https://github.com/joannekoong/libfuse/commit/444fa27fa9fd2118a=
0dc332933197faf9bbf25aa
> > > > [3] https://github.com/joannekoong/linux/commits/prototype_generic_=
iomap_dax/
> > > > [4] https://github.com/joannekoong/libfuse/commits/famfs_bpf/
> > > >
> > > > >
> > > > > Thanks,
> > > > > Joanne
> > > > >
> > > > > [1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPG=
dmxEXbcEyKn-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#md1b8003a109760d8ee1d5397e=
053673c1978ed4d
> > > > > [2] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPG=
dmxEXbcEyKn-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#u
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > > John
> > > > > >
> > > >
> >

