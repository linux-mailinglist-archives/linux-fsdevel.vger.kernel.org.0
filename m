Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF572A30C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjFITZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFITZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:25:35 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909F22D44;
        Fri,  9 Jun 2023 12:25:33 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-43b28436ebeso678660137.0;
        Fri, 09 Jun 2023 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686338732; x=1688930732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBra/qzyTdtrjEzBurj/Y1p0fLBfDamv12ytilgO8qo=;
        b=H2oYIl5aPxAv620NjOPW60zKkE/no3QNPNQD/+AT0K44v1ppGWGxnfhG4bG3Kf8lbf
         mOpiAnutaizeJwDT7pPI13f1rLuV94PnXwxAaex5lH10wdiG/JQMWjgQbkLbU45Hx6tX
         7daOdvlcOYFcDaeG3yA0pBGYAFIOt+onTNnWOB+wFzNfhQgEojBG0ZBYII73uowe2VAT
         H/Jj9jfIk/vaueehi0/85HS4TqFJPMXPVXfFa3AczbH236PzozmHmdr1ryYHLKHEhR62
         bujZtIkbj3y+5uuMSvZtYP6w0TgbyrLBGmVUnEAXIifGxmYnH/Vw5WCfpNHUBc9uF6l0
         0uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686338732; x=1688930732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBra/qzyTdtrjEzBurj/Y1p0fLBfDamv12ytilgO8qo=;
        b=eEaeD2U5YQGnkx9wh/jbtPHRzXsaujOiSzyc+zMUQZ1YU8RT8jOSqns4IY9134IzOm
         jvMCnk2ZU+ZCd9hFP1P/j4Y49ppRukER71W6xMW7HwfnDoWAXfq3/FJs1XTk6uvyMNqt
         ztQcPFse2P0aRY8DWss/ERRUdSBC/xTWZ9ccwGbcCmoDAs2W98F/p8jgtvyNIb6pqaL5
         MiRXp+jow81ZrY5idhNvl+Aqk7IVNHX3Q/aM8WM3FMxOCbJ0/O7bISAD6GhHNKN63M1Z
         FvK7WTuOng4WCKNNccTxecmy4kYXUUK191RehlLJY8VyaljiFTf6XRM7vRsPFHh0vEoD
         RI5w==
X-Gm-Message-State: AC+VfDwPGY9l7eNKyvqiZO+a17IRGbWxjoFSTXtqjKktxtGK5/aR3e4s
        1bHKl+htXBeTWk/qASkMuL6tUobjGDdCmIbolu8=
X-Google-Smtp-Source: ACHHUZ75Vs1z/t6aapDEebauLBiFRtZTkcHgmOZoEk5gKHrIc6/bXNAoLghbvyqkV+QdRPL8H+a+8THhzaOWTUglpDI=
X-Received: by 2002:a67:ee10:0:b0:43b:298f:ed6e with SMTP id
 f16-20020a67ee10000000b0043b298fed6emr1731289vsp.30.1686338732313; Fri, 09
 Jun 2023 12:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org> <20230605-fs-overlayfs-mount_api-v2-1-3da91c97e0c0@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v2-1-3da91c97e0c0@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 22:25:21 +0300
Message-ID: <CAOQ4uxge44J1SCF6YiscchB0SjfcqPXf8wQfNuVBfCh6dU5rXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ovl: port to new mount api
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

On Fri, Jun 9, 2023 at 6:42=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
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
>  fs/overlayfs/super.c | 515 ++++++++++++++++++++++++++++-----------------=
------
>  1 file changed, 279 insertions(+), 236 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index f97ad8b40dbb..ceaf05743f45 100644
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
> @@ -67,6 +69,59 @@ module_param_named(metacopy, ovl_metacopy_def, bool, 0=
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
> +static const struct fs_parameter_spec ovl_parameter_spec[] =3D {
> +       fsparam_string("lowerdir",          Opt_lowerdir),
> +       fsparam_string("upperdir",          Opt_upperdir),
> +       fsparam_string("workdir",           Opt_workdir),
> +       fsparam_flag("default_permissions", Opt_default_permissions),
> +       fsparam_enum("redirect_dir",        Opt_redirect_dir, ovl_paramet=
er_bool),
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
>  static void ovl_dentry_release(struct dentry *dentry)
>  {
>         struct ovl_entry *oe =3D dentry->d_fsdata;
> @@ -394,27 +449,6 @@ static int ovl_show_options(struct seq_file *m, stru=
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
> -
>  static const struct super_operations ovl_super_operations =3D {
>         .alloc_inode    =3D ovl_alloc_inode,
>         .free_inode     =3D ovl_free_inode,
> @@ -424,76 +458,8 @@ static const struct super_operations ovl_super_opera=
tions =3D {
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
> -{
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
>  static int ovl_parse_redirect_mode(struct ovl_config *config, const char=
 *mode)
>  {
>         if (strcmp(mode, "on") =3D=3D 0) {
> @@ -517,123 +483,14 @@ static int ovl_parse_redirect_mode(struct ovl_conf=
ig *config, const char *mode)
>         return 0;
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
> +       bool metacopy_opt =3D ctx->set & OVL_METACOPY_SET,
> +            redirect_opt =3D ctx->set & OVL_REDIRECT_SET;
> +       bool nfs_export_opt =3D ctx->set & OVL_NFS_EXPORT_SET,
> +            index_opt =3D ctx->set & OVL_INDEX_SET;

Nit: please split lines here.

>
>         /* Workdir/index are useless in non-upper mount */
>         if (!config->upperdir) {
> @@ -1882,12 +1739,143 @@ static struct dentry *ovl_get_root(struct super_=
block *sb,
>         return root;
>  }
>
> -static int ovl_fill_super(struct super_block *sb, void *data, int silent=
)
> +static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *p=
aram)
>  {
> -       struct path upperpath =3D { };
> +       int err =3D 0;
> +       struct fs_parse_result result;
> +       struct ovl_fs *ofs =3D fc->s_fs_info;
> +       struct ovl_config *config =3D &ofs->config;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct path path;
> +       char *dup;
> +       int opt;
> +       char *sval;
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
> +                       path_put(&path);
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
> +                       path_put(&path);
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
> +                       path_put(&path);
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
> +               if (result.uint_32 =3D=3D true)
> +                       sval =3D kstrdup("on", GFP_KERNEL);
> +               else
> +                       sval =3D kstrdup("off", GFP_KERNEL);
> +               if (!sval) {
> +                       err =3D -ENOMEM;
> +                       break;
> +               }
> +
> +               kfree(config->redirect_mode);
> +               config->redirect_mode =3D sval;
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


For the end result, all these functions above should be in params.c
I don't mind if you move it with an extra patch at the beginning
Probably easier at the end. Just as long as you do not move
ovl_fs_params_verify() in the same patch that changes half of it.

Thanks,
Amir.
