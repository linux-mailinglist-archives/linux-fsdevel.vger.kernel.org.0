Return-Path: <linux-fsdevel+bounces-27738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A44D963781
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C911F21545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59614B96B;
	Thu, 29 Aug 2024 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3vwm91+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2C14A0A3;
	Thu, 29 Aug 2024 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893500; cv=none; b=ToF3qa5OlI0DKNZ8ICI3vLwUsCCCeC3FcYz2sziiyc6vTGtVDg0uXv+qTTrnOUnmvtDqL9IIFilcTSejKPu3RK788hm25hjxca/bmmj2sK2VvRaAb+6YjDElbPPxzAqq0QQHFRphZUIzo4lMMzO6evdATnKoZNUUL59W0EyqlN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893500; c=relaxed/simple;
	bh=xB08nBAPl61OofPOGvwFRENxEZD1qCG61thY+k7r1kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gejoCKZaZOcW1sPP+Nrs6s5GjjtypJoXxcC3VvlWI32nKqKTK5JFb+3l+T0qiS5GYHFkw1htbmyUyFX9q+20P7t85YHJZfbwVJdzMRdWsjesGgpscsj7mtxvhJT5zLW4EZfeYx7emZJCtyYObv5nV8dhtYtpj5VpckT6SiNf+3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3vwm91+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6000AC4CEC0;
	Thu, 29 Aug 2024 01:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893499;
	bh=xB08nBAPl61OofPOGvwFRENxEZD1qCG61thY+k7r1kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3vwm91+pfep6ywXjzulH491xDiAOp5OVtzGRsCJMR+hUMxZNRbWW/UnDvtjocpUl
	 ts63Laz/L0JoQiMykPsFJq4FmCMMM/aAgLtzQl9ERbwkpqgToIUCx8bgX74+LU2cdh
	 CN7+rVCEKsHzi4GebiGIHRQzuK8x2nNKBMZhXlHx31+2hZ+S/OJGfj6hWVqX436Wvx
	 zcutbDrczOkayBpA7oVOASTflKfL/BS0dkcatZCzEIeKhlml5rFsun8/4ESbFGCz+O
	 k3/zeVKM0CTPltTsRAoG5kFwHg+R3V17y83KdNYCdZcvXCVXDY232bSkaJc/ABPYE3
	 1r96VKwjCeidw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 25/25] nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst
Date: Wed, 28 Aug 2024 21:04:20 -0400
Message-ID: <20240829010424.83693-26-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
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
 Documentation/filesystems/nfs/localio.rst | 77 +++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/filesystems/nfs/localio.rst b/Documentation/filesystems/nfs/localio.rst
index 8cceb3db386a..4b6d63246479 100644
--- a/Documentation/filesystems/nfs/localio.rst
+++ b/Documentation/filesystems/nfs/localio.rst
@@ -61,6 +61,83 @@ fio for 20 secs with directio, qd of 8, 1 libaio thread:
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
+   performance regardless of whether pNFS is used. However adding a
+   requirement to go over the wire to do an open and/or close ends up
+   negating any benefit of avoiding the wire for doing the I/O itself
+   when we’re dealing with small files. There is no benefit to replacing
+   the READ or WRITE with a new open and/or close operation that still
+   needs to go over the wire.
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


