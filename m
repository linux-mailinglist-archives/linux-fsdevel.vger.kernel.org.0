Return-Path: <linux-fsdevel+bounces-73938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D61BCD25B57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0F84305D8B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446893B52F1;
	Thu, 15 Jan 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jotschi-de.20230601.gappssmtp.com header.i=@jotschi-de.20230601.gappssmtp.com header.b="OLi1G+H2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A793B8BC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493926; cv=none; b=cCQTdJf65gQG+6j8BxG7kyS9/xlHw+PWBL9JwwW5aFeSl6zKqCS0X9djlEkZaFu4xQhrVxpX/Dbkk9fLESeNcdreM0irgXCwt2Y7EnMup7d5T24hjKyG4zbXodjKHWXVgNxTCEAPJm7V8uB8WTLNemuwhGBRSNjE+5wWL3xVJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493926; c=relaxed/simple;
	bh=azcvOTdMsPuvumr7JrSghmHGgkDpj7od9aEKJ3Dyb94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuU5EZa9Ft9LJr1EE+VdbkjDxMCkJodgchstyd+bo7bbg4ja6sSs2kQkK4PTvxVlU1ANB4EsAv/sjZlVKvl4c51sIK4Iw9bcehNbzlDNjf21ifPPZCCWgKXV+mej1pRaOEud5DY8tvO0u8EBEU5CGn4M587Y1MCUjRv67yYFqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jotschi.de; spf=none smtp.mailfrom=jotschi.de; dkim=pass (2048-bit key) header.d=jotschi-de.20230601.gappssmtp.com header.i=@jotschi-de.20230601.gappssmtp.com header.b=OLi1G+H2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jotschi.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jotschi.de
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c1d98ba11so810922a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 08:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jotschi-de.20230601.gappssmtp.com; s=20230601; t=1768493914; x=1769098714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=azcvOTdMsPuvumr7JrSghmHGgkDpj7od9aEKJ3Dyb94=;
        b=OLi1G+H20B+oMcRd+VyiIYDPUxS13UTqT8sNdJpQm1M4fujZb2dH61wQeVcyw6y2Jh
         Sxi/LOyVMuQrU7+dVjaPQRcd4Xtpvd6Wvm5Zrhf/fU8FaYQVR+Wlo5vCPGCWgzIywFCt
         /VT2rxx++E8LZvUAPPYfSLyp1UKdUrwKmzFmNd5jhYuc9m/OfjYTzpBIOXzKhYDpkqp+
         VOFRo2/FCl41EhHa76is671kKOgYwQOyX7eGNxNi002sX1qwIQHoOyn9ucotIoYJ7L5u
         lyL2FqCi6AqOYKDNu7JS6jShdl1+SFT+3qWuzKEmPr7ylK7BCbnsUeB05Lsmbd6mbqKM
         BfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768493914; x=1769098714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azcvOTdMsPuvumr7JrSghmHGgkDpj7od9aEKJ3Dyb94=;
        b=V4OXbH9uah0LYDVJFVUHromjlXaaNSJosuEtImLyyT206YwB8BALYbmRiBNlGnoCU5
         cQoibh7jjpdLnWtAmZLmMlNpVYn247BZZSvAile9hHCtMGqGT57o/6Vg33JtJdOxhcGf
         t+vD7rSDUiuA9x3RPemv65a9IZnWX3mne39k4zjh/9Ua5Os8BlTAXgoqQ9MQ7ffWIvyM
         UBP1ezE63NKaXyNMdPzJKaKGuM4MVvMy/9Uj1X2xZSmQdbngo1OhM+G7EpTUwfuDhuzV
         pGBb0UrRzLApfAQL1k7CklgoRs19jML9lhvNOFgWrhYdTlzYsLYP+18Iug7tG8i7VIb/
         xkxA==
X-Forwarded-Encrypted: i=1; AJvYcCW7BOF29t1uPtnfgFENBPlQVe3o7KeYU4jauMCu2CKUB1B4VoEaiqeOiPHvSQJJjL7kmsWwdVVsDKJK8tMn@vger.kernel.org
X-Gm-Message-State: AOJu0YxdjR3pMam1sIxxZQw9+xTQQm3ba6Uzr6PqHOY1R0Yw0iVH6lpU
	Vjm+mpTd29JUzDT9T+cWo4LPbVvngaAzdRR+UvRIQ48OoOkLlQ3zmIKjXWqsxhlUrQUVRybwYeE
	lx6eLKiOfwrK7pl63svs5w96b20VOdDTXpjhWGJqI
