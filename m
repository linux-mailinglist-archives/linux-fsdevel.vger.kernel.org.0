Return-Path: <linux-fsdevel+bounces-9713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF16584492D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AE328CAE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617FF38DD0;
	Wed, 31 Jan 2024 20:53:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00138DD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734387; cv=none; b=KPKp9vGMwc07hZdg+LsZl+oA1P+34ll8a9ikSDdbMjInbZg3PglSqKagrSi8dDxZgPIX3JOHF85KRHvzA5xBWR2TDNKeqv9fb633uH5O7xCaEOVmwAUGlmjoLOgpkG2LZk6mvuKCE8MufKvlcsfGC56I+fZp82f8+lHHhyeqoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734387; c=relaxed/simple;
	bh=bz+Ofo3xEZwJywK5rOnbrZ1l33DmWTz7R0m2o5GIOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rb+4vsbkgOCvCxDaHAgg7kHP3YN3Ruih0rjbM2bJXBniH+aiceaG5I7Vs3mDhpvw6rVHQN8BE1Eb7wjFcZTRQbwGoveDdn1A0HydrvwJt3uucnmJ3ASLZhNFD7zoxC2o/gWsFXS/n5Au/cT6RDrongCF2Nr6wvPW4HervKjeMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-295dd13fe0dso122520a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734385; x=1707339185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M2SO79B6y1YIfmRoEqIQZzJlB/zDx7WRLXIRFIp6W/E=;
        b=eraiVPDKy1CKY07mP/IdizbVM/wpVEkzwxHiNpwWOY+HeKLZn3SVrwUlS4tqEoqIQ4
         K6cEV/Nicact+g64EK1SyGYdCYh4YHbNjKZGEupkmEXY9/J2ufZGlHI0n8vMF0yOs6wa
         9xkMr5UG3T9KtA2IBbKDLK6wscHtCs/s4rJXRCAahoxHav0Hdd+1TatQ80iK2dxoJoO0
         QdahdFBjTfAYQ/+YYMsMB7x/efH7D1bgXrONAX640UM8hTuk+iv5doLMZucwmGx5ejTp
         Ze4V73Rqx30ThjnhQ+GdGD0z0dP64/pUOB6LSOesCRubyzQDSJyrXqSce5sxQaMUEgnb
         5q0Q==
X-Gm-Message-State: AOJu0Yy1ahoulR0aBqNzsYzJELEqLhZykC2Y9jO/PvjhzMazrJ5SrzXW
	3eD0QPXHIpoqbN+6xguFG9wujSqRrnVg+OB8vD+XmbDTHyK6Ptzn
X-Google-Smtp-Source: AGHT+IHmyil7+qFPSFKk6hdaChXBR06vYQytfT0QC7g8kx83DS6K8O8VVFHCqOPyUNezgvphdOi4YA==
X-Received: by 2002:a17:90b:3696:b0:295:20e:5d2 with SMTP id mj22-20020a17090b369600b00295020e05d2mr3235488pjb.10.1706734384667;
        Wed, 31 Jan 2024 12:53:04 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090ace8300b00295fb7e7b87sm855977pju.27.2024.01.31.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:53:04 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/6] Restore data lifetime support
Date: Wed, 31 Jan 2024 12:52:31 -0800
Message-ID: <20240131205237.3540210-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

UFS devices are widely used in mobile applications, e.g. in smartphones.
UFS vendors need data lifetime information to achieve good performance.
Providing data lifetime information to UFS devices can result in up to 40%
lower write amplification. Hence this patch series that restores the
bi_write_hint member in struct bio. After this patch series has been merged,
patches that implement data lifetime support in the SCSI disk (sd) driver
will be sent to the Linux kernel SCSI maintainer.

The following changes are included in this patch series:
 - Improvements for the F_GET_RW_HINT and F_SET_RW_HINT fcntls.
 - Move enum rw_hint into a new header file.
 - Support F_SET_RW_HINT for block devices to make it easy to test data
   lifetime support.
 - Restore the bio.bi_write_hint member and restore support in the VFS layer
   and also in the block layer for data lifetime information.

