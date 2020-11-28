Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E502C747C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbgK1Vta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbgK1TAU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:00:20 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38340C02B8F1;
        Sat, 28 Nov 2020 01:06:38 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i9so6921276ioo.2;
        Sat, 28 Nov 2020 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIIZAXDzKwop2fyL+ugRMktDfmpGkDPbQUZJlWUas5k=;
        b=px9OARAcD/eF7z6PpWzwqPpkkPggWWfPEfc72C7hyzAFdeQw4CeKWDVVmrtKvqEJai
         5ZbNKSNgNutfj3oh5/ACoqmW/Gfoi7hnUTDennY1TCOWVlDHplv/fP56s/duH9SzJ5k1
         hnFmYEUGw805ay4cdwO77s0yTMXgmYQzsdMHA/IXMLHI5sz2K2SsaNClsKRNXWXHhmtz
         q/m4X+1dBfXFyPgtrfqQe+/fSs2UrrPTMXposgGaW5MRSgBl9zjq+sDfCIr2Jkahy9Ba
         Qs4rfnpDMGZ1FOgqqTARI59GihW73OosE+45EfmbzcdQYzxRhDQD3ZQagMyaF8LxXhSN
         lu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIIZAXDzKwop2fyL+ugRMktDfmpGkDPbQUZJlWUas5k=;
        b=I1vOzydsny50wnBlWs89bP/mVA3icGRQWFZtG3Ai+P9MGYei0iay/sJRTFW7iWsEhP
         Pl07F0qbzXJYISyfeUZtlkBR/xybK6xr2KqtXPFKeCBqgpGnvLEeZs7qaZ5VStc1hEgZ
         t90aI3y9L2AYJ6eo3zqEctxSIlCPzDk/ezvkEjfPuiDnGyEs/Ln82GvL5ox3qJTouJLf
         te61DKWMSif4G0swWo1/dR4DnNr8naGh7xqdinwk/oaQZvw/r/3zG8ZiuTTjhzpnc8KK
         Zp1qxWaQ0d+8T4z/9OgPvnbJ4yvgpOPDLtAWXyGeeKE4CE85i623XdMV2EEn5T5kfDUb
         Or/g==
X-Gm-Message-State: AOAM533xE9m23+lWJEwai5BFTv/X5Tja5UFG+/Mc7PnrwE5FbVDsZhmR
        aN2jci4sCc80oR2P43Imp+lbbMlujiJ0jD30570=
X-Google-Smtp-Source: ABdhPJwzR7VXTRrZRR5BOdY7EvDKmkHZ5b/9fOg5BD5byoj8XxyWRZnQeAnjuuso57zt/vXIZPKgHBmMaylTyhaVFNQ=
X-Received: by 2002:a02:cc89:: with SMTP id s9mr4242657jap.81.1606554397527;
 Sat, 28 Nov 2020 01:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-3-sargun@sargun.me>
 <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com>
 <20201127221154.GA23383@ircssh-2.c.rugged-nimbus-611.internal> <CAOQ4uxiLRy9ioqaqtOp7P6hLy8Gx5vRO86mie7FAdTu2OfnGrw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiLRy9ioqaqtOp7P6hLy8Gx5vRO86mie7FAdTu2OfnGrw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 28 Nov 2020 11:06:26 +0200
Message-ID: <CAOQ4uxhra_RB98gJ7ovGhbUV1atCR1rMPnf63tT37WtrNC0asg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] overlay: Document current outstanding shortcoming
 of volatile
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 28, 2020 at 10:56 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > I notice you maintain overlay tests outside of the kernel. Unfortunately, I
> > think for this kind of test, it requires in kernel code to artificially bump the
> > writeback error count on the upperdir, or it requires the failure injection
> > infrastructure.
> >
> > Simulating this behaviour is non-trivial without in-kernel support:
> >
> > P1: Open(f) -> p1.fd
> > P2: Open(f) -> p2.fd
> > P1: syncfs(p1.fd) -> errrno
> > P2: syncfs(p1.fd) -> 0 # This should return an error
> >
>
> failure injection is an option. xfstest generic/019 is an example.
> generic/108 uses a different method and generic/361 uses a plain
> loop image over commit without any fault injection to trigger writeback
> errors.
>
> With current xfstests, check -overlay run (runs all generic tests with
> overlayfs over the configured base fs) all the 3 tests mentioned above
> will be skipped because of _require_block_device, but the requirement
> is there for a different reason for each of them.
>
> At first look, the loop device approach is the most generic one and could
> easily work also with overlayfs, so you could create an overlay specific
> test (non generic) based on generic/361, but it is not easy to use the
> helper _scratch_mkfs_sized, because check -overlay runs do not mkfs
> the base scratch fs.
>
> My recommendation would be to fix generic/019 in a similar manner
> to the way that tests that _require_scratch_shutdown were fixed to run
> with check -overlay:
>
> * Instead of _require_block_device, add a specific helper
>    _require_scratch_fail_make_request, which like _require_scratch_shutdown
>    knows how to deal with overlay FSTYP correctly
>
> * Instead of `_sysfs_dev $SCRATCH_DEV` use a helper _scratch_sysfs_dev
>    that knows how to deal with overlay FSTYP correctly
>

I missed:

* Instead of `blockdev --getsz $SCRATCH_DEV` use helper _scratch_blockdev_getsz

> This will add test coverage to overlayfs fsync/syncfs and then you can
> do one or both of:
> 1. Run 'check -overlay generic/019' with  OVERLAY_MOUNT_OPTIONS="volatile"
> 2. Fork an overlay specific test from the generic test that will test the
>     volatile error handling on every 'check -overlay -g quick' run
>
> #2 will provide better coverage against regressions in volatile writeback error
> handling and will be a good start for a test to reuse a volatile mount after
> writeback errors.
>
> Thanks,
> Amir.
