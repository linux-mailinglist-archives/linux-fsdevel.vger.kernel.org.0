Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB50571178
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 06:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiGLEdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 00:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGLEdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 00:33:14 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB6F201AE;
        Mon, 11 Jul 2022 21:33:13 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id l7so2597120ual.9;
        Mon, 11 Jul 2022 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYSy+PwJVZtWQPEvCfRMGZwW6SplaQ3eDk/MT8VgHHs=;
        b=gB9RJbP8BYaQhDcDUj5GbDcEKwayrCtLHieVMuXumMThnw5KPvU+5n80wEPKsBEj9r
         RHyhOGV6shDyNBOxiFy+thubnnxJziVU5WpcVb+1Ay4xKKGmcAzai8yPK1o55/G1dDtu
         pd8mS8semd6K5ITLxu18x9Wp3oZk6bUkL2VhH38dcdpqN1Y3YGJy/BvkBAa40d/3xTLL
         9gkAyd+4xKJQv1kWqTl60vmmewTaL71GbS6i2EAPdBe3A+UcVvAbCF+jLlHiUwY8+1QH
         /0S699wYI7m/Gv8Tb7S6I/V+FS7DeHZroaiHSuLX2//tBZzdhsi2pIDn4PgNs8icXiOc
         H2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYSy+PwJVZtWQPEvCfRMGZwW6SplaQ3eDk/MT8VgHHs=;
        b=Ee0e1aoHWis6Pq/2aZzaVsgZtX/zb2LNnq4KHZqkqBAguIPSro99nhs9Vf9xaAN/bX
         WAgzRboVrbty03973yrI4tbnKspUFe6iGa9SM+PFz8KuJEphbYujOEYmOwNiVGlDcXwW
         Tk+6Sa9wB/+pIWzTxVnHnSfjRl0rN/3CVnsKmNvVtW3mLD8Dols1jIHa+lC7ezcO+mau
         uZbN3aAAzUDsjyv3sZJfe0BM/gc1pN+MqklpleHSugSAxqINbPesJqSH/CXaqEL48ZF9
         6NTcqdewTlvMYqGEfLgQMZ41mQARo0+lQNJhBr4zKKDK14iKt5jM0CcZKZfkoNBTvuZb
         kOPQ==
X-Gm-Message-State: AJIora+c16CvjQY1OEIbNA2NVGAQQwTOPCrCpkhHZapUP5SzTR8mD3+Z
        tbTFr/4VD/sEPZWjZgDBfKPelB6zsvTdSXvGQjlTMpBZH98OCGPh
X-Google-Smtp-Source: AGRyM1s3EjBOs8s4xkMJ8x6N/Ycr8M9scEQaIVL0V9eTihxAbIk7EDxJ8QLmNRnRrJ2Fu1PRHjfieOmll+Jmsa3tzQk=
X-Received: by 2002:ab0:7515:0:b0:382:84b1:a2e1 with SMTP id
 m21-20020ab07515000000b0038284b1a2e1mr7233609uap.26.1657600392171; Mon, 11
 Jul 2022 21:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220701201123.183468-1-bongiojp@gmail.com> <YsRv2iaVltGW8Yj2@magnolia>
