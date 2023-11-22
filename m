Return-Path: <linux-fsdevel+bounces-3404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D76A7F4624
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BF9B20AAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8B4C601;
	Wed, 22 Nov 2023 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7EmtVBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A810EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b344101f2so427045e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656041; x=1701260841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKLj5l1Xhnw2zoUlxx/+LN6slM4CkiXXHqNLCxOI6DA=;
        b=F7EmtVBN/rwK8fYUGFRuPZo2DRj9NiXOAePIpFIcZIafnrUkARz/j4xaaaXqauW51e
         HK7IUHUBFz+Y6YVDDQXeuQswzBpnQsRgYp0arEQM7GOVJXX9H7JI/fcdtbOqixZ0QNAg
         oSKlW9zdquPKtgZ5ZF5uklhCqld9lJpgwTOlocTQQnYYgMQDkBpduOvRHaYi17sn9mzX
         x/jm9jLymQkW6C8g3jTQRvTWFh3a83wBHe58fLPIn+0eu8ltwZmkckJZHmZ01CkUaPob
         JvzIcljE69qWMFfcLKHnxZzSZDSqezkEi11FhKpXvmPjglpxRsfE3VZgRG6D+Vk4CMft
         yQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656041; x=1701260841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKLj5l1Xhnw2zoUlxx/+LN6slM4CkiXXHqNLCxOI6DA=;
        b=WJnrIiSPUk1DnQYzJlhDSnNxhf+Wn6y4AdesauoFnnQtmbOnR9YSM45p8FH81pidsf
         R+NmdQZxKzhA1GrEBpFvqqcUa0R2QfrhtMcfF7UUbS/cEytvYcJV919X0ATT9wHhsLtR
         s2ktP796IxI/pIhZy3xxH6raXeFVK8phBwrr+RHp3cbpE0X5i4Rq5768aluBGNfPg3E9
         +TaGbqpWyhJDOY9ZZC9JWWtdnbcS/saL59m0XPMq6j4WBsWQ6jtBtJTJPyuIgWTxBS33
         ra/txqHD+5fqK0NOxLOJ2zB+YjQtQzOAT+uEJ0HWWw23wldzNiqE6wZ5wbVofCqXG6u1
         LTsg==
X-Gm-Message-State: AOJu0YzqbaJjub4Q+nkbNvJaGDYvP48T5lKTNUnbOeB69nA0XqvS/E8Q
	Hzwb7qi7DrAdBhGCa1E8pdscbobAbeU=
X-Google-Smtp-Source: AGHT+IGNJf2HQ3DEGEq0G8xnoSbSunfl/YU49xkKIoTPNNTx9BLM5JAoGMJyr1sor4IBIb7Fqs52MA==
X-Received: by 2002:a05:600c:4712:b0:405:19dd:ad82 with SMTP id v18-20020a05600c471200b0040519ddad82mr2137104wmo.16.1700656040606;
        Wed, 22 Nov 2023 04:27:20 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:20 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/16] Tidy up file permission hooks
Date: Wed, 22 Nov 2023 14:26:59 +0200
Message-Id: <20231122122715.2561213-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

During my work on fanotify "pre content" events [1], Jan and I noticed
some inconsistencies in the call sites of security_file_permission()
hooks inside rw_verify_area() and remap_verify_area().

The majority of call sites are before file_start_write(), which is how
we want them to be for fanotify "pre content" events.

For splice code, there are many duplicate calls to rw_verify_area()
for the entire range as well as for partial ranges inside iterator.

This cleanup series, mostly following Jan's suggestions, moves all
the security_file_permission() hooks before file_start_write() and
eliminates duplicate permission hook calls in the same call chain.

The last 3 patches are helpers that I used in fanotify patches to
assert that permission hooks are called with expected locking scope.

Please stage this work on a stable branch in the vfs tree, so that
I will be able to send Jan fanotify patches for "pre content" events
based on the stable vfs branch.

Thanks,
Amir.

Changes since v1:
- Split coda locking reorder patch (jaharkes)
- Fix vfs_iocb_iter_write() file_end_write() bug (Josef)
- Fix subtle allow_file_dedupe() bug (+rename) (brauner)
- Fix some minor review nits (brauner)
- Added RVB from Josef and Chuck

[1] https://github.com/amir73il/linux/commits/fan_pre_content

Amir Goldstein (16):
  ovl: add permission hooks outside of do_splice_direct()
  splice: remove permission hook from do_splice_direct()
  splice: move permission hook out of splice_direct_to_actor()
  splice: move permission hook out of splice_file_to_pipe()
  splice: remove permission hook from iter_file_splice_write()
  remap_range: move permission hooks out of do_clone_file_range()
  remap_range: move file_start_write() to after permission hook
  btrfs: move file_start_write() to after permission hook
  coda: change locking order in coda_file_write_iter()
  fs: move file_start_write() into vfs_iter_write()
  fs: move permission hook out of do_iter_write()
  fs: move permission hook out of do_iter_read()
  fs: move kiocb_start_write() into vfs_iocb_iter_write()
  fs: create __sb_write_started() helper
  fs: create file_write_started() helper
  fs: create {sb,file}_write_not_started() helpers

 drivers/block/loop.c   |   2 -
 fs/btrfs/ioctl.c       |  12 +--
 fs/cachefiles/io.c     |   5 +-
 fs/coda/file.c         |   2 -
 fs/internal.h          |   8 +-
 fs/nfsd/vfs.c          |   7 +-
 fs/overlayfs/copy_up.c |  26 +++++-
 fs/overlayfs/file.c    |  10 +--
 fs/read_write.c        | 177 ++++++++++++++++++++++++++++-------------
 fs/remap_range.c       |  37 +++++----
 fs/splice.c            |  78 ++++++++++--------
 include/linux/fs.h     |  62 ++++++++++++++-
 12 files changed, 297 insertions(+), 129 deletions(-)

-- 
2.34.1


