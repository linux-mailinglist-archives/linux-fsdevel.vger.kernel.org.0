Return-Path: <linux-fsdevel+bounces-26552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A00295A5B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 22:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F41F3B22A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39616F830;
	Wed, 21 Aug 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njgTdnmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6A41D12F4;
	Wed, 21 Aug 2024 20:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271290; cv=none; b=CwfcuVDo7vQ/bGASnr/kzONYdi8URs7QkeNUu1QMtMYNqyr32KRsjvMv0hVygLlNkNAEOV7KdFAxVxhI8WG7pKySAA6k2Ew0OUkOXcJ4v1oZs4SMDQxiJhA73fwdRGBZBuFjax2CA0gYUABFOBqiSAJUu1/2YxLYft5RT4e3z1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271290; c=relaxed/simple;
	bh=27okc9Z8VqzyGucSMkZIzant9+TRx4eRZtUbKLZ/s0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYpVz5DptVzwNEPBYlI2oinzSQKZPKR7ItPAc9IZ9ZDT1jd6CIahKPuf/G7jOYKpx/SuLD0Zruu5ASGxrD5uhODwrpnIEsmBdIav1viOP2rQjkWPSmH/AEtmnJXDigp8pJL+dl0apOjqBPsiDcoSqiuQPLWRzyiDciQwC2HABjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njgTdnmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFE1C32781;
	Wed, 21 Aug 2024 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724271290;
	bh=27okc9Z8VqzyGucSMkZIzant9+TRx4eRZtUbKLZ/s0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njgTdnmh368stv/IWNxhUQyBxr1HxRx8Z2y0biKHYXMORcjDqrwEK3jSPrSWbtYua
	 m4OG/24mitWRsmnZyiEozgf5FVHrvFWzukXWxeKDW0cGNTAB2G4NVzWhcyFdHmv2VS
	 BqIRVQI9PTiDX9ognw4IUYC3Cphjnsjfog7lcPnMaKUYwbRqqGff1D5KCU2y60Ugnk
	 EH1MB+ygI9pmIzPQiL9rzxc74fnSp+4ASMph55UFsw65xKmBXk75GrBFGSozQO5ry3
	 Y1JPDPBD3/2sMUposWbNkgukVYa45A4kH3LugHdInwY1mjNHHQHcvFRyqoONPMbpKn
	 0ppfQckWQxG/Q==
Date: Wed, 21 Aug 2024 16:14:48 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 24/24] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Message-ID: <ZsZKuPopU32Rlq4t@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <20240819181750.70570-25-snitzer@kernel.org>
 <115f7c93d81d080ce6aac64eaa4e8616a5fe0cdd.camel@kernel.org>
 <ZsZKQV8qRVQY8g00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsZKQV8qRVQY8g00@kernel.org>

