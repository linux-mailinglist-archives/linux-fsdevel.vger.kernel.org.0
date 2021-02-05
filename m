Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C797B3112C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 21:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhBETDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 14:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhBETBi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 14:01:38 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1763EC06174A;
        Fri,  5 Feb 2021 12:43:22 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id q23so4327819vsg.4;
        Fri, 05 Feb 2021 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zQsbQqU8v0J69kx7VlEEqc5CnlMmAXtv+kLMdo4DMoU=;
        b=Q0NVz7Xg5ztNqEVp7o9ftQwRfhvHnLTnFQD2pcyaDROqmuH0UMeRXtAqhD/vXy9SZZ
         XRkhMdIVJdFOa4FQ8brbYEiwGGHTfqeBiplecxKW6Od3zOJpV1Jk2k7xAEbG+q0biz/2
         Yt3h1jxTQg/nStuYfLu6NL6iY0uJ161veM5hLLMa6SK+HdnPbig9pqW17qPqNXl6OW3P
         KssDnJLanYqODyih11lUBShgXPlUoLe5OfQNyQZJiFCIy6lqKo/FtNIZT/olQyjrgoOS
         LshggAoI+w6Z2yiZmb4l1SCzX9kT2JUXtn+IKNR0d0IoG9uTLyLgT5KF+IGHY03WT37x
         z2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=zQsbQqU8v0J69kx7VlEEqc5CnlMmAXtv+kLMdo4DMoU=;
        b=MHdtNGjt1tla1/kluQEX1t9v9ohRCgEKW9L6Az6A0a9yzTkMjlKmN0YSpR24uaQWZ5
         J4JoODnOERkSfDU4qYJgyB+vLn07G9Q+zzz6ksa8+x6KeRiURTkms9U/8kZ2RsB+WwNW
         NW8dO23zyj2mG37yL1+O2bxhIjbZoTmFDbvAyukzofyRUAXhIl7hlDtYW6xsmx+UyIQB
         WXTp3t2jY5oVqBzxYwV4GZalQjPJkqLkg5LhivTCQx+zZpHipMKkWb5jx0CERIV5nR62
         6EiKUbmDGYPuj5uL7ImZuUNrnCEVdDIBreFVhFIrsyismv94ZSGe7/A9FemgZ9V/442S
         Gxew==
X-Gm-Message-State: AOAM532MvFZlzJs+bg3WCD3m6HFiHo/NJZxeMuqHJJQ79pmWbvdgNqkr
        739AjB97NwBSvL2id1mGHg8VqeDD2Qtt4VfXd34=
X-Google-Smtp-Source: ABdhPJxzP//EYDjw/9Gh7AShXIhMpCAZ8yFBWw3P1vtlwldQazlLxBNC9orqn4mv5zFF9oH5UoizNzSVMMuhvth2qY4=
X-Received: by 2002:a67:c29e:: with SMTP id k30mr4509314vsj.45.1612557801344;
 Fri, 05 Feb 2021 12:43:21 -0800 (PST)
