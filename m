Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140F423415F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 10:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgGaIlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 04:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730233AbgGaIlZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:41:25 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A3C061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 01:41:24 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s20so15362697vsq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2020 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y63oAJuw+Me3PZc6ce5WsDrbSV4mt+J1F7499sphZYM=;
        b=VhXTI/wkMh6FSf+lij/Wc0W8VW9FEWZAk9akoxgJRV3UCXTvH0vgvfFOXO6OuUIODQ
         ovABBlVaLIIbZ7I/2I0gZKLwRk0aWHyhn4uPzTeLLYrX8rsd6sVLZ8z7ztT1DVf6dy8j
         H7t2RC4o2LMBrCaElZpZqKwUjIaZ7Gbdqi/0UkQMhOYDCTmq6lXcPoCB/J/Xsz2deIeu
         fLWOOKHUltesrhyqvGAoEcxgWmLP0FVN2bVs27vgbo6em7ooU8GofSdvOLJ0/b1sM2VN
         CEx9g8cLbU+XWL7U2bHXkNKSXUHG0wi5U9lj0OBBUGPFQ4+OurahPGpcxq7SUz1mW4HT
         6bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y63oAJuw+Me3PZc6ce5WsDrbSV4mt+J1F7499sphZYM=;
        b=BW0oPKY95FOVLbTnMqau82WE3lNdVPZALuL+4wfwUnHhV4MbvTFwaPgTdjndkE6Ujd
         JQgP2BZXQHduXYSkbDn8ph21q1Ik/mfnAwEpfw0Bi7CDmf4yru2BY+rXstEeH1xf7zGq
         WMclklNiN92iIw9ne+cEN8reeujP7ze7888kC/FtSsEPwcGEvZy6ZqkHYHZ+sLWXyG/m
         KNwWAwnuzp3+0xOJ49mSBFpVeZInfVMv755nTk7tjy9mfAFn+MxQNZ1cJcYXbFNHXGt7
         1wKGizDytYr/f2C7Ayr2UeNfbBonFgXvSlbzZsS/x834j7O0+WvqVJfJu+0Sa8jnjuLv
         KF8w==
X-Gm-Message-State: AOAM5322DZbdrssDexqtb/VwxUZfMQy3pT//R8niz7CSt7Q/VsgalhWQ
        j3ArKNoUVYb0dYjw1PSa53d4jYbvsh/2h47TO0KNmw==
X-Google-Smtp-Source: ABdhPJyMv/+GMEvEskdPMp4oeXoWW0VaZBNK6A0V7CnAuElnA7ojDXe0TGgKMVchrDxSKyCk0pP5oMjr37TXEGLJ5FU=
X-Received: by 2002:a67:e412:: with SMTP id d18mr2316019vsf.41.1596184883711;
 Fri, 31 Jul 2020 01:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200726160401.311569-1-hch@lst.de> <20200726160401.311569-2-hch@lst.de>
 <20200730173437.GA1172439@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200730173437.GA1172439@ubuntu-n2-xlarge-x86>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jul 2020 14:11:11 +0530
