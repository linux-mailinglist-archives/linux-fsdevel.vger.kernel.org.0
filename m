Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A522A90C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 21:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbfIDSLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 14:11:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43420 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388806AbfIDSLi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84I8mw4188517;
        Wed, 4 Sep 2019 18:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=wvZM2113YZRSbQoV6qQJLkw3huwJtvX/oXClQJB4Jvc=;
 b=A2GKlXLgwEszQiTsa6NzgoKwyFbFtm/SA4iHBqQPamP+Ds87xNzD1E9TbtlhhDSqzazb
 vJNCqitpOLt6Tz+G7Qsek+6cV1rol0x53pDFY9Upf0WedKOOG549k4VO9tR8tETJVxuD
 n3gk97fmnKM0SzZ+nZN4uPnbKfM8TqFvQFgCvJiCrRNiyI+sUsOeIjy7s479pjDe4TQd
 hHbl4lYnbiOdvAnmxoO+8PYtS0Zy7/N8ymfbZJ75tw0RfgmZbKtdyPCL7zrRrE2EQAnp
 vl0sC9OYAmQZdMKa2e7ztZ8gOZFgGBlE0r0hm9P+EX3EbfG1tIEhkFNfCxaP8C8D4eoY nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2utj93r0uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 18:11:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x84I8U6j096404;
        Wed, 4 Sep 2019 18:11:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2usu53fcq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 18:11:17 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x84IBFo5029889;
        Wed, 4 Sep 2019 18:11:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Sep 2019 11:11:14 -0700
Date:   Wed, 4 Sep 2019 11:11:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 68494b8e248f
Message-ID: <20190904181113.GK5340@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9370 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040182
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
the next update.  I will send around for review an amended zonefs patch
with the recent api breakage fixed.

The new head of the iomap-for-next branch is commit:

68494b8e248f iomap: move the iomap_dio_rw ->end_io callback into a structure

New Commits:

Andreas Gruenbacher (1):
      [791ee52eb10b] iomap: Fix trivial typo

Christoph Hellwig (9):
      [31c20dede460] list.h: add list_pop and list_pop_entry helpers
      [a12c4b4602f1] iomap: copy the xfs writeback code to iomap.c
      [4b45a4b5c1f5] iomap: add tracing for the address space operations
      [6f0af1def491] iomap: warn on inline maps in iomap_writepage_map
      [84be4599c1a6] xfs: set IOMAP_F_NEW more carefully
      [f61be89fed56] iomap: zero newly allocated mapped blocks
      [3d2d71b4fdff] xfs: initialize iomap->flags in xfs_bmbt_to_iomap
      [1c1daa47a0ae] xfs: refactor the ioend merging code
      [68494b8e248f] iomap: move the iomap_dio_rw ->end_io callback into a structure

Matthew Bobrowski (1):
      [db10bd824bc0] iomap: split size and error for iomap_dio_rw ->end_io

Randy Dunlap (1):
      [32e3cf9f41c7] tracing: fix iomap.h build warnings


Code Diffstat:

 fs/iomap/buffered-io.c       | 575 ++++++++++++++++++++++++++++++++++++++++++-
 fs/iomap/direct-io.c         |  24 +-
 fs/xfs/xfs_aops.c            |  70 +++---
 fs/xfs/xfs_file.c            |  14 +-
 fs/xfs/xfs_iomap.c           |  35 ++-
 fs/xfs/xfs_iomap.h           |   2 +-
 fs/xfs/xfs_pnfs.c            |   2 +-
 include/linux/iomap.h        |  53 +++-
 include/linux/list.h         |  33 +++
 include/trace/events/iomap.h |  87 +++++++
 10 files changed, 824 insertions(+), 71 deletions(-)
 create mode 100644 include/trace/events/iomap.h
