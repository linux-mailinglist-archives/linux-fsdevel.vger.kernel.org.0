Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF06BC84F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 09:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCPIKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 04:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCPIKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:10:14 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855D3D0A8;
        Thu, 16 Mar 2023 01:10:08 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id q42so609186uac.3;
        Thu, 16 Mar 2023 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678954207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVDF5XRq/NQbJJS8zoIciNchem66cRyUTGlxvz5pY8A=;
        b=YWhTOLol/AmrdX1MuYf91pmgi6IOPlV2bGb4zotTTbMsIHJhSG0NSGHgDBiQ7jlsrD
         Vp88SK08FS7maDiSxMDIx+w6JmVe+VQplCrWgV5itExQ5630Fkaad/7YhmRzE0GNpx5h
         8TD2qNcQO3aSICH8249ol9q85+H7rmJZIOh4RDzpr31qqkrAaxpKSHUoqpGbuQcuA9wI
         G0Dk8WNRQu49ffOnVfM6jCVOqg/dCoEqX71Jzrjm8BchDvPIeg5tLuIKDfiKLAs3dDXE
         wdnKGczR6IbCp8ya9wMCAf+G4mjS0Pnkannx6j0O57k3OrK+DttllT48KkwNotWniDiu
         amQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVDF5XRq/NQbJJS8zoIciNchem66cRyUTGlxvz5pY8A=;
        b=73NFNqtnvrv6mf/STfODJxeDRlO81w3E5UxDz3GcrNzgGBUVZyykhz5PJierWCF6qI
         QuwESoUsER3+q7ghAHYRpuoYVT7nVIr6FLvwTnrkpKPkLLXeFEQia3fBo+M9cLR1h+F4
         YEyCq+GWPwxqoEU1d17IG/q3/eSGKb/JFnHDIgz3OUB3AmKZ/tm2Bs+3ULCQChSt0eWW
         SoxPxjeTHnbdvjB56Sdk4m+R5xa7HKXRGaU6Ktj1MCiuMwqRpq+VlMyyAAd9KLq34+Hn
         U6oy6mZtkLbqdMWP4q/FozOeT+mQaiVsLSdElMjWMfteEckittIwCw+lzdVNbi14K8zk
         JUQA==
X-Gm-Message-State: AO0yUKUSB2kpgEwGic4zcLWbr6dMDPeHby+ux8ddisOwppIfr7ydVccr
        LcCcHW9LlfsvKjY1x6uBLp5MOYX02rpNiybmGVhF8JHz+BM=
X-Google-Smtp-Source: AK7set9NbWd9uxN1CK8PUxyQgMdMqXzwnrs+9uS9uK7JTaqB8KStybFt9SXjPzTTrU0iPFWVa9RgsgBFhdlAVsptQkM=
X-Received: by 2002:ab0:544e:0:b0:68a:5c52:7f2b with SMTP id
 o14-20020ab0544e000000b0068a5c527f2bmr27352743uaa.1.1678954207154; Thu, 16
 Mar 2023 01:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230314042109.82161-1-catherine.hoang@oracle.com>
 <20230314042109.82161-4-catherine.hoang@oracle.com> <CAOQ4uxiYVpF9gjt-kTVpnoVYboOFG-Fpfw=KMrM=-aEHod4vXw@mail.gmail.com>
 <FC1BD250-7179-470B-854E-649E52147219@oracle.com>
In-Reply-To: <FC1BD250-7179-470B-854E-649E52147219@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Mar 2023 10:09:56 +0200
Message-ID: <CAOQ4uxg6hR8R9XC8qSkxQG8=tkwKZi=2Ofq_-LgZEwwPqbFQjA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] xfs: add XFS_IOC_SETFSUUID ioctl
To:     Catherine Hoang <catherine.hoang@oracle.com>
Cc:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 1:13=E2=80=AFAM Catherine Hoang
<catherine.hoang@oracle.com> wrote:
>
> > On Mar 13, 2023, at 10:50 PM, Amir Goldstein <amir73il@gmail.com> wrote=
:
> >
> > On Tue, Mar 14, 2023 at 6:27=E2=80=AFAM Catherine Hoang
> > <catherine.hoang@oracle.com> wrote:
> >>
> >> Add a new ioctl to set the uuid of a mounted filesystem.
> >>
> >> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> >> ---
> >> fs/xfs/libxfs/xfs_fs.h |   1 +
> >> fs/xfs/xfs_ioctl.c     | 107 +++++++++++++++++++++++++++++++++++++++++
> >> fs/xfs/xfs_log.c       |  19 ++++++++
> >> fs/xfs/xfs_log.h       |   2 +
> >> 4 files changed, 129 insertions(+)
> >>
> >> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> >> index 1cfd5bc6520a..a350966cce99 100644
> >> --- a/fs/xfs/libxfs/xfs_fs.h
> >> +++ b/fs/xfs/libxfs/xfs_fs.h
> >> @@ -831,6 +831,7 @@ struct xfs_scrub_metadata {
> >> #define XFS_IOC_FSGEOMETRY          _IOR ('X', 126, struct xfs_fsop_ge=
om)
> >> #define XFS_IOC_BULKSTAT            _IOR ('X', 127, struct xfs_bulksta=
t_req)
> >> #define XFS_IOC_INUMBERS            _IOR ('X', 128, struct xfs_inumber=
s_req)
> >> +#define XFS_IOC_SETFSUUID           _IOR ('X', 129, uuid_t)
> >
> > Should be _IOW.
>
> Ok, will fix that.
> >
> > Would you consider defining that as FS_IOC_SETFSUUID in fs.h,
> > so that other fs could implement it later on, instead of hoisting it la=
ter?
> >
> > It would be easy to add support for FS_IOC_SETFSUUID to ext4
> > by generalizing ext4_ioctl_setuuid().
> >
> > Alternatively, we could hoist EXT4_IOC_SETFSUUID and struct fsuuid
> > to fs.h and use that ioctl also for xfs.
>
> I actually did try to hoist the ext4 ioctls previously, but we weren=E2=
=80=99t able to come
> to a consensus on the implementation.
>
> https://lore.kernel.org/linux-xfs/20221118211408.72796-2-catherine.hoang@=
oracle.com/
>
> I would prefer to keep this defined as an xfs specific ioctl to avoid all=
 of the
