Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD62AF703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgKKQ4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 11:56:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52154 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKQ4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:56:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABGrwcR118531;
        Wed, 11 Nov 2020 16:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=llT9KLhREFVQvXSsY6eOLMqTF9y/n6ZKqhtEicukBcE=;
 b=PL/Hku1Er9GHNXnjFHp/ERWwqhcJvPKzasaB1sZmtIUIUwDSht8R1+8HdF7nEFPbNEwg
 tlZm9EROOPwZDqwgvfvZND9yA8134ppvlMZuIwMNla27kp2fVpS4iHP6QyYY5I/OMObX
 1tNYmiYkE1nipWVzjWGZlMPQoZFhFpQV6zFroBvvEsnhfBzeyNGpWs9YMQR+xzXB6235
 k3JlznsoiQ5EhfiINHu2dkP39Ou4NsUIeQBBT7l6n7sVsdpCd8RfiVzf0o3oUCUGvHRH
 UHso4SHAw/4f67uORNa/mU712ZohKZ/0HuE+s+z6XHI5LlfuouMzWlkQ1p1rKXpiSOwc JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3b21s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Nov 2020 16:56:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ABGtG3a063348;
        Wed, 11 Nov 2020 16:56:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 34p55q6e9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 16:56:01 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ABGu0Cm029395;
        Wed, 11 Nov 2020 16:56:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Nov 2020 08:56:00 -0800
Date:   Wed, 11 Nov 2020 08:55:59 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: for-next updated to 2bd3fa793aaa
Message-ID: <20201111165559.GF9685@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110100
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

The for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  There are still a few bug fixes on the list waiting
for review (patches 2-4 of "xfs: fix various scrub problems"), though I
get that it's a US holiday and not as many people are around today.
I'm currently sneaking online to push this out to get some soak time in
for-next. ;)

The new head of the for-next branch is commit:

2bd3fa793aaa xfs: fix a missing unlock on error in xfs_fs_map_blocks

New Commits:

Christoph Hellwig (1):
      [2bd3fa793aaa] xfs: fix a missing unlock on error in xfs_fs_map_blocks

Darrick J. Wong (4):
      [ea8439899c0b] xfs: fix flags argument to rmap lookup when converting shared file rmaps
      [5dda3897fd90] xfs: set the unwritten bit in rmap lookup flags in xchk_bmap_get_rmapextents
      [6ff646b2ceb0] xfs: fix rmap key and record comparison functions
      [54e9b09e1538] xfs: fix brainos in the refcount scrubber's rmap fragment processor


Code Diffstat:

 fs/xfs/libxfs/xfs_rmap.c       |  2 +-
 fs/xfs/libxfs/xfs_rmap_btree.c | 16 ++++++++--------
 fs/xfs/scrub/bmap.c            |  2 ++
 fs/xfs/scrub/refcount.c        |  8 +++-----
 fs/xfs/xfs_pnfs.c              |  2 +-
 5 files changed, 15 insertions(+), 15 deletions(-)
