Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B144178C09
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 08:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgCDH7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 02:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgCDH7K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:59:10 -0500
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44EEF20866;
        Wed,  4 Mar 2020 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583308749;
        bh=L1H6M6gHwQJT8kztc/VbrbHKbYCULOj2sy5j6VFNTfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N+7+aGCpY4pXsBoQatFuCnXxv+ulHMk3hh82Mr1Ws2jzCnJpOiWtUfvpPouFL3/3K
         uyYJi2OyCBUoytQW56KFc12VBaDMc/DXNrjTPJtODNKCPZO0xWTUgYzZYdyhJ+vmjc
         ZaXhKTmj/sguZHsKRF2a2+9R7rXBZBYf/HIn9jVU=
Date:   Wed, 4 Mar 2020 08:59:05 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
Message-ID: <20200304085905.6b71fe8c@coco.lan>
In-Reply-To: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Wed,  4 Mar 2020 08:29:50 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:

> Mauro's patch series <cover.1581955849.git.mchehab+huawei@kernel.org>
> ("[PATCH 00/44] Manually convert filesystem FS documents to ReST")
> converts many Documentation/filesystems/ files to ReST.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains with 27
> warnings on Documentation/filesystems/ of this kind:
> 
>   warning: no file matches F: Documentation/filesystems/...
> 
> Adjust MAINTAINERS entries to all files converted from .txt to .rst in the
> patch series and address the 27 warnings.
> 
> Link: https://lore.kernel.org/linux-erofs/cover.1581955849.git.mchehab+huawei@kernel.org
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> Mauro, please ack.
> Jonathan, pick pick this patch for doc-next.
> 
> Note there are still two further warnings remaining in Documentation:
> 
>   warning: no file matches F: Documentation/networking/6lowpan.txt
>   warning: no file matches F: Documentation/kobject.txt
> 
> Patches for those warnings will follow.

Btw, those can easily be fixed with:

	./scripts/documentation-file-ref-check --fix

I had already a similar patch to this one already on my tree, intending
to submit later today. You were faster than me on that ;-)

