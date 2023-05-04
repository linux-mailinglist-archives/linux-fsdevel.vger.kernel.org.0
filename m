Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3247F6F6A28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 13:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjEDLiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjEDLhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 07:37:54 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CA4200;
        Thu,  4 May 2023 04:37:50 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-430556f35ebso99680137.3;
        Thu, 04 May 2023 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683200270; x=1685792270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arLbA3HNdyw+twAm+vIkZFygVCLFMYZpLtNy6xlyP2A=;
        b=MusRBuIPuKzhY3ZOXC/kEwn/biFqb+f/fhEGrG75D0huT12YiE1j0OrfWYdzXJf8Vk
         aBTZ7JhIPCIYQitUr7R+5jpAGvurCKM2YRwUu0gPzpAOPgM+gn6HMSWqtiulWnSaJcbX
         mZQFPUoy4bGzKQpaAGEaGAk3PrmxQyTNBCKz7MQ5MEHyHPFMHGEN4de1P1Ayy0QeGgOE
         G46IKI6zqPvUDkwAmzcLyScDQPfFMUYfNvNaafySat3MQAS1zH2ayT80UEK1pjNaOOzI
         Q7Ssd3lLO8uEqCb9uZ1DzmCyssOHyXSpOy7TscLqFbVOEGqMB0KpotGOF5vgCdxF27oC
         twtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683200270; x=1685792270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arLbA3HNdyw+twAm+vIkZFygVCLFMYZpLtNy6xlyP2A=;
        b=YRrHhkdRfrat+GyCQ1Sc4kxGP/Y7wnW94G2fAn1LB0Qfy3orHcwMJFMuOd4ieAHuls
         8yezGHmDSlgq2VVXdSrj0b6BmRxnKJejAjUnWpVlQ1RjHDDwt4oj1wfod0p4PTlHFLqM
         5TIsADY80y45khz88x9iQTXdQwY6NOH9ZJmqRXPd5gatXvQKKsV0m66sGjYr+yig2ISp
         FKdeGS0A9Dg5m5VLY1KC7ZTlwsdcGkrf1h/GtI5fqDW9ZB3lxZn7TRfSRDxJ7LCY2yEX
         wLzQm273nU48MDwxgcs2S6L1lv0TD4rMqXm1PGTgRFSACOsxp5g/D4LwTVuHaO9wPQ+O
         lmuQ==
X-Gm-Message-State: AC+VfDzwF4JFtFIeEtxdfYBbDwMrCCC79OFKQS1uKYMG3/jzidMhd8cE
        j3e3gmqdfumgNlrp2RPOzx7fGT+0sZd57ufqRZg=
X-Google-Smtp-Source: ACHHUZ4AFI8iwYTRO1EDDmzfftusChrWK+GNqtbaCP+VrvYKMD0KMyF7asvBDZjEaxQBlpzQpQEhctWbes56ONTAbrM=
X-Received: by 2002:a67:b349:0:b0:426:4773:963 with SMTP id
 b9-20020a67b349000000b0042647730963mr3176916vsm.34.1683200269879; Thu, 04 May
 2023 04:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230502124817.3070545-1-amir73il@gmail.com> <20230502124817.3070545-4-amir73il@gmail.com>
 <20230503172314.kptbcaluwd6xiamz@quack3> <20230504-unruhen-lauftraining-d676c7702fea@brauner>
In-Reply-To: <20230504-unruhen-lauftraining-d676c7702fea@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 4 May 2023 14:37:38 +0300
Message-ID: <CAOQ4uxh4Kij7fMyFOMgdnZee5_HcHc9RYTNxvLTBtD-JxpCZwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] exportfs: allow exporting non-decodeable file
 handles to userspace
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Thu, May 4, 2023 at 2:19=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, May 03, 2023 at 07:23:14PM +0200, Jan Kara wrote:
> > On Tue 02-05-23 15:48:16, Amir Goldstein wrote:
> > > Some userspace programs use st_ino as a unique object identifier, eve=
n
> > > though inode numbers may be recycable.
> > >
> > > This issue has been addressed for NFS export long ago using the expor=
tfs
> > > file handle API and the unique file handle identifiers are also expor=
ted
> > > to userspace via name_to_handle_at(2).
> > >
> > > fanotify also uses file handles to identify objects in events, but on=
ly
> > > for filesystems that support NFS export.
> > >
> > > Relax the requirement for NFS export support and allow more filesyste=
ms
> > > to export a unique object identifier via name_to_handle_at(2) with th=
e
> > > flag AT_HANDLE_FID.
> > >
> > > A file handle requested with the AT_HANDLE_FID flag, may or may not b=
e
> > > usable as an argument to open_by_handle_at(2).
> > >
> > > To allow filesystems to opt-in to supporting AT_HANDLE_FID, a struct
> > > export_operations is required, but even an empty struct is sufficient
> > > for encoding FIDs.
> >
> > Christian (or Al), are you OK with sparing one AT_ flag for this
> > functionality? Otherwise the patch series looks fine to me so I'd like =
to
> > queue it into my tree. Thanks!
>
> At first it looked like there are reasons to complain about this on the
> grounds that this seems like a flag only for a single system call. But
> another look at include/uapi/linux/fcntl.h reveals that oh well, the
> AT_* flag namespace already contains system call specific flags.
>
> The overloading of AT_EACCESS and AT_REMOVEDIR as 0x200 is especially
> creative since it doesn't even use an infix like the statx specific
> flags.
>
> Long story short, since there's already overloading of the flag
> namespace happening it wouldn't be unprecedent or in any way wrong if
> this patch just reused the 0x200 value as well.
>

I had considered this myself as well...
Couldn't decide if this was ugly or not.
Obviously, I do not mind which value the flag gets.

> In fact, it might come in handy since it would mean that we have the bit
> you're using right now free for a flag that is meaningful for multiple
> system calls. So something to consider but you can just change that
> in-tree as far as I'm concerned.
>
> All this amounts to a long-winded,
>
> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks,
Amir.
