Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7692C264D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 20:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgIJSnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 14:43:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48280 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgIJSnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:43:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AGPubO045058;
        Thu, 10 Sep 2020 16:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=iU/XucBwO3ejuFmZFXIEclD7ztzdiyQP77HA/c7BlDg=;
 b=Enaia+i1olawZLh1E6tvUub+F+mmAIgLMmwNBwX/qsIHBWLsjf1V1ETFGqZg+dzZzZAq
 6bk5ND8nnPe2W72MWsM3frCpVdyR++ngdDMakDvCKi21D48ASaRTXtNXly+zyBWVhB/X
 x0Km7R4zeFMZiMXulW4jZLL5bhrj0zXfizZgJyO2VmfaFwlhMchC9kRksq4I9qT0qU0y
 ddBXcborFasBz1+ukV+mT70CvloTdc1fV9xW3v9PX9oXHNeDTLJvEYdzkRw3K6nccAC6
 T+OWCWoHQjNC4nL1jcEKYb648oHJ2qLh4Bt1yuVZCH5QA2wAdn/c2YT2GCPReLltMpoE yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33c23r9aad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 16:28:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08AGP8Jx109006;
        Thu, 10 Sep 2020 16:28:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33cmka5rtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 16:28:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08AGScmv021012;
        Thu, 10 Sep 2020 16:28:38 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Sep 2020 09:28:38 -0700
Date:   Thu, 10 Sep 2020 09:28:36 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.10-merge updated to 14284fedf59f
Message-ID: <20200910162836.GA7949@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009100151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=988 mlxscore=0 bulkscore=0 suspectscore=2 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100151
Sender: linux-fsdevel-owner@vger.kernel.org
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
the next update after -rc6.  Nikolay Borisov has a cleanup that's
already on the list; and I imagine Matthew Wilcox will resend his THP
refactoring series soon.

The new head of the iomap-5.10-merge branch is commit:

14284fedf59f iomap: Mark read blocks uptodate in write_begin

New Commits:

Andreas Gruenbacher (1):
      [c114bbc6c423] iomap: Fix direct I/O write consistency check

Matthew Wilcox (Oracle) (2):
      [e6e7ca92623a] iomap: Clear page error before beginning a write
      [14284fedf59f] iomap: Mark read blocks uptodate in write_begin

Qian Cai (1):
      [a805c111650c] iomap: fix WARN_ON_ONCE() from unprivileged users


Code Diffstat:

 fs/iomap/buffered-io.c | 15 +++++++--------
 fs/iomap/direct-io.c   | 12 +++++++++++-
 2 files changed, 18 insertions(+), 9 deletions(-)
