Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D6C4D47B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiCJNJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 08:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiCJNJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:09:16 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 006082676;
        Thu, 10 Mar 2022 05:08:10 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AbGct16k6ZJOdBh3HQzXxEljo5gzqJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzVWnWIdWGiDPv+NZDb9eohybtm08EJQ7Z/Wz98wG1Y4+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCLl7JXCkBGbG5fr67A0ZK0sBqUU8/h2DUl?=
 =?us-ascii?q?A7/sdLyoHbwzFjOWzqJq7QelEh8ItNsDnMYoT/HZ6wlnxAf8gB5KFXKTO4d5R2?=
 =?us-ascii?q?SwYh8ZSEPKYbM0cARJjbgvHZRJnOVoNDp862uCyiRHXdzxetULQoK8f4Hbaxw8?=
 =?us-ascii?q?316LiWPLTZNCLQMB9mkeDunmA+2X/HwFcONGBoRKH+3ShwOTPgAv8QosZELD+/?=
 =?us-ascii?q?flv6HWXx2oOGFgYTle2v/S9olCxVsgZKEEO/Ccq668o+ySDStj7Qg39o3OeuBM?=
 =?us-ascii?q?Yc8RfHvd86wyXzKfQpQGDCQAsSj9HdcxjpMEtbSIl20XPnN7zAzFr9rqPRhqgG?=
 =?us-ascii?q?h28xd+pEXFNazZcOmlfFk1Yi+QPabob1nrnJuuP2obs5jEtJQzN/g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AJcrJXajzqPVrHXvE9rtHgn3h13BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122519745"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Mar 2022 21:08:09 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2552C4D169F3;
        Thu, 10 Mar 2022 21:08:09 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 10 Mar 2022 21:08:09 +0800
Received: from [10.167.201.6] (10.167.201.6) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 10 Mar 2022 21:08:08 +0800
Message-ID: <87ff591c-ac1c-4460-fc6a-ba2b86714472@fujitsu.com>
Date:   Thu, 10 Mar 2022 21:08:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v11 0/8] fsdax: introduce fs query to support reflink
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 2552C4D169F3.A1690
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping  ;)

在 2022/2/27 20:07, Shiyang Ruan 写道:
> This patchset is aimed to support shared pages tracking for fsdax.
> 
> Changes since V10:
>    - Use cmpxchg() to prevent concurrent registration/unregistration
>    - Use phys_addr_t for ->memory_failure()
>    - Add dax_entry_lock() for dax_lock_mapping_entry()
>    - Fix offset and length calculation at the boundary of a filesystem
> 
> This patchset moves owner tracking from dax_assocaite_entry() to pmem
> device driver, by introducing an interface ->memory_failure() for struct
> pagemap.  This interface is called by memory_failure() in mm, and
> implemented by pmem device.
> 
> Then call holder operations to find the filesystem which the corrupted
> data located in, and call filesystem handler to track files or metadata
> associated with this page.
> 
> Finally we are able to try to fix the corrupted data in filesystem and
> do other necessary processing, such as killing processes who are using
> the files affected.
> 
> The call trace is like this:
> memory_failure()
> |* fsdax case
> |------------
> |pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
> | dax_holder_notify_failure()      =>
> |  dax_device->holder_ops->notify_failure() =>
> |                                     - xfs_dax_notify_failure()
> |  |* xfs_dax_notify_failure()
> |  |--------------------------
> |  |   xfs_rmap_query_range()
> |  |    xfs_dax_failure_fn()
> |  |    * corrupted on metadata
> |  |       try to recover data, call xfs_force_shutdown()
> |  |    * corrupted on file data
> |  |       try to recover data, call mf_dax_kill_procs()
> |* normal case
> |-------------
> |mf_generic_kill_procs()
> 
> ==
> Shiyang Ruan (8):
>    dax: Introduce holder for dax_device
>    mm: factor helpers for memory_failure_dev_pagemap
>    pagemap,pmem: Introduce ->memory_failure()
>    fsdax: Introduce dax_lock_mapping_entry()
>    mm: move pgoff_address() to vma_pgoff_address()
>    mm: Introduce mf_dax_kill_procs() for fsdax case
>    xfs: Implement ->notify_failure() for XFS
>    fsdax: set a CoW flag when associate reflink mappings
> 
>   drivers/dax/super.c         |  89 +++++++++++++
>   drivers/nvdimm/pmem.c       |  16 +++
>   fs/dax.c                    | 140 ++++++++++++++++++---
>   fs/xfs/Makefile             |   1 +
>   fs/xfs/xfs_buf.c            |  12 ++
>   fs/xfs/xfs_fsops.c          |   3 +
>   fs/xfs/xfs_mount.h          |   1 +
>   fs/xfs/xfs_notify_failure.c | 235 +++++++++++++++++++++++++++++++++++
>   fs/xfs/xfs_notify_failure.h |  10 ++
>   fs/xfs/xfs_super.c          |   6 +
>   include/linux/dax.h         |  47 +++++++
>   include/linux/memremap.h    |  12 ++
>   include/linux/mm.h          |  17 +++
>   include/linux/page-flags.h  |   6 +
>   mm/memory-failure.c         | 240 ++++++++++++++++++++++++++----------
>   15 files changed, 747 insertions(+), 88 deletions(-)
>   create mode 100644 fs/xfs/xfs_notify_failure.c
>   create mode 100644 fs/xfs/xfs_notify_failure.h
> 


