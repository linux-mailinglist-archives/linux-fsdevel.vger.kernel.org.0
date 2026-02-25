Return-Path: <linux-fsdevel+bounces-78377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFXYAloEn2mZYgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:16:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB819893D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E12A33010222
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 14:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52535028D;
	Wed, 25 Feb 2026 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URL4RfX6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61E271471;
	Wed, 25 Feb 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029008; cv=none; b=vDK5XeuGXMZAlJw42q5NboYZIK4njbRabpOfkMMvYuZiYCrNiJKyxyEYV9di99Uyui/WUrbsu0WCRmOWjAYyAhJwy260N1bHcj/5OA/WgagaLCsYm1hnicM8nruo0j08FadrmvjgLNKN+pmruTbi6UFlmk8zSacojMbPxrUa1ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029008; c=relaxed/simple;
	bh=MpVg0YfU8QE7l76zxdteib1w5gs5rFfWZGUql+vguaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJjnK05iAZZI+pRMcL8RQyIDqBkl4pB29VZMk/dMfqqo7B1zE8dN9DHtGXKPFksZOII1p2WuDxuwE+jNCyF6pWtBe0E0u2CF38UwMIVhqr+ag6qhOVrjRmm2sGqtcgBkIJSZ/C6oFiqdvy96+jiu9/dUdpBjELd6tTPyHRQ5upU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URL4RfX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF97C116D0;
	Wed, 25 Feb 2026 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029008;
	bh=MpVg0YfU8QE7l76zxdteib1w5gs5rFfWZGUql+vguaY=;
	h=From:To:Cc:Subject:Date:From;
	b=URL4RfX6JwLr1G3gN0rKUpK8xswAYjHxtFr48RpqoH0dAZ2vlqwnRBPTYoioTIIOY
	 kaMnAbth1QLNLZpI6VW8NShbSIyFGgIIrl2mZsTF1mep9u92Mvu6vbLUQU1thQGlsC
	 AO8zvonOMyJX3OZIvkqVw4tdSpFYlpVvAP34ettcreZQ83kZOkG3bMKVd1sCrq0TLC
	 u9NBilo4LvSgvugkjJaxnw8s5a9bf4eGJESbQ6ykonzkitcDJ1oi0MeQgPnyvyjOTZ
	 ErtelyTUfCwvD0S5JBke+vymxWNohCPuxXIuP92LcHZS9B3PmtbJElHJyLcNYdTiLK
	 HtPUhsKsV5Z3A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.0] vfs fixes
Date: Wed, 25 Feb 2026 15:16:23 +0100
Message-ID: <20260225-vfs-fixes-5b96f026f275@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4550; i=brauner@kernel.org; h=from:subject:message-id; bh=MpVg0YfU8QE7l76zxdteib1w5gs5rFfWZGUql+vguaY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOZ7F/u+xgks2HhcfOvv3/jInp2Qd+R9cJtf1v6vWPR P3hZQrb2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR3cmMDKuyTptZu1RFbjIv uHQuzFPB+0bUMRUz2+C+tQtuRfBNuMfIsPTCTI6dpl0Z/W/kl2VuDVm7wlBmt930n+6nDqw79tb RjR8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-78377-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BEB819893D
X-Rspamd-Action: no action

Hey Linus,

/* Summary */

This contains fixes for this cycle:

- Fix an uninitialized variable in file_getattr(). The flags_valid field
  wasn't initialized before calling vfs_fileattr_get(), triggering KMSAN
  uninit-value reports in fuse.

- Fix writeback wakeup and logging timeouts when DETECT_HUNG_TASK is not
  enabled. sysctl_hung_task_timeout_secs is 0 in that case causing
  spurious "waiting for writeback completion for more than 1 seconds"
  warnings.

- Fix a null-ptr-deref in do_statmount() when the mount is internal.

- Add missing kernel-doc description for the @private parameter in
  iomap_readahead().

- Fix mount namespace creation to hold namespace_sem across the mount
  copy in create_new_namespace(). The previous drop-and-reacquire
  pattern was fragile and failed to clean up mount propagation links if
  the real rootfs was a shared or dependent mount.

- Fix /proc mount iteration where m->index wasn't updated when
  m->show() overflows, causing a restart to repeatedly show the same
  mount entry in a rapidly expanding mount table.

- Return EFSCORRUPTED instead of ENOSPC in minix_new_inode() when the
  inode number is out of range.

- Fix unshare(2) when CLONE_NEWNS is set and current->fs isn't shared.
  copy_mnt_ns() received the live fs_struct so if a subsequent namespace
  creation failed the rollback would leave pwd and root pointing to
  detached mounts. Always allocate a new fs_struct when CLONE_NEWNS is
  requested.

- fserror bug fixes:

  - Remove the unused fsnotify_sb_error() helper now that all callers
    have been converted to fserror_report_metadata.

  - Fix a lockdep splat in fserror_report() where igrab() takes
    inode::i_lock which can be held in IRQ context. Replace igrab() with
    a direct i_count bump since filesystems should not report inodes that
    are about to be freed or not yet exposed.

- Handle error pointer in procfs for try_lookup_noperm().

- Fix an integer overflow in ep_loop_check_proc() where recursive calls
  returning INT_MAX would overflow when +1 is added, breaking the
  recursion depth check.

- Fix a misleading break in pidfs.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 770aaedb461a055f79b971d538678942b6607894:

  Merge tag 'bootconfig-v7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2026-02-13 19:33:39 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.0-rc2.fixes

for you to fetch changes up to 4a1ddb0f1c48c2b56f21d8b5200e2e29adf4c1df:

  pidfs: avoid misleading break (2026-02-24 12:09:00 +0100)

----------------------------------------------------------------
vfs-7.0-rc2.fixes

Please consider pulling these changes from the signed vfs-7.0-rc2.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
Al Viro (1):
      unshare: fix unshare_fs() handling

Christian Brauner (4):
      mount: hold namespace_sem across copy in create_new_namespace()
      namespace: fix proc mount iteration
      Merge patch series "fserror: bug fixes"
      pidfs: avoid misleading break

Darrick J. Wong (2):
      fsnotify: drop unused helper
      fserror: fix lockdep complaint when igrabbing inode

Edward Adam Davis (1):
      fs: init flags_valid before calling vfs_fileattr_get

Ethan Tidmore (1):
      proc: Fix pointer error dereference

Hongbo Li (1):
      iomap: Describe @private in iomap_readahead()

Huacai Chen (1):
      writeback: Fix wakeup and logging timeouts for !DETECT_HUNG_TASK

Jann Horn (1):
      eventpoll: Fix integer overflow in ep_loop_check_proc()

Jori Koolstra (1):
      minix: Correct errno in minix_new_inode

Qing Wang (1):
      statmount: Fix the null-ptr-deref in do_statmount()

 fs/eventpoll.c           |   5 +-
 fs/file_attr.c           |   2 +-
 fs/fs-writeback.c        |   9 ++--
 fs/iomap/buffered-io.c   |   1 +
 fs/iomap/ioend.c         |  46 ++++++++++++++++
 fs/minix/bitmap.c        |   2 +-
 fs/namespace.c           | 133 ++++++++++++++++++++++++++---------------------
 fs/pidfs.c               |  10 ++--
 fs/proc/base.c           |   3 ++
 include/linux/fsnotify.h |  13 -----
 kernel/fork.c            |   2 +-
 11 files changed, 139 insertions(+), 87 deletions(-)

