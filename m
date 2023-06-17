Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0718733F4B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jun 2023 09:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346207AbjFQHtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Jun 2023 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFQHtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:49:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5D2720;
        Sat, 17 Jun 2023 00:49:14 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9a949c012so16913271cf.0;
        Sat, 17 Jun 2023 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686988154; x=1689580154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLZqwUvbwm0WexYUJyTPF0/2MQebYgnyb3tdbn/Yu8k=;
        b=GKSHDgnizLoRoYeLpvLt/M+L1eVmzULjPIsPMIsMiY1l/kss4MCniFbtb5mBfZU1y6
         EJ6vFyXzgPJWDYjAkzcfDVe91oy3LVDLq+vJbIvkP0C/0RA69W6OyipwHBOIGG0cDb2z
         FYHHfCqCwh+xskR0o2Q8dmkvU2MzQzVPAp2pPxK+tfyu7WsdmfB2H9On9szfYJbHJqKw
         HK2fo6suoa8NQKR1lbjEo0Bm0P+7LjvYsVGGw85l4DdVrZ9BSLq8FZw5BpxdZZO64s1M
         m/uxzoTODgDihSElCqAWYoaPmiy19HHg/oGqCyLCJDwCqqMyrtKffo5frn8wNqG1Ifzr
         5FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686988154; x=1689580154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLZqwUvbwm0WexYUJyTPF0/2MQebYgnyb3tdbn/Yu8k=;
        b=YJ2uAKAgGpC0pxC+dO2TXL0m5Kgl/a0v8QQAJm/pKKi0nKYM3bRLSforQXLs3H1rYu
         Uzp4DlYI/xuORjRFpxmDg2DAHsIeNrfk/1ZK8WN0Y0GXvW+BuQHGMScWqZAz0eNekCee
         ngFDZJJK9zM5GWSIXEh0FEwfpmb/byRmtKUYOB/WWrbc9F/OV7w68O9/6FmRlyQkoUOU
         QNVs9a+wQDScqIKdKHqWdBvvJfLu0LLQv0KxX98f+zl4+zCTgmFiqb1HINVp8KBGRw5x
         70agCcSxy4e+ghxtdSXceF25STwF+gp6+kLnPnZ87koMCFOQK96F97pE+yoY0iBfh7Gx
         DWqQ==
X-Gm-Message-State: AC+VfDycaxMu4bH+UJjWGsG0vpgoxQJ6OdwgtaRSH1gXwr/2hyOmhOWe
        Ju1nhkJjMjXTk3PUSYQzEJq71FRW5odRGMUxK1o=
X-Google-Smtp-Source: ACHHUZ7lmdqfWaKeycwPn2Er7aTSpb23PjSlcGhNUndqPbN5xEGuRihHkb/YrOVI0Q1S2c0pZYB0OEe+Evb2gnan2CQ=
X-Received: by 2002:ac8:59ce:0:b0:3f7:a54c:c101 with SMTP id
 f14-20020ac859ce000000b003f7a54cc101mr5541686qtf.63.1686988153346; Sat, 17
 Jun 2023 00:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org> <20230605-fs-overlayfs-mount_api-v3-3-730d9646b27d@kernel.org>
In-Reply-To: <20230605-fs-overlayfs-mount_api-v3-3-730d9646b27d@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 17 Jun 2023 10:49:02 +0300
Message-ID: <CAOQ4uxi-J7DUxhzWfo4Degzxm_fWFyhmi0wRgRFLCybJ_pRTGQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ovl: change layer mount option handling
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

