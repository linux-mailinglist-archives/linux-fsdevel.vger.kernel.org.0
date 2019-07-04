Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7410E5FA80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 17:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGDPDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 11:03:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33516 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfGDPDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:03:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64EwxYK062120;
        Thu, 4 Jul 2019 15:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=m9zOiaZ6RGBsOAj4Llb6iyw+aAk7VcW0sg3VM08shQI=;
 b=M5sUpz5q+2ZMPfVs2HKlaJBv9ZTMuRWzcUeDjbqODn9JPnN+XoyJshkMBZ4qc97CDycN
 TrhqKoeE+ZGUFK9v1Hf8oy4aNV+T5TrLTqowOVQjV+RJCFGH94CpYyr4x1ramdO/Geui
 QtW+PIAIJzZ/NzaIEtZ0S/kxUVqSdsULNMrOVMQPdydBBH1PXpOzJEAZ82ky4gVkpYIF
 dYYV2FKGnCd1qZIVrFMUcnVpzfB6QonC8Yqdnnobj+oUDD0ex7m8O8OiB70B107w/gNx
 g8ROaEjab1OY22jK5lcQMW5OdEUtemSOaEGyHHEdYwZQW/+9IFWT8onnCMVgcGCcG44u 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2te61q7abv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:02:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64F2wG1183576;
        Thu, 4 Jul 2019 15:02:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2th9ec0xcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:02:58 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x64F2vXs011526;
        Thu, 4 Jul 2019 15:02:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 08:02:57 -0700
Date:   Thu, 4 Jul 2019 08:02:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to 7e328e5930ad
Message-ID: <20190704150258.GA1404256@magnolia>
References: <20190701160656.GM1404256@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701160656.GM1404256@magnolia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040190
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040189
Sender: linux-fsdevel-owner@vger.kernel.org
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
the next update.  This is a resend of an earlier announcement about the
SETFLAGS and FSSETXATTR refactoring that I've started for 5.3 and will
continue for 5.4 so that these ioctls will have more consistent
behavior with the filesystems that originally created them.

The new head of the vfs-for-next branch is commit:

7e328e5930ad mm/fs: don't allow writes to immutable files

New Commits:

Darrick J. Wong (6):
      [5aca284210ce] vfs: create a generic checking and prep function for FS_IOC_SETFLAGS
      [7b0e492e6b80] vfs: create a generic checking function for FS_IOC_FSSETXATTR
      [f991492ed110] vfs: teach vfs_ioc_fssetxattr_check to check project id info
      [ca29be753445] vfs: teach vfs_ioc_fssetxattr_check to check extent size hints
      [dbc77f31e58b] vfs: only allow FSSETXATTR to set DAX flag on files and dirs
      [7e328e5930ad] mm/fs: don't allow writes to immutable files


Code Diffstat:

 fs/attr.c           |  13 ++---
 fs/btrfs/ioctl.c    |  30 ++++------
 fs/efivarfs/file.c  |  26 ++++++---
 fs/ext2/ioctl.c     |  16 ++----
 fs/ext4/ioctl.c     |  51 +++++------------
 fs/gfs2/file.c      |  42 +++++++++-----
 fs/hfsplus/ioctl.c  |  21 ++++---
 fs/inode.c          |  86 +++++++++++++++++++++++++++++
 fs/jfs/ioctl.c      |  22 +++-----
 fs/nilfs2/ioctl.c   |   9 +--
 fs/ocfs2/ioctl.c    |  13 +----
 fs/orangefs/file.c  |  37 ++++++++++---
 fs/reiserfs/ioctl.c |  10 ++--
 fs/ubifs/ioctl.c    |  13 +----
 fs/xfs/xfs_ioctl.c  | 154 +++++++++++++++++++++++-----------------------------
 include/linux/fs.h  |  12 ++++
 mm/filemap.c        |   3 +
 mm/memory.c         |   4 ++
 mm/mmap.c           |   8 ++-
 19 files changed, 319 insertions(+), 251 deletions(-)
