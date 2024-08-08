Return-Path: <linux-fsdevel+bounces-25453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D794C529
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597331C22086
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1009157466;
	Thu,  8 Aug 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gvpwn+W+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C0156F27
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145301; cv=none; b=ffq6OSotdWte30d5TWN+VnD8FKKJGGAinCoMLxWDmlGPjvp6QzwtdcinZjVXlMCEDqHGVyRn+n+TqV7Molh5Np/gYva/cp7vLeMU/T5S9/A/tCbI42yw1qy4xeRoqHiJnX7al5E06RN4tQADKgXAMG799CkxZzYNZwstu/qihCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145301; c=relaxed/simple;
	bh=moGq7PvzGvB0S6UQMZuwnIDOkPknvOA1+Hh9JdRtibM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q+a+R/3CgMp/xospULwU/3el0a1dzAdtye5jpaomFqLhmGKJy1qIIJLKh/RBtOPrnSFNX0rTTNuoecST4mfkWGtj/je+BrcLvDLC8BQ/CFTufFeDJZfIPcqieLb95Vhx6JrXpgQGYuxKZ3My8luBeIMwBfldGXB2aPdmgjBqucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gvpwn+W+; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1e4c75488so84089785a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145298; x=1723750098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=agwST92yUhpv2dWxzT9/pEGlKDn9gtYgiwLWoC5Trsk=;
        b=gvpwn+W+44B3E05WH/bsIflmSbZjONKg8olq3OJIx/2VxHnCccK0AtrXTf4ps9myvT
         87/xsU1DrxakXjwa1fMsFxfPJR2g1ngyEXguMvU4Y/61+b0IofrT9jOU7laUKig/TIJz
         QeO/ybSnVRry2Gy1QsJM+oIpaN13dXjCwOwoiuj/WnhJAKHbZqYZa7Wyz/jnw8qNVGpI
         L8LSRsBnxRnkBdoMwk8XqxZ4nnLQWY00RgJoUzEUSj2la7HWYeCMjeR122+b49b+wQDi
         w/g4vLYn2OrSKncemzfrTaUIyefCf9QfnQ4fYTUQa6yPK87gqtePaNWeeJ+5xz86igzu
         AvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145298; x=1723750098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agwST92yUhpv2dWxzT9/pEGlKDn9gtYgiwLWoC5Trsk=;
        b=sXkBVnkmpsY7Y3EjebX+m2R+c7NJ7betrAmMORuCNetoiq/KydQ75Ndf84oqyoUtWD
         BpEw16OlJLopR85V+IbhrqrqK9uRm/25NXUnnyuZUf/RNi9Kc2pECg/MntOKKphk2bjv
         hpDeI1gEYEaMEm7d9HODumxkiulXVC3vm6WhiXG+8XsUI8/4EpMl+AEM9MJX5HRyotPe
         Vp5GoLrBSULrz91SEhGcA5UxQtbJFJvEHl5NfGplbYuBOxpeJ4grMt+TMrL53ztFQqLz
         6qzMTapHfvkmBRTXGkrMAIG5iprOhrMg8TbtEo7nh9Q8BVTWL8Zj5+q2gm+0OBIYGmfZ
         bM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWI5F7NuvEQXSG9YM0D/ao+UPkMOPqwNc068qlXM8rHrl4PqY72SDnp40j5+9XKDz3FYISGWzxUlo5QcqLvJXTWVbKZG2TZvbtUbXEACw==
X-Gm-Message-State: AOJu0Yw/U2sPDYR2dfmp2CH0SqZL7WccgTnOchz2g46fKhFbZKinkyoF
	UQL8SCvooEoK3tYtEB5bp3FHo7Z+JKsJ/sVKCl5LCdzwJy24azBIPsZKyoC5Qtg=
X-Google-Smtp-Source: AGHT+IGGxHal+nvm3DWblQGxQewjVvUB+tmtzj67hYOald+f6l1Hj85ZVGGxy87PgKyA6cAN7fLx5A==
X-Received: by 2002:a05:620a:4515:b0:79f:436:7e3a with SMTP id af79cd13be357-7a381872787mr341626485a.48.1723145298198;
        Thu, 08 Aug 2024 12:28:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d2a3csm189653585a.18.2024.08.08.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 00/16] fanotify: add pre-content hooks
Date: Thu,  8 Aug 2024 15:27:02 -0400
Message-ID: <cover.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

v1->v2:
- reworked the page fault logic based on Jan's suggestion and turned it into a
  helper.
- Added 3 patches per-fs where we need to call the fsnotify helper from their
  ->fault handlers.