In-Reply-To: <YsRv2iaVltGW8Yj2@magnolia>
From:   Jeremy Bongio <bongiojp@gmail.com>
Date:   Mon, 11 Jul 2022 21:33:00 -0700
Message-ID: <CANfQU3y8m=08yJDgFSDztO0=b-pD6A4mXH8PQW9yh6ivq8h_Jw@mail.gmail.com>
Subject: Re: [PATCH v2] Add ioctls to get/set the ext4 superblock uuid.
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 5, 2022 at 10:07 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Jul 01, 2022 at 01:11:23PM -0700, Jeremy Bongio wrote:
> > This fixes a race between changing the ext4 superblock uuid and operations
> > like mounting, resizing, changing features, etc.
> >
> > Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Jeremy Bongio <bongiojp@gmail.com>
> > ---
> >  fs/ext4/ext4.h  | 13 ++++++++
> >  fs/ext4/ioctl.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 96 insertions(+)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 75b8d81b2469..0cf960cb591e 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -724,6 +724,8 @@ enum {
> >  #define EXT4_IOC_GETSTATE            _IOW('f', 41, __u32)
> >  #define EXT4_IOC_GET_ES_CACHE                _IOWR('f', 42, struct fiemap)
> >  #define EXT4_IOC_CHECKPOINT          _IOW('f', 43, __u32)
> > +#define EXT4_IOC_GETFSUUID           _IOR('f', 44, struct fsuuid)
> > +#define EXT4_IOC_SETFSUUID           _IOW('f', 44, struct fsuuid)
> >
> >  #define EXT4_IOC_SHUTDOWN _IOR ('X', 125, __u32)
> >
> > @@ -753,6 +755,17 @@ enum {
> >                                               EXT4_IOC_CHECKPOINT_FLAG_ZEROOUT | \
> >                                               EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
> >
> > +/*
> > + * Structure for EXT4_IOC_GETFSUUID/EXT4_IOC_SETFSUUID
> > + */
> > +struct fsuuid {
> > +     __u32       fu_len;
> > +     __u32       fu_flags;
> > +     __u8 __user fu_uuid[];
>
> __user is unnecessary here -- it applies to pointers, not to struct
> members.
>
> > +};
> > +
> > +#define EXT4_IOC_SETFSUUID_FLAG_BLOCKING 0x1
>
> What does this do?
>
> (Better yet, can you please write a manpage describing these new
> ioctls?)

Good idea. I'll write a manpage as if it were being converted to a general ioctl
and not specific to ext4.

>
> > +
> >  #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
> >  /*
> >   * ioctl commands in 32 bit emulation
> > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > index cb01c1da0f9d..75069afc16ae 100644
> > --- a/fs/ext4/ioctl.c
> > +++ b/fs/ext4/ioctl.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/iversion.h>
> >  #include <linux/fileattr.h>
> > +#include <linux/uuid.h>
> >  #include "ext4_jbd2.h"
> >  #include "ext4.h"
> >  #include <linux/fsmap.h>
> > @@ -41,6 +42,15 @@ static void ext4_sb_setlabel(struct ext4_super_block *es, const void *arg)
> >       memcpy(es->s_volume_name, (char *)arg, EXT4_LABEL_MAX);
> >  }
> >
> > +/*
> > + * Superblock modification callback function for changing file system
> > + * UUID.
> > + */
> > +static void ext4_sb_setuuid(struct ext4_super_block *es, const void *arg)
> > +{
> > +     memcpy(es->s_uuid, (__u8 *)arg, UUID_SIZE);
> > +}
> > +
> >  static
> >  int ext4_update_primary_sb(struct super_block *sb, handle_t *handle,
> >                          ext4_update_sb_callback func,
> > @@ -1131,6 +1141,73 @@ static int ext4_ioctl_getlabel(struct ext4_sb_info *sbi, char __user *user_label
> >       return 0;
> >  }
> >
> > +static int ext4_ioctl_getuuid(struct ext4_sb_info *sbi,
> > +                     struct fsuuid __user *ufsuuid)
> > +{
> > +     int ret = 0;
> > +     __u8 uuid[UUID_SIZE];
>
> Save some stack space and copy sbi->s_es->s_uuid into fsuuid.fu_uuid,
> and then copy_to_user from the kernel stack object out to userspace's
> object.

I can't copy sbi->s_es->s_uuid into fsuuid.fu_uuid since fu_uuid is a
VLA (size 0 array).
Are you suggesting I copy_to_user() from sbi->s_es->s_uuid into
ufsuuid within the locked region?

>
> > +     struct fsuuid fsuuid;
> > +
> > +     if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> > +             return -EFAULT;
> > +
> > +     if (fsuuid.fu_len != UUID_SIZE)
> > +             return -EINVAL;
>
> This function needs to check that fsuuid.fu_flags doesn't contain any
> unknown bitflags.
>
> > +
> > +     lock_buffer(sbi->s_sbh);
> > +     memcpy(uuid, sbi->s_es->s_uuid, UUID_SIZE);
> > +     unlock_buffer(sbi->s_sbh);
> > +
> > +     if (copy_to_user(&ufsuuid->fu_uuid[0], uuid, UUID_SIZE))
> > +             ret = -EFAULT;
> > +     return ret;
>
>         if (copy_to_user(...))
>                 return -EFAULT;
>
>         return 0;
>
> ?
>
> > +}
> > +
> > +static int ext4_ioctl_setuuid(struct file *filp,
> > +                     const struct fsuuid __user *ufsuuid)
> > +{
> > +     int ret = 0;
> > +     struct super_block *sb = file_inode(filp)->i_sb;
> > +     struct fsuuid fsuuid;
> > +     __u8 uuid[UUID_SIZE];
> > +
> > +     if (!capable(CAP_SYS_ADMIN))
> > +             return -EPERM;
> > +
> > +     /*
> > +      * If any checksums (group descriptors or metadata) are being used
> > +      * then the checksum seed feature is required to change the UUID.
> > +      */
> > +     if (((ext4_has_feature_gdt_csum(sb) || ext4_has_metadata_csum(sb))
> > +                     && !ext4_has_feature_csum_seed(sb))
> > +             || ext4_has_feature_stable_inodes(sb))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (copy_from_user(&fsuuid, ufsuuid, sizeof(fsuuid)))
> > +             return -EFAULT;
> > +
> > +     if (fsuuid.fu_len != UUID_SIZE)
> > +             return -EINVAL;
>
> This function needs to check that fsuuid.fu_flags doesn't contain any
> unknown bits.
>
> > +
> > +     if (copy_from_user(uuid, &ufsuuid->fu_uuid[0], UUID_SIZE))
> > +             return -EFAULT;
> > +
> > +     ret = mnt_want_write_file(filp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     do {
> > +             if (ret == -EBUSY)
> > +                     msleep(1000);
> > +             ret = ext4_update_superblocks_fn(sb, ext4_sb_setuuid, &uuid);
> > +     } while (ret == -EBUSY &&
> > +             fsuuid.fu_flags & EXT4_IOC_SETFSUUID_FLAG_BLOCKING);
>
> So... I guess by default, userspace gets NOWAIT mode?  That's a little
> strange, usually kernel convention is blocking mode by default, with
> nowait selectable via function flags.
>
> Also, what's the intended use case here?  Why would we want to set a
> uuid but only if the superblock(s) aren't busy?

When an ext4 filesystem is being resized, which could potentially take
a long time,
ext4_update_superblocks_fn() will return -EBUSY. In that case we can
either sleep and retry,
or return EBUSY to userspace. However, for my use case, I only care
about the blocking case.
I'll remove the flag since the default mode will be blocking.

>
> --D
>
> > +
> > +     mnt_drop_write_file(filp);
> > +
> > +     return ret;
> > +}
> > +
> >  static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >  {
> >       struct inode *inode = file_inode(filp);
> > @@ -1509,6 +1586,10 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> >               return ext4_ioctl_setlabel(filp,
> >                                          (const void __user *)arg);
> >
> > +     case EXT4_IOC_GETFSUUID:
> > +             return ext4_ioctl_getuuid(EXT4_SB(sb), (void __user *)arg);
> > +     case EXT4_IOC_SETFSUUID:
> > +             return ext4_ioctl_setuuid(filp, (const void __user *)arg);
> >       default:
> >               return -ENOTTY;
> >       }
> > @@ -1586,6 +1667,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >       case EXT4_IOC_CHECKPOINT:
> >       case FS_IOC_GETFSLABEL:
> >       case FS_IOC_SETFSLABEL:
> > +     case EXT4_IOC_GETFSUUID:
> > +     case EXT4_IOC_SETFSUUID:
> >               break;
> >       default:
> >               return -ENOIOCTLCMD;
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
