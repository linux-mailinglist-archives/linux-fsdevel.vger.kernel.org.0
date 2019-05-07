Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E82A16741
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 17:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEGP57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 11:57:59 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46702 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfEGP57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 11:57:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id v17so7331929otp.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2019 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Z5TigwEera364CM2VdxaFhBvvqoQcUUDoPjuwON3M8=;
        b=Fhw5wO5azxXSmUnVRy0VmVZxtI/8TimIdTzYQ/UeoAQYQZGviAYTNksdgqJ+h4IZlZ
         mTokc54qsRDW2yS4EvQ+bDPSH4FN4IflNhrlICbYtcUDota0DTDSg99mmSQiDtoSf8RM
         h7KMdjvi1jKcaWslrq7D0NRQycOzn/nIUefPAYMi5pPAS4MZzUQXex130Qk9KqmdbCgA
         0R3yL7+k/LxSJXiaiPle11wC6eBLMtw1mmTrGkhB4TAaZf7hOXNDW04OmQMQDJQ7s7DR
         WTyr5IX3eLwtE2yFAI+mQoZ9iViMdkKcVLHWFCAbjLvJsw1+eYUPSIO/QHK4niDfxWAj
         /g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Z5TigwEera364CM2VdxaFhBvvqoQcUUDoPjuwON3M8=;
        b=ZXZqdEGtaObHsEj9uBnYCdr6UwaOs5kgVCD4WqMTsmwvdlUFpqJTbFZnUzQzPykky9
         o2Ezd6iQOXP4d/Fi+josC+JxB8LktDsNpUXTNvJziRXZC5paa2cdz0SP6l/ENMefbSfy
         pce4nh4tM7WBvC/jCNbrXQKvhXBOhU8YLJj79X6cQsPP0ptwFkvxJjcHtVwFkGuaivof
         5ACi9c3p0sViWjh5DhGLOL9okUGCmWighf8r4W3nVZcbo8GddrHTd4p4kZxC1xKSjjuK
         arR6uRZPI1i4KfokH1IZbMRaZohkYbe767Kb/7ZFjRLBZ+H2QMcw7If3ZfEI6z4Rrf7P
         Mv7Q==
X-Gm-Message-State: APjAAAVr7cbuKfj7vf/ReN/TcO/Dh2S/GZ2QXBbT/zHoN5uNpi5xD/fC
        4TleAmHdIn+068c0j///5fHISOzSTK4AS3r/IKp2EQ==
X-Google-Smtp-Source: APXvYqznV4n0rtnwALOxXWGajN2p+ua09SAXiEIQ3HSkpkefYwXUadugP+hgxSmobjgqjOaL0Vn4qNDOneSoOTZ4bSE=
X-Received: by 2002:a9d:739a:: with SMTP id j26mr1315767otk.242.1557244677914;
 Tue, 07 May 2019 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <20190502040331.81196-2-ezemtsov@google.com>
In-Reply-To: <20190502040331.81196-2-ezemtsov@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 7 May 2019 17:57:31 +0200
Message-ID: <CAG48ez3SWdcSbdeu9sBx-MUSONgk9_Kmx62NmCALAVou1q9kCw@mail.gmail.com>
Subject: Re: [PATCH 1/6] incfs: Add first files of incrementalfs
To:     ezemtsov@google.com
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+linux-api

On Tue, May 7, 2019 at 4:23 PM <ezemtsov@google.com> wrote:
> - fs/incfs dir
> - Kconfig (CONFIG_INCREMENTAL_FS)
> - Makefile
> - Module and file system initialization and clean up code
> - New MAINTAINERS entry
> - Add incrementalfs.h UAPI header
> - Register ioctl range in ioctl-numbers.txt
> - Documentation
>
> Signed-off-by: Eugene Zemtsov <ezemtsov@google.com>
[...]
> diff --git a/Documentation/filesystems/incrementalfs.rst b/Documentation/=
filesystems/incrementalfs.rst
> new file mode 100644
> index 000000000000..682e3dcb6b5a
> --- /dev/null
> +++ b/Documentation/filesystems/incrementalfs.rst
> @@ -0,0 +1,452 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Incremental File System
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +Incremental FS is special-purpose Linux virtual file system that allows
> +execution of a program while its binary and resource files are still bei=
ng
> +lazily downloaded over the network, USB etc. It is focused on incrementa=
l
> +delivery for a small number (under 100) of big files (more than 10 megab=
ytes).
> +Incremental FS doesn=E2=80=99t allow direct writes into files and, once =
loaded, file
> +content never changes. Incremental FS doesn=E2=80=99t use a block device=
, instead it
> +saves data into a backing file located on a regular file-system.
> +
> +But why?
> +--------
> +To allow running **big** Android apps before their binaries and resource=
s are
> +fully downloaded to an Android device. If an app reads something not loa=
ded yet,
> +it needs to wait for the data block to be fetched, but in most cases hot=
 blocks
