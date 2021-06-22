Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACAB3AFD35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 08:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhFVGsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 02:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhFVGsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:48:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CA7C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 23:46:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1267345pjx.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMoLrGlSbu/NzvNfg8sSjGZ2Kjr0hCAtYkm6MqdTFW4=;
        b=IKCt8gbqXEwvJj90xlCYZ1zG/PUJyKhJGk1x7qGc3X6gj/8fkg7xQUiR1geaaZv3xx
         Yu3zkA79fSRpaPzweHV7gD2epI7I68PBpjyBNhCIhWr1pCspvrZ3sWbWFdtv5KSGFd+w
         xpdw65ar/IS3hxGgaqbf/JHfQXirOVcsiF/5G+hA5p1oOtHzrfk92OfMA4Lkqw0IcL96
         bW2Av6f1i8wPaWgKFEePR7v5F1FY/CvPQQaamZHusXxUIP4+W2R5Pmz5Pre5BTS3TNRr
         jNF5EawzrqxvBp+E6bxraH5JhbO7ohLorAEblGVENboZMmUZw+mdwNRY/TrkbFzRlTlF
         pelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMoLrGlSbu/NzvNfg8sSjGZ2Kjr0hCAtYkm6MqdTFW4=;
        b=qyqQazY7m5WhN2b7W/O5JT6+MKJaH3yBY82TNc3bAMXZJ4cDPNJRjORIORgFiwkZRO
         QSEi54TI2USgBt6n/vKrTFFk43vRXh6Q29VgLfrucURzZK8M2zKgoeZTnUwSL0jKC3jE
         IrbIyzLkjeTrWrYSCJJNj9MzHzu6fqJRN+jN1osn0jaBruHdo5dUG4eO+498G09w/HZp
         MPSbrpvmtOHugeE2qxME0rHP002kUAF8tzv6jH3LKrwfyFh1wghl1/MskL87YNSggf0G
         p0ofRF19Oi8X9WVqiK7uM1OB9SxOLnfhR4fZ00ti6XdHJA4xKawaSQf2fSUm2FVO75e4
         3T9Q==
X-Gm-Message-State: AOAM530+ibhqDmTv7373mg1yCSo5BFJge0w2fXSKsnwjy8H3gR1s5ezN
        2rxU8nB6u9anl1WkikJD7AYg/WFgzo0NQnc3Bzs=
X-Google-Smtp-Source: ABdhPJwOyTRb4to26ZMFyWYSb5Z9+c8MEZRrA3pMPitdPYRom8Ce5oWhvOpBhgBx+hjuJvxJfURbrTFNsPKaZ0i++Jk=
X-Received: by 2002:a17:90a:ee85:: with SMTP id i5mr2466398pjz.156.1624344384103;
 Mon, 21 Jun 2021 23:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com> <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
 <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net> <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
 <295cfc39-a820-3167-1096-d8758074452d@metux.net> <CA+a=Yy7DDrMs6R8qRF6JMco0VOBWCKNoX7E-ga9W2Omn=+QUrQ@mail.gmail.com>
 <e70a444e-4716-1020-4afa-fec6799e4a10@metux.net> <CA+a=Yy4iyMNK=8KxZ2PvB+zs8fbYNchEOyjcreWx4NEYopbtAg@mail.gmail.com>
 <6d58bd0f-668a-983a-bf7c-13110c02dae0@metux.net> <CA+a=Yy5rnqLqH2iR-ZY6AUkNJy48mroVV3Exmhmt-pfTi82kXA@mail.gmail.com>
 <65fc0313-b01b-9882-d716-d5a2911222b7@metux.net>
In-Reply-To: <65fc0313-b01b-9882-d716-d5a2911222b7@metux.net>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Tue, 22 Jun 2021 14:46:12 +0800
Message-ID: <CA+a=Yy6B09=B-4DESX6HChVSjCF2CraQeUT5Pb0H5uX9R4F+bg@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 3:07 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 17.06.21 15:23, Peng Tao wrote:
>
> >> Just keeping fd's open while a server restarts ?
> >> If that's what you want, I see much wider use far outside of fuse,
> >> and that might call for some more generic approach - something like
> >> Plan9's /srv filesystem.
> >>
> > 1. keeping FDs across userspace restart
>
> if application needs to be rewritten for that anyways, there're other
> ways to achieve this, w/o touching the kernel at all - exec() doesn't
> automatically close fd's (unless they're opened w/ O_CLOEXEC)
Or application recovery after panic ;)

>
> > 2. help save FD in the FUSE fd passthrough use case as implemented by
> > Alessio Balsini
>
> you mean this one ?
>
> https://lore.kernel.org/lkml/20210125153057.3623715-1-balsini@android.com
>
> I fail to see why an extra fd store within the fuse device is necessary
> for that - I'd just let the fuse daemon(s) reply the open request with
> the fd it already holds.
Alessio already has a similar implementation in his patchset. The RPC
patch tries to make it generic and thus usable for other use cases
like fuse daemon upgrade and panic-recovery.b

>
> I'd hate to run into situations where even killing all processes holding
> some file open leads to a situation where it remains open inside the
> kernel, thus blocking e.g. unmounting. I already see operators getting
> very angy ... :o
This is really a different design approach. The idea is to keep an FD
active beyond the lifetime of a running process so that we can do
panic recovery. Alessio's patchset has similar side effect in some
corner cases and this RFC patch makes it a semantic promise. Whether
ops like it would really depend on what they want.

>
> by the way: alessio's approach is limited to simple read/write
> operations anyways - other operations like ioctl() don't seem to work
> easily that way.
>
> and for the creds switching: I tend to believe that cases where a fs or
> device looks at the calling process' creds in operations on an already
> open fd, it's most likely a bad implementation.
>
I agree but I understand the rationale as well. A normal FUSE
read/write uses FUSE daemon creds so the semantics are the same.
Otherwise as you outline below, we'd have to go through all the
read/write callbacks to make sure none of them is checking process
creds.

> yes, some legacy drivers actually do check for CAP_SYS_ADMIN e.g. for
> low level hardware configuration (e.g. IO and IRQ on ISA bus), but I
> wonder whether these are use at all in the our use cases and should be
> ever allowed to non-root.
>
> do you have any case where you really need to use the opener's creds ?
> (after the fd is already open)
>
> >> Does FUSE actually manipulate the process' fd table directly, while
> >> in the open() callback ?
> >
> > hmm, you are right. The open() callback cannot install FD from there.
> > So in order for your use case to work, the VFS layer needs to be
> > changed to transparently replace an empty file struct with another
> > file struct that is prepared by the file system somewhere else. It is
> > really beyond the current RFC patch's scope IMHO.
>
> Exactly. That's where I'm struggling right now. Yet have to find out
> whether I could just copy from one struct file into another (probably
> some refcnt'ing required). And that still has some drawback: fd state
> like file position won't be shared.
>
> I've been thinking about changing the vfs_open() chain so that it
> doesn't pass in an existing/prepared struct file, but instead returns
> one, which is allocated further down the chain, right before the fs'
> open operation is called. Then we could add another variant that
> returns struct file. If the new one is present, it will be called,
> otherwise a new struct file is allocated, the old variant is called
> on the newly allocated one, and finally return this one.
>
> this is a bigger job to do ...
>
Agreed.

Cheers,
Tao

-- 
Into Sth. Rich & Strange
