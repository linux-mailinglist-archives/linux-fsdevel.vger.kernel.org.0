Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF8A6405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfICIcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 04:32:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbfICIbr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:31:47 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DF3CC057F88
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 08:31:46 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id x77so704989qka.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 01:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bOBhXmB7XsPnZTKOjmS8R6ak4mdY7soUtCxzzOznMSI=;
        b=eIfQrlL6aujIV8q//4TuCl8qRthvjV681L1K5gMWcuKIOwsub+k0E7kxWXA8Ggh17V
         rCDjKrvpofeeiuDT9YADIzSefjF+9yr6Pc05p4lPFyq5X7ljJHVzVa51VxQ1sfp7ok93
         b1TQAYtVySeGhGeBVDfT+K0Sd+tzy8sVgZhvrtAOVlLnPBCkBMooIPC03nRT/kFJ4/zg
         aE1i7HUKDt0Yy+zKvCrZ5BmRZD2DFbVtCPjyov+wPD/BPrqSdvv4VyTSTDfwiEVPWxZ7
         MWPZsr5AHz7nTqX9LnqpOicMhmWY27DI4HwCXG8qZ669WWQdzMg98E8kuYiVOosjYm4x
         IBjQ==
X-Gm-Message-State: APjAAAUqLH31SYEd3GWFta25ziSXt0xzCEEEXbPtMZzcBTtQ8WxX7rkA
        mWYTyS6nDjmTcFt2JfX5wnDujzbUbQ6Q1p/b7rK/Nd29VSVSBfCeefBoMzhDDLJkCIMtSfpRZlt
        Mms9xmw4pTdYX0xs8OB3sXTefwA==
X-Received: by 2002:ac8:1af3:: with SMTP id h48mr32120192qtk.270.1567499505338;
        Tue, 03 Sep 2019 01:31:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqye3UDxaegpAWPrGlAL4csf4++1RYIiST+4zDGhxevZeqMNsC4OPcvPeeTyi7KsADGrhYnLfg==
X-Received: by 2002:ac8:1af3:: with SMTP id h48mr32120163qtk.270.1567499505038;
        Tue, 03 Sep 2019 01:31:45 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id d133sm3169005qkg.31.2019.09.03.01.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 01:31:44 -0700 (PDT)
Date:   Tue, 3 Sep 2019 04:31:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190903041507-mutt-send-email-mst@kernel.org>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:05:02AM +0200, Miklos Szeredi wrote:
> [Cc:  virtualization@lists.linux-foundation.org, "Michael S. Tsirkin"
> <mst@redhat.com>, Jason Wang <jasowang@redhat.com>]
> 
> It'd be nice to have an ACK for this from the virtio maintainers.
> 
> Thanks,
> Miklos

Can the patches themselves be posted to the relevant list(s) please?
If possible, please also include "v3" in all patches so they are
easier to find.

I poked at
https://lwn.net/ml/linux-kernel/20190821173742.24574-1-vgoyal@redhat.com/
specifically
https://lwn.net/ml/linux-kernel/20190821173742.24574-12-vgoyal@redhat.com/
and things like:
+	/* TODO lock */
give me pause.

Cleanup generally seems broken to me - what pauses the FS

What about the rest of TODOs in that file?

use of usleep is hacky - can't we do better e.g. with a
completion?

Some typos - e.g. "reuests".


