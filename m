Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF841B5DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgDWOgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 10:36:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWOgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:36:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NESqx4043325;
        Thu, 23 Apr 2020 14:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=vhc1qxRXMx+iuW9x2FbtF55Pq5hnzBq07HQyTGBkbI4=;
 b=M0IdiOuhleGgSwvuxcumRfGfShs+bWWU8BddaDiKGgCPDw8xDeNALaru/oA5jLPbUJv4
 K28p+Iwq9GCqEU0d0Svz/QuCmf+16GiQ6jzP8XW35seZDKetC2uDbpcqCYVIia/xcmiq
 3SBNHz1nM186Am/qu3zQ8CPrXD8i5YOLGqDGNsj4tMel0bV0BxULUqdJG3qiWcH8zLm/
 /XYQt8SPYNE/Eb/c9MhsGEDbg9pgxItsTyEU6HuSKlvHT7EhtXKcmrwe0YNJJvfj3Wef
 soFHNnKGs7I3O2H5LuQ1bRumFiuupTdxJGiY+iF6cpceJyv8UjHnTmP1s/pqyy4yGyQk zQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30grpgwd7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 14:36:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03NEXfYh016068;
        Thu, 23 Apr 2020 14:36:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30k7qv81my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 14:36:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03NEae1Z028661;
        Thu, 23 Apr 2020 14:36:40 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Apr 2020 07:36:40 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [GIT PULL] Please pull first round of NFS server -rc fixes for v5.7
Message-Id: <AC510313-C744-4F22-82F7-F75F20F4B073@oracle.com>
Date:   Thu, 23 Apr 2020 10:36:39 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=2 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=2 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230116
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus-

As promised, here is the first set of 5.7-rc fixes for NFS server =
issues.
These were all unresolved at the time the 5.7 window opened, and needed
some additional time to ensure they were correctly addressed. They are
ready now.

At the moment I know of one more urgent issue regarding the NFS server.
A fix has been tested and is under review. I expect to send one more
"5.7-rc fixes" PR, containing this fix (which now consists of 3 =
patches).


The following changes since commit =
8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.7-rc-1

for you to fetch changes up to 23cf1ee1f1869966b75518c59b5cbda4c6c92450:

  svcrdma: Fix leak of svc_rdma_recv_ctxt objects (2020-04-17 12:40:38 =
-0400)

----------------------------------------------------------------
Fixes:

- Address several use-after-free and memory leak bugs

- Prevent a backchannel livelock

----------------------------------------------------------------
Chuck Lever (3):
      SUNRPC: Fix backchannel RPC soft lockups
      svcrdma: Fix trace point use-after-free race
      svcrdma: Fix leak of svc_rdma_recv_ctxt objects

Vasily Averin (1):
      nfsd: memory corruption in nfsd4_lock()

Yihao Wu (1):
      SUNRPC/cache: Fix unsafe traverse caused double-free in =
cache_purge

 fs/nfsd/nfs4callback.c                     |  4 +++-
 fs/nfsd/nfs4state.c                        |  2 ++
 include/linux/sunrpc/svc_rdma.h            |  1 +
 include/trace/events/rpcrdma.h             | 50 =
++++++++++++++++++++++++++++++++++++--------------
 net/sunrpc/cache.c                         |  5 +++--
 net/sunrpc/svc_xprt.c                      |  5 ++---
 net/sunrpc/svcsock.c                       |  4 ++++
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  2 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 22 ++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  3 +--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 29 =
++++++++++++-----------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 -----
 net/sunrpc/xprtsock.c                      |  1 +
 13 files changed, 89 insertions(+), 44 deletions(-)

--
Chuck Lever



