Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0649673E28C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjFZOyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 10:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFZOyI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:54:08 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD96BB;
        Mon, 26 Jun 2023 07:53:58 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44357f34e2dso389683137.3;
        Mon, 26 Jun 2023 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687791237; x=1690383237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gydG1jXBCbjfGuulMNF6lsqtIcV4urLEaqXef06B4Fk=;
        b=M3YNf7F299rmG9wXhlzRu/RsmVAkU0/10UiI4WabpG+9MnqJArqcwx8ZMea73UAr6v
         xMvIF2tAUGtrkGpST6wpOIjrfwJhfZIjcrjccOlbwfEswUacARPRGB/6OwTcW3hj/i1X
         BWYSCPVxqpuulSXLS7XYww1SEych9N+k1WZEy+5lcUOFn9g0hv1Qeac7fUhu0uc5YgG5
         3hsacmwuFav845dYl7qv9n46Ln8znfPHjAuUtwngZjpRAx3i0501e7zie42QY7SPDnFm
         /9IiPA4W0E9u51h1HqRcopvNrm24st+eV2IM5e48MNSzrCa9fk/tRzIV1SSPmpNr6EWr
         TUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687791237; x=1690383237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gydG1jXBCbjfGuulMNF6lsqtIcV4urLEaqXef06B4Fk=;
        b=Pq14+TCn1S0YkAqQEbs6le/gJFrr3Z7HNZGduh1c8rpEg7GQ9ssT78ncXDM8Or3gxe
         eM7bZrWWOf2x7wcUx083dpikmqV76NorSm/puYCkk7ARrlapfGOoIKHSUANQWxTa/vWr
         joht6FHWLEN2J7ChM+KJkqSHixgOALLZMnkd1qGzQq5Yx16Gi8OOrfGTQlDEbF1V75DE
         jrjo6ksHW2L+uVKuZVXIVaAtfOEUnpu1x3THoxWqMwTxLVEhmfHuVzF8BTkGYnqSmBb5
         XXl1i/Uy1UhTtTffo++ZSTjtKHivAwI8oKcnQZpz95vmb2asE0jxP/rC2e5v14NvGp9C
         EDNg==
X-Gm-Message-State: AC+VfDwG+TpV4YcgbRKPU25bwqhhDQzk2iJQd/XcYI8GYJomUhiOK6GY
        QrmsK2KbK3EgJfrRIDvoURElfxigbO98LQKUnLl1XZkU/I4=
X-Google-Smtp-Source: ACHHUZ4Hcs0a6c7dkDohzDQTSIx0yE+Ht/RICmfLk5wQijQgc8MEeM+B6jwyWksxWLgHS7kMKeCMJobGom0o8S3oCtQ=
X-Received: by 2002:a05:6102:3651:b0:440:a9df:31b9 with SMTP id
 s17-20020a056102365100b00440a9df31b9mr11138902vsu.18.1687791237038; Mon, 26
 Jun 2023 07:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com> <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
In-Reply-To: <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 26 Jun 2023 17:53:46 +0300
Message-ID: <CAOQ4uxgCrxMKO7ZgAriMkKU-aKnShN+CG0XqP-yYFiyR=Os82A@mail.gmail.com>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
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

