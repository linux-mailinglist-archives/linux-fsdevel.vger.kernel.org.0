Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225946D9A9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbjDFOjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjDFOiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:38:55 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F93D318
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 07:36:52 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id n125so46317133ybg.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680791812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNx+MpJaLafLCN78HnmInCHHb+TFh8dvtnnKiIxs/Rk=;
        b=fsOi3sHhMHJH7RJSIdZbBRS/H8CzrE8wq69/k/j7gKLgbFakhpQVMfB0DIuWL9wMwU
         vK80y6zlprjbRT3zeH6iFk0X4MwNiNIc7iGIsUilciv5CY3kj6zukLI/otspBOlPpiLm
         qdvFZaTZMOl/OUEr3bttcVNZ/u2hwIPBQ5Gq4P/As986XIMIZCVl+qrjcg0kZtF8buTf
         JtD1LJYyqalpfBSUZmHqnVewlrP2ryZS75lc+0OmQk2H5qp0GkkPYoq7mRnx7b7UevMM
         Nc+rwR1CzkKxtOvK4fETiuks/W2Jl1THnbtzFDFNwvyUFyTQkZPN+JBiKA0vz2oiQo63
         9viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNx+MpJaLafLCN78HnmInCHHb+TFh8dvtnnKiIxs/Rk=;
        b=5RnpHK0WfQ09N6EB3Rd1N+U2D4RuAWrHENcSP+cqrg5S1p2featrHsigp30GUSQv+e
         sgTZ9/5ikD8aBhAgrM1uUITru0SS1PigM9DfPOcOXWUDriCXChOw5mvx8syG/ZOMH3Ry
         pu3W0I76BveVTzM+hX4yh0ZyAHogywHXXIVIoTXlf2PyEdfsYSTap5dfXOWJ3JUtjW8S
         xsAnS5UxTzob9Hag9VVdR/la+B/e/LdpHuLVTDpZjB4k5Ge+yU7RTSxbSqNIocxhTfXt
         vABlDIDhCMqosnIPNMSaJFkugyvMO3HSXwhUIy9TOSjVYSMxELSOZnWS2QKYSVo516FF
         eaWQ==
X-Gm-Message-State: AAQBX9eUld0BLWEY2Z5K8eD5tRcOdfjAvXMUpIFuBjxH6rBpb/R22ntC
        wcHJnyDhv+kW7GRAWZckwNpTuhZIaOHsVe9JWyFov1S9tQGq+DY=
X-Google-Smtp-Source: AKy350bWqLOdzt7LIFLSFpObt5E4HhJLZLyJpGMyWnBVj6zl2dLyRNU9kwOuF9Pm+Puc7RtbPvMXIf3Lb8LunkqRw5Y=
X-Received: by 2002:a25:cc42:0:b0:b76:ceb2:661b with SMTP id
 l63-20020a25cc42000000b00b76ceb2661bmr2229794ybf.3.1680791812031; Thu, 06 Apr
 2023 07:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230405171449.4064321-1-stefanb@linux.ibm.com>
 <20230406-diffamieren-langhaarig-87511897e77d@brauner> <CAHC9VhQsnkLzT7eTwVr-3SvUs+mcEircwztfaRtA+4ZaAh+zow@mail.gmail.com>
 <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
In-Reply-To: <a6c6e0e4-047f-444b-3343-28b71ddae7ae@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Apr 2023 10:36:41 -0400
Message-ID: <CAHC9VhQyWa1OnsOvoOzD37EmDnESfo4Rxt2eCSUgu+9U8po-CA@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: Trigger file re-evaluation by IMA / EVM after writes
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, miklos@szeredi.hu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 6, 2023 at 10:20=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
> On 4/6/23 10:05, Paul Moore wrote:
> > On Thu, Apr 6, 2023 at 6:26=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> >> On Wed, Apr 05, 2023 at 01:14:49PM -0400, Stefan Berger wrote:
> >>> Overlayfs fails to notify IMA / EVM about file content modifications
> >>> and therefore IMA-appraised files may execute even though their file
> >>> signature does not validate against the changed hash of the file
> >>> anymore. To resolve this issue, add a call to integrity_notify_change=
()
> >>> to the ovl_release() function to notify the integrity subsystem about
> >>> file changes. The set flag triggers the re-evaluation of the file by
> >>> IMA / EVM once the file is accessed again.
> >>>
> >>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>> ---
> >>>   fs/overlayfs/file.c       |  4 ++++
> >>>   include/linux/integrity.h |  6 ++++++
> >>>   security/integrity/iint.c | 13 +++++++++++++
> >>>   3 files changed, 23 insertions(+)
> >>>
> >>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> >>> index 6011f955436b..19b8f4bcc18c 100644
> >>> --- a/fs/overlayfs/file.c
> >>> +++ b/fs/overlayfs/file.c
> >>> @@ -13,6 +13,7 @@
> >>>   #include <linux/security.h>
> >>>   #include <linux/mm.h>
> >>>   #include <linux/fs.h>
> >>> +#include <linux/integrity.h>
> >>>   #include "overlayfs.h"
> >>>
> >>>   struct ovl_aio_req {
> >>> @@ -169,6 +170,9 @@ static int ovl_open(struct inode *inode, struct f=
ile *file)
> >>>
> >>>   static int ovl_release(struct inode *inode, struct file *file)
> >>>   {
> >>> +     if (file->f_flags & O_ACCMODE)
> >>> +             integrity_notify_change(inode);
> >>> +
> >>>        fput(file->private_data);
> >>>
> >>>        return 0;
> >>> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> >>> index 2ea0f2f65ab6..cefdeccc1619 100644
> >>> --- a/include/linux/integrity.h
> >>> +++ b/include/linux/integrity.h
> >>> @@ -23,6 +23,7 @@ enum integrity_status {
> >>>   #ifdef CONFIG_INTEGRITY
> >>>   extern struct integrity_iint_cache *integrity_inode_get(struct inod=
e *inode);
> >>>   extern void integrity_inode_free(struct inode *inode);
> >>> +extern void integrity_notify_change(struct inode *inode);
> >>
> >> I thought we concluded that ima is going to move into the security hoo=
k
> >> infrastructure so it seems this should be a proper LSM hook?
> >
> > We are working towards migrating IMA/EVM to the LSM layer, but there
> > are a few things we need to fix/update/remove first; if anyone is
> > curious, you can join the LSM list as we've been discussing some of
> > these changes this week.  Bug fixes like this should probably remain
> > as IMA/EVM calls for the time being, with the understanding that they
> > will migrate over with the rest of IMA/EVM.
> >
> > That said, we should give Mimi a chance to review this patch as it is
> > possible there is a different/better approach.  A bit of patience may
> > be required as I know Mimi is very busy at the moment.
>
> There may be a better approach actually by increasing the inode's i_versi=
on,
> which then should trigger the appropriate path in ima_check_last_writer()=
.

I'm not the VFS/inode expert here, but I thought the inode's i_version
field was only supposed to be bumped when the inode metadata changed,
not necessarily the file contents, right?

That said, overlayfs is a bit different so maybe that's okay, but I
think we would need to hear from the VFS folks if this is acceptable.

--=20
paul-moore.com
