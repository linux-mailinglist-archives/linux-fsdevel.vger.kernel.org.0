Return-Path: <linux-fsdevel+bounces-29347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D144F978649
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523A41F24CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4A81AC1;
	Fri, 13 Sep 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNxZeJVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C36BFA3;
	Fri, 13 Sep 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246648; cv=none; b=ChsA8nmsCfx7qurFrD0oK9FO+b4sQSvH5PdwDUstcgQTYKrx9Fx+OJoJhHknMOD1H3wAJs2jDcK24knXHJ9mPemkG+X9pQ8GYie4vL6zhiXOOz74GHbcXtcOAjUFg737TR4s06PkMcAGDMjwfBhdJ72kc9VQEd1SuSlzMQir/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246648; c=relaxed/simple;
	bh=RMuylek6k4wQuFye40QyAIsum81oCoU7c/Xx1asARsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t47iazrd4CAuQAhksOKCkcb0SJigzCGont8tKtSnNdep4HJekIUbvuMS07T/P1YcouiY5loFNxPb99jdHz0ivfiQl1ubdXJmThVe6KraxLy7z8CDCJVRrjk21NzITHShn6sdQtQofX0OH3xQr3zqJOVuRnAWE4xMqswkxYCIf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNxZeJVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C320DC4CEC0;
	Fri, 13 Sep 2024 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726246648;
	bh=RMuylek6k4wQuFye40QyAIsum81oCoU7c/Xx1asARsc=;
	h=From:To:Cc:Subject:Date:From;
	b=VNxZeJVLFBxUokeO+/0P1EAnPmS1b5UaqbEzuH/GB95GkP+6XTvdKgXANz41Xsnau
	 4WzgBN8FRydrWmS+UPzc7Puv3wNjnzcTmAXLvX7frZTJKuzBgvbi8/KG3ysLEmmTlF
	 A1vafu0Xd0U9NrEkef/IVouurO/VyvsGPvJxG8LG3G6NOHv9IHtywhmvmedGnELRYw
	 zE6jgf/sNhhz4B0QjlO+WcXSqW5X6JTlso+0Ugx822CoGLDkvnsUT8YtOp7INGTUiT
	 dG+223qrTDrd8a9UPzj8xnj92d2AT5ZkCBqQpxLjgfrrJtG6nstTpaYmuPIPybv015
	 2cwpmMkTycQoQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs netfs
Date: Fri, 13 Sep 2024 18:56:36 +0200
Message-ID: <20240913-vfs-netfs-39ef6f974061@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12101; i=brauner@kernel.org; h=from:subject:message-id; bh=RMuylek6k4wQuFye40QyAIsum81oCoU7c/Xx1asARsc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ9yXtRPD19yyT/iYuP/A57lcddt0ZRUTZX1kvyVcbGp boPrsts6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI9iJGhierF+7RvFb0gHl5 Vn/BvIpD5l/L2i3q9/iFWm94LnFa4Tojw6JNDDPvyM1vE3QI+C7e6LPoyXYdq1cztm58PWm728m mM1wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains the work to improve read/write performance for the new
netfs library.

The main performance enhancing changes are:

    - Define a structure, struct folio_queue, and a new iterator type,
      ITER_FOLIOQ, to hold a buffer as a replacement for ITER_XARRAY. See
      that patch for questions about naming and form.

      ITER_FOLIOQ is provided as a replacement for ITER_XARRAY. The
      problem with an xarray is that accessing it requires the use of a
      lock (typically the RCU read lock) - and this means that we can't
      supply iterate_and_advance() with a step function that might sleep
      (crypto for example) without having to drop the lock between
      pages. ITER_FOLIOQ is the iterator for a chain of folio_queue
      structs, where each folio_queue holds a small list of folios. A
      folio_queue struct is a simpler structure than xarray and is not
      subject to concurrent manipulation by the VM. folio_queue is used
      rather than a bvec[] as it can form lists of indefinite size,
      adding to one end and removing from the other on the fly.

    - Provide a copy_folio_from_iter() wrapper.

    - Make cifs RDMA support ITER_FOLIOQ.

    - Use folio queues in the write-side helpers instead of xarrays.

    - Add a function to reset the iterator in a subrequest.

    - Simplify the write-side helpers to use sheaves to skip gaps rather
      than trying to work out where gaps are.

    - In afs, make the read subrequests asynchronous, putting them into work
      items to allow the next patch to do progressive unlocking/reading.

    - Overhaul the read-side helpers to improve performance.

    - Fix the caching of a partial block at the end of a file.

    - Allow a store to be cancelled.

