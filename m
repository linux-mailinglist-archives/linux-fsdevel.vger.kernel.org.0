Return-Path: <linux-fsdevel+bounces-9567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1661842EE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51591C2444C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369A78675;
	Tue, 30 Jan 2024 21:49:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351E78661;
	Tue, 30 Jan 2024 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651360; cv=none; b=me4diK8A0tp2IGO7v6H5GNVVzzsmST+l3XaBgHP3LsKtM5HgE9uSDZlE3nShG5HG7oG7hRQ4lGDLW5gYfUx0zbwpIV1FHwpFwfmI2QHcmJeU4fRpbrwMS0FWosZaf9JfAs8RKLbEc4A5nWuX5PHQVzoChD7wTqkWzO4iKozhNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651360; c=relaxed/simple;
	bh=AgOZ8fS0ZdeWrSTK60qllKoZj76EK5/uWgQudX6Oj2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkfZxD4AYBXWv+LnJM+3V5L184tDbga5RqHI9yqBwIjYI+9t9iHUS2HAn5YmCe6Ft6NrGZ4R6p1p9N03fRd9Vu7DsSAkxUdx5n9gnT1y7rFSFqd3niX/ILWJ1nJkrdUrf/mjDBy2/iuhWzsWUho9wYz0Vjl/VVO89cYcHzwm8h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59a27fbe832so1213545eaf.3;
        Tue, 30 Jan 2024 13:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651357; x=1707256157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNhb5l1JXYTb2I8/W+Qyh+QKu+mFvWiZEOhzArQ2/u8=;
        b=bqxXriexJKWdRQVmKrjIe8EIamYE5pAl5DNDUj+HwwU08LAI7ZO0S6rHDt7Ip3foNe
         hHGJo0DH1S2RadeWwjyGGjkQQPerVmjCozhFBsVLZAUmsJXZW5caf/eoL+6dTaMqxKpd
         mHsAvhnCEjFjXdogBcJOJJD0ZIGNKJMkWaPv8GkPGLQ2CdJIoCKxvoqtpP5gnwT+ojGB
         elent+Q444sw1pb2Yq2L3dl3I5PMAGtp4URbsjMSjcBwD+n4jVbs5yj5Njxso//5tpCb
         SdptT/2+9LIOhbzMW3ZRpE3EoWx1Gdo+l4oF06mOzM89LEXYzKquea+SsPKFjN1x09mP
         Q/ug==
X-Gm-Message-State: AOJu0Yz0XhXei6/EJ5YfJG/xrt6II06eTARg+D8j77/E7g8lUfXGXHWE
	z/zAIicVgtkL9kpAlMtw14qYGlVDSZrGPwlbiudXhaTtADsma3Xq
X-Google-Smtp-Source: AGHT+IEgy65EbP6py6rz5ikA4+OBWxrA6CRGeW1iLiLTTD595r2Ic67amu7jX5sNlp1OuqovGmu6aw==
X-Received: by 2002:a05:6358:1203:b0:178:6e53:ed4a with SMTP id h3-20020a056358120300b001786e53ed4amr5349451rwi.8.1706651357374;
        Tue, 30 Jan 2024 13:49:17 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:16 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v9 00/19] Pass data lifetime information to SCSI disk devices
Date: Tue, 30 Jan 2024 13:48:26 -0800
Message-ID: <20240130214911.1863909-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Martin,

UFS vendors need the data lifetime information to achieve good performance.
Providing data lifetime information to UFS devices can result in up to 40%
lower write amplification. Hence this patch series that adds support in F2FS
and also in the block layer for data lifetime information. The SCSI disk (sd)
driver is modified such that it passes write hint information to SCSI devices
via the GROUP NUMBER field.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v8:
 - Removed the .apply_whint() function pointer member from struct
   file_operations.
 - Made this patch series compatible with 'sparse' via the following change:
