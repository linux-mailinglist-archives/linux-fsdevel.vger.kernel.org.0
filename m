Return-Path: <linux-fsdevel+bounces-50932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D32EAD138D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA9188AA5D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Jun 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235819ADBA;
	Sun,  8 Jun 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QKzcpg6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904818E750
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jun 2025 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749403455; cv=none; b=nCGY/x0ChvDOm4ioxVAP8KHFdYFVQDsOP6Al3Yjx/qFvZ5vjowkRM/uSl3RVlqV8JtqUOI6D7aycx0/fh5OQFVUWM+nyJQkO3tvUfVSYZ7lC4pGsQW8g7ztmptYPT0t/SvdlMCP4fbWU66s5aYP+1ZSW85spjXfztcFTf45LFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749403455; c=relaxed/simple;
	bh=70ILYaIdKLzUD5pRFUK8kQH6cJIMf3eTnanny1wHHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kw3m2ZsAjkefADe/kTAhRV6Pps/pi2J+tx2fpbdXl1L6lKE/7jS6hxKhDKcUQT30ypcAe8gdmWaVNvu9/+NNc6VpJ9O14wjHw47h5bYvCAvm9yl4neF3zhM+vlBaaHz9aw98nrZBE2Tyxyuc1RAvwGdbGUOihtOJmw0dw8jAgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QKzcpg6Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=8X5ndpafHydr0i7cnIgooGo/gquP0NgxR/Nqr7zyEE0=; b=QKzcpg6ZsDLAgC1gf4b6/uRPv4
	zwkO0FeGmjlG+pDtGgNLu3k68akJJuGKkwHJjBOe59SgIwLP03LdMNJ+maZLPBwxtlGgjjxqsryNK
	9zSDdQx0ALwnLPl27fPttR+Rn/FrKZOQ01pLbldMba6IGI61ppNsTlF4uB0ClYQy6s5GWLbXKJu5m
	KA1apcNmJLiAVRBsqnwaCnhfxlut2WYRy0+H6CsfaN0T2oe5EnYLpqGY+Xqi6HhCdEHrgWEK1phAW
	GdrOydI+KnZyBV85OXO8rxO3oLrxQKW0foVpb4EgcVpl2XvrKRIEJyN9Fi8OBsqgqrE/jymaVj1cQ
	ZjDY6Eaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOJkf-00000002uAl-2NHF;
	Sun, 08 Jun 2025 17:24:09 +0000
Date: Sun, 8 Jun 2025 18:24:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [git pull] mount fixes
Message-ID: <20250608172409.GA299672@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit a82ba839915926f8713183fd023c6d9357bae26c:

  Merge tag 'pull-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2025-05-30 15:04:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 12f147ddd6de7382dad54812e65f3f08d05809fc:

  do_change_type(): refuse to operate on unmounted/not ours mounts (2025-06-07 01:37:56 -0400)

----------------------------------------------------------------
mount-related bugfixes

this cycle regression (well, bugfix for this cycle bugfix for v6.15-rc1 regression)
	do_move_mount(): split the checks in subtree-of-our-ns and entire-anon cases
	selftests/mount_setattr: adapt detached mount propagation test
v6.15	fs: allow clone_private_mount() for a path on real rootfs
v6.11	fs/fhandle.c: fix a race in call of has_locked_children()
v5.15	fix propagation graph breakage by MOVE_MOUNT_SET_GROUP move_mount(2)
v5.15	clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns
v5.7	path_overmount(): avoid false negatives
v3.12	finish_automount(): don't leak MNT_LOCKED from parent to child
v2.6.15	do_change_type(): refuse to operate on unmounted/not ours mounts

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (7):
      fs/fhandle.c: fix a race in call of has_locked_children()
      path_overmount(): avoid false negatives
      finish_automount(): don't leak MNT_LOCKED from parent to child
      fix propagation graph breakage by MOVE_MOUNT_SET_GROUP move_mount(2)
      do_move_mount(): split the checks in subtree-of-our-ns and entire-anon cases
      clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns
      do_change_type(): refuse to operate on unmounted/not ours mounts

Christian Brauner (1):
      selftests/mount_setattr: adapt detached mount propagation test

KONDO KAZUMA(近藤　和真) (1):
      fs: allow clone_private_mount() for a path on real rootfs

 fs/namespace.c                                     | 113 +++++++++++++--------
 include/linux/mount.h                              |   3 +-
 .../selftests/mount_setattr/mount_setattr_test.c   |  17 +---
 3 files changed, 74 insertions(+), 59 deletions(-)

