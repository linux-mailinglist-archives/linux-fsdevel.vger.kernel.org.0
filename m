Return-Path: <linux-fsdevel+bounces-39578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C408A15D06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10163A7ED1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 12:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656881898E8;
	Sat, 18 Jan 2025 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTwMTpEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87C13B2A9;
	Sat, 18 Jan 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737204935; cv=none; b=JsHJimtMKLaoAJ/AIreadqtHTzSuHjUFB3RW/4/GdmYaCkRaMEKKsdtMlituiP0VBrOnVRu6yJahRoGzEPYpNEg3bdjR+slZ+iJEfWfbb7XH3irHT1h3NpI4KGbD8c2rGl55Kb0gwt4AgZVvU/GN+Zizc9WaVf3XYgVYgmdI8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737204935; c=relaxed/simple;
	bh=hoRJ0LjhJM/ZKSHlqpJVFf4OPptK7lKMFXoPjphF5eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KiZSAlOkE2dsx0yCH/ys+fHf/2DYcH9B5fx1EEfAsldKuBiEdTse50PqTyR5uz2SKMsh7aGk2jf+5Tpu+1jGwxDFmg4mStxE3ged0DhPgsuKuAvGRtLp7vo8AQKThGaYS/MYMoSeAqw4jqo9VPIqX6dj4PDlyh3X8PnfWZUX/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTwMTpEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52C5C4CED1;
	Sat, 18 Jan 2025 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737204935;
	bh=hoRJ0LjhJM/ZKSHlqpJVFf4OPptK7lKMFXoPjphF5eE=;
	h=From:To:Cc:Subject:Date:From;
	b=DTwMTpEyv5zLU/0lZEGmyoZDRRlbxN+4vTL7h4BrM7ydNiWQKZJaGXe6TehJxTfow
	 Wzsqz7BPDGAjBkCmmYyi4DayLTGI6bYlZDpg2W7lMcGcm15GfBqhWC+3QMkQ28jVQ4
	 dz/RRQ1P7oOkytL7jNna17sg0Ik8ivNqYUN9zZqBmZkvcLQJJogqh+BpNQ9VKd6GKo
	 jnCc6GmdEFlnpwN/lezHsN08sxCTYtY/AP01Ai/8O7+36YcwXcGnZTiQfIZWwzEav2
	 CJRKgNzEExu9vd80leHbQ6PM96YajThNidAR42C/EUkiLJMPsfAOOF9G5DAhIMGdhR
	 W0pKMAIzvt3mQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs netfs
Date: Sat, 18 Jan 2025 13:55:28 +0100
Message-ID: <20250118-vfs-netfs-ba988c7b2167@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16267; i=brauner@kernel.org; h=from:subject:message-id; bh=hoRJ0LjhJM/ZKSHlqpJVFf4OPptK7lKMFXoPjphF5eE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3Lzm4q1Q4q/L1qxPiZ7bJ5PVevfKdTWlvfwyv4tGNV sdjrm306ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIlqWMDN/KJe7KrpmhfdDE Wk/P0//Gn6Zjk95GOP1iM1m0csoNzypGhj3PTALzKgL7u3ZfkmdWXqer4L8vWDLm2LZ24eWyR99 8YQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains read performance improvements and support for monolithic
single-blob objects that have to be read/written as such (e.g. AFS
directory contents). The implementation of the two parts is interwoven
as each makes the other possible.

