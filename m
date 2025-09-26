Return-Path: <linux-fsdevel+bounces-62888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC869BA41C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE0E387BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D521CC4F;
	Fri, 26 Sep 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItLANdLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B61C860C;
	Fri, 26 Sep 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896359; cv=none; b=C45F3FjSXkr+DnNFm8Pr/5hhkuf4eoyzAfU9+8r2D0gBo2l9LSjzRitxfFriRC1ZsZ6gSAihM2y0K0Dydfr1jIXq6ArheIuBpN+IbV72dlg74PAtCJ+7cWFo9t7oWE6WGI1xLichK/gXihdUys3ebibLtks2BdpTwEiIGd4z0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896359; c=relaxed/simple;
	bh=1GprW6BZyKsnE+HoKnDuf8fzy+sfbGVArWXSfz+lKhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmmkGw9Yo+bjWjgSQtxDuTBeNefhUF03xTF4sNMdTkIyq2Px5t0g5054bDmz1zBYGXheq8AUiHlKJc5BkSkDQ6WBtUzYxgu8aC4o4fg1hUvip/mJoEZnTZaFAfNOi19c7SRBQp4oJHh4jvWf3RFvYBbIqu7rmu1U70b0kRQwnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItLANdLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D536BC113D0;
	Fri, 26 Sep 2025 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896357;
	bh=1GprW6BZyKsnE+HoKnDuf8fzy+sfbGVArWXSfz+lKhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItLANdLABT1c4Y8mrpRROupabaP/bkZ5u8B08YenxdFVR3hVGab2bXk9d4m44E0uw
	 ovh1Ce3Ltp4wKcL2/EE8gcYUWQM/LP2lZACqQ0OQcHNSFWFagmc39Uar8aT2Llb/JK
	 DCSjFlpWv1mtV1fgKlgGWu+7JI2WjuIYxPPFOt8iUpx9/AZSjJkZHpo0zVQwpao7Oz
	 b8sdx03n8RPY6grrur/8xG6mKShKFVMo0kGr8wyaz8q4KDgmbJXx7ycTcdqld/qNfr
	 I7VUgm/R4lOdFt4jL/D5eH0lCeJBfhTEbWrgQ6Od3E1S4tCXsAOux8sbWLr0qRTvSf
	 WYTRmHI5huJRQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 9/12 for v6.18] afs
Date: Fri, 26 Sep 2025 16:19:03 +0200
Message-ID: <20250926-vfs-afs-633c36e4c55f@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926-vfs-618-e880cf3b910f@brauner>
References: <20250926-vfs-618-e880cf3b910f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=brauner@kernel.org; h=from:subject:message-id; bh=1GprW6BZyKsnE+HoKnDuf8fzy+sfbGVArWXSfz+lKhE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcW3ChJeTv22+KHY2ltYs/FG7hfzHv80yRWO77UUfV/ whOvX0rpqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAirZKMDP9uf5hT4304TvLi RvYmB7fbMyJm9+bUMt7jU16R2NLS8YKR4Vraj5NH8t92PGv+XKE9USz70g/GsL5DNYYak47YnX2 0mAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the change to enable afs to support RENAME_NOREPLACE and
RENAME_EXCHANGE if the server supports it.

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

No known conflicts.

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc1.afs

for you to fetch changes up to a19239ba14525c26ad097d59fd52cd9198b5bcdb:

  afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE (2025-09-25 09:19:07 +0200)

Please consider pulling these changes from the signed vfs-6.18-rc1.afs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc1.afs

----------------------------------------------------------------
David Howells (1):
      afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE

 fs/afs/dir.c               | 223 +++++++++++++++++++++++++++++++---------
 fs/afs/dir_edit.c          |  18 ++--
 fs/afs/dir_silly.c         |  11 ++
 fs/afs/internal.h          |  15 ++-
 fs/afs/misc.c              |   1 +
 fs/afs/protocol_yfs.h      |   3 +
 fs/afs/rotate.c            |  17 +++-
 fs/afs/yfsclient.c         | 249 +++++++++++++++++++++++++++++++++++++++++++++
 fs/dcache.c                |   1 +
 include/trace/events/afs.h |   6 ++
 10 files changed, 480 insertions(+), 64 deletions(-)

