Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34EA11203
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 06:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbfEBEDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 00:03:55 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52991 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfEBEDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 00:03:55 -0400
Received: by mail-pf1-f202.google.com with SMTP id w184so551231pfb.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=aZwfm4SAugDj9zwvtYV/fY+EtwO0yAQl0Qc94D9PEmk=;
        b=b0q54N5Ccszcu8u0tUd0+GcekJSDAHeOfm/CopjeXzs56VqK3/7iRBQiqbsFfTq6BT
         JFKG+JzndtVv4MggMszhoYATHTUwc+9I7vDAmF/6JX4oy0LqRlz21pJ/MCBzxbjAOrJF
         b2M7LEdVDy50tYmWyZlBWIweNeyWtkT6CDspjHBCvBqGhJl3RzUvz/2oq2GPMgnAyxo7
         BQdxH3t6Qkr/eM2k52562E7pL9bjBqF78VqXbB79xLe3nr2nv5hq1uYk5C5ZbiregeP4
         LOEEGZpbpxYdSb0zVSU1RuoXmQ7Yxklsh2hVSPrMlfp8SSi1eaxQ1PiZZRyg40yrtchC
         NzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=aZwfm4SAugDj9zwvtYV/fY+EtwO0yAQl0Qc94D9PEmk=;
        b=hQvFiWKdiLlRRB10G1CES8Lk2DNmLqE5nCfDB2kxMS4gAD5+OFff5FJ9cp+t3vWAmE
         Bq97ReRbs51uKAf+Onq9KiqosaN4pJml8NH/mj6KzVWEpCvHoqiICpp9YiAYJEPYJOqm
         95j1494CQnfiSnL4oYpCmGf9DafR8ByUjAbsi6NfHSDe4M2Dko19yTDpDsiKJx4oDb/H
         Q+4LQfsDUwJnpmIFdwuz9E8EMTK7MJmPZ/CHOYJ/IUp/rtWyOiAv7pnykc4nlyEyjlwl
         7MoocYt/o8iQnUoJUIqMq6pXCdsHNJXMBgbtyL9yzaQGYibtpXoBINOY9mJ0pqXVRpW+
         1jxQ==
X-Gm-Message-State: APjAAAUQ132NYLq7OQwRp/LZrPfBBjO5gZi3YKizRIPCVqHol7cirnfz
        s3uQESB5TkUW2bt6dbNjMNAnd+1FUbeviDt1Z2Bt5snt7xxMj7nOm+duOz8XXgu6bgt/NSyM8bh
        3BdGYr72YsfyvxQn+WfTDqg9SN3k/nfZezoy0ZlWrk3dmcebfiH3rfRGZmgFn5rrUL3Fa6GrZUh
        s=
X-Google-Smtp-Source: APXvYqz7eqJUKoQCHNrcvr6DpDygg0nLSBKy1VA3cU3U8nUMvsBRtc6Vedq3lA6QH+fZFVrvE4xTToMHpA43KA==
X-Received: by 2002:a63:4a5a:: with SMTP id j26mr1497030pgl.361.1556769833783;
 Wed, 01 May 2019 21:03:53 -0700 (PDT)
Date:   Wed,  1 May 2019 21:03:26 -0700
In-Reply-To: <20190502040331.81196-1-ezemtsov@google.com>
Message-Id: <20190502040331.81196-2-ezemtsov@google.com>
Mime-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 1/6] incfs: Add first files of incrementalfs
From:   ezemtsov@google.com
To:     linux-fsdevel@vger.kernel.org
Cc:     tytso@mit.edu, Eugene Zemtsov <ezemtsov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eugene Zemtsov <ezemtsov@google.com>

- fs/incfs dir
- Kconfig (CONFIG_INCREMENTAL_FS)
- Makefile
- Module and file system initialization and clean up code
- New MAINTAINERS entry
- Add incrementalfs.h UAPI header
- Register ioctl range in ioctl-numbers.txt
- Documentation

Signed-off-by: Eugene Zemtsov <ezemtsov@google.com>
---
 Documentation/filesystems/incrementalfs.rst | 452 ++++++++++++++++++++
 Documentation/ioctl/ioctl-number.txt        |   1 +
 MAINTAINERS                                 |   7 +
 fs/Kconfig                                  |   1 +
 fs/Makefile                                 |   1 +
 fs/incfs/Kconfig                            |  10 +
 fs/incfs/Makefile                           |   4 +
 fs/incfs/main.c                             |  85 ++++
 fs/incfs/vfs.c                              |  37 ++
 include/uapi/linux/incrementalfs.h          | 189 ++++++++
 10 files changed, 787 insertions(+)
 create mode 100644 Documentation/filesystems/incrementalfs.rst
 create mode 100644 fs/incfs/Kconfig
 create mode 100644 fs/incfs/Makefile
 create mode 100644 fs/incfs/main.c
 create mode 100644 fs/incfs/vfs.c
 create mode 100644 include/uapi/linux/incrementalfs.h

