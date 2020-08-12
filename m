Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3C242CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHLQPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 12:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgHLQPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:15:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A287C061383
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 09:15:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so2484703wme.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5L8bP8w8sdYaa93LT6ui9hXg+bMeXAbPa0x/OSaa4Q=;
        b=uH6SbdPCmzKRTM8Pi7bVlGPZtQ6nyYz0MRBspLVwLckhxCweqWWqzKsat2ToYUsHwG
         dihgOPN7/j1Q1Z8WGFaCpkq0OCQaAYUuQT2nG3ne+89ToInL052olMic9Xxf8tOAVxob
         WtgOkuRBV14PZKcMjnRbEZPjDlHfOP5kVSP9Yx7/84eJNODgi7kPSBD4qt7bDWMIiH/z
         rHMrN1LkVMpdhIrsd0sdpUBDwTShekB2EXTIV2wBR5JgjVZj4z1jQnNwfTLWut7Ict0K
         /GhbgIc8hlVyfZ+ujE2I+YKl4lfez0eZf+qt8h937ckAzdSW4Mgw834+/WaYupa22Rpb
         3dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P5L8bP8w8sdYaa93LT6ui9hXg+bMeXAbPa0x/OSaa4Q=;
        b=Lp7rFAWWNzzftcKvFHABKccJtt7rvRrN48QWI6/gFit8NWr8pUIxuNgFu7ycf4Np/v
         xvdHnOrkZLOijPwtybCO3xSgCCDoWBQ/4hkIB8tEqB8+2iUBdCMEED2Idg/CLFmoWg8e
         qboafKDBbGcsruWcnpJm0vSht7wrJd8V4ENWLManIaTOlhw7eyNHU4Xk1kHtGcV2gjl9
         S7nKE6maNYA8AX/multN9jr8akU7rUSHSRkBk629OQ3tNRf0I89H8CFXcaxTSgDwbpq8
         8ek3lpLdPUfn+Ps9IOix1znfTa8CvYXX+A7jbay+ar2uZhZ3Q43HEDUQhaOd7bRYyFom
         JgKw==
X-Gm-Message-State: AOAM532+BAgT1uXqKCjl1bn8Y+QaLlszZCu4JCuR5Q8nt2K+rTVOTaX0
        te4a9GbK8aHriaglPkxrMkjYhQ==
X-Google-Smtp-Source: ABdhPJzKsAEpvUfaOPMjlxFfkAwZiKQBycZXmVNAh3RW/7OTu/VZgGjy6ZBqs5mgExYiCVECce9wuw==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr419384wmc.155.1597248905533;
        Wed, 12 Aug 2020 09:15:05 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id l10sm4718995wru.3.2020.08.12.09.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 09:15:04 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Nikhilesh Reddy <reddyn@codeaurora.org>
Cc:     Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] fuse: Add support for passthrough read/write
Date:   Wed, 12 Aug 2020 17:14:52 +0100
Message-Id: <20200812161452.3086303-1-balsini@android.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for filesystem passthrough read/write of files when enabled in
userspace through the option FUSE_PASSTHROUGH.

There are filesystems based on FUSE that are intended to enforce special
policies or trigger complicate decision makings at the file operations
level.  Android, for example, uses FUSE to enforce fine-grained access
policies that also depend on the file contents.
Sometimes it happens that at open or create time a file is identified as
not requiring additional checks for consequent reads/writes, thus FUSE
would simply act as a passive bridge between the process accessing the FUSE
filesystem and the lower filesystem. Splicing and caching help reducing the
FUSE overhead, but there are still read/write operations forwarded to the
userspace FUSE daemon that could be avoided.

