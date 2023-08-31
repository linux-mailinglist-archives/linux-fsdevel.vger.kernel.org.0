Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A478F128
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjHaQWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 12:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244745AbjHaQWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:22:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C947BCEB;
        Thu, 31 Aug 2023 09:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5582BB82336;
        Thu, 31 Aug 2023 16:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167CFC433C8;
        Thu, 31 Aug 2023 16:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693498954;
        bh=zAICLpXIMSq2IixMHCudgNTf+XM+1+x0FkjvX8ZyAeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FPaFftgwx7rhWNRqc8Ji7eLGtS00mtMrTu+UAhOzHKa8okSn5sFCdTqaPHX81Lk+x
         8QlD0SPdHEPzNatorjh5ab7vaXBVzh/Xe7VHvWo1kB98gBG0BSJFU5i1gHzIf0t8oA
         3GoYdtnZiYW8SVT/ZE/OoLdKCGQd8KW8OLiemsN6M6iElEHeOQVVGf9qHM5J1swRQP
         csbgq79Sza2brgugT0zEEJeXWwS6I01aatCXtWIGUy4DtKyYMuVZ4jtWWF6rjlqPXn
         w+bGN+QD8puDA6HoGljgEujveIQ4WETs4em//05kkulYndqhuOkNzR0j0yAFxU7Vfc
         WDllkfB1vWOEg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500b66f8b27so1954855e87.3;
        Thu, 31 Aug 2023 09:22:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVEJvpNklVedYL/PAfG9nvstTTmsTe9nFP/xG/1GpW2NjQYrrZ
        dO8NtqjYV47y6GsEmWtRIuEU05oF7aq0G60o2LQ=
X-Google-Smtp-Source: AGHT+IGNKmW5THhZkY2JFYSDeF7qO+vGSyOvfnNky8/2WoFb9R/FailTQE35YMAZRSQWO7s6d0+Ly0PvJ5CpEShsZGw=
X-Received: by 2002:a05:6512:3e2a:b0:500:9f03:9157 with SMTP id
 i42-20020a0565123e2a00b005009f039157mr5368378lfv.65.1693498952009; Thu, 31
 Aug 2023 09:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230831161551.2032504-1-jiaozhou@google.com>
In-Reply-To: <20230831161551.2032504-1-jiaozhou@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 31 Aug 2023 18:22:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEvJPhO6dJGWx8ezX3D6QWwdaLjqw2bFqZCQcQda_BHmw@mail.gmail.com>
Message-ID: <CAMj1kXEvJPhO6dJGWx8ezX3D6QWwdaLjqw2bFqZCQcQda_BHmw@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Add Mount Option For Efivarfs
To:     Jiao Zhou <jiaozhou@google.com>
Cc:     Linux FS Development <linux-fsdevel@vger.kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi again,

This is v3 whereas the subject now has v2 - please remain consistent.

On Thu, 31 Aug 2023 at 18:15, Jiao Zhou <jiaozhou@google.com> wrote:
>
> We want to support fwupd for updating system firmware on Reven.
> Capsule updates need to create UEFI variables. Our current approach
> to UEFI variables of just allowing access to a static list of them
> at boot time won't work here.
>
> I think we could add mount options to efivarfs to set the uid/gid.
> We'd then mount the file system with fwupd's uid/gid.
> This approach is used by a number of other filesystems that don't
> have native support for ownership, so it should be upstreamable.
>
> Signed-off-by: Jiao Zhou <jiaozhou@google.com>


> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202308291443.ea96ac66-oliver.sang@intel.com

I mentioned that you should drop these two lines, and instead, include
the acked-by line from Matthew Garrett's reply to v1. You also failed
to cc Matthew - it is common courtesy to cc people that have taken the
trouble of responding to your previous revisions on subsequent ones.


> ---
> Changelog since v2:
> - Fix a NULL pointer dereference and add a a trailing empty entry to sturct.
>

These are the changes wrt v1 no? Please try to be accurate - these
things may seem unimportant but all these emails are logged and
archived, and someone may need to try and make sense of them 10+ years
from now to figure out why this change was made.

You also forgot to reply to the questions I raised in my previous
reply. Please address those before sending a v4.


