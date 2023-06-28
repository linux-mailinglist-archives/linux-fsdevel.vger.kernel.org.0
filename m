Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD10740BD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjF1Irr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbjF1IhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:37:00 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A853A9D;
        Wed, 28 Jun 2023 01:28:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b7ffab9454so19214055ad.3;
        Wed, 28 Jun 2023 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687940907; x=1690532907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je3nqrlzOYYQ8SVlBpkmEhHGojppwdW1wOCRKFhydq8=;
        b=fb5wRnQp11z7QPeHMGaOCzLitGqZyH6zJ8OvGn4qaA7n3ztBzJoZXroANgotlEilYu
         nTmvbVQWEST8irhKYcV6BpKIlNNQMkoTm8LkCONduHZAinUn64tXk5Exg4KVfJ+LajiY
         rvK1DkAy2E3q/fB9Sv88HM+xfIR9qC8RwIqi4RkqhXsI4xiD4nfnTRjRppurvaRb5ddv
         SfgbYzuke2r6bosXC/zVy9n+ZTpWViFGH6NbVGg2mK5JEpbBnUMWEoJSWPBwBBOfv3sU
         OiO3FICbP4NJXv8THO0/cogh+Ka4ZVcDmmUhi2HBxicKOlFA1lCkzSwchCIT6X6FnSE7
         1s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940907; x=1690532907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je3nqrlzOYYQ8SVlBpkmEhHGojppwdW1wOCRKFhydq8=;
        b=U61uHR0e1hcPTFT1vXgjdsBJ1PhLlWde2pwMzArEiIPdQVmcMfDRmeM+vSkwUZBbhZ
         viHkwGcA60bBVW5ERUYwuaCsQin4R6OSpjtG0Y5IURUOJxSp7aVZz0Zfkwyo3GVHDQth
         JBPWLhGbcUqSsmB2M7zphFKpbFP6ZbXBwN81O+/QN3pk5uBeU9zLDwGnVWZswR1tz9ZL
         5EOUhTqYgHJcgcq2f9PvXgLPOzyKW1rgdiM3/FHZTfRXKzzF7h9bxj+D8kHczbMYuvDX
         kPt/lvkCSGEaEtnfaDdcyGSdhWNJMCFn9owAKJhITO6eck4hi8T7dNJVw/lyjiuUTkfQ
         FASQ==
X-Gm-Message-State: AC+VfDyJ6GVFQeBi69v7k22yu9LJpjiapAb74HX4CUogrE5i0w9vncN7
        Sq1AkyW+C4eaTYl2jy9KKM6kUqHI6bLf8RD2BN4jViAls2Q=
X-Google-Smtp-Source: ACHHUZ4JN7p6ItoNPYh7eS98JRlbu/gVY84GPPJWjXmp/ureK/2segLM+RbikIgw2h1/OPGJRrQjuXLmOsfcGV7BKag=
X-Received: by 2002:a05:6102:142:b0:440:e0ef:4cd0 with SMTP id
 a2-20020a056102014200b00440e0ef4cd0mr9541101vsr.27.1687934034587; Tue, 27 Jun
 2023 23:33:54 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz> <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Jun 2023 09:33:43 +0300
Message-ID: <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
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

On Tue, Jun 27, 2023 at 11:50=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> The current behaviour caused an asymmetry where some write APIs
> (write, sendfile) would notify the written-to/read-from objects,
> but splice wouldn't.
>
> This affected userspace which uses inotify, most notably coreutils
> tail -f, to monitor pipes.
> If the pipe buffer had been filled by a splice-family function:
>   * tail wouldn't know and thus wouldn't service the pipe, and
>   * all writes to the pipe would block because it's full,
> thus service was denied.
> (For the particular case of tail -f this could be worked around
>  with ---disable-inotify.)
>

Is my understanding of the tail code wrong?
My understanding was that tail_forever_inotify() is not called for
pipes, or is it being called when tailing a mixed collection of pipes
and regular files? If there are subtleties like those you need to
mention them , otherwise people will not be able to reproduce the
problem that you are describing.

I need to warn you about something regarding this patch -
often there are colliding interests among different kernel users -
fsnotify use cases quite often collide with the interest of users tracking
performance regressions and IN_ACCESS/IN_MODIFY on anonymous pipes
specifically have been the source of several performance regression reports
in the past and have driven optimizations like:

71d734103edf ("fsnotify: Rearrange fast path to minimise overhead
when there is no watcher")
e43de7f0862b ("fsnotify: optimize the case of no marks of any type")

The moral of this story is: even if your patches are accepted by fsnotify
reviewers, once they are staged for merging they will be subject to
performance regression tests and I can tell you with certainty that
performance regression will not be tolerated for the tail -f use case.
I will push your v4 patches to a branch in my github, to let the kernel
test bots run the performance regressions on it whenever they get to it.

Moreover, if coreutils will change tail -f to start setting inotify watches
on anonymous pipes (my understanding is that currently does not?),
then any tail -f on anonymous pipe can cripple the "no marks on sb"
performance optimization for all anonymous pipes and that would be
a *very* unfortunate outcome.

I think we need to add a rule to fanotify_events_supported() to ban
sb/mount marks on SB_KERNMOUNT and backport this
fix to LTS kernels (I will look into it) and then we can fine tune
the s_fsnotify_connectors optimization in fsnotify_parent() for
the SB_KERNMOUNT special case.
This may be able to save your patch for the faith of NACKed
for performance regression.

> Generate modify out before access in to let inotify merge the
> modify out events in thr ipipe case.

This comment is not clear and does not belong in this context,
but it very much belongs near the code in question.

Please wait to collect more feedback and specifically
to hear what Jan has to say about this hack before posting v5!

FYI, we are now in the beginning of the 6.5 "merge window",
which means that maintainers may be less responsive for the
next two weeks to non-critical patches as this one, which are
not targeted for the 6.5 kernel release.

Thanks,
Amir.
