Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B62A1F32F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 06:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFIEXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 00:23:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIEX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 00:23:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0594MV6I071489;
        Tue, 9 Jun 2020 04:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=qWSsGo5OhM9pRPhNC5o0nZNffLaCMgdoXoYnWJh39mk=;
 b=QnC7Id641VRgtRoIoG8pZ5O06CUc6Ga1TlkQE4snQH2qrUStSdRVIcHOM25jSsxa3GX2
 evuR+eiS1S2Wr6H9FZC30i+rI4V3eMPWws84QX3Zo285/ieo2IeffxnhSBPpjM4GsuYU
 euqEtI0t3bdkLPckOE1vgIZlui0Z3H977lq2CVtxDAjyUqthP5L0S0h2gTjN/pFitywS
 T4n5hWQGjumfaP9YnYjPhcJmknD32tRrCl1NZObprByIKj7FqgTbz5HmsovKtqJpjApP
 NIed0KAH826L3fgGEJe/NLB2psN+yWNKd1mJucj/O2mxX02zlU6Fw4dBekW4cd0Zff/5 hQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3smt8wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 04:23:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0594ILgm180614;
        Tue, 9 Jun 2020 04:23:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31gn24qm5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 04:23:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0594NIbF024475;
        Tue, 9 Jun 2020 04:23:18 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 21:23:18 -0700
Date:   Mon, 8 Jun 2020 21:23:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: iomap-5.8-merge updated to d4ff3b2ef901
Message-ID: <20200609042317.GO1334206@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=2
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090032
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.8-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  Granted, it's just this one bug fix...

The new head of the iomap-5.8-merge branch is commit:

d4ff3b2ef901 iomap: Fix unsharing of an extent >2GB on a 32-bit machine

New Commits:

Matthew Wilcox (Oracle) (1):
      [d4ff3b2ef901] iomap: Fix unsharing of an extent >2GB on a 32-bit machine


Code Diffstat:

 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