When the FUSE_PASSTHROUGH capability is enabled the FUSE daemon may decide
while handling the open or create operations if the given file can be
accessed in passthrough mode, meaning that all the further read and write
operations would be forwarded by the kernel directly to the lower
filesystem rather than to the FUSE daemon. All requests that are not reads
or writes are still handled by the userspace FUSE daemon.
This allows for improved performance on reads and writes. Benchmarks show
improved performance that is close to native filesystem access when doing
massive manipulations on a single opened file, especially in the case of
random reads, for which the bandwidth increased by almost 2X or sequential
writes for which the improvement is close to 3X.

The creation of this direct connection (passthrough) between FUSE file
objects and file objects in the lower filesystem happens in a way that
reminds of passing file descriptors via sockets:
- a process opens a file handled by FUSE, so the kernel forwards the
  request to the FUSE daemon;
- the FUSE daemon opens the target file in the lower filesystem, getting
  its file descriptor;
- the file descriptor is passed to the kernel via /dev/fuse;
- the kernel gets the file pointer navigating through the opened files of
  the "current" process and stores it in an additional field in the
  fuse_file owned by the process accessing the FUSE filesystem.
From now all the read/write operations performed by that process will be
redirected to the file pointer pointing at the lower filesystem's file.

Signed-off-by: Nikhilesh Reddy <reddyn@codeaurora.org>
Signed-off-by: Alessio Balsini <balsini@android.com>
--

    Performance

What follows has been performed with this change rebased on top of a
vanilla v5.8 Linux kernel, using a custom passthrough_hp FUSE daemon that
enables pass-through for each file that is opened during both “open” and
“create”. Tests were run on an Intel Xeon E5-2678V3, 32GiB of RAM, with an
ext4-formatted SSD as the lower filesystem, with no special tuning, e.g.,
all the involved processes are SCHED_OTHER, ondemand is the frequency
governor with no frequency restrictions, and turbo-boost, as well as
p-state, are active. This is because I noticed that, for such high-level
benchmarks, results consistency was minimally affected by these features.

The source code of the updated libfuse library and passthrough_hp is shared
at the following repository:

    https://github.com/balsini/libfuse/tree/fuse-passthrough-stable-v.3.9.4

Two different kinds of benchmarks were done for this change, the first set
of tests evaluates the bandwidth improvements when manipulating a huge
single file, the second set of tests verify that no performance regressions
were introduced when handling many small files.

The first benchmarks were done by running FIO (fio-3.21) with:
- bs=4Ki;
- file size: 50Gi;
- ioengine: sync;
- fsync_on_close: true.
The target file has been chosen large enough to avoid it to be entirely
loaded into the page cache.
Results are presented in the following table:

+-----------+--------+-------------+--------+
| Bandwidth |  FUSE  |     FUSE    |  Bind  |
|  (KiB/s)  |        | passthrough |  mount |
+-----------+--------+-------------+--------+
| read      | 468897 |      502085 | 516830 |
+-----------+--------+-------------+--------+
| randread  |  15773 |       26632 |  21386 |
+-----------+--------+-------------+--------+
| write     |  58185 |      141272 | 141671 |
+-----------+--------+-------------+--------+
| randwrite |  59892 |       75236 |  76486 |
+-----------+--------+-------------+--------+

As long as this patch has the primary objective of improving bandwidth,
another set of tests has been performed to see how this behaves on a
totally different scenario that involves accessing many small files. For
this purpose, measuring the build time of the Linux kernel has been chosen
as a well-known workload.
The kernel has been built with as many processes as the number of logical
CPUs (-j $(nproc)), that besides being a reasonable number, is also enough
to saturate the processor’s utilization thanks to the additional FUSE
daemon’s threads, making it even harder to get closer to the native
filesystem performance.
The following table shows the total build times in the different
configurations:

+------------------+--------------+-----------+
|                  | AVG duration |  Standard |
|                  |     (sec)    | deviation |
+------------------+--------------+-----------+
| FUSE             |      144.566 |     0.697 |
+------------------+--------------+-----------+
| FUSE passthrough |      133.820 |     0.341 |
+------------------+--------------+-----------+
| Raw              |      109.423 |     0.724 |
+------------------+--------------+-----------+

