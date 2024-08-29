Return-Path: <linux-fsdevel+bounces-27746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40FD9637F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71AF1C21D51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901E02BAEB;
	Thu, 29 Aug 2024 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXBQ4p3k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E879F25777;
	Thu, 29 Aug 2024 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896031; cv=none; b=P9GiCFNueNT7cdatel4DXh46zGU0nh01TAoBccF60luxw/ze2mk/EuYL3fbauaAIoQGc1MCDtnG/0kiv5T49RAaDtLKr7x1iufjQF+fFVSR/fZGJxdamU0Bj0zUwFBCFT1+fkGvICOx1fQBKur4JhUEpQ1OrEYhtldc6WedNWl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896031; c=relaxed/simple;
	bh=rX03S+qYQPU1f9W/MD3wNiLX4lQKlgxcmGgXmzT6Ne0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIWESaFxfrTUNoSNix7ZZbaGwIIKFcbQD88tDuNBP4fWKWaaGluE7s01F8yRJYSOXFMhyzii4fr9qW7uqZBZ3dcozrOXV2O7Vb5m0NWDmFByp0JZZ8CKX2q1MGVaCC6uutOH+ZuKQfDc//5rUUMCuaqEmpYKf79vf0vCv4hVSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXBQ4p3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD4BC4CEC0;
	Thu, 29 Aug 2024 01:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724896030;
	bh=rX03S+qYQPU1f9W/MD3wNiLX4lQKlgxcmGgXmzT6Ne0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXBQ4p3ktBRLq7SEpdbXhGgT7GPvyh1zLlAwqR4UvEI86b6ibrG72EUyGX2HkyCp3
	 BFK/kAboOP/JXM4GXm/0keHm4S40ouDBFRwBpLJ8xwXbk5HnwnkygPC16uH8iBVD/t
	 BsMBsUKtLuaj1ykoojBb/2WMe+FstGQAhNpSN935VEK5y+fIh+xKjYS3dcWWGofeP5
	 ULm1WkUrVDmEFVexFQri3Q9w+GukdXWxkLNnXJWHO/9R4uidYi6J5QycarXaIEm3Ic
	 +TdaSrcKy6tYZBR70hhcFail28FM8LNoqUl2mIzaES+B2+Tp/OzUfr4/QUY+bbWLlp
	 x/gwAS5YWqmtQ==
Date: Wed, 28 Aug 2024 21:47:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14.5 25/25] nfs: add FAQ section to
 Documentation/filesystems/nfs/localio.rst
Message-ID: <Zs_THTtfEsY8Pcya@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-26-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829010424.83693-26-snitzer@kernel.org>

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a FAQ section to give answers to questions that have been raised
during review of the localio feature.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 78 +++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index 8cceb3db386a..5d652f637a97 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -61,6 +61,84 @@ fio for 20 secs with directio, qd of 8, 1 libaio thread:
   128K read:  IOPS=24.4k, BW=3050MiB/s (3198MB/s)(59.6GiB/20001msec)
   128K write: IOPS=11.4k, BW=1430MiB/s (1500MB/s)(27.9GiB/20001msec)
 
+FAQ
+===
+
+1. What are the use cases for LOCALIO?
+
+   a. Workloads where the NFS client and server are on the same host
+      realize improved IO performance. In particular, it is common when
+      running containerised workloads for jobs to find themselves
+      running on the same host as the knfsd server being used for
+      storage.
+
+2. What are the requirements for LOCALIO?
+
+   a. Bypass use of the network RPC protocol as much as possible. This
+      includes bypassing XDR and RPC for open, read, write and commit
+      operations.
+   b. Allow client and server to autonomously discover if they are
+      running local to each other without making any assumptions about
+      the local network topology.
+   c. Support the use of containers by being compatible with relevant
+      namespaces (e.g. network, user, mount).
+   d. Support all versions of NFS. NFSv3 is of particular importance
+      because it has wide enterprise usage and pNFS flexfiles makes use
+      of it for the data path.
+
+3. Why doesn´t LOCALIO just compare IP addresses or hostnames when
+   deciding if the NFS client and server are co-located on the same
+   host?
+
+   Since one of the main use cases is containerised workloads, we cannot
+   assume that IP addresses will be shared between the client and
+   server. This sets up a requirement for a handshake protocol that
+   needs to go over the same connection as the NFS traffic in order to
+   identify that the client and the server really are running on the
+   same host. The handshake uses a secret that is sent over the wire,
+   and can be verified by both parties by comparing with a value stored
+   in shared kernel memory if they are truly co-located.
+
+4. Does LOCALIO improve pNFS flexfiles?
+
+   Yes, LOCALIO complements pNFS flexfiles by allowing it to take
+   advantage of NFS client and server locality.  Policy that initiates
+   client IO as closely to the server where the data is stored naturally
+   benefits from the data path optimization LOCALIO provides.
+
+5. Why not develop a new pNFS layout to enable LOCALIO?
+
+   A new pNFS layout could be developed, but doing so would put the
+   onus on the server to somehow discover that the client is co-located
+   when deciding to hand out the layout.
+   There is value in a simpler approach (as provided by LOCALIO) that
+   allows the NFS client to negotiate and leverage locality without
+   requiring more elaborate modeling and discovery of such locality in a
+   more centralized manner.
+
+6. Why is having the client perform a server-side file OPEN, without
+   using RPC, beneficial?  Is the benefit pNFS specific?
+
+   Avoiding the use of XDR and RPC for file opens is beneficial to
+   performance regardless of whether pNFS is used. Especially when
+   dealing with small files its best to avoid going over the wire
+   whenever possible, otherwise it could reduce or even negate the
+   benefits of avoiding the wire for doing the small file I/O itself.
+   Given LOCALIO's requirements the current approach of having the
+   client perform a server-side file open, without using RPC, is ideal.
+   If in the future requirements change then we can adapt accordingly.
+
+7. Why is LOCALIO only supported with UNIX Authentication (AUTH_UNIX)?
+
+   Strong authentication is usually tied to the connection itself. It
+   works by establishing a context that is cached by the server, and
+   that acts as the key for discovering the authorisation token, which
+   can then be passed to rpc.mountd to complete the authentication
+   process. On the other hand, in the case of AUTH_UNIX, the credential
+   that was passed over the wire is used directly as the key in the
+   upcall to rpc.mountd. This simplifies the authentication process, and
+   so makes AUTH_UNIX easier to support.
+
 RPC
 ===
 
-- 
2.44.0


