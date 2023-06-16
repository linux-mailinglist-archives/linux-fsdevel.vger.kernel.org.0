Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64B733215
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345597AbjFPNVr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 09:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345596AbjFPNVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:21:46 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08A30C1;
        Fri, 16 Jun 2023 06:21:42 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-43b56039611so113596137.1;
        Fri, 16 Jun 2023 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686921701; x=1689513701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrjiopYqeQYT8sBp4oM6JEBnVCzxhh6agCLyR6N9hy8=;
        b=mVgtT4DAnXKkrY+f/E4XUXGJyB28fjWhXtDzI8Xyv25OnWRCyzm4ERN38vEtUNoubx
         jitfL7ye1DDbSmEuWcooZzw6UzrHHtgMPtIQosTuQcnvI+jQJC7C+BVJiqlaNU3EZjae
         gMuyiK1pLimzgsrOpT4zSeOmpZnrB+pxMfAplO2uNuMIC0d+H2xfRLBbrPe9gza1RMc5
         4jwS9CMjdPm/b1kCWQuJzvOie7QUv2JIh7UvqV8xesF5LN273T0+EeePOSAApZvVfF7o
         siiQTjGYn6Vhd6WlxScuwqU0oUqNM3NxNk/8oBol2Z+g96dV76WscHRbDTgWE7mdeJRJ
         +UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686921701; x=1689513701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrjiopYqeQYT8sBp4oM6JEBnVCzxhh6agCLyR6N9hy8=;
        b=PZnpNYA+Vqiv44ruyMQgxNurP5SXpX77XpbAOYQgeWVS2JFO1WFi8vrRzhzrC2kIHB
         XYvcMfQgy2uKoAUmpKETs1hRrF7Odfz3EOBa5p9FqrTYGqaDbRj001W2j6ULxeGxNH8h
         RNbl2Xvfvji1egdwBNSq0SjiT37xxl4RveVmgMZJTDU1KLIGR+NiSVYgUyU5TRazIY57
         B1/jtPFSVXYqgFNdBDMNPlx0OmTHYcVeoYUDyqTKV10VbvY4ykqNA2nIEbGYY7Fl2xe7
         wmrjOdZ9DT+eaVABSFqTvZfAgQlKUXo6xK8jM4ZbiRfb0RloUcqOKalmN/eaYqbHjE5A
         rEvg==
X-Gm-Message-State: AC+VfDxe2u6mflhV00eO4Ex6/rQFwz+7GUohEHdeFi6sfCZtOUbstcdx
        p8hemnLBDD+mFGqs9GVkYIXwfYwOK3ab3Je2sVJwIwp6nJI=
X-Google-Smtp-Source: ACHHUZ7H9tsUohQOreNbxYJez+F2loOdzJ5H02O4n+K04zxyLGM86I8TdDKNdQu8YUj9gwAwkfaflJwLJWQrnKbQV0w=
X-Received: by 2002:a67:f04d:0:b0:43f:5eb2:8e9b with SMTP id
 q13-20020a67f04d000000b0043f5eb28e9bmr1066801vsm.27.1686921700954; Fri, 16
 Jun 2023 06:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org> <20230605-fs-overlayfs-mount_api-v3-2-730d9646b27d@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v3-2-730d9646b27d@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Jun 2023 16:21:29 +0300
