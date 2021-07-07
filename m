Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC1B3BEA4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhGGPH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 11:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhGGPH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:07:26 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35020C061574;
        Wed,  7 Jul 2021 08:04:46 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1F93E50A1; Wed,  7 Jul 2021 11:04:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1F93E50A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625670285;
        bh=QAOyrzJPOcE2SXamHMXvVsksmrY457V7ch3ClTSWyUY=;
        h=Date:To:Cc:Subject:From:From;
        b=lv0zPNdSNDQ4OLI9sV6ZeMd2gpJkhj9zkbUEH2CSfjeVfX0vKTiQlA2cb947bhqyX
         S9jJ1XEvX9xYBPZnCDxWfFwNNMbkP6iEjL6tf3KKIC86p8gX8xQvyEUamxVamZboin
         yWuilPwxT4fQQgwP9bw2zsFThr6BvOFlpCCVEgmE=
Date:   Wed, 7 Jul 2021 11:04:45 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [GIT PULL] nfsd changes for 5.14
Message-ID: <20210707150445.GA9911@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please pull:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.14

for 5.14 nfsd changes.

Some highlights:
	- add tracepoints for callbacks and for client creation and
	  destruction
	- cache the mounts used for server-to-server copies
	- expose callback information in /proc/fs/nfsd/clients/*/info
	- don't hold locks unnecessarily while waiting for commits
	- update NLM to use xdr_stream, as we have for NFSv2/v3/v4

--b.

ChenXiaoSong (1):
      nfs_common: fix doc warning

Chuck Lever (54):
      NFSD: Fix TP_printk() format specifier in nfsd_clid_class
      NFSD: Add an RPC authflavor tracepoint display helper
      NFSD: Add nfsd_clid_cred_mismatch tracepoint
      NFSD: Add nfsd_clid_verf_mismatch tracepoint
      NFSD: Remove trace_nfsd_clid_inuse_err
      NFSD: Add nfsd_clid_confirmed tracepoint
      NFSD: Add nfsd_clid_reclaim_complete tracepoint
      NFSD: Add nfsd_clid_destroyed tracepoint
      NFSD: Add a couple more nfsd_clid_expired call sites
      NFSD: Add tracepoints for SETCLIENTID edge cases
      NFSD: Add tracepoints for EXCHANGEID edge cases
      NFSD: Constify @fh argument of knfsd_fh_hash()
      NFSD: Capture every CB state transition
      NFSD: Drop TRACE_DEFINE_ENUM for NFSD4_CB_<state> macros
      NFSD: Add cb_lost tracepoint
      NFSD: Adjust cb_shutdown tracepoint
      NFSD: Remove spurious cb_setup_err tracepoint
      NFSD: Enhance the nfsd_cb_setup tracepoint
      NFSD: Add an nfsd_cb_lm_notify tracepoint
      NFSD: Add an nfsd_cb_offload tracepoint
      NFSD: Replace the nfsd_deleg_break tracepoint
      NFSD: Add an nfsd_cb_probe tracepoint
      NFSD: Remove the nfsd_cb_work and nfsd_cb_done tracepoints
      NFSD: Update nfsd_cb_args tracepoint
      lockd: Remove stale comments
      lockd: Create a simplified .vs_dispatch method for NLM requests
      lockd: Common NLM XDR helpers
      lockd: Update the NLMv1 void argument decoder to use struct xdr_stream
      lockd: Update the NLMv1 TEST arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 LOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 CANCEL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 UNLOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 nlm_res arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 SM_NOTIFY arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 SHARE arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 FREE_ALL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv1 void results encoder to use struct xdr_stream
      lockd: Update the NLMv1 TEST results encoder to use struct xdr_stream
      lockd: Update the NLMv1 nlm_res results encoder to use struct xdr_stream
      lockd: Update the NLMv1 SHARE results encoder to use struct xdr_stream
      lockd: Update the NLMv4 void arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 TEST arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 LOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 CANCEL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 UNLOCK arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 nlm_res arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 SM_NOTIFY arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 SHARE arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 FREE_ALL arguments decoder to use struct xdr_stream
      lockd: Update the NLMv4 void results encoder to use struct xdr_stream
      lockd: Update the NLMv4 TEST results encoder to use struct xdr_stream
      lockd: Update the NLMv4 nlm_res results encoder to use struct xdr_stream
      lockd: Update the NLMv4 SHARE results encoder to use struct xdr_stream
      NFSD: Prevent a possible oops in the nfs_dirent() tracepoint

Colin Ian King (2):
      rpc: remove redundant initialization of variable status
      nfsd: remove redundant assignment to pointer 'this'

Dai Ngo (2):
      NFSD: delay unmount source's export after inter-server copy completed.
      nfsd: fix kernel test robot warning in SSC code

Dave Wysochanski (1):
      nfsd4: Expose the callback address and state of each NFS4 client

J. Bruce Fields (4):
      nfsd: move some commit_metadata()s outside the inode lock
      nfsd: move fsnotify on client creation outside spinlock
      nfsd: rpc_peeraddr2str needs rcu lock
      nfsd: fix NULL dereference in nfs3svc_encode_getaclres

Olga Kornievskaia (1):
      NFSD add vfs_fsync after async copy is done

Trond Myklebust (1):
      nfsd: Reduce contention for the nfsd_file nf_rwsem

Wei Yongjun (1):
      NFSD: Fix error return code in nfsd4_interssc_connect()

Yu Hsiang Huang (1):
      nfsd: Prevent truncation of an unlinked inode from blocking access to its directory

Zheng Yongjun (1):
      xprtrdma: Fix spelling mistakes

 fs/lockd/svc.c                    |  43 ++++
 fs/lockd/svcxdr.h                 | 151 ++++++++++++++
 fs/lockd/xdr.c                    | 402 +++++++++++++++++++------------------
 fs/lockd/xdr4.c                   | 403 ++++++++++++++++++++------------------
 fs/nfs_common/grace.c             |   1 +
 fs/nfsd/netns.h                   |   6 +
 fs/nfsd/nfs3acl.c                 |   3 +-
 fs/nfsd/nfs4callback.c            |  47 ++---
 fs/nfsd/nfs4proc.c                | 154 ++++++++++++++-
 fs/nfsd/nfs4state.c               | 177 +++++++++++++----
 fs/nfsd/nfsd.h                    |   4 +
 fs/nfsd/nfsfh.h                   |   7 +-
 fs/nfsd/nfssvc.c                  |   3 +
 fs/nfsd/trace.h                   | 250 +++++++++++++++++------
 fs/nfsd/vfs.c                     |  26 ++-
 fs/nfsd/xdr4.h                    |   1 +
 include/linux/lockd/xdr.h         |   6 -
 include/linux/lockd/xdr4.h        |   7 +-
 include/linux/nfs_ssc.h           |  14 ++
 net/sunrpc/auth_gss/svcauth_gss.c |   2 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c |   6 +-
 21 files changed, 1175 insertions(+), 538 deletions(-)
 create mode 100644 fs/lockd/svcxdr.h
