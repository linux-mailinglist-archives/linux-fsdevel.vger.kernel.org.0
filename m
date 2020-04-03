Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C79E519D8AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgDCOJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 10:09:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36956 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCOJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:09:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033E8tJr126934;
        Fri, 3 Apr 2020 14:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=tzs2p9/Sodtu6+Aabywdf4bFlq59U9T/bcVIVhebzAw=;
 b=LQNRoI5DGpuycxE/YW8kUi7D696EEMGFqQFVYSE6rm/WLYpBj3E1kwx28FYj/I2QrtWg
 oid6VgdIBsny/qRI9h/5HRg7uN0GRBVkCQql6goBpZF3zGuuBpqE/jSmw0M6D00stNsa
 nPg9Iwv9OQ5eIyWch7A2YVrBVSaPzTe9QUfI2bOpoS7y2N6sIw1YGEYfh+jaamdsmDba
 8tJ0QHEkjk/eGAeAd2y6ki1P1el9BKd1pzwViQxArjw7CqqsvOuO6JzpZ9Au/G904twl
 PGifiWcKTl7Nh3jJ/zdJwe7pmpW+vR5S44ff35z3jOF/X/77umBRl5j3BJNXadGEF4// Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 303aqj1r9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 14:09:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 033E8VH4032141;
        Fri, 3 Apr 2020 14:09:26 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 302g4xj7wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 14:09:26 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 033E9M9g026314;
        Fri, 3 Apr 2020 14:09:25 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 07:09:22 -0700
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [GIT PULL] Please pull NFS server updates for 5.7
Message-Id: <E69B987A-7E11-4321-8812-EBC2EE4F07E0@oracle.com>
Date:   Fri, 3 Apr 2020 10:09:21 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=2
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030125
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

I'm filling in for Bruce this time while he and his family settle
into a new house.


The following changes since commit =
fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.7

for you to fetch changes up to 1a33d8a284b1e85e03b8c7b1ea8fb985fccd1d71:

  svcrdma: Fix leak of transport addresses (2020-03-27 12:25:06 -0400)

----------------------------------------------------------------
Highlights:

- Fix EXCHANGE_ID response when NFSD runs in a container
- A battery of new static trace points
- Socket transports now use bio_vec to send Replies
- NFS/RDMA now supports filesystems with no .splice_read method
- Favor memcpy() over DMA mapping for small RPC/RDMA Replies
- Add pre-requisites for supporting multiple Write chunks
- Numerous minor fixes and clean-ups

There are a few open issues that did not reach closure before I cut
the nfsd-5.7 tag:

- Vasily Averin has addressed a use-after-free in nfsd4_lock()
- Yihao Wu is investigating a race in cache_purge()
- Jan Psota reports a refcount underflow warning in nfsd41_cb_destroy()

These are long-standing bugs. I plan to send follow-up PRs for
v5.7-rc when these issues are resolved and their fixes thoroughly
tested.

----------------------------------------------------------------

Amol Grover (1):
      sunrpc: Pass lockdep expression to RCU lists

Christophe JAILLET (1):
      SUNRPC: Fix a potential buffer overflow in 'svc_print_xprts()'

Chuck Lever (21):
      nfsd: Fix NFSv4 READ on RDMA when using readv
      NFSD: Clean up nfsd4_encode_readv
      svcrdma: Fix double svc_rdma_send_ctxt_put() in an error path
      SUNRPC: Add xdr_pad_size() helper
      SUNRPC: Clean up: Replace dprintk and BUG_ON call sites in =
svcauth_gss.c
      svcrdma: Create a generic tracing class for displaying xdr_buf =
layout
      svcrdma: Remove svcrdma_cm_event() trace point
      svcrdma: Use struct xdr_stream to decode ingress transport headers
      svcrdma: De-duplicate code that locates Write and Reply chunks
      svcrdma: Update synopsis of svc_rdma_send_reply_chunk()
      svcrdma: Update synopsis of svc_rdma_map_reply_msg()
      svcrdma: Update synopsis of svc_rdma_send_reply_msg()
      svcrdma: Rename svcrdma_encode trace points in send routines
      SUNRPC: Add encoders for list item discriminators
      svcrdma: Refactor chunk list encoders
      svcrdma: Fix double sync of transport header buffer
      svcrdma: Avoid DMA mapping small RPC Replies
      SUNRPC: Refactor xs_sendpages()
      SUNRPC: Teach server to use xprt_sock_sendmsg for socket sends
      NFSD: Fix NFS server build errors
      svcrdma: Fix leak of transport addresses

