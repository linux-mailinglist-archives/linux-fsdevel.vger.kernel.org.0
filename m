Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838B47935E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 09:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjIFHGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 03:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIFHGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:06:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D183;
        Wed,  6 Sep 2023 00:06:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F5DC433C7;
        Wed,  6 Sep 2023 07:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693984002;
        bh=QlKqOiuJcXJ+UJetTjnpr9pfdN0x0FuCwfVIo5GBkBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KK4BDgGIlXB8No81pdYiryeL5qSOuHM8UAEsMZ15KODIa4tk0ksko4ZINc6iuSlQr
         Q7KjjPWJSXq1MHoNb/bU8xEe3qTkoONvukVR9b4pQiph4fPYkE0hW2VmmFP2CYsese
         0j30XdQybX1QPbw5M0wkV81FLXedOwQZYZGsL6KY/ixYEgfN+Bd1jPS5e7UAu/vnfq
         5h71ZPj4dcidFJcw4oBpDXPVSg9wRx9k4kXx3eoDefQZm8ct3E6e6PEkg/h+eWhrPw
         k0/WoreWZzpibWgeYCR2LpXMg5sRCVZGg0QTBxIP4/Tw+yZQzOFF/okf+G4pstOCXe
         7h7mEqORy3LaA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5008d16cc36so5546403e87.2;
        Wed, 06 Sep 2023 00:06:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YzT7Is/r8pLjy+HkhVHYfdMF+TUREpYeN1Pua6gFlBsoaAJED5L
        VoIC3tBGHNmKgkyIDzSAjdnIiJrZt8k//aobS54=
X-Google-Smtp-Source: AGHT+IE841z3r8oL+9aJtgeVSdQWFQn+moBKacdcuvomzpmaDTDBpnpeNr+fPTUhJfMtvvPI04QZFav6gQMzTsLegXg=
X-Received: by 2002:a05:6512:220f:b0:4fb:7cea:882a with SMTP id
 h15-20020a056512220f00b004fb7cea882amr1943544lfu.3.1693984000686; Wed, 06 Sep
 2023 00:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230831153108.2021554-1-jiaozhou@google.com> <20230904-erben-coachen-7ca9a30cdc05@brauner>
 <CAFyYRf0xyZSLypcHvpzCXQ5dUztTXbE4Ea1xAcQLfbP4+9N9sQ@mail.gmail.com>
In-Reply-To: <CAFyYRf0xyZSLypcHvpzCXQ5dUztTXbE4Ea1xAcQLfbP4+9N9sQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 6 Sep 2023 09:06:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRaMgPi1X-WRMkunBhBqfVFyDZu6f7CdCh6mU5Mtqh1A@mail.gmail.com>
Message-ID: <CAMj1kXFRaMgPi1X-WRMkunBhBqfVFyDZu6f7CdCh6mU5Mtqh1A@mail.gmail.com>
Subject: Re: [PATCH] kernel: Add Mount Option For Efivarfs
To:     Jiao Zhou <jiaozhou@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux FS Development <linux-fsdevel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 5 Sept 2023 at 20:05, Jiao Zhou <jiaozhou@google.com> wrote:
>
> Hi Christian,
>
> Thanks for your reply, will adding a guid and uid check like the below be=
 sufficient? I saw this is how most file systems check their gid and uid. I=
 am not quite sure about how to send fd back to init_user_ns. Can you pleas=
e clarify a little bit? Thank you so much.
...

>

Please don't top post and please only send plaintext email to the mailing l=
ists.

Please consult Documentation/process/submitting-patches.rst in the
Linux source tree if you are unfamiliar with the upstream contribution
process (and since you appear to be at Google, you might want to
consult go/kernel-upstream as well)

Thanks,
Ard.


