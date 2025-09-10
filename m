Return-Path: <linux-fsdevel+bounces-60771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAA3B5196B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F7977BD3AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75509324B24;
	Wed, 10 Sep 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUD0i17J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5691E5B70;
	Wed, 10 Sep 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514643; cv=none; b=Wu18gn+xeol3P775aW03lENAZqhmvIiXIxxvVFXJrVyTyYz2647F/BKW9daYjjgvfVVZI9GonRZuKCXrB/MI2osk1bd2kC9mfE5LqXB+zuP9JYFQUf8BloL7yVQbU948Rcnm6E2Sfg6TNvPPGSYHCFsI5Wqk+kHFIcfOixmN51c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514643; c=relaxed/simple;
	bh=q9cztTGvjEzI/SyYY0Ly+X+4kXKXRyRqSo+jdgCi4Ao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNlf4TGRHTiEmgFDnM4KPiN+d52N+qolYdIhz1LAavifJzz/ASDOs6as0QSPpxa9qA8bUVyubeosIhDAayWfWaFqOnL4tkrydv+A6YL1Q+oqh5MWEAUj1tp9XmxrlJvSoHMX6x/wxb6GwATNeDpWWkA7WBWiwnORsJf/TkmVoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUD0i17J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6ACC4CEEB;
	Wed, 10 Sep 2025 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757514643;
	bh=q9cztTGvjEzI/SyYY0Ly+X+4kXKXRyRqSo+jdgCi4Ao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KUD0i17Jath6rPDGjPQ5Hy8LnhgUDTZcWI2zjOepc7I649gTN9qpZJxKtXQ5qXJ0v
	 SS0UGmh8Wxx/R8ZENFTHGhguGpdM/er6FaSrWrJzNH9W/hUQO5wOhkFAIbqdDIve6P
	 XgQORNbVaDw/GZGeiCxM51okTVBIXLx2KLOhzR5lm0nR3vojPsrC2qJdLvghSv11SI
	 k2J0E0RwSJrwexE3sBHGZ29Oqp7SaVkW5yhNvKVPDpbnGEaqHd/puE4HpjevRzd6Xo
	 xFdjTDEcWHCbkTwgFEObgR56FIZrDkVJ8ACR8l7MFY9UajItCcgylgdZVh20t4kSA0
	 wNCnefDeDmLzQ==
Message-ID: <72dff4694962ff72dec90e4071ef993134dfae27.camel@kernel.org>
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Cedric Blancher	
 <cedric.blancher@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
  Christoph Hellwig	 <hch@infradead.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Wed, 10 Sep 2025 10:30:41 -0400
In-Reply-To: <11a66cd2-7ffb-4082-a8cd-ae34a48530af@oracle.com>
References: 
	<CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
	 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
	 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
	 <aEZ3zza0AsDgjUKq@infradead.org>
	 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
	 <aEfD3Gd0E8ykYNlL@infradead.org>
	 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
	 <236e7b3e86423b6cdacbce9a83d7a00e496e020a.camel@kernel.org>
	 <11a66cd2-7ffb-4082-a8cd-ae34a48530af@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-10 at 10:14 -0400, Chuck Lever wrote:
> On 9/10/25 7:10 AM, Jeff Layton wrote:
> > On Tue, 2025-09-09 at 18:06 +0200, Cedric Blancher wrote:
> > > On Tue, 10 Jun 2025 at 07:34, Christoph Hellwig <hch@infradead.org> w=
rote:
> > > >=20
> > > > On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
> > > > > > Date:   Wed May 21 16:50:46 2008 +1000
> > > > > >=20
> > > > > >     dcache: Add case-insensitive support d_ci_add() routine
> > > > >=20
> > > > > My memory must be quite faulty then. I remember there being signi=
ficant
> > > > > controversy at the Park City LSF around some patches adding suppo=
rt for
> > > > > case insensitivity. But so be it -- I must not have paid terribly=
 close