Further testing and performance evaluations are welcome.

Changes in v6:
* Port to kernel v5.8:
  * fuse_file_{read,write}_iter() changed since the v5 of this patch was
    proposed.
* Simplify fuse_simple_request().
* Merge fuse_passthrough.h into fuse_i.h
* Refactor of passthrough.c:
  * Remove BUG_ON()s.
  * Simplified error checking and request arguments indexing.
  * Use call_{read,write}_iter() utility functions.
  * Remove get_file() and fputs() during read/write: handle the extra FUSE
    references to the lower file object when the fuse_file is
    created/deleted.
  [Proposed by Jann Horn]

Changes in v5:
* Fix the check when setting the passthrough file.
  [Found when testing by Mike Shal]

Changes in v3 and v4:
* Use the fs_stack_depth to prevent further stacking and a minor fix.
  [Proposed by Jann Horn]

Changes in v2:
* Changed the feature name to passthrough from stacked_io.
  [Proposed by Linus Torvalds]
---
 fs/fuse/Makefile          |   1 +
 fs/fuse/dev.c             |   3 ++
 fs/fuse/dir.c             |   2 +
 fs/fuse/file.c            |  25 ++++++---
 fs/fuse/fuse_i.h          |  18 +++++++
 fs/fuse/inode.c           |   9 +++-
 fs/fuse/passthrough.c     | 110 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   4 +-
 8 files changed, 164 insertions(+), 8 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 3e8cebfb59b7..6971454a2bdf 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-objs := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o
+fuse-objs += passthrough.o
 virtiofs-y += virtio_fs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36b3676..c2131301eeba 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -506,6 +506,7 @@ ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *args)
 		BUG_ON(args->out_numargs == 0);
 		ret = args->out_args[args->out_numargs - 1].size;
 	}
+	args->passthrough_filp = req->passthrough_filp;
 	fuse_put_request(fc, req);
 
 	return ret;
@@ -1897,6 +1898,8 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		err = copy_out_args(cs, req->args, nbytes);
 	fuse_copy_finish(cs);
 
+	fuse_setup_passthrough(fc, req);
+
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
 	if (!fpq->connected)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b..531de0c5c9e8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -477,6 +477,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[0].value = &outentry;
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
+	args.passthrough_filp = NULL;
 	err = fuse_simple_request(fc, &args);
 	if (err)
 		goto out_free_ff;
@@ -489,6 +490,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	ff->fh = outopen.fh;
 	ff->nodeid = outentry.nodeid;
 	ff->open_flags = outopen.open_flags;
+	ff->passthrough_filp = args.passthrough_filp;
 	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
 			  &outentry.attr, entry_attr_timeout(&outentry), 0);
 	if (!inode) {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 83d917f7e542..c3289ff0cd33 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -33,10 +33,12 @@ static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
 }
 
 static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