Message-ID: <CA+G9fYs0ZJCp39qh2Zs6v=Pb6S=1PYDEA1+Dk7Q8=RL45_P7NQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: stop using <asm/compat.h> directly
To:     Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     X86 ML <x86@kernel.org>, Jan Kara <jack@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        lkft-triage@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 30 Jul 2020 at 23:04, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Sun, Jul 26, 2020 at 06:03:58PM +0200, Christoph Hellwig wrote:
> > Always use <linux/compat.h> so that we can move more declarations to
> > common code.  In two of the three cases the asm include was in addition
> > to an existing one for <linux/compat.h> anyway.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/arm64/include/asm/stat.h | 2 +-
> >  arch/arm64/kernel/process.c   | 1 -
> >  arch/arm64/kernel/ptrace.c    | 1 -
> >  3 files changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/sta=
t.h
> > index 3b4a62f5aeb0c3..1b5ac1ef5d04cc 100644
> > --- a/arch/arm64/include/asm/stat.h
> > +++ b/arch/arm64/include/asm/stat.h
> > @@ -10,7 +10,7 @@
> >  #ifdef CONFIG_COMPAT
> >
> >  #include <linux/time.h>
> > -#include <asm/compat.h>
> > +#include <linux/compat.h>
>
> This breaks arm64 defconfig:
>
> $ make -skj"$(nproc)" ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux- distcle=
an defconfig init/main.o
> In file included from ./include/linux/compat.h:17,
>                  from ./arch/arm64/include/asm/stat.h:13,
>                  from ./include/linux/stat.h:6,
>                  from ./include/linux/sysfs.h:22,
>                  from ./include/linux/kobject.h:20,
>                  from ./include/linux/of.h:17,
>                  from ./include/linux/irqdomain.h:35,
>                  from ./include/linux/acpi.h:13,
>                  from ./include/acpi/apei.h:9,
>                  from ./include/acpi/ghes.h:5,
>                  from ./include/linux/arm_sdei.h:8,
>                  from arch/arm64/kernel/asm-offsets.c:10:
> ./include/linux/fs.h: In function 'vfs_whiteout':
> ./include/linux/fs.h:1736:32: error: 'S_IFCHR' undeclared (first use in t=
his function)
>  1736 |  return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_=
DEV);
>       |                                ^~~~~~~
> ./include/linux/fs.h:1736:32: note: each undeclared identifier is reporte=
d only once for each function it appears in
> ./include/linux/fs.h: At top level:
> ./include/linux/fs.h:1886:46: warning: 'struct kstat' declared inside par=
ameter list will not be visible outside of this definition or declaration
>  1886 |  int (*getattr) (const struct path *, struct kstat *, u32, unsign=
ed int);
>       |                                              ^~~~~
> ./include/linux/fs.h: In function '__mandatory_lock':
> ./include/linux/fs.h:2372:25: error: 'S_ISGID' undeclared (first use in t=
his function); did you mean 'SIGIO'?
>  2372 |  return (ino->i_mode & (S_ISGID | S_IXGRP)) =3D=3D S_ISGID;
>       |                         ^~~~~~~
>       |                         SIGIO
> ./include/linux/fs.h:2372:35: error: 'S_IXGRP' undeclared (first use in t=
his function)
>  2372 |  return (ino->i_mode & (S_ISGID | S_IXGRP)) =3D=3D S_ISGID;
>       |                                   ^~~~~~~
> ...
>
> $ git bisect log
> # bad: [7b287a5c6ac518c415a258f2aa7b1ebb25c263d2] Add linux-next specific=
 files for 20200730
> # good: [d3590ebf6f91350192737dd1d1b219c05277f067] Merge tag 'audit-pr-20=
200729' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
> git bisect start '7b287a5c6ac518c415a258f2aa7b1ebb25c263d2' 'd3590ebf6f91=
350192737dd1d1b219c05277f067'
> # bad: [1f1ed12be70e9eb4e05ac206c6ad6a5a31f5b921] Merge remote-tracking b=
ranch 'crypto/master'
> git bisect bad 1f1ed12be70e9eb4e05ac206c6ad6a5a31f5b921
> # bad: [07fad673c2f1a02440c879c34f8182b12786a735] Merge remote-tracking b=
ranch 'hid/for-next'
> git bisect bad 07fad673c2f1a02440c879c34f8182b12786a735
> # good: [7a77c92312546a74d3507484b256ae17bfb2cfe2] Merge remote-tracking =
branch 'm68knommu/for-next'
> git bisect good 7a77c92312546a74d3507484b256ae17bfb2cfe2
> # good: [40dd62f180e38317e744d7f82c98af31a24fd2c9] Merge remote-tracking =
branch 'f2fs/dev'
> git bisect good 40dd62f180e38317e744d7f82c98af31a24fd2c9
> # bad: [52138dfdd2192bcfc7d3bc2e79475966ee4b20c4] Merge remote-tracking b=
ranch 'printk/for-next'
> git bisect bad 52138dfdd2192bcfc7d3bc2e79475966ee4b20c4
> # good: [a37c3e37fa3fa1381e03d918d708f82927ddd160] Merge remote-tracking =
branch 'xfs/for-next'
> git bisect good a37c3e37fa3fa1381e03d918d708f82927ddd160
> # good: [4e523547e2bf755d40cb10e85795c2f9620ff3fb] nvme-pci: add a blank =
line after declarations
> git bisect good 4e523547e2bf755d40cb10e85795c2f9620ff3fb
> # bad: [5066741180729f7bad9401de34efda3766c3274a] Merge branches 'fixes' =
and 'work.quota-compat' into for-next
> git bisect bad 5066741180729f7bad9401de34efda3766c3274a
> # good: [4ff8a356daafaafbf90141ee7a3b8fdc18e560a8] ia64: switch to ->regs=
et_get()
> git bisect good 4ff8a356daafaafbf90141ee7a3b8fdc18e560a8
> # good: [ce327e1c54119179066d6f3573a28001febc9265] regset: kill user_regs=
et_copyout{,_zero}()
> git bisect good ce327e1c54119179066d6f3573a28001febc9265
> # good: [1697a322e28ba96d35953c5d824540d172546d36] [elf-fdpic] switch cor=
edump to regsets
> git bisect good 1697a322e28ba96d35953c5d824540d172546d36
> # good: [259bf01c1bd1f049958496a089c4f334fe0c8a48] Merge branches 'work.m=
isc', 'work.regset' and 'work.fdpic' into for-next
> git bisect good 259bf01c1bd1f049958496a089c4f334fe0c8a48
> # bad: [0a3a4497a1de8e68e809a693b549c7ec2f195301] compat: lift compat_s64=
 and compat_u64 to <linux/compat.h>
