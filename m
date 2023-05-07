Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208416F9B2A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 21:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjEGT2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGT2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 15:28:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D39AD31;
        Sun,  7 May 2023 12:28:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaea43def7so24919105ad.2;
        Sun, 07 May 2023 12:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683487695; x=1686079695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oBBWa3jrmLOsDMTh5LEkcrPU/gLn0ua9p/p2VO7DWBU=;
        b=SO6YqgRGBP83QgGjL9Wc6nVAj4QqSuDVB811zsxaB4+2CAG924X7Z//ZvHAC0WHaqp
         jIwG0deb4id7vZmSh+YjGfIA8thOeqKO4WubIpTGfynKMGgG93ZqcmiYQWJTlLvI5MCi
         Nn3mWkNjr9ZHN2eVXihLulRJEmedn+tDiGUdi9uFpdIRYbtj7jeu+UX1zC4IfgKbwjNL
         CwXUlOdxs0MGzquDGaMQIj213KFBazaVNNQNffOj2KuLf3o4NvVirSFlHBtgCEfWmRSH
         QFeAmcLaI/Y2oyrvqIRiPfpkl68zAcwXGoITaxwaUIwhXNJpfgFRh2KXzVaLxc83pIOb
         g+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683487695; x=1686079695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBBWa3jrmLOsDMTh5LEkcrPU/gLn0ua9p/p2VO7DWBU=;
        b=br7PIbfaIlr170gNd/lpo0+Ir3jU/sfQmZqJ6bRFxXJcUYHH7/AOoa4zjqpEIMEfi0
         OpxmwYkhyhQ5hLxVN21j/TBa7Dal8N1/3Wd5otAWsEcxHvT6CS10aTttM09uFt6wFYdS
         +znExW0y6tFHuiAma02aqduCgkVrytlr7G8I/a3u96LZmjFIMHc7ujqbMNk13PAxROPi
         fbT6K7jN0OMgC0+UJNB1o47aS2nw4LZkviaMJaHzy6xDctk5Isi9n414MY6YpljNUOfK
         pjROwpbwhtbzq8k2crtm4oPPkFnE90kFX/2cb5+IAIwxkshPmx82wz9tTxP2EHwx5OFw
         1zig==
X-Gm-Message-State: AC+VfDyrA4XluGkikN7fCjJ0XfQ1n2zQQtLZzii2jig77dtQuJPNH286
        8tK/G1LYNuyyGNMVvTE7t0hkmtWPVbY=
X-Google-Smtp-Source: ACHHUZ7ce0AMaZGjc5d55BAWa1MQ9uXjuWNdLxRSfu4F24OWoLt/7xLN3gxXFiQPuA11qCg0fZykAg==
X-Received: by 2002:a17:902:e543:b0:1ac:8062:4f31 with SMTP id n3-20020a170902e54300b001ac80624f31mr70732plf.37.1683487694633;
        Sun, 07 May 2023 12:28:14 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:80ba:4cb4:7226:d064:79aa])
        by smtp.gmail.com with ESMTPSA id jg18-20020a17090326d200b001a505f04a06sm5485624plb.190.2023.05.07.12.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 12:28:14 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv5 0/5] iomap: Add support for per-block dirty state to improve write performance
Date:   Mon,  8 May 2023 00:57:55 +0530
Message-Id: <cover.1683485700.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please find version-5 of this series. v5 mainly addresses the review comments
from Matthew to have a better iop->state bitmap handling functions.
Please do let me know if any comments/feedback.

Testing
=========
Continuing to run more tests, but so far I haven't observed any surprises
on my 1k and 4k blocksize with default options & -g "auto" runs.

