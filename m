Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22D5FA9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfGDPGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 11:06:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47594 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfGDPGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:06:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64F3lqF156312;
        Thu, 4 Jul 2019 15:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=FH2NYfJu1OoHkPVONwaDDpuB/nbZ0jsWEWKbTs2zSOM=;
 b=Ugkl6t6bhrl/QwzP26/+VM5FV3px8a2i4ssNmtzvC6X8tJxp7GldgivHfCFveY5AFKpD
 d7Q9ge81gFGWEbbffN3+z130EqyaXyKmsDjx7bn+roiXC6t4Tt6iOWzqUFmXeIDH6eCS
 02QmBF1xsUNtlj4skwTdP9JBS/aTWkLmuMnCU4+d8IW1NrjKzkL28Y4qY8V4kJjFx37V
 iNxtOFFHNMwsbI8zgKXts4p0yiqXKb/iVNJgKaCLmxLYNSST+zbs9RrUnlaxp4LJqM7g
 eMVrs+DdBcBbYq91I05Hb+dCAJQmsk3N+Txi78e8JA3oMRZDcdckdgjbDA4oNl/h7ipK yQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2te5tbyb7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:06:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x64F2v7C067257;
        Thu, 4 Jul 2019 15:06:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2th5qmbbwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jul 2019 15:06:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x64F6Gtu018615;
        Thu, 4 Jul 2019 15:06:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jul 2019 08:06:16 -0700
Date:   Thu, 4 Jul 2019 08:06:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [ANNOUNCE RESEND] xfs-linux: copy-file-range-fixes updated to
 fe0da9c09b2d
Message-ID: <20190704150617.GC5164@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=826
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907040190
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9307 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=875 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907040190
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The copy-file-range-fixes branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has (not) been updated.  This is a resend of an earlier announcement
about the copy file range cleanups that I plan to merge for 5.3.

The new head of the copy-file-range-fixes branch is commit:

fe0da9c09b2d fuse: copy_file_range needs to strip setuid bits and update timestamps

New Commits:

Amir Goldstein (7):
      [a31713517dac] vfs: introduce generic_file_rw_checks()
      [646955cd5425] vfs: remove redundant checks from generic_remap_checks()
      [96e6e8f4a68d] vfs: add missing checks to copy_file_range
      [e38f7f53c352] vfs: introduce file_modified() helper
      [8c3f406c097b] xfs: use file_modified() helper
      [5dae222a5ff0] vfs: allow copy_file_range to copy across devices
      [fe0da9c09b2d] fuse: copy_file_range needs to strip setuid bits and update timestamps

Dave Chinner (2):
      [f16acc9d9b37] vfs: introduce generic_copy_file_range()
      [64bf5ff58dff] vfs: no fallback for ->copy_file_range


Code Diffstat:

 fs/ceph/file.c     |  23 ++++++++--
 fs/cifs/cifsfs.c   |   4 ++
 fs/fuse/file.c     |  29 +++++++++++--
 fs/inode.c         |  20 +++++++++
 fs/nfs/nfs4file.c  |  23 ++++++++--
 fs/read_write.c    | 124 +++++++++++++++++++++++++++++------------------------
 fs/xfs/xfs_file.c  |  15 +------
 include/linux/fs.h |   9 ++++
 mm/filemap.c       | 110 ++++++++++++++++++++++++++++++++++++++---------
 9 files changed, 257 insertions(+), 100 deletions(-)
