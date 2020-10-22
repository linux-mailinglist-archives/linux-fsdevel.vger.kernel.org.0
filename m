Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93A29564C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 04:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894950AbgJVCR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 22:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442800AbgJVCR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 22:17:27 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Oct 2020 19:17:26 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B98C0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2020 19:17:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 393FD1C81; Wed, 21 Oct 2020 22:07:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 393FD1C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1603332461;
        bh=sbUwsZww/rB1W0BWKxrwwuLO12ajP4YFsTHjfo7VsIY=;
        h=Date:To:Cc:Subject:From:From;
        b=PuYkx6ABwrAV2BYXj+RQDidL15S1VhR3dR3syTEwG1rNS6f8VYp8o0dRliBa1b4nD
         AJTP7uINX+wmomcra7JJ+IWGwyj8Fwb2IXu7+f3rEfV1JLZlXLlgUssDB80i5RycI8
         jcJvp/dYMZLrCvUIEgFczUfveTGOz+rx0HrakHBI=
Date:   Wed, 21 Oct 2020 22:07:41 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] nfsd change for 5.10
Message-ID: <20201022020741.GA6074@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please pull nfsd changes for 5.10 from:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.10

The one new feature this time, from Anna Schumaker, is READ_PLUS, which
has the same arguments as READ but allows the server to return an array
of data and hole extents.

Otherwise it's a lot of cleanup and bugfixes.

--b.

----------------------------------------------------------------
Alex Dewar (2):
      nfsd: Fix typo in comment
      nfsd: Remove unnecessary assignment in nfs4xdr.c

Anna Schumaker (5):
      SUNRPC/NFSD: Implement xdr_reserve_space_vec()
      NFSD: Add READ_PLUS data support
      NFSD: Add READ_PLUS hole segment encoding
      NFSD: Return both a hole and a data segment
      NFSD: Encode a full READ_PLUS reply

Artur Molchanov (1):
      net/sunrpc: Fix return value for sysctl sunrpc.transports

Chuck Lever (17):
      NFSD: Correct type annotations in user xattr helpers
      NFSD: Correct type annotations in user xattr XDR functions
      NFSD: Correct type annotations in COPY XDR functions
      NFSD: Add missing NFSv2 .pc_func methods
      lockd: Replace PROC() macro with open code
      NFSACL: Replace PROC() macro with open code
      NFSD: Encoder and decoder functions are always present
      NFSD: Clean up switch statement in nfsd_dispatch()
      NFSD: Clean up stale comments in nfsd_dispatch()
      NFSD: Clean up nfsd_dispatch() variables
      NFSD: Refactor nfsd_dispatch() error paths
      NFSD: Remove vestigial typedefs
      NFSD: Fix .pc_release method for NFSv2
      NFSD: Call NFSv2 encoders on error returns
      NFSD: Remove the RETURN_STATUS() macro
      NFSD: Map nfserr_wrongsec outside of nfsd_dispatch
      NFSD: Hoist status code encoding into XDR encoder functions

Dai Ngo (1):
      NFSv4.2: Fix NFS4ERR_STALE error when doing inter server copy

Dan Aloni (1):
      svcrdma: fix bounce buffers for unaligned offsets and multiple pages

Hou Tao (1):
      nfsd: rename delegation related tracepoints to make them less confusing

J. Bruce Fields (8):
      nfsd: remove fault injection code
      nfsd: give up callbacks on revoked delegations
      MAINTAINERS: Note NFS docs under Documentation/
      Documentation: update RPCSEC_GSSv3 RFC link
      sunrpc: simplify do_cache_clean
      nfsd: Cache R, RW, and W opens separately
      nfsd4: remove check_conflicting_opens warning
      nfsd: rq_lease_breaker cleanup

Martijn de Gouw (1):
      SUNRPC: fix copying of multiple pages in gss_read_proxy_verf()

Randy Dunlap (1):
      net: sunrpc: delete repeated words

Rik van Riel (1):
      silence nfscache allocation warnings with kvzalloc

Roberto Bergantinos Corpas (1):
      sunrpc: raise kernel RPC channel buffer size

Tom Rix (1):
      nfsd: remove unneeded break

Xu Wang (1):
      sunrpc: cache : Replace seq_printf with seq_puts

Zheng Bin (1):
      nfsd: fix comparison to bool warning

 Documentation/admin-guide/nfs/fault_injection.rst |  70 ---
 Documentation/admin-guide/nfs/index.rst           |   1 -
 Documentation/filesystems/nfs/rpc-server-gss.rst  |   5 +-
 MAINTAINERS                                       |   2 +
 fs/lockd/svc4proc.c                               | 248 +++++++--
 fs/lockd/svcproc.c                                | 250 +++++++--
 fs/nfs/nfs4file.c                                 |  38 +-
 fs/nfs/nfs4super.c                                |   5 +
 fs/nfs/super.c                                    |  17 +
 fs/nfs_common/Makefile                            |   1 +
 fs/nfs_common/nfs_ssc.c                           |  94 ++++
 fs/nfsd/Kconfig                                   |  12 +-
 fs/nfsd/Makefile                                  |   1 -
 fs/nfsd/export.c                                  |   2 +-
 fs/nfsd/filecache.c                               |   2 +-
 fs/nfsd/nfs2acl.c                                 | 160 ++++--
 fs/nfsd/nfs3acl.c                                 |  88 ++--
 fs/nfsd/nfs3proc.c                                | 238 +++++----
 fs/nfsd/nfs3xdr.c                                 |  25 +-
 fs/nfsd/nfs4proc.c                                |  34 +-
 fs/nfsd/nfs4state.c                               | 605 +---------------------
 fs/nfsd/nfs4xdr.c                                 | 202 ++++++--
 fs/nfsd/nfscache.c                                |  12 +-
 fs/nfsd/nfsctl.c                                  |   3 -
 fs/nfsd/nfsproc.c                                 | 283 +++++-----
 fs/nfsd/nfssvc.c                                  | 122 +++--
 fs/nfsd/nfsxdr.c                                  |  52 +-
 fs/nfsd/state.h                                   |  27 -
 fs/nfsd/trace.h                                   |   4 +-
 fs/nfsd/vfs.c                                     |   6 +-
 fs/nfsd/xdr.h                                     |  16 +-
 fs/nfsd/xdr3.h                                    |   1 +
 fs/nfsd/xdr4.h                                    |   1 +
 include/linux/nfs_ssc.h                           |  67 +++
 include/linux/sunrpc/xdr.h                        |   2 +
 include/uapi/linux/nfsacl.h                       |   2 +
 net/sunrpc/auth_gss/svcauth_gss.c                 |  27 +-
 net/sunrpc/backchannel_rqst.c                     |   2 +-
 net/sunrpc/cache.c                                |  21 +-
 net/sunrpc/sysctl.c                               |   8 +-
 net/sunrpc/xdr.c                                  |  47 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c                 |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c             |   3 +-
 tools/nfsd/inject_fault.sh                        |  50 --
 44 files changed, 1490 insertions(+), 1368 deletions(-)
 delete mode 100644 Documentation/admin-guide/nfs/fault_injection.rst
 create mode 100644 fs/nfs_common/nfs_ssc.c
 create mode 100644 include/linux/nfs_ssc.h
 delete mode 100755 tools/nfsd/inject_fault.sh
