Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563F3B7E4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 17:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbfISPha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 11:37:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36876 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389840AbfISPh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:37:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JFYNm7169221;
        Thu, 19 Sep 2019 15:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=obEEcpkxDZO71S8QQtANUQvd5KQ7MwnRCTs6RGHNVmc=;
 b=NcRipYIdMiKA8lxT6p+v77B/Noi+X5FraDPe44Pb9OoyVnXYca90Rxswm17heSCeezfP
 c/cUL9zye8uaHNYaYHyAK3+YLzZfRQY635lUSQCXIMLJDpxglWIkzkemUUkkMmO0JQIn
 DITtnjNS1wpmypisLta91k2GH3+i2ZOXUAVQ1+WbFGy4Sf0dNjoJHXZqKS5h2tLxDJFU
 pgWvyaX+azU+ezLpi/pd52cpgxLd4xqpdnORwnoWU1ZauQjECBstI19guv+Lof07Xvhc
 HOQHNoK3XR6J/mT4WsnD1konFm5niEgZkw5FPWi+W9iGEu1fL3cwnem2yFGAba70tq08 yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v3vb54vwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 15:37:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JFCgkT006634;
        Thu, 19 Sep 2019 15:37:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2v3vbsar8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 15:37:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8JFb612008663;
        Thu, 19 Sep 2019 15:37:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 15:37:06 +0000
Date:   Thu, 19 Sep 2019 08:37:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Message-ID: <20190919153704.GK2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190144
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.4-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.  This is a rebase to remove the list_pop bits
that killed the previous pull request.  I removed patches 1 and 9 from
the branch and made the following modifications to patch #2:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 051b8ec326ba..558d09bc5024 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1156,10 +1156,11 @@ void
 iomap_finish_ioends(struct iomap_ioend *ioend, int error)
 {
 	struct list_head tmp;
+	struct iomap_ioend *next;
 
 	list_replace_init(&ioend->io_list, &tmp);
 	iomap_finish_ioend(ioend, error);
-	while ((ioend = list_pop_entry(&tmp, struct iomap_ioend, io_list)))
+	list_for_each_entry_safe(ioend, next, &tmp, io_list)
 		iomap_finish_ioend(ioend, error);
 }
 EXPORT_SYMBOL_GPL(iomap_finish_ioends);

I'm not thrilled to be rebasing a work branch in the middle of the merge
window, but I think the changes are simple enough that we might be able
to try again next week.  Damien, if you have the time can you please
rebase zonefs atop this and make sure buffered writing to a conventional
zone still works?  It should, since the _finish_ioends loop is identical
between iomap and xfs.

The new head of the iomap-5.4-merge branch is commit:

1b4fdf4f30db iomap: move the iomap_dio_rw ->end_io callback into a structure

New Commits:

Andreas Gruenbacher (1):
      [be942954d7ad] iomap: Fix trivial typo

Christoph Hellwig (7):
      [9544e58e466f] iomap: copy the xfs writeback code to iomap.c
      [668931192d9d] iomap: add tracing for the address space operations
      [ca6de3a5b6f4] iomap: warn on inline maps in iomap_writepage_map
      [4df389276768] xfs: set IOMAP_F_NEW more carefully
      [5f1f62a3f64c] iomap: zero newly allocated mapped blocks
      [0b98e70d9586] xfs: initialize iomap->flags in xfs_bmbt_to_iomap
      [1b4fdf4f30db] iomap: move the iomap_dio_rw ->end_io callback into a structure

Matthew Bobrowski (1):
      [da078883a85d] iomap: split size and error for iomap_dio_rw ->end_io

Randy Dunlap (1):
      [239b92845737] tracing: fix iomap.h build warnings


Code Diffstat:

 fs/iomap/buffered-io.c       | 576 ++++++++++++++++++++++++++++++++++++++++++-
 fs/iomap/direct-io.c         |  24 +-
 fs/xfs/xfs_file.c            |  14 +-
 fs/xfs/xfs_iomap.c           |  35 ++-
 fs/xfs/xfs_iomap.h           |   2 +-
 fs/xfs/xfs_pnfs.c            |   2 +-
 include/linux/iomap.h        |  53 +++-
 include/trace/events/iomap.h |  87 +++++++
 8 files changed, 754 insertions(+), 39 deletions(-)
 create mode 100644 include/trace/events/iomap.h
