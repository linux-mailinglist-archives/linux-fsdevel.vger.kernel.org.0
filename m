Return-Path: <linux-fsdevel+bounces-13988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A987619B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B952A1C21BFD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018254BCB;
	Fri,  8 Mar 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgWe0Td6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96E5380F;
	Fri,  8 Mar 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892649; cv=none; b=ZQWcWm5bP8Nipm7eQAVLjAhomtuxppZuWOkiUDkULX38cTL6nedmx7WV0adaOhS0i5+22u8mVo3DE96pxqiNuIRJ17Cx8sOnWlK0J8lRZpsDu9JyfCSlVOI9o+iZP49R9Oy5N+baBDP2N8/U4OWDmJfyPWWvMCWH4tXWuJpa/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892649; c=relaxed/simple;
	bh=1IxfkLaq7cSmoS4jM4ssep+B6tvqeRrJNySOpjgKp5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ht1x5z8z7Tm1Md4dKmUFRF+QcSpU3Vibx2Kg/cpac3zQkkY0cExMy+bP2icqM+GKDJ06b1Eod8VYh8wlGD9f5UW9nRjU2SGqNMHlx7/ogkBrSbNkUnSGk8NrCwhT8QVLzHru9Eroa998o2w/Kx4bLsG8JrZduksfdef+/KzrRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgWe0Td6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781FEC433F1;
	Fri,  8 Mar 2024 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892648;
	bh=1IxfkLaq7cSmoS4jM4ssep+B6tvqeRrJNySOpjgKp5k=;
	h=From:To:Cc:Subject:Date:From;
	b=NgWe0Td6E/YZSr/8x4zEw3Rp2gJKk4VqzmxljuARcFYnO7QwxW6JDtqBojvANZw8A
	 xgQHz2YZCj9jYzjRI1juB1vySRI1bFQUPqtBD3BI8hkhYkcno1//JmGfx1Rh5W6lGI
	 3OcN+ywxJ7OKXGl2bO1ZUvaEa+wOKTn+NC6PkaVhCyZu0pBtJlc9bv2JB3/x+Y0qty
	 qszsnn/PItGQLrI4AciWzpBWd7RBw9uDcbMa49bpNE/8EGFFLjRW7ZiG4Pof5t4SYB
	 CsyVMS9Chqw1yPL2P1yyAGdg+5WPKgfZ4huayjRlQPqWF7ik69CwACEh+BNLe+xDt3
	 X80jgxNTeFwRA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs ntfs
Date: Fri,  8 Mar 2024 11:10:21 +0100
Message-ID: <20240308-vfs-ntfs-ede727d2a142@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7045; i=brauner@kernel.org; h=from:subject:message-id; bh=1IxfkLaq7cSmoS4jM4ssep+B6tvqeRrJNySOpjgKp5k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+eiJ19uX1CyELz76I/LUqaN0tBQbfibXPn4WyuWmo9 Qd4Wj8/1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLXGMDFOyCxziSua/2xrv OMVb7IxUiE2Vr+W+ixbRKbWCjdknnBkZ3p25fPb516p3PXOa/3zsOx/Dy9YUYzbtw/wfvAs8V3q ZsQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This removes the old ntfs driver. The new ntfs3 driver is a full
replacement that was merged over two years ago. We've went through
various userspace and either they use ntfs3 or they use the fuse version
of ntfs and thus build neither ntfs nor ntfs3. I think that's a clear
sign that we should risk removing the legacy ntfs driver.

Quoting from Arch Linux and Debian:

* Debian does neither build the legacy ntfs nor the new ntfs3:

  "Not currently built with Debian's kernel packages, "ntfs" has been
  symlinked to "ntfs-3g" as it relates to fstab and mount commands.

  Debian kernels are built without support of the ntfs3 driver developed
  by Paragon Software."
  (cf. [2])

* Archlinux provides ntfs3 as their default since 5.15:

  "All officially supported kernels with versions 5.15 or newer are
  built with CONFIG_NTFS3_FS=m and thus support it. Before 5.15, NTFS
  read and write support is provided by the NTFS-3G FUSE file system."
  (cf. [1]).

It's unmaintained apart from various odd fixes as well. Worst case we
have to reintroduce it if someone really has a valid dependency on it.
But it's worth trying to see whether we can remove it.

Link: https://wiki.archlinux.org/title/NTFS [1]
Link: https://wiki.debian.org/NTFS [2]

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
At the time of creating this PR no merge conflicts were reported from
linux-next and no merge conflicts showed up doing a test-merge with
current mainline.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.ntfs

for you to fetch changes up to 06b8db3a7dde43cc7c412517c93c85d13a4557f8:

  fs: remove NTFS classic from docum. index (2024-01-24 12:11:48 +0100)

Please consider pulling these changes from the signed vfs-6.9.ntfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.ntfs

----------------------------------------------------------------
Matthew Wilcox (Oracle) (1):
      fs: Remove NTFS classic

