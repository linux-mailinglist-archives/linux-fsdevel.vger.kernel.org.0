Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F31AB545
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 03:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406205AbgDPBLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 21:11:08 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56749 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgDPBLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:11:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=42;SR=0;TI=SMTPD_---0TvepAUe_1586999442;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TvepAUe_1586999442)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 09:10:43 +0800
Subject: Re: [PATCH 01/34] docs: filesystems: fix references for doc files
 there
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Tyler Hicks <code@tyhicks.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        ecryptfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-unionfs@vger.kernel.org
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
 <4233bc0ed8d3ebd45da248332c157a9e04a16058.1586960617.git.mchehab+huawei@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <4112dd33-ee49-f5a8-e5cb-6b47299dceca@linux.alibaba.com>
Date:   Thu, 16 Apr 2020 09:10:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4233bc0ed8d3ebd45da248332c157a9e04a16058.1586960617.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2020/4/15 22:32, Mauro Carvalho Chehab wrote:
> Several files there were renamed to ReST. Fix the broken
> references.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/ABI/stable/sysfs-devices-node               | 2 +-
>  Documentation/ABI/testing/procfs-smaps_rollup             | 2 +-
>  Documentation/admin-guide/cpu-load.rst                    | 2 +-
>  Documentation/admin-guide/nfs/nfsroot.rst                 | 2 +-
>  Documentation/driver-api/driver-model/device.rst          | 2 +-
>  Documentation/driver-api/driver-model/overview.rst        | 2 +-
>  Documentation/filesystems/dax.txt                         | 2 +-
>  Documentation/filesystems/dnotify.txt                     | 2 +-
>  Documentation/filesystems/ramfs-rootfs-initramfs.rst      | 2 +-
>  Documentation/powerpc/firmware-assisted-dump.rst          | 2 +-
>  Documentation/process/adding-syscalls.rst                 | 2 +-
>  .../translations/it_IT/process/adding-syscalls.rst        | 2 +-
>  Documentation/translations/zh_CN/filesystems/sysfs.txt    | 6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                   | 2 +-
>  fs/Kconfig                                                | 2 +-
>  fs/Kconfig.binfmt                                         | 2 +-
>  fs/adfs/Kconfig                                           | 2 +-
>  fs/affs/Kconfig                                           | 2 +-
>  fs/afs/Kconfig                                            | 6 +++---
>  fs/bfs/Kconfig                                            | 2 +-
>  fs/cramfs/Kconfig                                         | 2 +-
>  fs/ecryptfs/Kconfig                                       | 2 +-
>  fs/fat/Kconfig                                            | 8 ++++----
>  fs/fuse/Kconfig                                           | 2 +-
>  fs/fuse/dev.c                                             | 2 +-
>  fs/hfs/Kconfig                                            | 2 +-
>  fs/hpfs/Kconfig                                           | 2 +-
>  fs/isofs/Kconfig                                          | 2 +-
>  fs/namespace.c                                            | 2 +-
>  fs/notify/inotify/Kconfig                                 | 2 +-
>  fs/ntfs/Kconfig                                           | 2 +-
>  fs/ocfs2/Kconfig                                          | 2 +-

For ocfs2 part,
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

