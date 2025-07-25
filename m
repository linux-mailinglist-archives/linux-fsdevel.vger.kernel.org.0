Return-Path: <linux-fsdevel+bounces-56018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C2B11D7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F64CAE3521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493932E7653;
	Fri, 25 Jul 2025 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZFE+HYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C002E7180;
	Fri, 25 Jul 2025 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442848; cv=none; b=iGvSM56qeX8Q9T6dVQyBZMcgXg2px8RxNra83Q3Wwx1ErDTWQmmdSqCAsu0JVTIq4+CUH+4ytE2FJ4hk4XnAqFQw4EBFrDOrXMWUInl1eNZv4XR/92E6eBgZ+/qsKPdGUWKFVSgiEkf/SB2uWRGXIWVuns94w29HFG20eGVZaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442848; c=relaxed/simple;
	bh=+XiY2kBKMKUpEQJFYn7FsO6Pn6RjwoyNmiPYMcid32k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTtxEyJZskHM09Z36fs+KCX4Fkgtc/SthI2PPaLMA2lF3hgLGOr7kNUT/wMf+Hmu2xu5nz8JA5lsi7OD5dza6GCVohXGZtOqZysPUNWB/3fbweBbFkApwkK/EfdJ65ISqjpQZY48fL8vd8t4fF0lcIwU98BxcClB2ujLHegrbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZFE+HYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D44C4CEE7;
	Fri, 25 Jul 2025 11:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442848;
	bh=+XiY2kBKMKUpEQJFYn7FsO6Pn6RjwoyNmiPYMcid32k=;
	h=From:To:Cc:Subject:Date:From;
	b=UZFE+HYSPqX4KxFp6Ne4bPDrYjgTjcYL41nKLTLop2LwMoUeXv+cjvaWW4AcOJRD4
	 2rnnwBB9m1h0ztGneuVUCTnWAdnZ3c6MjILfowpssmbpODyJ280P9nTJYgpVgcNE03
	 aZxjWKBt/sg/VoERjD7OLb7Pi0YfvGfCOuy7XjMDwXJmTtO9hwCFOIlvTkfAR4J2Jq
	 7BgdZcrHmQF2pSBQmMMIl8PlutUoFTPNIsscO37p5pyb0SDBaJnZ+uhnneFquN2P/c
	 IJ6wlEpgXwzarT6IKvKDSZO3PBEfI71rewys2wd6xugcbEAXpwFhyPLnRh/l2UJP5t
	 gVAqgYPmUYyxg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/14 for v6.17] vfs 6.17
Date: Fri, 25 Jul 2025 13:27:13 +0200
Message-ID: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3716; i=brauner@kernel.org; h=from:subject:message-id; bh=+XiY2kBKMKUpEQJFYn7FsO6Pn6RjwoyNmiPYMcid32k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4mYMO0+e+3ix73WrFVWJ9s0zhmdSj4uLRi5hC3vT Zcx68kjHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJ9mb478Ij0psVNDv8O6+B xmxHhpgk+YevDn26VMPQuu+QXIEeH8P/OJ7ivNUmQT8XnH5uxsBh+vxEgtr8gIsqtlM3piavl/r DAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is the batch of pull requests for the v6.17 merge window!

I'm trying something new where I'm attaching a cover letter with a short
summary of all the various pull requests flowing to you during this
cycle.

Lucky for me the v6.17 merge window coincides with me moving. IOW, I'm
currently getting squashed by moving boxes and disassembled furniture.
I'm just happy that I did find my laptop in this mess and I hope there's
no notable effects due to the last couple of weeks.

In any case, this cycle was pretty usual for us given the past years.
We have two new system call additions in core vfs file_getattr() and
file_setattr() which are exensible successors to the legacy ioctl()s.

There's further work in the form of preparatory changes to the directory
locking scheme we currently have; both on the vfs level and for
overlayfs specificall. I want to stress that no actual locking changes
have happened yet and that there's not yet any commitment by us to
actually land any of this.

We have a new bpf kfunc extension for reading extended attributes from
cgroups. This is the first time we're routing bpf patches but I will do
this for all future vfs bpf extensions so we know exactly how and when
something is happening.

There's another round of extensive coredump work. Not just an extension
to the coredump socket but also a rework of the coredump code to just be
more readable and maintainable. I'm somewhat afraid of what I've gotten
myself into by touching that code but hey, that's part of the deal.

We have some work at the intersection of the block and vfs layer in the
form of the new FS_IOC_GETLBMD_CAP ioctl() which returns information
about the files integrity profile for userspace applications that need
to understand a files end-to-end data protection support and configure
the I/O accordingly.

Iomap has been quite active as well with some refactoring and changes to
the infrastucture to extend the abilities of fuse and support large
folios. Hell, if this keeps going on every filesystem will move to fuse
and we'll all be out of a job soon.

There's the usual pile of miscellaneous changes to the vfs layer and
filesystems. No need to cover this in detail here.

We also have some work at the intersection of mm and the vfs by porting
a good chunk of filesystems from f_op->mmap() to the new and better
f_op->mmap_prepare(). I'm going to haunt the relevant developers to
finish this conversion asap because I have no appetite of running around
with yet more duplicated methods than we already have. I mean, we've
just gotten rid of f_op->readdir() last year or so - actually you did.

I'm also routing the usual namespace work. This time in the form of some
minor nsfs extensions by exposing a bunch of uapi symbols that a lot of
userspace already relies on and so we can't change those constants
anyway. That's the root inode number of procfs and the inode numbers of
the initial set of namespaces.

We've also been very active in pidfs which gains a bunch of new features
such as persisent exit and coredump information, extended attributes,
autonomous file handles, and pidfd for reaped task from SCM_PDIFD
messages.

A few minor Rust updates are also in there but they're really not that
interesting at all.

And at last a new struct super_operations method that allows
multi-device filesystems such as btrfs to be informed when a block
device is removed. Since btrfs can survive surprise device removal this
complements the usual ->shutdown() call nicely.

That's all! Expect some slight delay in responses as I'm going to be
preoccupied with the move over the weekend.

Thanks!
Christian

