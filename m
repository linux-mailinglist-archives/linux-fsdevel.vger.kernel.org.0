Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96592248676
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgHRNxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 09:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHRNxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:53:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFABC061389
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 06:53:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so18373294wra.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=thjbHR66C9mbfkTJErYtUYKaNlwUDKzbLc8lqsZWYuQ=;
        b=Kh2C+IVbGVDluIa2rwC7ayy6dUX9umIllJPrnIfgh26edN5zlQgyqujihJBH4y3E4g
         b1rNC7su8oupxOjDrGo9WICo4WpUTOVNWpVXtbPLCRI5Eh9MTZq/1iT2mKZV2cLI4m1C
         v/7dIj5khQNSTz0BIp8hpMiQvM4vG01fdtV2/bEvJM4czUpaW+iSWPTvBv0yu9o7sGJS
         3dPxxqksQUUrXoHC2FMOUIgCEPSvbn6ropZPI64yIR5T3Q1cJQHuE0aSb/uxVu/kXANw
         ZaZfpelBD4Fmqw42JJygauBslDsVe+y6yqDxLzToxYF2RJEqjSkiKXnQhegVKGoW9nRh
         6XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=thjbHR66C9mbfkTJErYtUYKaNlwUDKzbLc8lqsZWYuQ=;
        b=ECH0IdVODb/3Q51MP529CM5h4oJHcLeD/+VLEH+W1Tmu8r+DO2WQI+1YApkYFmG8m0
         tzV+kc2D9n5S1RQxnjGRwp5+qb5sJ21XZV/P6xEEl5SV0JV4qkVAW1dBBAkNFYyaxHth
         IFkD0pgmgzgMAAuMGfDsXHw06h9qd1pjAC384nQ1vtmQbma61zL/TDqBWrQFtqbjNq3F
         n1dC51Q7tiQYuj1rE+exuy08tSoWsd8pM/Y+rCjHnJaHwRvyAP0i0m6ATHAiU/Ntp1r5
         CXoshlVfnXp8+ivWb69vrskp87hwaqiYsfUNEmMggBWDGDD0UYa+bU77BuO6meaKr4Zk
         3jQA==
X-Gm-Message-State: AOAM530d+jS0VCG89zrEAv/9OSmGjS5V+nKFlYbtFYGaU8Kkleq7BinM
        gp4UcXQeHnwpomcBqc6AuJF93g==
X-Google-Smtp-Source: ABdhPJyk2PCRyesGk7JMHAk08FJ4zgiyMwevuVJCfI8IW0mpQ/eoyAbxBD0wOrr+JpQ5Wt3iVf5+kw==
X-Received: by 2002:adf:ee8e:: with SMTP id b14mr22005449wro.213.1597758795298;
        Tue, 18 Aug 2020 06:53:15 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id a11sm37425838wrq.0.2020.08.18.06.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 06:53:14 -0700 (PDT)
Date:   Tue, 18 Aug 2020 14:53:13 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Nikhilesh Reddy <reddyn@codeaurora.org>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] fuse: Add support for passthrough read/write
Message-ID: <20200818135313.GA3074431@google.com>
References: <20200812161452.3086303-1-balsini@android.com>
 <CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com>
 <20200813132809.GA3414542@google.com>
 <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0jkU7iwdLYPA0=4PdH0SL8wpEPrYvpSztKG3JEhkeHag@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you both for the important feedback,

I tried to consolidate all your suggestions in the new version of the
patch, shared below.

As you both recommended, that tricky ki_filp swapping has been removed,
taking overlayfs as a reference for the management of asynchronous
requests.
The V7 below went again through some testing with fio (sync and libaio
engines with several jobs in randrw), fsstress, and a bunch of kernel
builds to trigger both the sync and async paths. Gladly everything worked
as expected.

What I didn't get from overlayfs are the temporary cred switchings, as I
think that in the FUSE use case it is still the FUSE daemon that should
take care of identifying if the requesting process has the right
permissions before allowing the passthrough feature.

