Return-Path: <linux-fsdevel+bounces-76657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ua9WGOWFhmn7OQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 01:23:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91051104456
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 01:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E52B30157D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423ED1DDC2B;
	Sat,  7 Feb 2026 00:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEngaDOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6B1A9FAF
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Feb 2026 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770423777; cv=pass; b=oq5GWHY9OC+dNizdFa3AvBmgnpwM3MsqmnP5iWilqLJojjdlh01iIkA4Z2+Su5JDa8HvBMPmWQVMn0f1AETzPDluoG0PbdkI+qWdMSu4cNY+7o9KkMrzW9FOJ5kUVmsinKyabFIDBqn6+8unvhyIYg8mGfVF1MNyWke9mH7wdJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770423777; c=relaxed/simple;
	bh=G/VDd36WEahnAQvlPVrj+p9xjJMGos+kJWFjtcNLkRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdoEyEfSO36Rw4kBwwy1QbEUQTPWROEy/B1/8tJ1sa+sut7C4BZW0wspdZAhUKu4fAG7NWcbRmGzJmM7yjO5oCchhKK+4eglCXtcEvAfKwdqe5QZJ30ZqGIOdin8bK6ihXVPSWCKeQmqNpjGDadzFjTBXC1Jj21mwM4l9NXa/PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEngaDOw; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-501488a12cbso30659521cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 16:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770423776; cv=none;
        d=google.com; s=arc-20240605;
        b=Uzv3DzSGjWUuWXA9xt46Ftxo8ZySqFxO2uzYFF2XloX/ZzGvpXnAe2dUeExUkjzwgb
         amJtW0E5f9iuhR6jro1qBSaYDL/N9oEMo8Ga3TP/KsZJ8uNeOPzB91e8obgHXWevlM2/
         VpuigEiVtyA3LTIjsBXEhnRqOsH6OH9WrraNfFw+DjDXFyCisSci51GP4fsSLGDOApgC
         NRMWjCdq2WEKZ1bEdFhtvw0rT0hr6kQa2yNhTDQb2UzfATlliBeKEAeLOMcGqDqBl0B7
         aYrgskonHE+4VLEG5yUMF7hvdxaQ5AlyuMIRiQobhkGUfsd5z33rAdoe/JUJeQncjcuz
         r4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x06H9/7JjG6jAM5EiJb/Q3f9V9ik+Q3T2EntcHVdHyw=;
        fh=Sqr3ZcPRgbT9cJ8uOYMBdPSyFHlxE39W4WDwYTw7Su8=;
        b=GzUk2jkfKuljiXWDv9vLfxTzI8I14OdrP45HNpaibayZbLe2fdiVQeRGuLNp7RODtc
         MvrebHZ/8Zt7fRhqwPHay0Epx8geeCZ391H+QYIhgTw+i1M+/0UjgVeYlNTssIXqrBEi
         +m/azOlru2LdcSCJWdflFDx6mPrIC2P7y8Sncs5Bjpi4S8NSSy5fAwDPmXOORM+L8cv2
         Z71nDEqPuXaN/ezR1h9Jr5QFV4OHXt9O7BCdArs2XkYEfgIFgAKpyQLLavlTcDxpfn/3
         3c4i7Knf/hMzZ02GWfGMNa/GdsECyv6cSHc8iZyJwc34GRB0dc0z1VRZ8EyplRYTdmDv
         jjLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770423776; x=1771028576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x06H9/7JjG6jAM5EiJb/Q3f9V9ik+Q3T2EntcHVdHyw=;
        b=KEngaDOwTF3Um9SRSVkBT5PDk5zDNMGA3/OSXUGMV6aigP8O8XBSWQJKbkgx/bfPIj
         6gVwMpO2Ah/iE/Njv/k2niN409bidsjZIfvktFkxBfC5M1TdiyarlpnriylS2Qh3I7aU
         6NtMDzNGUcUGGEzXdjQXttBKv7n3RA6fks37R91ddNI1mLUo5euEKn3fhWzaKtkoh8Lc
         BU9Ht8cWKNjlYsbDVtOZJeah3KDvgCwaq1EsYqFbQg3Qev2UCzSHpUumJTrMhk9jqR4F
         j7++FqbG5G+l+EER2z1uPt87cmLNKlAkkrLUqycVnHaNhWc3+mckCy84ckoELs2k4/ky
         NGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770423776; x=1771028576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x06H9/7JjG6jAM5EiJb/Q3f9V9ik+Q3T2EntcHVdHyw=;
        b=WaHDQVdhGGC74X7fryLDLaXcL7xaNmErX6n0Xio/6VT/XmcqQbs3/aor9dryjNVVWW
         QpFC13XbQ97griouFC/aw9BNJzvLgSI41GX/yGojkX1DbfW0tmhuqjqiEiGPG3Bx9oD4
         E/+77b5PFIS2wPZETVeGYBK2w2ihk1orpoLBZBTM0ygvEHfDX1K3CvOxOycKyudXIzea
         D5caY5TbtSDdGlkvzCIm0UMMieRguwv+yC55qFAkHmpu78wnbBUUX29G7jg0oVP8asYm
         EsSRjg5j1MfYwrH1m0FobVl+n9q2C4k4vcxayhsTCPyv3HUeovd5g1V6Jcn+KQwO5qlQ
         GPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCssSiOBBYkOKF9loJT0c86RmTgoq+geOSmWJJyS3CYBp/1Cxss2kBHoXh0Z7IvyhYj5e9GHS1zahYoxMn@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYr+goo886b9hrVLkm/zVH+7JHvksnk+qR9bt+rcDfVIY5xEb
	8D3EIexMCO4vYl7TnkkeVv+ld0HG6dGSuoVnfDp6WiUlFguvxUGqcGEWmA/3atMJJkDZhGYUhFO
	zyPCQGeYt1sGbzjoLVV8xD7mauKt1Usc=
