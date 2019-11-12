Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14AF95E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 17:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKLQna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 11:43:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLQna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:43:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACGYGXq160560;
        Tue, 12 Nov 2019 16:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=YI8hTS055F4EgW/TI3R4fEBJd2vHSaZqvWwC9qPSlbk=;
 b=MkPiAXBgLTt2p+cnmLgfFG6rDG6EZgpWLT26qaG428gN6a9jdfjVP/7HkfskyBCJ4NAS
 Bdb10EJOYzdroxbXuqyxnFD9P19lvL0Sm0O78rpr6DUmRQjq5rnEQSjmH3UEpWk1BDY9
 DX8zC1gDgh1D+NSYw27p4aiAe4XvfI0pawsfVCyAzDCLUgmUjzyqsyeaIGgZUredHaRb
 /nZbir1JXUF8o63h2OxfvfsXXrqYZw1OoI+oheqgfPZ16T3ztsm/SGnb2EqKhViZC5ex
 RqQW/le0bMaCzlcHl1cr0vEQgY41Y1pgdxwATPp7wZ0D6jV/UMBinFDsnlFtT9/AcDUc hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w5ndq64hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 16:43:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACGc55o072247;
        Tue, 12 Nov 2019 16:43:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2w7khkkpcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 16:43:06 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xACGh3X9025264;
        Tue, 12 Nov 2019 16:43:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 08:43:03 -0800
Date:   Tue, 12 Nov 2019 08:43:02 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to e9f930ac88a8
Message-ID: <20191112164301.GF6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120141
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

The new head of the iomap-for-next branch is commit:

e9f930ac88a8 iomap: fix return value of iomap_dio_bio_actor on 32bit systems

New Commits:

Andreas Gruenbacher (1):
      [add66fcbd3fb] iomap: Fix overflow in iomap_page_mkwrite

Christoph Hellwig (20):
      [2492a606b3d2] xfs: initialize iomap->flags in xfs_bmbt_to_iomap
      [05b30949f1aa] xfs: set IOMAP_F_NEW more carefully
      [4e087a3b313c] xfs: use a struct iomap in xfs_writepage_ctx
      [433dad94ec5d] xfs: refactor the ioend merging code
      [5653017bc44e] xfs: turn io_append_trans into an io_private void pointer
      [760fea8bfb7f] xfs: remove the fork fields in the writepage_ctx and ioend
      [009d8d849d3f] iomap: zero newly allocated mapped blocks
      [9e91c5728cab] iomap: lift common tracing code from xfs to iomap
      [598ecfbaa742] iomap: lift the xfs writeback code to iomap
      [3e19e6f3eeea] iomap: warn on inline maps in iomap_writepage_map
      [ab08b01ec0a2] iomap: move struct iomap_page out of iomap.h
      [b3d423ec898a] iomap: cleanup iomap_ioend_compare
      [48d64cd18b33] iomap: pass a struct page to iomap_finish_page_writeback
      [65a60e8687c1] iomap: better document the IOMAP_F_* flags
      [c12d6fa88d09] iomap: remove the unused iomap argument to __iomap_write_end
      [dcd6158d15c7] iomap: always use AOP_FLAG_NOFS in iomap_write_begin
      [3590c4d8979b] iomap: ignore non-shared or non-data blocks in xfs_file_dirty
      [d3b404396977] iomap: move the zeroing case out of iomap_read_page_sync
      [32a38a499104] iomap: use write_begin to read pages to unshare
      [eb81cf9d0e18] iomap: renumber IOMAP_HOLE to 0

Darrick J. Wong (2):
      [9cd0ed63ca51] iomap: enhance writeback error message
      [2b91b28e29f6] iomap: iomap_bmap should check iomap_apply return value

Dave Chinner (1):
      [7684e2c4384d] iomap: iomap that extends beyond EOF should be marked dirty

Goldwyn Rodrigues (1):
      [c039b9979272] iomap: use a srcmap for a read-modify-write I/O

Jan Kara (2):
      [13ef954445df] iomap: Allow forcing of waiting for running DIO in iomap_dio_rw()
      [906753befc4d] xfs: Use iomap_dio_rw to wait for unaligned direct IO

Jan Stancek (1):
      [e9f930ac88a8] iomap: fix return value of iomap_dio_bio_actor on 32bit systems

Joseph Qi (1):
      [a90100421499] fs/iomap: remove redundant check in iomap_dio_rw()


Code Diffstat:

 fs/dax.c                 |  13 +-
 fs/ext2/inode.c          |   2 +-
 fs/ext4/inode.c          |   2 +-
 fs/gfs2/bmap.c           |   3 +-
 fs/gfs2/file.c           |   6 +-
 fs/iomap/Makefile        |  16 +-
 fs/iomap/apply.c         |  25 +-
 fs/iomap/buffered-io.c   | 756 +++++++++++++++++++++++++++++++++++++++++------
 fs/iomap/direct-io.c     |  15 +-
 fs/iomap/fiemap.c        |  10 +-
 fs/iomap/seek.c          |   4 +-
 fs/iomap/swapfile.c      |   3 +-
 fs/iomap/trace.c         |  12 +
 fs/iomap/trace.h         |  88 ++++++
 fs/xfs/libxfs/xfs_bmap.c |  14 +-
 fs/xfs/libxfs/xfs_bmap.h |   3 +-
 fs/xfs/xfs_aops.c        | 754 ++++++++--------------------------------------
 fs/xfs/xfs_aops.h        |  17 --
 fs/xfs/xfs_file.c        |  13 +-
 fs/xfs/xfs_iomap.c       |  51 +++-
 fs/xfs/xfs_iomap.h       |   2 +-
 fs/xfs/xfs_pnfs.c        |   2 +-
 fs/xfs/xfs_reflink.c     |   2 +-
 fs/xfs/xfs_super.c       |  11 +-
 fs/xfs/xfs_trace.h       |  65 ----
 include/linux/iomap.h    | 129 +++++---
 26 files changed, 1097 insertions(+), 921 deletions(-)
 create mode 100644 fs/iomap/trace.c
 create mode 100644 fs/iomap/trace.h