> +can be loaded in advance.

But the idea is that eventually, the complete application will be
downloaded, right? You're not planning to download the last few chunks
of an app on demand weeks after it has been installed?

> +Workflow
> +--------
> +A userspace process, called a data loader, mounts an instance of increme=
ntal-fs
> +giving it a file descriptor on an underlying file system (like ext4 or f=
2fs).
> +Incremental-fs reads content (if any) of this backing file and interpret=
s it as
> +a file system image with files, directories and data blocks. At this poi=
nt
> +the data loader can declare new files to be shown by incremental-fs.
> +
> +A process is started from a binary located on incremental-fs.
> +All reads are served directly from the backing file
> +without roundtrips into userspace. If the process accesses a data block =
that was
> +not originally present in the backing file, the read operation waits.
> +
> +Meanwhile the data loader can feed new data blocks to incremental-fs by =
calling
> +write() on a special .cmd pseudo-file. The data loader can request infor=
mation
> +about pending reads by calling poll() and read() on the .cmd pseudo-file=
.
> +This mechanism allows the data loader to serve most urgently needed data=
 first.
> +Once a data block is given to incremental-fs, it saves it to the backing=
 file
> +and unblocks all the reads waiting for this block.
> +
> +Eventually all data for all files is uploaded by the data loader, and sa=
ved by
> +incremental-fs into the backing file. At that moment the data loader is =
not
> +needed any longer. The backing file will play the role of a complete
> +filesystem image for all future runs of the program.

This means that for all future runs, you still need to mount an incfs
instance to be able to access application files, even when the
complete application has been downloaded already, right? Wouldn't it
be nicer if, once the complete application has been downloaded, you
could stop using a shim layer entirely? That way, the performance of
the shim layer would also matter less.

Is there a reason why this thing is not backed by a normal directory
hierarchy on the backing file system, instead of the single image file
you're proposing?

> +External .cmd file interface
> +----------------------------
> +When incremental-fs is mounted, a mount directory contains a pseudo-file
> +called '.cmd'. The data loader will open this file and call read(), writ=
e(),
> +poll() and ioctl() on it inspect and change state of incremental-fs.
> +
> +poll() and read() are used by the data loader to wait for pending reads =
to
> +appear and obtain an array of ``struct incfs_pending_read_info``.
> +
> +write() is used by the data loader to feed new data blocks to incrementa=
l-fs.
> +A data buffer given to write() is interpreted as an array of
> +``struct incfs_new_data_block``. Structs in the array describe locations=
 and
> +properties of data blocks loaded with this write() call.

You can't do that. A write() handler must not interpret written data
as pointers; that must be handled with an ioctl instead.

> +``ioctl(INCFS_IOC_PROCESS_INSTRUCTION)`` is used to change structure of
> +incremental-fs. It receives an pointer to ``struct incfs_instruction``
> +where type field can have be one of the following values.
> +
> +**INCFS_INSTRUCTION_NEW_FILE**
> +Creates an inode (a file or a directory) without a name.
> +It assumes ``incfs_new_file_instruction.file`` is populated with details=
.
> +
> +**INCFS_INSTRUCTION_ADD_DIR_ENTRY**
> +Creates a name (aka hardlink) for an inode in a directory.
> +A directory can't have more than one hardlink pointing to it, but files =
can be
> +linked from different directories.
> +It assumes ``incfs_new_file_instruction.dir_entry`` is populated with de=
tails.
> +
> +**INCFS_INSTRUCTION_REMOVE_DIR_ENTRY**
> +Remove a name (aka hardlink) for a file from a directory.
> +Only empty directories can be unlinked.
> +It assumes ``incfs_new_file_instruction.dir_entry`` is populated with de=
tails.

What is the usecase for removing directory entries?

With the API you're proposing, you're always going to want to populate
the entire directory hierarchy before running an application from
incfs, because otherwise lookups and readdir might fail in a way the
application doesn't expect, right?

> +For more details see in uapi/linux/incrementalfs.h and samples below.
> +
> +Supported mount options
> +-----------------------
> +See ``fs/incfs/options.c`` for more details.
> +
> +    * ``backing_fd=3D<unsigned int>``
> +        Required. A file descriptor of a backing file opened by the proc=
ess
> +        calling mount(2). This descriptor can be closed after mount retu=
rns.
> +
> +    * ``read_timeout_msc=3D<unsigned int>``
> +        Default: 1000. Timeout in milliseconds before a read operation f=
ails
> +        if no data found in the backing file or provided by the data loa=
der.

