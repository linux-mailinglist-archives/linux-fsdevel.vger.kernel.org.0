Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D142730A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgIURHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 13:07:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46532 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgIURHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:07:13 -0400
X-Greylist: delayed 995 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 13:07:12 EDT
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LGjPW0153954;
        Mon, 21 Sep 2020 16:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=cpHbKq/jzNkOqXMpHVAVZLahUeBKCi8bOij5q/cpM7w=;
 b=GBgWyYkLH9S+7vIDa+H0Vhjhe/dhRTbNdp2AEdP5y+ptNGmSeijp0LFlMWGmE1mOK110
 +n65Dj6dxj3RUHhT5sTyZ41aBcLrKOiNV4M03A/QQ6GkqX1HM1793+Sphcv3Nrs8HEfW
 OhWQLQk8Yf+ikcARgTfL7VpuMEugT15KYTV1lljWXZjVi/VeHnTcwsUmaTOusczNJ5a2
 mr2KiliOblv9dP5cJfJ3AkZ1HWaBMeARgbeznZyhBZNgpKAhQ7eyb1C954FSs8rwTNeW
 fr5eAbP7RPbyfaCO3kkxwN9PflAgr/OpsbGl7sed6/IgZ/mhxCquQCj/hkCtiXkXrDn3 uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 33n7ga9jsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 16:50:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LGoKUR058347;
        Mon, 21 Sep 2020 16:50:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33nurr4rjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 16:50:26 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08LGoPYo031067;
        Mon, 21 Sep 2020 16:50:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 09:50:25 -0700
Date:   Mon, 21 Sep 2020 09:50:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.10-merge updated to 81ee8e52a71c
Message-ID: <20200921165024.GC7949@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=2
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=2 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210119
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.10-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  (Yes, I saw a btrfs directio series containing iomap
patches, but they had no S-o-b, which will impede review...)

The new head of the iomap-5.10-merge branch is commit:

81ee8e52a71c iomap: Change calling convention for zeroing

New Commits:

Andreas Gruenbacher (1):
      [c114bbc6c423] iomap: Fix direct I/O write consistency check

Matthew Wilcox (Oracle) (11):
      [e6e7ca92623a] iomap: Clear page error before beginning a write
      [14284fedf59f] iomap: Mark read blocks uptodate in write_begin
      [7ed3cd1a69e3] iomap: Fix misplaced page flushing
      [24addd848a45] fs: Introduce i_blocks_per_page
      [a6901d4d148d] iomap: Use kzalloc to allocate iomap_page
      [b21866f514cb] iomap: Use bitmap ops to set uptodate bits
      [0a195b91e899] iomap: Support arbitrarily many blocks per page
      [7d636676d284] iomap: Convert read_count to read_bytes_pending
      [0fb2d7209d66] iomap: Convert write_count to write_bytes_pending
      [e25ba8cbfd16] iomap: Convert iomap_write_end types
      [81ee8e52a71c] iomap: Change calling convention for zeroing

Nikolay Borisov (1):
      [6cc19c5fad09] iomap: Use round_down/round_up macros in __iomap_write_begin

Qian Cai (1):
      [a805c111650c] iomap: fix WARN_ON_ONCE() from unprivileged users


Code Diffstat:

 fs/dax.c                |  13 ++--
 fs/iomap/buffered-io.c  | 192 ++++++++++++++++++++----------------------------
 fs/iomap/direct-io.c    |  12 ++-
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |   2 +-
 include/linux/dax.h     |   3 +-
 include/linux/pagemap.h |  16 ++++
 7 files changed, 116 insertions(+), 124 deletions(-)