>  fs/efivarfs/inode.c    |  4 +++
>  fs/efivarfs/internal.h |  9 ++++++
>  fs/efivarfs/super.c    | 65 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+)
>
> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index 939e5e242b98..de57fb6c28e1 100644
> --- a/fs/efivarfs/inode.c
> +++ b/fs/efivarfs/inode.c
> @@ -20,9 +20,13 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
>                                 const struct inode *dir, int mode,
>                                 dev_t dev, bool is_removable)
>  {
> +       struct efivarfs_fs_info *fsi = sb->s_fs_info;
>         struct inode *inode = new_inode(sb);
> +       struct efivarfs_mount_opts *opts = &fsi->mount_opts;
>
>         if (inode) {
> +               inode->i_uid = opts->uid;
> +               inode->i_gid = opts->gid;
>                 inode->i_ino = get_next_ino();
>                 inode->i_mode = mode;
>                 inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> index 30ae44cb7453..57deaf56d8e2 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -8,6 +8,15 @@
>
>  #include <linux/list.h>
>
> +struct efivarfs_mount_opts {
> +       kuid_t uid;
> +       kgid_t gid;
> +};
> +
> +struct efivarfs_fs_info {
> +       struct efivarfs_mount_opts mount_opts;
> +};
> +
>  extern const struct file_operations efivarfs_file_operations;
>  extern const struct inode_operations efivarfs_dir_inode_operations;
>  extern bool efivarfs_valid_name(const char *str, int len);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 15880a68faad..d67b0d157ff5 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -8,6 +8,7 @@
>  #include <linux/efi.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/module.h>
>  #include <linux/pagemap.h>
>  #include <linux/ucs2_string.h>
> @@ -23,10 +24,27 @@ static void efivarfs_evict_inode(struct inode *inode)
>         clear_inode(inode);
>  }
>
> +static int efivarfs_show_options(struct seq_file *m, struct dentry *root)
> +{
> +       struct super_block *sb = root->d_sb;
> +       struct efivarfs_fs_info *sbi = sb->s_fs_info;
> +       struct efivarfs_mount_opts *opts = &sbi->mount_opts;
> +
> +       /* Show partition info */
> +       if (!uid_eq(opts->uid, GLOBAL_ROOT_UID))
> +               seq_printf(m, ",uid=%u",
> +                               from_kuid_munged(&init_user_ns, opts->uid));
> +       if (!gid_eq(opts->gid, GLOBAL_ROOT_GID))
> +               seq_printf(m, ",gid=%u",
> +                               from_kgid_munged(&init_user_ns, opts->gid));
> +       return 0;
> +}
> +
>  static const struct super_operations efivarfs_ops = {
>         .statfs = simple_statfs,
>         .drop_inode = generic_delete_inode,
>         .evict_inode = efivarfs_evict_inode,
> +       .show_options   = efivarfs_show_options,
>  };
>
>  /*
> @@ -190,6 +208,41 @@ static int efivarfs_destroy(struct efivar_entry *entry, void *data)
>         return 0;
>  }
>
> +enum {
> +       Opt_uid, Opt_gid,
> +};
> +
> +static const struct fs_parameter_spec efivarfs_parameters[] = {
> +       fsparam_u32("uid",                      Opt_uid),
> +       fsparam_u32("gid",                      Opt_gid),
> +       {},
> +};
> +
> +static int efivarfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +       struct efivarfs_fs_info *sbi = fc->s_fs_info;
> +       struct efivarfs_mount_opts *opts = &sbi->mount_opts;
> +       struct fs_parse_result result;
> +       int opt;
> +
> +       opt = fs_parse(fc, efivarfs_parameters, param, &result);
> +       if (opt < 0)
> +               return opt;
> +
> +       switch (opt) {
> +       case Opt_uid:
> +               opts->uid = make_kuid(current_user_ns(), result.uint_32);
> +               break;
> +       case Opt_gid:
> +               opts->gid = make_kgid(current_user_ns(), result.uint_32);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  {
>         struct inode *inode = NULL;
> @@ -233,10 +286,21 @@ static int efivarfs_get_tree(struct fs_context *fc)
>
>  static const struct fs_context_operations efivarfs_context_ops = {
>         .get_tree       = efivarfs_get_tree,
> +       .parse_param    = efivarfs_parse_param,
>  };
>
>  static int efivarfs_init_fs_context(struct fs_context *fc)
>  {
> +       struct efivarfs_fs_info *sfi;
> +
> +       sfi = kzalloc(sizeof(struct efivarfs_fs_info), GFP_KERNEL);
> +       if (!sfi)
> +               return -ENOMEM;
> +
> +       sfi->mount_opts.uid = current_uid();
> +       sfi->mount_opts.gid = current_gid();
> +
> +       fc->s_fs_info = sfi;
>         fc->ops = &efivarfs_context_ops;
>         return 0;
>  }
> @@ -254,6 +318,7 @@ static struct file_system_type efivarfs_type = {
>         .name    = "efivarfs",
>         .init_fs_context = efivarfs_init_fs_context,
>         .kill_sb = efivarfs_kill_sb,
> +       .parameters             = efivarfs_parameters,
>  };
>
>  static __init int efivarfs_init(void)
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>
