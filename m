Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1715C47F724
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Dec 2021 15:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhLZOes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Dec 2021 09:34:48 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:63671 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229924AbhLZOes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Dec 2021 09:34:48 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A/+wqsq6lfzFmvSpppo7iowxRtFPGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0jMPmjMXWm+PbveLM2KkLtpwYYnlpBwCuZOAmtU3HVQ5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvRH+CmVra?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCni75fDkxCun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVBPBgQ9bcQqHO5NZdx?=
 =?us-ascii?q?x8xgNxDGbDVYM9xQTZtcxPGbDVMN00RBZZ4m/2n7lH7cjtFuBeQoII0/WHYz0p?=
 =?us-ascii?q?2yreFGNzLdt2PQO1Rn12EvSTC/mLkElcWOcL34TiM9H/qje/StSThUYkWGfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTRMNWValrP2RlEGzQZRcJlYS9y5oqrI9nGSvT9/gT1i7rWSCsxo?=
 =?us-ascii?q?0RdVdCas55RuLx66S5ByWbkAATzhceJk2utQeWzMnzBmKksnvCDgpt6eaIU9xX?=
 =?us-ascii?q?J/8QSiaYHBTdDFdI3RfC1Zt3jUqm6lr5jqnczqpOPfdYgXJJAzN?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AXO9SV6+gxX3MbzwR2Rpuk+AwI+orL9Y04lQ7?=
 =?us-ascii?q?vn2YSXRuHPBw8Pre+MjztCWE7wr5N0tBpTntAsW9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PCRuxfBODZogEIdReQygck79YDT0FhMqyKMXFKydb9/BKjE8sthP2O8KWTj+/Y?=
 =?us-ascii?q?yHt3JDsaEp1I3kNoDBqBCE1qSE1jDZo9LpCV4c1KvH6OYnISB/7LfkUtbqzSoc?=
 =?us-ascii?q?HRjpL6bVojDx4j0gOHijSl8/rbPnGjr3Ejbw8=3D?=
X-IronPort-AV: E=Sophos;i="5.88,237,1635177600"; 
   d="scan'208";a="119563845"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Dec 2021 22:34:45 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 110FB4D13BFD;
        Sun, 26 Dec 2021 22:34:41 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Dec 2021 22:34:39 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 26 Dec 2021 22:34:38 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v9 00/10] fsdax: introduce fs query to support reflink
Date:   Sun, 26 Dec 2021 22:34:29 +0800
Message-ID: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 110FB4D13BFD.A4C06
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is aimed to support shared pages tracking for fsdax.

Changes from V8 Resend:
  - Fix usage of dax write/read lock
  - Remove fsdax/xfs register/unregister wrappers
  - Move unrelated fixes into separate patchset
  - Fix code style

Changes from V8:
  - Rebased to "decouple DAX from block devices v2"
  - Patch8(implementation in XFS): Separate dax part to Patch7
  - Patch9: add FS_DAX_MAPPING_COW flag to distinguish CoW with normal

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
|  |    xfs_dax_failure_fn()
|  |    * corrupted on metadata
|  |       try to recover data, call xfs_force_shutdown()
|  |    * corrupted on file data
|  |       try to recover data, call mf_dax_kill_procs()
|* normal case
|-------------
|mf_generic_kill_procs()

==
Shiyang Ruan (10):
  dax: Use percpu rwsem for dax_{read,write}_lock()
  dax: Introduce holder for dax_device
  mm: factor helpers for memory_failure_dev_pagemap
  pagemap,pmem: Introduce ->memory_failure()
  fsdax: fix function description
  fsdax: Introduce dax_lock_mapping_entry()
  mm: move pgoff_address() to vma_pgoff_address()
  mm: Introduce mf_dax_kill_procs() for fsdax case
  xfs: Implement ->notify_failure() for XFS
  fsdax: set a CoW flag when associate reflink mappings

 drivers/dax/device.c        |  11 +-
 drivers/dax/super.c         | 104 ++++++++++++++--
 drivers/md/dm-writecache.c  |   7 +-
 drivers/nvdimm/pmem.c       |  16 +++
 fs/dax.c                    | 174 +++++++++++++++++++++------
 fs/fuse/dax.c               |   6 +-
 fs/xfs/Makefile             |   1 +
 fs/xfs/xfs_buf.c            |  15 +++
 fs/xfs/xfs_fsops.c          |   3 +
 fs/xfs/xfs_mount.h          |   1 +
 fs/xfs/xfs_notify_failure.c | 189 +++++++++++++++++++++++++++++
 fs/xfs/xfs_notify_failure.h |  10 ++
 include/linux/dax.h         |  63 +++++++++-
 include/linux/memremap.h    |   9 ++
 include/linux/mm.h          |  15 +++
 mm/memory-failure.c         | 232 +++++++++++++++++++++++++-----------
 16 files changed, 719 insertions(+), 137 deletions(-)
 create mode 100644 fs/xfs/xfs_notify_failure.c
 create mode 100644 fs/xfs/xfs_notify_failure.h

-- 
2.34.1