- Read performance improvements

  The read performance improvements are intended to speed up some loss
  of performance detected in cifs and to a lesser extend in afs. The
  problem is that we queue too many work items during the collection of
  read results: each individual subrequest is collected by its own work
  item, and then they have to interact with each other when a series of
  subrequests don't exactly align with the pattern of folios that are
  being read by the overall request.

  Whilst the processing of the pages covered by individual subrequests
  as they complete potentially allows folios to be woken in parallel and
  with minimum delay, it can shuffle wakeups for sequential reads out of
  order - and that is the most common I/O pattern.

  The final assessment and cleanup of an operation is then held up until
  the last I/O completes - and for a synchronous sequential operation,
  this means the bouncing around of work items just adds latency.

  Two changes have been made to make this work:

  (1) All collection is now done in a single "work item" that works
      progressively through the subrequests as they complete (and also
      dispatches retries as necessary).

  (2) For readahead and AIO, this work item be done on a workqueue and
      can run in parallel with the ultimate consumer of the data; for
      synchronous direct or unbuffered reads, the collection is run in
      the application thread and not offloaded.

  Functions such as smb2_readv_callback() then just tell netfslib that
  the subrequest has terminated; netfslib does a minimal bit of
  processing on the spot - stat counting and tracing mostly - and then
  queues/wakes up the worker.  This simplifies the logic as the
  collector just walks sequentially through the subrequests as they
  complete and walks through the folios, if buffered, unlocking them as
  it goes.  It also keeps to a minimum the amount of latency injected
  into the filesystem's low-level I/O handling

  The way netfs supports filesystems using the deprecated PG_private_2
  flag is changed: folios are flagged and added to a write request as
  they complete and that takes care of scheduling the writes to the
  cache.  The originating read request can then just unlock the pages
  whatever happens.

- Single-blob object support

  Single-blob objects are files for which the content of the file must
  be read from or written to the server in a single operation because
  reading them in parts may yield inconsistent results.  AFS directories
  are an example of this as there exists the possibility that the
  contents are generated on the fly and would differ between reads or
  might change due to third party interference.

  Such objects will be written to and retrieved from the cache if one is
  present, though we allow/may need to propose multiple subrequests to
  do so. The important part is that read from/write to the *server* is
  monolithic.

  Single blob reading is, for the moment, fully synchronous and does
  result collection in the application thread and, also for the moment,
  the API is supplied the buffer in the form of a folio_queue chain
  rather than using the pagecache.