So... if I run an application from this incremental file system, and
the application page faults on a page that hasn't been loaded yet, and
my phone happens to not have connectivity for a second because it's
moving between wifi and cellular or whatever, the application will
crash?

> +Open .cmd file
> +~~~~~~~~~~~~~~
> +
> +::
> +
> +    int open_commands_file(char *mount_dir)
> +    {
> +        char cmd_file[255];
> +        int cmd_fd;
> +
> +        snprintf(cmd_file, ARRAY_SIZE(cmd_file), "%s/.cmd", mount_dir);
> +        cmd_fd =3D open(cmd_file, O_RDWR);
> +        if (cmd_fd < 0)
> +            perror("Can't open commands file");
> +        return cmd_fd;
> +    }

How is access control for this supposed to work? The command file is
created with mode 0666, so does that mean that any instance of the
application can write arbitrary code into chunks that haven't been
loaded yet, modulo SELinux?

> +Design alternatives
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Why isn't incremental-fs implemented via FUSE?
> +----------------------------------------------
> +TLDR: FUSE-based filesystems add 20-80% of performance overhead for targ=
et
> +scenarios

Really?

> and increase power use on mobile beyond acceptable limit
> +for widespread deployment.

From what I can tell, you only really need this thing to be active
while the application is still being downloaded - and at that point in
time, you're shoving packets over a wireless connection, checking data
integrity, writing blocks to disk, and so on, right? Does FUSE add
noticeable power use to that?

> A custom kernel filesystem is the way to overcome
> +these limitations.

I doubt that. I see two main alternatives that I think would both be better=
:

1. Use a FUSE filesystem to trap writes while files are being
downloaded, then switch to native ext4.
2. Add an eBPF hook in the ext4 read path. The hook would take the
inode number and the offset as input and return a value that indicates
whether the kernel should let the read go through or block the read
and send a notification to userspace over a file descriptor. Sort of
like userfaultfd, except with an eBPF-based fastpath. (And to deal
with readahead, you could perhaps add a flag that is passed through to
the read code to say "this is readahead", and then throw an error
instead of blocking the read.)

> +From the theoretical side of things, FUSE filesystem adds some overhead =
to
> +each filesystem operation that=E2=80=99s not handled by OS page cache:

How many filesystem operations do you have during application download
that are not handled by the OS page cache?

> +    * When an IO request arrives to FUSE driver (D), it puts it into a q=
ueue
> +      that runs on a separate kernel thread
> +    * Then another separate user-mode handler process (H) has to run,
> +      potentially after a context switch, to read the request from the q=
ueue.
> +      Reading the request adds a kernel-user mode transition to the hand=
ling.
> +    * (H) sends the IO request to kernel to handle it on some underlying=
 storage
> +      filesystem. This adds a user-kernel and kernel-user mode transitio=
n
> +      pair to the handling.
> +    * (H) then responds to the FUSE request via a write(2) call.
> +      Writing the response is another user-kernel mode transition.
> +    * (D) needs to read the response from (H) when its kernel thread run=
s
> +      and forward it to the user
> +
> +Together, the scenario adds 2 extra user-kernel-user mode transition pai=
rs,
> +and potentially has up to 3 additional context switches for the FUSE ker=
nel
> +thread and the user-mode handler to start running for each IO request on=
 the
> +filesystem.
> +This overhead can vary from unnoticeable to unmanageable, depending on t=
he
> +target scenario.

Is the overhead of extra context switches really "unmanageable"
compared to the latency of storage?

> But it will always burn extra power via CPU staying longer
> +in non-idle state, handling context switches and mode transitions.
> +One important goal for the new filesystem is to be able to handle each p=
age
> +read separately on demand, because we don't want to wait and download mo=
re data
> +than absolutely necessary. Thus readahead would need to be disabled comp=
letely.
> +This increases the number of separate IO requests and the FUSE related o=
verhead
> +by almost 32x (128KB readahead limit vs 4KB individual block operations)

You could implement the readahead in the FUSE filesystem, no? Check if
adjacent blocks are already available, and if so, shove them into the
page cache without waiting for the kernel to ask for them?

> +For more info see a 2017 USENIX research paper:
> +To FUSE or Not to FUSE: Performance of User-Space File Systems
> +Bharath Kumar Reddy Vangoor, Stony Brook University;
> +Vasily Tarasov, IBM Research-Almaden;
> +Erez Zadok, Stony Brook University
> +https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf

From that paper, the workloads that are interesting for you are either
the seq-rd-1th-1f or the rnd-rd-1th-1f workloads, right?
