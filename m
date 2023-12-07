Return-Path: <linux-fsdevel+bounces-5149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2F808AB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2F4B20FE5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7B3D0D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsAz8JCD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6EC1716
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 04:38:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3334254cfa3so512394f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 04:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952713; x=1702557513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1sJsP6rK/KglGJR5zN6pvF4Y7bSWLocljX5qmOcXD8=;
        b=UsAz8JCDVHBoZmSET8avQn1DscaXWTQcEaTId5smNjq3ZerQPZCh2qjNRzkOhtiARY
         RjWBBTCRBBH/UJPDXaj+OSHq/ikcjL+RtxqNFvohvlb2OUKV+J8KV87cLWOuKZSpJTvW
         nsNqZ3kSlsAj5RQX/rhyx/4Us5R7wm0Gy3QeZwZwuK8pGNU8Rg4SoCgVkgbtEJl8/EhI
         U0tWIkrFEWNgY1p0SrOFmDOpgqmsSpyMWH5V+oaB3P53WVMhhUZiRSGiFzn95OV8vR4V
         tr9WQwsweeFoX3oxmd74DVMnuSU2Un5/aTlcwJNTaMdaVRzKZ50sDUIyRg5Nh6SB+bJW
         f1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952713; x=1702557513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1sJsP6rK/KglGJR5zN6pvF4Y7bSWLocljX5qmOcXD8=;
        b=tleV2BLUfhoSR5OCksU6Q8gg8S5do7Xx8yU1dZOjP+CkjGEdPNi4u+sbdBK1NqLUyi
         1RjdA1wZ+Px62Lgv6v6IFl8lmOre89DP+y1L9ytcD+o3zNX7fjDs6LJheWCJYZldfFx6
         j30paLOZxyZg9OaTsfwH69164c0yRE3bQ2AI5RsxJLb4z3ZNxGKMDSekh7uc2Q1bvsMh
         hggIjrCRLm1uRnx4kuVlvtitpJIcEQSU5iY7nNbS6sC0BKoc1VphYfYD28GK8Y0iHT4u
         szN8mga68+1r59Htpc7qMDXmepCEwRxrG/jbBkJJOtOQaNfjZbFhlYo3SxCyTG+JlZdy
         ifvA==
X-Gm-Message-State: AOJu0YwQzU1M53ucjtCMAjr0xCxT9JIHUKVseFclon9WDSxQkrv2zeWY
	IrDod2SdgFUlBpgG0vJUpXs=
X-Google-Smtp-Source: AGHT+IFeqOlSK8CytlB85X3oIyy9gF/sXYKg8/vxITJP/X4jlTjPsiy710nP3tqR/JW4Afa9JVU1sQ==
X-Received: by 2002:adf:eb87:0:b0:333:47e4:6216 with SMTP id t7-20020adfeb87000000b0033347e46216mr1650957wrn.13.1701952712772;
        Thu, 07 Dec 2023 04:38:32 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003333abf3edfsm1332431wrs.47.2023.12.07.04.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:38:32 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] Prepare for fsnotify pre-content permission events
Date: Thu,  7 Dec 2023 14:38:21 +0200
Message-Id: <20231207123825.4011620-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan & Christian,

I am not planning to post the fanotify pre-content event patches [1]
for 6.8.  Not because they are not ready, but because the usersapce
example is not ready.

Also, I think it is a good idea to let the large permission hooks
cleanup work to mature over the 6.8 cycle, before we introduce the
pre-content events.

However, I would like to include the following vfs prep patches along
with the vfs.rw PR for 6.8, which could be titled as the subject of
this cover letter.

Patch 1 is a variant of a cleanup suggested by Christoph to get rid
of the generic_copy_file_range() exported symbol.

Patches 2,3 add the file_write_not_started() assertion to fsnotify
file permission hooks.  IMO, it is important to merge it along with
vfs.rw because:

1. This assert is how I tested vfs.rw does what it aimed to achieve
2. This will protect us from new callers that break the new order
3. The commit message of patch 3 provides the context for the entire
   series and can be included in the PR message

Patch 4 is the final change of fsnotify permission hook locations/args
and is the last of the vfs prerequsites for pre-content events.

If we merge patch 4 for 6.8, it will be much easier for the development
of fanotify pre-content events in 6.9 dev cycle, which be contained
within the fsnotify subsystem.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fan_pre_content

Amir Goldstein (4):
  fs: use splice_copy_file_range() inline helper
  fsnotify: split fsnotify_perm() into two hooks
  fsnotify: assert that file_start_write() is not held in permission
    hooks
  fsnotify: pass access range in file permission hooks

 fs/ceph/file.c           |  4 ++--
 fs/fuse/file.c           |  5 +++--
 fs/nfs/nfs4file.c        |  5 +++--
 fs/open.c                |  4 ++++
 fs/read_write.c          | 44 ++++++++--------------------------------
 fs/readdir.c             |  4 ++++
 fs/remap_range.c         |  8 +++++++-
 fs/smb/client/cifsfs.c   |  5 +++--
 fs/splice.c              |  2 +-
 include/linux/fs.h       |  3 ---
 include/linux/fsnotify.h | 42 ++++++++++++++++++++++++--------------
 include/linux/splice.h   |  8 ++++++++
 security/security.c      | 10 ++-------
 13 files changed, 72 insertions(+), 72 deletions(-)

-- 
2.34.1


