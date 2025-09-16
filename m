Return-Path: <linux-fsdevel+bounces-61473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 735DCB58903
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D67A2A023E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6FC19F43A;
	Tue, 16 Sep 2025 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hruFeid9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7729A19CC28;
	Tue, 16 Sep 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981930; cv=none; b=k8etONroUJrWuF4s7ViilwQj8sGQD33MiAKsU/4psUwt3nBKEW/nVtN6tn+l4xD7PTEZxbqkFuRg8BtKY8xYadaN48J2WuhDYZF6vaLRN+PimWxbY9fvnu0G1A+hqvG6bjWlZGEeRcnGJznhkucru2MZvWOOhDCeAfjfT9pEJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981930; c=relaxed/simple;
	bh=6eaSealOEBcJNpcbHmJ4NlwaZ742E8cMJpzP7JdwXLE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hu6pWhNQDFWRKlGaTwlQ2V/ifMUKqsW25YsfiIOyweWjf9livDGKBTzVTqwDKd8ebrrk15LN3L6tvPTnEs93WqPvBvyUZeln27Nqk2rwowUlspeWnQ0Ou+eHhUCDEPrHb2Xx/JFKnR0DtSUmZ2A26ndqCeoBbV4Iab3vAZwYntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hruFeid9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B55EC4CEF1;
	Tue, 16 Sep 2025 00:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757981930;
	bh=6eaSealOEBcJNpcbHmJ4NlwaZ742E8cMJpzP7JdwXLE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hruFeid9gm5oHwobmPTEFwRhDQ/NUbAcIJYP+HzZdQ49O1otdN9x/AvYH062Mj6jr
	 X1BVMfNi0d/CyD7dh06lg2TIVJzPk9v63h4A2C5vkJ8VRM+qPnKdM0+0hpGkdyR8pB
	 AmCop7tP1+Z1sSVDIF0xZ61p2jNXVREDWaCjnk8PeWQbUkUqZuLbXZWHd/dhJwCw5P
	 sbblQC6rHO/olaLMbZNGuxeWtotqoScSCsVW0QSgdYTM9dR7wQEswexdvqfmEBcINv
	 XRGLedF6YTRr3L/+vVqJC0nPzMYXSfVmyA34ISDbuePenIlrpqVN19ZvdyZEaKzto9
	 A8RlZ34EMTNIQ==
Date: Mon, 15 Sep 2025 17:18:49 -0700
Subject: [PATCHSET RFC v5 3/8] fuse: cleanups ahead of adding fuse support
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: mszeredi@redhat.com, amir73il@gmail.com, bernd@bsbernd.com,
 linux-xfs@vger.kernel.org, John@groves.net, linux-fsdevel@vger.kernel.org,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

In preparation for making fuse use the fs/iomap code for regular file
data IO, fix a few bugs in fuse and apply a couple of tweaks to iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-prep
---
Commits in this patchset:
 * fuse: allow synchronous FUSE_INIT
 * fuse: move the backing file idr and code into a new source file
 * fuse: move the passthrough-specific code back to passthrough.c
 * fuse_trace: move the passthrough-specific code back to passthrough.c
 * fuse: move CREATE_TRACE_POINTS to a separate file
---
 fs/fuse/fuse_dev_i.h      |   13 ++-
 fs/fuse/fuse_i.h          |   73 ++++++++++----
 fs/fuse/fuse_trace.h      |   35 +++++++
 include/uapi/linux/fuse.h |    9 ++
 fs/fuse/Kconfig           |    4 +
 fs/fuse/Makefile          |    4 +
 fs/fuse/backing.c         |  231 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/cuse.c            |    3 -
 fs/fuse/dev.c             |   79 +++++++++++----
 fs/fuse/dev_uring.c       |    4 -
 fs/fuse/inode.c           |   54 ++++++++---
 fs/fuse/passthrough.c     |  198 +++++++--------------------------------
 fs/fuse/trace.c           |   13 +++
 13 files changed, 494 insertions(+), 226 deletions(-)
 create mode 100644 fs/fuse/backing.c
 create mode 100644 fs/fuse/trace.c