On Thu, Aug 13, 2020 at 08:30:21PM +0200, 'Jann Horn' via kernel-team wrote:
> On Thu, Aug 13, 2020 at 3:28 PM Alessio Balsini <balsini@android.com> wrote:
> [...]
> 
> My point is that you can use this security issue to steal file
> descriptors from processes that are _not_ supposed to act as FUSE
> daemons. For example, let's say there is some setuid root executable
> that opens /etc/shadow and then writes a message to stdout. If I
> invoke this setuid root executable with stdout pointing to a FUSE
> device fd, and I can arrange for the message written by the setuid
> process to look like a FUSE message, I can trick the setuid process to
> install its /etc/shadow fd as a passthrough fd on a FUSE file, and
> then, through the FUSE filesystem, mess with /etc/shadow.
> 
> Also, for context: While on Android, access to /dev/fuse is
> restricted, desktop Linux systems allow unprivileged users to use
> FUSE.
> [...]
> The new fuse_dev_ioctl() command would behave just like
> fuse_dev_write(), except that the ioctl-based interface would permit
> OPEN/CREATE replies with FOPEN_PASSTHROUGH, while the write()-based
> interface would reject them.
> [...]
> I can't think of any checks that you could do there to make it safe,
> because fundamentally what you have to figure out is _userspace's
> intent_, and you can't figure out what that is if userspace just calls
> write().
> [...]
> In this case, an error indicates that the userspace programmer made a
> mistake. So even if the userspace programmer is not looking at kernel
> logs, we should indicate to them that they messed up - and we can do
> that by returning an error code from the syscall. So I think we should
> ideally abort the operation in this case.

I've been thinking about the security issue you mentioned, but I'm thinking
that besides the extra Android restrictions, it shouldn't be that easy to
play with /dev/fuse, also for a privileged process in Linux.
In order for a process to successfully send commands to /dev/fuse, the
command has to match a pending request coming from the FUSE filesystem,
meaning that the same privileged process should have mounted the FUSE
filesystem, actually becoming a FUSE daemon itself.
Is this still an eventually exploitable scenario?

> 
> No, call_write_iter() doesn't do any of the required checking and
> setup and notification steps, it just calls into the file's
> ->write_iter handler:
> 
> static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
>       struct iov_iter *iter)
> {
>         return file->f_op->write_iter(kio, iter);
> }
> 
> Did you confuse call_write_iter() with vfs_iocb_iter_write(), or
> something like that?

Ops, you are right, I was referring to vfs_iocb_iter_write(), that was
actually part of my first design, but ended up simplifying in favor of
call_write_iter().

> Requests can complete asynchronously. That means call_write_iter() can
> return more or less immediately, while the request is processed in the
> background, and at some point, a callback is invoked. That's what that
> -EIOCBQUEUED return value is about. In that case, the current code
> will change ->ki_filp while the request is still being handled in the
> background.
> 
> I recommend looking at ovl_write_iter() in overlayfs to see how
> they're dealing with this case.

That was a great suggestion, I hopefully picked the right things from
overlayfs, without overlooking some security aspects.

Thanks again,
Alessio

---8<---

From 5f0e162d2bb39acf41687ca722e15e95d0721c43 Mon Sep 17 00:00:00 2001
From: Alessio Balsini <balsini@android.com>
Date: Wed, 12 Aug 2020 17:14:52 +0100
Subject: [PATCH v7] fuse: Add support for passthrough read/write

Add support for filesystem passthrough read/write of files when enabled
in userspace through the option FUSE_PASSTHROUGH.

There are filesystems based on FUSE that are intended to enforce special
policies or trigger complicate decision makings at the file operations
level.  Android, for example, uses FUSE to enforce fine-grained access
policies that also depend on the file contents.
Sometimes it happens that at open or create time a file is identified as
not requiring additional checks for consequent reads/writes, thus FUSE
would simply act as a passive bridge between the process accessing the
FUSE filesystem and the lower filesystem. Splicing and caching help
reducing the FUSE overhead, but there are still read/write operations
forwarded to the userspace FUSE daemon that could be avoided.

