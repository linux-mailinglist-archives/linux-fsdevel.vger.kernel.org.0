Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE29133A1A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgAHEU3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 23:20:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50044 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgAHEU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:20:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0084JFK4026692;
        Wed, 8 Jan 2020 04:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=7Oo1sicqsTtTOwQ93/Y/BfeHOPw9SprrwK1buo8ZKZM=;
 b=TiCzU6h1YYillqWrCbL8JBo09h3beBT1VRIhbUPSRK0hD9X1Kd3PDiyhoJZqZw7MgPuP
 OPN8pTHKudfK4sr8ws3nIP0ccIU7Di/pN6Qbt7Gq7tEnTsrxq1wAR5cuqrdHWA1m975Y
 EBSzQBHl+Ze5h5X5t61wp61tQLxd705mdPJ0wX7BBfZwg3hnJBpLS71qjXJzo0ENlOCC
 rH1G/iaG+Ob7on1IGqrOvnV5Z7Qv4bGsbE+nlC6dHZA1gIx2Z+bTTTtTDFcmtrBp9/Al
 MbjdOPozi/cBKBSslwtIZAYhBj67L/5DbTY47v7dFYeeXTraD3FApERYD65sBlOdFjA6 kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnq1eqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 04:20:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0084JI3R136053;
        Wed, 8 Jan 2020 04:20:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xcpanywya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 04:20:09 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0084K5jv008866;
        Wed, 8 Jan 2020 04:20:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 20:20:05 -0800
Date:   Tue, 7 Jan 2020 20:20:00 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jan Kara <jack@suse.cz>, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [ANNOUNCE] xfs-linux: iomap-5.6-merge updated to 62e298db3fc3
Message-ID: <20200108042000.GA5552@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080037
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

The iomap-5.6-merge branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been updated.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.

The new head of the iomap-5.6-merge branch is commit:

62e298db3fc3 fs: Fix page_mkwrite off-by-one errors

New Commits:

Andreas Gruenbacher (1):
      [62e298db3fc3] fs: Fix page_mkwrite off-by-one errors


Code Diffstat:

 fs/btrfs/inode.c        | 15 ++++-----------
 fs/buffer.c             | 16 +++-------------
 fs/ceph/addr.c          |  2 +-
 fs/ext4/inode.c         | 15 ++++-----------
 fs/iomap/buffered-io.c  | 18 +++++-------------
 fs/ubifs/file.c         |  3 +--
 include/linux/pagemap.h | 28 ++++++++++++++++++++++++++++
 7 files changed, 46 insertions(+), 51 deletions(-)
