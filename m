Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D9174181C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 20:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjF1SiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjF1SiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:38:19 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A2198E;
        Wed, 28 Jun 2023 11:38:16 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-440db8e60c8so71362137.0;
        Wed, 28 Jun 2023 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687977495; x=1690569495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUfemlynnNneoxL8cdSabImehAqyH734aWKCQV2DU1U=;
        b=nj/fTdVOvEEk1BUnQEQlWWmwdnbfMJn6BAZGIXq9TAzRzf/CKgapHEbYtH7ViJr0FV
         0BRZMjWNOA3f0C6jzA2qSBogK/IlvbrAny3EjSFwIYQT6A6FuIE/zzHzb+/wq29cojc5
         VDShPWA8OMXHmAw9aghDvZXygdgMvLcTfi115abjYV1cIjXk1ealb2bRjMVhqJcy3AT9
         4wrCay2k1tRglt5B4f2EG2oVhi2CFWMmLbm/qOJe6qh6sRXVnKwGfKtLkd1LZvNur7MQ
         qz1n+0uqLH2oWdFHeJ0rUDSnXM5FhFHrlpV5JvvKdPWxu3zFn+voPwt0423U+IN6vhgZ
         MMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687977495; x=1690569495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUfemlynnNneoxL8cdSabImehAqyH734aWKCQV2DU1U=;
        b=dL78nclhYhxBisPsRoBMXGHw9cgPioZHUjf4NuWVaEK8UgXvIpX3gLwmgKNoc2C09R
         BWRvJ+THhxi9Lwi9eoQWulyjHQwCEGRvCz3kV4x/czaOyMgdsAoQjKYoaSdBk8vJ/8hS
         du8Gy5Q8UWcgas6oNO7msNcR1lI/TptZ+Fte+DQUmcJcZQanghqOssrqz241dTyDMY8S
         6cX8o3up4mFVV3BfA9KwtmTzlbjNoZLSIdvmTGYlNOTWhhdWPqNm9N+2dy3EMvFyYoOA
         bkJCXE95m5QQbi5W5h+7SRmlRwVhvJi2x5DuNQk1NoiyT5a+eLju/MMmG5DB6hkXtd5E
         PfhQ==
X-Gm-Message-State: AC+VfDzlWGj8Brh14dMGpycE/n/EQFqSnETYwCGnMb4YtNLA7lWQLfjN
        0lPDXd5D5PYKCfzj4ob9MlNQZPwAivxcIZzrYUY=
X-Google-Smtp-Source: ACHHUZ6mjzx7S9b3k6PPB8thfNeFOxurIR+4Ghqx+hQOrJXdXRcmSeWtJZzFywWJ/Bs1Ww42QFWbbbbm9OyBRm+wx9s=
X-Received: by 2002:a67:f998:0:b0:443:6ad6:7915 with SMTP id
 b24-20020a67f998000000b004436ad67915mr5460304vsq.27.1687977495140; Wed, 28
 Jun 2023 11:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz> <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com> <q2nwpf74fngjdlhukkxvlxuz3xkaaq4aup7hzpqjkqlmlthag5@dsx6m7cgk5yt>
In-Reply-To: <q2nwpf74fngjdlhukkxvlxuz3xkaaq4aup7hzpqjkqlmlthag5@dsx6m7cgk5yt>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Jun 2023 21:38:03 +0300
Message-ID: <CAOQ4uxh-ALXa0N-aZzVtO9E5e6C5++OOnkbL=aPSwRbF=DL1Pw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>, ltp@lists.linux.it
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

