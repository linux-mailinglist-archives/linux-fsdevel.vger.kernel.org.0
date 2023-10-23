Return-Path: <linux-fsdevel+bounces-946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF5E7D3E94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 20:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F52B20E82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF242135C;
	Mon, 23 Oct 2023 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETrjQdsp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07021340
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:08:11 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E6B7;
	Mon, 23 Oct 2023 11:08:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859c46447so16136145e9.1;
        Mon, 23 Oct 2023 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698084488; x=1698689288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39y2Ufi42/TSD/0So/PaEtUOxu4hI7ByzVCWESr99ok=;
        b=ETrjQdspqx91Pz0b3mry7Abf0vaweqxAmhcRURAAwCL8ZZXvOkPX43vCGLe0cEHPfF
         c1Hh085dlWpjGabOHpRu657lU1rMaSP8Ij/Vh3A4YAzk/ufJwONVJG4rUHF7EVglwGDE
         KEmBHGN+n8eLZa8nZzvCNb9GRuId6N0qjbhnReqJDDZ1S+9lBT5nrgP3gulq6uEkchYg
         z0SX5A2FtNU0Qnq3f/01OdPaRPgFkdggoJR7kJ+cRkeD9yCdcsyiquSYa6oJ0A5tJuUz
         nIXRszRB7y2bsNKpGE2S8CF4v1J9bZ4C2JM0sl674Z6TOHP4m8McdUVwzWvWCyp8jRZv
         1cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084488; x=1698689288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39y2Ufi42/TSD/0So/PaEtUOxu4hI7ByzVCWESr99ok=;
        b=wEG/8ICmPoJphWmKztqcuT7MC+v0dQLsQFvNJZgPZZzkA3Dv6eGqKLrfaAqhIKUBk9
         SzbhpdYSSnUE62u/pEcCByQsA/l0ch/wea3jCXSxi7feZuHXtC5YTcObeirs/upcvMPH
         fC/LM+dWkBO/w55X8RSB4bQPYDwTKJCCX5CHAD01Iw0k8mzw+AqHzLbdEsqrHQz1isKX
         Ya9txyGJkVxvdJL6+1AwmkuuOqrdniZuDs5+ccoQBdFo3s0nt+pLXVr/3F/zKEXhumXk
         jdcfKADCpZDy3lsC9NEHETGIf7F47Q0LR8O4hcxsRnGiJ5D5Gt8zJ05ELzRMXb99Jwcz
         XXbg==
X-Gm-Message-State: AOJu0Yw7pf7SIXayjibumZ9QMOWn7rvJNh0Oby6C/2Fj+JTysskK4Wi6
	92w+2kEzoEUmKnZ5k6GZQTY=
X-Google-Smtp-Source: AGHT+IGnhRozy4YsEdUK3dhYoVi10LeoEvFYrP8vb1yHh0g/BT8FMy60tU0nhFRl3gkS0dauaFB5+A==
X-Received: by 2002:a05:600c:4e8c:b0:401:bf56:8ba6 with SMTP id f12-20020a05600c4e8c00b00401bf568ba6mr7609866wmq.28.1698084488122;
        Mon, 23 Oct 2023 11:08:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id c39-20020a05600c4a2700b0040588d85b3asm14391492wmp.15.2023.10.23.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:08:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/4] Support more filesystems with FAN_REPORT_FID
Date: Mon, 23 Oct 2023 21:07:57 +0300
Message-Id: <20231023180801.2953446-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

The grand plan is to be able to use fanotify with FAN_REPORT_FID as a
drop-in replacement for inotify, but with current upstream, inotify is
supported on all the filesystems and FAN_REPORT_FID only on a few.

Making all filesystem support FAN_REPORT_FID requires that all
filesystems will:
1. Support for AT_HANDLE_FID file handles
2. Report non-zero f_fsid

This patch set takes care of the first requirement.
Patches were reviewed by Jan and the nfsd maintainers.

I have another patch in review [2] for adding non-zero f_fsid to many
simple filesystems, but it is independent of this patch set, so no
reason to couple them together.

Note that patch #2 touches many filesystems due to vfs API change,
requiring an explicit ->encode_fh() method. I did not gets ACKs from
all filesystem maintainers, but the change is trivial and does not
change any logic.

Thanks,
Amir.

Changes since v1 [1]:
- Patch #1 already merged into v6.6-rc7
- Fix build without CONFIG_EXPORTFS
- Fix checkpatch warnings
- Define symbolic constant for FILEID_INO64_GEN_LEN
- Clarify documentation (units of) max_len argument

[1] https://lore.kernel.org/r/20231018100000.2453965-1-amir73il@gmail.com/
[2] https://lore.kernel.org/r/20231023143049.2944970-1-amir73il@gmail.com/

Amir Goldstein (4):
  exportfs: add helpers to check if filesystem can encode/decode file
    handles
  exportfs: make ->encode_fh() a mandatory method for NFS export
  exportfs: define FILEID_INO64_GEN* file handle types
  exportfs: support encoding non-decodeable file handles by default

 Documentation/filesystems/nfs/exporting.rst |  7 +--
 Documentation/filesystems/porting.rst       |  9 ++++
 fs/affs/namei.c                             |  1 +
 fs/befs/linuxvfs.c                          |  1 +
 fs/efs/super.c                              |  1 +
 fs/erofs/super.c                            |  1 +
 fs/exportfs/expfs.c                         | 54 +++++++++++++++------
 fs/ext2/super.c                             |  1 +
 fs/ext4/super.c                             |  1 +
 fs/f2fs/super.c                             |  1 +
 fs/fat/nfs.c                                |  1 +
 fs/fhandle.c                                |  6 +--
 fs/fuse/inode.c                             |  7 +--
 fs/jffs2/super.c                            |  1 +
 fs/jfs/super.c                              |  1 +
 fs/nfsd/export.c                            |  3 +-
 fs/notify/fanotify/fanotify_user.c          |  4 +-
 fs/ntfs/namei.c                             |  1 +
 fs/ntfs3/super.c                            |  1 +
 fs/overlayfs/util.c                         |  2 +-
 fs/smb/client/export.c                      | 11 ++---
 fs/squashfs/export.c                        |  1 +
 fs/ufs/super.c                              |  1 +
 include/linux/exportfs.h                    | 51 ++++++++++++++++++-
 24 files changed, 128 insertions(+), 40 deletions(-)

-- 
2.34.1