> git bisect bad 0a3a4497a1de8e68e809a693b549c7ec2f195301
> # bad: [b902bfb3f0e9d07ec9f48256e57e5c5de6108f8c] arm64: stop using <asm/=
compat.h> directly
> git bisect bad b902bfb3f0e9d07ec9f48256e57e5c5de6108f8c
> # first bad commit: [b902bfb3f0e9d07ec9f48256e57e5c5de6108f8c] arm64: sto=
p using <asm/compat.h> directly
>
> I assume the stat header order should be messed around with but I am not
> sure what exactly that would entail to make sure that nothing else
> breaks, hence just the report.

FYI,
We have also noticed this arm64 build break on linux next 20200730
with gcc-8.x, gcc-9.x and gcc-10.x

make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild Image
#
In file included from ../include/linux/compat.h:17,
                 from ../arch/arm64/include/asm/stat.h:13,
                 from ../include/linux/stat.h:6,
                 from ../include/linux/sysfs.h:22,
                 from ../include/linux/kobject.h:20,
                 from ../include/linux/of.h:17,
                 from ../include/linux/irqdomain.h:35,
                 from ../include/linux/acpi.h:13,
                 from ../include/acpi/apei.h:9,
                 from ../include/acpi/ghes.h:5,
                 from ../include/linux/arm_sdei.h:8,
                 from ../arch/arm64/kernel/asm-offsets.c:10:
../include/linux/fs.h: In function =E2=80=98vfs_whiteout=E2=80=99:
../include/linux/fs.h:1709:32: error: =E2=80=98S_IFCHR=E2=80=99 undeclared =
(first use
in this function)
 1709 |  return vfs_mknod(dir, dentry, S_IFCHR | WHITEOUT_MODE, WHITEOUT_DE=
V);
      |                                ^~~~~~~
../include/linux/fs.h:1709:32: note: each undeclared identifier is
reported only once for each function it appears in
../include/linux/fs.h: At top level:
../include/linux/fs.h:1855:46: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 1855 |  int (*getattr) (const struct path *, struct kstat *, u32,
unsigned int);
      |                                              ^~~~~
../include/linux/fs.h: In function =E2=80=98__mandatory_lock=E2=80=99:
../include/linux/fs.h:2325:25: error: =E2=80=98S_ISGID=E2=80=99 undeclared =
(first use
in this function); did you mean =E2=80=98SIGIO=E2=80=99?
 2325 |  return (ino->i_mode & (S_ISGID | S_IXGRP)) =3D=3D S_ISGID;
      |                         ^~~~~~~
      |                         SIGIO
../include/linux/fs.h:2325:35: error: =E2=80=98S_IXGRP=E2=80=99 undeclared =
(first use
in this function)
 2325 |  return (ino->i_mode & (S_ISGID | S_IXGRP)) =3D=3D S_ISGID;
      |                                   ^~~~~~~
../include/linux/fs.h: In function =E2=80=98invalidate_remote_inode=E2=80=
=99:
../include/linux/fs.h:2588:6: error: implicit declaration of function
=E2=80=98S_ISREG=E2=80=99 [-Werror=3Dimplicit-function-declaration]
 2588 |  if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
      |      ^~~~~~~
../include/linux/fs.h:2588:32: error: implicit declaration of function
=E2=80=98S_ISDIR=E2=80=99; did you mean =E2=80=98EISDIR=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
 2588 |  if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
      |                                ^~~~~~~
      |                                EISDIR
