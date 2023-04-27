Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B232F6F0C65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 21:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbjD0TMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbjD0TL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:11:59 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F683;
        Thu, 27 Apr 2023 12:11:58 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-77aad9ad986so5257173241.0;
        Thu, 27 Apr 2023 12:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682622717; x=1685214717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STvq7oaJUgF6DWduqzMBwKUOBKMNNJjV5P1F4ifhZfE=;
        b=gxvwGazxlJcxjzNFnMXOVnLgfj8ArkO1N6eIOMEZdqet4tWSwinemkemNcsA7n9HU5
         avEP4iXP5zrbPA2pi8KQpfbTRx0cWgeWjgqmZl26H6gsm1Tu8HvZ88gzztLTPyvBM4N5
         svXfJzCPpGJldK23HMeasgXYVqUv/MljzXzTbokefvzFyKreHFBCuImFzpzx5m334ox+
         B3DWBscRGInqpGWeeuhuHKcDC1yJ0CqPkHWn8Bs1mB+vuwroAaJ4HZrmTMH3qZm4yC4f
         DH5pnldplPm8AZJIbuURs6VcNEOR/AVzcHrxKw4ykEkO7/DsSGVaPjAHPpCES95hu3d3
         cDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682622717; x=1685214717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STvq7oaJUgF6DWduqzMBwKUOBKMNNJjV5P1F4ifhZfE=;
        b=cqtfAnj39l7GqZh6xYQ66cBKa3jCMdCCPJHoONs7ceQMouwJMTAEhg4eDpfFLJa+L0
         hTfn/OqEWJAFpKU/fpe4PqrjE1VM6k4ll3LjDEZZO7tqPVQzzj8T72ljKzjdI1hcP0Y/
         tzR1w05bOFmEzQVhy1pekummOXInJYLlwhtGSktueoyRT8MCQJfsjZohRPEdR8r4xZ67
         kOXcoLvLlnkUz28wsup6QA+UNyZcVsEF7jylVLxXbqUA4wQZ/QMgTdGLCyIG2eqyOttn
         mNyMGAN7Qy1Ul4VzVzFPcuhfJzuWKLdR45d8CMaSCT7gBZs4PD3YHBejSrmIuiMglhRK
         4dOg==
X-Gm-Message-State: AC+VfDy+LxmAcMFG0WrRbLabw2X0I0JQ32ydFVE933Le5uudw5rK/kqC
        1xKKDON95sMfLGBcsnpjW3dDK7wgIFTlo6UWwp8r/YipVYM=
X-Google-Smtp-Source: ACHHUZ6pFIcxwQ6ieYeHyqxXuIkV+Qiv0y9ZUd6RglW9ITyuZzaIc5EgPqxQZLXtQflaXH35MM3bnBXSH91HMkVpEi8=
X-Received: by 2002:a05:6102:e88:b0:42e:4383:783d with SMTP id
 l8-20020a0561020e8800b0042e4383783dmr3646225vst.3.1682622717253; Thu, 27 Apr
 2023 12:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
 <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com> <df31058f662fe9ec9ad1cc59838f288b8aff10f0.camel@kernel.org>
In-Reply-To: <df31058f662fe9ec9ad1cc59838f288b8aff10f0.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 22:11:46 +0300
Message-ID: <CAOQ4uxhWzV7YJ_kPGg_4wHhWAd79_Xgo2uoDY+1K9sEtJcH_cA@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with fanotify
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
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

handle_bytes

On Thu, Apr 27, 2023 at 7:36=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2023-04-27 at 18:52 +0300, Amir Goldstein wrote:
> > On Thu, Apr 27, 2023 at 6:13=E2=80=AFPM Jeff Layton <jlayton@kernel.org=
> wrote:
> > >
> > > On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> > > > Jan,
> > > >
> > > > Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot=
 at an