- Disabled readahead in the case that there's a pre-content watch in place.
- Disabled huge faults when there's a pre-content watch in place (entirely
  because it's untested, theoretically it should be straightforward to do).
- Updated the command numbers.
- Addressed the random spelling/grammer mistakes that Jan pointed out.
- Addressed the other random nits from Jan.

--- Original email ---

Hello,

These are the patches for the bare bones pre-content fanotify support.  The
majority of this work is Amir's, my contribution to this has solely been around
adding the page fault hooks, testing and validating everything.  I'm sending it
because Amir is traveling a bunch, and I touched it last so I'm going to take
all the hate and he can take all the credit.

There is a PoC that I've been using to validate this work, you can find the git
repo here

https://github.com/josefbacik/remote-fetch

This consists of 3 different tools.

1. populate.  This just creates all the stub files in the directory from the
   source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
   recursively create all of the stub files and directories.
2. remote-fetch.  This is the actual PoC, you just point it at the source and
   destination directory and then you can do whatever.  ./remote-fetch ~/linux
   ~/hsm-linux.
3. mmap-validate.  This was to validate the pagefault thing, this is likely what
   will be turned into the selftest with remote-fetch.  It creates a file and
   then you can validate the file matches the right pattern with both normal
   reads and mmap.  Normally I do something like

   ./mmap-validate create ~/src/foo
   ./populate ~/src ~/dst
   ./rmeote-fetch ~/src ~/dst
   ./mmap-validate validate ~/dst/foo

I did a bunch of testing, I also got some performance numbers.  I copied a
kernel tree, and then did remote-fetch, and then make -j4

Normal
real    9m49.709s
user    28m11.372s
sys     4m57.304s

HSM
real    10m6.454s
user    29m10.517s
sys     5m2.617s

So ~17 seconds more to build with HSM.  I then did a make mrproper on both trees
to see the size

[root@fedora ~]# du -hs /src/linux
1.6G    /src/linux
[root@fedora ~]# du -hs dst
125M    dst

This mirrors the sort of savings we've seen in production.

Meta has had these patches (minus the page fault patch) deployed in production
for almost a year with our own utility for doing on-demand package fetching.
The savings from this has been pretty significant.

The page-fault hooks are necessary for the last thing we need, which is
on-demand range fetching of executables.  Some of our binaries are several gigs
large, having the ability to remote fetch them on demand is a huge win for us
not only with space savings, but with startup time of containers.

There will be tests for this going into LTP once we're satisfied with the
patches and they're on their way upstream.  Thanks,

Josef

Amir Goldstein (8):
  fsnotify: introduce pre-content permission event
  fsnotify: generate pre-content permission event on open
  fanotify: introduce FAN_PRE_ACCESS permission event
  fanotify: introduce FAN_PRE_MODIFY permission event
  fanotify: pass optional file access range in pre-content event
  fanotify: rename a misnamed constant
  fanotify: report file range info with pre-content events
  fanotify: allow to set errno in FAN_DENY permission response

Josef Bacik (8):
  fanotify: don't skip extra event info if no info_mode is set
  fanotify: add a helper to check for pre content events
  fanotify: disable readahead if we have pre-content watches
  mm: don't allow huge faults for files with pre content watches
  fsnotify: generate pre-content permission event on page fault
  bcachefs: add pre-content fsnotify hook to fault
  gfs2: add pre-content fsnotify hook to fault
  xfs: add pre-content fsnotify hook for write faults

 fs/bcachefs/fs-io-pagecache.c      |  13 ++++
 fs/gfs2/file.c                     |  13 ++++
 fs/namei.c                         |   9 +++
 fs/notify/fanotify/fanotify.c      |  32 ++++++--
 fs/notify/fanotify/fanotify.h      |  20 +++++
 fs/notify/fanotify/fanotify_user.c | 116 +++++++++++++++++++++++------
 fs/notify/fsnotify.c               |  14 +++-
 fs/xfs/xfs_file.c                  |  20 ++++-
 include/linux/fanotify.h           |  20 +++--
 include/linux/fsnotify.h           |  54 ++++++++++++--
 include/linux/fsnotify_backend.h   |  59 ++++++++++++++-
 include/linux/mm.h                 |   2 +
 include/uapi/linux/fanotify.h      |  17 +++++
 mm/filemap.c                       | 109 +++++++++++++++++++++++++--
 mm/memory.c                        |  22 ++++++
 mm/readahead.c                     |  13 ++++
 security/selinux/hooks.c           |   3 +-
 17 files changed, 482 insertions(+), 54 deletions(-)

-- 
2.43.0


