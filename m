Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E501D1A8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 18:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbgEMQEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 12:04:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733083AbgEMQEL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 12:04:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DFuRXE043960;
        Wed, 13 May 2020 16:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=myg+Pbi0jJplfSlrmx3sySw86RPCsqGwGq4ZrHDz5L0=;
 b=fjVxr5HI7zXUI0LF6GL3MO8dtw0OIp8XNAfuJnSPT1e6RjSzX8OnH1TZOgVcJTQFVaXF
 MENnYnwJ9g3IFqbh2IdRSkCMDOWJ0E5s3gsZdcsDMwEQzeZgZETPv+OzvKQF/QeVyWmc
 CY/thpaN4Q9pDCfd1snkvUFBH7nB9oAx0dQcpYDNMS4BURCb573QC19MWFKHww7GmXeQ
 1+NkecJ2ul+mqzUFEPCyCpqGXXpPcRTur4dYY4pY624Ug54YcEyy0IYphNKlR8QsFoiR
 dKuv4yIz1occf3VIe0h25a5TGOJJnycmcckouoOun+Ppg8tyICA0Wk5aR926Sxz49gLa Wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3100yfw4j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 16:03:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04DFw4EH102865;
        Wed, 13 May 2020 16:01:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3100yeubfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 16:01:58 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04DG1uH0002783;
        Wed, 13 May 2020 16:01:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 09:01:56 -0700
Date:   Wed, 13 May 2020 09:01:53 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     ira.weiny@intel.com, Al Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to 2c567af418e3
Message-ID: <20200513160153.GA2079101@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=2 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=2 spamscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130139
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
the next update.

The new head of the vfs-for-next branch is commit:

2c567af418e3 fs: Introduce DCACHE_DONTCACHE

New Commits:

Ira Weiny (5):
      [efbe3c2493d2] fs: Remove unneeded IS_DAX() check in io_is_direct()
      [712b2698e4c0] fs/stat: Define DAX statx attribute
      [83d9088659e8] Documentation/dax: Update Usage section
      [dae2f8ed7992] fs: Lift XFS_IDONTCACHE to the VFS layer
      [2c567af418e3] fs: Introduce DCACHE_DONTCACHE


Code Diffstat:

 Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++++++++++-
 drivers/block/loop.c              |   6 +-
 fs/dcache.c                       |  19 +++++
 fs/stat.c                         |   3 +
 fs/xfs/xfs_icache.c               |   4 +-
 fs/xfs/xfs_inode.h                |   3 +-
 fs/xfs/xfs_super.c                |   2 +-
 include/linux/dcache.h            |   2 +
 include/linux/fs.h                |  14 ++--
 include/uapi/linux/stat.h         |   1 +
 10 files changed, 178 insertions(+), 18 deletions(-)
