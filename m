Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F93F72A372
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjFITwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFITwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:52:49 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9BC2720;
        Fri,  9 Jun 2023 12:52:46 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-43c1e5978e4so685467137.1;
        Fri, 09 Jun 2023 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686340365; x=1688932365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8lehw6HvMxtozABe9kCYX+I+ypvTOcIvgqM03LMzKM=;
        b=C9txNQgyV9Vs4kN+PYaH1yy7jXi3eTpziYWxxcqSbAhjsfQd4Sc9CBZ8+D4HFMLb+q
         0wev7hUKdACFaCkeSlup1Gng/6vyy1vcgjajkKjOWhpa6StvJWooYjpRR/KQJrEAQEPL
         S3M58o4PRSZzhOWvysVzYZN2DQZQ4iIIFZhWxXlOHqUDkpDB5OrmSWooaErSKMdbTgqk
         UymF5FZRHOnkGZbsLltpJJBbAdaaofYBxLIfET5MsHepEVC05io6meZQXP4QiqLYGWdJ
         Btb0NP62GEbU2F8gqGQ6i/oweySxw+swEKKzpUDfovXqlDwFfD4OZoF3fEyZP7uvhbQP
         Q7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686340365; x=1688932365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8lehw6HvMxtozABe9kCYX+I+ypvTOcIvgqM03LMzKM=;
        b=RlVIzMNaMMyT6PB+4I+bBPv6OR2aWWiQmopUNuIDxX3rTCAlUEttPyNIizgNFl0/cz
         htiJawU3b8C4sDKvYrzKNwzKEO9zfxx8iZCW11cZF+ATAhw641Ow3JV5mhNO+uWU06SA
         INUTzWCBBCRjU1DpWIYTfjBgfTI2cGn8/yiUsSHzeGG/ZBLHk4BPKxSKCfxvXHtK6oYh
         3m7gvccZ5ZDiahqQai4mG/PaOfQ3ghpzwaeMpsVUVQ59kzHRxVRo0f2+EKUbkgQLJOjQ
         DUyCS53Z58dRsYr5xxzj6HuBU0rN0+TKS6rE+m27aHNdJ7hORXAQe3hB53kRZBCNC/oX
         yo+Q==
X-Gm-Message-State: AC+VfDzGgHnz6qDJ4M52sGtGp9IsRhS3ENxl152RWOwSRuD8/W82pphr
        4Bg2TuM2y0FLe4EsmbGiWfvJU/6li83q8Veiq8IrzsLNY0E=
X-Google-Smtp-Source: ACHHUZ5WHXWOMqb8PY0rhdcCWzEr5scpA1uSluUyyUfq9ct2H6J1P9M+8JJ7dCxPV/uMPHS+XyT9Mh/jFbELOUBDvTY=
X-Received: by 2002:a05:6102:102:b0:436:c33:a96e with SMTP id
 z2-20020a056102010200b004360c33a96emr1804246vsq.24.1686340364978; Fri, 09 Jun
 2023 12:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v2-0-3da91c97e0c0@kernel.org> <20230605-fs-overlayfs-mount_api-v2-2-3da91c97e0c0@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v2-2-3da91c97e0c0@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 9 Jun 2023 22:52:33 +0300