>  fs/overlayfs/Kconfig                                      | 6 +++---
>  fs/proc/Kconfig                                           | 4 ++--
>  fs/romfs/Kconfig                                          | 2 +-
>  fs/sysfs/dir.c                                            | 2 +-
>  fs/sysfs/file.c                                           | 2 +-
>  fs/sysfs/mount.c                                          | 2 +-
>  fs/sysfs/symlink.c                                        | 2 +-
>  fs/sysv/Kconfig                                           | 2 +-
>  fs/udf/Kconfig                                            | 2 +-
>  include/linux/relay.h                                     | 2 +-
>  include/linux/sysfs.h                                     | 2 +-
>  kernel/relay.c                                            | 2 +-
>  44 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index df8413cf1468..484fc04bcc25 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -54,7 +54,7 @@ Date:		October 2002
>  Contact:	Linux Memory Management list <linux-mm@kvack.org>
>  Description:
>  		Provides information about the node's distribution and memory
> -		utilization. Similar to /proc/meminfo, see Documentation/filesystems/proc.txt
> +		utilization. Similar to /proc/meminfo, see Documentation/filesystems/proc.rst
>  
>  What:		/sys/devices/system/node/nodeX/numastat
>  Date:		October 2002
> diff --git a/Documentation/ABI/testing/procfs-smaps_rollup b/Documentation/ABI/testing/procfs-smaps_rollup
> index 274df44d8b1b..046978193368 100644
> --- a/Documentation/ABI/testing/procfs-smaps_rollup
> +++ b/Documentation/ABI/testing/procfs-smaps_rollup
> @@ -11,7 +11,7 @@ Description:
>  		Additionally, the fields Pss_Anon, Pss_File and Pss_Shmem
>  		are not present in /proc/pid/smaps.  These fields represent
>  		the sum of the Pss field of each type (anon, file, shmem).
> -		For more details, see Documentation/filesystems/proc.txt
> +		For more details, see Documentation/filesystems/proc.rst
>  		and the procfs man page.
>  
>  		Typical output looks like this:
> diff --git a/Documentation/admin-guide/cpu-load.rst b/Documentation/admin-guide/cpu-load.rst
> index 2d01ce43d2a2..ebdecf864080 100644
> --- a/Documentation/admin-guide/cpu-load.rst
> +++ b/Documentation/admin-guide/cpu-load.rst
> @@ -105,7 +105,7 @@ References
>  ----------
>  
>  - http://lkml.org/lkml/2007/2/12/6
> -- Documentation/filesystems/proc.txt (1.8)
> +- Documentation/filesystems/proc.rst (1.8)
>  
>  
>  Thanks
> diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
> index 82a4fda057f9..c6772075c80c 100644
> --- a/Documentation/admin-guide/nfs/nfsroot.rst
> +++ b/Documentation/admin-guide/nfs/nfsroot.rst
> @@ -18,7 +18,7 @@ Mounting the root filesystem via NFS (nfsroot)
>  In order to use a diskless system, such as an X-terminal or printer server for
>  example, it is necessary for the root filesystem to be present on a non-disk
>  device. This may be an initramfs (see
> -Documentation/filesystems/ramfs-rootfs-initramfs.txt), a ramdisk (see
> +Documentation/filesystems/ramfs-rootfs-initramfs.rst), a ramdisk (see
>  Documentation/admin-guide/initrd.rst) or a filesystem mounted via NFS. The
>  following text describes on how to use NFS for the root filesystem. For the rest
>  of this text 'client' means the diskless system, and 'server' means the NFS
> diff --git a/Documentation/driver-api/driver-model/device.rst b/Documentation/driver-api/driver-model/device.rst
> index 2b868d49d349..b8c15a39a9a0 100644
> --- a/Documentation/driver-api/driver-model/device.rst
> +++ b/Documentation/driver-api/driver-model/device.rst
> @@ -50,7 +50,7 @@ Attributes
>  
>  Attributes of devices can be exported by a device driver through sysfs.
>  
> -Please see Documentation/filesystems/sysfs.txt for more information
> +Please see Documentation/filesystems/sysfs.rst for more information
>  on how sysfs works.
>  
>  As explained in Documentation/kobject.txt, device attributes must be
> diff --git a/Documentation/driver-api/driver-model/overview.rst b/Documentation/driver-api/driver-model/overview.rst
> index d4d1e9b40e0c..e98d0ab4a9b6 100644
> --- a/Documentation/driver-api/driver-model/overview.rst
> +++ b/Documentation/driver-api/driver-model/overview.rst
> @@ -121,4 +121,4 @@ device-specific data or tunable interfaces.
>  
>  More information about the sysfs directory layout can be found in
>  the other documents in this directory and in the file
> -Documentation/filesystems/sysfs.txt.
> +Documentation/filesystems/sysfs.rst.
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> index 679729442fd2..735f3859b19f 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.txt
> @@ -74,7 +74,7 @@ are zeroed out and converted to written extents before being returned to avoid
>  exposure of uninitialized data through mmap.
>  
>  These filesystems may be used for inspiration:
> -- ext2: see Documentation/filesystems/ext2.txt
> +- ext2: see Documentation/filesystems/ext2.rst
>  - ext4: see Documentation/filesystems/ext4/
>  - xfs:  see Documentation/admin-guide/xfs.rst
>  
> diff --git a/Documentation/filesystems/dnotify.txt b/Documentation/filesystems/dnotify.txt
> index 15156883d321..08d575ece45d 100644
> --- a/Documentation/filesystems/dnotify.txt
> +++ b/Documentation/filesystems/dnotify.txt
> @@ -67,4 +67,4 @@ See tools/testing/selftests/filesystems/dnotify_test.c for an example.
>  NOTE
>  ----
>  Beginning with Linux 2.6.13, dnotify has been replaced by inotify.
> -See Documentation/filesystems/inotify.txt for more information on it.
> +See Documentation/filesystems/inotify.rst for more information on it.
> diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> index 6c576e241d86..3fddacc6bf14 100644
> --- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> +++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
> @@ -71,7 +71,7 @@ be allowed write access to a ramfs mount.
>  
>  A ramfs derivative called tmpfs was created to add size limits, and the ability
>  to write the data to swap space.  Normal users can be allowed write access to
> -tmpfs mounts.  See Documentation/filesystems/tmpfs.txt for more information.
> +tmpfs mounts.  See Documentation/filesystems/tmpfs.rst for more information.
>  
>  What is rootfs?
>  ---------------
> diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
> index b3f3ee135dbe..20ea8cdee0aa 100644
> --- a/Documentation/powerpc/firmware-assisted-dump.rst
> +++ b/Documentation/powerpc/firmware-assisted-dump.rst
> @@ -344,7 +344,7 @@ Here is the list of files under powerpc debugfs:
>  
>  
>  NOTE:
> -      Please refer to Documentation/filesystems/debugfs.txt on
> +      Please refer to Documentation/filesystems/debugfs.rst on
>        how to mount the debugfs filesystem.
>  
>  
> diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> index 1c3a840d06b9..a6b4a3a5bf3f 100644
> --- a/Documentation/process/adding-syscalls.rst
> +++ b/Documentation/process/adding-syscalls.rst
> @@ -33,7 +33,7 @@ interface.
>         to a somewhat opaque API.
>  
>   - If you're just exposing runtime system information, a new node in sysfs
> -   (see ``Documentation/filesystems/sysfs.txt``) or the ``/proc`` filesystem may
> +   (see ``Documentation/filesystems/sysfs.rst``) or the ``/proc`` filesystem may
>     be more appropriate.  However, access to these mechanisms requires that the
>     relevant filesystem is mounted, which might not always be the case (e.g.
>     in a namespaced/sandboxed/chrooted environment).  Avoid adding any API to
> diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst b/Documentation/translations/it_IT/process/adding-syscalls.rst
> index c3a3439595a6..bff0a82bf127 100644
> --- a/Documentation/translations/it_IT/process/adding-syscalls.rst
> +++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
> @@ -39,7 +39,7 @@ vostra interfaccia.
>         un qualche modo opaca.
>  
>   - Se dovete esporre solo delle informazioni sul sistema, un nuovo nodo in
> -   sysfs (vedere ``Documentation/filesystems/sysfs.txt``) o
> +   sysfs (vedere ``Documentation/filesystems/sysfs.rst``) o
>     in procfs potrebbe essere sufficiente.  Tuttavia, l'accesso a questi
>     meccanismi richiede che il filesystem sia montato, il che potrebbe non
>     essere sempre vero (per esempio, in ambienti come namespace/sandbox/chroot).
> diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Documentation/translations/zh_CN/filesystems/sysfs.txt
> index ee1f37da5b23..782500d85936 100644
> --- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
> +++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
> @@ -1,4 +1,4 @@
> -Chinese translated version of Documentation/filesystems/sysfs.txt
> +Chinese translated version of Documentation/filesystems/sysfs.rst
>  
>  If you have any comment or update to the content, please contact the
>  original document maintainer directly.  However, if you have a problem
> @@ -10,7 +10,7 @@ Maintainer: Patrick Mochel	<mochel@osdl.org>
>  		Mike Murphy <mamurph@cs.clemson.edu>
>  Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
>  ---------------------------------------------------------------------
> -Documentation/filesystems/sysfs.txt 的中文翻译
> +Documentation/filesystems/sysfs.rst 的中文翻译
>  
>  如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
>  交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
> @@ -281,7 +281,7 @@ drivers/ 包含了每个已为特定总线上的设备而挂载的驱动程序
>  假定驱动没有跨越多个总线类型)。
>  
>  fs/ 包含了一个为文件系统设立的目录。现在每个想要导出属性的文件系统必须
> -在 fs/ 下创建自己的层次结构(参见Documentation/filesystems/fuse.txt)。
> +在 fs/ 下创建自己的层次结构(参见Documentation/filesystems/fuse.rst)。
>  
>  dev/ 包含两个子目录： char/ 和 block/。在这两个子目录中，有以
>  <major>:<minor> 格式命名的符号链接。这些符号链接指向 sysfs 目录
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> index 211f5de99a44..9aba2910d83a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> @@ -170,7 +170,7 @@ struct dpu_global_state
>   *
>   * Main debugfs documentation is located at,
>   *
> - * Documentation/filesystems/debugfs.txt
> + * Documentation/filesystems/debugfs.rst
>   *
>   * @dpu_debugfs_setup_regset32: Initialize data for dpu_debugfs_create_regset32
>   * @dpu_debugfs_create_regset32: Create 32-bit register dump file
> diff --git a/fs/Kconfig b/fs/Kconfig
> index f08fbbfafd9a..d1ad3935fb85 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -166,7 +166,7 @@ config TMPFS
>  	  space. If you unmount a tmpfs instance, everything stored therein is
>  	  lost.
>  
> -	  See <file:Documentation/filesystems/tmpfs.txt> for details.
> +	  See <file:Documentation/filesystems/tmpfs.rst> for details.
>  
>  config TMPFS_POSIX_ACL
>  	bool "Tmpfs POSIX Access Control Lists"
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index 62dc4f577ba1..3fbbd54f50fd 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -72,7 +72,7 @@ config CORE_DUMP_DEFAULT_ELF_HEADERS
>  
>  	  The core dump behavior can be controlled per process using
>  	  the /proc/PID/coredump_filter pseudo-file; this setting is
> -	  inherited.  See Documentation/filesystems/proc.txt for details.
> +	  inherited.  See Documentation/filesystems/proc.rst for details.
>  
>  	  This config option changes the default setting of coredump_filter
>  	  seen at boot time.  If unsure, say Y.
> diff --git a/fs/adfs/Kconfig b/fs/adfs/Kconfig
> index df4650dccf68..44738fed6625 100644
> --- a/fs/adfs/Kconfig
> +++ b/fs/adfs/Kconfig
> @@ -12,7 +12,7 @@ config ADFS_FS
>  
>  	  The ADFS partition should be the first partition (i.e.,
>  	  /dev/[hs]d?1) on each of your drives. Please read the file
> -	  <file:Documentation/filesystems/adfs.txt> for further details.
> +	  <file:Documentation/filesystems/adfs.rst> for further details.
>  
>  	  To compile this code as a module, choose M here: the module will be
>  	  called adfs.
> diff --git a/fs/affs/Kconfig b/fs/affs/Kconfig
> index 84c46b9025c5..eb9d0ab850cb 100644
> --- a/fs/affs/Kconfig
> +++ b/fs/affs/Kconfig
> @@ -9,7 +9,7 @@ config AFFS_FS
>  	  FFS partition on your hard drive.  Amiga floppies however cannot be
>  	  read with this driver due to an incompatibility of the floppy
>  	  controller used in an Amiga and the standard floppy controller in
> -	  PCs and workstations. Read <file:Documentation/filesystems/affs.txt>
> +	  PCs and workstations. Read <file:Documentation/filesystems/affs.rst>
>  	  and <file:fs/affs/Changes>.
>  
>  	  With this driver you can also mount disk files used by Bernd
> diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
> index 3fb1f559e317..1ad211d72b3b 100644
> --- a/fs/afs/Kconfig
> +++ b/fs/afs/Kconfig
> @@ -8,7 +8,7 @@ config AFS_FS
>  	  If you say Y here, you will get an experimental Andrew File System
>  	  driver. It currently only supports unsecured read-only AFS access.
>  
> -	  See <file:Documentation/filesystems/afs.txt> for more information.
> +	  See <file:Documentation/filesystems/afs.rst> for more information.
>  
>  	  If unsure, say N.
>  
> @@ -18,7 +18,7 @@ config AFS_DEBUG
>  	help
>  	  Say Y here to make runtime controllable debugging messages appear.
>  
> -	  See <file:Documentation/filesystems/afs.txt> for more information.
> +	  See <file:Documentation/filesystems/afs.rst> for more information.
>  
>  	  If unsure, say N.
>  
> @@ -37,6 +37,6 @@ config AFS_DEBUG_CURSOR
>  	  the dmesg log if the server rotation algorithm fails to successfully
>  	  contact a server.
>  
> -	  See <file:Documentation/filesystems/afs.txt> for more information.
> +	  See <file:Documentation/filesystems/afs.rst> for more information.
>  
>  	  If unsure, say N.
> diff --git a/fs/bfs/Kconfig b/fs/bfs/Kconfig
> index 3e1247f07913..3a757805b585 100644
> --- a/fs/bfs/Kconfig
> +++ b/fs/bfs/Kconfig
> @@ -11,7 +11,7 @@ config BFS_FS
>  	  on your /stand slice from within Linux.  You then also need to say Y
>  	  to "UnixWare slices support", below.  More information about the BFS
>  	  file system is contained in the file
> -	  <file:Documentation/filesystems/bfs.txt>.
> +	  <file:Documentation/filesystems/bfs.rst>.
>  
>  	  If you don't know what this is about, say N.
>  
> diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
> index c8bebb70a971..d98cef0dbb6b 100644
> --- a/fs/cramfs/Kconfig
> +++ b/fs/cramfs/Kconfig
> @@ -9,7 +9,7 @@ config CRAMFS
>  	  limited to 256MB file systems (with 16MB files), and doesn't support
>  	  16/32 bits uid/gid, hard links and timestamps.
>  
> -	  See <file:Documentation/filesystems/cramfs.txt> and
> +	  See <file:Documentation/filesystems/cramfs.rst> and
>  	  <file:fs/cramfs/README> for further information.
>  
>  	  To compile this as a module, choose M here: the module will be called
> diff --git a/fs/ecryptfs/Kconfig b/fs/ecryptfs/Kconfig
> index 522c35d5292b..1bdeaa6d5790 100644
> --- a/fs/ecryptfs/Kconfig
> +++ b/fs/ecryptfs/Kconfig
> @@ -7,7 +7,7 @@ config ECRYPT_FS
>  	select CRYPTO_MD5
>  	help
>  	  Encrypted filesystem that operates on the VFS layer.  See
> -	  <file:Documentation/filesystems/ecryptfs.txt> to learn more about
> +	  <file:Documentation/filesystems/ecryptfs.rst> to learn more about
>  	  eCryptfs.  Userspace components are required and can be
>  	  obtained from <http://ecryptfs.sf.net>.
>  
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 718163d0c621..ca31993dcb47 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -69,7 +69,7 @@ config VFAT_FS
>  
>  	  The VFAT support enlarges your kernel by about 10 KB and it only
>  	  works if you said Y to the "DOS FAT fs support" above.  Please read
> -	  the file <file:Documentation/filesystems/vfat.txt> for details.  If
> +	  the file <file:Documentation/filesystems/vfat.rst> for details.  If
>  	  unsure, say Y.
>  
>  	  To compile this as a module, choose M here: the module will be called
> @@ -82,7 +82,7 @@ config FAT_DEFAULT_CODEPAGE
>  	help
>  	  This option should be set to the codepage of your FAT filesystems.
>  	  It can be overridden with the "codepage" mount option.
> -	  See <file:Documentation/filesystems/vfat.txt> for more information.
> +	  See <file:Documentation/filesystems/vfat.rst> for more information.
>  
>  config FAT_DEFAULT_IOCHARSET
>  	string "Default iocharset for FAT"
> @@ -96,7 +96,7 @@ config FAT_DEFAULT_IOCHARSET
>  	  Note that "utf8" is not recommended for FAT filesystems.
>  	  If unsure, you shouldn't set "utf8" here - select the next option
>  	  instead if you would like to use UTF-8 encoded file names by default.
> -	  See <file:Documentation/filesystems/vfat.txt> for more information.
> +	  See <file:Documentation/filesystems/vfat.rst> for more information.
>  
>  	  Enable any character sets you need in File Systems/Native Language
>  	  Support.
> @@ -114,4 +114,4 @@ config FAT_DEFAULT_UTF8
>  
>  	  Say Y if you use UTF-8 encoding for file names, N otherwise.
>  
> -	  See <file:Documentation/filesystems/vfat.txt> for more information.
> +	  See <file:Documentation/filesystems/vfat.rst> for more information.
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index eb2a585572dc..774b2618018a 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -12,7 +12,7 @@ config FUSE_FS
>  	  although chances are your distribution already has that library
>  	  installed if you've installed the "fuse" package itself.
>  
> -	  See <file:Documentation/filesystems/fuse.txt> for more information.
> +	  See <file:Documentation/filesystems/fuse.rst> for more information.
>  	  See <file:Documentation/Changes> for needed library/utility version.
>  
>  	  If you want to develop a userspace FS, or if you want to use
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 97eec7522bf2..c7a65cf2bcca 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2081,7 +2081,7 @@ static void end_polls(struct fuse_conn *fc)
>   * The same effect is usually achievable through killing the filesystem daemon
>   * and all users of the filesystem.  The exception is the combination of an
>   * asynchronous request and the tricky deadlock (see
> - * Documentation/filesystems/fuse.txt).
> + * Documentation/filesystems/fuse.rst).
>   *
>   * Aborting requests under I/O goes as follows: 1: Separate out unlocked
>   * requests, they should be finished off immediately.  Locked requests will be
> diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
> index 44f6e89bcb75..129926b5142d 100644
> --- a/fs/hfs/Kconfig
> +++ b/fs/hfs/Kconfig
> @@ -6,7 +6,7 @@ config HFS_FS
>  	help
>  	  If you say Y here, you will be able to mount Macintosh-formatted
>  	  floppy disks and hard drive partitions with full read-write access.
> -	  Please read <file:Documentation/filesystems/hfs.txt> to learn about
> +	  Please read <file:Documentation/filesystems/hfs.rst> to learn about
>  	  the available mount options.
>  
>  	  To compile this file system support as a module, choose M here: the
> diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
> index 56aa0336254a..2b36dc6f0a10 100644
> --- a/fs/hpfs/Kconfig
> +++ b/fs/hpfs/Kconfig
> @@ -9,7 +9,7 @@ config HPFS_FS
>  	  write files to an OS/2 HPFS partition on your hard drive. OS/2
>  	  floppies however are in regular MSDOS format, so you don't need this
>  	  option in order to be able to read them. Read
> -	  <file:Documentation/filesystems/hpfs.txt>.
> +	  <file:Documentation/filesystems/hpfs.rst>.
>  
>  	  To compile this file system support as a module, choose M here: the
>  	  module will be called hpfs.  If unsure, say N.
> diff --git a/fs/isofs/Kconfig b/fs/isofs/Kconfig
> index 5e7419599f50..08ffd37b9bb8 100644
> --- a/fs/isofs/Kconfig
> +++ b/fs/isofs/Kconfig
> @@ -8,7 +8,7 @@ config ISO9660_FS
>  	  long Unix filenames and symbolic links are also supported by this
>  	  driver.  If you have a CD-ROM drive and want to do more with it than
>  	  just listen to audio CDs and watch its LEDs, say Y (and read
> -	  <file:Documentation/filesystems/isofs.txt> and the CD-ROM-HOWTO,
> +	  <file:Documentation/filesystems/isofs.rst> and the CD-ROM-HOWTO,
>  	  available from <http://www.tldp.org/docs.html#howto>), thereby
>  	  enlarging your kernel by about 27 KB; otherwise say N.
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e6aed405611d..894a1d12fe5f 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3592,7 +3592,7 @@ EXPORT_SYMBOL(path_is_under);
>   * file system may be mounted on put_old. After all, new_root is a mountpoint.
>   *
>   * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem.
> - * See Documentation/filesystems/ramfs-rootfs-initramfs.txt for alternatives
> + * See Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
>   * in this situation.
>   *
>   * Notes:
> diff --git a/fs/notify/inotify/Kconfig b/fs/notify/inotify/Kconfig
> index 6736e47d94d8..7715fadd5fff 100644
> --- a/fs/notify/inotify/Kconfig
> +++ b/fs/notify/inotify/Kconfig
> @@ -12,6 +12,6 @@ config INOTIFY_USER
>  	  new features including multiple file events, one-shot support, and
>  	  unmount notification.
>  
> -	  For more information, see <file:Documentation/filesystems/inotify.txt>
> +	  For more information, see <file:Documentation/filesystems/inotify.rst>
>  
>  	  If unsure, say Y.
> diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
> index de9fb5cff226..1667a7e590d8 100644
> --- a/fs/ntfs/Kconfig
> +++ b/fs/ntfs/Kconfig
> @@ -18,7 +18,7 @@ config NTFS_FS
>  	  the Linux 2.4 kernel series is separately available as a patch
>  	  from the project web site.
>  
> -	  For more information see <file:Documentation/filesystems/ntfs.txt>
> +	  For more information see <file:Documentation/filesystems/ntfs.rst>
>  	  and <http://www.linux-ntfs.org/>.
>  
>  	  To compile this file system support as a module, choose M here: the
> diff --git a/fs/ocfs2/Kconfig b/fs/ocfs2/Kconfig
> index 46bba20da6b5..1177c33df895 100644
> --- a/fs/ocfs2/Kconfig
> +++ b/fs/ocfs2/Kconfig
> @@ -21,7 +21,7 @@ config OCFS2_FS
>  	  OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
>  
>  	  For more information on OCFS2, see the file
> -	  <file:Documentation/filesystems/ocfs2.txt>.
> +	  <file:Documentation/filesystems/ocfs2.rst>.
>  
>  config OCFS2_FS_O2CB
>  	tristate "O2CB Kernelspace Clustering"
> diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
> index 714c14c47ca5..dd188c7996b3 100644
> --- a/fs/overlayfs/Kconfig
> +++ b/fs/overlayfs/Kconfig
> @@ -9,7 +9,7 @@ config OVERLAY_FS
>  	  'lower' filesystem is either hidden or, in the case of directories,
>  	  merged with the 'upper' object.
>  
> -	  For more information see Documentation/filesystems/overlayfs.txt
> +	  For more information see Documentation/filesystems/overlayfs.rst
>  
>  config OVERLAY_FS_REDIRECT_DIR
>  	bool "Overlayfs: turn on redirect directory feature by default"
> @@ -38,7 +38,7 @@ config OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW
>  	  If backward compatibility is not an issue, then it is safe and
>  	  recommended to say N here.
>  
> -	  For more information, see Documentation/filesystems/overlayfs.txt
> +	  For more information, see Documentation/filesystems/overlayfs.rst
>  
>  	  If unsure, say Y.
>  
> @@ -103,7 +103,7 @@ config OVERLAY_FS_XINO_AUTO
>  	  If compatibility with applications that expect 32bit inodes is not an
>  	  issue, then it is safe and recommended to say Y here.
>  
> -	  For more information, see Documentation/filesystems/overlayfs.txt
> +	  For more information, see Documentation/filesystems/overlayfs.rst
>  
>  	  If unsure, say N.
>  
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 27ef84d99f59..971a42f6357d 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -23,7 +23,7 @@ config PROC_FS
>  	  /proc" or the equivalent line in /etc/fstab does the job.
>  
>  	  The /proc file system is explained in the file
> -	  <file:Documentation/filesystems/proc.txt> and on the proc(5) manpage
> +	  <file:Documentation/filesystems/proc.rst> and on the proc(5) manpage
>  	  ("man 5 proc").
>  
>  	  This option will enlarge your kernel by about 67 KB. Several
> @@ -95,7 +95,7 @@ config PROC_CHILDREN
>  	default n
>  	help
>  	  Provides a fast way to retrieve first level children pids of a task. See
> -	  <file:Documentation/filesystems/proc.txt> for more information.
> +	  <file:Documentation/filesystems/proc.rst> for more information.
>  
>  	  Say Y if you are running any user-space software which takes benefit from
>  	  this interface. For example, rkt is such a piece of software.
> diff --git a/fs/romfs/Kconfig b/fs/romfs/Kconfig
> index ad4c45788896..9737b8e68878 100644
> --- a/fs/romfs/Kconfig
> +++ b/fs/romfs/Kconfig
> @@ -6,7 +6,7 @@ config ROMFS_FS
>  	  This is a very small read-only file system mainly intended for
>  	  initial ram disks of installation disks, but it could be used for
>  	  other read-only media as well.  Read
> -	  <file:Documentation/filesystems/romfs.txt> for details.
> +	  <file:Documentation/filesystems/romfs.rst> for details.
>  
>  	  To compile this file system support as a module, choose M here: the
>  	  module will be called romfs.  Note that the file system of your
> diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
> index aa85f2874a9f..59dffd5ca517 100644
> --- a/fs/sysfs/dir.c
> +++ b/fs/sysfs/dir.c
> @@ -6,7 +6,7 @@
>   * Copyright (c) 2007 SUSE Linux Products GmbH
>   * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
>   *
> - * Please see Documentation/filesystems/sysfs.txt for more information.
> + * Please see Documentation/filesystems/sysfs.rst for more information.
>   */
>  
>  #define pr_fmt(fmt)	"sysfs: " fmt
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 26bbf960e2a2..f275fcda62fb 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -6,7 +6,7 @@
>   * Copyright (c) 2007 SUSE Linux Products GmbH
>   * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
>   *
> - * Please see Documentation/filesystems/sysfs.txt for more information.
> + * Please see Documentation/filesystems/sysfs.rst for more information.
>   */
>  
>  #include <linux/module.h>
> diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
> index db81cfbab9d6..e747c135c1d1 100644
> --- a/fs/sysfs/mount.c
> +++ b/fs/sysfs/mount.c
> @@ -6,7 +6,7 @@
>   * Copyright (c) 2007 SUSE Linux Products GmbH
>   * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
>   *
> - * Please see Documentation/filesystems/sysfs.txt for more information.
> + * Please see Documentation/filesystems/sysfs.rst for more information.
>   */
>  
>  #include <linux/fs.h>
> diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
> index c4deecc80f67..5603530a1a52 100644
> --- a/fs/sysfs/symlink.c
> +++ b/fs/sysfs/symlink.c
> @@ -6,7 +6,7 @@
>   * Copyright (c) 2007 SUSE Linux Products GmbH
>   * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
>   *
> - * Please see Documentation/filesystems/sysfs.txt for more information.
> + * Please see Documentation/filesystems/sysfs.rst for more information.
>   */
>  
>  #include <linux/fs.h>
> diff --git a/fs/sysv/Kconfig b/fs/sysv/Kconfig
> index d4edf7d9ae10..b4e23e03fbeb 100644
> --- a/fs/sysv/Kconfig
> +++ b/fs/sysv/Kconfig
> @@ -28,7 +28,7 @@ config SYSV_FS
>  	  tar" or preferably "info tar").  Note also that this option has
>  	  nothing whatsoever to do with the option "System V IPC". Read about
>  	  the System V file system in
> -	  <file:Documentation/filesystems/sysv-fs.txt>.
> +	  <file:Documentation/filesystems/sysv-fs.rst>.
>  	  Saying Y here will enlarge your kernel by about 27 KB.
>  
>  	  To compile this as a module, choose M here: the module will be called
> diff --git a/fs/udf/Kconfig b/fs/udf/Kconfig
> index 6848de581ce1..26e1a49f3ba7 100644
> --- a/fs/udf/Kconfig
> +++ b/fs/udf/Kconfig
> @@ -9,7 +9,7 @@ config UDF_FS
>  	  compatible with standard unix file systems, it is also suitable for
>  	  removable USB disks. Say Y if you intend to mount DVD discs or CDRW's
>  	  written in packet mode, or if you want to use UDF for removable USB
> -	  disks. Please read <file:Documentation/filesystems/udf.txt>.
> +	  disks. Please read <file:Documentation/filesystems/udf.rst>.
>  
>  	  To compile this file system support as a module, choose M here: the
>  	  module will be called udf.
> diff --git a/include/linux/relay.h b/include/linux/relay.h
> index c759f96e39c1..e13a333e7c37 100644
> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -141,7 +141,7 @@ struct rchan_callbacks
>  	 * cause relay_open() to create a single global buffer rather
>  	 * than the default set of per-cpu buffers.
>  	 *
> -	 * See Documentation/filesystems/relay.txt for more info.
> +	 * See Documentation/filesystems/relay.rst for more info.
>  	 */
>  	struct dentry *(*create_buf_file)(const char *filename,
>  					  struct dentry *parent,
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 80bb865b3a33..86067dbe7745 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -7,7 +7,7 @@
>   * Copyright (c) 2007 SUSE Linux Products GmbH
>   * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
>   *
> - * Please see Documentation/filesystems/sysfs.txt for more information.
> + * Please see Documentation/filesystems/sysfs.rst for more information.
>   */
>  
>  #ifndef _SYSFS_H_
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 07ee1a791d85..628f570ca678 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -1,7 +1,7 @@
>  /*
>   * Public API and common code for kernel->userspace relay file support.
>   *
> - * See Documentation/filesystems/relay.txt for an overview.
> + * See Documentation/filesystems/relay.rst for an overview.
>   *
>   * Copyright (C) 2002-2005 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
>   * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
> 
