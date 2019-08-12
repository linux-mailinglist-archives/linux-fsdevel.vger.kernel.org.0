Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356318A3AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfHLQsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 12:48:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44559 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:48:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so105155895wrf.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2019 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ds4v6qg5XCbjPtJUW6ydjoaN8fyTJlvedFKQi1PLLU=;
        b=pM1BMT27git2CiviYhLC8h5eMqcSAt/yige7e2wLqwmA1paStTaI6QY4E8VqSS30zK
         0ApSSHpk0lx0HdBBRY3MJrLyaPyz48FZueduP2Y6RLYVZaeDBPM2NcZz/THPghcdwN8V
         jdtfnvGzLqGtPzLnfxR24aTDdBLM8DPqmJFlBKRgk5Be1A6SEHTmupqApHP6It/3tEAs
         Ryn7OxNw0S7AH1ELX0bF6rD+T16o8OGJ/Ztbrm9phcZEQUQNEIw38AuB75RYKp/D213k
         tvumBBkhEBj2qqEGYccuWqCyOBvoitE4B+RPJ0Z+ej6jj3QjnnWo4JmtZ8Rhmeh+kK7u
         Q7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ds4v6qg5XCbjPtJUW6ydjoaN8fyTJlvedFKQi1PLLU=;
        b=K8brZxDJaOdfVa6/Fn62zWzf4whHxK/Aa7eM8MN/2UthzAHTbAg+odjP3ayXGiyrZf
         tZhIqbEEfhsBdnYslGT31c1T8nY2Nvb+7aOl0CeZijvgEA3bd1nLYIcyXJlSCRHPK6BR
         bMYyIMHmP6J1oZCblKWBdUu9JmrjVI4AxYEwpseCCVUXPx/h488qFzbHKa9RvTULmjzS
         wwEm4tthYuIYHgW04yQsy52RYOK5oIl29FKpe909IZfKTCW5QkKy/muX60iXTnAEEcxZ
         rEGvS/6mBteGUl+QvkwFW3VMzes+L3ZAzvmo/vyqencnqevcozsDT1WHePh2LZ03dVFv
         Uwjw==
X-Gm-Message-State: APjAAAUTUcSDTwNfRhgA2otQ0IXUb/WL5MUX63s3Vt7yCSGqCPIXvt89
        ihlBxzIDhYY1KCclkYo1uU7j+ZTHeHQ=
X-Google-Smtp-Source: APXvYqwhz5pSxDay1ftFtcVu20mH0svHRpIo8VdAQY98tDGNka9WYB7oIckdAU52OAasOXQdp0k4Gw==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr30450456wrr.194.1565628497707;
        Mon, 12 Aug 2019 09:48:17 -0700 (PDT)
Received: from Bfire.plexistor.com ([217.70.211.18])
        by smtp.googlemail.com with ESMTPSA id 39sm14439916wrc.45.2019.08.12.09.48.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 09:48:17 -0700 (PDT)
From:   Boaz Harrosh <boaz@plexistor.com>
X-Google-Original-From: Boaz Harrosh <boazh@netapp.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Amit Golander <Amit.Golander@netapp.com>,
        Sagi Manole <sagim@netapp.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 03/16] zuf: Preliminary Documentation
Date:   Mon, 12 Aug 2019 19:47:53 +0300
Message-Id: <20190812164806.15852-4-boazh@netapp.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190812164806.15852-1-boazh@netapp.com>
References: <20190812164806.15852-1-boazh@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding Documentation/filesystems/zufs.txt.

Adding some Documentation first. So to give the reviewer
of the coming patch-set. Some background and overview of
the all system.

[v2]
  Incorporated Randy's few comments.

Randy Please give it an harder review?

CC: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 Documentation/filesystems/zufs.txt | 386 +++++++++++++++++++++++++++++
 1 file changed, 386 insertions(+)
 create mode 100644 Documentation/filesystems/zufs.txt