On Wed, Aug 21, 2024 at 04:12:49PM -0400, Mike Snitzer wrote:
> On Wed, Aug 21, 2024 at 03:03:07PM -0400, Jeff Layton wrote:
> > On Mon, 2024-08-19 at 14:17 -0400, Mike Snitzer wrote:
> > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > 
> > > Add a FAQ section to give answers to questions that have been raised
> > > during review of the localio feature.
> > > 
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  Documentation/filesystems/nfs/localio.rst | 77 +++++++++++++++++++++++
> > >  1 file changed, 77 insertions(+)
> > > 
> > > diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
> > > index d8bdab88f1db..acd8f3e5d87a 100644
> > > --- a/Documentation/filesystems/nfs/localio.rst
> > > +++ b/Documentation/filesystems/nfs/localio.rst
> > > @@ -40,6 +40,83 @@ fio for 20 secs with 24 libaio threads, 128k directio reads, qd of 8,
> > >  - Without LOCALIO:
> > >    read: IOPS=12.0k, BW=1495MiB/s (1568MB/s)(29.2GiB/20015msec)
> > >  
> > > +FAQ
> > > +===
> > > +
> > > +1. What are the use cases for LOCALIO?
> > > +
> > > +   a. Workloads where the NFS client and server are on the same host
> > > +      realize improved IO performance. In particular, it is common when
> > > +      running containerised workloads for jobs to find themselves
> > > +      running on the same host as the knfsd server being used for
> > > +      storage.
> > > +
> > > +2. What are the requirements for LOCALIO?
> > > +
> > > +   a. Bypass use of the network RPC protocol as much as possible. This
> > > +      includes bypassing XDR and RPC for open, read, write and commit
> > > +      operations.
> > > +   b. Allow client and server to autonomously discover if they are
> > > +      running local to each other without making any assumptions about
> > > +      the local network topology.
> > > +   c. Support the use of containers by being compatible with relevant
> > > +      namespaces (e.g. network, user, mount).
> > > +   d. Support all versions of NFS. NFSv3 is of particular importance
> > > +      because it has wide enterprise usage and pNFS flexfiles makes use
> > > +      of it for the data path.
> > > +
> > > +3. Why doesn´t LOCALIO just compare IP addresses or hostnames when
> > > +   deciding if the NFS client and server are co-located on the same
> > > +   host?
> > > +
> > > +   Since one of the main use cases is containerised workloads, we cannot
> > > +   assume that IP addresses will be shared between the client and
> > > +   server. This sets up a requirement for a handshake protocol that
> > > +   needs to go over the same connection as the NFS traffic in order to
> > > +   identify that the client and the server really are running on the
> > > +   same host. The handshake uses a secret that is sent over the wire,
> > > +   and can be verified by both parties by comparing with a value stored
> > > +   in shared kernel memory if they are truly co-located.
> > > +
> > > +4. Does LOCALIO improve pNFS flexfiles?
> > > +
> > > +   Yes, LOCALIO complements pNFS flexfiles by allowing it to take
> > > +   advantage of NFS client and server locality.  Policy that initiates
> > > +   client IO as closely to the server where the data is stored naturally
> > > +   benefits from the data path optimization LOCALIO provides.
> > > +
> > > +5. Why not develop a new pNFS layout to enable LOCALIO?
> > > +
> > > +   A new pNFS layout could be developed, but doing so would put the
> > > +   onus on the server to somehow discover that the client is co-located
> > > +   when deciding to hand out the layout.
> > > +   There is value in a simpler approach (as provided by LOCALIO) that
> > > +   allows the NFS client to negotiate and leverage locality without
> > > +   requiring more elaborate modeling and discovery of such locality in a
> > > +   more centralized manner.
> > > +
> > > +6. Why is having the client perform a server-side file OPEN, without
> > > +   using RPC, beneficial?  Is the benefit pNFS specific?
> > > +
> > > +   Avoiding the use of XDR and RPC for file opens is beneficial to
> > > +   performance regardless of whether pNFS is used. However adding a
> > > +   requirement to go over the wire to do an open and/or close ends up
> > > +   negating any benefit of avoiding the wire for doing the I/O itself
> > > +   when we´re dealing with small files. There is no benefit to replacing
> > > +   the READ or WRITE with a new open and/or close operation that still
> > > +   needs to go over the wire.
> > > +
> > > +7. Why is LOCALIO only supported with UNIX Authentication (AUTH_UNIX)?
> > > +
> > > +   Strong authentication is usually tied to the connection itself. It
> > > +   works by establishing a context that is cached by the server, and
> > > +   that acts as the key for discovering the authorisation token, which
> > > +   can then be passed to rpc.mountd to complete the authentication
> > > +   process. On the other hand, in the case of AUTH_UNIX, the credential
> > > +   that was passed over the wire is used directly as the key in the
> > > +   upcall to rpc.mountd. This simplifies the authentication process, and
> > > +   so makes AUTH_UNIX easier to support.
> > > +
> > >  RPC
> > >  ===
> > >  
> > 
> > I'd just squash this into patch #19.
> 
> That'd use the fact Trond is the author.

s/use/lose/

> 
> Does linux have a shortage on commit ids I'm unaware of? ;)
> 

Anyway, I'd prefer the FAQ be left split out as a separate commit
given the author is different.