- Related afs changes

  This series makes a number of changes to the kafs filesystem,
  primarily in the area of directory handling:

  - AFS's FetchData RPC reply processing is made partially asynchronous
    which allows the netfs_io_request's outstanding operation counter to
    be removed as part of reducing the collection to a single work item.

  - Directory and symlink reading are plumbed through netfslib using the
    single-blob object API and are now cacheable with fscache. This also
    allows the afs_read struct to be eliminated and netfs_io_subrequest
    to be used directly instead.

  - Directory and symlink content are now stored in a folio_queue buffer
    rather than in the pagecache.  This means we don't require the RCU
    read lock and xarray iteration to access it, and folios won't
    randomly disappear under us because the VM wants them back.

  - The vnode operation lock is changed from a mutex struct to a private
    lock implementation. The problem is that the lock now needs to be
    dropped in a separate thread and mutexes don't permit that.

  - When a new directory or symlink is created, we now initialise it
    locally and mark it valid rather than downloading it (we know what
    it's likely to look like).

  - We now use the in-directory hashtable to reduce the number of
    entries we need to scan when doing a lookup.  The edit routines have
    to maintain the hash chains.

  - Cancellation (e.g. by signal) of an async call after the rxrpc_call
    has been set up is now offloaded to the worker thread as there will
    be a notification from rxrpc upon completion.  This avoids a double
    cleanup.

- A "rolling buffer" implementation is created to abstract out the two
  separate folio_queue chaining implementations I had (one for read and
  one for write).

- Functions are provided to create/extend a buffer in a folio_queue
  chain and tear it down again.  This is used to handle AFS directories,
  but could also be used to create bounce buffers for content crypto and
  transport crypto.

- The was_async argument is dropped from netfs_read_subreq_terminated().
  Instead we wake the read collection work item by either queuing it or
  waking up the app thread.

- We don't need to use BH-excluding locks when communicating between the
  issuing thread and the collection thread as neither of them now run in
  BH context.

- Also included are a number of new tracepoints; a split of the netfslib
  write collection code to put retrying into its own file (it gets more
  complicated with content encryption).

- There are also some minor fixes AFS included, including fixing the AFS
  directory format struct layout, reducing some directory
  over-invalidation and making afs_mkdir() translate EEXIST to ENOTEMPY
  (which is not available on all systems the servers support).

- Finally, there's a patch to try and detect entry into the folio unlock
  function with no folio_queue structs in the buffer (which isn't
  allowed in the cases that can get there).  This is a debugging patch,
  but should be minimal overhead.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

There's a merge conflict that can be resolved as follows:

diff --cc fs/netfs/direct_write.c
index f9421f3e6d37,eded8afaa60b..000000000000
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@@ -67,8 -67,8 +67,8 @@@ ssize_t netfs_unbuffered_write_iter_loc
                 * allocate a sufficiently large bvec array and may shorten the
                 * request.
                 */
 -              if (async || user_backed_iter(iter)) {
 +              if (user_backed_iter(iter)) {
-                       n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
+                       n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
                        if (n < 0) {
                                ret = n;
                                goto out;
@@@ -77,15 -77,8 +77,13 @@@
                        wreq->direct_bv_count = n;
                        wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
                } else {
 +                      /* If this is a kernel-generated async DIO request,
 +                       * assume that any resources the iterator points to
 +                       * (eg. a bio_vec array) will persist till the end of
 +                       * the op.
 +                       */
-                       wreq->iter = *iter;
+                       wreq->buffer.iter = *iter;
                }
-
-               wreq->io_iter = wreq->iter;
        }

        __set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
diff --cc fs/netfs/read_retry.c
index 16b676c68dcd,bf6f26525b0d..000000000000
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@@ -142,25 -125,19 +125,20 @@@ static void netfs_retry_read_subrequest
                        __clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
                        subreq->retry_count++;

-                       spin_lock_bh(&rreq->lock);
-                       list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-                       subreq->prev_donated += rreq->prev_donated;
-                       rreq->prev_donated = 0;
                        trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-                       spin_unlock_bh(&rreq->lock);
-
-                       BUG_ON(!len);

                        /* Renegotiate max_len (rsize) */
+                       stream->sreq_max_len = subreq->len;
 -                      if (rreq->netfs_ops->prepare_read(subreq) < 0) {
 +                      if (rreq->netfs_ops->prepare_read &&
 +                          rreq->netfs_ops->prepare_read(subreq) < 0) {
                                trace_netfs_sreq(subreq, netfs_sreq_trace_reprep_failed);
                                __set_bit(NETFS_SREQ_FAILED, &subreq->flags);
+                               goto abandon;
                        }

-                       part = umin(len, stream0->sreq_max_len);
-                       if (unlikely(rreq->io_streams[0].sreq_max_segs))
-                               part = netfs_limit_iter(&source, 0, part, stream0->sreq_max_segs);
+                       part = umin(len, stream->sreq_max_len);
+                       if (unlikely(stream->sreq_max_segs))
+                               part = netfs_limit_iter(&source, 0, part, stream->sreq_max_segs);
                        subreq->len = subreq->transferred + part;
                        subreq->io_iter = source;
                        iov_iter_truncate(&subreq->io_iter, part);

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 5fe85a5c513344161cde33b79f8badc81b8aa8d3:

  Merge patch series "netfs, ceph, nfs, cachefiles: Miscellaneous fixes/changes" (2024-12-20 22:08:16 +0100)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc1.netfs

for you to fetch changes up to 7a47db23a9f003614e15c687d2a5425c175a9ca8:

  Merge patch series "netfs: Read performance improvements and "single-blob" support" (2024-12-20 22:34:18 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc1.netfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc1.netfs

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "netfs: Read performance improvements and "single-blob" support"

David Howells (31):
      netfs: Clean up some whitespace in trace header
      cachefiles: Clean up some whitespace in trace header
      netfs: Use a folio_queue allocation and free functions
      netfs: Add a tracepoint to log the lifespan of folio_queue structs
      netfs: Abstract out a rolling folio buffer implementation
      netfs: Make netfs_advance_write() return size_t
      netfs: Split retry code out of fs/netfs/write_collect.c
      netfs: Drop the error arg from netfs_read_subreq_terminated()
      netfs: Drop the was_async arg from netfs_read_subreq_terminated()
      netfs: Don't use bh spinlock
      afs: Don't use mutex for I/O operation lock
      afs: Fix EEXIST error returned from afs_rmdir() to be ENOTEMPTY
      afs: Fix directory format encoding struct
      netfs: Remove some extraneous directory invalidations
      cachefiles: Add some subrequest tracepoints
      cachefiles: Add auxiliary data trace
      afs: Add more tracepoints to do with tracking validity
      netfs: Add functions to build/clean a buffer in a folio_queue
      netfs: Add support for caching single monolithic objects such as AFS dirs
      afs: Make afs_init_request() get a key if not given a file
      afs: Use netfslib for directories
      afs: Use netfslib for symlinks, allowing them to be cached
      afs: Eliminate afs_read
      afs: Fix cleanup of immediately failed async calls
      afs: Make {Y,}FS.FetchData an asynchronous operation
      netfs: Change the read result collector to only use one work item
      afs: Make afs_mkdir() locally initialise a new directory's content
      afs: Use the contained hashtable to search a directory
      afs: Locally initialise the contents of a new symlink on creation
      afs: Add a tracepoint for afs_read_receive()
      netfs: Report on NULL folioq in netfs_writeback_unlock_folios()

 fs/9p/vfs_addr.c                  |   6 +-
 fs/afs/Makefile                   |   1 +
 fs/afs/callback.c                 |   4 +-
 fs/afs/dir.c                      | 809 ++++++++++++++++++++------------------
 fs/afs/dir_edit.c                 | 383 ++++++++++--------
 fs/afs/dir_search.c               | 227 +++++++++++
 fs/afs/file.c                     | 260 ++++++------
 fs/afs/fs_operation.c             | 113 +++++-
 fs/afs/fsclient.c                 |  62 +--
 fs/afs/inode.c                    | 140 ++++++-
 fs/afs/internal.h                 | 143 +++++--
 fs/afs/main.c                     |   2 +-
 fs/afs/mntpt.c                    |  22 +-
 fs/afs/rotate.c                   |   4 +-
 fs/afs/rxrpc.c                    |  37 +-
 fs/afs/super.c                    |   4 +-
 fs/afs/validation.c               |  31 +-
 fs/afs/vlclient.c                 |   1 +
 fs/afs/write.c                    |  16 +-
 fs/afs/xdr_fs.h                   |   2 +-
 fs/afs/yfsclient.c                |  49 +--
 fs/cachefiles/io.c                |   4 +
 fs/cachefiles/xattr.c             |   9 +-
 fs/ceph/addr.c                    |  22 +-
 fs/netfs/Makefile                 |   5 +-
 fs/netfs/buffered_read.c          | 290 +++++---------
 fs/netfs/direct_read.c            |  78 ++--
 fs/netfs/direct_write.c           |  10 +-
 fs/netfs/internal.h               |  41 +-
 fs/netfs/main.c                   |   6 +-
 fs/netfs/misc.c                   | 164 ++++----
 fs/netfs/objects.c                |  21 +-
 fs/netfs/read_collect.c           | 761 +++++++++++++++++++++--------------
 fs/netfs/read_pgpriv2.c           | 207 ++++------
 fs/netfs/read_retry.c             | 209 +++++-----
 fs/netfs/read_single.c            | 195 +++++++++
 fs/netfs/rolling_buffer.c         | 226 +++++++++++
 fs/netfs/stats.c                  |   4 +-
 fs/netfs/write_collect.c          | 281 +++----------
 fs/netfs/write_issue.c            | 241 +++++++++++-
 fs/netfs/write_retry.c            | 232 +++++++++++
 fs/nfs/fscache.c                  |   6 +-
 fs/nfs/fscache.h                  |   3 +-
 fs/smb/client/cifssmb.c           |  12 +-
 fs/smb/client/file.c              |   3 +-
 fs/smb/client/smb2ops.c           |   2 +-
 fs/smb/client/smb2pdu.c           |  15 +-
 include/linux/folio_queue.h       |  12 +-
 include/linux/netfs.h             |  54 ++-
 include/linux/rolling_buffer.h    |  61 +++
 include/trace/events/afs.h        | 210 +++++++++-
 include/trace/events/cachefiles.h | 185 ++++-----
 include/trace/events/netfs.h      | 229 +++++------
 lib/kunit_iov_iter.c              |   4 +-
 54 files changed, 3911 insertions(+), 2207 deletions(-)
 create mode 100644 fs/afs/dir_search.c
 create mode 100644 fs/netfs/read_single.c
 create mode 100644 fs/netfs/rolling_buffer.c
 create mode 100644 fs/netfs/write_retry.c
 create mode 100644 include/linux/rolling_buffer.h

