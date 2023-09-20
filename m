Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397287A8C7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjITTPU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 15:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjITTPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:15:19 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730D712F;
        Wed, 20 Sep 2023 12:14:50 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so1094665ad.1;
        Wed, 20 Sep 2023 12:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237289; x=1695842089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auLwmYcPwpCop/KyMdUsQVrE3j+wevfYzyjjkhpW8JQ=;
        b=BwfKVMSNrjOHPISewDcE3JRWBljGUv/YwTjp0jwcc2pnMAoYy7HWVGUke0w4vHM072
         qvKgWdjTQElOhDv9lZnQmOLQQF47HbdBDsbxfPYjROMDsThW+2MuX6s5lRWpHiwtdc/k
         MP0FiMz/j4v/OYleFCfVrFaCPhYvGawKncCr9Z5rp41CST/i7OIYguHlyxx0z1D7t5VH
         kMS4MgNoELr7PGkNpQs0l1vqNenhgZHaFDJG1wpWcEs7JzLUxDJAu0qsbZqt9UiT9ZfI
         sk+vGp4hrhO3ifT8flH09/u/soTY4M3XuT94/fadNZzzgzJwrUIEEgmvgkS3JFlnQGib
         6OrQ==
X-Gm-Message-State: AOJu0Yx3JtnZFvg+Csm7K7ubt88X8gVWhNHctCBJe4rfbxud+zwdz2lQ
        xD1BqmIVJo6nIf422CiFK0VGRGU33U4=
X-Google-Smtp-Source: AGHT+IGUnEwHX2MXMmDcrFI/KFBT6yC74KxXDI1Qtbv29u3ZVQSECDj2jLkgvawjmi5HcU27+NXamQ==
X-Received: by 2002:a17:90a:31c9:b0:26d:416a:b027 with SMTP id j9-20020a17090a31c900b0026d416ab027mr3487236pjf.31.1695237289429;
        Wed, 20 Sep 2023 12:14:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id a13-20020a17090a8c0d00b002633fa95ac2sm1656318pjo.13.2023.09.20.12.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:14:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/13] Pass data temperature information to zoned UFS devices
Date:   Wed, 20 Sep 2023 12:14:25 -0700
Message-ID: <20230920191442.3701673-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

Zoned UFS vendors need the data temperature information. Hence this patch
series that restores write hint information in F2FS and in the block layer.
The SCSI disk (sd) driver is modified such that it passes write hint
information to SCSI devices via the GROUP NUMBER field.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (13):
  fs/f2fs: Restore the whint_mode mount option
  fs: Restore support for F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT
  fs: Restore kiocb.ki_hint
  block: Restore write hint support
  scsi: core: Query the Block Limits Extension VPD page
  scsi_proto: Add struct io_group_descriptor
  sd: Translate data lifetime information
  scsi_debug: Reduce code duplication
  scsi_debug: Support the block limits extension VPD page
  scsi_debug: Rework page code error handling
  scsi_debug: Rework subpage code error handling
  scsi_debug: Implement the IO Advice Hints Grouping mode page
  scsi_debug: Maintain write statistics per group number

 Documentation/filesystems/f2fs.rst |  70 ++++++++++
 block/bio.c                        |   2 +
 block/blk-crypto-fallback.c        |   1 +
 block/blk-merge.c                  |  14 ++
 block/blk-mq.c                     |   2 +
 block/bounce.c                     |   1 +
 block/fops.c                       |   3 +
 drivers/scsi/scsi.c                |   2 +
 drivers/scsi/scsi_debug.c          | 202 +++++++++++++++++++----------
 drivers/scsi/scsi_sysfs.c          |  10 ++
 drivers/scsi/sd.c                  |  78 ++++++++++-
 drivers/scsi/sd.h                  |   2 +
 fs/aio.c                           |   1 +
 fs/buffer.c                        |  13 +-
 fs/cachefiles/io.c                 |   2 +
 fs/direct-io.c                     |   1 +
 fs/f2fs/data.c                     |   2 +
 fs/f2fs/f2fs.h                     |   9 ++
 fs/f2fs/file.c                     |   6 +
 fs/f2fs/segment.c                  |  95 ++++++++++++++
 fs/f2fs/super.c                    |  32 ++++-
 fs/fcntl.c                         |  18 +++
 fs/iomap/buffered-io.c             |   2 +
 fs/iomap/direct-io.c               |   1 +
 fs/mpage.c                         |   1 +
 fs/open.c                          |   1 +
 include/linux/blk-mq.h             |   1 +
 include/linux/blk_types.h          |   1 +
 include/linux/fs.h                 |  21 +++
 include/scsi/scsi_device.h         |   1 +
 include/scsi/scsi_proto.h          |  40 ++++++
 include/trace/events/f2fs.h        |   5 +-
 io_uring/rw.c                      |   1 +
 33 files changed, 566 insertions(+), 75 deletions(-)

