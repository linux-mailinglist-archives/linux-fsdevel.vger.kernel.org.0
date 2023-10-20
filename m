Return-Path: <linux-fsdevel+bounces-810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 401577D09B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 09:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54B1B2150D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 07:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562B4DDB5;
	Fri, 20 Oct 2023 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQGfBWS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E62D527
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 07:48:36 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C3FA
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 00:48:34 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b6d6773d05so209296241.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697788113; x=1698392913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nDIEXkqZFUlLOpAEMqVPYpiBtXq4rv4owUJbY06QSM0=;
        b=TQGfBWS0tupPnSYFx/N54t7iE64b8yLk6/UH/ABoZaxx9bQLpe13DN5RuhJ0hKQZoq
         OxFy36VEdtWpMWfWVWGHr2RUNdA5M3zoVv7lQzzDtnjWEgzofTMJwTPrVsaAcmPUsAzx
         DiWGWTIE47YO2zIUAjriO49ShdIDDtLTUdqNkMytymfOBSo6vDPLNRAbNN3REj8VbgzL
         kerU4y6FUK2U20+1TDzHjKCBOMlhpZjjz7P2i7a0ijBWDaqEqIa6PbbRw4sihYIYHpP4
         JbHIWCT2kvM51PJ/gN32G/Q949bb9mETK6sHK+MMYXSBkQtU8WgoxDkNghFUyqFmxhuZ
         vUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697788113; x=1698392913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDIEXkqZFUlLOpAEMqVPYpiBtXq4rv4owUJbY06QSM0=;
        b=c+Sm/2IZt9KjrnainsL7F61LoxxmVjVWabA0TrSqOs6V/1RAMtjsSbD352ZVzYKxXC
         iUTZRbiS822bb1A50oAPHJDSjehrEIBu4tDWDzLvLwMcE+K5pWhU7oLNaEHmmcn9ObvQ
         3vRC/Walh4oxEQSqu9XLnvhq187fmbhFEMkuG/nbdpRJ32gR0ob0dCZKjchMGjpMKRu+
         Pf7+xLa9siMQ68sQ49oxKYEqggoedNfMt+7fnmKOgzN4NF4GXVdJuRLvgnCzoBnB/fUd
         oTYpc2AJkZEpzAAsom3wDdaEZXZW1x5J0LqeeZRmtByMgvQyy4TnOuvtol5XCOj/OozN
         Dlog==
X-Gm-Message-State: AOJu0YyqDupnMjjkI5Y4fN2yXB9/NlPQg+H4TZD4ivql7q46VO/RJKNN
	wWdkbQGyx1v5jBtF2mbCBp1yWPAcFY8ZDV/KtRmULA==
X-Google-Smtp-Source: AGHT+IEikmoFCL9Nnt7/OsX/a+HpbHLx2qFjrSFbaYMzg4AT61OcSfYI7oXVYkQwYOz/C4LSTPxV2YIb0P3UAaDOnjY=
X-Received: by 2002:a67:e0c9:0:b0:457:a915:5e85 with SMTP id
 m9-20020a67e0c9000000b00457a9155e85mr1026591vsl.28.1697788113382; Fri, 20 Oct
 2023 00:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYt75r4i39DuB4E3y6jRLaLoSEHGbBcJy=AQZBQ2SmBbiQ@mail.gmail.com>
 <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
