Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0476E34E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 06:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjDPEUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 00:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDPEUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 00:20:47 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA6826A1;
        Sat, 15 Apr 2023 21:20:45 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id a9so20697401vsh.3;
        Sat, 15 Apr 2023 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681618845; x=1684210845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFHaERV3/v3bDFIZruBezwk/pvpEOOlCaDNdvQPiJv4=;
        b=Tbfx06QIYgFhSJv4aJf/RTKFaskZNh4V69TrGcS1W0bTzJN2Lq4rjaeyDRKy7m1nyh
         QuAjyREzNP5jXQUOdzOegYc5fFPkdnSrPRJD8nQAT7njR7wkqahgXIGP7a3Qsxso86ZS
         3dGmR0lN8Wy0+JeU5j6nhffJtr/U4myIxJxoLiOh7e30JthVfvCKTj6MRIX/P8Tdeq6F
         hp/19Jt53B20/hC9C16N+iJIIykaNPsLRrN8B/xkmCL/sHBA6yH5YoZ8PSuelwTNrHxz
         CzI7LZvW7LwHoU5A1wQBQ43FBFiDwNcyUmKp7zPkyivUPt74q7hNXBjKOe+J4pjr6u5Y
         q+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681618845; x=1684210845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFHaERV3/v3bDFIZruBezwk/pvpEOOlCaDNdvQPiJv4=;
        b=ix3uDzTl59uVP62ArEJNQd5CC8Pq5wvIXGNSZVlWZ997hEnincBe5hfuYUR/2ukRge
         hzXuMiPA0ISoi6U/7F6TboqSKbhY0MWcDrJ90C2Y1HWOzHJf4sfTAstwycDpkv4GKgnw
         iaGMqS71FnuDx4hCcf3qMhJ3sFfPfUA2mjIO4G4sEFjBVjuQUOj+lgQndNQZ7x5ZKnZ+
         AaEgP0T0mfH9uB7Qk7gHRV6ahNdH2MOZGqrjYR5+Zslebe8QXd7QJRIVRtUs9Mmqa+Zn
         6RLg16eFOWsV4HXv/DnoOrAahx4aKBIq3twGj4JNlZt9VuWtxynmZb4lHXAwt4sNcdpk
         fJKQ==
X-Gm-Message-State: AAQBX9eEx4r5jFjLTXwOHlocwAXK3T+va/RUvWbj8mhY9gIJSQVasftm
        Ac+NRFLS4OW6Bgr8JH8Ldwi4cK5Gs8ARr9d4eFmEghdL
X-Google-Smtp-Source: AKy350YwUT0qoDElgjTK7jHQGDM8gM5a9KY+2D71IXdS+YHUk/nZhzQsWXtt8t8gQtOOBl0/AgjltNjsXikMz/DJDnc=
X-Received: by 2002:a67:ca1b:0:b0:425:d58d:557d with SMTP id
 z27-20020a67ca1b000000b00425d58d557dmr6085623vsk.0.1681618844872; Sat, 15 Apr
 2023 21:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com> <45099985-B9DE-4842-9D0F-58A5205CD81D@oracle.com>
In-Reply-To: <45099985-B9DE-4842-9D0F-58A5205CD81D@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 16 Apr 2023 07:20:33 +0300
Message-ID: <CAOQ4uxj8b8gV02ybuBWMu7ppBc9phrd8J_XMK_bwOYb+Z5hxCg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] BoF for nfsd
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 7:35=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
> > On Apr 12, 2023, at 2:26 PM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
> >
> > I'd like to request some time for those interested specifically
> > in NFSD to gather and discuss some topics. Not a network file
> > system free-for-all, but specifically for NFSD, because there
> > is a long list of potential topics:
> >
> >    =E2=80=A2 Progress on using iomap for NFSD READ/READ_PLUS (anna)
> >    =E2=80=A2 Replacing nfsd_splice_actor (all)
> >    =E2=80=A2 Transition from page arrays to bvecs (dhowells, hch)
> >    =E2=80=A2 tmpfs directory cookie stability (cel)
> >    =E2=80=A2 timestamp resolution and i_version (jlayton)
> >    =E2=80=A2 GSS Kerberos futures (dhowells)
> >    =E2=80=A2 NFS/NFSD CI (jlayton)
> >    =E2=80=A2 NFSD POSIX to NFSv4 ACL translation - writing down the rul=
es (all)
> >
> > Some of these topics might be appealing to others not specifically
> > involved with NFSD development. If there's something that should
> > be moved to another track or session, please pipe up.
>
> It's been suggested that this is too many topics for a
> single session. Let me propose some ways of breaking it
> up.
>
> >    =E2=80=A2 Progress on using iomap for NFSD READ/READ_PLUS (anna)
> >    =E2=80=A2 Replacing nfsd_splice_actor
>
>
> This is probably worth its own session. We might want to
> include how to convert NFSD to use folios, or maybe that
> deserves its own conversation.
>
> >    =E2=80=A2 Transition from page arrays to bvecs (dhowells, hch)
>
>
> This is something we can take to the hallway or discuss
> over beers or a meal.
>
> >    =E2=80=A2 tmpfs directory cookie stability (cel)
>
> This could be a FS/MM session. Aside from directory
> cookies, there are issues about exporting any shmemfs-
> based filesystem (autofs is another).
>
> >    =E2=80=A2 timestamp resolution and i_version (jlayton)
>
> I'll let Jeff propose something here, and take this off
> the NFSD-specific agenda.

Please do.

>
> >    =E2=80=A2 GSS Kerberos futures (dhowells)
>
> Perhaps this topic also requires us to be drunk first.
> Seriously, though... it could be a pretty specialized
> conversation, and thus left for the hallway track.
>
> Or, David and I could fold this into the bvecs discussion
> above, as these two are somewhat related.
>
> >    =E2=80=A2 NFS/NFSD CI (jlayton)
>
> Network filesystems have special requirements for CI.
> Jeff has been working on shaping kdevops to work for
> our needs, and the work probably has broader appeal
> than only to NFS. This could be its own 30-minute session,
> or maybe we've got most everything worked out already?
>

Perhaps a guest speaker at Luis's kdevops session?

> >    =E2=80=A2 NFSD POSIX to NFSv4 ACL translation - writing down the rul=
es (all)
>
>
> Could be its own session, but it might have only a
> handful of interested parties.
>

Apropos interested parties. If there are any NFS developers/maintainers
that are interested in attending the NFSD BoF virtually, please let me know
and I will send you a code for the virtual registration option.

Thanks,
Amir.