Message-ID: <CAOQ4uxi0cVquk5=VF8Q9JY8XWKOp19WxijHNkFGiO=LfpTw+Ng@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ovl: port to new mount api
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 5:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> We recently ported util-linux to the new mount api. Now the mount(8)
> tool will by default use the new mount api. While trying hard to fall
> back to the old mount api gracefully there are still cases where we run
> into issues that are difficult to handle nicely.
>
> Now with mount(8) and libmount supporting the new mount api I expect an
> increase in the number of bug reports and issues we're going to see with
> filesystems that don't yet support the new mount api. So it's time we
> rectify this.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/ovl_entry.h |   2 +-
>  fs/overlayfs/super.c     | 557 ++++++++++++++++++++++++++---------------=
------
>  2 files changed, 305 insertions(+), 254 deletions(-)
>
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index e5207c4bf5b8..c72433c06006 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -12,7 +12,7 @@ struct ovl_config {
>         bool default_permissions;
>         bool redirect_dir;
>         bool redirect_follow;
> -       const char *redirect_mode;
> +       unsigned redirect_mode;

I have a separate patch to get rid of redirect_dir and redirect_follow
leaving only redirect_mode enum.

I've already rebased your patches over this change in my branch.

https://github.com/amir73il/linux/commits/fs-overlayfs-mount_api


>         bool index;
>         bool uuid;
>         bool nfs_export;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index d9be5d318e1b..3392dc5d2082 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -16,6 +16,8 @@
>  #include <linux/posix_acl_xattr.h>
>  #include <linux/exportfs.h>
>  #include <linux/file.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include "overlayfs.h"
>
>  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> @@ -59,6 +61,79 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0=
644);
>  MODULE_PARM_DESC(metacopy,
>                  "Default to on or off for the metadata only copy up feat=
ure");
>
> +enum {
> +       Opt_lowerdir,
> +       Opt_upperdir,
> +       Opt_workdir,
> +       Opt_default_permissions,
> +       Opt_redirect_dir,
> +       Opt_index,
> +       Opt_uuid,
> +       Opt_nfs_export,
> +       Opt_userxattr,
> +       Opt_xino,
> +       Opt_metacopy,
> +       Opt_volatile,
> +};

Renaming all those enums to lower case creates unneeded churn.
I undid that in my branch, so now the mount api porting patch is a
lot smaller.

> +
> +static const struct constant_table ovl_parameter_bool[] =3D {
> +       { "on",         true  },
> +       { "off",        false },
> +       {}
> +};
> +
> +static const struct constant_table ovl_parameter_xino[] =3D {
> +       { "on",         OVL_XINO_ON   },
> +       { "off",        OVL_XINO_OFF  },
> +       { "auto",       OVL_XINO_AUTO },
> +       {}
> +};
> +
> +enum {
> +       OVL_REDIRECT_DIR_ON,
> +       OVL_REDIRECT_DIR_OFF,
> +       OVL_REDIRECT_DIR_FOLLOW,
> +       OVL_REDIRECT_DIR_NOFOLLOW,
> +};
> +
> +static const struct constant_table ovl_parameter_redirect_dir[] =3D {
> +       { "on",         OVL_REDIRECT_DIR_ON       },
> +       { "off",        OVL_REDIRECT_DIR_OFF      },
> +       { "follow",     OVL_REDIRECT_DIR_FOLLOW   },
> +       { "nofollow",   OVL_REDIRECT_DIR_NOFOLLOW },
> +       {}
> +};
> +
> +static const char *ovl_redirect_mode(struct ovl_config *config)
> +{
> +       return ovl_parameter_redirect_dir[config->redirect_mode].name;
> +}
> +
> +static const struct fs_parameter_spec ovl_parameter_spec[] =3D {
> +       fsparam_string("lowerdir",          Opt_lowerdir),
> +       fsparam_string("upperdir",          Opt_upperdir),
> +       fsparam_string("workdir",           Opt_workdir),
> +       fsparam_flag("default_permissions", Opt_default_permissions),
> +       fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_paramet=
er_redirect_dir),
> +       fsparam_enum("index",               Opt_index, ovl_parameter_bool=
),
> +       fsparam_enum("uuid",                Opt_uuid, ovl_parameter_bool)=
,
> +       fsparam_enum("nfs_export",          Opt_nfs_export, ovl_parameter=
_bool),
> +       fsparam_flag("userxattr",           Opt_userxattr),
> +       fsparam_enum("xino",                Opt_xino, ovl_parameter_xino)=
,
> +       fsparam_enum("metacopy",            Opt_metacopy, ovl_parameter_b=
ool),
> +       fsparam_flag("volatile",            Opt_volatile),
> +       {}
> +};
> +
> +#define OVL_METACOPY_SET       BIT(0)
> +#define OVL_REDIRECT_SET       BIT(1)
> +#define OVL_NFS_EXPORT_SET     BIT(2)
> +#define OVL_INDEX_SET          BIT(3)
> +
> +struct ovl_fs_context {
> +       u8 set;
> +};
> +
>  static struct dentry *ovl_d_real(struct dentry *dentry,
>                                  const struct inode *inode)
>  {
> @@ -243,7 +318,6 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>         kfree(ofs->config.lowerdir);
>         kfree(ofs->config.upperdir);
>         kfree(ofs->config.workdir);
> -       kfree(ofs->config.redirect_mode);
>         if (ofs->creator_cred)
>                 put_cred(ofs->creator_cred);
>         kfree(ofs);
> @@ -253,7 +327,8 @@ static void ovl_put_super(struct super_block *sb)
>  {
>         struct ovl_fs *ofs =3D sb->s_fs_info;
>
> -       ovl_free_fs(ofs);
> +       if (ofs)
> +               ovl_free_fs(ofs);
>  }
>
>  /* Sync real dirty inodes in upper filesystem (if it exists) */
> @@ -357,6 +432,7 @@ static int ovl_show_options(struct seq_file *m, struc=
t dentry *dentry)
>  {
>         struct super_block *sb =3D dentry->d_sb;
>         struct ovl_fs *ofs =3D sb->s_fs_info;
> +       const char *redirect_mode;
>
>         seq_show_option(m, "lowerdir", ofs->config.lowerdir);
>         if (ofs->config.upperdir) {
> @@ -365,8 +441,9 @@ static int ovl_show_options(struct seq_file *m, struc=
t dentry *dentry)
>         }
>         if (ofs->config.default_permissions)
>                 seq_puts(m, ",default_permissions");
> -       if (strcmp(ofs->config.redirect_mode, ovl_redirect_mode_def()) !=
=3D 0)
> -               seq_printf(m, ",redirect_dir=3D%s", ofs->config.redirect_=
mode);
> +       redirect_mode =3D ovl_redirect_mode(&ofs->config);
> +       if (strcmp(redirect_mode, ovl_redirect_mode_def()) !=3D 0)
> +               seq_printf(m, ",redirect_dir=3D%s", redirect_mode);
>         if (ofs->config.index !=3D ovl_index_def)
>                 seq_printf(m, ",index=3D%s", ofs->config.index ? "on" : "=
off");
>         if (!ofs->config.uuid)
> @@ -386,27 +463,6 @@ static int ovl_show_options(struct seq_file *m, stru=
ct dentry *dentry)
>         return 0;
>  }
>
> -static int ovl_remount(struct super_block *sb, int *flags, char *data)
> -{
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> -       struct super_block *upper_sb;
> -       int ret =3D 0;
> -
> -       if (!(*flags & SB_RDONLY) && ovl_force_readonly(ofs))
> -               return -EROFS;
> -
> -       if (*flags & SB_RDONLY && !sb_rdonly(sb)) {
> -               upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
> -               if (ovl_should_sync(ofs)) {
> -                       down_read(&upper_sb->s_umount);
> -                       ret =3D sync_filesystem(upper_sb);
> -                       up_read(&upper_sb->s_umount);
> -               }
> -       }
> -
> -       return ret;
> -}

Moving code around and changing it at the same time makes
reviewing very hard. I undid the move in my patch.
If you want to rearrange the functions in the file afterwards
I don't mind.

> -
>  static const struct super_operations ovl_super_operations =3D {
>         .alloc_inode    =3D ovl_alloc_inode,
>         .free_inode     =3D ovl_free_inode,
> @@ -416,216 +472,42 @@ static const struct super_operations ovl_super_ope=
rations =3D {
>         .sync_fs        =3D ovl_sync_fs,
>         .statfs         =3D ovl_statfs,
>         .show_options   =3D ovl_show_options,
> -       .remount_fs     =3D ovl_remount,
> -};
> -
> -enum {
> -       OPT_LOWERDIR,
> -       OPT_UPPERDIR,
> -       OPT_WORKDIR,
> -       OPT_DEFAULT_PERMISSIONS,
> -       OPT_REDIRECT_DIR,
> -       OPT_INDEX_ON,
> -       OPT_INDEX_OFF,
> -       OPT_UUID_ON,
> -       OPT_UUID_OFF,
> -       OPT_NFS_EXPORT_ON,
> -       OPT_USERXATTR,
> -       OPT_NFS_EXPORT_OFF,
> -       OPT_XINO_ON,
> -       OPT_XINO_OFF,
> -       OPT_XINO_AUTO,
> -       OPT_METACOPY_ON,
> -       OPT_METACOPY_OFF,
> -       OPT_VOLATILE,
> -       OPT_ERR,
> -};
> -
> -static const match_table_t ovl_tokens =3D {
> -       {OPT_LOWERDIR,                  "lowerdir=3D%s"},
> -       {OPT_UPPERDIR,                  "upperdir=3D%s"},
> -       {OPT_WORKDIR,                   "workdir=3D%s"},
> -       {OPT_DEFAULT_PERMISSIONS,       "default_permissions"},
> -       {OPT_REDIRECT_DIR,              "redirect_dir=3D%s"},
> -       {OPT_INDEX_ON,                  "index=3Don"},
> -       {OPT_INDEX_OFF,                 "index=3Doff"},
> -       {OPT_USERXATTR,                 "userxattr"},
> -       {OPT_UUID_ON,                   "uuid=3Don"},
> -       {OPT_UUID_OFF,                  "uuid=3Doff"},
> -       {OPT_NFS_EXPORT_ON,             "nfs_export=3Don"},
> -       {OPT_NFS_EXPORT_OFF,            "nfs_export=3Doff"},
> -       {OPT_XINO_ON,                   "xino=3Don"},
> -       {OPT_XINO_OFF,                  "xino=3Doff"},
> -       {OPT_XINO_AUTO,                 "xino=3Dauto"},
> -       {OPT_METACOPY_ON,               "metacopy=3Don"},
> -       {OPT_METACOPY_OFF,              "metacopy=3Doff"},
> -       {OPT_VOLATILE,                  "volatile"},
> -       {OPT_ERR,                       NULL}
>  };
>
> -static char *ovl_next_opt(char **s)
> +static int ovl_set_redirect_mode(struct ovl_config *config)
>  {
> -       char *sbegin =3D *s;
> -       char *p;
> -
> -       if (sbegin =3D=3D NULL)
> -               return NULL;
> -
> -       for (p =3D sbegin; *p; p++) {
> -               if (*p =3D=3D '\\') {
> -                       p++;
> -                       if (!*p)
> -                               break;
> -               } else if (*p =3D=3D ',') {
> -                       *p =3D '\0';
> -                       *s =3D p + 1;
> -                       return sbegin;
> -               }
> -       }
> -       *s =3D NULL;
> -       return sbegin;
> -}
> -
> -static int ovl_parse_redirect_mode(struct ovl_config *config, const char=
 *mode)
> -{
> -       if (strcmp(mode, "on") =3D=3D 0) {
> +       switch (config->redirect_mode) {
> +       case OVL_REDIRECT_DIR_ON:
>                 config->redirect_dir =3D true;
>                 /*
>                  * Does not make sense to have redirect creation without
>                  * redirect following.
>                  */
>                 config->redirect_follow =3D true;
> -       } else if (strcmp(mode, "follow") =3D=3D 0) {
> +               return 0;
> +       case OVL_REDIRECT_DIR_FOLLOW:
>                 config->redirect_follow =3D true;
> -       } else if (strcmp(mode, "off") =3D=3D 0) {
> +               return 0;
> +       case OVL_REDIRECT_DIR_OFF:
>                 if (ovl_redirect_always_follow)
>                         config->redirect_follow =3D true;
> -       } else if (strcmp(mode, "nofollow") !=3D 0) {
> -               pr_err("bad mount option \"redirect_dir=3D%s\"\n",
> -                      mode);
> -               return -EINVAL;
> +               return 0;
> +       case OVL_REDIRECT_DIR_NOFOLLOW:
> +               return 0;
>         }
>
> -       return 0;
> +       pr_err("invalid \"redirect_dir\" mount option\n");
> +       return -EINVAL;
>  }
>
> -static int ovl_parse_opt(char *opt, struct ovl_config *config)
> +static int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
> +                               struct ovl_config *config)
>  {
> -       char *p;
>         int err;
> -       bool metacopy_opt =3D false, redirect_opt =3D false;
> -       bool nfs_export_opt =3D false, index_opt =3D false;
> -
> -       config->redirect_mode =3D kstrdup(ovl_redirect_mode_def(), GFP_KE=
RNEL);
> -       if (!config->redirect_mode)
> -               return -ENOMEM;
> -
> -       while ((p =3D ovl_next_opt(&opt)) !=3D NULL) {
> -               int token;
> -               substring_t args[MAX_OPT_ARGS];
> -
> -               if (!*p)
> -                       continue;
> -
> -               token =3D match_token(p, ovl_tokens, args);
> -               switch (token) {
> -               case OPT_UPPERDIR:
> -                       kfree(config->upperdir);
> -                       config->upperdir =3D match_strdup(&args[0]);
> -                       if (!config->upperdir)
> -                               return -ENOMEM;
> -                       break;
> -
> -               case OPT_LOWERDIR:
> -                       kfree(config->lowerdir);
> -                       config->lowerdir =3D match_strdup(&args[0]);
> -                       if (!config->lowerdir)
> -                               return -ENOMEM;
> -                       break;
> -
> -               case OPT_WORKDIR:
> -                       kfree(config->workdir);
> -                       config->workdir =3D match_strdup(&args[0]);
> -                       if (!config->workdir)
> -                               return -ENOMEM;
> -                       break;
> -
> -               case OPT_DEFAULT_PERMISSIONS:
> -                       config->default_permissions =3D true;
> -                       break;
> -
> -               case OPT_REDIRECT_DIR:
> -                       kfree(config->redirect_mode);
> -                       config->redirect_mode =3D match_strdup(&args[0]);
> -                       if (!config->redirect_mode)
> -                               return -ENOMEM;
> -                       redirect_opt =3D true;
> -                       break;
> -
> -               case OPT_INDEX_ON:
> -                       config->index =3D true;
> -                       index_opt =3D true;
> -                       break;
> -
> -               case OPT_INDEX_OFF:
> -                       config->index =3D false;
> -                       index_opt =3D true;
> -                       break;
> -
> -               case OPT_UUID_ON:
> -                       config->uuid =3D true;
> -                       break;
> -
> -               case OPT_UUID_OFF:
> -                       config->uuid =3D false;
> -                       break;
> -
> -               case OPT_NFS_EXPORT_ON:
> -                       config->nfs_export =3D true;
> -                       nfs_export_opt =3D true;
> -                       break;
> -
> -               case OPT_NFS_EXPORT_OFF:
> -                       config->nfs_export =3D false;
> -                       nfs_export_opt =3D true;
> -                       break;
> -
> -               case OPT_XINO_ON:
> -                       config->xino =3D OVL_XINO_ON;
> -                       break;
> -
> -               case OPT_XINO_OFF:
> -                       config->xino =3D OVL_XINO_OFF;
> -                       break;
> -
> -               case OPT_XINO_AUTO:
> -                       config->xino =3D OVL_XINO_AUTO;
> -                       break;
> -
> -               case OPT_METACOPY_ON:
> -                       config->metacopy =3D true;
> -                       metacopy_opt =3D true;
> -                       break;
> -
> -               case OPT_METACOPY_OFF:
> -                       config->metacopy =3D false;
> -                       metacopy_opt =3D true;
> -                       break;
> -
> -               case OPT_VOLATILE:
> -                       config->ovl_volatile =3D true;
> -                       break;
> -
> -               case OPT_USERXATTR:
> -                       config->userxattr =3D true;
> -                       break;
> -
> -               default:
> -                       pr_err("unrecognized mount option \"%s\" or missi=
ng value\n",
> -                                       p);
> -                       return -EINVAL;
> -               }
> -       }
> +       bool metacopy_opt =3D ctx->set & OVL_METACOPY_SET;
> +       bool redirect_opt =3D ctx->set & OVL_REDIRECT_SET;
> +       bool nfs_export_opt =3D ctx->set & OVL_NFS_EXPORT_SET;
> +       bool index_opt =3D ctx->set & OVL_INDEX_SET;
>
>         /* Workdir/index are useless in non-upper mount */
>         if (!config->upperdir) {
> @@ -647,7 +529,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config=
 *config)
>                 config->ovl_volatile =3D false;
>         }
>
> -       err =3D ovl_parse_redirect_mode(config, config->redirect_mode);
> +       err =3D ovl_set_redirect_mode(config);
>         if (err)
>                 return err;
>
> @@ -662,7 +544,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config=
 *config)
>         if (config->metacopy && !config->redirect_dir) {
>                 if (metacopy_opt && redirect_opt) {
>                         pr_err("conflicting options: metacopy=3Don,redire=
ct_dir=3D%s\n",
> -                              config->redirect_mode);
> +                              ovl_redirect_mode(config));
>                         return -EINVAL;
>                 }
>                 if (redirect_opt) {
> @@ -671,7 +553,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config=
 *config)
>                          * in this conflict.
>                          */
>                         pr_info("disabling metacopy due to redirect_dir=
=3D%s\n",
> -                               config->redirect_mode);
> +                               ovl_redirect_mode(config));
>                         config->metacopy =3D false;
>                 } else {
>                         /* Automatically enable redirect otherwise. */
> @@ -728,7 +610,7 @@ static int ovl_parse_opt(char *opt, struct ovl_config=
 *config)
>         if (config->userxattr) {
>                 if (config->redirect_follow && redirect_opt) {
>                         pr_err("conflicting options: userxattr,redirect_d=
ir=3D%s\n",
> -                              config->redirect_mode);
> +                              ovl_redirect_mode(config));
>                         return -EINVAL;
>                 }
>                 if (config->metacopy && metacopy_opt) {
> @@ -1926,12 +1808,128 @@ static struct dentry *ovl_get_root(struct super_=
block *sb,
>         return root;
>  }
>
> -static int ovl_fill_super(struct super_block *sb, void *data, int silent=
)
> +static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *p=
aram)
> +{
> +       int err =3D 0;
> +       struct fs_parse_result result;
> +       struct ovl_fs *ofs =3D fc->s_fs_info;
> +       struct ovl_config *config =3D &ofs->config;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       char *dup;
> +       int opt;
> +
> +       /*
> +        * On remount overlayfs has always ignored all mount options no
> +        * matter if malformed or not so for backwards compatibility we
> +        * do the same here.
> +        */
> +       if (fc->purpose =3D=3D FS_CONTEXT_FOR_RECONFIGURE)
> +               return 0;
> +
> +       opt =3D fs_parse(fc, ovl_parameter_spec, param, &result);
> +       if (opt < 0)
> +               return opt;
> +
> +       switch (opt) {
> +       case Opt_lowerdir:
> +               dup =3D kstrdup(param->string, GFP_KERNEL);
> +               if (!dup) {
> +                       err =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               kfree(config->lowerdir);
> +               config->lowerdir =3D dup;
> +               break;
> +       case Opt_upperdir:
> +               dup =3D kstrdup(param->string, GFP_KERNEL);
> +               if (!dup) {
> +                       err =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               kfree(config->upperdir);
> +               config->upperdir =3D dup;
> +               break;
> +       case Opt_workdir:
> +               dup =3D kstrdup(param->string, GFP_KERNEL);
> +               if (!dup) {
> +                       err =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               kfree(config->workdir);
> +               config->workdir =3D dup;
> +               break;
> +       case Opt_default_permissions:
> +               config->default_permissions =3D true;
> +               break;
> +       case Opt_index:
> +               config->index =3D result.uint_32;
> +               ctx->set |=3D OVL_INDEX_SET;
> +               break;
> +       case Opt_uuid:
> +               config->uuid =3D result.uint_32;
> +               break;
> +       case Opt_nfs_export:
> +               config->nfs_export =3D result.uint_32;
> +               ctx->set |=3D OVL_NFS_EXPORT_SET;
> +               break;
> +       case Opt_metacopy:
> +               config->metacopy =3D result.uint_32;
> +               ctx->set |=3D OVL_METACOPY_SET;
> +               break;
> +       case Opt_userxattr:
> +               config->userxattr =3D true;
> +               break;
> +       case Opt_volatile:
> +               config->ovl_volatile =3D true;
> +               break;
> +       case Opt_xino:
> +               config->xino =3D result.uint_32;
> +               break;
> +       case Opt_redirect_dir:
> +               config->redirect_mode =3D result.uint_32;
> +               ctx->set |=3D OVL_REDIRECT_SET;
> +               break;
> +       default:
> +               pr_err("unrecognized mount option \"%s\" or missing value=
\n", param->key);
> +               return -EINVAL;
> +       }
> +
> +       return err;
> +}
> +
> +
> +static int ovl_reconfigure(struct fs_context *fc)
>  {
> -       struct path upperpath =3D { };
> +       struct super_block *sb =3D fc->root->d_sb;
> +       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct super_block *upper_sb;
> +       int ret =3D 0;
> +
> +       if (!(fc->sb_flags & SB_RDONLY) && ovl_force_readonly(ofs))
> +               return -EROFS;
> +
> +       if (fc->sb_flags & SB_RDONLY && !sb_rdonly(sb)) {
> +               upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
> +               if (ovl_should_sync(ofs)) {
> +                       down_read(&upper_sb->s_umount);
> +                       ret =3D sync_filesystem(upper_sb);
> +                       up_read(&upper_sb->s_umount);
> +               }
> +       }
> +
> +       return ret;
> +}
> +
> +static int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct path upperpath =3D {};
>         struct dentry *root_dentry;
>         struct ovl_entry *oe;
> -       struct ovl_fs *ofs;
>         struct ovl_layer *layers;
>         struct cred *cred;
>         char *splitlower =3D NULL;
> @@ -1939,36 +1937,24 @@ static int ovl_fill_super(struct super_block *sb,=
 void *data, int silent)
>         int err;
>
>         err =3D -EIO;
> -       if (WARN_ON(sb->s_user_ns !=3D current_user_ns()))
> -               goto out;
> +       if (WARN_ON(fc->user_ns !=3D current_user_ns()))
> +               goto out_err;
>
> +       ofs->share_whiteout =3D true;
>         sb->s_d_op =3D &ovl_dentry_operations;
>
> -       err =3D -ENOMEM;
> -       ofs =3D kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
> -       if (!ofs)
> -               goto out;
> -
>         err =3D -ENOMEM;
>         ofs->creator_cred =3D cred =3D prepare_creds();
>         if (!cred)
>                 goto out_err;
>
> -       /* Is there a reason anyone would want not to share whiteouts? */
> -       ofs->share_whiteout =3D true;
> -
> -       ofs->config.index =3D ovl_index_def;
> -       ofs->config.uuid =3D true;
> -       ofs->config.nfs_export =3D ovl_nfs_export_def;
> -       ofs->config.xino =3D ovl_xino_def();
> -       ofs->config.metacopy =3D ovl_metacopy_def;
> -       err =3D ovl_parse_opt((char *) data, &ofs->config);
> +       err =3D ovl_fs_params_verify(ctx, &ofs->config);
>         if (err)
>                 goto out_err;
>
>         err =3D -EINVAL;
>         if (!ofs->config.lowerdir) {
> -               if (!silent)
> +               if (fc->sb_flags & SB_SILENT)

Test is negated here.
I fixed it in my branch.
No need to re-send.

>                         pr_err("missing 'lowerdir'\n");
>                 goto out_err;
>         }
> @@ -2113,25 +2099,90 @@ static int ovl_fill_super(struct super_block *sb,=
 void *data, int silent)
>  out_free_oe:
>         ovl_free_entry(oe);
>  out_err:
> -       kfree(splitlower);
> -       path_put(&upperpath);
> -       ovl_free_fs(ofs);
> -out:

Folded your fix here:
       ovl_free_fs(ofs);
       sb->s_fs_info =3D NULL;

>         return err;
>  }
>

Thanks,
Amir.