> 
>  MAINTAINERS | 54 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46fdb834d1fb..e19b275f2ac2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -214,7 +214,7 @@ Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
>  T:	git git://github.com/martinetd/linux.git
>  S:	Maintained
> -F:	Documentation/filesystems/9p.txt
> +F:	Documentation/filesystems/9p.rst
>  F:	fs/9p/
>  F:	net/9p/
>  F:	include/net/9p/
> @@ -584,7 +584,7 @@ AFFS FILE SYSTEM
>  M:	David Sterba <dsterba@suse.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Odd Fixes
> -F:	Documentation/filesystems/affs.txt
> +F:	Documentation/filesystems/affs.rst
>  F:	fs/affs/
>  
>  AFS FILESYSTEM
> @@ -593,7 +593,7 @@ L:	linux-afs@lists.infradead.org
>  S:	Supported
>  F:	fs/afs/
>  F:	include/trace/events/afs.h
> -F:	Documentation/filesystems/afs.txt
> +F:	Documentation/filesystems/afs.rst
>  W:	https://www.infradead.org/~dhowells/kafs/
>  
>  AGPGART DRIVER
> @@ -3076,7 +3076,7 @@ M:	Luis de Bethencourt <luisbg@kernel.org>
>  M:	Salah Triki <salah.triki@gmail.com>
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/luisbg/linux-befs.git
> -F:	Documentation/filesystems/befs.txt
> +F:	Documentation/filesystems/befs.rst
>  F:	fs/befs/
>  
>  BFQ I/O SCHEDULER
> @@ -3090,7 +3090,7 @@ F:	Documentation/block/bfq-iosched.rst
>  BFS FILE SYSTEM
>  M:	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>
>  S:	Maintained
> -F:	Documentation/filesystems/bfs.txt
> +F:	Documentation/filesystems/bfs.rst
>  F:	fs/bfs/
>  F:	include/uapi/linux/bfs_fs.h
>  
> @@ -3623,7 +3623,7 @@ W:	http://btrfs.wiki.kernel.org/
>  Q:	http://patchwork.kernel.org/project/linux-btrfs/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs.git
>  S:	Maintained
> -F:	Documentation/filesystems/btrfs.txt
> +F:	Documentation/filesystems/btrfs.rst
>  F:	fs/btrfs/
>  F:	include/linux/btrfs*
>  F:	include/uapi/linux/btrfs*
> @@ -3920,7 +3920,7 @@ W:	http://ceph.com/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
>  T:	git git://github.com/ceph/ceph-client.git
>  S:	Supported
> -F:	Documentation/filesystems/ceph.txt
> +F:	Documentation/filesystems/ceph.rst
>  F:	fs/ceph/
>  
>  CERTIFICATE HANDLING
> @@ -4432,7 +4432,7 @@ F:	include/linux/cpuidle.h
>  CRAMFS FILESYSTEM
>  M:	Nicolas Pitre <nico@fluxnic.net>
>  S:	Maintained
> -F:	Documentation/filesystems/cramfs.txt
> +F:	Documentation/filesystems/cramfs.rst
>  F:	fs/cramfs/
>  
>  CREATIVE SB0540
> @@ -5975,7 +5975,7 @@ W:	http://ecryptfs.org
>  W:	https://launchpad.net/ecryptfs
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git
>  S:	Odd Fixes
> -F:	Documentation/filesystems/ecryptfs.txt
> +F:	Documentation/filesystems/ecryptfs.rst
>  F:	fs/ecryptfs/
>  
>  EDAC-AMD64
> @@ -6297,7 +6297,7 @@ M:	Chao Yu <yuchao0@huawei.com>
>  L:	linux-erofs@lists.ozlabs.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
> -F:	Documentation/filesystems/erofs.txt
> +F:	Documentation/filesystems/erofs.rst
>  F:	fs/erofs/
>  F:	include/trace/events/erofs.h
>  
> @@ -6358,7 +6358,7 @@ EXT2 FILE SYSTEM
>  M:	Jan Kara <jack@suse.com>
>  L:	linux-ext4@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/filesystems/ext2.txt
> +F:	Documentation/filesystems/ext2.rst
>  F:	fs/ext2/
>  F:	include/linux/ext2*
>  
> @@ -6432,7 +6432,7 @@ L:	linux-f2fs-devel@lists.sourceforge.net
>  W:	https://f2fs.wiki.kernel.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
>  S:	Maintained
> -F:	Documentation/filesystems/f2fs.txt
> +F:	Documentation/filesystems/f2fs.rst
>  F:	Documentation/ABI/testing/sysfs-fs-f2fs
>  F:	fs/f2fs/
>  F:	include/linux/f2fs_fs.h
> @@ -7474,13 +7474,13 @@ F:	drivers/infiniband/hw/hfi1
>  HFS FILESYSTEM
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Orphan
> -F:	Documentation/filesystems/hfs.txt
> +F:	Documentation/filesystems/hfs.rst
>  F:	fs/hfs/
>  
>  HFSPLUS FILESYSTEM
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Orphan
> -F:	Documentation/filesystems/hfsplus.txt
> +F:	Documentation/filesystems/hfsplus.rst
>  F:	fs/hfsplus/
>  
>  HGA FRAMEBUFFER DRIVER
> @@ -8351,7 +8351,7 @@ M:	Jan Kara <jack@suse.cz>
>  R:	Amir Goldstein <amir73il@gmail.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/filesystems/inotify.txt
> +F:	Documentation/filesystems/inotify.rst
>  F:	fs/notify/inotify/
>  F:	include/linux/inotify.h
>  F:	include/uapi/linux/inotify.h
> @@ -11854,7 +11854,7 @@ W:	https://nilfs.sourceforge.io/
>  W:	https://nilfs.osdn.jp/
>  T:	git git://github.com/konis/nilfs2.git
>  S:	Supported
> -F:	Documentation/filesystems/nilfs2.txt
> +F:	Documentation/filesystems/nilfs2.rst
>  F:	fs/nilfs2/
>  F:	include/trace/events/nilfs2.h
>  F:	include/uapi/linux/nilfs2_api.h
> @@ -11963,7 +11963,7 @@ L:	linux-ntfs-dev@lists.sourceforge.net
>  W:	http://www.tuxera.com/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
>  S:	Supported
> -F:	Documentation/filesystems/ntfs.txt
> +F:	Documentation/filesystems/ntfs.rst
>  F:	fs/ntfs/
>  
>  NUBUS SUBSYSTEM
> @@ -12309,7 +12309,7 @@ OMFS FILESYSTEM
>  M:	Bob Copeland <me@bobcopeland.com>
>  L:	linux-karma-devel@lists.sourceforge.net
>  S:	Maintained
> -F:	Documentation/filesystems/omfs.txt
> +F:	Documentation/filesystems/omfs.rst
>  F:	fs/omfs/
>  
>  OMNIKEY CARDMAN 4000 DRIVER
> @@ -12557,8 +12557,8 @@ M:	Joseph Qi <joseph.qi@linux.alibaba.com>
>  L:	ocfs2-devel@oss.oracle.com (moderated for non-subscribers)
>  W:	http://ocfs2.wiki.kernel.org
>  S:	Supported
> -F:	Documentation/filesystems/ocfs2.txt
> -F:	Documentation/filesystems/dlmfs.txt
> +F:	Documentation/filesystems/ocfs2.rst
> +F:	Documentation/filesystems/dlmfs.rst
>  F:	fs/ocfs2/
>  
>  ORANGEFS FILESYSTEM
> @@ -12568,7 +12568,7 @@ L:	devel@lists.orangefs.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
>  S:	Supported
>  F:	fs/orangefs/
> -F:	Documentation/filesystems/orangefs.txt
> +F:	Documentation/filesystems/orangefs.rst
>  
>  ORINOCO DRIVER
>  L:	linux-wireless@vger.kernel.org
> @@ -13530,7 +13530,7 @@ S:	Maintained
>  F:	fs/proc/
>  F:	include/linux/proc_fs.h
>  F:	tools/testing/selftests/proc/
> -F:	Documentation/filesystems/proc.txt
> +F:	Documentation/filesystems/proc.rst
>  
>  PROC SYSCTL
>  M:	Luis Chamberlain <mcgrof@kernel.org>
> @@ -15818,7 +15818,7 @@ L:	squashfs-devel@lists.sourceforge.net (subscribers-only)
>  W:	http://squashfs.org.uk
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pkl/squashfs-next.git
>  S:	Maintained
> -F:	Documentation/filesystems/squashfs.txt
> +F:	Documentation/filesystems/squashfs.rst
>  F:	fs/squashfs/
>  
>  SRM (Alpha) environment access
> @@ -16261,7 +16261,7 @@ F:	drivers/platform/x86/system76_acpi.c
>  SYSV FILESYSTEM
>  M:	Christoph Hellwig <hch@infradead.org>
>  S:	Maintained
> -F:	Documentation/filesystems/sysv-fs.txt
> +F:	Documentation/filesystems/sysv-fs.rst
>  F:	fs/sysv/
>  F:	include/linux/sysv_fs.h
>  
> @@ -17126,7 +17126,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git next
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git fixes
>  W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
>  S:	Supported
> -F:	Documentation/filesystems/ubifs.txt
> +F:	Documentation/filesystems/ubifs.rst
>  F:	fs/ubifs/
>  
>  UCLINUX (M68KNOMMU AND COLDFIRE)
> @@ -17145,7 +17145,7 @@ F:	arch/m68k/include/asm/*_no.*
>  UDF FILESYSTEM
>  M:	Jan Kara <jack@suse.com>
>  S:	Maintained
> -F:	Documentation/filesystems/udf.txt
> +F:	Documentation/filesystems/udf.rst
>  F:	fs/udf/
>  
>  UDRAW TABLET
> @@ -18585,7 +18585,7 @@ L:	linux-fsdevel@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
>  S:	Maintained
>  F:	fs/zonefs/
> -F:	Documentation/filesystems/zonefs.txt
> +F:	Documentation/filesystems/zonefs.rst
>  
>  ZPOOL COMPRESSED PAGE STORAGE API
>  M:	Dan Streetman <ddstreet@ieee.org>


Thanks,
Mauro
