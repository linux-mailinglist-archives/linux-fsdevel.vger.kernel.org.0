Return-Path: <linux-fsdevel+bounces-39588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA1A15D25
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0D118854E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76A18DF73;
	Sat, 18 Jan 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYm7NtN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE4A95C;
	Sat, 18 Jan 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205856; cv=none; b=SiQv09n99rSOLZG3BbAF8BI/r1ZoPXQw/02yAJ9g54nwIsuKsZdnai6aC8m3VVGQyRW9gr8KtyHbQPqW6a5KAP/PP+ykxAPYZ47uWJyHTK/2fwrP+26HgfP3Y9M6g9VTbtIGGRgwcXrMMiaC/7W/O8oTTtTr9p9gbUGqylXU0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205856; c=relaxed/simple;
	bh=0OHuIAWrmhCJGmbuBDTtxykzcos5ai1C4yFsexvDxUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lm+VDBhkOlWntIYsFeNX2ciUWE5RPNoUIH1Uy+KaVGh+TjPRweKf+OlYB6BHxc7Lq+JY8PEbrIjulNj4cp6dilQJwX4PjP1kf5Ct/RRV1PsvfjMKmTR4Ul1a71w856Cup2256wXpNnr6HYsAolqgln2hB4iDOvOB8cdY9bafMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYm7NtN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D42C4CED1;
	Sat, 18 Jan 2025 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205855;
	bh=0OHuIAWrmhCJGmbuBDTtxykzcos5ai1C4yFsexvDxUA=;
	h=From:To:Cc:Subject:Date:From;
	b=RYm7NtN6T/Gx8oXeJ3hfbzjROUSVZMWflYrzvbG+wpfPlg8LKcAWrm6H4B4WAYS4T
	 581MW/VtsNReMdeFqzXPWTYR2XV5gNhtaglruv65vDBjy/I42YQY3swsPOzi88sdl/
	 oqH1DDkSJ8x/q/Jzap7XdzirGgQaHqWuXiQeWanFORFEhdU1O+jNGLuAo6NyRSQvCD
	 MFfofM9okbvft8FIqz6CdXQ6fq0Y74apc69FB19oc2gIFwQGXszpHX3wkYzmC5VA0l
	 AfOCyHvcqjFeaqfHfd4I6GDHKWfy2oGAUFi6vIwG2MqJQ3snXUG4lybGUwFETAP7rY
	 I7K48cEcIpOEQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] afs
Date: Sat, 18 Jan 2025 14:10:47 +0100
Message-ID: <20250118-vfs-afs-c73684b81023@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=brauner@kernel.org; h=from:subject:message-id; bh=0OHuIAWrmhCJGmbuBDTtxykzcos5ai1C4yFsexvDxUA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3r4gw9dTOzd+h/z70+oX1617ruEwUqxJMEMj/Z3Tug xfjnJi/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5x83wv+6ghtaaVZbput1H ds/ht1ycuD/utdiisqfilelb7LRMqxkZXk8Jevf/gN1M48vBMy0+ucSpn3jJs5PjnYfGlNBvHwI TWQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains afs updates for this cycle:

Features:

- dynamic root improvements:

  - Create an /afs/.<cell> mountpoint to match the /afs/<cell>
    mountpoint when a cell is created.

  - Add some more checks on cell names proposed by the user to prevent
    dodgy symlink bodies from being created.  Also prevent rootcell from
    being altered once set to simplify the locking.

  - Change the handling of /afs/@cell from being a dentry name
    substitution at lookup time to making it a symlink to the current
    cell name and also provide a /afs/.@cell symlink to point to the
    dotted cell mountpoint.

Fixes:

- Fix the abort code check in the fallback handling for the
  YFS.RemoveFile2 RPC call.

- Use call->op->server() for oridnary filesystem RPC calls that have an
  operation descriptor instead of call->server()

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.afs

for you to fetch changes up to e30458d690f35abb01de8b3cbc09285deb725d00:

  afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call (2025-01-15 11:47:22 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.afs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.afs

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "afs: Dynamic root improvements"

David Howells (4):
      afs: Make /afs/.<cell> as well as /afs/<cell> mountpoints
      afs: Add rootcell checks
      afs: Make /afs/@cell and /afs/.@cell symlinks
      afs: Fix the fallback handling for the YFS.RemoveFile2 RPC call

 fs/afs/cell.c              |  21 ++++-
 fs/afs/dynroot.c           | 227 ++++++++++++++++++++++++++++++++-------------
 fs/afs/proc.c              |   8 +-
 fs/afs/yfsclient.c         |   5 +-
 include/trace/events/afs.h |   2 +
 5 files changed, 189 insertions(+), 74 deletions(-)