Message-ID: <CAOQ4uxhE18yduSTF1tvv_J_zCjVQgWd_6ySuX6RF_rU_qwb5Rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ovl: modify layer parameter parsing
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 9, 2023 at 6:42=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> We ran into issues where mount(8) passed multiple lower layers as one
> big string through fsconfig(). But the fsconfig() FSCONFIG_SET_STRING
> option is limited to 256 bytes in strndup_user(). While this would be
> fixable by extending the fsconfig() buffer I'd rather encourage users to
> append layers via multiple fsconfig() calls as the interface allows
> nicely for this. This has also been requested as a feature before.
>
> With this port to the new mount api the following will be possible:
>
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", "/lower1", 0);
>
>         /* set upper layer */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "upperdir", "/upper", 0);
>
>         /* append "/lower2", "/lower3", and "/lower4" */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower2:/lower=
3:/lower4", 0);
>
>         /* turn index feature on */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "index", "on", 0);
>
>         /* append "/lower5" */
>         fsconfig(fs_fd, FSCONFIG_SET_STRING, "lowerdir", ":/lower5", 0);
>
> Specifying ':' would have been rejected so this isn't a regression. And
> we can't simply use "lowerdir=3D/lower" to append on top of existing
> layers as "lowerdir=3D/lower,lowerdir=3D/other-lower" would make
> "/other-lower" the only lower layer so we'd break uapi if we changed
> this. So the ':' prefix seems a good compromise.
>
> Users can choose to specify multiple layers at once or individual
> layers. A layer is appended if it starts with ":". This requires that
> the user has already added at least one layer before. If lowerdir is
> specified again without a leading ":" then all previous layers are
> dropped and replaced with the new layers. If lowerdir is specified and
> empty than all layers are simply dropped.
>
> An additional change is that overlayfs will now parse and resolve layers
> right when they are specified in fsconfig() instead of deferring until
> super block creation. This allows users to receive early errors.
>
> It also allows users to actually use up to 500 layers something which
> was theoretically possible but ended up not working due to the mount
> option string passed via mount(2) being too large.
>
> This also allows a more privileged process to set config options for a
> lesser privileged process as the creds for fsconfig() and the creds for
> fsopen() can differ. We could restrict that they match by enforcing that
> the creds of fsopen() and fsconfig() match but I don't see why that
> needs to be the case and allows for a good delegation mechanism.
>
> Plus, in the future it means we're able to extend overlayfs mount
> options and allow users to specify layers via file descriptors instead
> of paths:
>
>         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower1", dirfd);
>
>         /* append */
>         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower2", dirfd);
>
>         /* append */
>         fsconfig(FSCONFIG_SET_PATH{_EMPTY}, "lowerdir", "lower3", dirfd);
>
>         /* clear all layers specified until now */
>         fsconfig(FSCONFIG_SET_STRING, "lowerdir", NULL, 0);
>
> This would be especially nice if users create an overlayfs mount on top
> of idmapped layers or just in general private mounts created via
> open_tree(OPEN_TREE_CLONE). Those mounts would then never have to appear
> anywhere in the filesystem. But for now just do the minimal thing.
>
> We should probably aim to move more validation into ovl_fs_parse_param()
> so users get errors before fsconfig(FSCONFIG_CMD_CREATE). But that can
> be done in additional patches later.
>
> Link: https://github.com/util-linux/util-linux/issues/2287
> Link: https://github.com/util-linux/util-linux/issues/1992
> Link: https://bugs.archlinux.org/task/78702
> Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908=
c2108@brauner
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/Makefile       |   2 +-
>  fs/overlayfs/layer_params.c | 288 ++++++++++++++++++++++++++++++++++++++
>  fs/overlayfs/ovl_entry.h    |  30 ++++
>  fs/overlayfs/super.c        | 328 +++++++++++++++-----------------------=
------
>  4 files changed, 431 insertions(+), 217 deletions(-)
>
> diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
> index 9164c585eb2f..a3ad81c2e64e 100644
> --- a/fs/overlayfs/Makefile
> +++ b/fs/overlayfs/Makefile
> @@ -6,4 +6,4 @@
>  obj-$(CONFIG_OVERLAY_FS) +=3D overlay.o
>
>  overlay-objs :=3D super.o namei.o util.o inode.o file.o dir.o readdir.o =
\
> -               copy_up.o export.o
> +               copy_up.o export.o layer_params.o
> diff --git a/fs/overlayfs/layer_params.c b/fs/overlayfs/layer_params.c
> new file mode 100644
> index 000000000000..29907afc9d0d
> --- /dev/null
> +++ b/fs/overlayfs/layer_params.c

params.c please
and please move all the params parsing code here
not only the layers parsing.

