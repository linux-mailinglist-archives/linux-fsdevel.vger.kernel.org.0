Return-Path: <linux-fsdevel+bounces-77272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gt7NewNk2nw1AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:30:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A27F14358F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3615301D32C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94D221A457;
	Mon, 16 Feb 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSLdwbr7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8B19C566;
	Mon, 16 Feb 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771245018; cv=none; b=WnThfsGiFMa7DTo6/BDM6oHW1gHvMJEEI8NOa4BD/NzSMArTOVr0ALYPeSYeCRVaIA1tludsr7Vghz1i8k1wfi6AIUq2aQ/Ct/OFcKDRyHWHvN/UTZGLfnn+TRdBVLTZPRUXGZhqOZzOOLybT8bFiICRAkojphuF+7i8bZyBBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771245018; c=relaxed/simple;
	bh=AuWXSaDFZkr1cNAvZ2UPwfsOM4JyElxUeF7oO+a1km8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAiugcCwOHT35PLIL7ygQk2MuCcpKYhhCg+UwmN0Qtp2bS/GTBcCkZ571jWgSj0Jf0hSWXqPeke+i0pFk6H3v07ndMocMhkJdiHarrWIoFY8WA62kbun+83d+4WZWWIpCSy2vQTYkmuFSFcruxafU3/GKI15la+ktw3g8w9d8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSLdwbr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD65AC116C6;
	Mon, 16 Feb 2026 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771245017;
	bh=AuWXSaDFZkr1cNAvZ2UPwfsOM4JyElxUeF7oO+a1km8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSLdwbr7aPHNJtLqr4vSJfr1xnnQi5asOsewDaZmwZm2YWDFrj2EJYdz0gqyfL5BB
	 FbLEXN8slwxkOwGxl8JXHkLMnkLhr6hn1YDelM5RoRLJWs6Cazt3l/069wj9N6jxWY
	 He+1EMnjPw0vd3cNEwV6UA7N2Ffl/VnLxYBCQuB2SzVPU5fwssbpGNyWe45EOTbL/7
	 c3eqZrKsJXLohzii3d5HiyjNRnJNcUzHocLSbzVMCfYyGzPhvN+brRJSCYTnNfSvkQ
	 vWFDxDwrouha2TIqajLGoT0NtRYA+jxby4/Q9THSeFl314knnwjYpFa1SKDZzShrMw
	 wo8pThRD8e6uA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 13/12 for v7.0] kernel misc
Date: Mon, 16 Feb 2026 13:29:20 +0100
Message-ID: <20260216-kernel-misc-v70-899e4272dc4d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206-vfs-v70-7df0b750d594@brauner>
References: <20260206-vfs-v70-7df0b750d594@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=brauner@kernel.org; h=from:subject:message-id; bh=AuWXSaDFZkr1cNAvZ2UPwfsOM4JyElxUeF7oO+a1km8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRO5l1Usp3D2Wzh/eUX1IVPfE7ck2ZntNglXtb+L/O86 irBGUz7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSf5zhn9qy+zP1fr1c+VH7 9HE3nnjJur2P1KN9/CJWN2ofEbC7fJGRYZ7r1i3MP+d/7w9928Gz6EH83dQL3u8VTvmwCN5hcmf 6wwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-77272-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A27F14358F
X-Rspamd-Action: no action

Hey Linus,

as announced in [1] this is one of pull requests that was delayed.

/* Summary */

- pid: introduce task_ppid_vnr() helper

- Revert "pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers"

- ipc: Add SPDX license id to mqueue.c

- pidfs: convert rb-tree to rhashtable

  Mateusz reported performance penalties during task creation because
  pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
  rhashtable to have separate fine-grained locking and to decouple from
  pidmap_lock moving all heavy manipulations outside of it.

  Also move inode allocation outside of pidmap_lock. With this there's
  nothing happening for pidfs under pidmap_lock.

- pid: reorder fields in pid_namespace to reduce false sharing

Link: https://lore.kernel.org/20260206-vfs-v70-7df0b750d594@brauner [1]
/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 6cbfdf89470ef3c2110f376a507d135e7a7a7378:

  posix_acl: make posix_acl_to_xattr() alloc the buffer (2026-01-16 10:51:12 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.0-rc1.misc

for you to fetch changes up to 3673dd3c7dc1f37baf0448164d323d7c7a44d1da:

  Merge patch series "Revert "pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers"" (2026-02-10 11:39:31 +0100)

----------------------------------------------------------------
kernel-7.0-rc1.misc

Please consider pulling these changes from the signed kernel-7.0-rc1.misc tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (2):
      pidfs: convert rb-tree to rhashtable
      Merge patch series "Revert "pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers""

Mateusz Guzik (2):
      pid: reorder fields in pid_namespace to reduce false sharing
      pidfs: implement ino allocation without the pidmap lock

Oleg Nesterov (2):
      Revert "pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers"
      pid: introduce task_ppid_vnr() helper

Tim Bird (1):
      ipc: Add SPDX license id to mqueue.c

 fs/pidfs.c                    | 174 +++++++++++++++++++++++-------------------
 include/linux/pid.h           |   9 ++-
 include/linux/pid_namespace.h |  14 ++--
 include/linux/pidfs.h         |   3 +-
 ipc/mqueue.c                  |   3 +-
 kernel/pid.c                  |  15 ++--
 6 files changed, 121 insertions(+), 97 deletions(-)

