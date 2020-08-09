Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E723FF0D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Aug 2020 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgHIPqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Aug 2020 11:46:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIPqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Aug 2020 11:46:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 079Fc05X124024;
        Sun, 9 Aug 2020 15:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=7sO52o8n45ywtCixPuR/wFX+kO5/oyb73FG2RAil3P0=;
 b=0b13Uuz9pvueL2TT4Z+y4R0JHGO7ahiyj+FXKoRbuMFZBEjuUONDbbCDLA3heVO31Zmt
 SMU0HYh5NJnN5s20C7CMn+N3v+wyRokkFP1jmxwIIvdIIybwkMT/PIIgyIsLglccU5cn
 cAKD/ZDWc+X+6EwnzFJ/H118kws0M1++OBwyqS/3Cp08iUwlVGfI12zIVT00B7dciJmi
 ovuE6Ne1cmQObFwF4kU13oyuDYyDdNqeHoeFlc9G+B9vG0bkZNDDR7xrjz+uaG0swPw2
 WidFk39fxsF9GQzb5Q85oawUmwFB4hROLb/YZ6LRjelX5wdJo98UR0x/OxjTmK2lZJTn UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2yd9kpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 09 Aug 2020 15:46:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 079FhJtT102028;
        Sun, 9 Aug 2020 15:44:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32t5tprvs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Aug 2020 15:44:17 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 079FiGcm019359;
        Sun, 9 Aug 2020 15:44:16 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Aug 2020 15:44:16 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Please pull NFS server updates for v5.9
Message-Id: <F9B8940D-9F7B-47F5-9946-D77C17CF959A@oracle.com>
Date:   Sun, 9 Aug 2020 11:44:15 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008090118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008090117
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Linus-

The following changes since commit =
11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git tags/nfsd-5.9

for you to fetch changes up to b297fed699ad9e50315b27e78de42ac631c9990d:

  svcrdma: CM event handler clean up (2020-07-28 10:18:15 -0400)

----------------------------------------------------------------
Highlights:

- Support for user extended attributes on NFS (RFC 8276)
- Further reduce unnecessary NFSv4 delegation recalls

Notable fixes:

- Fix recent krb5p regression
- Address a few resource leaks and a rare NULL dereference

Other:

- De-duplicate RPC/RDMA error handling and other utility functions
- Replace storage and display of kernel memory addresses by tracepoints

----------------------------------------------------------------
Chuck Lever (24):
      SUNRPC: Augment server-side rpcgss tracepoints
      svcrdma: Fix page leak in svc_rdma_recv_read_chunk()
      svcrdma: Remove save_io_pages() call from send_error_msg()
      svcrdma: Add @rctxt parameter to svc_rdma_send_error() functions
      svcrdma: Add a @status parameter to svc_rdma_send_error_msg()
      svcrdma: Eliminate return value for svc_rdma_send_error_msg()
      svcrdma: Make svc_rdma_send_error_msg() a global function
      svcrdma: Consolidate send_error helper functions
      svcrdma: Clean up trace_svcrdma_send_failed() tracepoint
      svcrdma: Remove declarations for functions long removed
      SUNRPC: Add helpers for decoding list discriminators symbolically
      svcrdma: Add common XDR decoders for RDMA and Read segments
      svcrdma: Add common XDR encoders for RDMA and Read segments
      svcrdma: Introduce infrastructure to support completion IDs
      svcrdma: Introduce Receive completion IDs
      svcrdma: Record Receive completion ID in svc_rdma_decode_rqst
      svcrdma: Introduce Send completion IDs
      svcrdma: Record send_ctxt completion ID in =
trace_svcrdma_post_send()
      svcrdma: Display chunk completion ID when posting a rw_ctxt
      SUNRPC: Fix ("SUNRPC: Add "@len" parameter to gss_unwrap()")
      SUNRPC: Refresh the show_rqstp_flags() macro
      svcrdma: Fix another Receive buffer leak
      svcrdma: Remove transport reference counting
      svcrdma: CM event handler clean up

Frank van der Linden (10):
      nfs,nfsd: NFSv4.2 extended attribute protocol definitions
      xattr: break delegations in {set,remove}xattr
      xattr: add a function to check if a namespace is supported
      nfsd: split off the write decode code into a separate function
      nfsd: add defines for NFSv4.2 extended attribute support
      nfsd: define xattr functions to call into their vfs counterparts
      nfsd: take xattr bits into account for permission checks
      nfsd: add structure definitions for xattr requests / responses
      nfsd: implement the xattr functions and en/decode logic
      nfsd: add fattr support for user extended attributes

J. Bruce Fields (1):
      nfsd4: a client's own opens needn't prevent delegations

Randy Dunlap (1):
      nfsd: netns.h: delete a duplicated word

Scott Mayhew (1):
      nfsd: avoid a NULL dereference in __cld_pipe_upcall()

Xu Wang (1):
      nfsd: Use seq_putc() in two functions

 fs/locks.c                                 |   3 +
 fs/nfsd/netns.h                            |   2 +-
 fs/nfsd/nfs4idmap.c                        |   4 +-
 fs/nfsd/nfs4proc.c                         | 128 =
++++++++++++++++++++++-
 fs/nfsd/nfs4recover.c                      |  24 ++---
 fs/nfsd/nfs4state.c                        |  54 +++++++---
 fs/nfsd/nfs4xdr.c                          | 531 =
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++------
 fs/nfsd/nfsd.h                             |   5 +-
 fs/nfsd/vfs.c                              | 239 =
++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/vfs.h                              |  10 ++
 fs/nfsd/xdr4.h                             |  31 ++++++
 fs/xattr.c                                 | 111 ++++++++++++++++++--
 include/linux/nfs4.h                       |  22 +++-
 include/linux/sunrpc/rpc_rdma.h            |  74 +++++++++++++
 include/linux/sunrpc/rpc_rdma_cid.h        |  24 +++++
 include/linux/sunrpc/svc_rdma.h            |  17 ++-
 include/linux/sunrpc/xdr.h                 |  26 +++++
 include/linux/xattr.h                      |   4 +
 include/trace/events/rpcgss.h              | 168 =
+++++++++++++++++++++++++-----
 include/trace/events/rpcrdma.h             | 207 =
+++++++++++++++++++-----------------
 include/trace/events/sunrpc.h              |  35 +++++--
 include/uapi/linux/nfs4.h                  |   3 +
 net/sunrpc/auth_gss/gss_krb5_wrap.c        |   2 +-
 net/sunrpc/auth_gss/svcauth_gss.c          | 118 ++++++++++++++-------
 net/sunrpc/auth_gss/trace.c                |   3 +
 net/sunrpc/xprtrdma/frwr_ops.c             |   1 -
 net/sunrpc/xprtrdma/rpc_rdma.c             |  31 ++----
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 115 +++++++-------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  81 +++++++++------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 124 ++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  74 +++++--------
 32 files changed, 1807 insertions(+), 466 deletions(-)
 create mode 100644 include/linux/sunrpc/rpc_rdma_cid.h
--
Chuck Lever



