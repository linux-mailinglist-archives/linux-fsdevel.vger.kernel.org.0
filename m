Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547531C3F86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 18:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgEDQON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 12:14:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60244 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEDQON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 12:14:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Fta2g150099;
        Mon, 4 May 2020 16:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Uuh1IJ8pB0K+VMTYDs8Zuh+vG5xj9hQbQ99FMw/17ys=;
 b=neQLZziZ4rQ+6tvbTUB3Kcy+OFOZKVIq+dwiEKIRJz3K+rKIA8zXYSxUdg0v2oRfx4gt
 5Cr6hLdH/wM/TBnXuM2j49YZQ9HJWih61J1yaU8KJTk7fbmkM5IKh0BYf0aCSph6s2nE
 xRQxNlkY05IhAFStfOKzpMQosS3kB7QVn95DvhlaZTtFd/cgBkQyue5rzsWr1LJwS2l1
 GPrJfR0nU5YdgiBPI0v3KdGDoeEAIiM5nvustGd6ByNcbusoLpO6ivK/qvAFqoSRgAne
 pPVbnA9G2jhzXnKqhHtn3YeTaZuy/JF65xtNyQdr6P9ToW051/LFZtsulYW1oA2zYdLA Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30s0tm7vq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 16:13:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044G6qJR061942;
        Mon, 4 May 2020 16:13:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30sjdquymb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 16:13:56 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044GDskG025963;
        Mon, 4 May 2020 16:13:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 09:13:54 -0700
Date:   Mon, 4 May 2020 09:13:52 -0700
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
Subject: [ANNOUNCE] xfs-linux: vfs-for-next updated to 83d9088659e8
Message-ID: <20200504161352.GA13783@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=2
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040127
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The vfs-for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

After a very, very long process of discussing how sysadmins and app
programmers are supposed to tag files for DAX data access mode, we have
reached an agreement about how the userspace knobs should work.  This
first update contains the necessary documentation updates and statx mode
flag to enable the behaviors that we have decided on.  The second part
(hinting at inode eviction to change the DAX mode) will come later after
everyone has had a few days to let this soak in.

The new head of the vfs-for-next branch is commit:

83d9088659e8 Documentation/dax: Update Usage section

New Commits:

Ira Weiny (3):
      [efbe3c2493d2] fs: Remove unneeded IS_DAX() check in io_is_direct()
      [712b2698e4c0] fs/stat: Define DAX statx attribute
      [83d9088659e8] Documentation/dax: Update Usage section


Code Diffstat:

 Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++++++++++-
 drivers/block/loop.c              |   6 +-
 fs/stat.c                         |   3 +
 include/linux/fs.h                |   7 +-
 include/uapi/linux/stat.h         |   1 +
 5 files changed, 147 insertions(+), 12 deletions(-)