> @@ -0,0 +1,288 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
> +#include <linux/posix_acl_xattr.h>
> +#include <linux/xattr.h>
> +#include "overlayfs.h"
> +
> +static size_t ovl_parse_param_split_lowerdirs(char *str)
> +{
> +       size_t ctr =3D 1;
> +       char *s, *d;
> +
> +       for (s =3D d =3D str;; s++, d++) {
> +               if (*s =3D=3D '\\') {
> +                       s++;
> +               } else if (*s =3D=3D ':') {
> +                       *d =3D '\0';
> +                       ctr++;
> +                       continue;
> +               }
> +               *d =3D *s;
> +               if (!*s)
> +                       break;
> +       }
> +       return ctr;
> +}
> +
> +static int ovl_mount_dir_noesc(const char *name, struct path *path)
> +{
> +       int err =3D -EINVAL;
> +
> +       if (!*name) {
> +               pr_err("empty lowerdir\n");
> +               goto out;
> +       }
> +       err =3D kern_path(name, LOOKUP_FOLLOW, path);
> +       if (err) {
> +               pr_err("failed to resolve '%s': %i\n", name, err);
> +               goto out;
> +       }
> +       err =3D -EINVAL;
> +       if (ovl_dentry_weird(path->dentry)) {
> +               pr_err("filesystem on '%s' not supported\n", name);
> +               goto out_put;
> +       }
> +       if (!d_is_dir(path->dentry)) {
> +               pr_err("'%s' not a directory\n", name);
> +               goto out_put;
> +       }
> +       return 0;
> +
> +out_put:
> +       path_put_init(path);
> +out:
> +       return err;
> +}
> +
> +static void ovl_unescape(char *s)
> +{
> +       char *d =3D s;
> +
> +       for (;; s++, d++) {
> +               if (*s =3D=3D '\\')
> +                       s++;
> +               *d =3D *s;
> +               if (!*s)
> +                       break;
> +       }
> +}
> +
> +static int ovl_mount_dir(const char *name, struct path *path)
> +{
> +       int err =3D -ENOMEM;
> +       char *tmp =3D kstrdup(name, GFP_KERNEL);
> +
> +       if (tmp) {
> +               ovl_unescape(tmp);
> +               err =3D ovl_mount_dir_noesc(tmp, path);
> +
> +               if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
> +                       pr_err("filesystem on '%s' not supported as upper=
dir\n",
> +                              tmp);
> +                       path_put_init(path);
> +                       err =3D -EINVAL;
> +               }
> +               kfree(tmp);
> +       }
> +       return err;
> +}
> +
> +int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> +                            bool workdir)
> +{
> +       int err;
> +       struct ovl_fs *ofs =3D fc->s_fs_info;
> +       struct ovl_config *config =3D &ofs->config;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct path path;
> +       char *dup;
> +
> +       err =3D ovl_mount_dir(name, &path);
> +       if (err)
> +               return err;
> +
> +       /*
> +        * Check whether upper path is read-only here to report failures
> +        * early. Don't forget to recheck when the superblock is created
> +        * as the mount attributes could change.
> +        */
> +       if (__mnt_is_readonly(path.mnt)) {
> +               path_put(&path);
> +               return -EINVAL;
> +       }
> +
> +       dup =3D kstrdup(name, GFP_KERNEL);
> +       if (!dup) {
> +               path_put(&path);
> +               return -ENOMEM;
> +       }
> +
> +       if (workdir) {
> +               kfree(config->workdir);
> +               config->workdir =3D dup;
> +               path_put(&ctx->work);
> +               ctx->work =3D path;
> +       } else {
> +               kfree(config->upperdir);
> +               config->upperdir =3D dup;
> +               path_put(&ctx->upper);
> +               ctx->upper =3D path;
> +       }
> +       return 0;
> +}
> +
> +void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
> +{
> +       for (size_t nr =3D 0; nr < ctx->nr; nr++) {
> +               path_put(&ctx->lower[nr].path);
> +               kfree(ctx->lower[nr].name);
> +               ctx->lower[nr].name =3D NULL;
> +       }
> +       ctx->nr =3D 0;
> +}
> +
> +/*
> + * Parse lowerdir=3D mount option:
> + *
> + * (1) lowerdir=3D/lower1:/lower2:/lower3
> + *     Set "/lower1", "/lower2", and "/lower3" as lower layers. Any
> + *     existing lower layers are replaced.
> + * (2) lowerdir=3D:/lower4
> + *     Append "/lower4" to current stack of lower layers. This requires
> + *     that there already is at least one lower layer configured.
> + */
> +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
> +{
> +       int err;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct ovl_fs_context_layer *l;
> +       char *dup =3D NULL, *dup_iter;
> +       size_t nr_lower =3D 0, nr =3D 0;
> +       bool append =3D false;
> +
> +       /* Enforce that users are forced to specify a single ':'. */
> +       if (strncmp(name, "::", 2) =3D=3D 0)
> +               return -EINVAL;
> +
> +       /*
> +        * Ensure we're backwards compatible with mount(2)
> +        * by allowing relative paths.
> +        */
> +
> +       /* drop all existing lower layers */
> +       if (!*name) {
> +               ovl_parse_param_drop_lowerdir(ctx);
> +               return 0;
> +       }
> +
> +       if (*name =3D=3D ':') {
> +               /*
> +                * If users want to append a layer enforce that they
> +                * have already specified a first layer before. It's
> +                * better to be strict.
> +                */
> +               if (ctx->nr =3D=3D 0)
> +                       return -EINVAL;
> +
> +               /*
> +                * Drop the leading. We'll create the final mount option
> +                * string for the lower layers when we create the superbl=
ock.
> +                */
> +               name++;
> +               append =3D true;
> +       }
> +
> +       dup =3D kstrdup(name, GFP_KERNEL);
> +       if (!dup)
> +               return -ENOMEM;
> +
> +       err =3D -EINVAL;
> +       nr_lower =3D ovl_parse_param_split_lowerdirs(dup);
> +       if ((nr_lower > OVL_MAX_STACK) ||
> +           (append && (size_add(ctx->nr, nr_lower) > OVL_MAX_STACK))) {
> +               pr_err("too many lower directories, limit is %d\n", OVL_M=
AX_STACK);
> +               goto out_err;
> +       }
> +
> +       if (!append)
> +               ovl_parse_param_drop_lowerdir(ctx);
> +
> +       /*
> +        * (1) append
> +        *
> +        * We want nr <=3D nr_lower <=3D capacity We know nr > 0 and nr <=
=3D
> +        * capacity. If nr =3D=3D 0 this wouldn't be append. If nr +
> +        * nr_lower is <=3D capacity then nr <=3D nr_lower <=3D capacity
> +        * already holds. If nr + nr_lower exceeds capacity, we realloc.
> +        *
> +        * (2) replace
> +        *
> +        * Ensure we're backwards compatible with mount(2) which allows
> +        * "lowerdir=3D/a:/b:/c,lowerdir=3D/d:/e:/f" causing the last
> +        * specified lowerdir mount option to win.
> +        *
> +        * We want nr <=3D nr_lower <=3D capacity We know either (i) nr =
=3D=3D 0
> +        * or (ii) nr > 0. We also know nr_lower > 0. The capacity
> +        * could've been changed multiple times already so we only know
> +        * nr <=3D capacity. If nr + nr_lower > capacity we realloc,
> +        * otherwise nr <=3D nr_lower <=3D capacity holds already.
> +        */
> +       nr_lower +=3D ctx->nr;
> +       if (nr_lower > ctx->capacity) {
> +               err =3D -ENOMEM;
> +               l =3D krealloc_array(ctx->lower, nr_lower, sizeof(*ctx->l=
ower),
> +                                  GFP_KERNEL_ACCOUNT);
> +               if (!l)
> +                       goto out_err;
> +
> +               ctx->lower =3D l;
> +               ctx->capacity =3D nr_lower;
> +       }
> +
> +       /* By (1) and (2) we know nr <=3D nr_lower <=3D capacity. */
> +       dup_iter =3D dup;
> +       for (nr =3D ctx->nr; nr < nr_lower; nr++) {
> +               l =3D &ctx->lower[nr];
> +
> +               err =3D ovl_mount_dir_noesc(dup_iter, &l->path);
> +               if (err)
> +                       goto out_put;
> +
> +               err =3D -ENOMEM;
> +               l->name =3D kstrdup(dup_iter, GFP_KERNEL_ACCOUNT);
> +               if (!l->name)
> +                       goto out_put;
> +
> +               dup_iter =3D strchr(dup_iter, '\0') + 1;
> +       }
> +       ctx->nr =3D nr_lower;
> +       kfree(dup);
> +       return 0;
> +
> +out_put:
> +       /*
> +        * We know nr >=3D ctx->nr < nr_lower. If we failed somewhere
> +        * we want to undo until nr =3D=3D ctx->nr. This is correct for
> +        * both ctx->nr =3D=3D 0 and ctx->nr > 0.
> +        */
> +       for (; nr >=3D ctx->nr; nr--) {
> +               l =3D &ctx->lower[nr];
> +               kfree(l->name);
> +               l->name =3D NULL;
> +               path_put(&l->path);
> +
> +               /* don't overflow */
> +               if (nr =3D=3D 0)
> +                       break;
> +       }
> +
> +out_err:
> +       kfree(dup);
> +
> +       /* Intentionally don't realloc to a smaller size. */
> +       return err;
> +}
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index fd11fe6d6d45..269a9a6f177b 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -85,6 +85,36 @@ struct ovl_fs {
>         errseq_t errseq;
>  };
>
> +#define OVL_MAX_STACK 500
> +
> +struct ovl_fs_context_layer {
> +       char *name;
> +       struct path path;
> +};
> +
> +/*
> + * These options imply different behavior when they are explicitly
> + * specified than when they are left in their default state.
> + */
> +#define OVL_METACOPY_SET       BIT(0)
> +#define OVL_REDIRECT_SET       BIT(1)
> +#define OVL_NFS_EXPORT_SET     BIT(2)
> +#define OVL_INDEX_SET          BIT(3)
> +
> +struct ovl_fs_context {
> +       struct path upper;
> +       struct path work;
> +       size_t capacity;
> +       size_t nr;
> +       u8 set;
> +       struct ovl_fs_context_layer *lower;
> +};
> +
> +int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> +                            bool workdir);
> +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
> +void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
> +

