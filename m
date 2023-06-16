Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDC733310
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjFPOFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 10:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345649AbjFPOE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:04:59 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB8735A5;
        Fri, 16 Jun 2023 07:04:32 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7870821d9a1so605747241.1;
        Fri, 16 Jun 2023 07:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686924225; x=1689516225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iqX1mClaCrIBk4/Mil5Oa6jacTIU5M6Y0BtufyXlsU=;
        b=obrSTLVJVXV8hD4TnKJPyePcxhqzv04Upb0puHO3evN3cWytxFK5BX/z+lIJsfzzAe
         R58ntJXkT0o7VIxTxWx+4dItpE0V6Gmhoiu7QGf3YYA2GUwUGFW5c2FoRYYB4h/IN7Xl
         5TlYhV51ryWuQjQmBAmmIoDOo1CVAS/e0PcqY03biYkOjCHnIYaTSq+cD/H12VL3O0Lw
         cjesuOojdZfYrQy9iCVv0iR/uuJ6jfpDzONqnjM1Xba8KDztAZY40Y4ICImW8/HK0FQS
         txdntSnd9t/7TVYK0Y8xcwy6SfCbWMxjtHDVRUeMYFSDA5CyDUzNEIzeC+V5/0ZvY2Tw
         V/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686924225; x=1689516225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iqX1mClaCrIBk4/Mil5Oa6jacTIU5M6Y0BtufyXlsU=;
        b=k0pCZX5ImJGAZ7WClbeG9I/scqPS8xBiHrwxSQPtirPPgao42zoU+EESVx0VChgi+6
         aOwX+0W4rfW7LcEXE2J97dnLZvsJ+0DjeoFcxNXg3SWRO6RLriuwb5eaYMgiyNxUTpS5
         O4rPZ+kbC0oV2YvqLWvzeoOeWcO1N5Cj87iCMFKO4emJ64WHNTJQpoeM6+1NidaEEBWi
         UnU1Ft9wBy4V9nhIQbGt9BrVh2JS8O5cpqKqOmG8YWiOGKq4NiViFb9/Y/Qd5ApEoljn
         lf8bzy47kpyuDZ4UBkdcHnH0JlghhqtY/bw4EZRIwazGT9ygKFIXtPt5ptbbEU5zvRpF
         Fn9w==
X-Gm-Message-State: AC+VfDxC0/L3DcUj3edKNFnHIq6jcC0z/blh+rIoxP6oQr5l/ZZutgnJ
        nT5cdMUo8r6JdGzm/XsK6kmFI+wyD16/ug17eCIFhfCY
X-Google-Smtp-Source: ACHHUZ46Jm4b78a8FWI2iVK7jzykiYZxpF9iRzI42ODzmAmyOLGiJiU+ZkoSWTyZBFPEfUFxHDc6lUpjWOa/nfRWZQ0=
X-Received: by 2002:a05:6102:440b:b0:43b:4f2e:359 with SMTP id
 df11-20020a056102440b00b0043b4f2e0359mr4163906vsb.3.1686924225581; Fri, 16
 Jun 2023 07:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
 <20230605-fs-overlayfs-mount_api-v3-2-730d9646b27d@kernel.org>
 <CAOQ4uxi0cVquk5=VF8Q9JY8XWKOp19WxijHNkFGiO=LfpTw+Ng@mail.gmail.com>
 <20230616-neuplanung-zudem-0408ceb10767@brauner> <CAOQ4uxic2o+-NjbQRdfjuc8hJUwZMm9Lr+t_U7BKb8F7nQxV-A@mail.gmail.com>
In-Reply-To: <CAOQ4uxic2o+-NjbQRdfjuc8hJUwZMm9Lr+t_U7BKb8F7nQxV-A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Jun 2023 17:03:34 +0300
Message-ID: <CAOQ4uxiLiqxftSGSG6vD4OK1hhBiHiN26iZ1NhC38Xyk6E=fBw@mail.gmail.com>
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