> > > > > attention due to lack of oxygen.
> > > >=20
> > > > Well, that is when the ext4 CI code landed, which added the unicode
> > > > normalization, and with that another whole bunch of issues.
> > >=20
> > > Well, no one likes the Han unification, and the mess the Unicode
> > > consortium made from that,
> > > But the Chinese are working on a replacement standard for Unicode, so
> > > that will be a lot of FUN =3D:-)
> > >=20
> > > > > > That being said no one ever intended any of these to be exporte=
d over
> > > > > > NFS, and I also question the sanity of anyone wanting to use ca=
se
> > > > > > insensitive file systems over NFS.
> > > > >=20
> > > > > My sense is that case insensitivity for NFS exports is for Window=
s-based
> > > > > clients
> > > >=20
> > > > I still question the sanity of anyone using a Windows NFS client in
> > > > general, but even more so on a case insensitive file system :)
> > >=20
> > > Well, if you want one and the same homedir on both Linux and Windows,
> > > then you have the option between the SMB/CIFS and the Windows NFSv4.2
> > > driver (I'm not counting the Windows NFSv3 driver due lack of ACL
> > > support).
> > > Both, as of September 2025, work fine for us for production usage.
> > >=20
> > > > > Does it, for example, make sense for NFSD to query the file syste=
m
> > > > > on its case sensitivity when it prepares an NFSv3 PATHCONF respon=
se?
> > > > > Or perhaps only for NFSv4, since NFSv4 pretends to have some reco=
gnition
> > > > > of internationalized file names?
> > > >=20
> > > > Linus hates pathconf any anything like it with passion.  Altough we
> > > > basically got it now with statx by tacking it onto a fast path
> > > > interface instead, which he now obviously also hates.  But yes, nfs=
d
> > > > not beeing able to query lots of attributes, including actual impor=
tant
> > > > ones is largely due to the lack of proper VFS interfaces.
> > >=20
> > > What does Linus recommend as an alternative to pathconf()?
> > >=20
> > > Also, AGAIN the question:
> > > Due lack of a VFS interface and the urgend use case of needing to
> > > export a case-insensitive filesystem via NFSv4.x, could we please get
> > > two /etc/exports options, one setting the case-insensitive boolean
> > > (true, false, get-default-from-fs) and one for case-preserving (true,
> > > false, get-default-from-fs)?
> > >=20
> > > So far LInux nfsd does the WRONG thing here, and exports even
> > > case-insensitive filesystems as case-sensitive. The Windows NFSv4.1
> > > server does it correctly.
> > >=20
> > > Ced
> >=20
> > I think you don't want an export option for this.
> >=20
> > It sounds like what we really need is a mechanism to determine whether
> > the inode the client is doing a GETATTR against lies on a case-
> > insensitive mount.
> >=20
> > Is there a way to detect that in the kernel?
>=20
> Agreed, I would prefer something automatic rather than an explicit
> export option. The best approach is to set this behavior on the
> underlying file system via its mount options or on-disk settings.
> That way, remote and local users see the exact same CS behavior.
>=20
> An export option would enable NFSD to lie about case sensitivity.
> Maybe that's what is needed? I don't really know. It seems like
> a potential interoperability disaster.
>=20

There is also the issue that exports can span filesystems. If you have
one fs that is case-sensitive mounted on another that is not, and then
you export the whole mess, the results sound sketchy.

> Moreover, as we determined the last time this thread was active,
> ext4 has a per-directory case insensitivity setting. The NFS
> protocol's CS attribute is per file system. That's a giant mismatch
> in semantics, and I don't know what to do about that. An export
> option would basically override all of that -- as a hack -- but
> would get us moving forward. Again, perhaps there are some
> significant risks to this approach.
>=20

The spec is written such that case-sensitivity applies to the whole fs,
but in practical terms, would there be any harm in allowing this to be
set more granularly?

Existing servers would still work fine in that case, and I don't think
it would be an issue for the Linux client at least.
--=20
Jeff Layton <jlayton@kernel.org>

