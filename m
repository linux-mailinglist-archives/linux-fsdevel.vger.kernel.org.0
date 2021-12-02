Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D6465FD6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 09:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356254AbhLBIwd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 03:52:33 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24741 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1356241AbhLBIw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:52:29 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ALXqL0qlJ5BP5P7dvvAs162/o5gzqJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzwPz2IcUG6BbPmLazf1c9snOoXn9U5QvZPUnNBqHlFr+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYueJQUVUj/nSH+OmULS?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHv6pXClhWaG5fr67A0ZK0sBqUU8/h2DUl?=
 =?us-ascii?q?A7/sdLyoHbwzFjOWzqJq7QelEh8ItNsDnMYoT/HZ6wlnxAf8gB5KFXKTO4d5R2?=
 =?us-ascii?q?SwYh8ZSEPKYbM0cARJjbgvHZRJnOVoNDp862uCyiRHXdzxetULQoK8f4Hbaxw8?=
 =?us-ascii?q?316LiWPLTZNCLQMB9mkeDunmA+2X/HwFcONGBoRKH+3ShwOTPgAv8QosZELD+/?=
 =?us-ascii?q?flv6HWXx2oOGFgYTle2v/S9olCxVsgZKEEO/Ccq668o+ySDStj7Qg39o3OeuBM?=
 =?us-ascii?q?Yc8RfHvd86wyXzKfQpQGDCQAsSj9HdcxjpMEtbSIl20XPnN7zAzFr9rqPRhqgG?=
 =?us-ascii?q?h28xd+pEXFNazZcOmlfFk1Yi+QPabob1nrnJuuP2obv5jEtJQzN/g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfTq0Zq11/TLF874yE6mKAgqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="118319104"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Dec 2021 16:49:04 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id BBB024D13A13;
        Thu,  2 Dec 2021 16:49:00 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Dec 2021 16:49:01 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Dec 2021 16:48:58 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [RESEND PATCH v8 0/9] fsdax: introduce fs query to support reflink
Date:   Thu, 2 Dec 2021 16:48:47 +0800
Message-ID: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: BBB024D13A13.A0354
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is aimed to support shared pages tracking for fsdax.

Christoph has posted "decouple DAX from block devices v2", I need to
rebase to his tree.  And since my v8 patchset sent before hasn't been
reviewed yet.  So, I send this patchset as a RESEND of v8.

Changes from V8:
  - Rebased to "decouple DAX from block devices v2"
  - Patch8(implementation in XFS): Separate dax part to Patch7
  - Patch9: add FS_DAX_MAPPING_COW flag to distinguish CoW with normal

Changes from V7:
  - Change dax lock from global rwsem to per-device percpu_rwsem
  - Change type of range length from size_t to u64
  - Rename 'flags' to 'mf_flags'
  - Fix mistakes in XFS code
  - Add cow branch for dax_assocaite_entry()

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
|mf_generic_kill_procs()

==
Shiyang Ruan (9):
  dax: Use percpu rwsem for dax_{read,write}_lock()
  dax: Introduce holder for dax_device
  mm: factor helpers for memory_failure_dev_pagemap
  pagemap,pmem: Introduce ->memory_failure()
  fsdax: Introduce dax_lock_mapping_entry()
  mm: Introduce mf_dax_kill_procs() for fsdax case
  dax: add dax holder helper for filesystems
  xfs: Implement ->notify_failure() for XFS
  fsdax: set a CoW flag when associate reflink mappings

 drivers/dax/device.c        |  11 +-
 drivers/dax/super.c         | 120 ++++++++++++++++---
 drivers/md/dm-writecache.c  |   7 +-
 drivers/nvdimm/pmem.c       |  16 +++
 fs/dax.c                    | 172 +++++++++++++++++++++------
 fs/fuse/dax.c               |   6 +-
 fs/xfs/Makefile             |   1 +
 fs/xfs/xfs_buf.c            |   4 +
 fs/xfs/xfs_fsops.c          |   3 +
 fs/xfs/xfs_mount.h          |   1 +
 fs/xfs/xfs_notify_failure.c | 224 +++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.h |  15 +++
 include/linux/dax.h         |  73 +++++++++++-
 include/linux/memremap.h    |   9 ++
 include/linux/mm.h          |   2 +
 mm/memory-failure.c         | 226 +++++++++++++++++++++++++-----------
 16 files changed, 757 insertions(+), 133 deletions(-)
 create mode 100644 fs/xfs/xfs_notify_failure.c
 create mode 100644 fs/xfs/xfs_notify_failure.h

-- 
2.34.0