X-Gm-Gg: AZuq6aJoLrCKXCdUJax0SeAOYiBaR9FUcRKXbAbcSvb9ZCfknnXoCdvQOpqGhf4rqcx
	1ZIlef7CAynP0S8ieMh/hA0B6f64AZGuTNgbQ6QEKGJHc4DQ8bVbkoaCE/D0oSoOmkCsHCGjIYc
	XTdt0cwMfpWpBsCzQ5H13LMloVlr6TWi3vtlJETlq+OvgEHVC5MY0TvE6cnuAF9byOfCX+n9vuh
	O8SB96I3r7wXUgcxASqrrhE7h3MBBXJc0fEG0jmYogAWY1qDjc+fKvk1QCsULBAOz59FQ==
X-Received: by 2002:ac8:5acd:0:b0:506:1e15:d757 with SMTP id
 d75a77b69052e-5063997d343mr65575991cf.56.1770423776351; Fri, 06 Feb 2026
 16:22:56 -0800 (PST)
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
In-Reply-To: <aYZOVWXGxagpCYw5@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Feb 2026 16:22:45 -0800
X-Gm-Features: AZwV_QjAjGIMzcbbC0dgV-vMHHUCcrOT3X2m1zVLH_FhN3EVoKCpLmPM842WRag
Message-ID: <CAJnrk1Za2SdCkpJ=sZR8LJ1qvBn8dd3CCsH=PvMrg=_0Jv+40Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76657-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,szeredi.hu,lists.linux-foundation.org,vger.kernel.org,bsbernd.com,igalia.com,birthelmer.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 91051104456
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 12:48=E2=80=AFPM John Groves <john@groves.net> wrote=
:
>
> On 26/02/05 09:52PM, Darrick J. Wong wrote:
> > On Thu, Feb 05, 2026 at 10:27:52AM +0100, Amir Goldstein wrote:
> > > On Thu, Feb 5, 2026 at 4:33=E2=80=AFAM John Groves <john@jagalactic.c=
om> wrote:
> > > >
> > > > On 26/02/04 11:06AM, Darrick J. Wong wrote:
> > > >
> > > > [ ... ]
> > > >
> > > > > >  - famfs: export distributed memory
> > > > >
> > > > > This has been, uh, hanging out for an extraordinarily long time.
> > > >
> > > > Um, *yeah*. Although a significant part of that time was on me, bec=
ause
> > > > getting it ported into fuse was kinda hard, my users and I are hopi=
ng we
> > > > can get this upstreamed fairly soon now. I'm hoping that after the =
6.19
> > > > merge window dust settles we can negotiate any needed changes etc. =
and
> > > > shoot for the 7.0 merge window.
> >
> > I think we've all missed getting merged for 7.0 since 6.19 will be
> > released in 3 days. :/
> >
> > (Granted most of the maintainers I know are /much/ less conservative
> > than I was about the schedule)
>
> Doh - right you are...
>
> >
> > > I think that the work on famfs is setting an example, and I very much
> > > hope it will be a good example, of how improving existing infrastruct=
ure
> > > (FUSE) is a better contribution than adding another fs to the pile.
> >
> > Yeah.  Joanne and I spent a couple of days this week coprogramming a
> > prototype of a way for famfs to create BPF programs to handle
> > INTERLEAVED_EXTENT files.  We might be ready to show that off in a
> > couple of weeks, and that might be a way to clear up the
> > GET_FMAP/IOMAP_BEGIN logjam at last.
>
> I'd love to learn more about this; happy to do a call if that's a
> good way to get me briefed.
>
> I [generally but not specifically] understand how this could avoid
> GET_FMAP, but not GET_DAXDEV.
>
> But I'm not sure it could (or should) avoid dax_iomap_rw() and
> dax_iomap_fault(). The thing is that those call my begin() function
> to resolve an offset in a file to an offset on a daxdev, and then
> dax completes the fault or memcpy. In that dance, famfs never knows
> the kernel address of the memory at all (also true of xfs in fs-dax
> mode, unless that's changed fairly recently). I think that's a pretty
> decent interface all in all.
>
> Also: dunno whether y'all have looked at the dax patches in the famfs
> series, but the solution to working with Alistair's folio-ification
> and cleanup of the dax layer (which set me back months) was to create
> drivers/dax/fsdev.c, which, when bound to a daxdev in place of
> drivers/dax/device.c, configures folios & pages compatibly with
> fs-dax. So I kinda think I need the dax_iomap* interface.
>
> As usual, if I'm overlooking something let me know...

Hi John,

The conversation started [1] on Darrick's containerization patchset
about using bpf to a) avoid extra requests / context switching for
->iomap_begin and ->iomap_end calls and b) offload what would
otherwise have to be hard-coded kernel logic into userspace, which
gives userspace more flexibility / control with updating the logic and
is less of a maintenance burden for fuse. There was some musing [2]
about whether with bpf infrastructure added, it would allow famfs to
move all famfs-specific logic to userspace/bpf.

