Return-Path: <linux-fsdevel+bounces-74237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720FD3865D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08143060580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1A3385B5;
	Fri, 16 Jan 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW90wXAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B02222D0;
	Fri, 16 Jan 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593802; cv=none; b=i0NuQ+7ECNfvbYmskOvV5yJTWBZWo6kP9uy5JzrRNvglLPpJrDXTculFlitGjBmbqW4W4L+Ni9efNu0bpc02qVGcauWL/FGzxdEsAiRQlvG/S+nH0oCjO/ZGQSIU72tibalCxorkJtPZ4gtJoaQRh69aIfZrYCLwBpPQAwl8vQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593802; c=relaxed/simple;
	bh=ZLHGEqcOVXoni6XTEPKitTIm9ujNRUW5WVboT2RyK6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qXE2XfqiZLUyZJNHUkfB1FpxD9RojmLhqsEq6OPpdMjgd9qM/cWZ9T+bStHzIiGcCMbREXL68SXhqFNoAnLU+qNCPIXYlVVHIv1Du4OwhedJri+f6WxZAR16u4cOwnxNV8wR+wGs0gTWYQOcolZk/MZKgMa7g4/w17UGelQ9YCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW90wXAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BB1C116C6;
	Fri, 16 Jan 2026 20:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768593801;
	bh=ZLHGEqcOVXoni6XTEPKitTIm9ujNRUW5WVboT2RyK6A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EW90wXAY6p2kYZ5eu/fpT/M60SDXXkzuch8U7laU6oQ1CjWFgJaqXXac046/fsmFa
	 wuNqyCbHU9gyVhKrNjDiHhhdrm59cggtCuFjtLlJsVRxjHptwtVeYWyfOLPjRLpGGg
	 R13EVGdsw2oMn8VN3sS+iXu+t5h96hs2+PQCFqg+M9cxSg/KsBR8HkYWNXb6/k0AdP
	 Y0RKoIOPxz9+3wsESh1s20EpBIBX7Sbpnt5tqABMVtyxXBhl/IYZVNAWoXUF/VkY/P
	 iqSOjJ3LMC3iRj3ZpAMMoH530zrI/NE+exfwUei2pLJrTx/5+jD4+ZIw6xU5o0v8To
	 G3kvjTZNn29jw==
Message-ID: <72edd2f60b4a91437c73a9b49ec85a37586512a5.camel@kernel.org>
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <cel@kernel.org>, Benjamin Coddington
 <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Anna Schumaker <anna@kernel.org>, Eric Biggers
 <ebiggers@kernel.org>,  Rick Macklem <rick.macklem@gmail.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Date: Fri, 16 Jan 2026 15:03:20 -0500
In-Reply-To: <683798bf-b7f3-4418-99ce-b15b0788c960@kernel.org>
References: <cover.1768573690.git.bcodding@hammerspace.com>
	 <f8e2d466-7280-4a21-ad71-21bf1e546300@app.fastmail.com>
	 <C69B1F13-7248-4CAF-977C-5F0236B0923A@hammerspace.com>
	 <683798bf-b7f3-4418-99ce-b15b0788c960@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-01-16 at 14:43 -0500, Chuck Lever wrote:
> On 1/16/26 12:17 PM, Benjamin Coddington wrote:
> > On 16 Jan 2026, at 11:56, Chuck Lever wrote:
> >=20
> > > On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
> > > > The following series enables the linux NFS server to add a
> > > > Message
> > > > Authentication Code (MAC) to the filehandles it gives to
> > > > clients.=C2=A0 This
> > > > provides additional protection to the exported filesystem
> > > > against filehandle
> > > > guessing attacks.
> > > >=20
> > > > Filesystems generate their own filehandles through the
> > > > export_operation
> > > > "encode_fh" and a filehandle provides sufficient access to open
> > > > a file
> > > > without needing to perform a lookup.=C2=A0 An NFS client holding a
> > > > valid
> > > > filehandle can remotely open and read the contents of the file
> > > > referred to
> > > > by the filehandle.
> > >=20
> > > "open, read, or modify the contents of the file"
> > >=20
> > > Btw, referring to "open" here is a little confusing, since NFSv3
> > > does
> > > not have an on-the-wire OPEN operation. I'm not sure how to
> > > clarify.
> > >=20
> > >=20
> > > > In order to acquire a filehandle, you must perform lookup
> > > > operations on the
> > > > parent directory(ies), and the permissions on those directories
> > > > may
> > > > prohibit you from walking into them to find the files within.=C2=A0
> > > > This would
> > > > normally be considered sufficient protection on a local
> > > > filesystem to
> > > > prohibit users from accessing those files, however when the
> > > > filesystem is
> > > > exported via NFS those files can still be accessed by guessing
> > > > the correct,
> > > > valid filehandles.
> > >=20
> > > Instead: "an exported file can be accessed whenever the NFS
> > > server is
> > > presented with the correct filehandle, which can be guessed or
> > > acquired
> > > by means other than LOOKUP."
> > >=20
> > >=20
> > > > Filehandles are easy to guess because they are well-formed.=C2=A0
> > > > The
> > > > open_by_handle_at(2) man page contains an example C program
> > > > (t_name_to_handle_at.c) that can display a filehandle given a
> > > > path.=C2=A0 Here's
> > > > an example filehandle from a fairly modern XFS:
> > > >=20
> > > > # ./t_name_to_handle_at /exports/foo
> > > > 57
> > > > 12 129=C2=A0=C2=A0=C2=A0 99 00 00 00 00 00 00 00 b4 10 0b 8c
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^---------=
=C2=A0 filehandle=C2=A0 ----------^
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^------- ino=
de -------^ ^-- gen --^
> > > >=20
> > > > This filehandle consists of a 64-bit inode number and 32-bit
> > > > generation
> > > > number.=C2=A0 Because the handle is well-formed, its easy to
> > > > fabricate
> > > > filehandles that match other files within the same filesystem.=C2=
=A0
> > > > You can
> > > > simply insert inode numbers and iterate on the generation
> > > > number.
> > > > Eventually you'll be able to access the file using
> > > > open_by_handle_at(2).
> > > > For a local system, open_by_handle_at(2) requires
> > > > CAP_DAC_READ_SEARCH, which
> > > > protects against guessing attacks by unprivileged users.
> > > >=20
> > > > In contrast to a local user using open_by_handle(2), the NFS
> > > > server must
> > > > permissively allow remote clients to open by filehandle without
> > > > being able
> > > > to check or trust the remote caller's access.
>=20
> Btw, "allow ... clients to open by filehandle" is another confusion.
>=20
> NFSv4 OPEN does do access checking and authorization.
>=20
> Again, it's NFS READ and WRITE that are not blocked.
>=20
> NFSv3 READ and WRITE do an intrinsic open.
>=20
> NFSv4 READ and WRITE permit the use of a special stateid so that an
> OPEN
> isn't necessary to do the I/O (IIRC).
>=20
>=20
> > > > Therefore additional
> > > > protection against this attack is needed for NFS case.=C2=A0 We
> > > > propose to sign
> > > > filehandles by appending an 8-byte MAC which is the siphash of
> > > > the
> > > > filehandle from a key set from the nfs-utilities.=C2=A0 NFS server
> > > > can then
> > > > ensure that guessing a valid filehandle+MAC is practically
> > > > impossible
> > > > without knowledge of the MAC's key.=C2=A0 The NFS server performs
> > > > optional
> > > > signing by possessing a key set from userspace and having the
> > > > "sign_fh"
> > > > export option.
> > >=20
> > > OK, I guess this is where I got the idea this would be an export
> > > option.
> > >=20
> > > But I'm unconvinced that this provides any real security. There
> > > are
> > > other ways of obtaining a filehandle besides guessing, and
> > > nothing
> > > here suggests that guessing is the premier attack methodology.
> >=20
> > Help me understand you - you're unconvinced that having the server
> > sign
> > filehandles and verify filehandles prevents clients from
> > fabricating valid
> > ones?
>=20
> The rationale provided here doesn't convince me that fabrication is
> the
> biggest threat and will give us the biggest bang for our buck if it
> is
> mitigated.
>=20
> In order to carry out this attack, the attacker has to have access to
> the filehandles on an NFS client to examine them. She has to have
> access to a valid client IP address to send NFS requests from. Maybe
> you can bridge the gap by explaining how a /non-root/ user on an NFS
> client might leverage FH fabrication to gain access to another user's
> files. I think only the root user has this ability.
>=20
> I've also tried to convince myself that cryptographic FH validation
> could mitigate misdirected WRITEs or READs. An attacker could replace
> the FH in a valid NFS request, for example, or a client might send
> garbage in an FH. I'm not sure those are real problems, though.
>=20
> I am keeping in mind that everything here is using AUTH_SYS anyway,
> so
> maybe I'm just an old man yelling at a cloud. Nothing here is
> blocking
> yet, but I want the feature to provide meaningful value (as I think
> you
> do).
>=20
> Thank you for bearing with me.
>=20

Yes, there may be a root squash option that prevents synthesis of root
credentials, but that's not necessarily an impediment:

We assume that the attacker does have access to a userspace NFS client
on the authorised client and that they can synthesize calls.
If so, then GETATTR is unprivileged and will happily give up knowledge
of which owner/group combination to synthesize in an OPEN, READ or
WRITE call.


--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