On Mon, Jun 26, 2023 at 3:19=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> On Mon, Jun 26, 2023 at 09:11:53AM +0300, Amir Goldstein wrote:
> > On Mon, Jun 26, 2023 at 6:54=E2=80=AFAM Ahelenia Ziemia=C5=84ska
> > <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > >
> > > Hi!
> > >
> > > Consider the following programs:
> > > -- >8 --
> > > =3D=3D> ino.c <=3D=3D
> > > #define _GNU_SOURCE
> > > #include <stdio.h>
> > > #include <sys/inotify.h>
> > > #include <unistd.h>
> > > int main() {
> > >   int ino =3D inotify_init1(IN_CLOEXEC);
> > >   inotify_add_watch(ino, "/dev/fd/0", IN_MODIFY);
> > >
> > >   char buf[64 * 1024];
> > >   struct inotify_event ev;
> > >   while (read(ino, &ev, sizeof(ev)) > 0) {
> > >     fprintf(stderr, "%d: mask=3D%x, cook=3D%x, len=3D%x, name=3D%.*s\=
n", ev.wd, ev.mask,
> > >             ev.cookie, ev.len, (int)ev.len, ev.name);
> > >     fprintf(stderr, "rd=3D%zd\n", read(0, buf, sizeof(buf)));
> > >   }
> > > }
> > >
> >
> > That's a very odd (and wrong) way to implement poll(2).
> > This is not a documented way to use pipes, so it may
> > happen to work with sendfile(2), but there is no guarantee.
> That's what I'm trying to do, yes.
> What's the right way to implement poll here? Because I don't think Linux
> has poll for pipes that behaves like this and POSIX certainly doesn't
> guarantee it, and, indeed, requires that polling a pipe that was hanged
> up instantly returns with POLLHUP forever.
>
> > > -- >8 --
> > > $ make se sp ino
> > > $ mkfifo fifo
> > > $ ./ino < fifo &
> > > [1] 230
> > > $ echo a > fifo
> > > $ echo a > fifo
> > > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > > rd=3D4
> > > $ echo c > fifo
> > > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > > rd=3D2
> > > $ ./se > fifo
> > > abcdef
> > > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > > asd
> > > ^D
> > > se=3D11: Success
> > > rd=3D11
> > > 1: mask=3D2, cook=3D0, len=3D0, name=3D
> > > rd=3D0
> > > $ ./sp > fifo
> > > abcdefg
> > > asd
> > > dsasdadadad
> > > sp=3D24: Success
> > > $ < sp ./sp > fifo
> > > sp=3D25856: Success
> > > $ < sp ./sp > fifo
> > > ^C
> > > $ echo sp > fifo
> > > ^C
> > > -- >8 --
> > >
> > > Note how in all ./sp > fifo cases, ./ino doesn't wake up!
> > > Note also how, thus, we've managed to fill the pipe buffer with ./sp
> > > (when it transferred 25856), and now we can't /ever/ write there agai=
n
> > > (both splicing and normal writes block, since there's no space left i=
n
> > >  the pipe; ./ino hasn't seen this and will never wake up or service t=
he
> > >  pipe):
> > > so we've effectively "denied service" by slickily using a different
> > > syscall to do the write, right?
> > >
> > > I consider this to be unexpected behaviour because (a) obviously and
> > > (b) sendfile() sends the inotify event.
> > >
> > Only applications that do not check for availability
> > of input in the pipe correctly will get "denied service".
> >
> > The fact is that relying on inotify IN_MODIFY and IN_ACCESS events
> > for pipes is not a good idea.
> Okay, so how /is/ "correctly" then?
> Sleep in a loop and read non-blockingly?
> splice also breaks that (and, well, the pipe it's splicing to in general)
>   https://lore.kernel.org/linux-fsdevel/qk6hjuam54khlaikf2ssom6custxf5is2=
ekkaequf4hvode3ls@zgf7j5j4ubvw/t/#u
> but that's beside the point I guess.
>
> > splice(2) differentiates three different cases:
> >         if (ipipe && opipe) {
> > ...
> >         if (ipipe) {
> > ...
> >         if (opipe) {
> > ...
> >
> > IN_ACCESS will only be generated for non-pipe input
> > IN_MODIFY will only be generated for non-pipe output
> >
> > Similarly FAN_ACCESS_PERM fanotify permission events
> > will only be generated for non-pipe input.
> inotify(7) and fanotify(7) don't squeak on that,
> and imply the *ACCESS stuff is just for reading.

Correct.

>
> > sendfile(2) OTOH does not special cases the pipe input
> > case at all and it generates IN_MODIFY for the pipe output
> > case as well.
> >
> > My general opinion about IN_ACCESS/IN_MODIFY
> > (as well as FAN_ACCESS_PERM) is that they are not
> > very practical, not well defined for pipes and anyway do
> > not cover all the ways that a file can be modified/accessed
> > (i.e. mmap). Therefore, IMO, there is no incentive to fix
> > something that has been broken for decades unless
> > you have a very real use case - not a made up one.
> My made-up use-case is tail -f, but I can just request
> IN_MOFIFY|IN_ACCESS for pipes, so if that's "correctly" then great.
> If it isn't, then, again, how /do/ you poll pipes.
>
> > If you would insist on fixing this inconsistency, I would be
> > willing to consider a patch that matches sendfile(2) behavior
> > to that of splice(2) and not the other way around.
> Meh, platform-specific API, long-standing behaviour, it's whatever;
> I'll just update *notify(7) to include that *ACCESSses are generated
> for "wants to/has read OR pipe was written".

I guess you already understood that is not what I meant.

> So is it really true that the only way to poll a pipe is a
> sleep()/read(O_NONBLOCK) loop?

I don't think so, but inotify is not the way.

Thanks,
Amir.
