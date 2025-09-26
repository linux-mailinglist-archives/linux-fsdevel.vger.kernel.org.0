Return-Path: <linux-fsdevel+bounces-62879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09EBA4179
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE391C0497D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5111E1BD035;
	Fri, 26 Sep 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR9VgGgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2E34BA4D;
	Fri, 26 Sep 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896344; cv=none; b=AMjjZwSbc7t6JBwL4y6DQzqgPfEliRCmM0lAp6k52Nk8EsdUqsOsb4sx2nYYS8NtEM0/U9AZ9vkWK3gM2ImQqVb5xHAUFSB1dsQ4UWyieiwzXmGK7FuEzwcLmyzLRu94cMALmc1tI6dvAxOJgAgjn2Yz149T3o6XTUVltc48YqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896344; c=relaxed/simple;
	bh=n/Im3YAEhZ0ns6j5YoTZc/FyFFGFx/x0pD4YYo08oX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJlaVnUORKgFOjJBlnh/zr5MTajz7ZLDmUwdvAEaIWBVz5/Sr4daBwuYFPIbiz1fHbgvRUduoWex7B+0QwKXg3ryrDjjKRw80OSnNPw8+xcKs2LkCX4ndPE0fb46oQuADHYhKUJ+caUTw10IdIjlF4q8mKpYdZPmXK/TfEEdUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR9VgGgM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2320FC4CEF4;
	Fri, 26 Sep 2025 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896344;
	bh=n/Im3YAEhZ0ns6j5YoTZc/FyFFGFx/x0pD4YYo08oX4=;
	h=From:To:Cc:Subject:Date:From;
	b=MR9VgGgMy0PQYez/PGalaBjbXuYhNjpIWUS16H49KjhRyi/O3fvGPOp1wy2FVmelw
	 ztmyRSbkmJk5+XcqG8NCkx8g2ikHvt2x0IDiFRWP173tVkY5bUJsok9V0A6lfENaLz
	 IbyiFrq7ZLCXfMUYxundKBRt6LTjsxhyeTfZj9jjxDHTRoKWH60+w5QCyAzj5WQy36
	 a5QTKMuiDIGBc1s3dXRLRsStMkVpBw63QZoy5FBMtZfxzNcVvWeN+2BW1DXXpmWOuG
	 IwDHUZkI/q1at+K8Nl6QL512WeNivNInMbqlX2vWeQQtQaAK8vkbmg/wiCrOJB+iEG
	 j4P8Y0/jRtTUA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/12 for v6.18] vfs 6.18
Date: Fri, 26 Sep 2025 16:18:54 +0200
Message-ID: <20250926-vfs-618-e880cf3b910f@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431; i=brauner@kernel.org; h=from:subject:message-id; bh=n/Im3YAEhZ0ns6j5YoTZc/FyFFGFx/x0pD4YYo08oX4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3B+jSdb3IyNU6X/uXF4fF90941RZV9Mw+FvhiY3n oS/M1u1s6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiV+YzMjwNfnK/8FObmsfu p1XJflEm8atO98/ZslLr/EvRmQ8b1vcx/DP6vd/aZd8nv5O8jIxFhWnBPEVaryeuKHbOdDj4m29 yDhsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is the batch of pull requests for the v6.18 merge window!

This was a pretty usual cycle. Not light, not particularly heavy.

There are a few minor filesystem specific changes such as afs and pidfs
but nothing that's really worth mentioning. Same goes for iomap and
rust. There are some changes around clone3() and copy_process() that
lead to some cleanups.

There's some workqueue chagnes that affect all of fs but it's not all
that exciting and we don't have to care once all the cleanup is done and
the semantics for per-cpu and unbounded workqueues are simplified and
clarified.

There's a pretty interesting writeback series by Jan Kara that fixes a
nasty issue causing lockups reported by users when a systemd unit
reading lots of files from a filesystem mounted with the lazytime mount
option exits.

With the lazytime mount option enabled we can be switching many dirty
inodes on cgroup exit to the parent cgroup. The numbers observed in
practice when a systemd slice of a large cron job exits can easily reach
hundreds of thousands or millions.

The overall time complexity of switching all the inodes to the correct
wb is quadratic leading to workers being pegged for hours consuming 100%
of the CPU and switching inodes to the parent wb.

That issue should be gone.

We also have a series that shrinks struct inode by 16 bytes. This is
really something I care about because struct inode in contrast to struct
file and struct dentry both of which are meticulously clean by now (I
mean, it could alwasy be better, but you know...) struct inode is still
a giant dumping ground where everyone is made to pay for features that
only 3 filesystems actually end up using. First step, I've moved fscrpt
and fsverity pointers out of struct inode and into the individual
filesystems that care about this. Hopefully more to come in that area.

There's also some preliminary cleanup related to the inode lifetime
rework that is currently under way leading to less open-coded accesses
to internal inode members and some simplifications for iput_final().

Last but not least there's a bunch of namespace related rework this cycle.
This specifically also addresses a complaint you had a few weeks back
about ns_alloc_inum(). That's now completely gone and so is the
special-casing of the init network namespace initialization.

Initialization, reference counting, and cleanup are now unified and
statically derived from the namespace type allowing the compiler to
catch obvious bugs.

The namespace iterator infrastructure I did for the mount namespace some
time back is now extended and generalized to cover all other namespace
types. As a first step this allows the implemenation of namespace file
handles.

As with pidfs file handles, namespace file handles are exhaustive,
meaning it is not required to actually hold a reference to nsfs to be
able to decode aka open_by_handle_at() a namespace file handle. It has
the same advantage as pidfs file handles have. It's possible to reliably
and for the lifetime of the system refer to a namespace without pinning
any resources and to compare them trivially.

The namespace file handle layout is exposed as uapi and has a stable and
extensible format. The stable format means that userspace may construct
its own namespace file handles without going through name_to_handle_at().

Thanks!
Christian