X-Gm-Gg: AY/fxX6W/DgAN+5FGb5Ah5+muLuAfARyldCr4pRwEZzmE2v060Mn8qJo+j5YKDfwmwE
	FHeWcmydkLVUwfq83NCvTS1cR/ST/uFC0rr9ElmP/0hwnToyGAEtQf0KoLEpdlswH/Eiy/mPTVe
	rB7j1uvDqRBSglYnHucqr5pBKjNAdJAYeaSc/KNgM3HuZB+ZOjvzxn9V70tq0/On57J5lenA/Hv
	G/gPZVo9jsiQyD0v3JU9z0W70RKwU60A1FCSfJ0s7u4r5P4PAX9DMa174ZQBY/IDj9dWPP2XzwK
	XZl2
X-Received: by 2002:a17:90b:2250:b0:34c:a29d:992f with SMTP id
 98e67ed59e1d1-3510913e074mr6692916a91.31.1768493914410; Thu, 15 Jan 2026
 08:18:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link>
 <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org>
 <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link>
 <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org>
In-Reply-To: <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org>
From: =?UTF-8?Q?Johannes_Sch=C3=BCth?= <j.schueth@jotschi.de>
Date: Thu, 15 Jan 2026 17:18:23 +0100
X-Gm-Features: AZwV_QgPnpxcRztEbfCr85Hbb66HOYuKjtmYlWJkawDPk4AswjlQT9ZkgIte-98
Message-ID: <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
To: Trond Myklebust <trondmy@kernel.org>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, linux-fsdevel@vger.kernel.org, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"

Here are the two requested dumps:
https://www.jotschi.de/files/fuse_nfs_mount_6_18_5.pcap
https://www.jotschi.de/files/fuse_nfs_setfattr_6_18_5.pcap

I see XAW (xattr write?) being denied on nfs mount:
Opcode: ACCESS (3), [Access Denied: MD XT DL XAW], [Allowed: RD LU XAR XAL]

Testing system/security xattr was just a test. My userland code only
uses user.* xattr.

Am Do., 15. Jan. 2026 um 00:32 Uhr schrieb Trond Myklebust <trondmy@kernel.org>:
>
> On Wed, 2026-01-14 at 22:45 +0000, Antonio SJ Musumeci wrote:
> > The user (cc'ed) said they have tested numerous recent releases
> > including 6.18.5 (on both client and server.)
> >
> >
>
> Can you supply a wireshark/tcpdump trace taken on the client that shows
> the mount process and an example of a failed setfattr of a user xattr
> on the 6.18.5 kernel?
>
> Note that trying to access system level xattrs (I see your github issue
> tracker notes trying to read "system.nfs4_acl") has never been allowed.
> The NFSv4.2 xattr protocol extension explicitly bans the practice of
> using xattrs to construct private filesystem APIs.
>
> IOW: Reading, writing and listing of user xattrs on the remote server
> is the only mode that is supported by the NFSv4.2 protocol extension.
>
> >
> > On Wednesday, January 14th, 2026 at 1:27 PM, Trond Myklebust
> > <trondmy@kernel.org> wrote:
> >
> > >
> > >
> > > On Wed, 2026-01-14 at 19:18 +0000, Antonio SJ Musumeci wrote:
> > >
> > > > You don't often get email from trapexit@spawn.link.
> > > > Learn why this is important
> > > >
> > > > Forgive me but I've not had the chance to investigate this in
> > > > detail
> > > > but according to a user of mine[0] after a commit[1] between
> > > > 6.15.10
> > > > and 6.15.11 user namespaced xattr requests now return EOPNOSUPP
> > > > when
> > > > the FUSE filesystem is exported via NFS. It was replicated with
> > > > other
> > > > FUSE filesystems.
> > > >
> > > > Was this intentional? If "yes", what would be the proper way to
> > > > support this?
> > > >
> > > > -Antonio
> > > >
> > > > [0] https://github.com/trapexit/mergerfs/issues/1607
> > > > [1]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm
> > > > it/?id=a8ffee4abd8ec9d7a64d394e0306ae64ba139fd2
> > >
> > >
> > > You should upgrade to a newer stable kernel.
> > >
> > > This issue has already been reported and fixed by commit
> > > 31f1a960ad1a
> > > ("NFSv4: Don't clear capabilities that won't be reset").
> > >
> > >
> > > --
> > > Trond Myklebust
> > > Linux NFS client maintainer, Hammerspace
> > > trondmy@kernel.org, trond.myklebust@hammerspace.com
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com