Then some changes for cifs to make it use folio queues instead of
xarrays for crypto bufferage:

    - Use raw iteration functions rather than manually coding iteration when
      hashing data.

    - Switch to using folio_queue for crypto buffers.

    - Remove the xarray bits.

Make some adjustments to the /proc/fs/netfs/stats file such that:

    - All the netfs stats lines begin 'Netfs:' but change this to something
      a bit more useful.

    - Add a couple of stats counters to track the numbers of skips and waits
      on the per-inode writeback serialisation lock to make it easier to
      check for this as a source of performance loss.

Miscellaneous work:

    - Ensure that the sb_writers lock is taken around
      vfs_{set,remove}xattr() in the cachefiles code.

    - Reduce the number of conditional branches in netfs_perform_write().

    - Move the CIFS_INO_MODIFIED_ATTR flag to the netfs_inode struct and
      remove cifs_post_modify().

    - Move the max_len/max_nr_segs members from netfs_io_subrequest to
      netfs_io_request as they're only needed for one subreq at a time.

    - Add an 'unknown' source value for tracing purposes.

    - Remove NETFS_COPY_TO_CACHE as it's no longer used.

    - Set the request work function up front at allocation time.

    - Use bh-disabling spinlocks for rreq->lock as cachefiles completion may
      be run from block-filesystem DIO completion in softirq context.

    - Remove fs/netfs/io.c.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on the vfs-6.11-rc7.fixes merge to bring in prerequisite
fixes in individual filesystems. All of this has been sitting in linux-next. No
build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known merge conflicts.

This has now a merge conflict with main due to some rather late cifs fixes.
This can be resolved by:

git rm fs/netfs/io.c

and then:

diff --cc fs/smb/client/cifssmb.c
index cfae2e918209,04f2a5441a89..d0df0c17b18f
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@@ -1261,16 -1261,6 +1261,14 @@@ openRetry
        return rc;
  }

 +static void cifs_readv_worker(struct work_struct *work)
 +{
 +      struct cifs_io_subrequest *rdata =
 +              container_of(work, struct cifs_io_subrequest, subreq.work);
 +
-       netfs_subreq_terminated(&rdata->subreq,
-                               (rdata->result == 0 || rdata->result == -EAGAIN) ?
-                               rdata->got_bytes : rdata->result, true);
++      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
 +}
 +
  static void
  cifs_readv_callback(struct mid_q_entry *mid)
  {
@@@ -1323,21 -1306,11 +1321,23 @@@
                rdata->result = -EIO;
        }

 -      if (rdata->result == 0 || rdata->result == -EAGAIN)
 -              iov_iter_advance(&rdata->subreq.io_iter, rdata->got_bytes);
 +      if (rdata->result == -ENODATA) {
 +              __set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 +              rdata->result = 0;
 +      } else {
-               if (rdata->got_bytes < rdata->actual_len &&
-                   rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes ==
-                   ictx->remote_i_size) {
++              size_t trans = rdata->subreq.transferred + rdata->got_bytes;
++              if (trans < rdata->subreq.len &&
++                  rdata->subreq.start + trans == ictx->remote_i_size) {
 +                      __set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 +                      rdata->result = 0;
 +              }
 +      }
 +
        rdata->credits.value = 0;
+       rdata->subreq.transferred += rdata->got_bytes;
 -      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
++      trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
 +      INIT_WORK(&rdata->subreq.work, cifs_readv_worker);
 +      queue_work(cifsiod_wq, &rdata->subreq.work);
        release_mid(mid);
        add_credits(server, &credits, 0);
  }
diff --cc fs/smb/client/smb2pdu.c
index 88dc49d67037,95377bb91950..bb8ecbbe78af
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@@ -4614,6 -4613,10 +4613,8 @@@ smb2_readv_callback(struct mid_q_entry
                              server->credits, server->in_flight,
                              0, cifs_trace_rw_credits_read_response_clear);
        rdata->credits.value = 0;
+       rdata->subreq.transferred += rdata->got_bytes;
 -      if (rdata->subreq.start + rdata->subreq.transferred >= rdata->subreq.rreq->i_size)
 -              __set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+       trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
        INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
        queue_work(cifsiod_wq, &rdata->subreq.work);
        release_mid(mid);

Merge conflicts with other trees
================================

No known merge conflicts.

The following changes since commit 4356ab331c8f0dbed0f683abde345cd5503db1e4:

  Merge tag 'vfs-6.11-rc7.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2024-09-04 09:33:57 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.netfs

for you to fetch changes up to 4b40d43d9f951d87ae8dc414c2ef5ae50303a266:

  docs: filesystems: corrected grammar of netfs page (2024-09-12 12:20:43 +0200)

