Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B522AF71C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 18:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgKKRDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 12:03:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58134 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKKRDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:03:40 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABGs11E118551;
        Wed, 11 Nov 2020 17:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=1J5K2D5KU7KesGW1tW4a1Qv5PHiX7vdapnhjq1yb2dI=;
 b=dHIyCkRYUahnGcfdx3bLEPWe9jsvfiWPQ5G6QS33t8/9N+0BlLhHhPsni+fhdVghkNsJ
 IiFVxf4VxfCSuHQbVsj3MYv4MMGbIPSVr1Ht0k3rKfbpw5ynMMHOdHiB19wBgGSJXc6K
 puhRe9cBbvzU0Yp43WD44nTkyxmBpeQi40eccq1OiEfIYZGxnynlqSCdKF/eTZ191AGJ
 6da4doufRoYWgpMey03iCSwt96WDQquKYrYZWvxW7jXTuI+YZF22he4tb/f2t5jqPHMN
 bRF/5ObDq5SrCppiqabLwBip1f9alRvhQAZtgVf6Gd9dBSuKQe3vfxovfR1gglaT2CbZ dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34nh3b22qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 17:03:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABH0Cnm090381;
        Wed, 11 Nov 2020 17:01:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34p5gym8nv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 17:01:33 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ABH1Wf8022486;
        Wed, 11 Nov 2020 17:01:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 09:01:32 -0800
Date:   Wed, 11 Nov 2020 09:01:31 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     jack@suse.cz, hch@lst.de
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to 9b8523423b23
Message-ID: <20201111170131.GR9695@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110100
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  This is a short branch fixing the fs freeze locking
races that we were discussing earlier this week.  I haven't decided if I
really want to send the code cleanups for 5.10 (-fixes-2) but the first
tag (-fixes-1) solves some real corruption problems.

The new head of the vfs-for-next branch is commit:

9b8523423b23 vfs: move __sb_{start,end}_write* to fs.h

New Commits:

Darrick J. Wong (3):
      [22843291efc9] vfs: remove lockdep bogosity in __sb_start_write
      [8a3c84b649b0] vfs: separate __sb_start_write into blocking and non-blocking helpers
      [9b8523423b23] vfs: move __sb_{start,end}_write* to fs.h


Code Diffstat:

 fs/aio.c           |  2 +-
 fs/io_uring.c      |  3 +--
 fs/super.c         | 49 -------------------------------------------------
 include/linux/fs.h | 38 +++++++++++++++++++++++++++-----------
 4 files changed, 29 insertions(+), 63 deletions(-)
