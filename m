Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D21018A0FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 17:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCRQ4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 12:56:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRQ4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:56:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02IGtjvq112013;
        Wed, 18 Mar 2020 16:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ZEUebHxpC8v3ft1+kV43vNtEG4/dMnunebyI4e5bUpA=;
 b=DeNbXM1EN7Y0fbNr/dgnrwVgZBHWDd1YRNzZsvK/PQKOtgmwCbtKJtxFa0c2P0KqMWe/
 laBhCYVmJqugbQtpby6R3xGf31gIEWhnGp3bbDMBa0nleLMy1AGFMv7Cd6YpoOFuGbL5
 OgSPvjqENf8bchSxdv+rkkyu8mO74+4vFi/I2BRWNIv+vDdBQmwZ0d2smJuOJE4tfnR+
 nJatzeDVo5WT0r0mPLA98z93rgPRZc2kdEmfWVaJME2kekKSWnRTQOm4pSuGANB4WVbG
 TjyDpl+fyq+cHFxsVPAkiERTL/OYqPEbZRgB0coe+QLtOMqIfSfEop4nCdyW1imWVSAY 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2yrpprbvnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 16:56:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02IGnmO8143227;
        Wed, 18 Mar 2020 16:56:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ys92h011s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 16:56:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02IGuQTq008599;
        Wed, 18 Mar 2020 16:56:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Mar 2020 09:56:25 -0700
Date:   Wed, 18 Mar 2020 09:56:24 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to d9973ce2fe5b
Message-ID: <20200318165624.GA256740@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180076
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
the next update.

The new head of the iomap-for-next branch is commit:

d9973ce2fe5b iomap: fix comments in iomap_dio_rw

New Commits:

Matthew Wilcox (Oracle) (1):
      [1ac994525b9d] iomap: Remove pgoff from tracepoints

yangerkun (1):
      [d9973ce2fe5b] iomap: fix comments in iomap_dio_rw


Code Diffstat:

 fs/iomap/buffered-io.c |  7 ++++---
 fs/iomap/direct-io.c   |  4 ++--
 fs/iomap/trace.h       | 27 +++++++++++----------------
 3 files changed, 17 insertions(+), 21 deletions(-)