> 
> On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi,
> >
> > Here are the V3 patches for virtio-fs filesystem. This time I have
> > broken the patch series in two parts. This is first part which does
> > not contain DAX support. Second patch series will contain the patches
> > for DAX support.
> >
> > I have also dropped RFC tag from first patch series as we believe its
> > in good enough shape that it should get a consideration for inclusion
> > upstream.
> >
> > These patches apply on top of 5.3-rc5 kernel and are also available
> > here.
> >
> > https://github.com/rhvgoyal/linux/commits/vivek-5.3-aug-21-2019
> >
> > Patches for V1 and V2 were posted here.
> >
> > https://lwn.net/ml/linux-fsdevel/20181210171318.16998-1-vgoyal@redhat.com/
> > http://lkml.iu.edu/hypermail/linux/kernel/1905.1/07232.html
> >
> > More information about the project can be found here.
> >
> > https://virtio-fs.gitlab.io
> >
> > Changes from V2
> > ===============
> > - Various bug fixes and performance improvements.
> >
> > HOWTO
> > ======
> > We have put instructions on how to use it here.
> >
> > https://virtio-fs.gitlab.io/
> >
> > Some Performance Numbers
> > ========================
> > I have basically run bunch of fio jobs to get a sense of speed of
> > various operations. I wrote a simple wrapper script to run fio jobs
> > 3 times and take their average and report it. These scripts are available
> > here.
> >
> > https://github.com/rhvgoyal/virtiofs-tests
> >
> > I set up a directory on ramfs on host and exported that directory inside
> > guest using virtio-9p and virtio-fs and ran tests inside guests. Ran
> > tests with cache=none both for virtio-9p and virtio-fs so that no caching
> > happens in guest. For virtio-fs, I ran an additional set of tests with
> > dax enabled. Dax is not part of first patch series but I included
> > results here because dax seems to get the maximum performance advantage
> > and its shows the real potential of virtio-fs.
> >
> > Test Setup
> > -----------
> > - A fedora 28 host with 32G RAM, 2 sockets (6 cores per socket, 2
> >   threads per core)
> >
> > - Using ramfs on host as backing store. 4 fio files of 2G each.
> >
> > - Created a VM with 16 VCPUS and 8GB memory. An 8GB cache window (for dax
> >   mmap).
> >
> > Test Results
> > ------------
> > - Results in three configurations have been reported. 9p (cache=none),
> >   virtio-fs (cache=none) and virtio-fs (cache=none + dax).
> >
> >   There are other caching modes as well but to me cache=none seemed most
> >   interesting for now because it does not cache anything in guest
> >   and provides strong coherence. Other modes which provide less strong
> >   coherence and hence are faster are yet to be benchmarked.
> >
> > - Three fio ioengines psync, libaio and mmap have been used.
> >
> > - I/O Workload of randread, radwrite, seqread and seqwrite have been run.
> >
> > - Each file size is 2G. Block size 4K. iodepth=16
> >
> > - "multi" means same operation was done with 4 jobs and each job is
> >   operating on a file of size 2G.
> >
> > - Some results are "0 (KiB/s)". That means that particular operation is
> >   not supported in that configuration.
> >
> > NAME                    I/O Operation           BW(Read/Write)
> >
> > 9p-cache-none           seqread-psync           27(MiB/s)
> > virtiofs-cache-none     seqread-psync           35(MiB/s)
> > virtiofs-dax-cache-none seqread-psync           245(MiB/s)
> >
> > 9p-cache-none           seqread-psync-multi     117(MiB/s)
> > virtiofs-cache-none     seqread-psync-multi     162(MiB/s)
> > virtiofs-dax-cache-none seqread-psync-multi     894(MiB/s)
> >
> > 9p-cache-none           seqread-mmap            24(MiB/s)
> > virtiofs-cache-none     seqread-mmap            0(KiB/s)
> > virtiofs-dax-cache-none seqread-mmap            168(MiB/s)
> >
> > 9p-cache-none           seqread-mmap-multi      115(MiB/s)
> > virtiofs-cache-none     seqread-mmap-multi      0(KiB/s)
> > virtiofs-dax-cache-none seqread-mmap-multi      614(MiB/s)
> >
> > 9p-cache-none           seqread-libaio          26(MiB/s)
> > virtiofs-cache-none     seqread-libaio          139(MiB/s)
> > virtiofs-dax-cache-none seqread-libaio          160(MiB/s)
> >
> > 9p-cache-none           seqread-libaio-multi    129(MiB/s)
> > virtiofs-cache-none     seqread-libaio-multi    142(MiB/s)
> > virtiofs-dax-cache-none seqread-libaio-multi    577(MiB/s)
> >
> > 9p-cache-none           randread-psync          29(MiB/s)
> > virtiofs-cache-none     randread-psync          34(MiB/s)
> > virtiofs-dax-cache-none randread-psync          256(MiB/s)
> >
> > 9p-cache-none           randread-psync-multi    139(MiB/s)
> > virtiofs-cache-none     randread-psync-multi    153(MiB/s)
> > virtiofs-dax-cache-none randread-psync-multi    245(MiB/s)
> >
> > 9p-cache-none           randread-mmap           22(MiB/s)
> > virtiofs-cache-none     randread-mmap           0(KiB/s)
> > virtiofs-dax-cache-none randread-mmap           162(MiB/s)
> >
> > 9p-cache-none           randread-mmap-multi     111(MiB/s)
> > virtiofs-cache-none     randread-mmap-multi     0(KiB/s)
> > virtiofs-dax-cache-none randread-mmap-multi     215(MiB/s)
> >
> > 9p-cache-none           randread-libaio         26(MiB/s)
> > virtiofs-cache-none     randread-libaio         135(MiB/s)
> > virtiofs-dax-cache-none randread-libaio         157(MiB/s)
> >
> > 9p-cache-none           randread-libaio-multi   133(MiB/s)
> > virtiofs-cache-none     randread-libaio-multi   245(MiB/s)
> > virtiofs-dax-cache-none randread-libaio-multi   163(MiB/s)
> >
> > 9p-cache-none           seqwrite-psync          28(MiB/s)
> > virtiofs-cache-none     seqwrite-psync          34(MiB/s)
> > virtiofs-dax-cache-none seqwrite-psync          203(MiB/s)
> >
> > 9p-cache-none           seqwrite-psync-multi    128(MiB/s)
> > virtiofs-cache-none     seqwrite-psync-multi    155(MiB/s)
> > virtiofs-dax-cache-none seqwrite-psync-multi    717(MiB/s)
> >
> > 9p-cache-none           seqwrite-mmap           0(KiB/s)
> > virtiofs-cache-none     seqwrite-mmap           0(KiB/s)
> > virtiofs-dax-cache-none seqwrite-mmap           165(MiB/s)
> >
> > 9p-cache-none           seqwrite-mmap-multi     0(KiB/s)
> > virtiofs-cache-none     seqwrite-mmap-multi     0(KiB/s)
> > virtiofs-dax-cache-none seqwrite-mmap-multi     511(MiB/s)
> >
> > 9p-cache-none           seqwrite-libaio         27(MiB/s)
> > virtiofs-cache-none     seqwrite-libaio         128(MiB/s)
> > virtiofs-dax-cache-none seqwrite-libaio         141(MiB/s)
> >
> > 9p-cache-none           seqwrite-libaio-multi   119(MiB/s)
> > virtiofs-cache-none     seqwrite-libaio-multi   242(MiB/s)
> > virtiofs-dax-cache-none seqwrite-libaio-multi   505(MiB/s)
> >
> > 9p-cache-none           randwrite-psync         27(MiB/s)
> > virtiofs-cache-none     randwrite-psync         34(MiB/s)
> > virtiofs-dax-cache-none randwrite-psync         189(MiB/s)
> >
> > 9p-cache-none           randwrite-psync-multi   137(MiB/s)
> > virtiofs-cache-none     randwrite-psync-multi   150(MiB/s)
> > virtiofs-dax-cache-none randwrite-psync-multi   233(MiB/s)
> >
> > 9p-cache-none           randwrite-mmap          0(KiB/s)
> > virtiofs-cache-none     randwrite-mmap          0(KiB/s)
> > virtiofs-dax-cache-none randwrite-mmap          120(MiB/s)
> >
> > 9p-cache-none           randwrite-mmap-multi    0(KiB/s)
> > virtiofs-cache-none     randwrite-mmap-multi    0(KiB/s)
> > virtiofs-dax-cache-none randwrite-mmap-multi    200(MiB/s)
> >
> > 9p-cache-none           randwrite-libaio        25(MiB/s)
> > virtiofs-cache-none     randwrite-libaio        124(MiB/s)
> > virtiofs-dax-cache-none randwrite-libaio        131(MiB/s)
> >
> > 9p-cache-none           randwrite-libaio-multi  125(MiB/s)
> > virtiofs-cache-none     randwrite-libaio-multi  241(MiB/s)
> > virtiofs-dax-cache-none randwrite-libaio-multi  163(MiB/s)
> >
> > Conclusions
> > ===========
> > - In general virtio-fs seems faster than virtio-9p. Using dax makes it
> >   really interesting.
> >
> > Note:
> >   Right now dax window is 8G and max fio file size is 8G as well (4
> >   files of 2G each). That means everything fits into dax window and no
> >   reclaim is needed. Dax window reclaim logic is slower and if file
> >   size is bigger than dax window size, performance slows down.
> >
> > Description from previous postings
> > ==================================
> >
> > Design Overview
> > ===============
> > With the goal of designing something with better performance and local file
> > system semantics, a bunch of ideas were proposed.
> >
> > - Use fuse protocol (instead of 9p) for communication between guest
> >   and host. Guest kernel will be fuse client and a fuse server will
> >   run on host to serve the requests.
> >
> > - For data access inside guest, mmap portion of file in QEMU address
> >   space and guest accesses this memory using dax. That way guest page
> >   cache is bypassed and there is only one copy of data (on host). This
> >   will also enable mmap(MAP_SHARED) between guests.
> >
> > - For metadata coherency, there is a shared memory region which contains
> >   version number associated with metadata and any guest changing metadata
> >   updates version number and other guests refresh metadata on next
> >   access. This is yet to be implemented.
> >
> > How virtio-fs differs from existing approaches
> > ==============================================
> > The unique idea behind virtio-fs is to take advantage of the co-location
> > of the virtual machine and hypervisor to avoid communication (vmexits).
> >
> > DAX allows file contents to be accessed without communication with the
> > hypervisor. The shared memory region for metadata avoids communication in
> > the common case where metadata is unchanged.
> >
> > By replacing expensive communication with cheaper shared memory accesses,
> > we expect to achieve better performance than approaches based on network
> > file system protocols. In addition, this also makes it easier to achieve
> > local file system semantics (coherency).
> >
> > These techniques are not applicable to network file system protocols since
> > the communications channel is bypassed by taking advantage of shared memory
> > on a local machine. This is why we decided to build virtio-fs rather than
> > focus on 9P or NFS.
> >
> > Caching Modes
> > =============
> > Like virtio-9p, different caching modes are supported which determine the
> > coherency level as well. The “cache=FOO” and “writeback” options control the
> > level of coherence between the guest and host filesystems.
> >
> > - cache=none
> >   metadata, data and pathname lookup are not cached in guest. They are always
> >   fetched from host and any changes are immediately pushed to host.
> >
> > - cache=always
> >   metadata, data and pathname lookup are cached in guest and never expire.
> >
> > - cache=auto
> >   metadata and pathname lookup cache expires after a configured amount of time
> >   (default is 1 second). Data is cached while the file is open (close to open
> >   consistency).
> >
> > - writeback/no_writeback
> >   These options control the writeback strategy.  If writeback is disabled,
> >   then normal writes will immediately be synchronized with the host fs. If
> >   writeback is enabled, then writes may be cached in the guest until the file
> >   is closed or an fsync(2) performed. This option has no effect on mmap-ed
> >   writes or writes going through the DAX mechanism.
> >
> > Thanks
> > Vivek
> >
> > Miklos Szeredi (2):
> >   fuse: delete dentry if timeout is zero
> >   fuse: Use default_file_splice_read for direct IO
> >
> > Stefan Hajnoczi (6):
> >   fuse: export fuse_end_request()
> >   fuse: export fuse_len_args()
> >   fuse: export fuse_get_unique()
> >   fuse: extract fuse_fill_super_common()
> >   fuse: add fuse_iqueue_ops callbacks
> >   virtio_fs: add skeleton virtio_fs.ko module
> >
> > Vivek Goyal (5):
> >   fuse: Export fuse_send_init_request()
> >   Export fuse_dequeue_forget() function
> >   fuse: Separate fuse device allocation and installation in fuse_conn
> >   virtio-fs: Do not provide abort interface in fusectl
> >   init/do_mounts.c: add virtio_fs root fs support
> >
> >  fs/fuse/Kconfig                 |   11 +
> >  fs/fuse/Makefile                |    1 +
> >  fs/fuse/control.c               |    4 +-
> >  fs/fuse/cuse.c                  |    4 +-
> >  fs/fuse/dev.c                   |   89 ++-
> >  fs/fuse/dir.c                   |   26 +-
> >  fs/fuse/file.c                  |   15 +-
> >  fs/fuse/fuse_i.h                |  120 +++-
> >  fs/fuse/inode.c                 |  203 +++---
> >  fs/fuse/virtio_fs.c             | 1061 +++++++++++++++++++++++++++++++
> >  fs/splice.c                     |    3 +-
> >  include/linux/fs.h              |    2 +
> >  include/uapi/linux/virtio_fs.h  |   41 ++
> >  include/uapi/linux/virtio_ids.h |    1 +
> >  init/do_mounts.c                |   10 +
> >  15 files changed, 1462 insertions(+), 129 deletions(-)
> >  create mode 100644 fs/fuse/virtio_fs.c
> >  create mode 100644 include/uapi/linux/virtio_fs.h

Don't the new files need a MAINTAINERS entry?
I think we want virtualization@lists.linux-foundation.org to be
copied.


> >
> > --
> > 2.20.1
> >