diff --git a/Documentation/filesystems/incrementalfs.rst b/Documentation/fi=
lesystems/incrementalfs.rst
new file mode 100644
index 000000000000..682e3dcb6b5a
--- /dev/null
+++ b/Documentation/filesystems/incrementalfs.rst
@@ -0,0 +1,452 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Incremental File System
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+Incremental FS is special-purpose Linux virtual file system that allows
+execution of a program while its binary and resource files are still being
+lazily downloaded over the network, USB etc. It is focused on incremental
+delivery for a small number (under 100) of big files (more than 10 megabyt=
es).
+Incremental FS doesn=E2=80=99t allow direct writes into files and, once lo=
aded, file
+content never changes. Incremental FS doesn=E2=80=99t use a block device, =
instead it
+saves data into a backing file located on a regular file-system.
+
+But why?
+--------
+To allow running **big** Android apps before their binaries and resources =
are
+fully downloaded to an Android device. If an app reads something not loade=
d yet,
+it needs to wait for the data block to be fetched, but in most cases hot b=
locks
+can be loaded in advance.
+
+Workflow
+--------
+A userspace process, called a data loader, mounts an instance of increment=
al-fs
+giving it a file descriptor on an underlying file system (like ext4 or f2f=
s).
+Incremental-fs reads content (if any) of this backing file and interprets =
it as
+a file system image with files, directories and data blocks. At this point
+the data loader can declare new files to be shown by incremental-fs.
+
+A process is started from a binary located on incremental-fs.
+All reads are served directly from the backing file
+without roundtrips into userspace. If the process accesses a data block th=
at was
+not originally present in the backing file, the read operation waits.
+
+Meanwhile the data loader can feed new data blocks to incremental-fs by ca=
lling
+write() on a special .cmd pseudo-file. The data loader can request informa=
tion
+about pending reads by calling poll() and read() on the .cmd pseudo-file.
+This mechanism allows the data loader to serve most urgently needed data f=
irst.
+Once a data block is given to incremental-fs, it saves it to the backing f=
ile
+and unblocks all the reads waiting for this block.
+
+Eventually all data for all files is uploaded by the data loader, and save=
d by
+incremental-fs into the backing file. At that moment the data loader is no=
t
+needed any longer. The backing file will play the role of a complete
+filesystem image for all future runs of the program.
+
+Non-goals
+---------
+* Allowing direct writes by the executing processes into files on incremen=
tal-fs
+* Allowing the data loader change file size or content after it was loaded=
.
+* Having more than a couple hundred files and directories.
+
+
+Features
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Read-only, but not unchanging
+-----------------------------
+On the surface a mount directory of incremental-fs would look similar to
+a read-only instance of network file system: files and directories can be
+listed and read, but can=E2=80=99t be directly created or modified via cre=
at() or
+write(). At the same time the data loader can make changes to a directory
+structure via external ioctl-s. i.e. link and unlink files and directories
+(if they empty). Data can't be changed this way, once a file block is load=
ed
+there is no way to change it.
+
+Filesystem image in a backing file
+----------------------------------
+Instead of using a block device, all data and metadata is stored in a
+backing file provided as a mount parameter. The backing file is located on
+an underlying file system (like ext4 or f2fs). Such approach is very simil=
ar
+to what might be achieved by using loopback device with a traditional file
+system, but it avoids extra set-up steps and indirections. It also allows
+incremental-fs image to dynamically grow as new files and data come withou=
t
+having to do any extra steps for resizing.
+
+If the backing file contains data at the moment when incremental-fs is mou=
nted,
+content of the backing file is being interpreted as filesystem image.
+New files and data can still be added through the external interface,
+and they will be saved to the backing file.
+
+Data compression
+----------------
+Incremental-fs can store compressed data. In this case each 4KB data block=
 is
