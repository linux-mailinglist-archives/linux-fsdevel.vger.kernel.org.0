Return-Path: <linux-fsdevel+bounces-19267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A378C23D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F39286AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4633B16F26B;
	Fri, 10 May 2024 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmBkzyoU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1716D9A1;
	Fri, 10 May 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341616; cv=none; b=C0IGmNVZ664rcuSDkWTRE+KbRkq28WtoMEGdMuCiEHTDjpQkChod4zTycwoHF+pdwnrs8XBuFos9H5eVpyJpOcvu/Kdh7tM1KBj4VqEEfFdhXaT53DkOAtHFC1Ful3K1bSOe/lCs8xt6vchY9g2+sXcAadJG/vmR7RHH7LERLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341616; c=relaxed/simple;
	bh=GpjrIdP1D3e2xgatfDQZr6SxSEVJUUdd3f0t/ZKLSQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ms6aoj42a4YyIzkUo7hF+1lhUHrnZCd7VQgVZxwQaZusEk5+Q2HnP1If4FdjbkpCxSdzDvhc/YcCRY6HA1m3DKm67oRE+BeUUmdpsdWovvmwOO9aaL1XHxxXU2zZ2Fz6zXtaxz6HoYOrM/VFXez1hFelUiA9aGasVwzulJyO87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmBkzyoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FEDC113CC;
	Fri, 10 May 2024 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715341616;
	bh=GpjrIdP1D3e2xgatfDQZr6SxSEVJUUdd3f0t/ZKLSQE=;
	h=From:To:Cc:Subject:Date:From;
	b=fmBkzyoUcQqXFOuS+sdgGj7+FSpltN9Bd7Fu0s/wEk2FQ3uYKS4KYMlJ4cCJo1q85
	 E1fwYw2kUBlJzSD4Mej3nXQjsg5OBvcTFD87R0D/+M2qIaoVtqKRCoZqvpwpKl0e3S
	 DC83HeUgkkKdT+dULZUx/0heybmQRuiLebBuD+tbYZ9IkzL7LD1OvuxI8FCvbI3JMZ
	 YTXsWE4cyOWHu3WgzCBl9QMgepNzsMP+hzARAdD4DpNbG6cV5za4U99lIDucv+Wdx5
	 0hDl5PoUYIf7otNHYQR7TUdNcN9v+HSS1QVR3grV1HtgU7ER7DWE7stA0KhbSY1C7J
	 ECE/lm8mIeC3w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs mount
Date: Fri, 10 May 2024 13:46:47 +0200
Message-ID: <20240510-vfs-mount-ed8db9c38114@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=brauner@kernel.org; h=from:subject:message-id; bh=GpjrIdP1D3e2xgatfDQZr6SxSEVJUUdd3f0t/ZKLSQE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTZcWq9W1fCY3k+OGc5v2t357cN26eoO4glTPQ5kCWmL GTCqXqlo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCILmxn+ab145pFbEM9Zv+BV /dyIpXkcvz/r6fxj01ObukW8d3JnECPDRJNFqh1bLSo4p96JKNslvuTvzY0z+DIX3j/fcICz1Ti fCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This converts qnx6, minix, debugfs, tracefs, freevxfs, and openpromfs to
the new mount api further reducing the number of filesystems relying on
the legacy mount api.

/* Testing */
clang: Debian clang version 16.0.6 (26)
gcc: (Debian 13.2.0-24)

All patches are based on v6.9-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

[1] linux-next: manual merge of the vfs-brauner tree with Linus' tree
    https://lore.kernel.org/linux-next/20240506095258.05b5deae@canb.auug.org.au

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10.mount

for you to fetch changes up to 7cd7bfe59328741185ef6db3356489c22919e59b:

  minix: convert minix to use the new mount api (2024-03-26 09:04:55 +0100)

Please consider pulling these changes from the signed vfs-6.10.mount tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10.mount

----------------------------------------------------------------
Bill O'Donnell (2):
      qnx6: convert qnx6 to use the new mount api
      minix: convert minix to use the new mount api

David Howells (2):
      vfs: Convert debugfs to use the new mount API
      vfs: Convert tracefs to use the new mount API

Eric Sandeen (2):
      freevxfs: Convert freevxfs to the new mount API.
      openpromfs: finish conversion to the new mount API

 fs/debugfs/inode.c       | 198 ++++++++++++++++++++++-------------------------
 fs/freevxfs/vxfs_super.c |  69 ++++++++++-------
 fs/minix/inode.c         |  48 +++++++-----
 fs/openpromfs/inode.c    |   8 +-
 fs/qnx6/inode.c          | 117 ++++++++++++++++------------
 fs/tracefs/inode.c       | 196 ++++++++++++++++++++++------------------------
 6 files changed, 327 insertions(+), 309 deletions(-)

