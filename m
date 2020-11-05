Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2661E2A7524
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 02:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgKEB7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 20:59:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58034 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKEB7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:59:08 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A51uveW179606;
        Thu, 5 Nov 2020 01:59:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=aVWVXgsAgH2PBET9Poxk8LzSKFGVzRwTpWTdi/jyszQ=;
 b=fUvsZ0xArxp4r0f4dkZ0uZLb/8A52T2PdFwBs+Ar81BydtGi+cWJocsal2JG45M7HqUi
 sPkHHkr5M5ETqQLukedGdn/h6dRg1S9j3WINyIkiv42RyYZPDel+H4pm9agYd3MX7+O9
 tg9ZmkB/ksWn3mJlZLEUJ7OxjvQPeEsUUKr0zUNLg9H6Tpt/sAv0by6KECgncwuxYCfM
 wlhj4CQMgj1n22jZzXWO3xJGp/JN2xswJOYT2IMRfLCqJOQip0vYjYeBQeFq5vGyku03
 52/jwYzFiRhoHWejW6KXuBzvctbsXzYhInKSg/7cZP3G1L2AM6wLteUwyofDUkrTcHGa jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 34hhw2spyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 05 Nov 2020 01:59:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A51tnxU053548;
        Thu, 5 Nov 2020 01:59:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 34hvrys1rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Nov 2020 01:59:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A51x5Lx004639;
        Thu, 5 Nov 2020 01:59:05 GMT
Received: from localhost (/10.159.129.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 17:59:05 -0800
Date:   Wed, 4 Nov 2020 17:59:04 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs/iomap: for-next updated to 46afb0628b86
Message-ID: <20201105015904.GO7123@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=7 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=7 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050015
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  I'm still churning through bug fixes for 5.10, and
sending this to both lists because there's a couple of iomap fixes that
go along with the xfs fixes.

The new head of the for-next branch is commit:

46afb0628b86 xfs: only flush the unshared range in xfs_reflink_unshare

New Commits:

Brian Foster (3):
      [869ae85dae64] xfs: flush new eof page on truncate to avoid post-eof corruption
      [763e4cdc0f6d] iomap: support partial page discard on writeback block mapping failure
      [50e7d6c7a521] iomap: clean up writeback state logic on writepage error

Darrick J. Wong (4):
      [2c334e12f957] xfs: set xefi_discard when creating a deferred agfl free log intent item
      [c2f09217a430] xfs: fix missing CoW blocks writeback conversion retry
      [c1f6b1ac0075] xfs: fix scrub flagging rtinherit even if there is no rt device
      [46afb0628b86] xfs: only flush the unshared range in xfs_reflink_unshare


Code Diffstat:

 fs/iomap/buffered-io.c    | 30 ++++++++++--------------------
 fs/xfs/libxfs/xfs_alloc.c |  1 +
 fs/xfs/libxfs/xfs_bmap.h  |  2 +-
 fs/xfs/scrub/inode.c      |  3 +--
 fs/xfs/xfs_aops.c         | 20 ++++++++++++--------
 fs/xfs/xfs_iops.c         | 10 ++++++++++
 fs/xfs/xfs_reflink.c      |  3 ++-
 include/linux/iomap.h     |  2 +-
 8 files changed, 38 insertions(+), 33 deletions(-)