Gustavo A. R. Silva (2):
      sunrpc: Replace zero-length array with flexible-array member
      svcrdma: Replace zero-length array with flexible-array member

J. Bruce Fields (3):
      nfsd4: kill warnings on testing stateids with mismatched clientids
      nfsd: fsnotify on rmdir under nfsd/clients/
      SUNRPC/cache: don't allow invalid entries to be flushed

Madhuparna Bhowmik (2):
      fs: nfsd: nfs4state.c: Use built-in RCU list checking
      fs: nfsd: fileache.c: Use built-in RCU list checking

Petr Vorel (1):
      nfsd: remove read permission bit for ctl sysctl

Scott Mayhew (1):
      nfsd: set the server_scope during service startup

Trond Myklebust (7):
      nfsd: Don't add locks to closed or closing open stateids
      nfsd: Add tracing to nfsd_set_fh_dentry()
      nfsd: Add tracepoints for exp_find_key() and exp_get_by_name()
      nfsd: Add tracepoints for update of the expkey and export cache =
entries
      nfsd: export upcalls must not return ESTALE when mountd is down
      SUNRPC/cache: Allow garbage collection of invalid cache entries
      sunrpc: Add tracing for cache events

 fs/nfs/dns_resolve.c                       |  11 +-
 fs/nfsd/Kconfig                            |   2 +-
 fs/nfsd/export.c                           |  45 +++++++--
 fs/nfsd/filecache.c                        |   2 +-
 fs/nfsd/netns.h                            |   2 +
 fs/nfsd/nfs4idmap.c                        |  14 +++
 fs/nfsd/nfs4state.c                        |  87 ++++++++--------
 fs/nfsd/nfs4xdr.c                          |  38 +++----
 fs/nfsd/nfsctl.c                           |   1 +
 fs/nfsd/nfsfh.c                            |  13 ++-
 fs/nfsd/nfssvc.c                           |   3 +
 fs/nfsd/trace.h                            | 122 ++++++++++++++++++++++
 include/linux/sunrpc/cache.h               |   9 +-
 include/linux/sunrpc/rpc_rdma.h            |   3 +-
 include/linux/sunrpc/svc.h                 |   5 +-
 include/linux/sunrpc/svc_rdma.h            |  24 +++--
 include/linux/sunrpc/svc_xprt.h            |   2 +
 include/linux/sunrpc/xdr.h                 |  67 ++++++++++---
 include/trace/events/rpcgss.h              |  59 ++++++++++-
 include/trace/events/rpcrdma.h             |  67 ++++++-------
 include/trace/events/sunrpc.h              |  76 ++++++++++++++
 net/sunrpc/auth_gss/auth_gss.c             |   2 +-
 net/sunrpc/auth_gss/svcauth_gss.c          |  60 +++++------
 net/sunrpc/cache.c                         | 128 =
++++++++++++++----------
 net/sunrpc/clnt.c                          |   1 +
 net/sunrpc/socklib.c                       | 141 =
++++++++++++++++++++++++++
 net/sunrpc/socklib.h                       |  15 +++
 net/sunrpc/sunrpc.h                        |   4 -
 net/sunrpc/svc.c                           |  20 +++-
 net/sunrpc/svc_xprt.c                      |  22 +++-
 net/sunrpc/svcauth_unix.c                  |  12 +++
 net/sunrpc/svcsock.c                       | 202 =
+++++++++++++------------------------
 net/sunrpc/xprt.c                          |   3 +-
 net/sunrpc/xprtrdma/rpc_rdma.c             |  36 +------
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  17 ++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 244 =
+++++++++++++++++++++++++++-----------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  57 ++++++-----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 512 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------=
-------------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |   8 +-
 net/sunrpc/xprtsock.c                      | 188 =
++++++----------------------------
 40 files changed, 1411 insertions(+), 913 deletions(-)
 create mode 100644 net/sunrpc/socklib.h

--
Chuck Lever