Please move all this to overlayfs.h.
I don't think there is a good reason for it to be in this file.


>  static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
>  {
>         return ofs->layers[0].mnt;
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ceaf05743f45..35c61a1d0886 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -27,8 +27,6 @@ MODULE_LICENSE("GPL");
>
>  struct ovl_dir_cache;
>
> -#define OVL_MAX_STACK 500
> -
>  static bool ovl_redirect_dir_def =3D IS_ENABLED(CONFIG_OVERLAY_FS_REDIRE=
CT_DIR);
>  module_param_named(redirect_dir, ovl_redirect_dir_def, bool, 0644);
>  MODULE_PARM_DESC(redirect_dir,
> @@ -97,8 +95,11 @@ static const struct constant_table ovl_parameter_xino[=
] =3D {
>         {}
>  };
>
> +#define fsparam_string_empty(NAME, OPT) \
> +       __fsparam(fs_param_is_string, NAME, OPT, fs_param_can_be_empty, N=
ULL)
> +
>  static const struct fs_parameter_spec ovl_parameter_spec[] =3D {
> -       fsparam_string("lowerdir",          Opt_lowerdir),
> +       fsparam_string_empty("lowerdir",    Opt_lowerdir),
>         fsparam_string("upperdir",          Opt_upperdir),
>         fsparam_string("workdir",           Opt_workdir),
>         fsparam_flag("default_permissions", Opt_default_permissions),
> @@ -113,15 +114,6 @@ static const struct fs_parameter_spec ovl_parameter_=
spec[] =3D {
>         {}
>  };
>
> -#define OVL_METACOPY_SET       BIT(0)
> -#define OVL_REDIRECT_SET       BIT(1)
> -#define OVL_NFS_EXPORT_SET     BIT(2)
> -#define OVL_INDEX_SET          BIT(3)
> -
> -struct ovl_fs_context {
> -       u8 set;
> -};
> -
>  static void ovl_dentry_release(struct dentry *dentry)
>  {
>         struct ovl_entry *oe =3D dentry->d_fsdata;
> @@ -706,69 +698,6 @@ static struct dentry *ovl_workdir_create(struct ovl_=
fs *ofs,
>         goto out_unlock;
>  }
>
> -static void ovl_unescape(char *s)
> -{
> -       char *d =3D s;
> -
> -       for (;; s++, d++) {
> -               if (*s =3D=3D '\\')
> -                       s++;
> -               *d =3D *s;
> -               if (!*s)
> -                       break;
> -       }
> -}
> -
> -static int ovl_mount_dir_noesc(const char *name, struct path *path)
> -{
> -       int err =3D -EINVAL;
> -
> -       if (!*name) {
> -               pr_err("empty lowerdir\n");
> -               goto out;
> -       }
> -       err =3D kern_path(name, LOOKUP_FOLLOW, path);
> -       if (err) {
> -               pr_err("failed to resolve '%s': %i\n", name, err);
> -               goto out;
> -       }
> -       err =3D -EINVAL;
> -       if (ovl_dentry_weird(path->dentry)) {
> -               pr_err("filesystem on '%s' not supported\n", name);
> -               goto out_put;
> -       }
> -       if (!d_is_dir(path->dentry)) {
> -               pr_err("'%s' not a directory\n", name);
> -               goto out_put;
> -       }
> -       return 0;
> -
> -out_put:
> -       path_put_init(path);
> -out:
> -       return err;
> -}
> -
> -static int ovl_mount_dir(const char *name, struct path *path)
> -{
> -       int err =3D -ENOMEM;
> -       char *tmp =3D kstrdup(name, GFP_KERNEL);
> -
> -       if (tmp) {
> -               ovl_unescape(tmp);
> -               err =3D ovl_mount_dir_noesc(tmp, path);
> -
> -               if (!err && path->dentry->d_flags & DCACHE_OP_REAL) {
> -                       pr_err("filesystem on '%s' not supported as upper=
dir\n",
> -                              tmp);
> -                       path_put_init(path);
> -                       err =3D -EINVAL;
> -               }
> -               kfree(tmp);
> -       }
> -       return err;
> -}
> -
>  static int ovl_check_namelen(const struct path *path, struct ovl_fs *ofs=
,
>                              const char *name)
>  {
> @@ -789,10 +718,6 @@ static int ovl_lower_dir(const char *name, struct pa=
th *path,
>         int fh_type;
>         int err;
>
> -       err =3D ovl_mount_dir_noesc(name, path);
> -       if (err)
> -               return err;
> -
>         err =3D ovl_check_namelen(path, ofs, name);
>         if (err)
>                 return err;
> @@ -841,26 +766,6 @@ static bool ovl_workdir_ok(struct dentry *workdir, s=
truct dentry *upperdir)
>         return ok;
>  }
>
> -static unsigned int ovl_split_lowerdirs(char *str)
> -{
> -       unsigned int ctr =3D 1;
> -       char *s, *d;
> -
> -       for (s =3D d =3D str;; s++, d++) {
> -               if (*s =3D=3D '\\') {
> -                       s++;
> -               } else if (*s =3D=3D ':') {
> -                       *d =3D '\0';
> -                       ctr++;
> -                       continue;
> -               }
> -               *d =3D *s;
> -               if (!*s)
> -                       break;
> -       }
> -       return ctr;
> -}
> -
>  static int ovl_own_xattr_get(const struct xattr_handler *handler,
>                              struct dentry *dentry, struct inode *inode,
>                              const char *name, void *buffer, size_t size)
> @@ -961,15 +866,12 @@ static int ovl_report_in_use(struct ovl_fs *ofs, co=
nst char *name)
>  }
>
>  static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
> -                        struct ovl_layer *upper_layer, struct path *uppe=
rpath)
> +                        struct ovl_layer *upper_layer,
> +                        const struct path *upperpath)
>  {
>         struct vfsmount *upper_mnt;
>         int err;
>
> -       err =3D ovl_mount_dir(ofs->config.upperdir, upperpath);
> -       if (err)
> -               goto out;
> -
>         /* Upperdir path should not be r/o */
>         if (__mnt_is_readonly(upperpath->mnt)) {
>                 pr_err("upper fs is r/o, try multi-lower layers mount\n")=
;
> @@ -1256,46 +1158,37 @@ static int ovl_make_workdir(struct super_block *s=
b, struct ovl_fs *ofs,
>  }
>
>  static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
> -                          const struct path *upperpath)
> +                          const struct path *upperpath,
> +                          const struct path *workpath)
>  {
>         int err;
> -       struct path workpath =3D { };
> -
> -       err =3D ovl_mount_dir(ofs->config.workdir, &workpath);
> -       if (err)
> -               goto out;
>
>         err =3D -EINVAL;
> -       if (upperpath->mnt !=3D workpath.mnt) {
> +       if (upperpath->mnt !=3D workpath->mnt) {
>                 pr_err("workdir and upperdir must reside under the same m=
ount\n");
> -               goto out;
> +               return err;
>         }
> -       if (!ovl_workdir_ok(workpath.dentry, upperpath->dentry)) {
> +       if (!ovl_workdir_ok(workpath->dentry, upperpath->dentry)) {
>                 pr_err("workdir and upperdir must be separate subtrees\n"=
);
> -               goto out;
> +               return err;
>         }
>
> -       ofs->workbasedir =3D dget(workpath.dentry);
> +       ofs->workbasedir =3D dget(workpath->dentry);
>
>         if (ovl_inuse_trylock(ofs->workbasedir)) {
>                 ofs->workdir_locked =3D true;
>         } else {
>                 err =3D ovl_report_in_use(ofs, "workdir");
>                 if (err)
> -                       goto out;
> +                       return err;
>         }
>
>         err =3D ovl_setup_trap(sb, ofs->workbasedir, &ofs->workbasedir_tr=
ap,
>                              "workdir");
>         if (err)
> -               goto out;
> -
> -       err =3D ovl_make_workdir(sb, ofs, &workpath);
> -
> -out:
> -       path_put(&workpath);
> +               return err;
>
> -       return err;
> +       return ovl_make_workdir(sb, ofs, workpath);
>  }
>
>  static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
> @@ -1449,14 +1342,13 @@ static int ovl_get_fsid(struct ovl_fs *ofs, const=
 struct path *path)
>  }
>
>  static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> -                         struct path *stack, unsigned int numlower,
> -                         struct ovl_layer *layers)
> +                         struct ovl_fs_context *ctx, struct ovl_layer *l=
ayers)
>  {
>         int err;
>         unsigned int i;
>
>         err =3D -ENOMEM;
> -       ofs->fs =3D kcalloc(numlower + 1, sizeof(struct ovl_sb), GFP_KERN=
EL);
> +       ofs->fs =3D kcalloc(ctx->nr + 1, sizeof(struct ovl_sb), GFP_KERNE=
L);
>         if (ofs->fs =3D=3D NULL)
>                 goto out;
>
> @@ -1480,12 +1372,13 @@ static int ovl_get_layers(struct super_block *sb,=
 struct ovl_fs *ofs,
>                 ofs->fs[0].is_lower =3D false;
>         }
>
> -       for (i =3D 0; i < numlower; i++) {
> +       for (i =3D 0; i < ctx->nr; i++) {
> +               struct ovl_fs_context_layer *l =3D &ctx->lower[i];
>                 struct vfsmount *mnt;
>                 struct inode *trap;
>                 int fsid;
>
> -               err =3D fsid =3D ovl_get_fsid(ofs, &stack[i]);
> +               err =3D fsid =3D ovl_get_fsid(ofs, &l->path);
>                 if (err < 0)
>                         goto out;
>
> @@ -1496,11 +1389,11 @@ static int ovl_get_layers(struct super_block *sb,=
 struct ovl_fs *ofs,
>                  * the upperdir/workdir is in fact in-use by our
>                  * upperdir/workdir.
>                  */
> -               err =3D ovl_setup_trap(sb, stack[i].dentry, &trap, "lower=
dir");
> +               err =3D ovl_setup_trap(sb, l->path.dentry, &trap, "lowerd=
ir");
>                 if (err)
>                         goto out;
>
> -               if (ovl_is_inuse(stack[i].dentry)) {
> +               if (ovl_is_inuse(l->path.dentry)) {
>                         err =3D ovl_report_in_use(ofs, "lowerdir");
>                         if (err) {
>                                 iput(trap);
> @@ -1508,7 +1401,7 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                         }
>                 }
>
> -               mnt =3D clone_private_mount(&stack[i]);
> +               mnt =3D clone_private_mount(&l->path);
>                 err =3D PTR_ERR(mnt);
>                 if (IS_ERR(mnt)) {
>                         pr_err("failed to clone lowerpath\n");
> @@ -1569,63 +1462,86 @@ static int ovl_get_layers(struct super_block *sb,=
 struct ovl_fs *ofs,
>  }
>
>  static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
> -                               const char *lower, unsigned int numlower,
> -                               struct ovl_fs *ofs, struct ovl_layer *lay=
ers)
> +                                           struct ovl_fs_context *ctx,
> +                                           struct ovl_fs *ofs,
> +                                           struct ovl_layer *layers)
>  {
>         int err;
> -       struct path *stack =3D NULL;
>         unsigned int i;
>         struct ovl_entry *oe;
> +       size_t len;
> +       char *lowerdir;
> +       struct ovl_fs_context_layer *l;
>
> -       if (!ofs->config.upperdir && numlower =3D=3D 1) {
> +       if (!ofs->config.upperdir && ctx->nr =3D=3D 1) {
>                 pr_err("at least 2 lowerdir are needed while upperdir non=
existent\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       stack =3D kcalloc(numlower, sizeof(struct path), GFP_KERNEL);
> -       if (!stack)
> -               return ERR_PTR(-ENOMEM);
> -
>         err =3D -EINVAL;
> -       for (i =3D 0; i < numlower; i++) {
> -               err =3D ovl_lower_dir(lower, &stack[i], ofs, &sb->s_stack=
_depth);
> +       len =3D 0;
> +       for (i =3D 0; i < ctx->nr; i++) {
> +               l =3D &ctx->lower[i];
> +
> +               err =3D ovl_lower_dir(l->name, &l->path, ofs, &sb->s_stac=
k_depth);
>                 if (err)
> -                       goto out_err;
> +                       return ERR_PTR(err);
>
> -               lower =3D strchr(lower, '\0') + 1;
> +               len +=3D strlen(l->name);
>         }
>
>         err =3D -EINVAL;
>         sb->s_stack_depth++;
>         if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
>                 pr_err("maximum fs stacking depth exceeded\n");
> -               goto out_err;
> +               return ERR_PTR(err);
> +       }
.> +
> +       /*
> +        * Create a string of all lower layers that we store in
> +        * ofs->config.lowerdir which we can display to userspace in
> +        * mount options. For example, this assembles "/lower1",
> +        * "/lower2" into "/lower1:/lower2".
> +        *
> +        * We need to make sure we add a ':'. Thus, we need to account
> +        * for the separators when allocating space when multiple layers
> +        * are specified. That should be easy since we know that ctx->nr
> +        * >=3D 1. So we know that ctx->nr - 1 will be correct for the
> +        * base case ctx->nr =3D=3D 1 and all other cases.
> +        */
> +       len +=3D ctx->nr - 1;
> +       len++; /* and leave room for \0 */
> +       lowerdir =3D kzalloc(len, GFP_KERNEL_ACCOUNT);
> +       if (!lowerdir)
> +               return ERR_PTR(-ENOMEM);
> +
> +       ofs->config.lowerdir =3D lowerdir;
> +       for (i =3D 0; i < ctx->nr; i++) {
> +               l =3D &ctx->lower[i];
> +
> +               len =3D strlen(l->name);
> +               memcpy(lowerdir, l->name, len);
> +               if ((ctx->nr > 1) && ((i + 1) !=3D ctx->nr))
> +                       lowerdir[len++] =3D ':';
> +               lowerdir +=3D len;
>         }
>


I think it might be simpler and cleaner to move the
ctx->lower[i]->name strings as is to layers[i].name after
layers is allocated in ovl_get_layers() below and use a
loop of seq_printf() in ovl_show_options() instead of preparing
the big ofs->config.lowerdir string.

Something to consider.

Thanks,
Amir.