> > > > alternative proposal to seamlessly support more filesystems.
> > > >
> > > > While fanotify relaxes the requirements for filesystems to support
> > > > reporting fid to require only the ->encode_fh() operation, there ar=
e
> > > > currently no new filesystems that meet the relaxed requirements.
> > > >
> > > > I will shortly post patches that allow overlayfs to meet the new
> > > > requirements with default overlay configurations.
> > > >
> > > > The overlay and vfs/fanotify patch sets are completely independent.
> > > > The are both available on my github branch [2] and there is a simpl=
e
> > > > LTP test variant that tests reporting fid from overlayfs [3], which
> > > > also demonstrates the minor UAPI change of name_to_handle_at(2) for
> > > > requesting a non-decodeable file handle by userspace.
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6m=
b7vtft@quack3/
> > > > [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> > > > [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> > > >
> > > > Amir Goldstein (4):
> > > >   exportfs: change connectable argument to bit flags
> > > >   exportfs: add explicit flag to request non-decodeable file handle=
s
> > > >   exportfs: allow exporting non-decodeable file handles to userspac=
e
> > > >   fanotify: support reporting non-decodeable file handles
> > > >
> > > >  Documentation/filesystems/nfs/exporting.rst |  4 +--
> > > >  fs/exportfs/expfs.c                         | 29 +++++++++++++++++=
+---
> > > >  fs/fhandle.c                                | 20 ++++++++------
> > > >  fs/nfsd/nfsfh.c                             |  5 ++--
> > > >  fs/notify/fanotify/fanotify.c               |  4 +--
> > > >  fs/notify/fanotify/fanotify_user.c          |  6 ++---
> > > >  fs/notify/fdinfo.c                          |  2 +-
> > > >  include/linux/exportfs.h                    | 18 ++++++++++---
> > > >  include/uapi/linux/fcntl.h                  |  5 ++++
> > > >  9 files changed, 67 insertions(+), 26 deletions(-)
> > > >
> > >
> > > This set looks fairly benign to me, so ACK on the general concept.
> >
> > Thanks!
> >
> > >
> > > I am starting to dislike how the AT_* flags are turning into a bunch =
of
> > > flags that only have meanings on certain syscalls. I don't see a clea=
ner
> > > way to handle it though.
> >
> > Yeh, it's not great.
> >
> > There is also a way to extend the existing API with:
> >
> > Perhstruct file_handle {
> >         unsigned int handle_bytes:8;
> >         unsigned int handle_flags:24;
> >         int handle_type;
> >         unsigned char f_handle[];
> > };
> >
> > AFAICT, this is guaranteed to be backward compat
> > with old kernels and old applications.
> >
>
> That could work. It would probably look cleaner as a union though.
> Something like this maybe?
>
> union {
>         unsigned int legacy_handle_bytes;
>         struct {
>                 u8      handle_bytes;
>                 u8      __reserved;
>                 u16     handle_flags;
>         };
> }

I have no problem with the union, but does this struct
guarantee that the lowest byte of legacy_handle_bytes
is in handle_bytes for all architectures?

That's the reason I went with

struct {
         unsigned int handle_bytes:8;
         unsigned int handle_flags:24;
}

Is there a problem with this approach?

> >         unsigned int handle_bytes:8;
> >         unsigned int handle_flags:24;
>
> __reserved must be zeroed (for now). You could consider using it for
> some other purpose later.
>
> It's a little ugly as an API but it would be backward compatible, given
> that we never use the high bits today anyway.
>
> Callers might need to deal with an -EINVAL when they try to pass non-
> zero handle_flags to existing kernels, since you'd trip the
> MAX_HANDLE_SZ check that's there today.
>

Exactly.

> > It also may not be a bad idea that the handle_flags could
> > be used to request specific fh properties (FID) and can also
> > describe the properties of the returned fh (i.e. non-decodeable)
> > that could also be respected by open_by_handle_at().
> >
> > For backward compact, kernel will only set handle_flags in
> > response if new flags were set in the request.
> >
> > Do you consider this extension better than AT_HANDLE_FID
> > or worse? At least it is an API change that is contained within the
> > exportfs subsystem, without polluting the AT_ flags global namespace.
> >
>
> Personally, yes. I think adding a struct file_handle_v2 would be cleaner
> and allows for expanding the API later through new flags.

I agree.
I will give it a try.

Thanks,
Amir.