>
>
> On Mon, Sep 4, 2023 at 1:17=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>>
>> On Thu, Aug 31, 2023 at 03:31:07PM +0000, Jiao Zhou wrote:
>> > Add uid and gid in efivarfs's mount option, so that
>> > we can mount the file system with ownership. This approach
>> >  is used by a number of other filesystems that don't have
>> > native support for ownership.
>> >
>> > TEST=3DFEATURES=3Dtest emerge-reven chromeos-kernel-5_15
>> >
>> > Signed-off-by: Jiao Zhou <jiaozhou@google.com>
>> > Reported-by: kernel test robot <oliver.sang@intel.com>
>> > Closes: https://lore.kernel.org/oe-lkp/202308291443.ea96ac66-oliver.sa=
ng@intel.com
>> > ---
>> >  fs/efivarfs/inode.c    |  4 +++
>> >  fs/efivarfs/internal.h |  9 ++++++
>> >  fs/efivarfs/super.c    | 65 +++++++++++++++++++++++++++++++++++++++++=
+
>> >  3 files changed, 78 insertions(+)
>> >
>> > diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
>> > index 939e5e242b98..de57fb6c28e1 100644
>> > --- a/fs/efivarfs/inode.c
>> > +++ b/fs/efivarfs/inode.c
>> > @@ -20,9 +20,13 @@ struct inode *efivarfs_get_inode(struct super_block=
 *sb,
>> >                               const struct inode *dir, int mode,
>> >                               dev_t dev, bool is_removable)
>> >  {
>> > +     struct efivarfs_fs_info *fsi =3D sb->s_fs_info;
>> >       struct inode *inode =3D new_inode(sb);
>> > +     struct efivarfs_mount_opts *opts =3D &fsi->mount_opts;
>> >
>> >       if (inode) {
>> > +             inode->i_uid =3D opts->uid;
>> > +             inode->i_gid =3D opts->gid;
>> >               inode->i_ino =3D get_next_ino();
>> >               inode->i_mode =3D mode;
>> >               inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D=
 current_time(inode);
>> > diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
>> > index 30ae44cb7453..57deaf56d8e2 100644
>> > --- a/fs/efivarfs/internal.h
>> > +++ b/fs/efivarfs/internal.h
>> > @@ -8,6 +8,15 @@
>> >
>> >  #include <linux/list.h>
>> >
>> > +struct efivarfs_mount_opts {
>> > +     kuid_t uid;
>> > +     kgid_t gid;
>> > +};
>> > +
>> > +struct efivarfs_fs_info {
>> > +     struct efivarfs_mount_opts mount_opts;
>> > +};
>> > +
>> >  extern const struct file_operations efivarfs_file_operations;
>> >  extern const struct inode_operations efivarfs_dir_inode_operations;
>> >  extern bool efivarfs_valid_name(const char *str, int len);
>> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
>> > index 15880a68faad..d67b0d157ff5 100644
>> > --- a/fs/efivarfs/super.c
>> > +++ b/fs/efivarfs/super.c
>> > @@ -8,6 +8,7 @@
>> >  #include <linux/efi.h>
>> >  #include <linux/fs.h>
>> >  #include <linux/fs_context.h>
>> > +#include <linux/fs_parser.h>
>> >  #include <linux/module.h>
>> >  #include <linux/pagemap.h>
>> >  #include <linux/ucs2_string.h>
>> > @@ -23,10 +24,27 @@ static void efivarfs_evict_inode(struct inode *ino=
de)
>> >       clear_inode(inode);
>> >  }
>> >
>> > +static int efivarfs_show_options(struct seq_file *m, struct dentry *r=
oot)
>> > +{
>> > +     struct super_block *sb =3D root->d_sb;
>> > +     struct efivarfs_fs_info *sbi =3D sb->s_fs_info;
>> > +     struct efivarfs_mount_opts *opts =3D &sbi->mount_opts;
>> > +
>> > +     /* Show partition info */
>> > +     if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
>> > +             seq_printf(m, ",uid=3D%u",
>> > +                             from_kuid_munged(&init_user_ns, opts->ui=
d));
>> > +     if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
>> > +             seq_printf(m, ",gid=3D%u",
>> > +                             from_kgid_munged(&init_user_ns, opts->gi=
d));
>> > +     return 0;
>> > +}
>> > +
>> >  static const struct super_operations efivarfs_ops =3D {
>> >       .statfs =3D simple_statfs,
>> >       .drop_inode =3D generic_delete_inode,
>> >       .evict_inode =3D efivarfs_evict_inode,
>> > +     .show_options   =3D efivarfs_show_options,
>> >  };
>> >
>> >  /*
>> > @@ -190,6 +208,41 @@ static int efivarfs_destroy(struct efivar_entry *=
entry, void *data)
>> >       return 0;
>> >  }
>> >
>> > +enum {
>> > +     Opt_uid, Opt_gid,
>> > +};
>> > +
>> > +static const struct fs_parameter_spec efivarfs_parameters[] =3D {
>> > +     fsparam_u32("uid",                      Opt_uid),
>> > +     fsparam_u32("gid",                      Opt_gid),
>> > +     {},
>> > +};
>> > +
>> > +static int efivarfs_parse_param(struct fs_context *fc, struct fs_para=
meter *param)
>> > +{
>> > +     struct efivarfs_fs_info *sbi =3D fc->s_fs_info;
>> > +     struct efivarfs_mount_opts *opts =3D &sbi->mount_opts;
>> > +     struct fs_parse_result result;
>> > +     int opt;
>> > +
>> > +     opt =3D fs_parse(fc, efivarfs_parameters, param, &result);
>> > +     if (opt < 0)
>> > +             return opt;
>> > +
>> > +     switch (opt) {
>> > +     case Opt_uid:
>> > +             opts->uid =3D make_kuid(current_user_ns(), result.uint_3=
2);
>> > +             break;
>> > +     case Opt_gid:
>> > +             opts->gid =3D make_kgid(current_user_ns(), result.uint_3=
2);
>> > +             break;
>>
>> This will allow the following:
>>
>> # initial user namespace
>> fd_fs =3D fsopen("efivarfs")
>>
>> # switch to some unprivileged userns
>> fsconfig(fd_fs, FSCONFIG_SET_STRING, "uid", "1000")
>> =3D=3D> This now resolves within the caller's user namespace which might
>>     have an idmapping where 1000 cannot be resolved causing sb->{g,u}id
>>     to be set to INVALID_{G,U}ID.
>>
>>     In fact this is also possible in your patch right now without the
>>     namespace switching. The caller could just pass -1 and that would
>>     cause inodes with INVALID_{G,U}ID to be created.
>>     So you want a check for {g,u}id_valid().
>>
>> # send fd back to init_user_ns
>> fsconfig(fd_fs, FSCONFIG_CMD_CREATE)
>> fd_mnt =3D fsmount(fd_fs, ...)
>> move_mount(fd_fs, "", -EBADF, "/somehwere", ...)
