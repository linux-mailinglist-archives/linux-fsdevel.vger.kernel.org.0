Return-Path: <linux-fsdevel+bounces-5429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBD580BB93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188811C20749
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F614276;
	Sun, 10 Dec 2023 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV8EJd9K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102EDF4
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:08 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c3f68b79aso12516135e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702217946; x=1702822746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ycp1J/FiIEGPj2lkPXqFbevlm3uakrqsKqBQy5D4fk=;
        b=nV8EJd9KWRENbaNIFPAL4m88eZs/ZWF5GtAcDpWlBh7Xio045FYlRwBc00Ofvu6jjM
         GzIt9fAzHtBiPQXPkYp66JaPsV/t+SvznH8k+PB5Q1XoGoqOpn2GhDOA1NjeX6R1pLp3
         SsuFRz0XsDjaPnTzy1BTNB1iT6StH2j/z5IaWwWMGFYobRNbogYNPKdfexcLwkpGjDQp
         IaB0muMQ1BIkVQa/TPKuJG6m4o9ioZVW4YzZMVaU9bC324QTwzYUOwNJqg41eN6zpT0P
         FJOym0BZSKlQjCSbpnQVAZOMoUHaEDIfG1E3xH9WH07wHOZfHDAjLH7r2s3uwX0o07Z0
         FLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702217946; x=1702822746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ycp1J/FiIEGPj2lkPXqFbevlm3uakrqsKqBQy5D4fk=;
        b=LBivF7/+11u8u811dx43IVkIfsdzISLhvjQRcf1l9ePMsahWZV+Izvbxk85hp/seac
         f3NuCXJed1wGPZSytGOfYb1SjcjvxnpIatmURsx9GsRVUu/8c6jFBrZLX4CG9dc+0L2t
         3b1IfP9g6ExRB5AOrFi7/lXo74QISX/rKfGp959oNsKU+zEvNVQDEdoc0FRcDqNcOP4i
         4DM2UEM+vGx2FZfSVUpt8G9nA/ge1Tq+RcTBHidVgzGGcbTnSjiS8YeYLzL1TDl+3Uz8
         JaVohtiw5xJuRJkSBKS3RslSPIsWVghee4qe1V1Xrm/iGegls5yIgwxXsnHF24P2mVTr
         3DoQ==
X-Gm-Message-State: AOJu0Yz3hlsd5nBBpOkl3fZnG66EiYxv+wFtQ6/9Lkc9EXSszHUUnPmL
	b8z4tWR2cnvYbPFKKlSfNT0=
X-Google-Smtp-Source: AGHT+IFPpuFxcuVJXWnHAAAQGNXuLGYfDlEZl0Ob3XUgMg2mVjcSJv1+GJTGSgVs0CPu6cdgi3iG/w==
X-Received: by 2002:a05:600c:4311:b0:40b:5e21:dd40 with SMTP id p17-20020a05600c431100b0040b5e21dd40mr1775385wme.110.1702217946217;
        Sun, 10 Dec 2023 06:19:06 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm9644164wmq.18.2023.12.10.06.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:19:05 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/5] Prepare for fsnotify pre-content permission events
Date: Sun, 10 Dec 2023 16:18:56 +0200
Message-Id: <20231210141901.47092-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

This v2 of pre-content event prep patches addresses some comments and
replaces the v1 patches [1] that are currently applied to vfs.rw.

I started with a new cleanup patch for ssize_t return type that you
suggested.

Patch 2 has a fix for a build error reported by kernel tests robot
(moved MAX_RW_COUNT capping to splice_file_range()), so I did not
retain the RVBs for this patch.

Patches 3,4 are unchanged and retain their RVBs.

Patch 5 changes the fsnotify hook name, so RBVs not retained.

Thanks,
Amir.

Changes since v1 [1]:
- Move MAX_RW_COUNT capping to splice_file_range() to fix build error
- Cleanup splice helpers return type
- Change fsnotify hook name to fsnotify_file_area_perm()
- Add RVBs

[1] https://lore.kernel.org/r/20231207123825.4011620-1-amir73il@gmail.com/

Amir Goldstein (5):
  splice: return type ssize_t from all helpers
  fs: use splice_copy_file_range() inline helper
  fsnotify: split fsnotify_perm() into two hooks
  fsnotify: assert that file_start_write() is not held in permission
    hooks
  fsnotify: optionally pass access range in file permission hooks

 fs/ceph/file.c           |  4 +--
 fs/fuse/file.c           |  5 +--
 fs/nfs/nfs4file.c        |  5 +--
 fs/open.c                |  4 +++
 fs/overlayfs/copy_up.c   |  2 +-
 fs/read_write.c          | 46 ++++++---------------------
 fs/readdir.c             |  4 +++
 fs/remap_range.c         |  8 ++++-
 fs/smb/client/cifsfs.c   |  5 +--
 fs/splice.c              | 69 ++++++++++++++++++++--------------------
 include/linux/fs.h       |  3 --
 include/linux/fsnotify.h | 50 ++++++++++++++++++++---------
 include/linux/splice.h   | 50 ++++++++++++++++-------------
 io_uring/splice.c        |  4 +--
 security/security.c      | 10 ++----
 15 files changed, 138 insertions(+), 131 deletions(-)

-- 
2.34.1


