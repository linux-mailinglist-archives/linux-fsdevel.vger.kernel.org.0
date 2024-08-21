Return-Path: <linux-fsdevel+bounces-26576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F80695A879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6BC283DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178F917DE0E;
	Wed, 21 Aug 2024 23:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLnOncsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712DC14D2A8;
	Wed, 21 Aug 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283967; cv=none; b=HaLqogSurrG1GY86QaSxbn2PtfxLnwUZlUxqlakDecZH1PjCDTM08VXCAC4JGPOyFVbXrpyHhpcfG0z/3VdGj+dT+Zb7L3Yy0tO6aPgQY2+lJbRDsUZDQ/FePdWwEgnoQNMj9CSUIVhfcFXDd4A9wlgGvh/X61uClyh56V9exMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283967; c=relaxed/simple;
	bh=AxgfQd6rFlMqUE4kChvgvWpCo6+oJEMO0S7x2rz4lZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=srWpQbpHbCf05QiVWXWMuPZggqYRMXym8N0ImPLoxNBSNaJlNRlEq5X8aTn1luI8LG0KXx2MPlslac2MWQE9244W1FTDe0CBffXfAib9CoEOBuv+fEs7c+Bib8q5W24UjtYoKupdj+OD1ZFlmrtA9VpyGPXl++fhz3wwn8An1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLnOncsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56209C32782;
	Wed, 21 Aug 2024 23:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724283967;
	bh=AxgfQd6rFlMqUE4kChvgvWpCo6+oJEMO0S7x2rz4lZc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QLnOncsQevIH2EXB60TNVUBrWVPmGORFCuP6ORrXGV48R5YsKfOS9ntob8mPg0LZe
	 c70WkUV72x9C4mX/j335/4ULAAHL8C+jSVHQeLK9D1GEYYkpbBwd8mgrKv++fsr3o7
	 6qFZ8dTTgNjMjr+IOlJR5yewwBknbvTop3iWZICjBmuM8rnWCS+1llMmPfOpgVE/G0
	 Dh2EBsUgQpInXaoQWoccoH0UVHuF9pG96EBkcLD/ir60dPBcH4iqKcweKmMbOMNZJ8
	 pKw9eocjDMBPYUOjgdN/+UK0WJoKIy+/jcCXGh6QeaOiaX5me4fjHA3N8wnsX9/cMT
	 V11owPt8h6jfA==
Message-ID: <14a0177611aa77660425487e30c3f9b6313bf6be.camel@kernel.org>
Subject: Re: [PATCH v12 24/24] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, Anna
 Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>,
 NeilBrown <neilb@suse.de>,  linux-fsdevel@vger.kernel.org
Date: Wed, 21 Aug 2024 19:46:05 -0400
In-Reply-To: <ZsZKuPopU32Rlq4t@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
	 <20240819181750.70570-25-snitzer@kernel.org>
	 <115f7c93d81d080ce6aac64eaa4e8616a5fe0cdd.camel@kernel.org>
	 <ZsZKQV8qRVQY8g00@kernel.org> <ZsZKuPopU32Rlq4t@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 16:14 -0400, Mike Snitzer wrote:
> On Wed, Aug 21, 2024 at 04:12:49PM -0400, Mike Snitzer wrote:
> > On Wed, Aug 21, 2024 at 03:03:07PM -0400, Jeff Layton wrote:
> > > On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > >=20
> > > > Add a FAQ section to give answers to questions that have been raise=
d
> > > > during review of the localio feature.
> > > >=20
> > > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > > =C2=A0Documentation/filesystems/nfs/localio.rst | 77 ++++++++++++++=
+++++++++
> > > > =C2=A01 file changed, 77 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentat=
ion/filesystems/nfs/localio.rst
> > > > index d8bdab88f1db..acd8f3e5d87a 100644
> > > > --- a/Documentation/filesystems/nfs/localio.rst
> > > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > > @@ -40,6 +40,83 @@ fio for 20 secs with 24 libaio threads, 128k dir=
ectio reads, qd of 8,
> > > > =C2=A0- Without LOCALIO:
> > > > =C2=A0=C2=A0 read: IOPS=3D12.0k, BW=3D1495MiB/s (1568MB/s)(29.2GiB/=
20015msec)
> > > > =C2=A0
> > > > +FAQ
> > > > +=3D=3D=3D
> > > > +
> > > > +1. What are the use cases for LOCALIO?
> > > > +
> > > > +=C2=A0=C2=A0 a. Workloads where the NFS client and server are on t=
he same host
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 realize improved IO performance. In=
 particular, it is common when
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 running containerised workloads for=
 jobs to find themselves
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 running on the same host as the knf=
sd server being used for
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 storage.
> > > > +
> > > > +2. What are the requirements for LOCALIO?
> > > > +
> > > > +=C2=A0=C2=A0 a. Bypass use of the network RPC protocol as much as =
possible. This
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 includes bypassing XDR and RPC for =
open, read, write and commit
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 operations.
> > > > +=C2=A0=C2=A0 b. Allow client and server to autonomously discover i=
f they are
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 running local to each other without=
 making any assumptions about
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the local network topology.
> > > > +=C2=A0=C2=A0 c. Support the use of containers by being compatible =
with relevant
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 namespaces (e.g. network, user, mou=
nt).
> > > > +=C2=A0=C2=A0 d. Support all versions of NFS. NFSv3 is of particula=
r importance
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 because it has wide enterprise usag=
e and pNFS flexfiles makes use
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of it for the data path.
> > > > +
> > > > +3. Why doesn=C2=B4t LOCALIO just compare IP addresses or hostnames=
 when
