Return-Path: <linux-fsdevel+bounces-70165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E653C92A97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8D03AE9F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BC2F90C5;
	Fri, 28 Nov 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0iY7pMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA22F6933;
	Fri, 28 Nov 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348695; cv=none; b=iYcstQ+gGLlI1DZydu/80lXqPVCCCaEyz1R13ihznKvUbq0+IMOQ7MUca3gzUoRkktbNJZVc1QGaPB2nTM5p7wznEum3jU2pkZ71QEonnw3mG/zhrxQzMA4QJnpvsRjoXTU4BPPBM1reUJEmEZ50boyjeY48CZDE2dERfLgrNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348695; c=relaxed/simple;
	bh=uwe/hCaXH67Z4f1ToOALVomXb6tD4uNby2Es7SDaizw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaxKKMweONxFBlfXFDmZqpYtXv/q9EqEng344JNK+EI9E/xXKSxGGtexyBxuxbXij0TazPMTdLGOC4ddKOd4PcLWZ8hajoe7lHm5HuUkAOYDp7mx1tCOuF1K7vNNu/GTTDDmEMMpMR/di23kXHLF5DInjw3WyxO4d6EgT45RhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0iY7pMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41238C2BCB2;
	Fri, 28 Nov 2025 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348694;
	bh=uwe/hCaXH67Z4f1ToOALVomXb6tD4uNby2Es7SDaizw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0iY7pMpL6s+SCkZBhjAPuCQ0jtVY/EFDUJLm6Z0Uiknk+NA327H1EOQsK60KAqV7
	 I+/Hzwocuux0yPip2k48pmhsMfbPJr8o6+AG5Woe+Pty+LbyoEkbVjEk7u6e5Ca/r0
	 6ov/jDsLkd5W3NIqwJiBWrnXpmeAHpR1uwKSE3cLewKuvgAt8N3p8luUqXB/oNbmuS
	 vrgOF7GS2Lg+XhKAi/2AyvWcB8dA6bTBkjCy4lYNM1/xYC6zvgvUcSk3p8Z+LWdpR3
	 PUmFTdG9HsW2dnCIcoWmhBQhllDS4+fs1AkHfqWwvQMg3I/YVTxcu+JsykLSPBMal0
	 ovZ7AvwoK8EPg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 15/17 for v6.19] autofs
Date: Fri, 28 Nov 2025 17:48:26 +0100
Message-ID: <20251128-vfs-autofs-v619-9dc04a44c420@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1986; i=brauner@kernel.org; h=from:subject:message-id; bh=uwe/hCaXH67Z4f1ToOALVomXb6tD4uNby2Es7SDaizw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnrCeUCy8Dz/EZnLLzmThS0cxRdwpjD/zIg+su2ig qPNg5tJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRd2VkWJN0UfBy2RuBp9P6 9msa3p34KeMqP1vl0zWL2Qplb4qd1WL4Z/5//ub4x+F/eoSfPuTc6fk10fu4QabW25UyVS8Dl4r NZwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Prevent Futile Mount Triggers in Private Mount Namespaces

Fix a problematic loop in autofs when a mount namespace contains autofs
mounts that are propagation private and there is no namespace-specific
automount daemon to handle possible automounting.

Previously, attempted path resolution would loop until MAXSYMLINKS was
reached before failing, causing significant noise in the log.

The fix adds a check in autofs ->d_automount() so that the VFS can
immediately return EPERM in this case. Since the mount is propagation
private, EPERM is the most appropriate error code.

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

[1]: https://lore.kernel.org/linux-next/20251121153059.48e3d2fa@canb.auug.org.au

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.autofs

for you to fetch changes up to 922a6f34c1756d2b0c35d9b2d915b8af19e85965:

  autofs: dont trigger mount if it cant succeed (2025-11-19 11:14:02 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.autofs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.autofs

----------------------------------------------------------------
Ian Kent (1):
      autofs: dont trigger mount if it cant succeed

 fs/autofs/autofs_i.h  | 5 +++++
 fs/autofs/dev-ioctl.c | 1 +
 fs/autofs/inode.c     | 1 +
 fs/autofs/root.c      | 8 ++++++++
 fs/namespace.c        | 6 ++++++
 include/linux/fs.h    | 1 +
 6 files changed, 22 insertions(+)