+compressed separately. Data blocks can be provided to incremental-fs by
+the data loader in a compressed form. Incremental-fs uncompresses blocks
+each time a executing process reads it (modulo page cache). Compression al=
so
+takes care of blocks composed of all zero bytes removing necessity to hand=
le
+this case separately.
+
+Partially present files
+-----------------------
+Data in the files consists of 4KB blocks, each block can be present or abs=
ent.
+Unlike in sparse files, reading an absent block doesn=E2=80=99t return all=
 zeros.
+It waits for the data block to be loaded via the ioctl interface
+(respecting a timeout). Once a data block is loaded it never disappears
+and can=E2=80=99t be changed or erased from a file. This ability to fricti=
onlessly
+wait for temporary missing data is the main feature of incremental-fs.
+
+Hard links. Multiple names for the same file
+--------------------------------------------
+Like all traditional UNIX file systems, incremental-fs supports hard links=
,
+i.e. different file names in different directories can refer to the same f=
ile.
+As mentioned above new hard links can be created and removed via
+the ioctl interface, but actual data files are immutable, modulo partial
+data loading. Each directory can only have at most one name referencing it=
.
+
+Inspection of incremental-fs internal state
+-------------------------------------------
+poll() and read() on the .cmd pseudo-file allow data loaders to get a list=
 of
