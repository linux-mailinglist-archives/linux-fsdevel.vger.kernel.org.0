Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662887A5FDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjISKmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 06:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjISKmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:42:22 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0554BF0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:42:17 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7ab2270dfbcso210722241.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695120136; x=1695724936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APRzCckWmYFhP4vd+69u1Fo+z3isqHU203XGHBltBZ0=;
        b=ndnHOSmjlYPCTgSU8qNbM8jG33GD0xX6X0wcgRFha6fPg8Tep7gYeoTqaDmKVXHGaP
         jC6dzqi9nft6o1eO71/HsRFWoVIlGqrg3LPz47fa/Spy7eqhZC/PPIj1w4h42/5CbyaK
         v0dJ6CFLfkQrk1irvbjenEqTgxajWhq3qQ83vK9/HRa/lCBsf6k2aU8OLuqbXRFTH7SI
         5EJGpCbwoHWSwd/MEwWJdPgP7dRw3y0V+kzASJ9LVf4Z5GKVJ2eU8Z+SCkBaDVn25SmT
         k4rGEosFD1qf9fAElo4dFnFDjYzqGCFhNVU3ezVDA3SNG/ZTTTUNQTksbbrlZcXgHWCQ
         ZaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695120136; x=1695724936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APRzCckWmYFhP4vd+69u1Fo+z3isqHU203XGHBltBZ0=;
        b=tA2FsDJxkZRcDv4mxR4XN7WNkW76tl0UkDi5oflDPg60o0nrM/Jk3kNX+G8ZzUmfri
         a7TpFJQPASgLoYrorTYWSgLhadm6Rvc9h29QND8OEEp+6m7eqBXdEr3F/BR5FcEFw+FJ
         d6E/UmSDqJHcz84K/wAfcO4ni//KIW2iXlWsUNEfl9+HxEtH77IwlJNT0yjm1uvEotw8
         h7ylpAsqnaRFM1w38E1/EY8ZHlOmD0xE2hTF8FaKYH+Sm5lLrWODnYbrJ9YBllY+8ZCY
         aX7BSJa4ZhYBEmOl9+WeZXzbGr1szIMMv+UL3xp8UAtron4TUVlIDEwmnu/MOYfoJPiT
         qgfw==
X-Gm-Message-State: AOJu0YwFHZtW7sN0BF7ZB6v/fF3NCdmk5Ad1GlwDteDgDlgp3cT2SWW0
        vl80Az7g3sGt5m/vt6KsXTCW6Q+rsXx+WD4++UM=
X-Google-Smtp-Source: AGHT+IEz6J4pdpKf7OKmPpohBccoZic0BYeyM9vVSvFWqdSRSd/b+E5f3zYeqPZKflu759wo4RsZDPQKzFIvdz7Wces=
X-Received: by 2002:a1f:4c43:0:b0:48f:b9bc:5d09 with SMTP id
 z64-20020a1f4c43000000b0048fb9bc5d09mr8989162vka.9.1695120135981; Tue, 19 Sep
 2023 03:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230918123217.932179-1-max.kellermann@ionos.com>
 <20230918123217.932179-3-max.kellermann@ionos.com> <20230918124050.hzbgpci42illkcec@quack3>
 <CAKPOu+-Nx_cvBZNox63R1ah76wQp6eH4RLah0O5mDaLo9h60ww@mail.gmail.com>
 <20230918142319.kvzc3lcpn5n2ty6g@quack3> <CAOQ4uxic7C5skHv4d+Gek_uokRL8sgUegTusiGkwAY4dSSADYQ@mail.gmail.com>
 <CAOQ4uxjzf6NeoCaTrx_X0yZ0nMEWcQC_gq3M-j3jS+CuUTskSA@mail.gmail.com>
 <CAOQ4uxjkL+QEM+rkSOLahLebwXV66TwyxQhRj9xksnim5F-HFw@mail.gmail.com>
 <CAKPOu+_s8O=kfS1xq-cYGDcOD48oqukbsSA3tJT60FxC2eNWDw@mail.gmail.com> <20230919100112.nlb2t4nm46wmugc2@quack3>
