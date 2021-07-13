Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807DE3C6FAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhGML0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:26:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:33279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhGML0V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626175402;
        bh=VRDcu4s23xbaG8DaDgsxSjmIflVi1jWqXTBGkyCJL0A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WB0D080yR8qWqFtZc5snjngFLP0DgAtwRgEKk8snSMD9zmxcaPqlfi5+c5ulKqLY8
         WpMg76/KV3BCTALRs5hyYvullbq0JfPIgFETUQ0p30zBM3kVls+rcV2lkMYeBZnEJQ
         DJu5HHuY2Sxct2eZydeptBWDPRjJNnA09rN8l9wI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs4f-1lPTdg1f8b-00muCc; Tue, 13
 Jul 2021 13:23:22 +0200
Subject: Re: [PATCH 00/24] btrfs: support idmapped mounts
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210713111344.1149376-1-brauner@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <14addf76-b6f7-11ab-119b-4a1138bbd458@gmx.com>
Date:   Tue, 13 Jul 2021 19:23:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iuZLZ1YxFYEKFeMSk+eVwe2SjhGfi7Umae/3nE3tR2d2bgiBjhX
 lhskxotv5AzsZqahMzcj3OxZFNKyd9E1czbhDRXNvftb8H0khifhVT6NDA4Pe6Q2Wd1v8Wv
 MFluqVkLDEIaMCUzHgnU8Q5DWbzQb5bd3qeOy8d+5SBaL5MEI2+4Uk70pfhDgRTIET8zGg0
 Qoa2/u1K3tvd6DUnBpeHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0NpS09neatw=:G1Nt0VMmJ3Aouo0tAZYIle
 2Mrt0Yva6gdMoIJ6xmXMbO3AnJ3o3PIDL0og/130wET2SzKZeVbEJraoAEpwpeqsUfv+NjfIG
 A6PEfBprpbql0XLVcTAtTpH517sfl4azXCdr/P4Joss4w8JKmfVy53CogdaQcBYhh56FHt6O/
 Pr27uTBfRhcWqwjink59BACG1EtbJKihq+HYCe0odZxnJ6WoQM8yqXcLj0aVob19AwZa+LjNV
 5IBVamPAVxJfhDyZMOt2KitxKF/lIqoVLorncpwY1HPVz7/YhkklLpapO4JK+Ylz0hpna6C0E
 qLA+fEm/KVuPVKBFkN8NiLRUBwQfld+u1szj9b+PRJAf9hPYgPRvxgywGCQPYdAOEJKH887Q4
 tLz0WGi1/y3EtGIB9+3EDxJ0VSf5Lzc83PfSYCThF+f13Dv9MgAWPIFlx3VJ23sJAf1WpwneF
 j23lWf3Ui4JAAADSAHa013tq922eDHCiMDF3e0PerFwbzNEIYy0lFXFJt5gLmbtiXnf+AfauE
 DBOk6x2yyBr1nRH73hYmu4DU7Drb0As2iDOGEIx56SUsdGphNGpXy9szUqU1zJm4PkjF9laNe
 m/mktXgw06FcOKpwn5qEW0mUfBVr3N2QE0yEDs8a6XwOV/2n1dviHIDBxzYawYh+aHwVN8lfr
 p70cOHwLr6NVxFghMc5LESzyCteIVfYXPINA8k4Ii+ZLjclnLqaClVIzYcqRFZiYvFxvShpxg
 VSYqCxFnTBhzz8eHqNtBGr8TS16i9bGfwKa0dOnUc+MSbPGD2v6v7TPq+R7kXxmAdOcAF8jfN
 hV9wzlcTWh7xfGgsM9C6pJN4Z2BR6yHL9UIjTyKA0ljgpvpPIUjeFFdoNDUnEZmAgzCWO/Xr2
 moEtHW2GX7JQNNxYqksOS8jJBRrVW8iMtEmQuSYli05m3opS/vCZ8eLrW9fVUkCRTV+WVfDN/
 VsrLd8xi14K+MA9Tl70M6vg7or59Aq9M0WrXT2ubrk/gmhRpWGGGUd8goSdmc+4bUkDEmEPOL
 DFNZX6csfJEkMI+5PJKsK3X1jsVx8UDN/66Z4U/ZkxABLJyxwI1Qm1Wo4e4x7Iel3LqibSUQv
 LUNUeISEYvVpkY7W8HBGFv60H/tysEQUOgH+ARue8uSHo6DPeTITI75pA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/7/13 =E4=B8=8B=E5=8D=887:13, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Hey everyone,
>
> This series enables the creation of idmapped mounts on btrfs.

Any doc on the "idmapped" part?

Not familiar with that, the only thing I can thing of is from NFSv4
idmapd, is that related or a completely new thing?

Thanks,
Qu

> On the list of
> filesystems btrfs was pretty high-up and requested quite often from user=
space
> (cf. [1]). This series requires just a few changes to the vfs for specif=
ic
> lookup helpers that btrfs relies on to perform permission checking when =
looking
> up an inode. The changes are required to port some other filesystem as w=
ell.
>
> The conversion of the necessary btrfs internals was fairly straightforwa=
rd. No
> invasive changes were needed. I've decided to split up the patchset into=
 very