On Fri, Jun 16, 2023 at 4:37=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Fri, Jun 16, 2023 at 4:28=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Fri, Jun 16, 2023 at 04:21:29PM +0300, Amir Goldstein wrote:
> > > On Tue, Jun 13, 2023 at 5:49=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > >
> > > > We recently ported util-linux to the new mount api. Now the mount(8=
)
> > > > tool will by default use the new mount api. While trying hard to fa=
ll
> > > > back to the old mount api gracefully there are still cases where we=
 run
> > > > into issues that are difficult to handle nicely.
> > > >
> > > > Now with mount(8) and libmount supporting the new mount api I expec=
t an
> > > > increase in the number of bug reports and issues we're going to see=
 with
> > > > filesystems that don't yet support the new mount api. So it's time =
we
> > > > rectify this.
> > > >
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  fs/overlayfs/ovl_entry.h |   2 +-
> > > >  fs/overlayfs/super.c     | 557 ++++++++++++++++++++++++++---------=
------------
> > > >  2 files changed, 305 insertions(+), 254 deletions(-)
> > > >
> > > > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > > > index e5207c4bf5b8..c72433c06006 100644
> > > > --- a/fs/overlayfs/ovl_entry.h
> > > > +++ b/fs/overlayfs/ovl_entry.h
> > > > @@ -12,7 +12,7 @@ struct ovl_config {
> > > >         bool default_permissions;
> > > >         bool redirect_dir;
> > > >         bool redirect_follow;
> > > > -       const char *redirect_mode;
> > > > +       unsigned redirect_mode;
> > >
> > > I have a separate patch to get rid of redirect_dir and redirect_follo=
w
> > > leaving only redirect_mode enum.
> > >
> > > I've already rebased your patches over this change in my branch.
> > >
> > > https://github.com/amir73il/linux/commits/fs-overlayfs-mount_api
> > >
> > >
> > > >         bool index;
> > > >         bool uuid;
> > > >         bool nfs_export;
> > > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > > index d9be5d318e1b..3392dc5d2082 100644
> > > > --- a/fs/overlayfs/super.c
> > > > +++ b/fs/overlayfs/super.c
> > > > @@ -16,6 +16,8 @@
> > > >  #include <linux/posix_acl_xattr.h>
> > > >  #include <linux/exportfs.h>
> > > >  #include <linux/file.h>
> > > > +#include <linux/fs_context.h>
> > > > +#include <linux/fs_parser.h>
> > > >  #include "overlayfs.h"
> > > >
> > > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > > > @@ -59,6 +61,79 @@ module_param_named(metacopy, ovl_metacopy_def, b=
ool, 0644);
> > > >  MODULE_PARM_DESC(metacopy,
> > > >                  "Default to on or off for the metadata only copy u=
p feature");
> > > >
> > > > +enum {
> > > > +       Opt_lowerdir,
> > > > +       Opt_upperdir,
> > > > +       Opt_workdir,
> > > > +       Opt_default_permissions,
> > > > +       Opt_redirect_dir,
> > > > +       Opt_index,
> > > > +       Opt_uuid,
> > > > +       Opt_nfs_export,
> > > > +       Opt_userxattr,
> > > > +       Opt_xino,
> > > > +       Opt_metacopy,
> > > > +       Opt_volatile,
> > > > +};
> > >
> > > Renaming all those enums to lower case creates unneeded churn.
> > > I undid that in my branch, so now the mount api porting patch is a
> > > lot smaller.
> >
> > Every single filesystem apart from fuse and overlayfs uses the standard
> > "Opt_" syntax. Only fuse and overlayfs use OPT_* all uppercase. Even th=
e
> > documenation uses Opt_* throughout.
> >
> > So I'd appreciate it if you please did not go out of your way to deviat=
e
> > from this. I already did the work to convert to the Opt_* format on
> > purpose. If you want less churn however, then you can ofc move this to =
a
> > preparatory patch that converts to the standard format.
>
> okay.
> as long as the logical changes are separate from the renaming.

Looking at it again, after my prep patches, this enum rename
does not make reviewing harder, so I restored the Opt_* names
and pushed to my branch.

Thanks,
Amir.
