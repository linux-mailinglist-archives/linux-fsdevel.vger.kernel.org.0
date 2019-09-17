Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F69B553A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 20:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfIQSUI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 14:20:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40320 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfIQSUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:20:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so4273714wmj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gMPmMtjRZPxIw/k279+mMi8Jf2DvDPBfQpmjNzYywc=;
        b=PB4L/yK8ulPV/nukp8omko4ITQzK80cpdJv6/4eo7jZoMK0K9TF024+t3Lr7ueJhXg
         lXk62P2B+U5xWo+pk7W39Cr1yFn/UIOFtY+s/IPA3xLBCg7+6vGnDf+ay2K12mXoxY24
         AIjbKhOEIz5cadqECbfC5bZTNlK9DyqO289AxHhOH/tCS6yh0AXYH+fcqGKIY4VmWWfy
         hN382HenaOcBQG88l0Pd927QjeFeCCkXtwrbbvmq/W1crlpdMJqxUcTF4Q5cV/dPQtJu
         euUTyUxQAha+QzWYXf3apcBksPzXwn1yN1BxgTXAjS2hsZidgenJ5soQNTsIkQbuEqaP
         ltBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gMPmMtjRZPxIw/k279+mMi8Jf2DvDPBfQpmjNzYywc=;
        b=BfWJ50pL5/OeuCZlMJLziybRc9KdUN0Ky3gZ5e0r4BY3NL6lc1/pBl2kdf1Jl5ZA+4
         AbiU4XY7Au4w10ywLGREGe4bXGAfHmWxgW5EO0VmQpQtlv74CRcQoUq3ETHgRKfl9f2Y
         uQ/iOYPEVb6i9Vg3WTlgmuTPG+4CCec6Nn1LIrFULHg2g1SFnlIeUsEIbKI2F05l7Rvy
         XSKaJ+OB31/SpK+HF63ZIEeE/R60NvXAHIt9eb8FZtv0GNklkwSxEbC1XNtNy+SNlDiY
         pgvOD7U0k4T7zv5gOJqpfaryDwRrUwEFRoWhJkHmo9w92B53yn+ZCeCIPnWxTQNV+tDa
         kCYw==
X-Gm-Message-State: APjAAAUwlYUru+M+xQmBeW2j5fvBH9iN0XN3yqGZfK65veUMvlXoOqzd
        cBHh2SNg16m7djpeQIhh1W8DPYb8Tizt5+7VnlA=
X-Google-Smtp-Source: APXvYqw7+r/zKzmVS2cQN6yklmnJuV6s1fcMW+W3PXWf3LAe+KK6DzlMpJ8tHdKd2tPU6eVvZDorLeQsmqGTNpQmVus=
X-Received: by 2002:a1c:234e:: with SMTP id j75mr4982833wmj.9.1568744406655;
 Tue, 17 Sep 2019 11:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190906100324.8492-1-stefanha@redhat.com> <CAFLxGvw-n2VYcYR9kei7Hu2RBhCG9PeWuW7Z+SaiyDQVBRiugw@mail.gmail.com>
 <20190909070039.GB13708@stefanha-x1.localdomain>
In-Reply-To: <20190909070039.GB13708@stefanha-x1.localdomain>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 17 Sep 2019 20:19:55 +0200
Message-ID: <CAFLxGvw51qeifCLwhV-8DKXNwC9=_5hFf==e7h4YCvFE5_Wz0A@mail.gmail.com>
Subject: Re: [PATCH] init/do_mounts.c: add virtiofs root fs support
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 9, 2019 at 9:00 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Fri, Sep 06, 2019 at 09:16:04PM +0200, Richard Weinberger wrote:
> > On Fri, Sep 6, 2019 at 1:15 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > I think you don't need this, you can abuse a hack for mtd/ubi in
> > prepare_namespace().
> > At least for 9p it works well:
> > qemu-system-x86_64 -m 4G -M pc,accel=kvm -nographic -kernel
> > arch/x86/boot/bzImage -append "rootfstype=9p
> > rootflags=trans=virtio,version=9p2000.L root=mtdfake console=ttyS0 ro
> > init=/bin/sh" -virtfs
> > local,id=rootfs,path=/,security_model=passthrough,mount_tag=mtdfake
>
> That is worse because:
> 1. The file system must be named "mtd*" or "ubi*".
> 2. When mounting fails you get confusing error messages about block
>    devices and partitions.  These do not apply to virtio-fs or
>    virtio-9p.

This is the current situation, I'm not saying it is perfect. But
before we add another
special case for a filesystem we should at least try to consolidate this stuff.

> > If this works too for virtiofs I suggest to cleanup the hack and
> > generalize it. B-)
>
> Why mtd and ubi block devices even have a special case?  Maybe this code
> was added because ROOT_DEV = name_to_dev_t(root_device_name) doesn't
> work for "mtd:partition" device names so the regular CONFIG_BLOCK code
> path doesn't work for these devices.

ubi and mtd are not block devices, they are character devices.
That's why the hack with name matching was added a long time ago.

> Given the ordering/fallback logic in prepare_namespace()/mount_root() I
> don't feel comfortable changing other code paths.  It's likely to break
> something.
>
> If you or others have a concrete suggestion for how to generalize this
> I'm happy to try implementing it.

mtd, ubi, virtiofs and 9p have one thing in common, they are not block devices.
What about a new miscroot= kernel parameter?

-- 
Thanks,
//richard
