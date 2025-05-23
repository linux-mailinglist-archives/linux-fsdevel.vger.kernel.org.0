Return-Path: <linux-fsdevel+bounces-49769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EDCAC22EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A59A542203
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BBF35968;
	Fri, 23 May 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3pJVtM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BBD137E;
	Fri, 23 May 2025 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004117; cv=none; b=OFoydM39SqONIEOQqVOnrx3Ih8ndEQaq9PknFDlNFc+AAUAucoFMN5fsXisUz96p/ArWD58XyuqxHyX4oWVlL3ew3YpTI9CRt65IXSV7lwkt24St3XC+kqKRU/xxy3v7HcY1VdjThCYtiocmalQTUCTZdvVv2Y7nZmnRUqlHgpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004117; c=relaxed/simple;
	bh=kRLeMz1HYfI4gwnhv0LNFYddk/iydJ/jv0OGcCUxDaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBnA/4qI9zm3UJ+ZEbuwyyo+7aAmP/qFCvPOZaOifQ1kcoCCLwiEw6p8Y1ANtba/mEG2CuUSvX2Ic/2ibSps0mvSwTfzmsOSp02KGNQuTLBz5MRAKwPBdrTzyB897XffIWdvQvyTIEmHpM4a+1Us1gv+eHeMVaOCx6i+m9/VafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3pJVtM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E323C4CEE9;
	Fri, 23 May 2025 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004116;
	bh=kRLeMz1HYfI4gwnhv0LNFYddk/iydJ/jv0OGcCUxDaA=;
	h=From:To:Cc:Subject:Date:From;
	b=T3pJVtM3yAk3998WCgVoSynMJli4Bw01rMwdunAaH4qj1BCMZicQG5wfHp9MMKZ3v
	 EHuwa25FCwnWjWazB//3Ot+c8fCpwpDMNKbF5efpOBr+SCPHlvDxNFKB8SB9E4bLhM
	 FmJwYb8ju1wai4t5m1Fa/Zm6T5BiKhh1IbSFPtFvKR4cxdi5Acq4+5QOleHPVzBlud
	 ULRUFRFUYk+O7fSFsaowy64SC7exK1CfuNARTc4F5ViFK/lNhg2E0xn4RLhVGAAxWM
	 faxtSSMa0ZD30zMTIWCa9ZHx6KTEbUnFUGUD4ZTa/+6ly86WAKwKAlshRj+omALR3W
	 r/1nLiGIOedUg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs mount
Date: Fri, 23 May 2025 14:41:15 +0200
Message-ID: <20250523-vfs-mount-419141f78092@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=brauner@kernel.org; h=from:subject:message-id; bh=kRLeMz1HYfI4gwnhv0LNFYddk/iydJ/jv0OGcCUxDaA=; b=kA0DAAoWkcYbwGV43KIByyZiAGgwbQ6iMwtOnNOfIz0ddahcZ+NbVcR+O7a+dp1ECmx6KvEE0 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmgwbQ4ACgkQkcYbwGV43KJTxAEAwb/D IWiTOi/qKRbg9nhR/u6yFbWldGLT/tJJ7b+UJEEA/1vH3RM1ubQLbRIyaZsUZ0wgcPlAIkYZEu9 jPfnyjTUN
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

Unfortunately this had to be rebased as this had patches in it who were
also present in another branch under different hashes. Because I both
merged them and exposed them as one set in -next this didn't get
noticed. The patches here are trivial though.

/* Summary */

This contains minor mount updates for this cycle:

- mnt->mnt_devname can never be NULL so simplify the code handling that case.

- Add a comment about concurrent changes during statmount() and listmount().

- Update the STATMOUNT_SUPPORTED macro.

- Convert mount flags to an enum.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.mount

for you to fetch changes up to 2b3c61b87519ff5d52fd9d6eb2632975f4e18b04:

  statmount: update STATMOUNT_SUPPORTED macro (2025-05-23 14:20:45 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.mount tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.mount

----------------------------------------------------------------
Al Viro (1):
      ->mnt_devname is never NULL

Christian Brauner (1):
      mount: add a comment about concurrent changes with statmount()/listmount()

Dmitry V. Levin (1):
      statmount: update STATMOUNT_SUPPORTED macro

Stephen Brennan (1):
      fs: convert mount flags to enum

 fs/namespace.c        | 43 +++++++++++++++++++------
 fs/proc_namespace.c   | 12 +++----
 include/linux/mount.h | 87 ++++++++++++++++++++++++++-------------------------
 3 files changed, 82 insertions(+), 60 deletions(-)

