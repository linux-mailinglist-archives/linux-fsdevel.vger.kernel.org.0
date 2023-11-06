Return-Path: <linux-fsdevel+bounces-2041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0767E1A7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 07:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356C228130D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C87E8F63;
	Mon,  6 Nov 2023 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auSbn6bq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5CA642
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 06:50:55 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8985F2;
	Sun,  5 Nov 2023 22:50:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f78dcf036so3030128f8f.0;
        Sun, 05 Nov 2023 22:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699253452; x=1699858252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbqQdpAVIW9N67UKj8YDab5KVvVGkqnhm/9Uw2oo0UQ=;
        b=auSbn6bqsFQr4gL+AJoMtZ1R8E7C9VL+LY3TiOqo+VehnA6TCpvuRnVURAarNiu1XJ
         S8RraXAoqFYz4kdeeuy4tJD8IbxeX+2YbzVLLpV/PraZ7LcFwGojv/qA5ArBdpAzPO5m
         TkTznnYlyfvYDHINvRzz4WzSCM48tjnrBdJSjeRwDvbFRzZjAkh1rPpdLOU+kPLXaU2t
         3qlNS9oFSBCOFsnj0YJPO6ySeWMu62nK1uqmZuVk+R2dPTCPe+iIx+fx7XhUhx5Rg2RN
         j6V4I+IefHS19maF592oU87hRa++SbPyRw4egUPf15XyjavzVlFEhiwHa0h/VFrmls1f
         JGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699253452; x=1699858252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbqQdpAVIW9N67UKj8YDab5KVvVGkqnhm/9Uw2oo0UQ=;
        b=qkJSF8V7pop6NB5bIPt1hjPaq18ClqJWT0EHVNr+GFO8fctFFnJXxRYYVV/O148MSd
         woU52syhdgSoZh+7GMiDOvjHVcACfjiAVFG+rGfgPZzp8FsomoGyl70mYCLnx0vXVxcd
         ayiYGVblwuPtxamVvpTbCj7gccA2Go3sYyGnRA437qKjVqxC3ZxM+c39Bmh7y2xavFYX
         sQ9Mwy0fb8Y3XjsrB9l2G0Z7Is0gUel0JCDHd9R3I4E7OQ6HMNGJ2/qfGzkS45EOSKSZ
         U/04Bx1dMBaRVApYUTFArpeVXou5ArpfplE5OT7wKEHkwiw4sqaMB5elaE7FJps6JwKf
         xBBQ==
X-Gm-Message-State: AOJu0YwO9nwdAcH94cmtyoDTtixvE6PYZMfirefaS9BULswBwzWgy+Za
	YGnSWP0azfZT1CZQ9l2f1RLsPK3FORY=
X-Google-Smtp-Source: AGHT+IFziN0N5HWnkm5Tj9LEgU3hA4t796SFyuYWsDbYUOc+n4dyooIrAZsZ78DqWAeALjPl26a6ng==
X-Received: by 2002:a5d:5847:0:b0:32f:88f9:ba44 with SMTP id i7-20020a5d5847000000b0032f88f9ba44mr10049314wrf.25.1699253452090;
        Sun, 05 Nov 2023 22:50:52 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id r22-20020a05600c35d600b003fee567235bsm11132388wmq.1.2023.11.05.22.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 22:50:51 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 6.7
Date: Mon,  6 Nov 2023 08:50:45 +0200
Message-Id: <20231106065045.895874-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs update for 6.7.

Most of the changes in this update have been sitting in linux-next for
several weeks, based on two prerequisite vfs topic branches.
Last week, after the vfs branches were merged, I rebased overlayfs-next
to reduce noise.

Last week, I also added patches for new mount options to replace the
lowerdir append syntax that we disabled in v6.6-rc6 and v6.5.8.

This branch has gone through the usual overlayfs test routines and it
merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 14ab6d425e80674b6a0145f05719b11e82e64824:

  Merge tag 'vfs-6.7.ctime' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs (2023-10-30 09:47:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.7

for you to fetch changes up to 24e16e385f2272b1a9df51337a5c32d28a29c7ad:

  ovl: add support for appending lowerdirs one by one (2023-10-31 00:13:02 +0200)

----------------------------------------------------------------
overlayfs update for 6.7

Contains the following patch sets:

- Overlayfs aio cleanups and fixes [1]

- Overlayfs lock ordering changes [2]

- Add support for nesting overlayfs private xattrs [3]

- Add new mount options for appending lowerdirs [4]

[1] https://lore.kernel.org/r/20230912173653.3317828-1-amir73il@gmail.com/
[2] https://lore.kernel.org/r/20230816152334.924960-1-amir73il@gmail.com/
[3] https://lore.kernel.org/r/cover.1694512044.git.alexl@redhat.com/
[4] https://lore.kernel.org/r/20231030120419.478228-1-amir73il@gmail.com/

----------------------------------------------------------------
Alexander Larsson (4):
      ovl: Add OVL_XATTR_TRUSTED/USER_PREFIX_LEN macros
      ovl: Support escaped overlay.* xattrs
      ovl: Add an alternative type of whiteout
      ovl: Add documentation on nesting of overlayfs mounts

Amir Goldstein (14):
      ovl: use simpler function to convert iocb to rw flags
      ovl: propagate IOCB_APPEND flag on writes to realfile
      ovl: punt write aio completion to workqueue
      ovl: protect copying of realinode attributes to ovl inode
      ovl: add helper ovl_file_modified()
      ovl: split ovl_want_write() into two helpers
      ovl: reorder ovl_want_write() after ovl_inode_lock()
      ovl: do not open/llseek lower file with upper sb_writers held
      ovl: do not encode lower fh with upper sb_writers held
      ovl: Move xattr support to new xattrs.c file
      ovl: remove unused code in lowerdir param parsing
      ovl: store and show the user provided lowerdir mount option
      ovl: refactor layer parsing helpers
      ovl: add support for appending lowerdirs one by one

 Documentation/filesystems/overlayfs.rst |  40 +++-
 fs/overlayfs/Makefile                   |   2 +-
 fs/overlayfs/copy_up.c                  | 142 +++++++++-----
 fs/overlayfs/dir.c                      |  64 +++----
 fs/overlayfs/export.c                   |   7 +-
 fs/overlayfs/file.c                     |  88 ++++++---
 fs/overlayfs/inode.c                    | 165 ++--------------
 fs/overlayfs/namei.c                    |  52 ++++--
 fs/overlayfs/overlayfs.h                |  72 +++++--
 fs/overlayfs/params.c                   | 322 +++++++++++++++++---------------
 fs/overlayfs/params.h                   |   1 +
 fs/overlayfs/readdir.c                  |  27 ++-
 fs/overlayfs/super.c                    |  92 ++-------
 fs/overlayfs/util.c                     | 115 +++++++++++-
 fs/overlayfs/xattrs.c                   | 271 +++++++++++++++++++++++++++
 fs/super.c                              |   1 +
 16 files changed, 929 insertions(+), 532 deletions(-)
 create mode 100644 fs/overlayfs/xattrs.c