In-Reply-To: <71adfca4-4e80-4a93-b480-3031e26db409@app.fastmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 20 Oct 2023 13:18:22 +0530
Message-ID: <CA+G9fYtFqCX82L=oLvTpOQRWfz6CUKb79ybBncULkK2gK3aTrg@mail.gmail.com>
Subject: Re: autofs: add autofs_parse_fd()
To: Arnd Bergmann <arnd@arndb.de>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, "Bill O'Donnell" <bodonnel@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 12:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Oct 19, 2023, at 17:27, Naresh Kamboju wrote:
> > The qemu-x86_64 and x86_64 booting with 64bit kernel and 32bit rootfs we call
> > it as compat mode boot testing. Recently it started to failed to get login
> > prompt.
> >
> > We have not seen any kernel crash logs.
> >
> > Anders, bisection is pointing to first bad commit,
> > 546694b8f658 autofs: add autofs_parse_fd()
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
>
> I tried to find something in that commit that would be different
> in compat mode, but don't see anything at all -- this appears
> to be just a simple refactoring of the code, unlike the commits
> that immediately follow it and that do change the mount
> interface.
>
> Unfortunately this makes it impossible to just revert the commit
> on top of linux-next. Can you double-check your bisection by
> testing 546694b8f658 and the commit before it again?

I will try your suggested ways.

Is this information helpful ?
Linux-next the regression started happening from next-20230925.

GOOD: next-20230925
BAD: next-20230926

$ git log --oneline next-20230925..next-20230926 -- fs/autofs/
dede367149c4 autofs: fix protocol sub version setting
e6ec453bd0f0 autofs: convert autofs to use the new mount api
1f50012d9c63 autofs: validate protocol version
9b2731666d1d autofs: refactor parse_options()
7efd93ea790e autofs: reformat 0pt enum declaration
a7467430b4de autofs: refactor super block info init
546694b8f658 autofs: add autofs_parse_fd()
bc69fdde0ae1 autofs: refactor autofs_prepare_pipe()

> What are the exact mount options you pass to autofs in your fstab?

mount output shows like this,
systemd-1 on /proc/sys/fs/binfmt_misc type autofs
(rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=1421)

More information:
------------
+ mkdir -p /scratch
+ mount /dev/disk/by-id/ata-TOSHIBA_MG03ACA100_37O9KGL0F /scratch
[   38.217507] EXT4-fs (sda): mounted filesystem
13d24d11-02a0-4cc0-842e-d339637e2564 r/w with ordered data mode. Quota
mode: none.
+ echo mounted
mounted
+ df -h
Filesystem
       Size  Used Avail Use% Mounted on
10.66.16.116:/var/lib/lava/dispatcher/tmp/6951354/extract-nfsrootfs-fsw9ebbf
 559G   72G  487G  13% /
devtmpfs
       7.8G     0  7.8G   0% /dev
tmpfs
       7.8G     0  7.8G   0% /dev/shm
tmpfs
       3.2G  640K  3.2G   1% /run
tmpfs
       5.0M     0  5.0M   0% /run/lock
tmpfs
       1.6G     0  1.6G   0% /run/user/0
/dev/sda
       916G   28K  870G   1% /scratch