MIME-Version: 1.0
From:   Hanabishi Recca <irecca.kun@gmail.com>
Date:   Sat, 6 Feb 2021 01:43:10 +0500
Message-ID: <CAOehnrO-qjA4-YbqjyQCc27SyE_T2_bPRfWNg=jb8_tTetRUkw@mail.gmail.com>
Subject: Re: [PATCH v20 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
To:     almaz.alexandrovich@paragon-software.com
Cc:     aaptel@suse.com, andy.lavr@gmail.com, anton@tuxera.com,
        dan.carpenter@oracle.com, dsterba@suse.cz, ebiggers@kernel.org,
        hch@lst.de, joe@perches.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        mark@harmstone.com, nborisov@suse.com, pali@kernel.org,
        rdunlap@infradead.org, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can't even build v20 due to compilation errors.

DKMS make.log for ntfs3-20.0.0 for kernel 5.10.13-arch1-1 (x86_64)
Sat Feb  6 01:20:00 +05 2021
make -C /lib/modules/5.10.13-arch1-1/build
M=3D/var/lib/dkms/ntfs3/20.0.0/build modules
make[1]: Entering directory '/usr/lib/modules/5.10.13-arch1-1/build'
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/attrib.o
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/attrlist.o
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/bitfunc.o
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/bitmap.o
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/dir.o
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/fsntfs.o
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/frecord.o
  CC [M]  /var/lib/dkms/ntfs3/20.0.0/build/file.o
/var/lib/dkms/ntfs3/20.0.0/build/file.c: In function =E2=80=98ntfs_getattr=
=E2=80=99:
/var/lib/dkms/ntfs3/20.0.0/build/file.c:93:19: error: passing argument
1 of =E2=80=98generic_fillattr=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   93 |  generic_fillattr(mnt_userns, inode, stat);
      |                   ^~~~~~~~~~
      |                   |
      |                   struct user_namespace *
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3095:30: note: expected =E2=80=98struct inode *=E2=80=
=99 but
argument is of type =E2=80=98struct user_namespace *=E2=80=99
 3095 | extern void generic_fillattr(struct inode *, struct kstat *);
      |                              ^~~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:93:31: error: passing argument
2 of =E2=80=98generic_fillattr=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
   93 |  generic_fillattr(mnt_userns, inode, stat);
      |                               ^~~~~
      |                               |
      |                               struct inode *
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3095:46: note: expected =E2=80=98struct kstat *=E2=80=
=99 but
argument is of type =E2=80=98struct inode *=E2=80=99
 3095 | extern void generic_fillattr(struct inode *, struct kstat *);
      |                                              ^~~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:93:2: error: too many
arguments to function =E2=80=98generic_fillattr=E2=80=99
   93 |  generic_fillattr(mnt_userns, inode, stat);
      |  ^~~~~~~~~~~~~~~~
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3095:13: note: declared here
 3095 | extern void generic_fillattr(struct inode *, struct kstat *);
      |             ^~~~~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c: In function =E2=80=98ntfs3_setattr=
=E2=80=99:
/var/lib/dkms/ntfs3/20.0.0/build/file.c:639:24: error: passing
argument 1 of =E2=80=98setattr_prepare=E2=80=99 from incompatible pointer t=
ype
[-Werror=3Dincompatible-pointer-types]
  639 |  err =3D setattr_prepare(mnt_userns, dentry, attr);
      |                        ^~~~~~~~~~
      |                        |
      |                        struct user_namespace *
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3217:28: note: expected =E2=80=98struct dentry *=E2=80=
=99 but
argument is of type =E2=80=98struct user_namespace *=E2=80=99
 3217 | extern int setattr_prepare(struct dentry *, struct iattr *);
      |                            ^~~~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:639:36: error: passing
argument 2 of =E2=80=98setattr_prepare=E2=80=99 from incompatible pointer t=
ype
[-Werror=3Dincompatible-pointer-types]
  639 |  err =3D setattr_prepare(mnt_userns, dentry, attr);
      |                                    ^~~~~~
      |                                    |
      |                                    struct dentry *
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3217:45: note: expected =E2=80=98struct iattr *=E2=80=
=99 but
argument is of type =E2=80=98struct dentry *=E2=80=99
 3217 | extern int setattr_prepare(struct dentry *, struct iattr *);
      |                                             ^~~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:639:8: error: too many
arguments to function =E2=80=98setattr_prepare=E2=80=99
  639 |  err =3D setattr_prepare(mnt_userns, dentry, attr);
      |        ^~~~~~~~~~~~~~~
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3217:12: note: declared here
 3217 | extern int setattr_prepare(struct dentry *, struct iattr *);
      |            ^~~~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:664:15: error: passing
argument 1 of =E2=80=98setattr_copy=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  664 |  setattr_copy(mnt_userns, inode, attr);
      |               ^~~~~~~~~~
      |               |
      |               struct user_namespace *
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3219:40: note: expected =E2=80=98struct inode *=E2=80=
=99 but
argument is of type =E2=80=98struct user_namespace *=E2=80=99
 3219 | extern void setattr_copy(struct inode *inode, const struct iattr *a=
ttr);
      |                          ~~~~~~~~~~~~~~^~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:664:27: error: passing
argument 2 of =E2=80=98setattr_copy=E2=80=99 from incompatible pointer type
[-Werror=3Dincompatible-pointer-types]
  664 |  setattr_copy(mnt_userns, inode, attr);
      |                           ^~~~~
      |                           |
      |                           struct inode *
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3219:67: note: expected =E2=80=98const struct iattr *=
=E2=80=99
but argument is of type =E2=80=98struct inode *=E2=80=99
 3219 | extern void setattr_copy(struct inode *inode, const struct iattr *a=
ttr);
      |                                               ~~~~~~~~~~~~~~~~~~~~^=
~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:664:2: error: too many
arguments to function =E2=80=98setattr_copy=E2=80=99
  664 |  setattr_copy(mnt_userns, inode, attr);
      |  ^~~~~~~~~~~~
In file included from ./include/linux/backing-dev.h:13,
                 from /var/lib/dkms/ntfs3/20.0.0/build/file.c:8:
./include/linux/fs.h:3219:13: note: declared here
 3219 | extern void setattr_copy(struct inode *inode, const struct iattr *a=
ttr);
      |             ^~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c: At top level:
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1109:13: error: initialization
of =E2=80=98int (*)(const struct path *, struct kstat *, u32,  unsigned int=
)=E2=80=99
{aka =E2=80=98int (*)(const struct path *, struct kstat *, unsigned int,
unsigned int)=E2=80=99} from incompatible pointer type =E2=80=98int (*)(str=
uct
user_namespace *, const struct path *, struct kstat *, u32,  u32)=E2=80=99
{aka =E2=80=98int (*)(struct user_namespace *, const struct path *, struct
kstat *, unsigned int,  unsigned int)=E2=80=99}
[-Werror=3Dincompatible-pointer-types]
 1109 |  .getattr =3D ntfs_getattr,
      |             ^~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1109:13: note: (near
initialization for =E2=80=98ntfs_file_inode_operations.getattr=E2=80=99)
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1110:13: error: initialization
of =E2=80=98int (*)(struct dentry *, struct iattr *)=E2=80=99 from incompat=
ible
pointer type =E2=80=98int (*)(struct user_namespace *, struct dentry *, str=
uct
iattr *)=E2=80=99 [-Werror=3Dincompatible-pointer-types]
 1110 |  .setattr =3D ntfs3_setattr,
      |             ^~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1110:13: note: (near
initialization for =E2=80=98ntfs_file_inode_operations.setattr=E2=80=99)
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1112:16: error: initialization
of =E2=80=98int (*)(struct inode *, int)=E2=80=99 from incompatible pointer=
 type =E2=80=98int
(*)(struct user_namespace *, struct inode *, int)=E2=80=99
[-Werror=3Dincompatible-pointer-types]
 1112 |  .permission =3D ntfs_permission,
      |                ^~~~~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1112:16: note: (near
initialization for =E2=80=98ntfs_file_inode_operations.permission=E2=80=99)
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1114:13: error: initialization
of =E2=80=98int (*)(struct inode *, struct posix_acl *, int)=E2=80=99 from
incompatible pointer type =E2=80=98int (*)(struct user_namespace *, struct
inode *, struct posix_acl *, int)=E2=80=99
[-Werror=3Dincompatible-pointer-types]
 1114 |  .set_acl =3D ntfs_set_acl,
      |             ^~~~~~~~~~~~
/var/lib/dkms/ntfs3/20.0.0/build/file.c:1114:13: note: (near
initialization for =E2=80=98ntfs_file_inode_operations.set_acl=E2=80=99)
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:279:
/var/lib/dkms/ntfs3/20.0.0/build/file.o] Error 1
make[1]: *** [Makefile:1805: /var/lib/dkms/ntfs3/20.0.0/build] Error 2
make[1]: Leaving directory '/usr/lib/modules/5.10.13-arch1-1/build'
make: *** [Makefile:37: all] Error 2
