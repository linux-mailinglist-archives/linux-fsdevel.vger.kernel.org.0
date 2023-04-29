Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820D6F2577
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjD2R0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 13:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjD2R0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:26:54 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEE419A3;
        Sat, 29 Apr 2023 10:26:52 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-76dae081228so639134241.2;
        Sat, 29 Apr 2023 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682789212; x=1685381212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fNJCgPD3nZD/CxSEKrz96qhuNBDu8LACgFCSboDSlQ=;
        b=ITtARgAn6fiW6y+gXm19hXu7B4QrcHTjswpRSkLamVSKUFr/B5Jx4LnHLaDehqaQLQ
         MUI7MLvc/AzTNxJIkkJM2k1mF17yzUGfZRrIREW6I7jSwzeg2COPr2ZqWjo5TMliFOji
         2GP6EFiYY6lt3QHJzmV7hXW7QBiODWzRsMDr/7G9uHqF2xqsr+2VRpAeBDE/TJabrtaK
         KVHxMqOqwgzyIxGYpqbGiz7a/GyVuExqmocL1/85E90BShhbPt+/wccshKcWjhtGFb6e
         pVkoym3JjQW19rHSAEwvs7kqh2CcqC0YZW0G4ysOSdZ2tk+xJ/t03nj5NZKYtuyfYMe9
         Sobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682789212; x=1685381212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fNJCgPD3nZD/CxSEKrz96qhuNBDu8LACgFCSboDSlQ=;
        b=DdSPxihI1BakAse7GExJBunq2nc//yh4qnWQENODQ2hYe7Fwuy8BRjqYjuy/GMhz39
         XgM8k+pJMmA5pIRQCdEdmV0SLziqz19P1z2xTiY2w1+j2yPVundpqxQjRuNNUlHiAiuC
         MlSKs21n4Dbud3dyoX1jMjGNDjL77+4W1xEIpYqsDIloKMpIw/7Xkl9EMb15f0WycM+9
         ayWgleRWnR5rundLZDXOEEHBPByHseu5oumjcST5zzpqiFRWCW6FoYXxu9KUMXHXf0oO
         NelDNJqZjdhq8J/0F8sNeFfGYx3EILPAekyfILvwDz3MCULHS0kVgrjhV5alCcgkikWP
         IJkw==
X-Gm-Message-State: AC+VfDxz20qP0bAfTeiCcviOvljBCup8xMoYxBLHK+5lOF3phq+TcLJJ
        9neZqdQwWLTHdZ7IkGnyc5Bq6IRLz56ZSVl+Src=
X-Google-Smtp-Source: ACHHUZ4eml1l3yJv4oCL8UyLA+BPHb9Ce2U9KFlhOo+Q/Ap9MjVeWZloS5dsDv4jemdCc01RKU8PZF39xdjqJDF+PfE=
X-Received: by 2002:a05:6102:3568:b0:430:7595:147d with SMTP id
 bh8-20020a056102356800b004307595147dmr4152338vsb.25.1682789211889; Sat, 29
 Apr 2023 10:26:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130105.2606684-1-amir73il@gmail.com> <dafbff6baa201b8af862ee3faf7fe948d2a026ab.camel@kernel.org>
 <ZE0teudDjXJFz+1b@manet.1015granger.net>
In-Reply-To: <ZE0teudDjXJFz+1b@manet.1015granger.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 29 Apr 2023 20:26:40 +0300
Message-ID: <CAOQ4uxi6-fZp8WzQAR7wbv+0c-xncFTsAa=U=9ZCcdcT3vQpgg@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] Prepare for supporting more filesystems with fanotify
To:     Chuck Lever <cel@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
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

On Sat, Apr 29, 2023 at 5:45=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Thu, Apr 27, 2023 at 11:13:33AM -0400, Jeff Layton wrote:
> > On Tue, 2023-04-25 at 16:01 +0300, Amir Goldstein wrote:
> > > Jan,
> > >
> > > Following up on the FAN_REPORT_ANY_FID proposal [1], here is a shot a=
t an
> > > alternative proposal to seamlessly support more filesystems.
> > >
> > > While fanotify relaxes the requirements for filesystems to support
> > > reporting fid to require only the ->encode_fh() operation, there are
> > > currently no new filesystems that meet the relaxed requirements.
> > >
> > > I will shortly post patches that allow overlayfs to meet the new
> > > requirements with default overlay configurations.
> > >
> > > The overlay and vfs/fanotify patch sets are completely independent.
> > > The are both available on my github branch [2] and there is a simple
> > > LTP test variant that tests reporting fid from overlayfs [3], which
> > > also demonstrates the minor UAPI change of name_to_handle_at(2) for
> > > requesting a non-decodeable file handle by userspace.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7=
vtft@quack3/
> > > [2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
> > > [3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
> > >
> > > Amir Goldstein (4):
> > >   exportfs: change connectable argument to bit flags
> > >   exportfs: add explicit flag to request non-decodeable file handles
> > >   exportfs: allow exporting non-decodeable file handles to userspace
> > >   fanotify: support reporting non-decodeable file handles
> > >
> > >  Documentation/filesystems/nfs/exporting.rst |  4 +--
> > >  fs/exportfs/expfs.c                         | 29 ++++++++++++++++++-=
--
> > >  fs/fhandle.c                                | 20 ++++++++------
> > >  fs/nfsd/nfsfh.c                             |  5 ++--
> > >  fs/notify/fanotify/fanotify.c               |  4 +--
> > >  fs/notify/fanotify/fanotify_user.c          |  6 ++---
> > >  fs/notify/fdinfo.c                          |  2 +-
> > >  include/linux/exportfs.h                    | 18 ++++++++++---
> > >  include/uapi/linux/fcntl.h                  |  5 ++++
> > >  9 files changed, 67 insertions(+), 26 deletions(-)
> > >
> >
> > This set looks fairly benign to me, so ACK on the general concept.
>
> Me also (modulo previous review comments), so
>
>   Acked-by: Chuck Lever <chuck.lever@oracle.com>
>
> I assume either Amir or Jeff will take these when they are ready.
> If I'm wrong, please do let me know and I can take them via the
> NFSD tree.
>

With your and Jeff's ACKs I think it would be best if Jan takes
these changes through the fsnotify tree, because they are only
meant to improve fanotify at this point.

>
> > I am starting to dislike how the AT_* flags are turning into a bunch of
> > flags that only have meanings on certain syscalls. I don't see a cleane=
r
> > way to handle it though.

With all the various proposals of file_handle_v2, I still think that the
AT_HANDLE_FID is the cleanest in terms of API simplicity.

Just trying to document file_handle_v2 and backward compat with
file_handle_v1 gives me a headache and documenting AT_HANDLE_FID
is a no brainer.

so if nobody objects I will stick with AT_HANDLE_FID.

Thanks,
Amir.