<Pasting RFCv3 => RFCv4 relevant changelog for v5 and dopping everything else>
========================================================================
This addresses a problem reported by Brian for a short write case with delalloc
   release. This is addressed in patch-5 in function iomap_write_delalloc_scan().
   I suppose this is a major change from the previous rfcv3.
   I did test a unit test which Brian provided with xfs_io -f option.
   Before those changes, the kernel caused a bug_on during unmount
   with the unit test. This gets fixed with the changes added in v4.

	i.e. After v4
	=================
	root@ubuntu# ./xfs_io -fc "truncate 4k" -c "mmap 0 4k" -c "mread 0 4k" -c "pwrite 0 1" -c "pwrite -f 2k 1" -c fsync /mnt1/tmnt/testfile
	wrote 1/1 bytes at offset 0
	1.000000 bytes, 1 ops; 0.0001 sec (7.077 KiB/sec and 7246.3768 ops/sec)
	pwrite: Bad address
	root@ubuntu# ./xfs_io -c "fiemap -v" /mnt1/tmnt/testfile
	/mnt1/tmnt/testfile:
	 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
	   0: [0..1]:          22..23               2   0x1
	   1: [2..7]:          hole                 6
	root@ubuntu# filefrag -v /mnt1/tmnt/testfile
	Filesystem type is: 58465342
	File size of /mnt1/tmnt/testfile is 4096 (4 blocks of 1024 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:         11..        11:      1:             last
	/mnt1/tmnt/testfile: 1 extent found
	root@ubuntu# umount /mnt1/tmnt
	root@ubuntu#

	Before v4
	===========
	root@ubuntu# mount /dev/loop8 /mnt1/test
	root@ubuntu# ./xfs_io -fc "truncate 4k" -c "mmap 0 4k" -c "mread 0 4k" -c "pwrite 0 1" -c "pwrite -f 2k 1" -c fsync /mnt1/test/testfile
	wrote 1/1 bytes at offset 0
	1.000000 bytes, 1 ops; 0.0000 sec (10.280 KiB/sec and 10526.3158 ops/sec)
	pwrite: Bad address
	root@ubuntu# ./xfs_io -c "fiemap -v" /mnt1/test/testfile
	/mnt1/test/testfile:
	 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
	   0: [0..1]:          22..23               2   0x0
	   1: [2..3]:          hole                 2
	   2: [4..5]:          0..1                 2   0x7
	   3: [6..7]:          hole                 2
	root@ubuntu# filefrag -v /mnt1/test/testfile
	Filesystem type is: 58465342
	File size of /mnt1/test/testfile is 4096 (4 blocks of 1024 bytes)
	 ext:     logical_offset:        physical_offset: length:   expected: flags:
	   0:        0..       0:         11..        11:      1:
	   1:        2..       2:          0..         0:      0:             last,unknown_loc,delalloc
	/mnt1/test/testfile: 2 extents found
	root@ubuntu# umount /mnt1/test
	<dmesg snip>
	[  156.581188] XFS (loop8): Unmounting Filesystem 7889507d-fc7f-4a1c-94d5-06797f2cc790
	[  156.584455] XFS (loop8): ino 43 data fork has delalloc extent at [0x2:0x1]
	[  156.587847] XFS: Assertion failed: 0, file: fs/xfs/xfs_icache.c, line: 1816
	[  156.591675] ------------[ cut here ]------------
	[  156.594133] kernel BUG at fs/xfs/xfs_message.c:102!
	[  156.596669] invalid opcode: 0000 [#1] PREEMPT SMP PTI
	[  156.599277] CPU: 7 PID: 435 Comm: kworker/7:5 Not tainted 6.3.0-rc6-xfstests-00003-g99a844f4e411-dirty #105
	[  156.603721] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
	[  156.608701] Workqueue: xfs-inodegc/loop8 xfs_inodegc_worker
	[  156.611426] RIP: 0010:assfail+0x38/0x40
	[  156.646981] Call Trace:
	[  156.647951]  <TASK>
	[  156.648904]  xfs_inodegc_set_reclaimable+0x15b/0x160
	[  156.651270]  xfs_inodegc_worker+0x95/0x1d0
	[  156.653202]  process_one_work+0x274/0x550
	[  156.655305]  worker_thread+0x4f/0x300
	[  156.657081]  ? __pfx_worker_thread+0x10/0x10
	[  156.658977]  kthread+0xf6/0x120
	[  156.660657]  ? __pfx_kthread+0x10/0x10
	[  156.662565]  ret_from_fork+0x2c/0x50
	[  156.664421]  </TASK>

Previous changelogs & TODOs at [1]

[1]: https://lore.kernel.org/linux-xfs/cover.1683208091.git.ritesh.list@gmail.com/

Ritesh Harjani (IBM) (5):
  iomap: Rename iomap_page_create/release() to iop_alloc/free()
  iomap: Refactor iop_set_range_uptodate() function
  iomap: Add iop's uptodate state handling functions
  iomap: Allocate iop in ->write_begin() early
  iomap: Add per-block dirty state tracking to improve performance

 fs/gfs2/aops.c         |   2 +-
 fs/iomap/buffered-io.c | 264 ++++++++++++++++++++++++++++++++---------
 fs/xfs/xfs_aops.c      |   2 +-
 fs/zonefs/file.c       |   2 +-
 include/linux/iomap.h  |   1 +
 5 files changed, 210 insertions(+), 61 deletions(-)

--
2.39.2