../include/linux/fs.h:2589:6: error: implicit declaration of function
=E2=80=98S_ISLNK=E2=80=99 [-Werror=3Dimplicit-function-declaration]
 2589 |      S_ISLNK(inode->i_mode))
      |      ^~~~~~~
../include/linux/fs.h: In function =E2=80=98execute_ok=E2=80=99:
../include/linux/fs.h:2768:26: error: =E2=80=98S_IXUGO=E2=80=99 undeclared =
(first use
in this function)
 2768 |  return (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode);
      |                          ^~~~~~~
In file included from ../include/linux/compat.h:17,
                 from ../arch/arm64/include/asm/stat.h:13,
                 from ../include/linux/stat.h:6,
                 from ../include/linux/sysfs.h:22,
                 from ../include/linux/kobject.h:20,
                 from ../include/linux/of.h:17,
                 from ../include/linux/irqdomain.h:35,
                 from ../include/linux/acpi.h:13,
                 from ../include/acpi/apei.h:9,
                 from ../include/acpi/ghes.h:5,
                 from ../include/linux/arm_sdei.h:8,
                 from ../arch/arm64/kernel/asm-offsets.c:10:
../include/linux/fs.h: At top level:
../include/linux/fs.h:3141:53: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3141 | extern void generic_fillattr(struct inode *, struct kstat *);
      |                                                     ^~~~~
../include/linux/fs.h:3142:58: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3142 | extern int vfs_getattr_nosec(const struct path *, struct kstat
*, u32, unsigned int);
      |                                                          ^~~~~
../include/linux/fs.h:3143:52: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3143 | extern int vfs_getattr(const struct path *, struct kstat *,
u32, unsigned int);
      |                                                    ^~~~~
../include/linux/fs.h:3160:60: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3160 | extern int vfs_statx(int, const char __user *, int, struct
kstat *, u32);
      |                                                            ^~~~~
../include/linux/fs.h:3161:46: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3161 | extern int vfs_statx_fd(unsigned int, struct kstat *, u32,
unsigned int);
      |                                              ^~~~~
../include/linux/fs.h:3163:64: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3163 | static inline int vfs_stat(const char __user *filename, struct
kstat *stat)
      |                                                                ^~~~=
~
../include/linux/fs.h: In function =E2=80=98vfs_stat=E2=80=99:
../include/linux/fs.h:3166:11: error: =E2=80=98STATX_BASIC_STATS=E2=80=99 u=
ndeclared
(first use in this function)
 3166 |     stat, STATX_BASIC_STATS);
      |           ^~~~~~~~~~~~~~~~~
../include/linux/fs.h:3166:5: error: passing argument 4 of =E2=80=98vfs_sta=
tx=E2=80=99
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
 3166 |     stat, STATX_BASIC_STATS);
      |     ^~~~
      |     |
      |     struct kstat *
../include/linux/fs.h:3160:53: note: expected =E2=80=98struct kstat *=E2=80=
=99 but
argument is of type =E2=80=98struct kstat *=E2=80=99
 3160 | extern int vfs_statx(int, const char __user *, int, struct
kstat *, u32);
      |                                                     ^~~~~~~~~~~~~~
../include/linux/fs.h: At top level:
../include/linux/fs.h:3168:61: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3168 | static inline int vfs_lstat(const char __user *name, struct kstat *=
stat)
      |                                                             ^~~~~
../include/linux/fs.h: In function =E2=80=98vfs_lstat=E2=80=99:
../include/linux/fs.h:3171:11: error: =E2=80=98STATX_BASIC_STATS=E2=80=99 u=
ndeclared
(first use in this function)
 3171 |     stat, STATX_BASIC_STATS);
      |           ^~~~~~~~~~~~~~~~~
../include/linux/fs.h:3171:5: error: passing argument 4 of =E2=80=98vfs_sta=
tx=E2=80=99
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
 3171 |     stat, STATX_BASIC_STATS);
      |     ^~~~
      |     |
      |     struct kstat *
../include/linux/fs.h:3160:53: note: expected =E2=80=98struct kstat *=E2=80=
=99 but
argument is of type =E2=80=98struct kstat *=E2=80=99
 3160 | extern int vfs_statx(int, const char __user *, int, struct
kstat *, u32);
      |                                                     ^~~~~~~~~~~~~~
../include/linux/fs.h: At top level:
../include/linux/fs.h:3174:17: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3174 |          struct kstat *stat, int flags)
      |                 ^~~~~
