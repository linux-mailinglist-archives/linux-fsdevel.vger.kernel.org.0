Return-Path: <linux-fsdevel+bounces-422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19B7CAE7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0861C20926
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505930CE4;
	Mon, 16 Oct 2023 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBrADG+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C51D2377B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:11 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E783
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32d81864e3fso3873629f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472548; x=1698077348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTlDGYWDvZpkZxswquAXq1cIaJ0qU0Vm4mzZMBRn1hc=;
        b=JBrADG+VfTp0CaNMPif3u76A0EMj2d/lYXvy5VI1p4zxe+6btbymm2glCdNRMkzwlV
         /0zk7aXTcvHlIpsChbAQg/bkpqrCgls3BD03Xkrzd+mwhh1wZYczTi9OIeXMsbOEJnu1
         zTy6pFm2cNo95gb3B2uKixYZl7JD3l3eEWQTT1yFqQ1dPecFSwH8j+Wu5trKakTTQWo0
         9CBKvCD8MOlG5ry0IuVTfMPI4+LYPwFkJT1zhXyIC8E6C6/DVwo1y7Y6fRKF/nLFLWC5
         NnIzky8aruUyA0iR/op/2+1Ch9om/pTrES2LJ685KNy1z+RyC1px4YbPuIc/bob7SMKr
         GJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472548; x=1698077348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTlDGYWDvZpkZxswquAXq1cIaJ0qU0Vm4mzZMBRn1hc=;
        b=XZJCQS5OSv70YKnzuCN7/yDMiW/oyM/l8YberHs2GTWBQam/+b5biAx/K+840ayaeX
         HsMLCi2HIsQlPkT9oeQ370ZsLp316YETYWBPyNWZoFHlWRuThGX7QlAjkr30RM4Xi6vR
         +vdZSLjL03V6wnyEczjBYi2R6fG5lsHiWKsdwtBqQsljns8T1nBdH6r0tfPFNJvk9LjJ
         Pm4wSWnLjyfASQmFV6kSudI0KNROhL5NLk2MgGBmVeKKfevybC6K6ipuFxDFnTwWshNI
         JaekjL/thcLCLx3cFVfA6oEjY4HrPTEA1O+2FecSAZEWp0uJFiXJsEEXjXcsIqN9VcVv
         9i7A==
X-Gm-Message-State: AOJu0YzHedfIw2tKrhjD0LJF0a4hnsQlU7M6xcp272HXkjMQPoP3Nngc
	He5NdXmPi9uxoRG9jRk4PkE=
X-Google-Smtp-Source: AGHT+IHApMwNUENesm4K4o+3OeC1yTt4ceAWpPmpqAGpja0E5nclWizznI77YMQK7XTF9pFnO6wF4A==
X-Received: by 2002:a5d:5441:0:b0:32d:a853:af68 with SMTP id w1-20020a5d5441000000b0032da853af68mr4763439wrv.52.1697472547542;
        Mon, 16 Oct 2023 09:09:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 00/12] FUSE passthrough for file io
Date: Mon, 16 Oct 2023 19:08:50 +0300
Message-Id: <20231016160902.2316986-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Miklos,

I've shared several POC branches since the posting of v13 back in May
and played with several API choices. It is time to post v14.

The API we converged to is server managed shared backing files that are
referenced by backing id plus per-file re-opened backing_file.

This model looks coherent to me. I think that the example server [3]
demonstrates that this API is simple enough to work with.

There is quite a bit of re-factored code in this version - I've actually
declared this common code as a new vfs subsystem [stackable filesystems]
in MAINTAINERS per Christian's request.

The re-factored common code is based on overlayfs-next and Christian's
vfs.misc branch (for the backing_file changes).

I am not posting performance numbers again. Alessio has already posted
performance numbers back in v12 and nothing has changed in this regard.
We are using a variant of v12 patches in production and the performance
improvement is very noticable.

Bernd and Nikolaus have helped with improving running fstests on fuse
passthrough examples.

I have ran the -g auto fstests with v14 patches with the example server.
Compared to the baseline test results with passthrough_hp, the backing
file passthrough passes several more test, mainly tests related to data
coherecy, such as generic/451.

The following tests are the only ones that pass on baseline passthtough_hp
and fail with my backing file passthrough example:

  generic/080 generic/120 generic/193 generic/215 generic/355

Those tests are failing because of missing mtime/atime/ctime updates
in some use cases and failure to strip suid/sgid bits in some cases.

The model of who is responsible for updating timestamps and stripping
suid/sgid bits is not always clear when it comes to backing file
passthrough. I tried to invalidate attr caches similar to how fuse
read/write behaves, but it does not cover all cases correctly.

Let me know what you think of this version and if you think there is
anything else that we need to take care of before upstreaming.

Thanks,
Amir.

Changes from v13 [1]:
- rebase on 6.6-rc6 (and overlayfs and vfs next branches)
- server managed shared backing files without auto-close mode
- open a backing_file per fuse_file with fuse file's path and flags
- factor out common read/write/splice/mmap helpers from overlayfs
- factor out ioctl helpers

[1] https://lore.kernel.org/r/20230519125705.598234-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/fuse-backing-fd-v14
[3] https://github.com/amir73il/libfuse/commits/fuse-backing-fd

Amir Goldstein (12):
  fs: prepare for stackable filesystems backing file helpers
  fs: factor out backing_file_{read,write}_iter() helpers
  fs: factor out backing_file_splice_{read,write}() helpers
  fs: factor out backing_file_mmap() helper
  fuse: factor out helper for FUSE_DEV_IOC_CLONE
  fuse: introduce FUSE_PASSTHROUGH capability
  fuse: pass optional backing_id in struct fuse_open_out
  fuse: implement ioctls to manage backing files
  fuse: implement read/write passthrough
  fuse: implement splice_{read/write} passthrough
  fuse: implement passthrough for mmap
  fuse: implement passthrough for readdir

 MAINTAINERS                  |   9 +
 fs/Kconfig                   |   4 +
 fs/Makefile                  |   1 +
 fs/backing-file.c            | 319 ++++++++++++++++++++++++++++
 fs/fuse/Kconfig              |  11 +
 fs/fuse/Makefile             |   1 +
 fs/fuse/cuse.c               |   3 +-
 fs/fuse/dev.c                |  98 ++++++---
 fs/fuse/dir.c                |   2 +-
 fs/fuse/file.c               |  69 ++++--
 fs/fuse/fuse_i.h             |  72 ++++++-
 fs/fuse/inode.c              |  25 +++
 fs/fuse/ioctl.c              |   3 +-
 fs/fuse/passthrough.c        | 392 +++++++++++++++++++++++++++++++++++
 fs/fuse/readdir.c            |  12 +-
 fs/open.c                    |  38 ----
 fs/overlayfs/Kconfig         |   1 +
 fs/overlayfs/file.c          | 246 ++++------------------
 fs/overlayfs/overlayfs.h     |   8 +-
 fs/overlayfs/super.c         |  11 +-
 include/linux/backing-file.h |  42 ++++
 include/linux/fs.h           |   3 -
 include/uapi/linux/fuse.h    |  23 +-
 23 files changed, 1085 insertions(+), 308 deletions(-)
 create mode 100644 fs/backing-file.c
 create mode 100644 fs/fuse/passthrough.c
 create mode 100644 include/linux/backing-file.h

-- 
2.34.1


