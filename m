Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E802B17AA4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgCEQQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 11:16:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40000 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEQQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:16:26 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025G33b4113528;
        Thu, 5 Mar 2020 16:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2QdT6UFI49On+Tbo/L0dP0l6P8M5O1ylKvD5YL+PQXY=;
 b=kusumnT14MvQ+5VmqGEyDB6+X/I2efBVSkl3VjyjrZ6By1+MsstPzSh5a9+1dbqJz19Q
 wMtndOHF0JnPs2AcgL/7XiBgYbs3YMsioibTJy2SqMEgxIpRzlILbCqGU7aUFUdUnycx
 bmtmO2Lv2jhsUDNDMLufNJYB6j7k5/fMVJqBGwHV+PJEfvd02GuBVbh0W8J/7ROfZV9P
 8wV1iRO0ULxaIBZ/HE6L4i7F6o01k1/IJEF8yAnIlfrgk1SJcOCwwvJActHN3HWz6psW
 gcmkM/geb+I4qWq4Ep+CuHSeoOE9RhT0VIbYSpKBB/po/pFdqQAoB5yhmhzLBNu2PMW2 qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yghn3hxvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 16:16:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 025G8db3069772;
        Thu, 5 Mar 2020 16:14:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yg1pay1bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Mar 2020 16:14:10 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 025GE97W027984;
        Thu, 5 Mar 2020 16:14:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Mar 2020 08:14:09 -0800
Date:   Thu, 5 Mar 2020 08:14:08 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.7-merge updated to 1ac994525b9d
Message-ID: <20200305161408.GG8037@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=979 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9550 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.7-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-5.7-merge branch is commit:

1ac994525b9d iomap: Remove pgoff from tracepoints

New Commits:

Matthew Wilcox (Oracle) (1):
      [1ac994525b9d] iomap: Remove pgoff from tracepoints


Code Diffstat:

 fs/iomap/buffered-io.c |  7 ++++---
 fs/iomap/trace.h       | 27 +++++++++++----------------
 2 files changed, 15 insertions(+), 19 deletions(-)