+read operations stalled due to lack of a data block (pending reads).
+
+
+Application Programming Interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Regular file system interface
+-----------------------------
+Executing process access files and directories via regular Linux file inte=
rface:
+open, read, close etc. All the intricacies of data loading a file represen=
tation
+are hidden from them.
+
+External .cmd file interface
+----------------------------
+When incremental-fs is mounted, a mount directory contains a pseudo-file
+called '.cmd'. The data loader will open this file and call read(), write(=
),
+poll() and ioctl() on it inspect and change state of incremental-fs.
+
+poll() and read() are used by the data loader to wait for pending reads to
+appear and obtain an array of ``struct incfs_pending_read_info``.
+
+write() is used by the data loader to feed new data blocks to incremental-=
fs.
+A data buffer given to write() is interpreted as an array of
+``struct incfs_new_data_block``. Structs in the array describe locations a=
nd
+properties of data blocks loaded with this write() call.
+
+``ioctl(INCFS_IOC_PROCESS_INSTRUCTION)`` is used to change structure of
+incremental-fs. It receives an pointer to ``struct incfs_instruction``
+where type field can have be one of the following values.
+
+**INCFS_INSTRUCTION_NEW_FILE**
+Creates an inode (a file or a directory) without a name.
+It assumes ``incfs_new_file_instruction.file`` is populated with details.
+
+**INCFS_INSTRUCTION_ADD_DIR_ENTRY**
+Creates a name (aka hardlink) for an inode in a directory.
+A directory can't have more than one hardlink pointing to it, but files ca=
n be
+linked from different directories.
+It assumes ``incfs_new_file_instruction.dir_entry`` is populated with deta=
ils.
+
+**INCFS_INSTRUCTION_REMOVE_DIR_ENTRY**
+Remove a name (aka hardlink) for a file from a directory.
+Only empty directories can be unlinked.
+It assumes ``incfs_new_file_instruction.dir_entry`` is populated with deta=
ils.
+
+For more details see in uapi/linux/incrementalfs.h and samples below.
+
+Supported mount options
+-----------------------
+See ``fs/incfs/options.c`` for more details.
+
+    * ``backing_fd=3D<unsigned int>``
+        Required. A file descriptor of a backing file opened by the proces=
s
+        calling mount(2). This descriptor can be closed after mount return=
s.
+
+    * ``read_timeout_msc=3D<unsigned int>``
+        Default: 1000. Timeout in milliseconds before a read operation fai=
ls
+        if no data found in the backing file or provided by the data loade=
r.
+
+Sysfs files
+-----------
+``/sys/fs/incremental-fs/version`` - a current version of the filesystem.
+One ASCII encoded positive integer number with a new line at the end.
+
+
+Examples
+--------
+See ``sample_data_loader.c`` for a complete implementation of a data loade=
r.
+
+Mount incremental-fs
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    int mount_fs(char *mount_dir, char *backing_file, int timeout_msc)
+    {
+        static const char fs_name[] =3D INCFS_NAME;
+        char mount_options[512];
+        int backing_fd;
+        int result;
+
+        backing_fd =3D open(backing_file, O_RDWR);
+        if (backing_fd =3D=3D -1) {
+            perror("Error in opening backing file");
+            return 1;
+        }
+
+        snprintf(mount_options, ARRAY_SIZE(mount_options),
+            "backing_fd=3D%u,read_timeout_msc=3D%u", backing_fd, timeout_m=
sc);
+
+        result =3D mount(fs_name, mount_dir, fs_name, 0, mount_options);
+        if (result !=3D 0)
+            perror("Error mounting fs.");
+        return result;
+    }
+
+Open .cmd file
+~~~~~~~~~~~~~~
+
+::
+
+    int open_commands_file(char *mount_dir)
+    {
+        char cmd_file[255];
+        int cmd_fd;
+
+        snprintf(cmd_file, ARRAY_SIZE(cmd_file), "%s/.cmd", mount_dir);
+        cmd_fd =3D open(cmd_file, O_RDWR);
+        if (cmd_fd < 0)
+            perror("Can't open commands file");
+        return cmd_fd;
+    }
+
+Add a file to the file system
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    int create_file(int cmd_fd, char *filename, int *ino_out, size_t size)
+    {
+        int ret =3D 0;
+        __u16 ino =3D 0;
+        struct incfs_instruction inst =3D {
+                .version =3D INCFS_HEADER_VER,
+                .type =3D INCFS_INSTRUCTION_NEW_FILE,
+                .file =3D {
+                    .size =3D size,
+                    .mode =3D S_IFREG | 0555,
+                }
+        };
+
+        ret =3D ioctl(cmd_fd, INCFS_IOC_PROCESS_INSTRUCTION, &inst);
+        if (ret)
+            return -errno;
+
+        ino =3D inst.file.ino_out;
+        inst =3D (struct incfs_instruction){
+                .version =3D INCFS_HEADER_VER,
+                .type =3D INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+                .dir_entry =3D {
+                    .dir_ino =3D INCFS_ROOT_INODE,
+                    .child_ino =3D ino,
+                    .name =3D ptr_to_u64(filename),
+                    .name_len =3D strlen(filename)
+                }
+            };
+        ret =3D ioctl(cmd_fd, INCFS_IOC_PROCESS_INSTRUCTION, &inst);
+        if (ret)
+            return -errno;
+        *ino_out =3D ino;
+        return 0;
+    }
+
+Load data into a file
+~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    int cmd_fd =3D open_commands_file(path_to_mount_dir);
+    char *data =3D get_some_data();
+    struct incfs_new_data_block block;
+    int err;
+
+    block.file_ino =3D file_ino;
+    block.block_index =3D 0;
+    block.compression =3D COMPRESSION_NONE;
+    block.data =3D (__u64)data;
+    block.data_len =3D INCFS_DATA_FILE_BLOCK_SIZE;
+
+    err =3D write(cmd_fd, &block, sizeof(block));
+
+
+Get an array of pending reads
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    int poll_res =3D 0;
+    struct incfs_pending_read_info reads[10];
+    int cmd_fd =3D open_commands_file(path_to_mount_dir);
+    struct pollfd pollfd =3D {
+        .fd =3D cmd_fd,
+        .events =3D POLLIN
+    };
+
+    poll_res =3D poll(&pollfd, 1, timeout);
+    if (poll_res > 0 && (pollfd.revents | POLLIN)) {
+        ssize_t read_res =3D read(cmd_fd, reads, sizeof(reads));
+        if (read_res > 0)
+            printf("Waiting reads %ld\n", read_res / sizeof(reads[0]));
+    }
+
+
+
+Ondisk format
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+General principles
+------------------
+* The backbone of the incremental-fs ondisk format is an append only linke=
d
+  list of metadata blocks. Each metadata block contains an offset of the n=
ext
+  one. These blocks describe files and directories on the
+  file system. They also represent actions of adding and removing file nam=
es
+  (hard links).
+  Every time incremental-fs instance is mounted, it reads through this lis=
t
+  to recreate filesystem's state in memory. An offset of the first record =
in the
+  metadata list is stored in the superblock at the beginning of the backin=
g
+  file.
+
+* Most of the backing file is taken by data areas and blockmaps.
+  Since data blocks can be compressed and have different sizes,
+  single per-file data area can't be pre-allocated. That's why blockmaps a=
re
+  needed in order to find a location and size of each data block in
+  the backing file. Each time a file is created, a corresponding block map=
 is