In-Reply-To: <20230919100112.nlb2t4nm46wmugc2@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Sep 2023 13:42:04 +0300
Message-ID: <CAOQ4uxgBXBuZ4PZkL7WWCfT699Ck=jbnxk-e-ZFwe=Ys_p_urw@mail.gmail.com>
Subject: Re: inotify maintenance status
To:     Jan Kara <jack@suse.cz>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Ivan Babrou <ivan@cloudflare.com>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 1:01=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 19-09-23 11:08:21, Max Kellermann wrote:
> > On Tue, Sep 19, 2023 at 9:17=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > > As my summary above states, it is correct that fanotify does not
> > > yet fully supersedes inotify, but there is a plan to go in this direc=
tion,
> > > hence, inotify is "being phased out" it is not Obsolete nor Deprecate=
d.
> >
> > I agree that if inotify is to be phased out, we should concentrate on f=
anotify.
> >
> > I'm however somewhat disappointed with the complexity of the fanotify
> > API. I'm not entirely convinced that fanotify is a good successor for
> > inotify, or that inotify should really be replaced. The additional
> > features that fanotify has could have been added to inotify instead; I
> > don't get why this needs an entirely new API. Of course, I'm late to
> > complain, having just learned about (the unprivileged availability of)
> > fanotify many years after it has been invented.
> >
> > System calls needed for one inotify event:
> > - read()
> >
> > System calls needed for one fanotify event:
> > - read()
> > - (do some magic to look up the fsid -
> > https://github.com/martinpitt/fatrace/blob/master/fatrace.c implements
> > a lookup table, yet more complexity that doesn't exist with inotify)
> > - open() to get a file descriptor for the fsid
> > - open_by_handle_at(fsid_fd, fid.handle)
> > - readlink("/proc/self/fd/%d") (which adds a dependency on /proc being =
mounted)
> > - close(fd)
> > - close(fsid_fd)
> >
> > I should mention that this workflow still needs a privileged process -
> > yes, I can use fanotify in an unprivileged process, but
> > open_by_handle_at() is a privileged system call - it requires
> > CAP_DAC_READ_SEARCH. Without it, I cannot obtain information on which
> > file was modified, can I?
> > There is FAN_REPORT_NAME, but it gives me only the name of the
> > directory entry; but since I'm watching a lot of files and all of them
> > are called "memory.events.local", that's of no use.
> >
> > Or am I supposed to use name_to_handle_at() on all watched files to
> > roll my own lookup? (The name_to_hamdle_at() manpage doesn't make me
> > confident it's a reliable system call; it sounds like it needs
> > explicit support from filesystems.)
>
> So with inotify event, you get back 'wd' and 'name' to identify the objec=
t
> where the event happened. How is this (for your usecase) different from
> getting back 'fsid + handle' and 'name' back from fanotify? In inotify ca=
se
> you had to somehow track wd -> path linkage, with fanotify you need to
> track 'fsid + handle' -> path linkage.
>

And if you want to see an implementation of a drop-in replacement
of inotify/fanotify, you can take a look at:

https://github.com/inotify-tools/inotify-tools/pull/134

And specifically the first commit
41b2ec4 ("Index watches by fanotify fid") to understand why
fid is a drop-in replacement for wd.

> > > FAN_REPORT_FID is designed in a way to be almost a drop in replacemen=
t
> > > for inotify watch descriptors as an opaque identifier of the object, =
except that
> > > fsid+fhanle provide much stronger functionality than wd did.
> >
> > How is it stronger?
>
> For your particular usecase I don't think there's any advantage of
> fsid+fhandle over plain wd. But if you want to monitor multiple filesyste=
ms
> or if you have priviledged process that can open by handle, or a standard
> filesystem where handles are actually persistent, then there are benefits=
.
>

Those cases are demonstrated in the --filesystem functionality of the
pull request above, which handles "dynamic watches" instead of
having to setup watches recursively on all subdirs.

Thanks,
Amir.