When the FUSE_PASSTHROUGH capability is enabled, the FUSE daemon may
decide while handling the open or create operations, if the given file
can be accessed in passthrough mode, meaning that all the further read
and write operations would be forwarded by the kernel directly to the
lower filesystem rather than to the FUSE daemon. All requests that are
not reads or writes are still handled by the userspace code.
This allows for improved performance on reads and writes, especially in
the case of reads at random offsets, for which no (readahead) caching
mechanism would help.
Benchmarks show improved performance that is close to native filesystem
access when doing massive manipulations on a single opened file,
especially in the case of random reads, for which the bandwidth
increased by almost 2X or sequential writes for which the improvement is
close to 3X.

The creation of this direct connection (passthrough) between FUSE file
objects and file objects in the lower filesystem happens in a way that
reminds of passing file descriptors via sockets:
- a process opens a file handled by FUSE, so the kernel forwards the
  request to the FUSE daemon;
- the FUSE daemon opens the target file in the lower filesystem, getting
  its file descriptor;
- the file descriptor is passed to the kernel via /dev/fuse;
- the kernel gets the file pointer navigating through the opened files
  of the "current" process and stores it in an additional field in the
  fuse_file owned by the process accessing the FUSE filesystem.
From now all the read/write operations performed by that process will be
redirected to the file pointer pointing at the lower filesystem's file.
Handling asynchronous IO is done by creating separate AIO requests for
the lower filesystem that will be internally tracked by FUSE, that
intercepts and propagates their completion through an internal
ki_completed callback similar to the current implementation of
overlayfs.

Original-patch-by: Nikhilesh Reddy <reddyn@codeaurora.org>
Signed-off-by: Alessio Balsini <balsini@android.com>
--
    Performance

What follows has been performed with this change [V6] rebased on top of a
vanilla v5.8 Linux kernel, using a custom passthrough_hp FUSE daemon that
enables pass-through for each file that is opened during both “open” and
“create”. Tests were run on an Intel Xeon E5-2678V3, 32GiB of RAM, with an
ext4-formatted SSD as the lower filesystem, with no special tuning, e.g., all
the involved processes are SCHED_OTHER, ondemand is the frequency governor with
no frequency restrictions, and turbo-boost, as well as p-state, are active.
This is because I noticed that, for such high-level benchmarks, results
consistency was minimally affected by these features.
The source code of the updated libfuse library and passthrough_hp is shared at
the following repository:

    https://github.com/balsini/libfuse/tree/fuse-passthrough-stable-v.3.9.4

Two different kinds of benchmarks were done for this change, the first set of
tests evaluates the bandwidth improvements when manipulating a huge single
file, the second set of tests verify that no performance regressions were
introduced when handling many small files.

The first benchmarks were done by running FIO (fio-3.21) with:
- bs=4Ki;
- file size: 50Gi;
- ioengine: sync;
- fsync_on_close: true.
The target file has been chosen large enough to avoid it to be entirely loaded
into the page cache.
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

As long as this patch has the primary objective of improving bandwidth, another
set of tests has been performed to see how this behaves on a totally different
scenario that involves accessing many small files. For this purpose, measuring
the build time of the Linux kernel has been chosen as a well-known workload.
The kernel has been built with as many processes as the number of logical CPUs
(-j $(nproc)), that besides being a reasonable number, is also enough to
saturate the processor’s utilization thanks to the additional FUSE daemon’s
threads, making it even harder to get closer to the native filesystem
performance.
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

Changes in v7:
* Full handling of aio requests as done in overlayfs (update commit message).
* s/fget_raw/fget.
* Open fails in case of passthrough errors, emitting warning messages.
  [Proposed by Jann Horn]
* Create new local kiocb, getting rid of the previously proposed ki_filp
  swapping.
  [Proposed by Jann Horn and Jens Axboe]
* Code polishing.

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
    references to the lower file object when the fuse_file is created/deleted.
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
 fs/fuse/dev.c             |   4 +
 fs/fuse/dir.c             |   2 +
 fs/fuse/file.c            |  25 +++--
 fs/fuse/fuse_i.h          |  20 ++++
 fs/fuse/inode.c           |  22 +++-
 fs/fuse/passthrough.c     | 219 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   4 +-
 8 files changed, 286 insertions(+), 11 deletions(-)
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
index 02b3c36b3676..a99c28fd4566 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -506,6 +506,7 @@ ssize_t fuse_simple_request(struct fuse_conn *fc, struct fuse_args *args)
 		BUG_ON(args->out_numargs == 0);
 		ret = args->out_args[args->out_numargs - 1].size;
 	}