+  allocated to store future offsets of data blocks.
+
+  Whenever a data block is given by data loader to incremental-fs:
+    - A data area with the given block is appended to the end of
+      the backing file.
+    - A record in the blockmap for the given block index is updated to ref=
lect
+      its location, size, and compression algorithm.
+
+Important format details
+------------------------
+Ondisk structures are defined in the ``format.h`` file. They are all packe=
d
+and use little-endian order.
+A backing file must start with ``incfs_super_block`` with ``s_magic`` fiel=
d
+equal to 0x5346434e49 "INCFS".
+
+Metadata records:
+
+* ``incfs_inode`` - metadata record to declare a file or a directory.
+                    ``incfs_inode.i_mode`` determents if it is a file
+                    or a directory.
+* ``incfs_blockmap_entry`` - metadata record that specifies size and locat=
ion
+                            of a blockmap area for a given file. This area
+                            contains an array of ``incfs_blockmap_entry``-=
s.
+* ``incfs_dir_action`` - metadata record that specifies changes made to a
+                    to a directory structure, e.g. add or remove a hardlin=
k.
+* ``incfs_md_header`` - header of a metadata record. It's always a part
+                    of other structures and served purpose of metadata
+                    bookkeeping.
+
+Other ondisk structures:
+
+* ``incfs_super_block`` - backing file header
+* ``incfs_blockmap_entry`` - a record in a blockmap area that describes si=
ze
+                        and location of a data block.
+* Data blocks dont have any particular structure, they are written to the =
backing
+  file in a raw form as they come from a data loader.
+
+
+Backing file layout
+-------------------
+::
+
+              +-------------------------------------------+
+              |            incfs_super_block              |]---+
+              +-------------------------------------------+    |
+              |                 metadata                  |<---+
+              |                incfs_inode                |]---+
+              +-------------------------------------------+    |
+                        .........................              |
+              +-------------------------------------------+    |   metadat=
a
+     +------->|               blockmap area               |    |  list lin=
ks
+     |        |          [incfs_blockmap_entry]           |    |
+     |        |          [incfs_blockmap_entry]           |    |
+     |        |          [incfs_blockmap_entry]           |    |
+     |    +--[|          [incfs_blockmap_entry]           |    |
+     |    |   |          [incfs_blockmap_entry]           |    |
+     |    |   |          [incfs_blockmap_entry]           |    |
+     |    |   +-------------------------------------------+    |
+     |    |             .........................              |
+     |    |   +-------------------------------------------+    |
+     |    |   |                 metadata                  |<---+
+     +----|--[|               incfs_blockmap              |]---+
+          |   +-------------------------------------------+    |
+          |             .........................              |
+          |   +-------------------------------------------+    |
+          +-->|                 data block                |    |
+              +-------------------------------------------+    |
+                        .........................              |
+              +-------------------------------------------+    |
+              |                 metadata                  |<---+
+              |             incfs_dir_action              |
+              +-------------------------------------------+
+
+Unreferenced files and absence of garbage collection
+----------------------------------------------------
+Described file format can produce files that don't have any names for them=
 in
+any directories. Incremental-fs takes no steps to prevent such situations =
or
+reclaim space occupied by such files in the backing file. If garbage colle=
ction
+is needed it has to be implemented as a separate userspace tool.
+
+
+Design alternatives
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Why isn't incremental-fs implemented via FUSE?
+----------------------------------------------
+TLDR: FUSE-based filesystems add 20-80% of performance overhead for target
+scenarios, and increase power use on mobile beyond acceptable limit
+for widespread deployment. A custom kernel filesystem is the way to overco=
me
+these limitations.
+
+From the theoretical side of things, FUSE filesystem adds some overhead to
+each filesystem operation that=E2=80=99s not handled by OS page cache:
+
+    * When an IO request arrives to FUSE driver (D), it puts it into a que=
ue
+      that runs on a separate kernel thread
+    * Then another separate user-mode handler process (H) has to run,
+      potentially after a context switch, to read the request from the que=
ue.
+      Reading the request adds a kernel-user mode transition to the handli=
ng.
+    * (H) sends the IO request to kernel to handle it on some underlying s=
torage
+      filesystem. This adds a user-kernel and kernel-user mode transition
+      pair to the handling.
+    * (H) then responds to the FUSE request via a write(2) call.
+      Writing the response is another user-kernel mode transition.
+    * (D) needs to read the response from (H) when its kernel thread runs
+      and forward it to the user
+
+Together, the scenario adds 2 extra user-kernel-user mode transition pairs=
,
+and potentially has up to 3 additional context switches for the FUSE kerne=
l
+thread and the user-mode handler to start running for each IO request on t=
he
+filesystem.
+This overhead can vary from unnoticeable to unmanageable, depending on the
+target scenario. But it will always burn extra power via CPU staying longe=
r
+in non-idle state, handling context switches and mode transitions.
+One important goal for the new filesystem is to be able to handle each pag=
e
+read separately on demand, because we don't want to wait and download more=
 data
+than absolutely necessary. Thus readahead would need to be disabled comple=
tely.
+This increases the number of separate IO requests and the FUSE related ove=
rhead
+by almost 32x (128KB readahead limit vs 4KB individual block operations)
+
+For more info see a 2017 USENIX research paper:
+To FUSE or Not to FUSE: Performance of User-Space File Systems
+Bharath Kumar Reddy Vangoor, Stony Brook University;
+Vasily Tarasov, IBM Research-Almaden;
+Erez Zadok, Stony Brook University
+https://www.usenix.org/system/files/conference/fast17/fast17-vangoor.pdf
diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioc=
tl-number.txt
index c9558146ac58..a5f8e0eaff91 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -227,6 +227,7 @@ Code  Seq#(hex)	Include File		Comments
 'f'	00-0F	fs/ocfs2/ocfs2_fs.h	conflict!
 'g'	00-0F	linux/usb/gadgetfs.h
 'g'	20-2F	linux/usb/g_printer.h
+'g'	30-3F	include/uapi/linux/incrementalfs.h
 'h'	00-7F				conflict! Charon filesystem
 					<mailto:zapman@interlan.net>
 'h'	00-1F	linux/hpet.h		conflict!
diff --git a/MAINTAINERS b/MAINTAINERS
index 5c38f21aee78..c92ad89ee5e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7630,6 +7630,13 @@ F:	Documentation/hwmon/ina2xx
 F:	drivers/hwmon/ina2xx.c
 F:	include/linux/platform_data/ina2xx.h

+INCREMENTAL FILESYSTEM
+M:	Eugene Zemtsov <ezemtsov@google.com>
+S:	Supported
+F:	fs/incfs/
+F:	include/uapi/linux/incrementalfs.h
+F:	Documentation/filesystems/incrementalfs.rst
+
 INDUSTRY PACK SUBSYSTEM (IPACK)
 M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
diff --git a/fs/Kconfig b/fs/Kconfig
index 3e6d3101f3ff..19f89c936209 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -119,6 +119,7 @@ source "fs/quota/Kconfig"
 source "fs/autofs/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
+source "fs/incfs/Kconfig"

 menu "Caches"

diff --git a/fs/Makefile b/fs/Makefile
index 427fec226fae..08c6b827df1a 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_AUTOFS_FS)		+=3D autofs/
 obj-$(CONFIG_ADFS_FS)		+=3D adfs/
 obj-$(CONFIG_FUSE_FS)		+=3D fuse/
 obj-$(CONFIG_OVERLAY_FS)	+=3D overlayfs/
