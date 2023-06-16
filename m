Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52F9733252
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjFPNh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFPNh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:37:57 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E130C1;
        Fri, 16 Jun 2023 06:37:56 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-786e37900fbso158863241.1;
        Fri, 16 Jun 2023 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686922675; x=1689514675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tAwHQ2B0lxegUbyW75rUFK0iEoD0lSnsgp1Ai8Hyyo=;
        b=oJFcKKHGiw0DqeFPBle0KO7BFVnXUHAMil75kr8/0SnepHZBNoRZbpV4XmM4C6G84i
         G6PpD5gH9DhjqBqskzTfEhs0iDjO0WvC5On5jNreWRUxSYRcnjzhuCXnGdfKNAICX6cb
         JvL/AScUdO0Xb5VIb7yNof+xMqF/1Jn04afxWVTpZzSd6vghJ4CfhHVnYdf/BD4jx37U
         cICR6sToavEzmgzOGtKkOt9ny4plyT6+L2MkrI4iOo9PECfDO2Mi9CO1ra1zhSvZpVbK
         Xmt7rAPvXjHqETNIyu9pl/f3ZtJm/IWUBuOltbzvGPexJHK5tYDS3GmHXZMyu38+DrR9
         8+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686922675; x=1689514675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tAwHQ2B0lxegUbyW75rUFK0iEoD0lSnsgp1Ai8Hyyo=;
        b=iAOCjlPER/4MrgFfRGJhhGjRMzfr7REUOjkwmGE0lU+iwJZbV67NgZIT7zynvzsC2v
         7fdEbI59T9LtyQaNmcPHUz5Js+xHVg+SNq5nM40Ni1mx0ideVfX5u8rubia002+B6KW+
         a5gQxzIv+YKaH6+TXtOhwPaU9hrnhKNUhcjuGjyu8rS7sg/Mt99RQgr3e5AkZdtP5Zp+
         8+D1n2xkA9rkCsZT6+4OFbPjnaeEwTLVpqL0gK/4fVu96YakcIahQSBjpRXPlF1NGP2I
         stDIFsacR9x9rwVIVIKKL5TtOk9r4pUxYFEgWMdWunzVfQ4mq9zas5UdZLWSD7VZuC+N
         qRuQ==
X-Gm-Message-State: AC+VfDx37lu06/H4BjILIpJuOUAdOYR72Kl1c9sma2bo9hP6z+1uyrE7
        Gu1ESSQfBzt9jS3af84VTOsViEVEF49fUdc0yTA=
X-Google-Smtp-Source: ACHHUZ7eF2akIiWBt1vHwNXGsV8i/XAvp78dALr8KxtL3ihNqCagGZbcYA3ab1FbA/C+Gdar94UdkMxGJzFf6vQ6AGM=
X-Received: by 2002:a05:6102:143:b0:434:6958:cdbf with SMTP id
 a3-20020a056102014300b004346958cdbfmr1368682vsr.18.1686922675137; Fri, 16 Jun
 2023 06:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230605-fs-overlayfs-mount_api-v3-0-730d9646b27d@kernel.org>
 <20230605-fs-overlayfs-mount_api-v3-2-730d9646b27d@kernel.org>
 <CAOQ4uxi0cVquk5=VF8Q9JY8XWKOp19WxijHNkFGiO=LfpTw+Ng@mail.gmail.com> <20230616-neuplanung-zudem-0408ceb10767@brauner>
In-Reply-To: <20230616-neuplanung-zudem-0408ceb10767@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 16 Jun 2023 16:37:44 +0300
Message-ID: <CAOQ4uxic2o+-NjbQRdfjuc8hJUwZMm9Lr+t_U7BKb8F7nQxV-A@mail.gmail.com>
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

On Fri, Jun 16, 2023 at 4:28=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Jun 16, 2023 at 04:21:29PM +0300, Amir Goldstein wrote:
> > On Tue, Jun 13, 2023 at 5:49=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > We recently ported util-linux to the new mount api. Now the mount(8)
> > > tool will by default use the new mount api. While trying hard to fall
> > > back to the old mount api gracefully there are still cases where we r=
un
> > > into issues that are difficult to handle nicely.
> > >
> > > Now with mount(8) and libmount supporting the new mount api I expect =
an
> > > increase in the number of bug reports and issues we're going to see w=
ith
> > > filesystems that don't yet support the new mount api. So it's time we
> > > rectify this.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/overlayfs/ovl_entry.h |   2 +-
> > >  fs/overlayfs/super.c     | 557 ++++++++++++++++++++++++++-----------=
----------
> > >  2 files changed, 305 insertions(+), 254 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> > > index e5207c4bf5b8..c72433c06006 100644
> > > --- a/fs/overlayfs/ovl_entry.h
> > > +++ b/fs/overlayfs/ovl_entry.h
> > > @@ -12,7 +12,7 @@ struct ovl_config {
> > >         bool default_permissions;
> > >         bool redirect_dir;
> > >         bool redirect_follow;
> > > -       const char *redirect_mode;
> > > +       unsigned redirect_mode;
> >
> > I have a separate patch to get rid of redirect_dir and redirect_follow
> > leaving only redirect_mode enum.
> >
> > I've already rebased your patches over this change in my branch.
> >
> > https://github.com/amir73il/linux/commits/fs-overlayfs-mount_api
> >
> >
> > >         bool index;
> > >         bool uuid;
> > >         bool nfs_export;
> > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > index d9be5d318e1b..3392dc5d2082 100644
> > > --- a/fs/overlayfs/super.c
> > > +++ b/fs/overlayfs/super.c
> > > @@ -16,6 +16,8 @@
> > >  #include <linux/posix_acl_xattr.h>
> > >  #include <linux/exportfs.h>
> > >  #include <linux/file.h>
> > > +#include <linux/fs_context.h>
> > > +#include <linux/fs_parser.h>
> > >  #include "overlayfs.h"
> > >
> > >  MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
> > > @@ -59,6 +61,79 @@ module_param_named(metacopy, ovl_metacopy_def, boo=
l, 0644);
> > >  MODULE_PARM_DESC(metacopy,
> > >                  "Default to on or off for the metadata only copy up =
feature");
> > >
> > > +enum {
> > > +       Opt_lowerdir,
> > > +       Opt_upperdir,
> > > +       Opt_workdir,
> > > +       Opt_default_permissions,
> > > +       Opt_redirect_dir,
> > > +       Opt_index,
> > > +       Opt_uuid,
> > > +       Opt_nfs_export,
> > > +       Opt_userxattr,
> > > +       Opt_xino,
> > > +       Opt_metacopy,
> > > +       Opt_volatile,
> > > +};
> >
> > Renaming all those enums to lower case creates unneeded churn.
> > I undid that in my branch, so now the mount api porting patch is a
> > lot smaller.
>
> Every single filesystem apart from fuse and overlayfs uses the standard
> "Opt_" syntax. Only fuse and overlayfs use OPT_* all uppercase. Even the
> documenation uses Opt_* throughout.
>
> So I'd appreciate it if you please did not go out of your way to deviate
> from this. I already did the work to convert to the Opt_* format on
> purpose. If you want less churn however, then you can ofc move this to a
> preparatory patch that converts to the standard format.

okay.
as long as the logical changes are separate from the renaming.

Thanks,
Amir.