+/* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
+#ifndef __CHECKER__
 static_assert(sizeof(enum rw_hint) == 1);
+#endif

Changes compared to v7:
 - As requested by Dave Chinner, changed one occurrence of
   file_inode(dio->iocb->ki_filp)->i_write_hint into inode->i_write_hint.
 - Modified the description of patch 03/19 since the patch that restores
   F_[GS]ET_FILE_RW_HINT has been removed.
 - Added Reviewed-by tags from v6 of this patch series and that were missing
   when v7 was posted.

Changes compared to v6:
 - Dropped patch "fs: Restore F_[GS]ET_FILE_RW_HINT support".

Changes compared to v5:
 - Added compile-time tests that compare the WRITE_LIFE_* and RWH_* constants.
 - Split the F_[GS]ET_RW_HINT handlers.
 - Removed the structure member kiocb.ki_hint again. Instead, copy the data
   lifetime information directly from struct file into a bio.
 - Together with Doug Gilbert, fixed multiple bugs in the scsi_debug patches.
   Added Doug's Tested-by.
 - Changed the type of "rscs:1" from bool into unsigned.
 - Added unit tests for the new SCSI protocol data structures.
 - Improved multiple patch descriptions.
 
Changes compared to v4:
 - Dropped the patch that renames the WRITE_LIFE_* constants.
 - Added a fix for an argument check in fcntl_rw_hint().
 - Reordered the patches that restore data lifetime support.
 - Included a fix for data lifetime support for buffered I/O to raw block
   devices.

Changes compared to v3:
 - Renamed the data lifetime constants (WRITE_LIFE_*).
 - Fixed a checkpatch complaint by changing "unsigned" into "unsigned int".
 - Rebased this patch series on top of kernel v6.7-rc1.
 
Changes compared to v2:
 - Instead of storing data lifetime information in bi_ioprio, introduce the
   new struct bio member bi_lifetime and also the struct request member
   'lifetime'.
 - Removed the bio_set_data_lifetime() and bio_get_data_lifetime() functions
   and replaced these with direct assignments.
 - Dropped all changes related to I/O priority.
 - Improved patch descriptions.

Changes compared to v1:
 - Use six bits from the ioprio field for data lifetime information. The
   bio->bi_write_hint / req->write_hint / iocb->ki_hint members that were
   introduced in v1 have been removed again.
 - The F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT fcntls have been removed.
 - In the SCSI disk (sd) driver, query the stream status and check the PERM bit.
 - The GET STREAM STATUS command has been implemented in the scsi_debug driver.

Bart Van Assche (19):
  fs: Fix rw_hint validation
  fs: Verify write lifetime constants at compile time
  fs: Split fcntl_rw_hint()
  fs: Move enum rw_hint into a new header file
  fs: Propagate write hints to the struct block_device inode
  block, fs: Restore the per-bio/request data lifetime fields
  fs/f2fs: Restore the whint_mode mount option
  fs/f2fs: Restore support for tracing data lifetimes
  scsi: core: Query the Block Limits Extension VPD page
  scsi: scsi_proto: Add structures and constants related to I/O groups
    and streams
  scsi: sd: Translate data lifetime information
  scsi: scsi_debug: Reduce code duplication
  scsi: scsi_debug: Support the block limits extension VPD page
  scsi: scsi_debug: Rework page code error handling
  scsi: scsi_debug: Rework subpage code error handling
  scsi: scsi_debug: Allocate the MODE SENSE response from the heap
  scsi: scsi_debug: Implement the IO Advice Hints Grouping mode page
  scsi: scsi_debug: Implement GET STREAM STATUS
  scsi: scsi_debug: Maintain write statistics per group number

 Documentation/filesystems/f2fs.rst |  70 +++++++
 block/bio.c                        |   2 +
 block/blk-crypto-fallback.c        |   1 +
 block/blk-merge.c                  |   8 +
 block/blk-mq.c                     |   2 +
 block/bounce.c                     |   1 +
 block/fops.c                       |   3 +
 drivers/scsi/Kconfig               |   5 +
 drivers/scsi/Makefile              |   2 +
 drivers/scsi/scsi.c                |   2 +
 drivers/scsi/scsi_debug.c          | 293 ++++++++++++++++++++++-------
 drivers/scsi/scsi_proto_test.c     |  56 ++++++
 drivers/scsi/scsi_sysfs.c          |  10 +
 drivers/scsi/sd.c                  | 111 ++++++++++-
 drivers/scsi/sd.h                  |   3 +
 fs/buffer.c                        |  12 +-
 fs/direct-io.c                     |   2 +
 fs/f2fs/data.c                     |   2 +
 fs/f2fs/f2fs.h                     |  10 +
 fs/f2fs/segment.c                  |  95 ++++++++++
 fs/f2fs/super.c                    |  32 +++-
 fs/fcntl.c                         |  64 ++++---
 fs/inode.c                         |   1 +
 fs/iomap/buffered-io.c             |   2 +
 fs/iomap/direct-io.c               |   1 +
 fs/mpage.c                         |   1 +
 include/linux/blk-mq.h             |   2 +
 include/linux/blk_types.h          |   2 +
 include/linux/fs.h                 |  16 +-
 include/linux/rw_hint.h            |  24 +++
 include/scsi/scsi_device.h         |   1 +
 include/scsi/scsi_proto.h          |  78 ++++++++
 include/trace/events/f2fs.h        |   6 +-
 33 files changed, 808 insertions(+), 112 deletions(-)
 create mode 100644 drivers/scsi/scsi_proto_test.c
 create mode 100644 include/linux/rw_hint.h