+obj-$(CONFIG_INCREMENTAL_FS)	+=3D incfs/
 obj-$(CONFIG_ORANGEFS_FS)       +=3D orangefs/
 obj-$(CONFIG_UDF_FS)		+=3D udf/
 obj-$(CONFIG_SUN_OPENPROMFS)	+=3D openpromfs/
diff --git a/fs/incfs/Kconfig b/fs/incfs/Kconfig
new file mode 100644
index 000000000000..a810131deed0
--- /dev/null
+++ b/fs/incfs/Kconfig
@@ -0,0 +1,10 @@
+config INCREMENTAL_FS
+	tristate "Incremental file system support"
+	depends on BLOCK && CRC32
+	help
+	  Incremental FS is a read-only virtual file system that facilitates exec=
ution
+	  of programs while their binaries are still being lazily downloaded over=
 the
+	  network, USB or pigeon post.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called incrementalfs.
\ No newline at end of file
diff --git a/fs/incfs/Makefile b/fs/incfs/Makefile
new file mode 100644
index 000000000000..7892196c634f
--- /dev/null
+++ b/fs/incfs/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INCREMENTAL_FS)	+=3D incrementalfs.o
+
+incrementalfs-y :=3D main.o vfs.o
\ No newline at end of file
diff --git a/fs/incfs/main.c b/fs/incfs/main.c
new file mode 100644
index 000000000000..07e1952ede9e
--- /dev/null
+++ b/fs/incfs/main.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Google LLC
+ */
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <uapi/linux/incrementalfs.h>
+
+#define INCFS_CORE_VERSION 1
+
+extern struct file_system_type incfs_fs_type;
+
+static struct kobject *sysfs_root;
+
+static ssize_t version_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buff)
+{
+	return snprintf(buff, PAGE_SIZE, "%d\n", INCFS_CORE_VERSION);
+}
+
+static struct kobj_attribute version_attr =3D __ATTR_RO(version);
+
+static struct attribute *attributes[] =3D {
+	&version_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group attr_group =3D {
+	.attrs =3D attributes,
+};
+
+static int __init init_sysfs(void)
+{
+	int res =3D 0;
+
+	sysfs_root =3D kobject_create_and_add(INCFS_NAME, fs_kobj);
+	if (!sysfs_root)
+		return -ENOMEM;
+
+	res =3D sysfs_create_group(sysfs_root, &attr_group);
+	if (res) {
+		kobject_put(sysfs_root);
+		sysfs_root =3D NULL;
+	}
+	return res;
+}
+
+static void cleanup_sysfs(void)
+{
+	if (sysfs_root) {
+		sysfs_remove_group(sysfs_root, &attr_group);
+		kobject_put(sysfs_root);
+		sysfs_root =3D NULL;
+	}
+}
+
+static int __init init_incfs_module(void)
+{
+	int err =3D 0;
+
+	err =3D init_sysfs();
+	if (err)
+		return err;
+
+	err =3D register_filesystem(&incfs_fs_type);
+	if (err)
+		cleanup_sysfs();
+
+	return err;
+}
+
+static void __exit cleanup_incfs_module(void)
+{
+	cleanup_sysfs();
+	unregister_filesystem(&incfs_fs_type);
+}
+
+module_init(init_incfs_module);
+module_exit(cleanup_incfs_module);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Eugene Zemtsov <ezemtsov@google.com>");
+MODULE_DESCRIPTION("Incremental File System");
diff --git a/fs/incfs/vfs.c b/fs/incfs/vfs.c
new file mode 100644
index 000000000000..2e71f0edf8a1
--- /dev/null
+++ b/fs/incfs/vfs.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Google LLC
+ */
+#include <linux/blkdev.h>
+#include <linux/fs.h>
+
+#include <uapi/linux/incrementalfs.h>
+
+static struct dentry *mount_fs(struct file_system_type *type, int flags,
+			       const char *dev_name, void *data);
+static void kill_sb(struct super_block *sb);
+
+struct file_system_type incfs_fs_type =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D INCFS_NAME,
+	.mount =3D mount_fs,
+	.kill_sb =3D kill_sb,
+	.fs_flags =3D 0
+};
+
+static int fill_super_block(struct super_block *sb, void *data, int silent=
)
+{
+	return 0;
+}
+
+static struct dentry *mount_fs(struct file_system_type *type, int flags,
+			       const char *dev_name, void *data)
+{
+	return mount_nodev(type, flags, data, fill_super_block);
+}
+
+static void kill_sb(struct super_block *sb)
+{
+	generic_shutdown_super(sb);
+}
+
diff --git a/include/uapi/linux/incrementalfs.h b/include/uapi/linux/increm=
entalfs.h
new file mode 100644
index 000000000000..5bcf66ac852b
--- /dev/null
+++ b/include/uapi/linux/incrementalfs.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for Incremental FS.
+ *
+ * Incremental FS is special-purpose Linux virtual file system that allows
+ * execution of a program while its binary and resource files are still be=
ing
+ * lazily downloaded over the network, USB etc.
+ *
+ * Copyright 2019 Google LLC
+ */
+#ifndef _UAPI_LINUX_INCREMENTALFS_H
+#define _UAPI_LINUX_INCREMENTALFS_H
+
+#include <linux/limits.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* =3D=3D=3D=3D=3D constants =3D=3D=3D=3D=3D */
+#define INCFS_NAME "incremental-fs"
+#define INCFS_MAGIC_NUMBER (0x5346434e49ul)
+#define INCFS_DATA_FILE_BLOCK_SIZE 4096
+#define INCFS_HEADER_VER 1
+
+#define INCFS_MAX_FILES 1000
+#define INCFS_COMMAND_INODE 1
+#define INCFS_ROOT_INODE 2
+
+#define INCFS_IOCTL_BASE_CODE 'g'
+
+/* =3D=3D=3D=3D=3D ioctl requests on command file =3D=3D=3D=3D=3D */
+
+/* Make changes to the file system via incfs instructions. */
+#define INCFS_IOC_PROCESS_INSTRUCTION \
+	_IOWR(INCFS_IOCTL_BASE_CODE, 30, struct incfs_instruction)
+
+enum incfs_compression_alg { COMPRESSION_NONE =3D 0, COMPRESSION_LZ4 =3D 1=
 };