I agree that it makes sense for famfs to go through dax iomap
interfaces. imo it seems cleanest if fuse has a generic iomap
interface with iomap dax going through that plumbing, and any
famfs-specific logic that would be needed beyond that (eg computing
the interleaved mappings) being moved to custom famfs bpf programs. I
started trying to implement this yesterday afternoon because I wanted
to make sure it would actually be doable for the famfs logic before
bringing it up and I didn't want to derail your project. So far I only
have the general iomap interface for fuse added with dax operations
going through dax_iomap* and haven't tried out integrating the famfs
GET_FMAP/GET_DAXDEV bpf program part yet but I'm planning/hoping to
get to that early next week. The work I did with Darrick this week was
on getting a server's bpf programs hooked up to fuse through bpf links
and Darrick has fleshed that out and gotten that working now. If it
turns out famfs can go through a generic iomap fuse plumbing layer,
I'd be curious to hear your thoughts on which approach you'd prefer.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyK=
n-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#md1b8003a109760d8ee1d5397e053673c197=
8ed4d
[2] https://lore.kernel.org/linux-fsdevel/CAJnrk1bxhw2u0qwjw0dJPGdmxEXbcEyK=
n-=3DiFrszqof2c8wGCA@mail.gmail.com/t/#u

>
> Regards,
> John
>

