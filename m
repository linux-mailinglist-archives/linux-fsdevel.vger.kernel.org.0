Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB2440EFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 16:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhJaPXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 11:23:15 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24352 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229838AbhJaPXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:23:14 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AaZa+X6BTL0XmRBVW/0Liw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBgnv1Gsm0DwGm2RLXj3XPvuLZGD8Ld1/aYqz9x4FucSAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkERcwmj/3auK49CEnjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPMYp+CWfyHXXcu7iheun2HX6/lnEkA6FYMC/eNwG2t?=
 =?us-ascii?q?P6boTLzVlRhCIh8q3xryhQ+Vhj8hlK9PkVKsTs3cmz3fGDPIiQJnGWI3L48NV2?=
 =?us-ascii?q?HE7gcUmNfrceM0fZhJsYQ7GbhkJPU0YYLo6neG1ljz6dhVbtluepuww+We75Ap?=
 =?us-ascii?q?v3LnoNfLRe8eWXoNRn0CFtiTK8nqRKhMTMtHZwjqY2nW2j+TLkGXwX4d6PLm58?=
 =?us-ascii?q?ON6xVOIymENBRk+S1S2u7+6h1S4VtYZLFYbkgIqrK4v5AmoQ8P7UhmQvnGJpFg?=
 =?us-ascii?q?fVsBWHul87xuCooLQ4gCEFi0UQCVpdtMrrok1SCYs21vPmMnmbQGDGpX9pWm1r?=
 =?us-ascii?q?+/S9G3tf3NOazJqWMPNdiNdi/GLnW35pkunog5fLZOI?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKVah96PMLSKxg8BcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631548800"; 
   d="scan'208";a="116677961"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2021 23:20:41 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C4B004D0DC6D;
        Sun, 31 Oct 2021 23:20:35 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:20:34 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:20:36 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 31 Oct 2021 23:20:33 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 0/8] fsdax: introduce fs query to support reflink
Date:   Sun, 31 Oct 2021 23:20:20 +0800
Message-ID: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C4B004D0DC6D.A123B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is aimed to support shared pages tracking for fsdax.

Changes from V7:
  - Change dax lock from global rwsem to per-device percpu_rwsem
  - Change type of range length from size_t to u64
  - Rename 'flags' to 'mf_flags'
  - Fix mistakes in XFS code
  - Add cow branch for dax_assocaite_entry()
  - Rebased to v5.15-rc7

This patchset moves owner tracking from dax_assocaite_entry() to pmem
device driver, by introducing an interface ->memory_failure() for struct
pagemap.  This interface is called by memory_failure() in mm, and
implemented by pmem device.

Then call holder operations to find the filesystem which the corrupted
data located in, and call filesystem handler to track files or metadata
associated with this page.

Finally we are able to try to fix the corrupted data in filesystem and
do other necessary processing, such as killing processes who are using
the files affected.

The call trace is like this:
memory_failure()
|* fsdax case
|------------
|pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
| dax_holder_notify_failure()      =>
|  dax_device->holder_ops->notify_failure() =>
|                                     - xfs_dax_notify_failure()
|  |* xfs_dax_notify_failure()
|  |--------------------------
|  |   xfs_rmap_query_range()
|  |    xfs_dax_notify_failure_fn()
|  |    * corrupted on metadata
|  |       try to recover data, call xfs_force_shutdown()
|  |    * corrupted on file data
|  |       try to recover data, call mf_dax_kill_procs()
|* normal case
|-------------
 mf_generic_kill_procs()

The fsdax & reflink support for XFS is not contained in this patchset.

(Rebased on v5.15-rc7)
==
Shiyang Ruan (8):
  dax: Use rwsem for dax_{read,write}_lock()
  dax: Introduce holder for dax_device
  mm: factor helpers for memory_failure_dev_pagemap
  pagemap,pmem: Introduce ->memory_failure()
  fsdax: Introduce dax_lock_mapping_entry()
  mm: Introduce mf_dax_kill_procs() for fsdax case
  xfs: Implement ->notify_failure() for XFS
  fsdax: add exception for reflinked files

 drivers/dax/device.c       |  11 +-
 drivers/dax/super.c        | 131 +++++++++++++++++----
 drivers/md/dm-writecache.c |   7 +-
 drivers/nvdimm/pmem.c      |  11 ++
 fs/dax.c                   | 140 +++++++++++++++++------
 fs/xfs/xfs_fsops.c         |   3 +
 fs/xfs/xfs_mount.h         |   1 +
 fs/xfs/xfs_super.c         | 207 +++++++++++++++++++++++++++++++++
 include/linux/dax.h        |  76 ++++++++++++-
 include/linux/memremap.h   |   9 ++
 include/linux/mm.h         |   2 +
 mm/memory-failure.c        | 226 ++++++++++++++++++++++++++-----------
 12 files changed, 687 insertions(+), 137 deletions(-)

-- 
2.33.0