-			  int opcode, struct fuse_open_out *outargp)
+			  int opcode, struct fuse_open_out *outargp,
+			  struct file **passthrough_filp)
 {
 	struct fuse_open_in inarg;
 	FUSE_ARGS(args);
+	int ret;
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
@@ -51,7 +53,10 @@ static int fuse_send_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 	args.out_args[0].size = sizeof(*outargp);
 	args.out_args[0].value = outargp;
 
-	return fuse_simple_request(fc, &args);
+	ret = fuse_simple_request(fc, &args);
+	*passthrough_filp = args.passthrough_filp;
+
+	return ret;
 }
 
 struct fuse_release_args {
@@ -144,14 +149,16 @@ int fuse_do_open(struct fuse_conn *fc, u64 nodeid, struct file *file,
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
 	if (isdir ? !fc->no_opendir : !fc->no_open) {
+		struct file *passthrough_filp;
 		struct fuse_open_out outarg;
 		int err;
 
-		err = fuse_send_open(fc, nodeid, file, opcode, &outarg);
+		err = fuse_send_open(fc, nodeid, file, opcode, &outarg,
+				     &passthrough_filp);
 		if (!err) {
 			ff->fh = outarg.fh;
 			ff->open_flags = outarg.open_flags;
-
+			ff->passthrough_filp = passthrough_filp;
 		} else if (err != -ENOSYS) {
 			fuse_file_free(ff);
 			return err;
@@ -281,6 +288,8 @@ void fuse_release_common(struct file *file, bool isdir)
 	struct fuse_release_args *ra = ff->release_args;
 	int opcode = isdir ? FUSE_RELEASEDIR : FUSE_RELEASE;
 
+	fuse_passthrough_release(ff);
+
 	fuse_prepare_release(fi, ff, file->f_flags, opcode);
 
 	if (ff->flock) {
@@ -1543,7 +1552,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough_filp)
+		return fuse_passthrough_read_iter(iocb, to);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
 		return fuse_direct_read_iter(iocb, to);
@@ -1557,7 +1568,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough_filp)
+		return fuse_passthrough_write_iter(iocb, from);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
 		return fuse_direct_write_iter(iocb, from);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 740a8a7d7ae6..5d6f2f913c71 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -208,6 +208,12 @@ struct fuse_file {
 
 	} readdir;
 
+	/**
+	 * Reference to lower filesystem file for read/write operations
+	 * handled in pass-through mode
+	 */
+	struct file *passthrough_filp;
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
@@ -252,6 +258,7 @@ struct fuse_args {
 	bool may_block:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
+	struct file *passthrough_filp;
 	void (*end)(struct fuse_conn *fc, struct fuse_args *args, int error);
 };
 
@@ -353,6 +360,9 @@ struct fuse_req {
 		struct fuse_out_header h;
 	} out;
 
+	/** Lower filesystem file pointer used in pass-through mode */
+	struct file *passthrough_filp;
+
 	/** Used to wake up the task waiting for completion of request*/
 	wait_queue_head_t waitq;
 
@@ -720,6 +730,9 @@ struct fuse_conn {
 	/* Do not show mount options */
 	unsigned int no_mount_options:1;
 
+	/** Pass-through mode for read/write IO */
+	unsigned int passthrough:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
@@ -1093,4 +1106,9 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
+void fuse_setup_passthrough(struct fuse_conn *fc, struct fuse_req *req);
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
+void fuse_passthrough_release(struct fuse_file *ff);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..eb223130a917 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -965,6 +965,12 @@ static void process_init_reply(struct fuse_conn *fc, struct fuse_args *args,
 					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
 					max_t(unsigned int, arg->max_pages, 1));
 			}
+			if (arg->flags & FUSE_PASSTHROUGH) {
+				fc->passthrough = 1;
+				/* Prevent further stacking */
+				fc->sb->s_stack_depth =
+					FILESYSTEM_MAX_STACK_DEPTH;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1002,7 +1008,8 @@ void fuse_send_init(struct fuse_conn *fc)
 		FUSE_WRITEBACK_CACHE | FUSE_NO_OPEN_SUPPORT |
 		FUSE_PARALLEL_DIROPS | FUSE_HANDLE_KILLPRIV | FUSE_POSIX_ACL |
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
-		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA;
+		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
+		FUSE_PASSTHROUGH;
 	ia->args.opcode = FUSE_INIT;
 	ia->args.in_numargs = 1;
 	ia->args.in_args[0].size = sizeof(ia->in);
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
new file mode 100644
index 000000000000..02786a55c3ab
--- /dev/null
+++ b/fs/fuse/passthrough.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "fuse_i.h"
+
+#include <linux/aio.h>
+#include <linux/fs_stack.h>
+
+void fuse_setup_passthrough(struct fuse_conn *fc, struct fuse_req *req)
+{
+	struct super_block *passthrough_sb;
+	struct inode *passthrough_inode;
+	struct fuse_open_out *open_out;
+	struct file *passthrough_filp;
+	unsigned short open_out_index;
+	int fs_stack_depth;
+
+	req->passthrough_filp = NULL;
+
+	if (!fc->passthrough)
+		return;
+
+	if (!(req->in.h.opcode == FUSE_OPEN && req->args->out_numargs == 1) &&
+	    !(req->in.h.opcode == FUSE_CREATE && req->args->out_numargs == 2))
+		return;
+
+	open_out_index = req->args->out_numargs - 1;
+
+	if (req->args->out_args[open_out_index].size != sizeof(*open_out))
+		return;
+
+	open_out = req->args->out_args[open_out_index].value;
+
+	if (!(open_out->open_flags & FOPEN_PASSTHROUGH))
+		return;
+
+	if (open_out->fd < 0)
+		return;
+
+	passthrough_filp = fget_raw(open_out->fd);
+	if (!passthrough_filp)
+		return;
+
+	passthrough_inode = file_inode(passthrough_filp);
+	passthrough_sb = passthrough_inode->i_sb;
+	fs_stack_depth = passthrough_sb->s_stack_depth + 1;
+	if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+		fput(passthrough_filp);
+		return;
+	}
+
+	req->passthrough_filp = passthrough_filp;
+}
+
+static inline ssize_t fuse_passthrough_read_write_iter(struct kiocb *iocb,
+						       struct iov_iter *iter,
+						       bool write)
+{
+	struct file *fuse_filp = iocb->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough_filp;
+	struct inode *passthrough_inode;
+	struct inode *fuse_inode;
+	ssize_t ret = -EIO;
+
+	fuse_inode = fuse_filp->f_path.dentry->d_inode;
+	passthrough_inode = file_inode(passthrough_filp);
+
+	iocb->ki_filp = passthrough_filp;
+
+	if (write) {
+		if (!passthrough_filp->f_op->write_iter)
+			goto out;
+
+		ret = call_write_iter(passthrough_filp, iocb, iter);
+		if (ret >= 0 || ret == -EIOCBQUEUED) {
+			fsstack_copy_inode_size(fuse_inode, passthrough_inode);
+			fsstack_copy_attr_times(fuse_inode, passthrough_inode);
+		}
+	} else {
+		if (!passthrough_filp->f_op->read_iter)
+			goto out;
+
+		ret = call_read_iter(passthrough_filp, iocb, iter);
+		if (ret >= 0 || ret == -EIOCBQUEUED)
+			fsstack_copy_attr_atime(fuse_inode, passthrough_inode);
+	}
+
+out:
+	iocb->ki_filp = fuse_filp;
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	return fuse_passthrough_read_write_iter(iocb, to, false);
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return fuse_passthrough_read_write_iter(iocb, from, true);
+}
+
+void fuse_passthrough_release(struct fuse_file *ff)
+{
+	if (ff->passthrough_filp) {
+		fput(ff->passthrough_filp);
+		ff->passthrough_filp = NULL;
+	}
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 373cada89815..e50bd775210a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -283,6 +283,7 @@ struct fuse_file_lock {
 #define FOPEN_NONSEEKABLE	(1 << 2)
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
+#define FOPEN_PASSTHROUGH	(1 << 5)
 
 /**
  * INIT request/reply flags
@@ -342,6 +343,7 @@ struct fuse_file_lock {
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
 #define FUSE_MAP_ALIGNMENT	(1 << 26)
+#define FUSE_PASSTHROUGH	(1 << 27)
 
 /**
  * CUSE INIT request/reply flags
@@ -591,7 +593,7 @@ struct fuse_create_in {
 struct fuse_open_out {
 	uint64_t	fh;
 	uint32_t	open_flags;
-	uint32_t	padding;
+	int32_t		fd;
 };
 
 struct fuse_release_in {
-- 
2.28.0.236.gb10cc79966-goog

