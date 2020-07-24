Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD222CAD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 18:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXQUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 12:20:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXQUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:20:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OGDR6r066731;
        Fri, 24 Jul 2020 16:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=gsr+vWVs/KQ7EOATjgJv17+sA8w6+4lLcvRvINDuemk=;
 b=nrDrSg8xpV/TPsl+qV0r083eSeEGEhkzhHu9zaDyi0PIstRrYMIYBTc5H+6IJ5mftfIZ
 n77gnJ2B/CXIHb37dOBZHez12LU7ByzA1knuMo7qgPNLqO2Q4EMcku54hMg3TUqxOtKb
 9Km11XHhoM5sRPDFxTci/Ui/P+O3agEKnJ/3nc18Gnv9BbVlfwqO7oM2qBJPH5d2S3Qv
 t9kNT2U8gYtF1SNOd7HGcH2u29wZn8HeTFMeIrVhfWyUtx7qG3376KSt9+hGom8efj8b
 G9FhKTGpH4lIH93ILXxgALJ+MbG1GyV1jZditG0CMKfF3W/cJiCTkviVZeeUWAdWBgIN Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32bs1n004g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 16:19:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OG4OhW058171;
        Fri, 24 Jul 2020 16:19:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32fswssurg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 16:19:56 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OGJuKC004419;
        Fri, 24 Jul 2020 16:19:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 09:19:55 -0700
Date:   Fri, 24 Jul 2020 09:19:55 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 979045f83ced
Message-ID: <20200724161955.GV3151642@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240127
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
the next update (bug fixes for 5.9, new features for 5.10).

This is later in the week than I was hoping, but I'm also recovering
from wrenching my back a few day ago. :(

The new head of the iomap-for-next branch is commit:

979045f83ced iomap: fall back to buffered writes for invalidation failures

New Commits:

Andreas Gruenbacher (1):
      [d1b4f507d71d] iomap: Make sure iomap_end is called after iomap_begin

Christoph Hellwig (2):
      [00dccd7bf406] xfs: use ENOTBLK for direct I/O to buffered I/O fallback
      [979045f83ced] iomap: fall back to buffered writes for invalidation failures

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