../include/linux/fs.h: In function =E2=80=98vfs_fstatat=E2=80=99:
../include/linux/fs.h:3177:11: error: =E2=80=98STATX_BASIC_STATS=E2=80=99 u=
ndeclared
(first use in this function)
 3177 |     stat, STATX_BASIC_STATS);
      |           ^~~~~~~~~~~~~~~~~
../include/linux/fs.h:3177:5: error: passing argument 4 of =E2=80=98vfs_sta=
tx=E2=80=99
from incompatible pointer type [-Werror=3Dincompatible-pointer-types]
 3177 |     stat, STATX_BASIC_STATS);
      |     ^~~~
      |     |
      |     struct kstat *
../include/linux/fs.h:3160:53: note: expected =E2=80=98struct kstat *=E2=80=
=99 but
argument is of type =E2=80=98struct kstat *=E2=80=99
 3160 | extern int vfs_statx(int, const char __user *, int, struct
kstat *, u32);
      |                                                     ^~~~~~~~~~~~~~
../include/linux/fs.h: At top level:
../include/linux/fs.h:3179:44: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3179 | static inline int vfs_fstat(int fd, struct kstat *stat)
      |                                            ^~~~~
../include/linux/fs.h: In function =E2=80=98vfs_fstat=E2=80=99:
../include/linux/fs.h:3181:32: error: =E2=80=98STATX_BASIC_STATS=E2=80=99 u=
ndeclared
(first use in this function)
 3181 |  return vfs_statx_fd(fd, stat, STATX_BASIC_STATS, 0);
      |                                ^~~~~~~~~~~~~~~~~
../include/linux/fs.h:3181:26: error: passing argument 2 of
=E2=80=98vfs_statx_fd=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
 3181 |  return vfs_statx_fd(fd, stat, STATX_BASIC_STATS, 0);
      |                          ^~~~
      |                          |
      |                          struct kstat *
../include/linux/fs.h:3161:39: note: expected =E2=80=98struct kstat *=E2=80=
=99 but
argument is of type =E2=80=98struct kstat *=E2=80=99
 3161 | extern int vfs_statx_fd(unsigned int, struct kstat *, u32,
unsigned int);
      |                                       ^~~~~~~~~~~~~~
../include/linux/fs.h: At top level:
../include/linux/fs.h:3206:55: warning: =E2=80=98struct kstat=E2=80=99 decl=
ared inside
parameter list will not be visible outside of this definition or
declaration
 3206 | extern int simple_getattr(const struct path *, struct kstat *,
u32, unsigned int);
      |                                                       ^~~~~
../include/linux/fs.h: In function =E2=80=98vma_is_fsdax=E2=80=99:
../include/linux/fs.h:3289:6: error: implicit declaration of function
=E2=80=98S_ISCHR=E2=80=99 [-Werror=3Dimplicit-function-declaration]
 3289 |  if (S_ISCHR(inode->i_mode))
      |      ^~~~~~~
../include/linux/fs.h: In function =E2=80=98is_sxid=E2=80=99:
../include/linux/fs.h:3428:17: error: =E2=80=98S_ISUID=E2=80=99 undeclared =
(first use
in this function)
 3428 |  return (mode & S_ISUID) || ((mode & S_ISGID) && (mode & S_IXGRP));
      |                 ^~~~~~~
../include/linux/fs.h:3428:38: error: =E2=80=98S_ISGID=E2=80=99 undeclared =
(first use
in this function); did you mean =E2=80=98SIGIO=E2=80=99?
 3428 |  return (mode & S_ISUID) || ((mode & S_ISGID) && (mode & S_IXGRP));
      |                                      ^~~~~~~
      |                                      SIGIO
../include/linux/fs.h:3428:58: error: =E2=80=98S_IXGRP=E2=80=99 undeclared =
(first use
in this function)
 3428 |  return (mode & S_ISUID) || ((mode & S_ISGID) && (mode & S_IXGRP));
      |                                                          ^~~~~~~
../include/linux/fs.h: In function =E2=80=98check_sticky=E2=80=99:
../include/linux/fs.h:3433:22: error: =E2=80=98S_ISVTX=E2=80=99 undeclared =
(first use
in this function)
 3433 |  if (!(dir->i_mode & S_ISVTX))
      |                      ^~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [../scripts/Makefile.build:114:
arch/arm64/kernel/asm-offsets.s] Error 1


kernel config:
https://builds.tuxbuild.com/BsPWKexQQ3JXC2WwDQSoQg/kernel.config

- Naresh
>
> Cheers,
> Nathan
