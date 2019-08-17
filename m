Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F11AF90C04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 04:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHQCC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 22:02:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40378 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQCC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 22:02:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H1wvRL006535;
        Sat, 17 Aug 2019 02:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=D2h/X/KeBuppJSUojj2Yh9aNdt5ZNStPGrUmlsS5ifc=;
 b=Sb70CLtU8f4dbsm8eMR4sDaghcB0Go9iL7nnofs1/nEiCL3b2w9YF9mbYWm9igmWC2ne
 Wvtwyk9KCAXPQeVclBjRphNfVWd+BsjMGBUhYKzVfwb6ZNAcfEBk9hO1ayQ+PpkaLHBW
 af63yDyFBxI2D2f/loacbaswAI9WFNkXExw46VVM4+OD+rWeofj3rP8+/sUudH6BL0hG
 Scv/FzrWNIss87S86yEK7sjptCTc8/YsIzwu/OXZRLc8iFQ+ypUN+CGdyQK3cjk78IaX
 1Hg1D/YE/UJ+RdbLjZJbGnWYfz7gPkHNcxjqOd1kOJkBr/Q0NtGVkb8Uen0JoLknPHJT Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u9nbu3cah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 02:02:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7H1wJKa129544;
        Sat, 17 Aug 2019 02:00:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ue6qcjc8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 02:00:51 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7H20oAa005285;
        Sat, 17 Aug 2019 02:00:50 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 19:00:50 -0700
Date:   Fri, 16 Aug 2019 19:00:49 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-for-next updated to 791ee52eb10b
Message-ID: <20190817020049.GF752159@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908170019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908170019
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

791ee52eb10b iomap: Fix trivial typo

New Commits:

Andreas Gruenbacher (1):
      [791ee52eb10b] iomap: Fix trivial typo

Christoph Hellwig (6):
      [31c20dede460] list.h: add list_pop and list_pop_entry helpers
      [a12c4b4602f1] iomap: copy the xfs writeback code to iomap.c
      [4b45a4b5c1f5] iomap: add tracing for the address space operations
      [6f0af1def491] iomap: warn on inline maps in iomap_writepage_map
      [84be4599c1a6] xfs: set IOMAP_F_NEW more carefully
      [f61be89fed56] iomap: zero newly allocated mapped blocks


Code Diffstat:

 fs/iomap/buffered-io.c       | 575 ++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.c           |   9 +-
 include/linux/iomap.h        |  43 ++++
 include/linux/list.h         |  33 +++
 include/trace/events/iomap.h |  85 +++++++
 5 files changed, 739 insertions(+), 6 deletions(-)
 create mode 100644 include/trace/events/iomap.h
