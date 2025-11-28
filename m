Return-Path: <linux-fsdevel+bounces-70150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25034C929DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17A1D4E22B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA0B29B8FE;
	Fri, 28 Nov 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3e6rKzS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C6281358;
	Fri, 28 Nov 2025 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348671; cv=none; b=UrTQRsBYU90L+84dLouwTPvMirIE//qnMfezkIPKvshph+xnbcnLSAVLRqBTR2itCIkeLzn7aJ57wRIH8nqI5kBvmM8olmChxacq9OC4XoNfjJsrj/CwtR52JMXDJw1QrkJknnE4OfutjKmpk9M8h1kfXqjt9wo/zCiGoeGgvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348671; c=relaxed/simple;
	bh=txTRgN8SFm/s4QRtUaiGpLvEmoWt+1c2Aa9tEGyxlE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzgcYPX3QmNwywHynUqlHjvcp56q7JlpJe3L7h+4eiu0+JMiSWi0aWVmzmpnVzd8YoYIxSfOsrbImJGye0JH5m4v8XgeZAT8xQ7iB45/c1LIFnxTLGspVeOTnPAUf4lAYa4sfC5RgbMJcC0RaWc6VUzBg14fQZHrhAwWRoQY3ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3e6rKzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB728C4CEF1;
	Fri, 28 Nov 2025 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348670;
	bh=txTRgN8SFm/s4QRtUaiGpLvEmoWt+1c2Aa9tEGyxlE8=;
	h=From:To:Cc:Subject:Date:From;
	b=T3e6rKzS+CWItB5wirAxjCn8oBjm10fwDXw2wsaSPuM9cO5s3+S8p4IzuRkEWNcEE
	 EE2NRz6dyGBTiwIwM3UJ6Sy6ZOiYIUP9FFhvCWyerGF4fjm5FeigDt1uyCxpt+traT
	 xkWQq54ZGXOfMy/a0rsxLo08UPi0TDEx5s26o3NcugTzo3EhNCF6NlAwAhgqLoHCG0
	 7UIEMfEj4YeLPUtEJFX7A4jjC0hkCLexO8wqgmdkumolRDbPrTQO8Gx29X3WQYf2fq
	 qHeOgPVxlGkhCbTckBOHUhnGo6wiHmRzqRDUEiG3RdPZFVipQfK0uS064smh84nUba
	 0HhvjxV51TUQw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/17 for v6.19] v6.19
Date: Fri, 28 Nov 2025 17:48:11 +0100
Message-ID: <20251128-vfs-v619-77cd88166806@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4569; i=brauner@kernel.org; h=from:subject:message-id; bh=txTRgN8SFm/s4QRtUaiGpLvEmoWt+1c2Aa9tEGyxlE8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnrYnXVwn3aw9BKzCfP9It3dPj1M5upZ0rppgUMt/ w3pW1/zOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS8JHhf5lgyylXvvu31s54 KqLeWGQ9le23xpHDPPe6Z7DrtpvGCTP8z/lhFuHvws4118TwFc+fx/5nUrzes9Y3tyg8n1LFrl/ DDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is the batch of pull requests for the v6.19 merge window!

We have a couple of inter-dependencies between branches. Notably the
cred guard work and the directory locking work are a prerequisite for
the overlayfs work for this cycle.

We also have an external dependency on the kbuild tree's work to enable
-fms-extension. So pulling the vfs work before the kbuild work will
bring that in. Which is fine. I'm just making sure you're aware of it.

This cycle was quite busy with a lot of infrastructure work and cleanups.

There is the new listns() system call that allows userspace to iterate
through namespaces in the system. Currently there's no direct way to
enumerate namespaces - applications must scan /proc/<pid>/ns/ across all
processes, which is inefficient, incomplete (misses namespaces kept
alive only by file descriptors or bind mounts), and requires broad /proc
access. The new system call supports pagination, filtering by namespace
type, and filtering by owning user namespace.

To support listns() and future namespace work, we've introduced an
active reference count that tracks namespace visibility to userspace. A
namespace is visible when it's in use by a task, persisted through a VFS
object, or is the parent of child namespaces. This prevents resurrection
of namespaces that are pinned only for internal kernel reasons.

There's the credential guard infrastructure change for this cycle that
you triggered. :) We now have with_kernel_creds() and
scoped_with_kernel_creds() guards that allow using kernel credentials
without allocating and copying them. We also have scoped_with_creds()
for the common override_creds()/revert_creds() pattern, and prepare
credential guards for more complex cases. All of overlayfs has been
converted to use these guards.

The inode state accessor work from last cycle continues. We now hide
inode->i_state behind accessors entirely, making plain access fail to
compile. This allows asserting correct usage - locking, flag
manipulation, detecting when code clears already-missing flags or sets
flags when illegal.

Directory operations are getting centralized locking helpers as part of
NeilBrown's effort to eventually allow multiple concurrent operations in
a directory by locking target dentries rather than whole parent
directories.

We now also have recall-only directory delegations for knfsd.

The iomap work includes FUSE support for buffered reads using iomap,
enabling granular uptodate tracking with large folios. There's also zero
range folio batch support to handle dirty folios over unwritten
mappings, and DIO write completions can now run from interrupt context
again for pure overwrites, reducing context switches for
high-performance workloads.

The FD_ADD() and FD_PREPARE() primitives simplify the ubiquitous pattern
of get_unused_fd_flags() + create file + fd_install() that currently
requires cumbersome cleanup paths. The series removes roughly double the
code it adds by eliminating convoluted cleanup logic across many
subsystems. This work came late in the cycle but is quite nice - an
alternative pull request with only trivial filesystem conversions is
available if preferred. The KVM conversions were reverted as they prefer
to take those through their tree.

Note that I provided two pull requests for FD_{ADD,PREPARE}():

(1) [GIT PULL 16/17 for v6.19] vfs fd prepare
    Message-Id: <20251128-vfs-fd-prepare-v619-e23be0b7a0c5@brauner>
    contains everything I sent out and a few later fixes and with a
    revert of the kvm conversions. The kvm maintainers want to take it
    to their tree apparently.

(2) [GIT PULL 17/17 for v6.19] vfs fd prepare minimal
    Message-Id: <20251128-vfs-fd-prepare-minimal-v619-41df48e056e7@brauner>
    contains a condensed version with anything that's complex removed.

I think (1) is fine but I understand wanting to be a bit more
conservative so I also provided (2).

There's the usual collection of cleanups: writeback interface
simplification removing low-level filemap_* interfaces, path lookup
optimizations with cheaper MAY_EXEC handling, step_into()/walk_component()
inlining, and the start of splitting up the monolithic fs.h header into
focused headers for superblock code.

Smaller items include folio_next_pos() helper fixing a 32-bit ocfs2 bug,
minix filesystem syzbot fixes, autofs fix for futile mount triggers in
private mount namespaces, and coredump/pidfd improvements exposing the
coredump signal.

Thanks!
Christian