On Wed, Jun 28, 2023 at 8:09=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> On Wed, Jun 28, 2023 at 09:33:43AM +0300, Amir Goldstein wrote:
> > On Tue, Jun 27, 2023 at 11:50=E2=80=AFPM Ahelenia Ziemia=C5=84ska
> > <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > > The current behaviour caused an asymmetry where some write APIs
> > > (write, sendfile) would notify the written-to/read-from objects,
> > > but splice wouldn't.
> > >
> > > This affected userspace which uses inotify, most notably coreutils
> > > tail -f, to monitor pipes.
> > > If the pipe buffer had been filled by a splice-family function:
> > >   * tail wouldn't know and thus wouldn't service the pipe, and
> > >   * all writes to the pipe would block because it's full,
> > > thus service was denied.
> > > (For the particular case of tail -f this could be worked around
> > >  with ---disable-inotify.)
> > Is my understanding of the tail code wrong?
> > My understanding was that tail_forever_inotify() is not called for
> > pipes, or is it being called when tailing a mixed collection of pipes
> > and regular files? If there are subtleties like those you need to
> > mention them , otherwise people will not be able to reproduce the
> > problem that you are describing.
> I can't squeak to the code itself, but it's trivial to check:
>   $ tail -f  fifo &
>   [1] 3213996
>   $ echo zupa > fifo
>   zupa
>   $ echo zupa > fifo
>   zupa
>   $ echo zupa > fifo
>   zupa
>   $ cat /bin/tail > fifo
>   # ...
>   $ cat /bin/tail > fifo
> hangs: the fifo is being watched with inotify.
>
> This happens regardless of other files being specified.
>
> tail -f doesn't follow FIFOs or pipes if they're fd 0
> (guaranteed by POSIX, coreutils conforms).
>
> OTOH, you could theoretically do
>   $ cat | tail -f /dev/fd/3 3<&0
> which first reads from the pipe until completion (=E2=87=94 hangup, cat d=
ied),
> then hangs, because it's waiting for more data on the pipe.
>
> This can never happen under a normal scenario, but doing
>   $ echo zupa > /proc/3238590/fd/3
> a few times reveals it's using classic 1/s polling
> (and splicing to /proc/3238590/fd/3 actually yields that data being
>  output from tail).
>
> > I need to warn you about something regarding this patch -
> > often there are colliding interests among different kernel users -
> > fsnotify use cases quite often collide with the interest of users track=
ing
> > performance regressions and IN_ACCESS/IN_MODIFY on anonymous pipes
> > specifically have been the source of several performance regression rep=
orts
> > in the past and have driven optimizations like:
> >
> > 71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
> > when there is no watcher")
> > e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
> >
> > The moral of this story is: even if your patches are accepted by fsnoti=
fy
> > reviewers, once they are staged for merging they will be subject to
> > performance regression tests and I can tell you with certainty that
> > performance regression will not be tolerated for the tail -f use case.
> > I will push your v4 patches to a branch in my github, to let the kernel
> > test bots run the performance regressions on it whenever they get to it=
.
> >
> > Moreover, if coreutils will change tail -f to start setting inotify wat=
ches
> > on anonymous pipes (my understanding is that currently does not?),
> > then any tail -f on anonymous pipe can cripple the "no marks on sb"
> > performance optimization for all anonymous pipes and that would be
> > a *very* unfortunate outcome.
> As seen above, it doesn't set inotify watches on anon pipes, and
> (since it manages to distinguish "| /dev/fd/3 3<&0" from "fifo",
>  so it must be going further than S_ISFIFO(fstat()))
> this is an explicit design decision.
>
> If you refuse setting inotifies on anon pipes then that likely won't
> impact any userspace program (it's pathological, and for tail-like cases
>  it'd only be meaningful for magic /proc/$pid/fd/* symlinks),
> and if it's in the name of performance then no-one'll likely complain,
> or even notice.
>

Unfortunately, it doesn't work this way - most of the time we are not
supposed to break existing applications and I have no way of knowing if
those applications exist...

> > I think we need to add a rule to fanotify_events_supported() to ban
> > sb/mount marks on SB_KERNMOUNT and backport this
> > fix to LTS kernels (I will look into it) and then we can fine tune
> > the s_fsnotify_connectors optimization in fsnotify_parent() for
> > the SB_KERNMOUNT special case.
> > This may be able to save your patch for the faith of NACKed
> > for performance regression.
> This goes over my head, but if Jan says it makes sense
> then it must do.
>

Here you go:
https://github.com/amir73il/linux/commits/fsnotify_pipe

I ended up using SB_NOUSER which is narrower than
SB_KERNMOUNT.

Care to test?
1) Functionally - that I did not break your tests.
2) Optimization - that when one anon pipe has an inotify watch
write to another anon pipe stops at fsnotify_inode_has_watchers()
and does not get to fsnotify().

> > > Generate modify out before access in to let inotify merge the
> > > modify out events in thr ipipe case.
> > This comment is not clear and does not belong in this context,
> > but it very much belongs near the code in question.
> Turned it into
>                 /*
>                  * Generate modify out before access in:
>                  * do_splice_from() may've already sent modify out,
>                  * and this ensures the events get merged.
>                  */
> for v5.

OK.

Thanks,
Amir.
