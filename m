Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB45FAA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 17:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfGDPIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 11:08:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48028 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfGDPIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:08:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64F3Z8o054674;
        Thu, 4 Jul 2019 15:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=NerSHqkgECmmoe/b+//AoS3dONJv7y+iAkspLeXM4AM=;
 b=oEPoS0WhcRAg4le/eliMvJjiaKQkcf53SbVWJl81WOTkTiz0F9/b5keaazIIfsD2BpTp
 h9Y3r4QkkU1kOYrHYELbcThBkZhbO95gpOq0MB6KnkkTe8QYR/T4+/g9590emBWQ8KUa
 f/x0SjHNpQHiRm0sJEtg26luwKGMIR3niHamDAjGgqb9Oc5ArKkVBo37JbFG8CYT7E0X
 6vF2AdeR6JMxtevL4UWnpWrsd1SrCLjfNWPovnLtCZcqVP/f+KgW0sgbODC5Q1TowPWA
 YN3JKJCZpnXd0YRcn0JcN9pW9osEKmxkPz9a9ymWvng31idA+n+nu/Gib47jxB9zcuFx ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2te61ef9yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:07:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64F7gua078651;
        Thu, 4 Jul 2019 15:07:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2th5qmbchq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:07:57 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x64F7vwY010452;
        Thu, 4 Jul 2019 15:07:57 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 08:07:57 -0700
Date:   Thu, 4 Jul 2019 08:07:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [ANNOUNCE RESEND] xfs-linux: vfs-for-next updated to 7e328e5930ad
Message-ID: <20190704150758.GD5164@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040191
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040190
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has (not) been updated.  This is a resend of previous announcements
about the SETFLAGS and FSSETXATTR refactoring that I've started for 5.3
and will continue for 5.4 so that these ioctls will have more consistent
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