> > > > +=C2=A0=C2=A0 deciding if the NFS client and server are co-located =
on the same
> > > > +=C2=A0=C2=A0 host?
> > > > +
> > > > +=C2=A0=C2=A0 Since one of the main use cases is containerised work=
loads, we cannot
> > > > +=C2=A0=C2=A0 assume that IP addresses will be shared between the c=
lient and
> > > > +=C2=A0=C2=A0 server. This sets up a requirement for a handshake pr=
otocol that
> > > > +=C2=A0=C2=A0 needs to go over the same connection as the NFS traff=
ic in order to
> > > > +=C2=A0=C2=A0 identify that the client and the server really are ru=
nning on the
> > > > +=C2=A0=C2=A0 same host. The handshake uses a secret that is sent o=
ver the wire,
> > > > +=C2=A0=C2=A0 and can be verified by both parties by comparing with=
 a value stored
> > > > +=C2=A0=C2=A0 in shared kernel memory if they are truly co-located.
> > > > +
> > > > +4. Does LOCALIO improve pNFS flexfiles?
> > > > +
> > > > +=C2=A0=C2=A0 Yes, LOCALIO complements pNFS flexfiles by allowing i=
t to take
> > > > +=C2=A0=C2=A0 advantage of NFS client and server locality.=C2=A0 Po=
licy that initiates
> > > > +=C2=A0=C2=A0 client IO as closely to the server where the data is =
stored naturally
> > > > +=C2=A0=C2=A0 benefits from the data path optimization LOCALIO prov=
ides.
> > > > +
> > > > +5. Why not develop a new pNFS layout to enable LOCALIO?
> > > > +
> > > > +=C2=A0=C2=A0 A new pNFS layout could be developed, but doing so wo=
uld put the
> > > > +=C2=A0=C2=A0 onus on the server to somehow discover that the clien=
t is co-located
> > > > +=C2=A0=C2=A0 when deciding to hand out the layout.
> > > > +=C2=A0=C2=A0 There is value in a simpler approach (as provided by =
LOCALIO) that
> > > > +=C2=A0=C2=A0 allows the NFS client to negotiate and leverage local=
ity without
> > > > +=C2=A0=C2=A0 requiring more elaborate modeling and discovery of su=
ch locality in a
> > > > +=C2=A0=C2=A0 more centralized manner.
> > > > +
> > > > +6. Why is having the client perform a server-side file OPEN, witho=
ut
> > > > +=C2=A0=C2=A0 using RPC, beneficial?=C2=A0 Is the benefit pNFS spec=
ific?
> > > > +
> > > > +=C2=A0=C2=A0 Avoiding the use of XDR and RPC for file opens is ben=
eficial to
> > > > +=C2=A0=C2=A0 performance regardless of whether pNFS is used. Howev=
er adding a
> > > > +=C2=A0=C2=A0 requirement to go over the wire to do an open and/or =
close ends up
> > > > +=C2=A0=C2=A0 negating any benefit of avoiding the wire for doing t=
he I/O itself
> > > > +=C2=A0=C2=A0 when we=C2=B4re dealing with small files. There is no=
 benefit to replacing
> > > > +=C2=A0=C2=A0 the READ or WRITE with a new open and/or close operat=
ion that still
> > > > +=C2=A0=C2=A0 needs to go over the wire.
> > > > +
> > > > +7. Why is LOCALIO only supported with UNIX Authentication (AUTH_UN=
IX)?
> > > > +
> > > > +=C2=A0=C2=A0 Strong authentication is usually tied to the connecti=
on itself. It
> > > > +=C2=A0=C2=A0 works by establishing a context that is cached by the=
 server, and
> > > > +=C2=A0=C2=A0 that acts as the key for discovering the authorisatio=
n token, which
> > > > +=C2=A0=C2=A0 can then be passed to rpc.mountd to complete the auth=
entication
> > > > +=C2=A0=C2=A0 process. On the other hand, in the case of AUTH_UNIX,=
 the credential
> > > > +=C2=A0=C2=A0 that was passed over the wire is used directly as the=
 key in the
> > > > +=C2=A0=C2=A0 upcall to rpc.mountd. This simplifies the authenticat=
ion process, and
> > > > +=C2=A0=C2=A0 so makes AUTH_UNIX easier to support.
> > > > +
> > > > =C2=A0RPC
> > > > =C2=A0=3D=3D=3D
> > > > =C2=A0
> > >=20
> > > I'd just squash this into patch #19.
> >=20
> > That'd use the fact Trond is the author.
>=20
> s/use/lose/
>=20
> >=20
> > Does linux have a shortage on commit ids I'm unaware of? ;)
> >=20
>=20
> Anyway, I'd prefer the FAQ be left split out as a separate commit
> given the author is different.

No worries. I don't feel as strongly about this one.
--=20
Jeff Layton <jlayton@kernel.org>