+	args->passthrough_filp = req->passthrough_filp;
 	fuse_put_request(fc, req);
 
 	return ret;
@@ -1897,6 +1898,9 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		err = copy_out_args(cs, req->args, nbytes);
 	fuse_copy_finish(cs);
 
+	if (fuse_passthrough_setup(fc, req))
+		err = -EINVAL;
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
index 740a8a7d7ae6..4e2ef3c436d0 100644
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
 
@@ -1093,4 +1106,11 @@ unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
+int __init fuse_passthrough_aio_request_cache_init(void);
+void fuse_passthrough_aio_request_cache_destroy(void);
+int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_req *req);
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
+void fuse_passthrough_release(struct fuse_file *ff);
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b..a8fc9e7fd82e 100644
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
@@ -1428,18 +1435,24 @@ static int __init fuse_fs_init(void)
 	if (!fuse_inode_cachep)
 		goto out;
 
-	err = register_fuseblk();
+	err = fuse_passthrough_aio_request_cache_init();
 	if (err)
 		goto out2;
 
-	err = register_filesystem(&fuse_fs_type);
+	err = register_fuseblk();
 	if (err)
 		goto out3;
 
+	err = register_filesystem(&fuse_fs_type);
+	if (err)
+		goto out4;
+
 	return 0;
 
- out3:
+ out4:
 	unregister_fuseblk();
+ out3:
+	fuse_passthrough_aio_request_cache_destroy();
  out2:
 	kmem_cache_destroy(fuse_inode_cachep);
  out:
