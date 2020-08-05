Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C4523D19B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgHEUDJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:03:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52164 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgHEQii (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:38:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GM5nn154546;
        Wed, 5 Aug 2020 16:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=b91EhdBrtRf++crUMvU1v/okOqyDZ/p6+WllKgxua24=;
 b=bh0uu4nrsi2S5qBOLMoUoWyyOCFcW8wJRK2qxlPYKZGMsxuECStoUme98FKfA4V+Pfn+
 MT8GQE4mupsAb++iZS1GmIr9H3Ve6g7SwPELF4xT53THa0ihgTf54fNRwjRVOzREhfWC
 k8LTFNGnx/mHv04cU4GrNbCXlgT/ICQArMOM1oTj4LFfeHtbcIykZdL1NukBn8lp036a
 8Vl7cV48YWgV+so495ZZbfdrEXqxmnNYizovLZ+2sKSBYiUlYQa/3LZ8jOO1alGLFeLk
 bRaqwXPCP/9IL+3sVa/4t40X8BSVqtuLaNf9p1VmcPinoWiieXF2xZyrPzzjq5XOkSA+ yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32qnd43e1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 16:38:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075GJB9S061054;
        Wed, 5 Aug 2020 16:38:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32p5gu1evy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 16:38:22 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075GcLuM002243;
        Wed, 5 Aug 2020 16:38:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 09:38:21 -0700
Date:   Wed, 5 Aug 2020 09:38:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        agruenba@redhat.com
Subject: [ANNOUNCE] xfs-linux: iomap-5.9-merge rebased to 60263d5889e6
Message-ID: <20200805163820.GB6090@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=2 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 clxscore=1015 mlxscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050132
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.9-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been rebased to remove email virus scanner debris from a patch
commit log.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-5.9-merge branch is commit:

60263d5889e6 iomap: fall back to buffered writes for invalidation failures

New Commits:

Andreas Gruenbacher (1):
      [856473cd5d17] iomap: Make sure iomap_end is called after iomap_begin

Christoph Hellwig (2):
      [80e543ae24db] xfs: use ENOTBLK for direct I/O to buffered I/O fallback
      [60263d5889e6] iomap: fall back to buffered writes for invalidation failures

Dave Chinner (1):
      [54752de928c4] iomap: Only invalidate page cache pages on direct IO writes


Code Diffstat:

 fs/ext4/file.c       |  2 ++
 fs/gfs2/file.c       |  3 ++-
 fs/iomap/apply.c     | 13 +++++++++----
 fs/iomap/direct-io.c | 37 +++++++++++++++++++++----------------
 fs/iomap/trace.h     |  1 +
 fs/xfs/xfs_file.c    |  8 ++++----
 fs/zonefs/super.c    |  7 +++++--
 7 files changed, 44 insertions(+), 27 deletions(-)