diff --git a/Documentation/filesystems/zufs.txt b/Documentation/filesystems/zufs.txt
new file mode 100644
index 000000000000..2a347a446aa7
--- /dev/null
+++ b/Documentation/filesystems/zufs.txt
@@ -0,0 +1,386 @@
+ZUFS - Zero-copy User-mode FileSystem
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Trees:
+	git clone https://github.com/NetApp/zufs-zuf -b upstream
+	git clone https://github.com/NetApp/zufs-zus -b upstream
+
+patches, comments, questions, requests to:
+	boazh@netapp.com
+
+Introduction:
+~~~~~~~~~~~~~
+
+ZUFS - stands for Zero-copy User-mode FS
+▪ It is geared towards true zero copy end to end of both data and meta data.
+▪ It is geared towards very *low latency*, very high CPU locality, lock-less
+  parallelism.
+▪ Synchronous operations
+▪ Numa awareness
+
+  ZUFS is a, from scratch, implementation of a filesystem-in-user-space, which
+tries to address the above goals. It is aimed for pmem based FSs. But supports
+any other type of FSs
+
+Glossary and names:
+~~~~~~~~~~~~~~~~~~~
+
+ZUF - Zero-copy User-mode Feeder
+  zuf.ko is the Kernel VFS component. Its job is to interface with the Kernel
+  VFS and dispatch commands to a User-mode application Server.
+  Uptodate code is found at:
+	git clone https://github.com/NetApp/zufs-zuf -b upstream
+
+ZUS - Zero-copy User-mode Server
+  zufs utilizes a User-mode server application. That takes care of the detailed
+  communication protocol and correctness with the Kernel.
+  In turn it utilizes many zusFS Filesystem plugins to implement the actual
+  on disc Filesystem.
+  Uptodate code is found at:
+	git clone https://github.com/NetApp/zufs-zus -b upstream
+
+zusFS - FS plugins
+  These are .so loadable modules that implement one or more Filesystem-types
+  (mount -t xyz).
+  The zus server communicates with the plugin via a set of function vectors
+  for the different operations. And establishes communication via defined
+  structures.
+
+Filesystem-type:
+  At startup zus registers with the Kernel one or more Filesystem-type(s)
+  Associated with the type is a unique type-name (mount -t foofs) +
+  different info about the fs, like a magic number and so on.
+  One Server can support many FS-types, in turn each FS-type can mount
+  multiple super-blocks, each supporting multiple devices.
+
+Device-Table (MDT) - A zufs FS can support multiple devices
+  ZUF in Kernel may receive, like any mount command a block-device or none.
+  For the former if the specified FS-types states so in a special field.
+  The mount will look for a Device table. A list of devices in a specific
+  order sitting at some offset on each block-device. The system will then
+  proceed to open and own all these devices and associate them to the mounting
+  super-block.
+  If FS-type specifies a -1 at DT_offset then there is no device table
+  and a DT of a single device is created. (If we have no devices, none
+  is specified than we operate without any block devices. (Mount options give
+  some indication of the storage information))
+  The device table has special consideration for pmem devices and will
+  present the all linear array of devices to zus, as one flat mmap space.
+  Alternatively all non-pmem devices are also provided an interface
+  with facility of data movement from pmem to slower devices.
+  A detailed NUMA info is exported to the Server for maximum utilization.
+  Each device has an associated NUMA node, so Server can optimize IO to
+  these devices
+
+pmem: (Also called t1)
+  Multiple pmem devices are presented to the server as a single
+  linear file mmap. Something like /dev/dax. But it is strictly
+  available only to the specific super-block that owns it.
+
+Shadow: (For debugging)
+  "Shadow" is used for debugging the correct persistence of pmem based
+  filesystems. With pmem if modified a user must call cl_flush/sfence
+  for the data to be guarantied resistance. This is very hard to test
+  and time consuming. So for that we invented the shadow.
+  There is a special mode bit in the MDT header that denotes a shadow
+  system. In a shadow setup each pmem device is divided in half. First
+  half is available for FS storage. The second half is a Shadow. IE
+  each time the FS calls cl_flush or mov_nt the data is then memcopied
+  to the shadow.
+  At mount time the Shadow is copied onto the main part. And thous
+  presenting only those bits that where persisted by the FS. So a simple
+  remount can simulate a full machine reboot.
+  The Shadow is presented as the upper part of the mmaped region. IE
+  the all t1 ranged is repeated again. The zus core code fasilitates
+  zusFS implementors in accessing this facility
+
+zufs_dpp_t - Dual port pointer type
+  At some points in the protocol there are objects that return from zus
+  (The Server) to the Kernel via a dpp_t. This is a special kind of pointer
+  It is actually an offset 8 bytes aligned with the 3 low bits specifying
+  a pool code: [offset = dpp_t & ~0x7] [pool = dpp_t & 0x7]
+  pool == 0 means the offset is in pmem who's management is by zuf and
+  a full easy access is provided for zus.
+
+  pool != 0 Is a pre-established file (up to 6 such files per sb) where
+  the zus has an mmap on the file and the Kernel can access that data
+  via an offset into the file.
+  pool == 7 denotes an offset into the application buffers associated
+  with the current IO.
+  All dpp_t objects life time rules are strictly defined.
+  Mainly the primary use of dpp_t is the on-pmem inode structure. Both
+  zus and zuf can access and change this structure. On any modification
+  the zus is called so to be notified of any changes, persistence.
+  More such objects are: Symlinks, xattrs, data-blocks etc...
+
+Relay-wait-object:
+  communication between Kernel and server are done via zus-threads that
+  sleep in Kernel (inside an IOCTL) and wait for commands. Once received
+  the IOCTL returns operation id executed and the return info is returned via
+  a new IOCTL call, which then waits for the next operation.
+  To wake up the sleeping thread we use a Relay-wait-object. Currently
+  it is two waitqueue_head(s) back to back.
+  In future we should investigate the use of a new special scheduler object
+  That switches from thread A to predefined thread ZT context without passing
+  through the scheduler at all.
+  (The switching is already very fast, faster then anything currently
+   in the Kernel. But I believe I can shave another 1 micro off a roundtrip)
+
+ZT-threads-array:
+  The novelty of the zufs is the ZT-threads system. 3 threads or more are
+  pre-created for each active core in the system.
+  ▪ The thread is AFFINITY set for that single core only.
+  ▪ Special communication file per ZT (O_TMPFILE + IOCTL_ZUFS_INIT)
+    At initialization the ZT thread communicates through a ZT_INIT ioctl
+    and registers as the handler of that core (Channel)
+  ▪ Also for each ZT, Kernel allocates an IOCTL-buffer that is directly
+    accessed by Kernel. In turn that IOCTL-buffer is mmaped by zus
+    for the Server access of that communication buffer. (This is for zero
+    copy operations as well as avoiding the smem memory barrier)
+  ▪ IOCTL_ZU_WAIT_OPT – threads sleeps in Kernel waiting for an operation
+    via the IOCTL_ZU_WAIT_OPT call.
+
+  ▪ On operation dispatch current CPU's ZT free channel is selected.
+    Operation info is set into the IOCTL-buffer, the ZT is woken and the
+    application thread is put to sleep.
+  ▪ After execution, ZT returns to kernel (IOCTL_ZU_WAIT_OPT), app is released,
+    Server wait for new operation on that CPU.
+  ▪ Each ZT has a cyclic logic. Each call to IOCTL_ZU_WAIT_OPT from Server
+    returns the results of the previous operation, before going to sleep
+    waiting to receive a new operation.
+	zus			zuf-zt				application
+    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+     ---> IOCTL_ZU_WAIT_OPT    if (app-waiting)
+     |					wake-up-application	 -> return to app
+     |				FS-WAIT
+     |				|				<- POSIX call
+     |				V		<- fs-wake-up(dispatch)
+     |			<- return with new command
+     |--<- do_new_operation
+
+ZUS-mount-thread:
+  The system utilizes a single mount thread. (This thread is not affinity to any
+  core).
+  ▪ It will first Register all FS-types supported by this Server (By calling
+    all zusFS plugins to register their supported types). Once done
+  ▪ As above, the thread sleeps in Kernel via the IOCTL_ZU_MOUNT call.
+  ▪ When the Kernel receives a mount request (vfs calles the fs_type->mount opt)
+    a mount is dispatched back to zus.
+  ▪ NOTE: That only on very first mount the above ZT-threads-array is created
+    the same ZT-array is then used for all super-blocks in the system
+  ▪ As part of the mount command in the context of this same mount-thread
+    a call to IOCTL_ZU_GRAB_PMEM will establish an interface to the pmem
+    Associated with this super_block
+  ▪ On return like above a new call to IOCTL_ZU_MOUNT will return info of the
+    mount before sleeping in kernel waiting for a new dispatch. All SB info
+    is provided to zuf, including the root inode info. Kernel then proceeds
+    to complete the mount call.
+  ▪ NOTE that since there is a single mount thread lots of FS-registration
+    super_block and pmem management are lockless.
+
+Philosophy of operations:
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. [zuf-root]
+
+On module load  (zuf.ko) A special pseudo FS is mounted on /sys/fs/zuf. This is
+called zuf-root.
+The zuf-root has no visible files. All communication is done via special-files.
+special-files are open(O_TMPFILE) and establish a special role via an
+IOCTL. (Example above ZT-thread is one such special file)
+All communications with the server are done via the zuf-root. Each root owns
+many FS-types and each FS-type owns many super-blocks of this type. All Sharing
+the same communication channels.
+Since all FS-type Servers live in the same zus application address space, at
+times. If the administrator wants to separate between different servers, he/she
+can mount a new zuf-root and point a new server instance on that new mount,
+registering other FS-types on that other instance. The all communication array
+will then be duplicated as well.
+(Otherwise pointing a new server instance on a busy root will return an error)
+
+2. [zus server start]
+  ▪ On load all configured zusFS plugins are loaded.
+  ▪ The Server starts by starting a single mount thread.
+  ▪ It than proceeds to register with Kernel all FS-types it will support.
+    (This is done on the single mount thread, so FS-registration and
+     mount/umount operate in a single thread and therefor need not any locks)
+  ▪ Sleeping in the Kernel on a special-file of that zuf-root. waiting for
+    a mount command.
+
+3. [mount -t xyz]
+  [In Kernel]
+  ▪ If xyz was registered above as part of the Server startup. the regular
+    mount command will come to the zuf module with a zuf_mount() call. with
+    the xyz-FS-info. In turn this points to a zuf-root.
+  ▪ Code than proceed to load a device-table of devices as  specified above.
+    It then establishes an multi_devices object with a specific sb_id.
+  ▪ It proceeds to call mount_bdev. Always with the same main-device
+    thous fully sporting automatic bind mounts. Even if different
+    devices are given to the mount command.
+  ▪ In zuf_fill_super it will then dispatch (awaken) the mount thread
+    specifying two parameters. One the FS-type to mount, and then
+    the sb_id Associated with this super_block.
+
+  [In zus]
+  ▪ A zus_super_block_info is allocated.
+  ▪ zus calls PMEM_GRAB(sb_id) to establish a direct mapping to its
+    pmem devices. On return we have full access to our PMEM
+
+  ▪ ZT-threads-array
+    If this is the first mount the ZT-threads-array is created and
+    established. The mount thread will wait until all zt-threads finished
+    initialization and ready to rock.
+  ▪ Root-zus_inode is loaded and is returned to kernel
+  ▪ More info about the mount like block sizes and so on are returned to kernel.
+
+  [In Kernel]
+   The zuf_fill_super is finalized vectors established and we have a new
+   super_block ready for operations.
+
+4. An FS operation like create or WRITE/READ and so on arrives from application
+   via VFS. Eventually an Operation is dispatched to zus:
+   ▪ A special per-operation descriptor is filled up with all parameters.
+   ▪ A current CPU channel is grabbed. the operation descriptor is put on
+     that channel (ZT). Including get_user_pages or Kernel-pages associated
+     with this OPT.
+   ▪ The ZT is awaken, app thread put to sleep.
+   ▪ Optionally in ZT context pages are mapped to that ZT-vma. This is so we
+     are sure the map is only on a single core. And no other core's TLB is
+     affected.
+   ▪ ZT thread is returned to user-space.
+   ▪ In ZT context the zus Server calls the appropriate zusFS->operation
+     vector. Output params filled.
+   ▪ zus calls again with an IOCTL_ZU_WAIT_OPT with the same descriptor
+     to return the requested info.
+   ▪ At Kernel (zuf) the app thread is awaken with the results, and the
+     ZT thread goes back to sleep waiting a new operation.
+
+   ZT rules:
+       A ZT thread should try to minimize it's sleeps. it might take locks
+   In which case we will see that the same CPU channel is reentered via another
+   application/thread. But now that CPU channel is taken.  What we do is we
+   utilize a few channels (ZTs) per core and those threads may grab another
+   channel. But this only postpones the problem. On a busy contended system,
+   all such channels will be consumed. If all channels are taken the
+   application thread is put on a busy scheduling wait until a channel can
+   be grabbed.
+   If The server needs to sleep for a long time it should utilize the
+   ZUFS_ASYNC return option. The app is then kept sleeping on an
+   operation-context object and the ZT freed for foreground operation.
+   At some point in time when the server completes the delayed operation
+   it will notify the Kernel with a special async IO-context cookie.
+   And the app will be awakened.
+
+4. On umount the operation is reversed and all resources are released.
+5. In case of an application or Server crash, all resources are Associated
+   with files, on file_release these resources are caught and freed.
+
+Objects and life-time
+~~~~~~~~~~~~~~~~~~~~~
+
+Each Kernel object type has an assosiated zus Server object type who's life
+time is governed by the life-time of the Kernel object. Therefor the Server's
+job is easy because it need not establish any object caches / hashes and so on.
+
+Inside zus all objects are allocated by the zusFS plugin. So in turn it can
+allocate a bigger space for its own private data and access it via the
+container_off() coding pattern. So when I say below a zus-object I mean both
+zus public part + zusFS private part of the same object.
+
+All operations return a User-mode pointer that are opaque to the the Kernel
+code, they are just a cookie which is returned back to zus, when needed.
+At times when we want the Kernel to have direct access to a zus object like
+zufs_inode, along with the cookie we also return a dpp_t, with a defined
+structure.
+
+Kernel object 			| zus object 		| Kernel access (via dpp_t)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+zuf_fs_type
+	file_system_type	| zus_fs_info		| no
+
+zuf_sb_info
+	super_block		| zus_sb_info		| no
+
+zuf_inode_info			|			|
+	vfs_inode		| zus_inode_info	| no
+	zufs_inode *		| 	zufs_inode *	| yes
+	synlink *		|	char-array	| yes
+	xattr**			|	zus_xattr	| yes
+
+When a Kernel object's time is to die, a final call to zus is
+dispatched so the associated object can also be freed. Which means
+that on memory pressure when object caches are evicted also the zus
+memory resources are freed.
+
+
+How to use zufs:
+~~~~~~~~~~~~~~~~
+
+The most updated documentation of how to use the latest code bases
+is the script (set of scripts) at fs/do-zu/zudo on the zus git tree
+
+We the developers at Netapp use this script to mount and test our
+latest code. So any new Secret will be found in these scripts. Please
+read them as the ultimate source of how to operate things.
+
+We assume you cloned these git trees:
+[]$ mkdir zufs; cd zufs
+[]$ git clone https://github.com/NetApp/zufs-zuf -b upstream
+[]$ git clone https://github.com/NetApp/zufs-zuf -b upstream
+
+This will create the following trees
+zufs/zus - Source code for Server
+zufs/zuf - Linux Kernel source tree to compile and install on your machine
+
+Also specifically:
+zufs/zus/fs/do-zu/zudo - script Documenting how to run things
+
+[]$ cd zufs
+
+First time
+[] zus/fs/do-zu/zudo
+this will create a file:
+	zus/fs/do-zu/zu.conf
+
+Edit this file for your environment. Devices, mount-point and so on.
+On first run an example file will be created for you. Fill in the
+blanks. Most params can stay as is in most cases
+
+Now lets start running:
+
+[1]$ zus/fs/do-zu/zudo mkfs
+This will run the proper mkfs command selected at zu.conf file
+with the proper devices.
+
+[2]$ zus/fs/do-zu/zudo zuf-insmod
+This loads the zuf.ko module
+
+[3]$ zus/fs/do-zu/zudo zuf-root
+This mounts the zuf-root FS above on /sys/fs/zuf (automatically created in [2])
+
+[4]$ zus/fs/do-zu/zudo zus-up
+This runs the zus daemon in the background
+
+[5]$ zus/fs/do-zu/zudo mount
+This mount the mkfs FS above on the specified dir in zu.conf
+
+To run all the 5 commands above at once do:
+[]$ zus/fs/do-zu/zudo up
+
+To undo all the above in reverse order do:
+[]$ zus/fs/do-zu/zudo down
+
+And the most magic command is:
+[]$ zus/fs/do-zu/zudo again
+Will do a "down", then update-mods, then "up"
+(update-mods is a special script to copy the latest compiled binaries)
+
+Now you are ready for some:
+[]$ zus/fs/do-zu/zudo xfstest
+xfstests is assumed to be installed in the regular /opt/xfstests dir
+
+Again please see inside the scripts what each command does
+these scripts are the ultimate Documentation, do not believe
+anything I'm saying here. (Because it is outdated by now)
+
+Have a nice day
-- 
2.20.1

