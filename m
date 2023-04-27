Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9826B6F08C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbjD0PwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbjD0PwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:52:15 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D6CD;
        Thu, 27 Apr 2023 08:52:14 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-77aad9ad986so4320724241.0;
        Thu, 27 Apr 2023 08:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682610733; x=1685202733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpbQCFCKqPtR+q35gYvKi307a8K/CfDKJnmDxnws/e0=;
        b=V9IlPrFxE75wX4NqAufm6Y6nRzlPCwRjtXEO+2kSSxX8SyFpb2Losmck1WNcpOg8SS
         q52eK2lzxfISYp/76EnJ9T7bJOjP8OzbRKl23lrM9vz/38e1Jd6RkQwgP9aR4p5vclia
         Q5cMw6ZbgWU+eybIQa8LW1R5pN1bxvxIJ/EEN+Ha2Etmur3A+pbac4i1+VdPOqW4cL06
         ZcvRhR/peMbg4TZkG5A5noErqfa19KSR6YtLo729ko8W08AsfdPA5PDilDSXa4ORjwKu
         hKhyYI+lv0IrrRQvL6y3i1VdRdbcHVL9HdOGqIPguvjPdK66a7tBLzN3dcZ8JdXTW9xf
         3MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682610733; x=1685202733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpbQCFCKqPtR+q35gYvKi307a8K/CfDKJnmDxnws/e0=;
        b=MKgPy0RiD0mPKEODN8oQFFJyZTYhdXtM8Fz25SDzs+wA1njYhGxLAQ3mcq28ciCNMI
         oI1CKUu70iMEu4Y8JRv0uikfFj67ceiHDSZeejRTazxQaT/NJR+jVELa649c3cfV4jqZ
         ME7Y69qMHQFC2GIOrtczWA5RrAr4KNZKzq1u698TB9PtP/gAv8qim8W2xLZrOBnJaYrb
         hEslulgAPhRUZGckmnFZFa/feQXO7mkJ1DKWaQ82oiLUOKXMMRJNbuPHzy3KFAduD9Ha
         FV5aI6kiSvLTYEZQ9iaL/3ccqqYqomTT6QUi/TqoXAGVpRBuQuL+EMizD72+pWgaE+dk
         hp5w==
X-Gm-Message-State: AC+VfDz+QycKvuO4+cJ5dxLRS/VOs0wKt9OgJw5klRlRSGEPDaCt0f82
        58QzhpI06Je7ufx0oaC4H/NPkCSdc4xUUn/fY7+dbjQGO5o=
X-Google-Smtp-Source: ACHHUZ5oJ4ySPKlN/gBKXSuk/9STUGVRqRVxBKNHPjhwTDBPPnq8P7t3uqF3+u3MG3IOq73ZsvtBak/sAgkJ9g67s6U=
X-Received: by 2002:a05:6102:390c:b0:42e:3aa5:3369 with SMTP id
 e12-20020a056102390c00b0042e3aa53369mr3484438vsu.5.1682610733585; Thu, 27 Apr
 2023 08:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
In-Reply-To: <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 18:52:02 +0300
Message-ID: <CAOQ4uxjR0cdjW1Pr1DWAn+dkTd3SbV7CUqeGRh2FeDVBGAdtRw@mail.gmail.com>
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

On Thu, Apr 27, 2023 at 6:13=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> > Jan,
> >
> > Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot at =
an
> > alternative proposal to seamlessly support more filesystems.
> >
> > While fanotify relaxes the requirements for filesystems to support
> > reporting fid to require only the ->encode_fh() operation, there are
> > currently no new filesystems that meet the relaxed requirements.
> >
> > I will shortly post patches that allow overlayfs to meet the new
> > requirements with default overlay configurations.
> >
> > The overlay and vfs/fanotify patch sets are completely independent.
> > The are both available on my github branch [2] and there is a simple
> > LTP test variant that tests reporting fid from overlayfs [3], which
> > also demonstrates the minor UAPI change of name_to_handle_at(2) for
> > requesting a non-decodeable file handle by userspace.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vt=
ft@quack3/
> > [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> > [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> >
> > Amir Goldstein (4):
> >   exportfs: change connectable argument to bit flags
> >   exportfs: add explicit flag to request non-decodeable file handles
> >   exportfs: allow exporting non-decodeable file handles to userspace
> >   fanotify: support reporting non-decodeable file handles
> >
> >  Documentation/filesystems/nfs/exporting.rst |  4 +--
> >  fs/exportfs/expfs.c                         | 29 ++++++++++++++++++---
> >  fs/fhandle.c                                | 20 ++++++++------
> >  fs/nfsd/nfsfh.c                             |  5 ++--
> >  fs/notify/fanotify/fanotify.c               |  4 +--
> >  fs/notify/fanotify/fanotify_user.c          |  6 ++---
> >  fs/notify/fdinfo.c                          |  2 +-
> >  include/linux/exportfs.h                    | 18 ++++++++++---
> >  include/uapi/linux/fcntl.h                  |  5 ++++
> >  9 files changed, 67 insertions(+), 26 deletions(-)
> >
>
> This set looks fairly benign to me, so ACK on the general concept.

Thanks!

>
> I am starting to dislike how the AT_* flags are turning into a bunch of
> flags that only have meanings on certain syscalls. I don't see a cleaner
> way to handle it though.

Yeh, it's not great.

There is also a way to extend the existing API with:

Perhstruct file_handle {
        unsigned int handle_bytes:8;
        unsigned int handle_flags:24;
        int handle_type;
        unsigned char f_handle[];
};

AFAICT, this is guaranteed to be backward compat
with old kernels and old applications.

It also may not be a bad idea that the handle_flags could
be used to request specific fh properties (FID) and can also
describe the properties of the returned fh (i.e. non-decodeable)
that could also be respected by open_by_handle_at().

For backward compact, kernel will only set handle_flags in
response if new flags were set in the request.

Do you consider this extension better than AT_HANDLE_FID
or worse? At least it is an API change that is contained within the
exportfs subsystem, without polluting the AT_ flags global namespace.

Thanks,
Amir.