On Tue, Jun 13, 2023 at 5:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
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
> This is now also rebased on top of the lazy lowerdata lookup which
> allows the specificatin of data only layers using the new "::" syntax.
>
> The rules are simple. A data only layers cannot be followed by any
> regular layers and data layers must be preceeded by at least one regular
> layer.
>
> Parsing the lowerdir mount option must change because of this. The
> original patchset used the old lowerdir parsing function to split a
> lowerdir mount option string such as:
>
>         lowerdir=3D/lower1:/lower2::/lower3::/lower4
>
> simply replacing each non-escaped ":" by "\0". So sequences of
> non-escaped ":" were counted as layers. For example, the previous
> lowerdir mount option above would've counted 6 layers instead of 4 and a
> lowerdir mount option such as:
>
>         lowerdir=3D"/lower1:/lower2::/lower3::/lower4::::::::::::::::::::=
:::::::"
>
> would be counted as 33 layers. Other than being ugly this didn't matter
> much because kern_path() would reject the first "\0" layer. However,
> this overcounting of layers becomes problematic when we base allocations
> on it where we very much only want to allocate space for 4 layers
> instead of 33.
>
> So the new parsing function rejects non-escaped sequences of colons
> other than ":" and "::" immediately instead of relying on kern_path().
>
> Link: https://github.com/util-linux/util-linux/issues/2287
> Link: https://github.com/util-linux/util-linux/issues/1992
> Link: https://bugs.archlinux.org/task/78702
> Link: https://lore.kernel.org/linux-unionfs/20230530-klagen-zudem-32c0908=
c2108@brauner
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/Makefile    |   2 +-
>  fs/overlayfs/overlayfs.h |  23 +++
>  fs/overlayfs/ovl_entry.h |   3 +-
>  fs/overlayfs/params.c    | 388 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/overlayfs/super.c     | 376 +++++++++++++++--------------------------=
----
>  5 files changed, 534 insertions(+), 258 deletions(-)
>
> diff --git a/fs/overlayfs/Makefile b/fs/overlayfs/Makefile
> index 9164c585eb2f..4e173d56b11f 100644
> --- a/fs/overlayfs/Makefile
> +++ b/fs/overlayfs/Makefile
> @@ -6,4 +6,4 @@
>  obj-$(CONFIG_OVERLAY_FS) +=3D overlay.o
>
>  overlay-objs :=3D super.o namei.o util.o inode.o file.o dir.o readdir.o =
\
> -               copy_up.o export.o
> +               copy_up.o export.o params.o
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index fcac4e2c56ab..7659ea6e02cb 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -119,6 +119,29 @@ struct ovl_fh {
>  #define OVL_FH_FID_OFFSET      (OVL_FH_WIRE_OFFSET + \
>                                  offsetof(struct ovl_fb, fid))
>
> +/* params.c */
> +#define OVL_MAX_STACK 500
> +
> +struct ovl_fs_context_layer {
> +       char *name;
> +       struct path path;
> +};
> +
> +struct ovl_fs_context {
> +       struct path upper;
> +       struct path work;
> +       size_t capacity;
> +       size_t nr; /* includes nr_data */
> +       size_t nr_data;
> +       u8 set;
> +       struct ovl_fs_context_layer *lower;
> +};
> +
> +int ovl_parse_param_upperdir(const char *name, struct fs_context *fc,
> +                            bool workdir);
> +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc);
> +void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx);
> +
>  extern const char *const ovl_xattr_table[][2];
>  static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr o=
x)
>  {
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index c72433c06006..7888ab33730b 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -6,7 +6,6 @@
>   */
>
>  struct ovl_config {
> -       char *lowerdir;
>         char *upperdir;
>         char *workdir;
>         bool default_permissions;
> @@ -41,6 +40,7 @@ struct ovl_layer {
>         int idx;
>         /* One fsid per unique underlying sb (upper fsid =3D=3D 0) */
>         int fsid;
> +       char *name;
>  };
>
>  /*
> @@ -101,7 +101,6 @@ struct ovl_fs {
>         errseq_t errseq;
>  };
>
> -
>  /* Number of lower layers, not including data-only layers */
>  static inline unsigned int ovl_numlowerlayer(struct ovl_fs *ofs)
>  {
> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
> new file mode 100644
> index 000000000000..a1606af1613f
> --- /dev/null
> +++ b/fs/overlayfs/params.c
> @@ -0,0 +1,388 @@
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
> +static ssize_t ovl_parse_param_split_lowerdirs(char *str)
> +{
> +       ssize_t nr_layers =3D 1, nr_colons =3D 0;
> +       char *s, *d;
> +
> +       for (s =3D d =3D str;; s++, d++) {
> +               if (*s =3D=3D '\\') {
> +                       s++;
> +               } else if (*s =3D=3D ':') {
> +                       bool next_colon =3D (*(s + 1) =3D=3D ':');
> +
> +                       nr_colons++;
> +                       if (nr_colons =3D=3D 2 && next_colon) {
> +                               pr_err("only single ':' or double '::' se=
quences of unescaped colons in lowerdir mount option allowed.\n");
> +                               return -EINVAL;
> +                       }
> +                       /* count layers, not colons */
> +                       if (!next_colon)
> +                               nr_layers++;
> +
> +                       *d =3D '\0';
> +                       continue;
> +               }
> +
> +               *d =3D *s;
> +               if (!*s) {
> +                       /* trailing colons */
> +                       if (nr_colons) {
> +                               pr_err("unescaped trailing colons in lowe=
rdir mount option.\n");
> +                               return -EINVAL;
> +                       }
> +                       break;
> +               }
> +               nr_colons =3D 0;
> +       }
> +
> +       return nr_layers;
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
> +       ctx->nr_data =3D 0;
> +}
> +
> +/*
> + * Parse lowerdir=3D mount option:
> + *
> + * (1) lowerdir=3D/lower1:/lower2:/lower3::/data1::/data2
> + *     Set "/lower1", "/lower2", and "/lower3" as lower layers and
> + *     "/data1" and "/data2" as data lower layers. Any existing lower
> + *     layers are replaced.
> + * (2) lowerdir=3D:/lower4
> + *     Append "/lower4" to current stack of lower layers. This requires
> + *     that there already is at least one lower layer configured.
> + * (3) lowerdir=3D::/lower5
> + *     Append data "/lower5" as data lower layer. This requires that
> + *     there's at least one regular lower layer present.
> + */
> +int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
> +{
> +       int err;
> +       struct ovl_fs_context *ctx =3D fc->fs_private;
> +       struct ovl_fs_context_layer *l;
> +       char *dup =3D NULL, *dup_iter;
> +       ssize_t nr_lower =3D 0, nr =3D 0, nr_data =3D 0;
> +       bool append =3D false, data_layer =3D false;
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
> +       if (strncmp(name, "::", 2) =3D=3D 0) {
> +               /*
> +                * This is a data layer.
> +                * There must be at least one regular lower layer
> +                * specified.
> +                */
> +               if (ctx->nr =3D=3D 0) {
> +                       pr_err("data lower layers without regular lower l=
ayers not allowed");
> +                       return -EINVAL;
> +               }
> +
> +               /* Skip the leading "::". */
> +               name +=3D 2;
> +               data_layer =3D true;
> +               /*
> +                * A data layer is automatically an append as there
> +                * must've been at least one regular lower layer.
> +                */
> +               append =3D true;
> +       } else if (*name =3D=3D ':') {
> +               /*
> +                * This is a regular lower layer.
> +                * If users want to append a layer enforce that they
> +                * have already specified a first layer before. It's
> +                * better to be strict.
> +                */
> +               if (ctx->nr =3D=3D 0) {
> +                       pr_err("cannot append layer if no previous layer =
has been specified");
> +                       return -EINVAL;
> +               }
> +
> +               /*
> +                * Once a sequence of data layers has started regular
> +                * lower layers are forbidden.
> +                */
> +               if (ctx->nr_data > 0) {
> +                       pr_err("regular lower layers cannot follow data l=
ower layers");
> +                       return -EINVAL;
> +               }
> +
> +               /* Skip the leading ":". */
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
> +       if (nr_lower < 0)
> +               goto out_err;
> +
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
> +       /*
> +        *   (3) By (1) and (2) we know nr <=3D nr_lower <=3D capacity.
> +        *   (4) If ctx->nr =3D=3D 0 =3D> replace
> +        *       We have verified above that the lowerdir mount option
> +        *       isn't an append, i.e., the lowerdir mount option
> +        *       doesn't start with ":" or "::".
> +        * (4.1) The lowerdir mount options only contains regular lower
> +        *       layers ":".
> +        *       =3D> Nothing to verify.
> +        * (4.2) The lowerdir mount options contains regular ":" and
> +        *       data "::" layers.
> +        *       =3D> We need to verify that data lower layers "::" aren'=
t
> +        *          followed by regular ":" lower layers
> +        *   (5) If ctx->nr > 0 =3D> append
> +        *       We know that there's at least one regular layer
> +        *       otherwise we would've failed when parsing the previous
> +        *       lowerdir mount option.
> +        * (5.1) The lowerdir mount option is a regular layer ":" append
> +        *       =3D> We need to verify that no data layers have been
> +        *          specified before.
> +        * (5.2) The lowerdir mount option is a data layer "::" append
> +        *       We know that there's at least one regular layer or
> +        *       other data layers. =3D> There's nothing to verify.
> +        */
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
> +               if (data_layer)
> +                       nr_data++;
> +
> +               /* Calling strchr() again would overrun. */
> +               if ((nr + 1) =3D=3D nr_lower)
> +                       break;
> +
> +               err =3D -EINVAL;
> +               dup_iter =3D strchr(dup_iter, '\0') + 1;
> +               if (*dup_iter) {
> +                       /*
> +                        * This is a regular layer so we require that
> +                        * there are no data layers.
> +                        */
> +                       if ((ctx->nr_data + nr_data) > 0) {
> +                               pr_err("regular lower layers cannot follo=
w data lower layers");
> +                               goto out_put;
> +                       }
> +
> +                       data_layer =3D false;
> +                       continue;
> +               }
> +
> +               /* This is a data lower layer. */
> +               data_layer =3D true;
> +               dup_iter++;
> +       }
> +       ctx->nr =3D nr_lower;
> +       ctx->nr_data +=3D nr_data;
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
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 3392dc5d2082..b73b14c52961 100644
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
> @@ -109,8 +107,11 @@ static const char *ovl_redirect_mode(struct ovl_conf=
ig *config)
>         return ovl_parameter_redirect_dir[config->redirect_mode].name;
>  }
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
> @@ -125,15 +126,15 @@ static const struct fs_parameter_spec ovl_parameter=
_spec[] =3D {
>         {}
>  };
>
> +/*
> + * These options imply different behavior when they are explicitly
> + * specified than when they are left in their default state.
> + */
>  #define OVL_METACOPY_SET       BIT(0)
>  #define OVL_REDIRECT_SET       BIT(1)
>  #define OVL_NFS_EXPORT_SET     BIT(2)
>  #define OVL_INDEX_SET          BIT(3)
>
> -struct ovl_fs_context {
> -       u8 set;
> -};
> -
>  static struct dentry *ovl_d_real(struct dentry *dentry,
>                                  const struct inode *inode)
>  {
> @@ -308,6 +309,7 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>         for (i =3D 0; i < ofs->numlayer; i++) {
>                 iput(ofs->layers[i].trap);
>                 mounts[i] =3D ofs->layers[i].mnt;
> +               kfree(ofs->layers[i].name);
>         }
>         kern_unmount_array(mounts, ofs->numlayer);
>         kfree(ofs->layers);
> @@ -315,7 +317,6 @@ static void ovl_free_fs(struct ovl_fs *ofs)
>                 free_anon_bdev(ofs->fs[i].pseudo_dev);
>         kfree(ofs->fs);
>
> -       kfree(ofs->config.lowerdir);
>         kfree(ofs->config.upperdir);
>         kfree(ofs->config.workdir);
>         if (ofs->creator_cred)
> @@ -433,8 +434,17 @@ static int ovl_show_options(struct seq_file *m, stru=
ct dentry *dentry)
>         struct super_block *sb =3D dentry->d_sb;
>         struct ovl_fs *ofs =3D sb->s_fs_info;
>         const char *redirect_mode;
> -
> -       seq_show_option(m, "lowerdir", ofs->config.lowerdir);
> +       size_t nr, nr_merged_lower =3D ofs->numlayer - ofs->numdatalayer;
> +       const struct ovl_layer *data_layers =3D &ofs->layers[nr_merged_lo=
wer];
> +
> +       /* ofs->layers[0] is the upper layer */
> +       seq_printf(m, ",lowerdir=3D%s", ofs->layers[1].name);
> +       /* dump regular lower layers */
> +       for (nr =3D 2; nr < nr_merged_lower; nr++)
> +               seq_printf(m, ":%s", ofs->layers[nr].name);
> +       /* dump data lower layers */
> +       for (nr =3D 0; nr < ofs->numdatalayer; nr++)
> +               seq_printf(m, "::%s", data_layers[nr].name);
>         if (ofs->config.upperdir) {
>                 seq_show_option(m, "upperdir", ofs->config.upperdir);
>                 seq_show_option(m, "workdir", ofs->config.workdir);
> @@ -509,6 +519,11 @@ static int ovl_fs_params_verify(const struct ovl_fs_=
context *ctx,
>         bool nfs_export_opt =3D ctx->set & OVL_NFS_EXPORT_SET;
>         bool index_opt =3D ctx->set & OVL_INDEX_SET;
>
> +       if (ctx->nr_data > 0 && !config->metacopy) {
> +               pr_err("lower data-only dirs require metacopy support.\n"=
);
> +               return -EINVAL;
> +       }
> +
>         /* Workdir/index are useless in non-upper mount */
>         if (!config->upperdir) {
>                 if (config->workdir) {
> @@ -723,69 +738,6 @@ static struct dentry *ovl_workdir_create(struct ovl_=
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
> @@ -806,10 +758,6 @@ static int ovl_lower_dir(const char *name, struct pa=
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
> @@ -858,26 +806,6 @@ static bool ovl_workdir_ok(struct dentry *workdir, s=
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
> @@ -978,15 +906,12 @@ static int ovl_report_in_use(struct ovl_fs *ofs, co=
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
> @@ -1016,6 +941,11 @@ static int ovl_get_upper(struct super_block *sb, st=
ruct ovl_fs *ofs,
>         upper_layer->idx =3D 0;
>         upper_layer->fsid =3D 0;
>
> +       err =3D -ENOMEM;
> +       upper_layer->name =3D kstrdup(ofs->config.upperdir, GFP_KERNEL);
> +       if (!upper_layer->name)
> +               goto out;
> +
>         /*
>          * Inherit SB_NOSEC flag from upperdir.
>          *
> @@ -1273,46 +1203,37 @@ static int ovl_make_workdir(struct super_block *s=
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
> @@ -1476,13 +1397,13 @@ static int ovl_get_data_fsid(struct ovl_fs *ofs)
>
>
>  static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
> -                         struct path *stack, unsigned int numlower,
> -                         struct ovl_layer *layers)
> +                         struct ovl_fs_context *ctx, struct ovl_layer *l=
ayers)
>  {
>         int err;
>         unsigned int i;
> +       size_t nr_merged_lower;
>
> -       ofs->fs =3D kcalloc(numlower + 2, sizeof(struct ovl_sb), GFP_KERN=
EL);
> +       ofs->fs =3D kcalloc(ctx->nr + 2, sizeof(struct ovl_sb), GFP_KERNE=
L);
>         if (ofs->fs =3D=3D NULL)
>                 return -ENOMEM;
>
> @@ -1509,13 +1430,15 @@ static int ovl_get_layers(struct super_block *sb,=
 struct ovl_fs *ofs,
>                 ofs->fs[0].is_lower =3D false;
>         }
>
> -       for (i =3D 0; i < numlower; i++) {
> +       nr_merged_lower =3D ctx->nr - ctx->nr_data;
> +       for (i =3D 0; i < ctx->nr; i++) {
> +               struct ovl_fs_context_layer *l =3D &ctx->lower[i];
>                 struct vfsmount *mnt;
>                 struct inode *trap;
>                 int fsid;
>
> -               if (i < numlower - ofs->numdatalayer)
> -                       fsid =3D ovl_get_fsid(ofs, &stack[i]);
> +               if (i < nr_merged_lower)
> +                       fsid =3D ovl_get_fsid(ofs, &l->path);
>                 else
>                         fsid =3D ovl_get_data_fsid(ofs);
>                 if (fsid < 0)
> @@ -1528,11 +1451,11 @@ static int ovl_get_layers(struct super_block *sb,=
 struct ovl_fs *ofs,
>                  * the upperdir/workdir is in fact in-use by our
>                  * upperdir/workdir.
>                  */
> -               err =3D ovl_setup_trap(sb, stack[i].dentry, &trap, "lower=
dir");
> +               err =3D ovl_setup_trap(sb, l->path.dentry, &trap, "lowerd=
ir");
>                 if (err)
>                         return err;
>
> -               if (ovl_is_inuse(stack[i].dentry)) {
> +               if (ovl_is_inuse(l->path.dentry)) {
>                         err =3D ovl_report_in_use(ofs, "lowerdir");
>                         if (err) {
>                                 iput(trap);
> @@ -1540,7 +1463,7 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                         }
>                 }
>
> -               mnt =3D clone_private_mount(&stack[i]);
> +               mnt =3D clone_private_mount(&l->path);
>                 err =3D PTR_ERR(mnt);
>                 if (IS_ERR(mnt)) {
>                         pr_err("failed to clone lowerpath\n");
> @@ -1559,6 +1482,8 @@ static int ovl_get_layers(struct super_block *sb, s=
truct ovl_fs *ofs,
>                 layers[ofs->numlayer].idx =3D ofs->numlayer;
>                 layers[ofs->numlayer].fsid =3D fsid;
>                 layers[ofs->numlayer].fs =3D &ofs->fs[fsid];
> +               layers[ofs->numlayer].name =3D l->name;
> +               l->name =3D NULL;
>                 ofs->numlayer++;
>                 ofs->fs[fsid].is_lower =3D true;
>         }
> @@ -1599,104 +1524,59 @@ static int ovl_get_layers(struct super_block *sb=
, struct ovl_fs *ofs,
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
> -       struct ovl_path *lowerstack;
> -       unsigned int numlowerdata =3D 0;
>         unsigned int i;
> +       size_t nr_merged_lower;
>         struct ovl_entry *oe;
> +       struct ovl_path *lowerstack;
>
> -       if (!ofs->config.upperdir && numlower =3D=3D 1) {
> +       struct ovl_fs_context_layer *l;
> +
> +       if (!ofs->config.upperdir && ctx->nr =3D=3D 1) {
>                 pr_err("at least 2 lowerdir are needed while upperdir non=
existent\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       stack =3D kcalloc(numlower, sizeof(struct path), GFP_KERNEL);
> -       if (!stack)
> -               return ERR_PTR(-ENOMEM);
> +       err =3D -EINVAL;
> +       for (i =3D 0; i < ctx->nr; i++) {
> +               l =3D &ctx->lower[i];
>
> -       for (i =3D 0; i < numlower;) {
> -               err =3D ovl_lower_dir(lower, &stack[i], ofs, &sb->s_stack=
_depth);
> +               err =3D ovl_lower_dir(l->name, &l->path, ofs, &sb->s_stac=
k_depth);
>                 if (err)
> -                       goto out_err;
> -
> -               lower =3D strchr(lower, '\0') + 1;
> -
> -               i++;
> -               if (i =3D=3D numlower)
> -                       break;
> -
> -               err =3D -EINVAL;
> -               /*
> -                * Empty lower layer path could mean :: separator that in=
dicates
> -                * a data-only lower data.
> -                * Several data-only layers are allowed, but they all nee=
d to be
> -                * at the bottom of the stack.
> -                */
> -               if (*lower) {
> -                       /* normal lower dir */
> -                       if (numlowerdata) {
> -                               pr_err("lower data-only dirs must be at t=
he bottom of the stack.\n");
> -                               goto out_err;
> -                       }
> -               } else {
> -                       /* data-only lower dir */
> -                       if (!ofs->config.metacopy) {
> -                               pr_err("lower data-only dirs require meta=
copy support.\n");
> -                               goto out_err;
> -                       }
> -                       if (i =3D=3D numlower - 1) {
> -                               pr_err("lowerdir argument must not end wi=
th double colon.\n");
> -                               goto out_err;
> -                       }
> -                       lower++;
> -                       numlower--;
> -                       numlowerdata++;
> -               }
> -       }
> -
> -       if (numlowerdata) {
> -               ofs->numdatalayer =3D numlowerdata;
> -               pr_info("using the lowest %d of %d lowerdirs as data laye=
rs\n",
> -                       numlowerdata, numlower);
> +                       return ERR_PTR(err);
>         }
>
>         err =3D -EINVAL;
>         sb->s_stack_depth++;
>         if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
>                 pr_err("maximum fs stacking depth exceeded\n");
> -               goto out_err;
> +               return ERR_PTR(err);
>         }
>
> -       err =3D ovl_get_layers(sb, ofs, stack, numlower, layers);
> +       err =3D ovl_get_layers(sb, ofs, ctx, layers);
>         if (err)
> -               goto out_err;
> +               return ERR_PTR(err);
>
>         err =3D -ENOMEM;
>         /* Data-only layers are not merged in root directory */
> -       oe =3D ovl_alloc_entry(numlower - numlowerdata);
> +       nr_merged_lower =3D ctx->nr - ctx->nr_data;
> +       oe =3D ovl_alloc_entry(nr_merged_lower);
>         if (!oe)
> -               goto out_err;
> +               return ERR_PTR(err);
>
>         lowerstack =3D ovl_lowerstack(oe);
> -       for (i =3D 0; i < numlower - numlowerdata; i++) {
> -               lowerstack[i].dentry =3D dget(stack[i].dentry);
> -               lowerstack[i].layer =3D &ofs->layers[i+1];
> +       for (i =3D 0; i < nr_merged_lower; i++) {
> +               l =3D &ctx->lower[i];
> +               lowerstack[i].dentry =3D dget(l->path.dentry);
> +               lowerstack[i].layer =3D &ofs->layers[i + 1];
>         }
> -
> -out:
> -       for (i =3D 0; i < numlower; i++)
> -               path_put(&stack[i]);
> -       kfree(stack);
> +       ofs->numdatalayer =3D ctx->nr_data;
>
>         return oe;
> -
> -out_err:
> -       oe =3D ERR_PTR(err);
> -       goto out;
>  }
>
>  /*
> @@ -1804,6 +1684,12 @@ static struct dentry *ovl_get_root(struct super_bl=
ock *sb,
>         ovl_set_upperdata(d_inode(root));
>         ovl_inode_init(d_inode(root), &oip, ino, fsid);
>         ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVAL=
IDATE);
> +       /*
> +        * We're going to put upper path when we call
> +        * fs_context_operations->free() take an additional
> +        * reference so we can just call path_put().
> +        */
> +       dget(upperdentry);

That's a very odd context for this comment.
The fact is that ovl_inode_init() takes ownership of upperdentry
so it is better to clarify that ovl_get_root() takes ownership of
ovl_get_root() takes ownership of upperdentry.
I will post a prep patch....

[...]

> @@ -1952,28 +1813,20 @@ static int ovl_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>         if (err)
>                 goto out_err;
>
> +       /*
> +        * Check ctx->nr instead of ofs->config.lowerdir since we're
> +        * going to set ofs->config.lowerdir here after we know that the
> +        * user specified all layers.
> +        */

outdated comment - removed in my branch.

>         err =3D -EINVAL;
> -       if (!ofs->config.lowerdir) {
> +       if (ctx->nr =3D=3D 0) {
>                 if (fc->sb_flags & SB_SILENT)
>                         pr_err("missing 'lowerdir'\n");
>                 goto out_err;
>         }

[...]

> @@ -2085,13 +1938,10 @@ static int ovl_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>         sb->s_iflags |=3D SB_I_SKIP_SYNC;
>
>         err =3D -ENOMEM;
> -       root_dentry =3D ovl_get_root(sb, upperpath.dentry, oe);
> +       root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);
>         if (!root_dentry)
>                 goto out_free_oe;
>
> -       mntput(upperpath.mnt);
> -       kfree(splitlower);
> -
>         sb->s_root =3D root_dentry;
>

... I will post a prep patch to replace mntput(upperpath.mnt)
here with path_put(&upperpath), so you patch just moves
path_put() to fs_context_operations->free().

Thanks,
Amir.
