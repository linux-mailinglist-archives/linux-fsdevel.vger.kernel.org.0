Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B188027B187
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1QNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 12:13:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55664 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1QNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:13:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SG9xnM138186;
        Mon, 28 Sep 2020 16:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=XKbAmCgRVEE7BA91FReg9XoljXgcXvzoKZwGX8JZSVM=;
 b=H/7ciX/9DGNGijycA+6Ipvo6RUYAIUrg18tM+WVuRaJZ9eIrZnvwA45PRToW9C2hodnS
 XFezsxCGptoXtb4ZfcQi4UMewYHUL2gqriAjTHSVShz0hqEOsq7IAMauScr0aplBHE/L
 0XzOpEu+YSBbSBaXbUJ3qRY2Wr5PD8E9S7Y2lEvVyxeLi8U9rquXSHW5ib/vqeGn3pBT
 HzqWdODI/9F3dAYVPtWhaGEt6KlR74noXUrbs9WEkVYqtpfTKkZibIkFAkt/xegHffQa
 0e+mUtKvHM1FhDEIw+2i6ky+oUYB1+DTJsLEtSoVHh632GzFEvYguf92eKWwMpKR7qJu FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 33su5ap3ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 16:13:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08SGAll2154327;
        Mon, 28 Sep 2020 16:11:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33tf7khagh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Sep 2020 16:11:25 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08SGBJFt012954;
        Mon, 28 Sep 2020 16:11:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Sep 2020 09:11:18 -0700
Date:   Mon, 28 Sep 2020 09:11:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, rgoldwyn@suse.de
Subject: [ANNOUNCE] xfs-linux: iomap-5.10-merge updated to 1a31182edd00
Message-ID: <20200928161117.GA49524@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=2 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009280124
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.10-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  Hopefully this is it for 5.10...

The new head of the iomap-5.10-merge branch is commit:

1a31182edd00 iomap: Call inode_dio_end() before generic_write_sync()

New Commits:

Andreas Gruenbacher (1):
      [c114bbc6c423] iomap: Fix direct I/O write consistency check

Christoph Hellwig (1):
      [c3d4ed1abecf] iomap: Allow filesystem to call iomap_dio_complete without i_rwsem

Goldwyn Rodrigues (1):
      [1a31182edd00] iomap: Call inode_dio_end() before generic_write_sync()

Matthew Wilcox (Oracle) (12):
      [e6e7ca92623a] iomap: Clear page error before beginning a write
      [14284fedf59f] iomap: Mark read blocks uptodate in write_begin
      [7ed3cd1a69e3] iomap: Fix misplaced page flushing
      [24addd848a45] fs: Introduce i_blocks_per_page
      [a6901d4d148d] iomap: Use kzalloc to allocate iomap_page
      [b21866f514cb] iomap: Use bitmap ops to set uptodate bits
      [0a195b91e899] iomap: Support arbitrarily many blocks per page
      [7d636676d284] iomap: Convert read_count to read_bytes_pending
      [0fb2d7209d66] iomap: Convert write_count to write_bytes_pending
      [e25ba8cbfd16] iomap: Convert iomap_write_end types
      [81ee8e52a71c] iomap: Change calling convention for zeroing
      [4595a298d556] iomap: Set all uptodate bits for an Uptodate page

Nikolay Borisov (1):
      [6cc19c5fad09] iomap: Use round_down/round_up macros in __iomap_write_begin

Qian Cai (1):
      [a805c111650c] iomap: fix WARN_ON_ONCE() from unprivileged users


Code Diffstat:

 fs/dax.c                |  13 ++--
 fs/iomap/buffered-io.c  | 194 ++++++++++++++++++++----------------------------
 fs/iomap/direct-io.c    |  49 +++++++++---
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |   2 +-
 include/linux/dax.h     |   3 +-
 include/linux/iomap.h   |   5 ++
 include/linux/pagemap.h |  16 ++++
 8 files changed, 150 insertions(+), 134 deletions(-)