+ mount
10.66.16.116:/var/lib/lava/dispatcher/tmp/6951354/extract-nfsrootfs-fsw9ebbf
on / type nfs (rw,relatime,vers=3,rsize=4096,wsize=4096,namlen=255,hard,nolock,proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.66.16.116,mountvers=3,mountproto=tcp,local_lock=all,addr=10.66.16.116)
devtmpfs on /dev type devtmpfs
(rw,relatime,size=8165164k,nr_inodes=2041291,mode=755)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
selinuxfs on /sys/fs/selinux type selinuxfs (rw,nosuid,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
devpts on /dev/pts type devpts
(rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs
(rw,nosuid,nodev,size=3266844k,nr_inodes=819200,mode=755)
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)
cgroup2 on /sys/fs/cgroup type cgroup2
(rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs
(rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=1421)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
ramfs on /run/credentials/systemd-sysctl.service type ramfs
(ro,nosuid,nodev,noexec,relatime,mode=700)
ramfs on /run/credentials/systemd-sysusers.service type ramfs
(ro,nosuid,nodev,noexec,relatime,mode=700)
ramfs on /run/credentials/systemd-tmpfiles-setup-dev.service type
ramfs (ro,nosuid,nodev,noexec,relatime,mode=700)
ramfs on /run/credentials/systemd-tmpfiles-setup.service type ramfs
(ro,nosuid,nodev,noexec,relatime,mode=700)
binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc
(rw,nosuid,nodev,noexec,relatime)
tmpfs on /run/user/0 type tmpfs
(rw,nosuid,nodev,relatime,size=1633420k,nr_inodes=408355,mode=700)
/dev/sda on /scratch type ext4 (rw,relatime)


Here is the bisect log for your reference,

# bad: [e3b18f7200f45d66f7141136c25554ac1e82009b] Add linux-next
specific files for 20231013
# good: [d3b4075b173f033387b614297bb4d998cf22c8bd] drm/msm/dp: use
correct lifetime device for devm_drm_bridge_add
git bisect start 'next-20231013' 'd3b4075b173f033387b614297bb4d998cf22c8bd'
# bad: [9949a257fbbef4bf21f77649d4585b6ba0d0abae] Merge branch
'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect bad 9949a257fbbef4bf21f77649d4585b6ba0d0abae
# good: [39f9dc8a2d8e789ea31e343070a3b51c3f7ae3a2] Merge branch
'xtensa-for-next' of git://github.com/jcmvbkbc/linux-xtensa.git
git bisect good 39f9dc8a2d8e789ea31e343070a3b51c3f7ae3a2
# good: [4b32d7970b9865ad711a65094609a8c0ec9867a8] bcachefs: Change
journal_io.c assertion to error message
git bisect good 4b32d7970b9865ad711a65094609a8c0ec9867a8
# good: [79592709a731af69f33613490a7d88168fd52efb] bcachefs: Improve
key_visible_in_snapshot()
git bisect good 79592709a731af69f33613490a7d88168fd52efb
# good: [7ea2bcad6a0d5d15801abc318738d7eec3164d0a] Merge branch
'linux-next' of git://git.linux-nfs.org/projects/anna/linux-nfs.git
git bisect good 7ea2bcad6a0d5d15801abc318738d7eec3164d0a
# bad: [be636e0fa5fdb395366fd73a078e959d2587c476] Merge branch
'vfs.super' into vfs.all
git bisect bad be636e0fa5fdb395366fd73a078e959d2587c476
# good: [fea0e8fc7829dc85f82c8a1a8249630f6fb85553] fs: rename inode
i_atime and i_mtime fields
git bisect good fea0e8fc7829dc85f82c8a1a8249630f6fb85553
# bad: [18fa6d4d5ed5e6d219aeab9b92f602fa60020d95] Merge branch
'vfs.iov_iter' into vfs.all
git bisect bad 18fa6d4d5ed5e6d219aeab9b92f602fa60020d95
# good: [13f8510ba3215d2fb2ee7d1c64c0d51827ac28bd] ovl: rely on SB_I_NOUMASK
git bisect good 13f8510ba3215d2fb2ee7d1c64c0d51827ac28bd
# good: [b5f0e20f444cd150121e0ce912ebd3f2dabd12bc] iov_iter, net: Move
hash_and_copy_to_iter() to net/
git bisect good b5f0e20f444cd150121e0ce912ebd3f2dabd12bc
# bad: [1f50012d9c63c690f25956239bd25d10236405f8] autofs: validate
protocol version
git bisect bad 1f50012d9c63c690f25956239bd25d10236405f8
# bad: [a7467430b4de0985b7d1de8f1e50f8dd47eb6c4a] autofs: refactor
super block info init
git bisect bad a7467430b4de0985b7d1de8f1e50f8dd47eb6c4a
# bad: [546694b8f65807427a0104154abd8cdc633b36e3] autofs: add autofs_parse_fd()
git bisect bad 546694b8f65807427a0104154abd8cdc633b36e3
# good: [bc69fdde0ae1aff595590d802b6ef39114f2b260] autofs: refactor
autofs_prepare_pipe()
git bisect good bc69fdde0ae1aff595590d802b6ef39114f2b260
# first bad commit: [546694b8f65807427a0104154abd8cdc633b36e3] autofs:
add autofs_parse_fd()

- Naresh

