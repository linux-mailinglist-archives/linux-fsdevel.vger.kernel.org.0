Return-Path: <linux-fsdevel+bounces-28135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7754B9673CE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D401B20FA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144F7199943;
	Sat, 31 Aug 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag87et/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329D155A24;
	Sat, 31 Aug 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143910; cv=none; b=twLV6VkCY7SxrFoEBp+wFfmpCZuzgcWTNdv3i64n3I53NxlfxOVhicNKV/KEdCT60gJDrEu3IqxrmYxedJ1G75lVNkOpidv72XivRsyZY3KuLczUD7jGF7miUmTpdDJYkhAUhMnRXEW6pyLqE+4wIppcFJyRsypKbSOmJKd9qSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143910; c=relaxed/simple;
	bh=ob7BER3VjWVl41/BEx6EWVQ81ADvOoQ98+MtcTJqOBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7wfiNfcn7OO3hS9+RTRbSP9Kw8AX4JCS9rQd6qbeUrhmXMpc21X+SlNQ9RvcgafQdaXTP4njvEuQAZEKQ1lBLpVi0x+6IShRXNIbhR0grizd9ERzoClw+d/CJPpflsx/uzH3f7HT/ORqs7DtwyQacIXc0BE0L7AoIT5MFN2LLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag87et/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2143BC4CEC0;
	Sat, 31 Aug 2024 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143910;
	bh=ob7BER3VjWVl41/BEx6EWVQ81ADvOoQ98+MtcTJqOBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ag87et/w9exUFpAiuAcMBVDxSGEsa6An7zryYZ4k7uhUZuGw92HSKzp01Nl+BTT5D
	 VJUHfmeP3djQhZrRQDdi97mniiF6EWOZ4ubVSALvLiuGEJWdq2PHdILa9owPCJ/TxG
	 1Qj1kC06E18sxfuQWQiCtpb/OAtmevbeLstSZw37jcbVmvM5AqkX3DADsg0KDjIBfe
	 XREinpihARmFZmB20kTsulIOTGHoUUqZphhGr4SXDUXEK17ywIpHotjdr59/mbw8Uq
	 I6rINuEFSgwj4zsKF1TEqrLFgCdOjI4RZjY7SDJr/0zQEc4r1ddxl1ZOP2XVp6p2Yj
	 qVRZ6UQ5m7OzQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 25/26] nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst
Date: Sat, 31 Aug 2024 18:37:45 -0400
Message-ID: <20240831223755.8569-26-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a FAQ section to give answers to questions that have been raised
during review of the localio feature.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 Documentation/filesystems/nfs/localio.rst | 86 +++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index 3c9bc370079b..ef3851d48133 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -64,6 +64,92 @@ fio for 20 secs with directio, qd of 8, 1 libaio thread:
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
+3. Why doesn’t LOCALIO just compare IP addresses or hostnames when
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
+8. How do export options that translate RPC user IDs behave for LOCALIO
+   operations (eg. root_squash, all_squash)?
+
+   Export options that translate user IDs are managed by nfsd_setuser()
+   which is called by nfsd_setuser_and_check_port() which is called by
+   __fh_verify().  So they get handled exactly the same way for LOCALIO
+   as they do for non-LOCALIO.
+
 RPC
 ===
 
-- 
2.44.0