The shell script that has been used to test the patch series combined with
the SCSI patches is available at the end of this cover letter.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Bart Van Assche (6):
  fs: Fix rw_hint validation
  fs: Verify write lifetime constants at compile time
  fs: Split fcntl_rw_hint()
  fs: Move enum rw_hint into a new header file
  fs: Propagate write hints to the struct block_device inode
  block, fs: Restore the per-bio/request data lifetime fields

 block/bio.c                 |  2 ++
 block/blk-crypto-fallback.c |  1 +
 block/blk-merge.c           |  8 +++++
 block/blk-mq.c              |  2 ++
 block/bounce.c              |  1 +
 block/fops.c                |  3 ++
 fs/buffer.c                 | 12 ++++---
 fs/direct-io.c              |  2 ++
 fs/f2fs/f2fs.h              |  1 +
 fs/fcntl.c                  | 64 +++++++++++++++++++++++++------------
 fs/inode.c                  |  1 +
 fs/iomap/buffered-io.c      |  2 ++
 fs/iomap/direct-io.c        |  1 +
 fs/mpage.c                  |  1 +
 include/linux/blk-mq.h      |  2 ++
 include/linux/blk_types.h   |  2 ++
 include/linux/fs.h          | 16 ++--------
 include/linux/rw_hint.h     | 24 ++++++++++++++
 18 files changed, 106 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/rw_hint.h

This patch series, combined with the SCSI patches, has been tested with the
following shell script:

#!/bin/bash
# SPDX-License-Identifier: GPL-3.0+
# Copyright (C) 2022 Google LLC

. tests/zbd/rc
. common/null_blk
. common/scsi_debug

DESCRIPTION="test block write hint support"
QUICK=1

requires() {
	_have_fio
	_have_scsi_debug_group_number_stats
}

submit_io() {
	local stats_attr=/sys/bus/pseudo/drivers/scsi_debug/group_number_stats
	echo "$1 ($3)"
	echo "$*" >>"${FULL}"
	local direct_io=$2
	echo 0 > "${stats_attr}" &&
	local fio_args wh &&
	for wh in none short medium long extreme; do
		if [ "${direct_io}" = 0 ]; then
			sync
			echo 1 > /proc/sys/vm/drop_caches
		fi
		fio_args=(
			--bs=4K
			--buffer_pattern='"'"$wh"'"'
			--direct="${direct_io}"
			--disable_clat=1
			--disable_slat=1
			--end_fsync=$((1 - direct_io))
			--filename="${dev}"
			--group_reporting=1
			--gtod_reduce=1
			--ioengine="$3"
			--ioscheduler=none
			--name=whint_"$wh"
			--norandommap
			--rw=randwrite
			--size=4M
			--thread=1
			--write_hint="$wh"
		)
		echo "fio ${fio_args[*]}" >>"${FULL}" 2>&1
		fio "${fio_args[@]}" >>"${FULL}" 2>&1 || return $?
	done &&
	grep -v ' 0$' "${stats_attr}" >> "${FULL}"
	while read -r group count; do
		if [ "$count" -gt 0 ]; then echo "$group"; fi
	done < "${stats_attr}"
}

test() {
	echo "Running ${TEST_NAME}"

	local scsi_debug_params=(
		delay=0
		dev_size_mb=1024
		sector_size=4096
	)
	_init_scsi_debug "${scsi_debug_params[@]}" &&
	local dev="/dev/${SCSI_DEBUG_DEVICES[0]}" fail &&
	ls -ldi "${dev}" >>"${FULL}" &&
	submit_io "Direct I/O" 1 pvsync &&
	submit_io "Direct I/O" 1 libaio &&
	submit_io "Direct I/O" 1 io_uring &&
	submit_io "Buffered I/O" 0 pvsync ||
	fail=true

	_exit_scsi_debug

	if [ -z "$fail" ]; then
		echo "Test complete"
	else
		echo "Test failed"
		return 1
	fi
}

Expected output:

Running scsi/097
Direct I/O (pvsync)
1
2
3
4
5
Direct I/O (libaio)
1
2
3
4
5
Direct I/O (io_uring)
1
2
3
4
5
Buffered I/O (pvsync)
1
2
3
4
5
Test complete

