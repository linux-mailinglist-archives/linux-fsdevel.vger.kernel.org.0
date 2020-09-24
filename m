Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF032771F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 15:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgIXNNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbgIXNNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:13:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F22C0613CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so3506095wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uP1yJZtRXAR2CZTk0DWpcUT9I4b5eMNOzOvstfr8R5g=;
        b=TAZ0MnPOn+Xo/Z+9MdzvJfVWbVCyNt38ECQZwVDE5DM+nDosRJQ+kUtn9QdH3xXjUZ
         CBNt5eGW0FWpfIKXoorf98yKvMt9dHPcjGAw7p/yeKAJrc42L81YIhi2A51m3DNU/xW3
         eyNv1xSJ3hraKUtq8FPxoZXL2oVPvK3ctYm1SJk1pJqZ/XG33ONMwD6qhBCl2OylUUp5
         mipYTg/MEaxQBfggYHX14JI0yS9kT2FFzcf77+83VQm8oWhUtk7Z33MnoBlSZbfjiHoi
         PBvkozEXjzndB1zq/h/E26hzTDNB54ETV4yCLu0BOKNn8DAoUIw8FvC39zsPHlA5SozF
         /KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uP1yJZtRXAR2CZTk0DWpcUT9I4b5eMNOzOvstfr8R5g=;
        b=E0WyMvI2AZQS56z5MU56ej0j2YojdbWBqXjtPIdnINYAfQho1Y+jgwHsZass0zqXIc
         QovOOzfVpF+fGvL7QZu2DACl+y9D+5tzjKHRH5QGutG3GfYLvMWCCyLO9jTEq/E8YG8m
         T2KWTdTuqKiwx8qlLu05N9lPvTf8Bo2MChXqCL1qcahcaDSjRAUv6ypOS0N+SHiEtTL0
         bsdjKTjrf0sEfuSiRm1luGnkZv0P3i0Xt1UuWTwjfJlR2ecEOBRwzF2Br0TpimH4FVpz
         CVliKOD/Nd+DysDQn/aSBFfM8LwtaF6YiU73RmEkXZctqfUokABxX8fkE1qm65KNrpj8
         npvQ==
X-Gm-Message-State: AOAM530dpDLQqw8ZpLbS2Kvqj2cKuloFzpipPXRRVV232PDxKqS7/7WC
        p7TiLc5d/3JXioMSKEfgA1PITA==
X-Google-Smtp-Source: ABdhPJx+Ajs1zmrAcaXn8LUrOlS5IJG5H7/m7w10TrL8GZZ00S+CdnrbiQFLJSKh6z1nutgo1/M4Rw==
X-Received: by 2002:a05:600c:2053:: with SMTP id p19mr4727105wmg.50.1600953203002;
        Thu, 24 Sep 2020 06:13:23 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id k22sm3805044wrd.29.2020.09.24.06.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:13:22 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V9 0/4] fuse: Add support for passthrough read/write
Date:   Thu, 24 Sep 2020 14:13:14 +0100
Message-Id: <20200924131318.2654747-1-balsini@android.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 9th version of the series. Please find the changelog at the
bottom of this cover letter.

Add support for file system passthrough read/write of files when enabled in
userspace through the option FUSE_PASSTHROUGH.

There are file systems based on FUSE that are intended to enforce special
policies or trigger complicated decision makings at the file operations
level. Android, for example, uses FUSE to enforce fine-grained access
policies that also depend on the file contents.
Sometimes it happens that at open or create time a file is identified as
not requiring additional checks for consequent reads/writes, thus FUSE
would simply act as a passive bridge between the process accessing the FUSE
file system and the lower file system. Splicing and caching help reduce the
FUSE overhead, but there are still read/write operations forwarded to the
userspace FUSE daemon that could be avoided.

This series has been inspired by the original patches from Nikhilesh Reddy,
the idea and code of which has been elaborated and improved thanks to the
community support.

When the FUSE_PASSTHROUGH capability is enabled, the FUSE daemon may decide
while handling the open/create operations, if the given file can be
accessed in passthrough mode. This means that all the further read and
write operations would be forwarded by the kernel directly to the lower
file system using the VFS layer rather than to the FUSE daemon. All the
requests other than reads or writes are still handled by the userspace FUSE
daemon.
This allows for improved performance on reads and writes, especially in the
case of reads at random offsets, for which no (readahead) caching mechanism
would help.
Benchmarks show improved performance that is close to native file system
access when doing massive manipulations on a single opened file, especially
in the case of random reads, for which the bandwidth increased by almost 2X
or sequential writes for which the improvement is close to 3X.

The creation of this direct connection (passthrough) between FUSE file
objects and file objects in the lower file system happens in a way that
reminds of passing file descriptors via sockets:
- a process requests the opening of a file handled by FUSE, so the kernel
  forwards the request to the FUSE daemon;
- the FUSE daemon opens the target file in the lower file system, getting
  its file descriptor;
- the FUSE daemon also decides according to its internal policies if
  passthrough can be enabled for that file, and, if so, can perform a
FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() on /dev/fuse, passing the file
descriptor obtained at the previous step and the fuse_req unique
identifier;
- the kernel translates the file descriptor to the file pointer navigating
  through the opened files of the "current" process and temporarily stores
it in the associated open/create fuse_req's passthrough_filp;
- when the FUSE daemon has done with the request and it's time for the
  kernel to close it, it checks if the passthrough_filp is available and in
case updates the additional field in the fuse_file owned by the process
accessing the FUSE file system.
From now on, all the read/write operations performed by that process will
be redirected to the corresponding lower file system file by creating new
VFS requests.
Since the read/write operation to the lower file system is executed with
the current process's credentials, it might happen that it does not have
enough privileges to succeed. For this reason, the process temporarily
receives the same credentials as the FUSE daemon, that are reverted as soon
as the read/write operation completes, emulating the behavior of the
request to be performed by the FUSE daemon itself. This solution has been
inspired by the way overlayfs handles read/write operations.
Asynchronous IO is supported as well, handled by creating separate AIO
requests for the lower file system that will be internally tracked by FUSE,
that intercepts and propagates their completion through an internal
ki_completed callback similar to the current implementation of overlayfs.
The ioctl() has been designed taking as a reference and trying to converge
to the fuse2 implementation. For example, the fuse_passthrough_out data
structure has extra fields that will allow for further extensions of the
feature.


    Performance

What follows has been performed with this change [V6] rebased on top of
vanilla v5.8 Linux kernel, using a custom passthrough_hp FUSE daemon that
enables pass-through for each file that is opened during both “open” and
“create”. Tests were run on an Intel Xeon E5-2678V3, 32GiB of RAM, with an
ext4-formatted SSD as the lower file system, with no special tuning, e.g.,
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
as a well-known workload. The kernel has been built with as many processes
as the number of logical CPUs (-j $(nproc)), that besides being a
reasonable number, is also enough to saturate the processor’s utilization
thanks to the additional FUSE daemon’s threads, making it even harder to
get closer to the native file system performance.
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

Similar performance measurements were performed with the current version of
the patch, the results of which are comparable with what is shown above.
Further testing and performance evaluations are welcome.


    Description of the series

Patch 1 introduces the data structures and definitions required both for
the communication with userspace and for the internal kernel use.
It also adds the basic functionalities to establish the bridge between the
FUSE file and the lower file system file through an ioctl().

Patch 2 creates a reference to the FUSE daemon credentials in the FUSE
connection.

Patch 3 enables the synchronous read and write operations for those FUSE
files for which the passthrough functionality is enabled.

Patch 4 extends the read and write operations to also support asynchronous
IO.

Changes in v9:
* Switched to using VFS instead of direct lower FS file ops
  [Attempt to address a request from Jens Axboe, Jann Horn, Amir Goldstein]
* Removal of useless included aio.h header
  [Proposed by Jens Axboe]

Changes in v8:
* aio requests now use kmalloc/kfree, instead of kmem_cache
* Switched to call_{read,write}_iter in AIO
* Revisited attributes copy
* Passthrough can only be enabled via ioctl(), fixing the security issue
* spotted by Jann
* Use an extensible fuse_passthrough_out data structure
  [Attempt to address a request from Nikolaus Rath, Amir Goldstein and
  Miklos Szeredi]

Changes in v7:
* Full handling of aio requests as done in overlayfs (update commit
* message).
* s/fget_raw/fget.
* Open fails in case of passthrough errors, emitting warning messages.
  [Proposed by Jann Horn]
* Create new local kiocb, getting rid of the previously proposed ki_filp
* swapping.
  [Proposed by Jann Horn and Jens Axboe]
* Code polishing.

Changes in v6:
* Port to kernel v5.8:
  * fuse_file_{read,write}_iter() changed since the v5 of this patch was
  * proposed.
* Simplify fuse_simple_request().
* Merge fuse_passthrough.h into fuse_i.h
* Refactor of passthrough.c:
  * Remove BUG_ON()s.
  * Simplified error checking and request arguments indexing.
  * Use call_{read,write}_iter() utility functions.
  * Remove get_file() and fputs() during read/write: handle the extra FUSE
  * references to the lower file object when the fuse_file is
  * created/deleted.
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


Alessio Balsini (4):
  fuse: Definitions and ioctl() for passthrough
  fuse: Trace daemon creds
  fuse: Introduce synchronous read and write for passthrough
  fuse: Handle asynchronous read and write in passthrough

 fs/fuse/Makefile          |   1 +
 fs/fuse/dev.c             |  57 ++++++++++-
 fs/fuse/dir.c             |   2 +
 fs/fuse/file.c            |  25 +++--
 fs/fuse/fuse_i.h          |  19 ++++
 fs/fuse/inode.c           |  17 +++-
 fs/fuse/passthrough.c     | 208 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  12 ++-
 8 files changed, 328 insertions(+), 13 deletions(-)
 create mode 100644 fs/fuse/passthrough.c

-- 
2.28.0.681.g6f77f65b4e-goog

