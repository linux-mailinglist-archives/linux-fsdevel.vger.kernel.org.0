Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4F92C7501
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 23:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbgK1Vt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbgK1S52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:57:28 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2895C02B8ED;
        Sat, 28 Nov 2020 00:56:42 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id a19so6639315ilm.3;
        Sat, 28 Nov 2020 00:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=On7srdy0/TdSxd0+F9jkJfCVKZfYH3vASimHmr7KFgA=;
        b=cfrxJQBJoIZl4NsGfhAzAbbegtPgs53PgmrPipjNQgSty+JEr/Qrfx7kCsUPohRITZ
         ZfDxq67/VDFyg/mCtSaQjm1zckIVgMLooXvbSZ+yWbjjUAi0oNyvvxy+V0PMMB+z0tJP
         JnqQ4cQOUSlrFLRnJThcU2wyJ2Hb8xggwbcxB57CaZChoown0anqdBGBBLI+VgIMhq85
         gfXalMu2jm+ugt7LAM3e58oiLu96Z0pkfl/1GUEb3aXLf7HTX/3ffgc/PxkKxTZ5gw7K
         g60QEPcFi8uZ7k7cVl+Hqkmo2fmdptSeKVPLzfwmomghb2G9RI/CcLAf/Z4zqocupl5y
         GTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=On7srdy0/TdSxd0+F9jkJfCVKZfYH3vASimHmr7KFgA=;
        b=ZZBEDXZibNuWgoYW7F54+HWARSby5z4/VbnH4Dbcd+QYFjZPV0zNe3K6uZZCdKFKrQ
         LM/fAVBVJCF/0Eogn1TXoayg1gRV8eqkw/vp7jcrHerpv8DaaWO395hieKvBNY5D2lGQ
         mby7oW+PkX2f3BGXZWNugOOeP65VKruV9xIVDQfDYPQdd4V998NJQFMzlaaqzWs3L3jI
         GBTdOkgsDL1lK7kpXTfahdZ1mGJALXlh+L8zeG3JkZwrPSyubh4YDevW6gcmPY2NPXA7
         TZEVI2jyOIe9ZfHZqtWPWU/S3qCvC5E/8wEIwJk6G/zMKGZS7bAcNWLjZmMvQ9mg2dxs
         REjA==
X-Gm-Message-State: AOAM533BE4mIbZbr6Ru7tqLajwBrGMMrlgw70g1dHMxURqXTlL3dBfyl
        jHaiKK5uFiWRe2e1oiGeh/Q83aDiwmFcO3pqcfs=
X-Google-Smtp-Source: ABdhPJzP8Sp+e1mwcr1OUIllQ/G6nfnGLb51UAEdFFXi14s8dEVhbFViKPDbjE+9LIIcEB6LnjQRV62CjZyM/kCr//U=
X-Received: by 2002:a92:da82:: with SMTP id u2mr10683732iln.137.1606553801985;
 Sat, 28 Nov 2020 00:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20201127092058.15117-1-sargun@sargun.me> <20201127092058.15117-3-sargun@sargun.me>
 <CAOQ4uxgaLuLb+f6WCMvmKHNTELvcvN8C5_u=t5hhoGT8Op7QuQ@mail.gmail.com> <20201127221154.GA23383@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20201127221154.GA23383@ircssh-2.c.rugged-nimbus-611.internal>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 28 Nov 2020 10:56:30 +0200
Message-ID: <CAOQ4uxiLRy9ioqaqtOp7P6hLy8Gx5vRO86mie7FAdTu2OfnGrw@mail.gmail.com>
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

> I notice you maintain overlay tests outside of the kernel. Unfortunately, I
> think for this kind of test, it requires in kernel code to artificially bump the
> writeback error count on the upperdir, or it requires the failure injection
> infrastructure.
>
> Simulating this behaviour is non-trivial without in-kernel support:
>
> P1: Open(f) -> p1.fd
> P2: Open(f) -> p2.fd
> P1: syncfs(p1.fd) -> errrno
> P2: syncfs(p1.fd) -> 0 # This should return an error
>

failure injection is an option. xfstest generic/019 is an example.
generic/108 uses a different method and generic/361 uses a plain
loop image over commit without any fault injection to trigger writeback
errors.

With current xfstests, check -overlay run (runs all generic tests with
overlayfs over the configured base fs) all the 3 tests mentioned above
will be skipped because of _require_block_device, but the requirement
is there for a different reason for each of them.

At first look, the loop device approach is the most generic one and could
easily work also with overlayfs, so you could create an overlay specific
test (non generic) based on generic/361, but it is not easy to use the
helper _scratch_mkfs_sized, because check -overlay runs do not mkfs
the base scratch fs.

My recommendation would be to fix generic/019 in a similar manner
to the way that tests that _require_scratch_shutdown were fixed to run
with check -overlay:

* Instead of _require_block_device, add a specific helper
   _require_scratch_fail_make_request, which like _require_scratch_shutdown
   knows how to deal with overlay FSTYP correctly

* Instead of `_sysfs_dev $SCRATCH_DEV` use a helper _scratch_sysfs_dev
   that knows how to deal with overlay FSTYP correctly

This will add test coverage to overlayfs fsync/syncfs and then you can
do one or both of:
1. Run 'check -overlay generic/019' with  OVERLAY_MOUNT_OPTIONS="volatile"
2. Fork an overlay specific test from the generic test that will test the
    volatile error handling on every 'check -overlay -g quick' run

#2 will provide better coverage against regressions in volatile writeback error
handling and will be a good start for a test to reuse a volatile mount after
writeback errors.

Thanks,
Amir.
