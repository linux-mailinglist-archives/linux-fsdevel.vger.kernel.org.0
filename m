Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88C234DD8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 01:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGaXCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 19:02:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50860 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaXCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:02:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VMvUaj003670;
        Fri, 31 Jul 2020 23:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Ysn7B1AJN6hApgHtkqVJAM9nKKIap1U+4nGN5nEJsQc=;
 b=B3QoGt/EoLaLDGBx76tbmKAeBH/L+O78iqdH0B0p9B0d0usiDpznoBbslJUSWogzFWPd
 EBdXpBECeKtI6qgMW85E2xHAo14maIE1AI4Z4S/hrqe7NaWWzEg6aJ7eR7dKVr3u8zLE
 8wF60SVfRa+UHNJybHhNdzO/6CGs5CWs+RxFKR++zdQDf8689/x6mK2wW4o3PeXj6eZq
 299BLzZD7FAJyUdH/XZtZUSNyphmW4F0/AN1kh8wmEcZM8QETFCPUgBhm95AR/kVV+T4
 k5xH4hqP3ies9HVNdwGU759MDQIWrdH0JiapTtbT3NMBwaUWsDJzvwxzOgwdG5DdvWZD lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32hu1jujua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 23:02:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VMqj8N046635;
        Fri, 31 Jul 2020 23:02:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32mf715gcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 23:02:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VN27ia008571;
        Fri, 31 Jul 2020 23:02:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 16:02:06 -0700
Date:   Fri, 31 Jul 2020 16:02:06 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.9-merge updated to 66143873c6a0
Message-ID: <20200731230206.GA67805@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=2 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310163
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.9-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  This was one last rebase to pick up a few more late
reviews on the head commit in the branch.

The new head of the iomap-5.9-merge branch is commit:

66143873c6a0 iomap: fall back to buffered writes for invalidation failures

New Commits:

Andreas Gruenbacher (1):
      [d1b4f507d71d] iomap: Make sure iomap_end is called after iomap_begin

Christoph Hellwig (2):
      [00dccd7bf406] xfs: use ENOTBLK for direct I/O to buffered I/O fallback
      [66143873c6a0] iomap: fall back to buffered writes for invalidation failures

Dave Chinner (1):
      [6fa1c383e783] iomap: Only invalidate page cache pages on direct IO writes


Code Diffstat:

 fs/ext4/file.c       |  2 ++
 fs/gfs2/file.c       |  3 ++-
 fs/iomap/apply.c     | 13 +++++++++----
 fs/iomap/direct-io.c | 37 +++++++++++++++++++++----------------
 fs/iomap/trace.h     |  1 +
 fs/xfs/xfs_file.c    |  8 ++++----
 fs/zonefs/super.c    |  7 +++++--
 7 files changed, 44 insertions(+), 27 deletions(-)