+
+/*
+ * Description of a pending read. A pending read - a read call by
+ * a userspace program for which the filesystem currently doesn't have dat=
a.
+ *
+ * This structs can be read from .cmd file to obtain a set of reads which
+ * are currently pending.
+ */
+struct incfs_pending_read_info {
+	/* Inode number of a file that is being read from. */
+	__aligned_u64 file_ino;
+
+	/* Index of a file block that is being read. */
+	__u32 block_index;
+
+	/* A serial number of this pending read. */
+	__u32 serial_number;
+};
+
+/*
+ * A struct to be written into a .cmd file to provide a data block for a f=
ile.
+ */
+struct incfs_new_data_block {
+	/* Inode number of a file this block belongs to. */
+	__aligned_u64 file_ino;
+
+	/* Index of a data block. */
+	__u32 block_index;
+
+	/* Length of data */
+	__u32 data_len;
+
+	/*
+	 * A pointer ot an actual data for the block.
+	 *
+	 * Equivalent to: __u8 *data;
+	 */
+	__aligned_u64 data;
+
+	/*
+	 * Compression algorithm used to compress the data block.
+	 * Values from enum incfs_compression_alg.
+	 */
+	__u32 compression;
+
+	__u32 reserved1;
+
+	__aligned_u64 reserved2;
+};
+
+enum incfs_instruction_type {
+	INCFS_INSTRUCTION_NOOP =3D 0,
+	INCFS_INSTRUCTION_NEW_FILE =3D 1,
+	INCFS_INSTRUCTION_ADD_DIR_ENTRY =3D 3,
+	INCFS_INSTRUCTION_REMOVE_DIR_ENTRY =3D 4,
+};
+
+/*
+ * Create a new file or directory.
+ * Corresponds to INCFS_INSTRUCTION_NEW_FILE
+ */
+struct incfs_new_file_instruction {
+	/*
+	 * [Out param. Populated by the kernel after ioctl.]
+	 * Inode number of a newly created file.
+	 */
+	__aligned_u64 ino_out;
+
+	/*
+	 * Total size of the new file. Ignored if S_ISDIR(mode).
+	 */
+	__aligned_u64 size;
+
+	/*
+	 * File mode. Permissions and dir flag.
+	 */
+	__u16 mode;
+
+	__u16 reserved1;
+
+	__u32 reserved2;
+
+	__aligned_u64 reserved3;
+
+	__aligned_u64 reserved4;
+
+	__aligned_u64 reserved5;
+
+	__aligned_u64 reserved6;
+
+	__aligned_u64 reserved7;
+};
+
+/*
+ * Create or remove a name (aka hardlink) for a file in a directory.
+ * Corresponds to
+ * INCFS_INSTRUCTION_ADD_DIR_ENTRY,
+ * INCFS_INSTRUCTION_REMOVE_DIR_ENTRY
+ */
+struct incfs_dir_entry_instruction {
+	/* Inode number of a directory to add/remove a file to/from. */
+	__aligned_u64 dir_ino;
+
+	/* File to add/remove. */
+	__aligned_u64 child_ino;
+
+	/* Length of name field */
+	__u32 name_len;
+
+	__u32 reserved1;
+
+	/*
+	 * A pointer to the name characters of a file to add/remove
+	 *
+	 * Equivalent to: char *name;
+	 */
+	__aligned_u64 name;
+
+	__aligned_u64 reserved2;
+
+	__aligned_u64 reserved3;
+
+	__aligned_u64 reserved4;
+
+	__aligned_u64 reserved5;
+};
+
+/*
+ * An Incremental FS instruction is the way for userspace
+ * to
+ *   - create files and directories
+ *   - show and hide files in the directory structure
+ */
+struct incfs_instruction {
+	/* Populate with INCFS_HEADER_VER */
+	__u32 version;
+
+	/*
+	 * Type - what this instruction actually does.
+	 * Values from enum incfs_instruction_type.
+	 */
+	__u32 type;
+
+	union {
+		struct incfs_new_file_instruction file;
+		struct incfs_dir_entry_instruction dir_entry;
+
+		/* Hard limit on the instruction body size in the future. */
+		__u8 reserved[64];
+	};
+};
+
+#endif /* _UAPI_LINUX_INCREMENTALFS_H */
--
2.21.0.593.g511ec345e18-goog