Please consider pulling these changes from the signed vfs-6.12.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.netfs

----------------------------------------------------------------
Christian Brauner (1):
      Merge branch 'netfs-writeback' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs into vfs.netfs

David Howells (24):
      cachefiles: Fix non-taking of sb_writers around set/removexattr
      netfs: Adjust labels in /proc/fs/netfs/stats
      netfs: Record contention stats for writeback lock
      netfs: Reduce number of conditional branches in netfs_perform_write()
      netfs, cifs: Move CIFS_INO_MODIFIED_ATTR to netfs_inode
      netfs: Move max_len/max_nr_segs from netfs_io_subrequest to netfs_io_stream
      netfs: Reserve netfs_sreq_source 0 as unset/unknown
      netfs: Remove NETFS_COPY_TO_CACHE
      netfs: Set the request work function upon allocation
      netfs: Use bh-disabling spinlocks for rreq->lock
      mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios
      iov_iter: Provide copy_folio_from_iter()
      cifs: Provide the capability to extract from ITER_FOLIOQ to RDMA SGEs
      netfs: Use new folio_queue data type and iterator instead of xarray iter
      netfs: Provide an iterator-reset function
      netfs: Simplify the writeback code
      afs: Make read subreqs async
      netfs: Speed up buffered reading
      netfs: Remove fs/netfs/io.c
      cachefiles, netfs: Fix write to partial block at EOF
      netfs: Cancel dirty folios that have no storage destination
      cifs: Use iterate_and_advance*() routines directly for hashing
      cifs: Switch crypto buffer to use a folio_queue rather than an xarray
      cifs: Don't support ITER_XARRAY

Dennis Lam (1):
      docs: filesystems: corrected grammar of netfs page

 Documentation/filesystems/netfs_library.rst |   2 +-
 fs/9p/vfs_addr.c                            |  11 +-
 fs/afs/file.c                               |  30 +-
 fs/afs/fsclient.c                           |   9 +-
 fs/afs/write.c                              |   4 +-
 fs/afs/yfsclient.c                          |   9 +-
 fs/cachefiles/io.c                          |  19 +-
 fs/cachefiles/xattr.c                       |  34 +-
 fs/ceph/addr.c                              |  76 +--
 fs/netfs/Makefile                           |   4 +-
 fs/netfs/buffered_read.c                    | 766 ++++++++++++++++----------
 fs/netfs/buffered_write.c                   | 309 +++++------
 fs/netfs/direct_read.c                      | 147 ++++-
 fs/netfs/internal.h                         |  43 +-
 fs/netfs/io.c                               | 804 ----------------------------
 fs/netfs/iterator.c                         |  50 ++
 fs/netfs/main.c                             |   7 +-
 fs/netfs/misc.c                             |  94 ++++
 fs/netfs/objects.c                          |  16 +-
 fs/netfs/read_collect.c                     | 544 +++++++++++++++++++
 fs/netfs/read_pgpriv2.c                     | 264 +++++++++
 fs/netfs/read_retry.c                       | 256 +++++++++
 fs/netfs/stats.c                            |  27 +-
 fs/netfs/write_collect.c                    | 246 +++------
 fs/netfs/write_issue.c                      |  93 ++--
 fs/nfs/fscache.c                            |  19 +-
 fs/nfs/fscache.h                            |   7 +-
 fs/smb/client/cifsencrypt.c                 | 144 +----
 fs/smb/client/cifsglob.h                    |   4 +-
 fs/smb/client/cifssmb.c                     |   6 +-
 fs/smb/client/file.c                        |  96 ++--
 fs/smb/client/smb2ops.c                     | 219 ++++----
 fs/smb/client/smb2pdu.c                     |  27 +-
 fs/smb/client/smbdirect.c                   |  82 +--
 include/linux/folio_queue.h                 | 156 ++++++
 include/linux/iov_iter.h                    | 104 ++++
 include/linux/netfs.h                       |  46 +-
 include/linux/uio.h                         |  18 +
 include/trace/events/netfs.h                | 144 +++--
 lib/iov_iter.c                              | 240 ++++++++-
 lib/kunit_iov_iter.c                        | 259 +++++++++
 lib/scatterlist.c                           |  69 ++-
 42 files changed, 3520 insertions(+), 1984 deletions(-)
 delete mode 100644 fs/netfs/io.c
 create mode 100644 fs/netfs/read_collect.c
 create mode 100644 fs/netfs/read_pgpriv2.c
 create mode 100644 fs/netfs/read_retry.c
 create mode 100644 include/linux/folio_queue.h