Randy Dunlap (1):
      fs: remove NTFS classic from docum. index

 CREDITS                             |    5 +
 Documentation/filesystems/index.rst |    1 -
 Documentation/filesystems/ntfs.rst  |  466 -----
 MAINTAINERS                         |   10 -
 fs/Kconfig                          |    1 -
 fs/Makefile                         |    1 -
 fs/ntfs/Kconfig                     |   81 -
 fs/ntfs/Makefile                    |   15 -
 fs/ntfs/aops.c                      | 1744 -------------------
 fs/ntfs/aops.h                      |   88 -
 fs/ntfs/attrib.c                    | 2624 ----------------------------
 fs/ntfs/attrib.h                    |  102 --
 fs/ntfs/bitmap.c                    |  179 --
 fs/ntfs/bitmap.h                    |  104 --
 fs/ntfs/collate.c                   |  110 --
 fs/ntfs/collate.h                   |   36 -
 fs/ntfs/compress.c                  |  950 -----------
 fs/ntfs/debug.c                     |  159 --
 fs/ntfs/debug.h                     |   57 -
 fs/ntfs/dir.c                       | 1540 -----------------
 fs/ntfs/dir.h                       |   34 -
 fs/ntfs/endian.h                    |   79 -
 fs/ntfs/file.c                      | 1997 ----------------------
 fs/ntfs/index.c                     |  440 -----
 fs/ntfs/index.h                     |  134 --
 fs/ntfs/inode.c                     | 3102 ---------------------------------
 fs/ntfs/inode.h                     |  310 ----
 fs/ntfs/layout.h                    | 2421 --------------------------
 fs/ntfs/lcnalloc.c                  | 1000 -----------
 fs/ntfs/lcnalloc.h                  |  131 --
 fs/ntfs/logfile.c                   |  849 ----------
 fs/ntfs/logfile.h                   |  295 ----
 fs/ntfs/malloc.h                    |   77 -
 fs/ntfs/mft.c                       | 2907 -------------------------------
 fs/ntfs/mft.h                       |  110 --
 fs/ntfs/mst.c                       |  189 ---
 fs/ntfs/namei.c                     |  392 -----
 fs/ntfs/ntfs.h                      |  150 --
 fs/ntfs/quota.c                     |  103 --
 fs/ntfs/quota.h                     |   21 -
 fs/ntfs/runlist.c                   | 1893 ---------------------
 fs/ntfs/runlist.h                   |   88 -
 fs/ntfs/super.c                     | 3202 -----------------------------------
 fs/ntfs/sysctl.c                    |   58 -
 fs/ntfs/sysctl.h                    |   27 -
 fs/ntfs/time.h                      |   89 -
 fs/ntfs/types.h                     |   55 -
 fs/ntfs/unistr.c                    |  384 -----
 fs/ntfs/upcase.c                    |   73 -
 fs/ntfs/usnjrnl.c                   |   70 -
 fs/ntfs/usnjrnl.h                   |  191 ---
 fs/ntfs/volume.h                    |  164 --
 52 files changed, 5 insertions(+), 29303 deletions(-)
 delete mode 100644 Documentation/filesystems/ntfs.rst
 delete mode 100644 fs/ntfs/Kconfig
 delete mode 100644 fs/ntfs/Makefile
 delete mode 100644 fs/ntfs/aops.c
 delete mode 100644 fs/ntfs/aops.h
 delete mode 100644 fs/ntfs/attrib.c
 delete mode 100644 fs/ntfs/attrib.h
 delete mode 100644 fs/ntfs/bitmap.c
 delete mode 100644 fs/ntfs/bitmap.h
 delete mode 100644 fs/ntfs/collate.c
 delete mode 100644 fs/ntfs/collate.h
 delete mode 100644 fs/ntfs/compress.c
 delete mode 100644 fs/ntfs/debug.c
 delete mode 100644 fs/ntfs/debug.h
 delete mode 100644 fs/ntfs/dir.c
 delete mode 100644 fs/ntfs/dir.h
 delete mode 100644 fs/ntfs/endian.h
 delete mode 100644 fs/ntfs/file.c
 delete mode 100644 fs/ntfs/index.c
 delete mode 100644 fs/ntfs/index.h
 delete mode 100644 fs/ntfs/inode.c
 delete mode 100644 fs/ntfs/inode.h
 delete mode 100644 fs/ntfs/layout.h
 delete mode 100644 fs/ntfs/lcnalloc.c
 delete mode 100644 fs/ntfs/lcnalloc.h
 delete mode 100644 fs/ntfs/logfile.c
 delete mode 100644 fs/ntfs/logfile.h
 delete mode 100644 fs/ntfs/malloc.h
 delete mode 100644 fs/ntfs/mft.c
 delete mode 100644 fs/ntfs/mft.h
 delete mode 100644 fs/ntfs/mst.c
 delete mode 100644 fs/ntfs/namei.c
 delete mode 100644 fs/ntfs/ntfs.h
 delete mode 100644 fs/ntfs/quota.c
 delete mode 100644 fs/ntfs/quota.h
 delete mode 100644 fs/ntfs/runlist.c
 delete mode 100644 fs/ntfs/runlist.h
 delete mode 100644 fs/ntfs/super.c
 delete mode 100644 fs/ntfs/sysctl.c
 delete mode 100644 fs/ntfs/sysctl.h
 delete mode 100644 fs/ntfs/time.h
 delete mode 100644 fs/ntfs/types.h
 delete mode 100644 fs/ntfs/unistr.c
 delete mode 100644 fs/ntfs/upcase.c
 delete mode 100644 fs/ntfs/usnjrnl.c
 delete mode 100644 fs/ntfs/usnjrnl.h
 delete mode 100644 fs/ntfs/volume.h

