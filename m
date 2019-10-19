Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 331DDDD5F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 03:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfJSB1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 21:27:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfJSB1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 21:27:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9J1PLDv026137;
        Sat, 19 Oct 2019 01:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=+eN2dHDKqzKzkek8Upk0U7xYgl91txQoJvCOcPqOmSQ=;
 b=THJsi6TwAS2Db0taHIc605mV/PwPgDinOuAQFDGrxwvd+qX1nu7j0sKSER2+DotlfM1x
 Q3W+ztw3Jq/nsSMiQW4VA6eOUqAiMxdEC46nXr5RZ1ZSuz13hEExJGpmyMGIWcy8viaD
 dmo9py6L3+WqibN2sLuFnTuqUuuML5NJmvMm2KvYepcWuv+Xc+LeW2F1JXIh09izxVtG
 dx8i+UR+kdt5mFpGEs5fJIEUNi6wOxpg0E97YQCGwL+h8M3vphAoVeuizjtbqttbt7fq
 O6DpmOCCehPwvuW1FqgX97XWC8laY9c1VpqnlzvVv/AzP+xkFHPutCUA+nya4m+JiblZ 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vq0q46r75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 01:26:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9J1MvfF107693;
        Sat, 19 Oct 2019 01:26:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vqqmgk9qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Oct 2019 01:26:49 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9J1QbXl010915;
        Sat, 19 Oct 2019 01:26:47 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 19 Oct 2019 01:26:37 +0000
Date:   Fri, 18 Oct 2019 18:26:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to b7b293bdaaf4
Message-ID: <20191019012635.GC6719@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910190009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910190009
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The branch now contains three major API changes for 5.5: Jan's explicit
synchronous iomap_dio_rw parameter; Christoph's porting of the xfs
writeback implementation to iomap; and Goldwyn/Christoph's addition of
srcmap support to iomap_begin for COW staging.  I think this is it for
5.5, modulo any bug fixes anyone wants to submit.  If anyone sees
anything bad enough to warrant a push -f, please scream quickly,
otherwise I'll consider this branch a stable working branch on 22 Oct
2019 at 00:00 UTC.  (Extra time because I'm sending this late on a
Friday afternoon.)

The new head of the iomap-for-next branch is commit:

b7b293bdaaf4 iomap: use a srcmap for a read-modify-write I/O

New Commits:

Christoph Hellwig (20):
      [5d816b81d09d] xfs: initialize iomap->flags in xfs_bmbt_to_iomap
      [34c8fe914a5c] xfs: set IOMAP_F_NEW more carefully
      [17950b4e5396] xfs: use a struct iomap in xfs_writepage_ctx
      [207e86dd487d] xfs: refactor the ioend merging code
      [be0bbd4c6859] xfs: turn io_append_trans into an io_private void pointer
      [b931cda62c8c] xfs: remove the fork fields in the writepage_ctx and ioend
      [786717533e97] iomap: zero newly allocated mapped blocks
      [f9208606ee98] iomap: lift common tracing code from xfs to iomap
      [21ae4d097bb2] iomap: lift the xfs writeback code to iomap
      [f0c130fd34f2] iomap: warn on inline maps in iomap_writepage_map
      [4e29ff8b6f00] iomap: move struct iomap_page out of iomap.h
      [e09ffca48f47] iomap: cleanup iomap_ioend_compare
      [1ccb2c4a5415] iomap: pass a struct page to iomap_finish_page_writeback
      [b28d0615b4ec] iomap: better document the IOMAP_F_* flags
      [f47fd1f1f5bd] iomap: remove the unused iomap argument to __iomap_write_end
      [0d84ea778c24] iomap: always use AOP_FLAG_NOFS in iomap_write_begin
      [213c6dfea828] iomap: ignore non-shared or non-data blocks in xfs_file_dirty
      [1c979fce8c91] iomap: move the zeroing case out of iomap_read_page_sync
      [c47007977d2e] iomap: use write_begin to read pages to unshare
      [37370b729fbd] iomap: renumber IOMAP_HOLE to 0

Darrick J. Wong (1):
      [a936fb253791] iomap: enhance writeback error message

Dave Chinner (1):
      [8a23414ee345] iomap: iomap that extends beyond EOF should be marked dirty

Goldwyn Rodrigues (1):
      [b7b293bdaaf4] iomap: use a srcmap for a read-modify-write I/O

Jan Kara (2):
      [13ef954445df] iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
      [906753befc4d] xfs: Use iomap_dio_rw to wait for unaligned direct IO


Code Diffstat:

 fs/dax.c                 |  13 +-
 fs/ext2/inode.c          |   2 +-
 fs/ext4/inode.c          |   2 +-
 fs/gfs2/bmap.c           |   3 +-
 fs/gfs2/file.c           |   6 +-
 fs/iomap/Makefile        |  16 +-
 fs/iomap/apply.c         |  25 +-
 fs/iomap/buffered-io.c   | 749 ++++++++++++++++++++++++++++++++++++++++------
 fs/iomap/direct-io.c     |   9 +-
 fs/iomap/fiemap.c        |   4 +-
 fs/iomap/seek.c          |   4 +-
 fs/iomap/swapfile.c      |   3 +-
 fs/iomap/trace.c         |  12 +
 fs/iomap/trace.h         |  88 ++++++
 fs/xfs/libxfs/xfs_bmap.c |  14 +-
 fs/xfs/libxfs/xfs_bmap.h |   3 +-
 fs/xfs/xfs_aops.c        | 754 ++++++++---------------------------------------
 fs/xfs/xfs_aops.h        |  17 --
 fs/xfs/xfs_file.c        |  13 +-
 fs/xfs/xfs_iomap.c       |  51 +++-
 fs/xfs/xfs_iomap.h       |   2 +-
 fs/xfs/xfs_pnfs.c        |   2 +-
 fs/xfs/xfs_reflink.c     |   2 +-
 fs/xfs/xfs_super.c       |  11 +-
 fs/xfs/xfs_trace.h       |  65 ----
 include/linux/iomap.h    | 129 +++++---
 26 files changed, 1085 insertions(+), 914 deletions(-)
 create mode 100644 fs/iomap/trace.c
 create mode 100644 fs/iomap/trace.h