@@ -1457,6 +1470,7 @@ static void fuse_fs_cleanup(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(fuse_inode_cachep);
+	fuse_passthrough_aio_request_cache_destroy();
 }
 
 static struct kobject *fuse_kobj;
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
new file mode 100644
index 000000000000..b5eee5acd2a2
--- /dev/null
+++ b/fs/fuse/passthrough.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "fuse_i.h"
+
+#include <linux/aio.h>
+#include <linux/fs_stack.h>
+#include <linux/uio.h>
+
+static struct kmem_cache *fuse_aio_request_cachep;
+
+struct fuse_aio_req {
+	struct kiocb iocb;
+	struct kiocb *iocb_fuse;
+};
+
+static void fuse_copyattr(struct file *dst_file, struct file *src_file,
+			  bool write)
+{
+	struct inode *dst = file_inode(dst_file);
+	struct inode *src = file_inode(src_file);
+
+	fsstack_copy_attr_times(dst, src);
+	if (write)
+		fsstack_copy_inode_size(dst, src);
+}
+
+static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
+{
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+	struct kiocb *iocb = &aio_req->iocb;
+
+	if (iocb->ki_flags & IOCB_WRITE) {
+		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
+				      SB_FREEZE_WRITE);
+		file_end_write(iocb->ki_filp);
+		fuse_copyattr(iocb_fuse->ki_filp, iocb->ki_filp, true);
+	}
+
+	iocb_fuse->ki_pos = iocb->ki_pos;
+	kmem_cache_free(fuse_aio_request_cachep, aio_req);
+}
+
+static void fuse_aio_rw_complete(struct kiocb *iocb, long res, long res2)
+{
+	struct fuse_aio_req *aio_req =
+		container_of(iocb, struct fuse_aio_req, iocb);
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+
+	fuse_aio_cleanup_handler(aio_req);
+	iocb_fuse->ki_complete(iocb_fuse, res, res2);
+}
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
+				   struct iov_iter *iter)
+{
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough_filp;
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (is_sync_kiocb(iocb_fuse)) {
+		struct kiocb iocb;
+
+		kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
+		ret = call_read_iter(passthrough_filp, &iocb, iter);
+		iocb_fuse->ki_pos = iocb.ki_pos;
+	} else {
+		struct fuse_aio_req *aio_req;
+
+		aio_req =
+			kmem_cache_zalloc(fuse_aio_request_cachep, GFP_KERNEL);
+		if (!aio_req)
+			return -ENOMEM;
+
+		aio_req->iocb_fuse = iocb_fuse;
+		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
+		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
+		ret = vfs_iocb_iter_read(passthrough_filp, &aio_req->iocb,
+					 iter);
+		if (ret != -EIOCBQUEUED)
+			fuse_aio_cleanup_handler(aio_req);
+	}
+
+	fuse_copyattr(fuse_filp, passthrough_filp, false);
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
+				    struct iov_iter *iter)
+{
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough_filp;
+	struct inode *passthrough_inode = file_inode(passthrough_filp);
+	struct inode *fuse_inode = file_inode(fuse_filp);
+	ssize_t ret;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	inode_lock(fuse_inode);
+
+	if (is_sync_kiocb(iocb_fuse)) {
+		struct kiocb iocb;
+
+		kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
+
+		file_start_write(passthrough_filp);
+		ret = call_write_iter(passthrough_filp, &iocb, iter);
+		file_end_write(passthrough_filp);
+
+		iocb_fuse->ki_pos = iocb.ki_pos;
+		fuse_copyattr(fuse_filp, passthrough_filp, true);
+	} else {
+		struct fuse_aio_req *aio_req;
+
+		aio_req =
+			kmem_cache_zalloc(fuse_aio_request_cachep, GFP_KERNEL);
+		if (!aio_req)
+			return -ENOMEM;
+
+		file_start_write(passthrough_filp);
+		__sb_writers_release(passthrough_inode->i_sb, SB_FREEZE_WRITE);
+
+		aio_req->iocb_fuse = iocb_fuse;
+		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
+		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
+		ret = vfs_iocb_iter_write(passthrough_filp, &aio_req->iocb,
+					  iter);
+		if (ret != -EIOCBQUEUED)
+			fuse_aio_cleanup_handler(aio_req);
+	}
+
+	inode_unlock(fuse_inode);
+
+	return ret;
+}
+
+int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_req *req)
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
+		return 0;
+
+	if (!(req->in.h.opcode == FUSE_OPEN && req->args->out_numargs == 1) &&
+	    !(req->in.h.opcode == FUSE_CREATE && req->args->out_numargs == 2))
+		return 0;
+
+	open_out_index = req->args->out_numargs - 1;
+
+	if (req->args->out_args[open_out_index].size != sizeof(*open_out))
+		return 0;
+
+	open_out = req->args->out_args[open_out_index].value;
+
+	if (!(open_out->open_flags & FOPEN_PASSTHROUGH))
+		return 0;
+
+	passthrough_filp = fget(open_out->fd);
+	if (!passthrough_filp) {
+		pr_err("FUSE: invalid file descriptor for passthrough.\n");
+		return -1;
+	}
+
+	if (!passthrough_filp->f_op->read_iter ||
+	    !passthrough_filp->f_op->write_iter) {
+		pr_err("FUSE: passthrough file misses file operations.\n");
+		fput(passthrough_filp);
+		return -1;
+	}
+
+	passthrough_inode = file_inode(passthrough_filp);
+	passthrough_sb = passthrough_inode->i_sb;
+	fs_stack_depth = passthrough_sb->s_stack_depth + 1;
+	if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+		pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
+		fput(passthrough_filp);
+		return -1;
+	}
+
+	req->passthrough_filp = passthrough_filp;
+	return 0;
+}
+
+void fuse_passthrough_release(struct fuse_file *ff)
+{
+	if (ff->passthrough_filp) {
+		fput(ff->passthrough_filp);
+		ff->passthrough_filp = NULL;
+	}
+}
+
+int __init fuse_passthrough_aio_request_cache_init(void)
+{
+	fuse_aio_request_cachep =
+		kmem_cache_create("fuse_aio_req", sizeof(struct fuse_aio_req),
+				  0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!fuse_aio_request_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void fuse_passthrough_aio_request_cache_destroy(void)
+{
+	kmem_cache_destroy(fuse_aio_request_cachep);
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
2.28.0.220.ged08abb693-goog