> small individual patches. This hopefully makes the series more readable =
and
> fairly easy to review. The overall changeset is quite small.
>
> All non-filesystem wide ioctls that peform permission checking based on =
inodes
> can be supported on idmapped mounts. There are really just a few restric=
tions.
> This should really only affect the deletion of subvolumes by subvolume i=
d which
> can be used to delete any subvolume in the filesystem even though the ca=
ller
> might not even be able to see the subvolume under their mount. Other tha=
n that
> behavior on idmapped and non-idmapped mounts is identical for all enable=
d
> ioctls.
>
> The changeset has an associated new testsuite specific to btrfs. The
> core vfs operations that btrfs implements are covered by the generic
> idmapped mount testsuite. For the ioctls a new testsuite was added. It
> is sent alongside this patchset for ease of review but will very likely
> be merged independent of it.
>
> All patches are based on v5.14-rc1.
>
> The series can be pulled from:
> https://git.kernel.org/brauner/h/fs.idmapped.btrfs
> https://github.com/brauner/linux/tree/fs.idmapped.btrfs
>
> The xfstests can be pulled from:
> https://git.kernel.org/brauner/xfstests-dev/h/fs.idmapped.btrfs
> https://github.com/brauner/xfstests/tree/fs.idmapped.btrfs
>
> Note, the new btrfs xfstests patch is on top of a branch of mine
> containing a few more preliminary patches. So if you want to run the
> tests, please simply pull the branch and build from there. It's based on
> latest xfstests master.
>
> The series has been tested with xfstests including the newly added btrfs
> specific test. All tests pass.
> There were three unrelated failures that I observed: btrfs/219,
> btrfs/2020 and btrfs/235. All three also fail on earlier kernels
> without the patch series applied.
>
> Thanks!
> Christian
>
> [1]: https://github.com/systemd/systemd/pull/19438#discussion_r622807165
>
> Christian Brauner (23):
>    namei: handle mappings in lookup_one_len()
>    namei: handle mappings in lookup_one_len_unlocked()
>    namei: handle mappings in lookup_positive_unlocked()
>    namei: handle mappings in try_lookup_one_len()
>    btrfs/inode: handle idmaps in btrfs_new_inode()
>    btrfs/inode: allow idmapped rename iop
>    btrfs/inode: allow idmapped getattr iop
>    btrfs/inode: allow idmapped mknod iop
>    btrfs/inode: allow idmapped create iop
>    btrfs/inode: allow idmapped mkdir iop
>    btrfs/inode: allow idmapped symlink iop
>    btrfs/inode: allow idmapped tmpfile iop
>    btrfs/inode: allow idmapped setattr iop
>    btrfs/inode: allow idmapped permission iop
>    btrfs/ioctl: check whether fs{g,u}id are mapped during subvolume
>      creation
>    btrfs/inode: allow idmapped BTRFS_IOC_{SNAP,SUBVOL}_CREATE{_V2} ioctl
>    btrfs/ioctl: allow idmapped BTRFS_IOC_SNAP_DESTROY{_V2} ioctl
>    btrfs/ioctl: relax restrictions for BTRFS_IOC_SNAP_DESTROY_V2 with
>      subvolids
>    btrfs/ioctl: allow idmapped BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} ioctl
>    btrfs/ioctl: allow idmapped BTRFS_IOC_SUBVOL_SETFLAGS ioctl
>    btrfs/ioctl: allow idmapped BTRFS_IOC_INO_LOOKUP_USER ioctl
>    btrfs/acl: handle idmapped mounts
>    btrfs/super: allow idmapped btrfs
>
>   arch/s390/hypfs/inode.c            |  2 +-
>   drivers/android/binderfs.c         |  4 +-
>   drivers/infiniband/hw/qib/qib_fs.c |  5 +-
>   fs/afs/dir.c                       |  2 +-
>   fs/afs/dir_silly.c                 |  2 +-
>   fs/afs/dynroot.c                   |  6 +-
>   fs/binfmt_misc.c                   |  2 +-
>   fs/btrfs/acl.c                     | 13 +++--
>   fs/btrfs/ctree.h                   |  3 +-
>   fs/btrfs/inode.c                   | 62 +++++++++++---------
>   fs/btrfs/ioctl.c                   | 94 ++++++++++++++++++++----------
>   fs/btrfs/super.c                   |  2 +-
>   fs/cachefiles/namei.c              |  9 +--
>   fs/cifs/cifsfs.c                   |  3 +-
>   fs/debugfs/inode.c                 |  9 ++-
>   fs/ecryptfs/inode.c                |  3 +-
>   fs/exportfs/expfs.c                |  6 +-
>   fs/kernfs/mount.c                  |  4 +-
>   fs/namei.c                         | 32 ++++++----
>   fs/nfs/unlink.c                    |  3 +-
>   fs/nfsd/nfs3xdr.c                  |  3 +-
>   fs/nfsd/nfs4recover.c              |  7 ++-
>   fs/nfsd/nfs4xdr.c                  |  3 +-
>   fs/nfsd/nfsproc.c                  |  3 +-
>   fs/nfsd/vfs.c                      | 19 +++---
>   fs/overlayfs/copy_up.c             | 10 ++--
>   fs/overlayfs/dir.c                 | 23 ++++----
>   fs/overlayfs/export.c              |  3 +-
>   fs/overlayfs/namei.c               | 13 +++--
>   fs/overlayfs/readdir.c             | 12 ++--
>   fs/overlayfs/super.c               |  8 ++-
>   fs/overlayfs/util.c                |  2 +-
>   fs/quota/dquot.c                   |  3 +-
>   fs/reiserfs/xattr.c                | 14 ++---
>   fs/tracefs/inode.c                 |  3 +-
>   include/linux/namei.h              | 12 ++--
>   ipc/mqueue.c                       |  5 +-
>   kernel/bpf/inode.c                 |  2 +-
>   security/apparmor/apparmorfs.c     |  5 +-
>   security/inode.c                   |  2 +-
>   40 files changed, 250 insertions(+), 168 deletions(-)
>
>
> base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
>