> fsdevel bikeshedding.

For the greater good, please do try to have this bikeshedding, before givin=
g up.
The discussion you pointed to wasn't so far from consensus IMO except
fsdevel was not CCed.

> >
> > Using an extensible struct with flags for that ioctl may turn out to be=
 useful,
> > for example, to verify that the new uuid is unique, despite the fact
> > that xfs was
> > mounted with -onouuid (useful IMO) or to explicitly request a restore o=
f old
> > uuid that would fail if new_uuid !=3D meta uuid.
>
> I think using a struct is probably a good idea, I can add that in the nex=
t version.

Well, if you agree about a struct and agree about flags then the only thing
left is Dave's concern about variable size arrays in ioctl and that could b=
e
addressed in a way that is compatible with ext4.

See untested patch below.

Thanks,
Amir.

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..143a4735486e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -215,6 +215,17 @@ struct fsxattr {
 #define FS_IOC_FSSETXATTR              _IOW('X', 32, struct fsxattr)
 #define FS_IOC_GETFSLABEL              _IOR(0x94, 49, char[FSLABEL_MAX])
 #define FS_IOC_SETFSLABEL              _IOW(0x94, 50, char[FSLABEL_MAX])
+#define FS_IOC_GETFSUUID               _IOR('v', 44, struct fsuuid)
+#define FS_IOC_SETFSUUID               _IOW('v', 44, struct fsuuid)
+
+/*
+ * Structure for FS_IOC_GETFSUUID/FS_IOC_SETFSUUID
+ */
+struct fsuuid {
+       __u32   fsu_len; /* for backward compat has to be 16 */
+       __u32   fsu_flags;
+       __u8    fsu_uuid[16];
+};

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 140e1eb300d1..c4ded5d5e421 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -722,8 +722,8 @@ enum {
 #define EXT4_IOC_GETSTATE              _IOW('f', 41, __u32)
 #define EXT4_IOC_GET_ES_CACHE          _IOWR('f', 42, struct fiemap)
 #define EXT4_IOC_CHECKPOINT            _IOW('f', 43, __u32)
-#define EXT4_IOC_GETFSUUID             _IOR('f', 44, struct fsuuid)
-#define EXT4_IOC_SETFSUUID             _IOW('f', 44, struct fsuuid)
+#define EXT4_IOC_GETFSUUID             _IOR('f', 44, struct fsuuid_bdr)
+#define EXT4_IOC_SETFSUUID             _IOW('f', 44, struct fsuuid_hdr)

 #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)

@@ -756,7 +756,7 @@ enum {
 /*
  * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
  */
-struct fsuuid {
+struct fsuuid_hdr {
        __u32       fsu_len;
        __u32       fsu_flags;
        __u8        fsu_uuid[];

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 8067ccda34e4..fc744231ad24 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1149,7 +1149,7 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info *sb=
i,
        struct fsuuid fsuuid;
        __u8 uuid[UUID_SIZE];

-       if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+       if (copy_from_user(&fsuuid, ufsuuid, offsetof(fsuuid, fsu_uuid)))
                return -EFAULT;

        if (fsuuid.fsu_len =3D=3D 0) {
@@ -1168,7 +1168,7 @@ static int ext4_ioctl_getuuid(struct ext4_sb_info *sb=
i,
        unlock_buffer(sbi->s_sbh);

        fsuuid.fsu_len =3D UUID_SIZE;
-       if (copy_to_user(ufsuuid, &fsuuid, sizeof(fsuuid)) ||
+       if (copy_to_user(ufsuuid, &fsuuid, offsetof(fsuuid, fsu_uuid)) ||
            copy_to_user(&ufsuuid->fsu_uuid[0], uuid, UUID_SIZE))
                return -EFAULT;
        return 0;
@@ -1194,7 +1194,7 @@ static int ext4_ioctl_setuuid(struct file *filp,
                || ext4_has_feature_stable_inodes(sb))
                return -EOPNOTSUPP;

-       if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
+       if (copy_from_user(&fsuuid, ufsuuid, offsetof(fsuuid, fsu_uuid)))
                return -EFAULT;

        if (fsuuid.fsu_len !=3D UUID_SIZE || fsuuid.fsu_flags !=3D 0)
@@ -1596,8 +1596,10 @@ static long __ext4_ioctl(struct file *filp,
unsigned int cmd, unsigned long arg)
                return ext4_ioctl_setlabel(filp,
                                           (const void __user *)arg);

+       case FS_IOC_GETFSUUID:
        case EXT4_IOC_GETFSUUID:
                return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
+       case FS_IOC_SETFSUUID:
        case EXT4_IOC_SETFSUUID:
                return ext4_ioctl_setuuid(filp, (const void __user *)arg);
        default:
