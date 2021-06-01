Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913C8397A04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 20:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhFASZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbhFASZZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:25:25 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5250DC061574;
        Tue,  1 Jun 2021 11:23:43 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e7so2365849ils.3;
        Tue, 01 Jun 2021 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0pBp2bOSzI+VDfi9SAgD6XQij5VdQmkbbjIGJEizdy4=;
        b=F6Cc9XGHqTWMpeJariO8d3Be+wYiiZh0pKRqeM5Z0Fk233pjF9oY1Ns8USRlPVhZ8z
         QW+G4Z5wb61UHV0oS7SBf4t360Qw8/jtXJCQG+SBYPv3RxLpCZTky6QYDokPsYgfokhQ
         7kbJUlt5v+QJIKH742yeTUajpeMecbY9PWRA45Hd8la3XwavDhWUOWvw6K/Jo2b/i5hV
         +kMkqCKytcvxDSb0VmXn6FXdZ+gnnqKiTskoqNVuGAtVbAJGVoVX/E/OkiuTWINTXZUk
         4zpZxrgtmQRqaZ/XsQ+683ll63h0jBiq9IjPwc9fsIk5YMf9I7QW7xcZDDyitKESm7+Y
         263g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0pBp2bOSzI+VDfi9SAgD6XQij5VdQmkbbjIGJEizdy4=;
        b=qa+8XlBLAGENnfFfsoT6Xq3S1HzGULWhJj1vHwknb0lOZPZJZ3aSghBCzdpoLBiFo+
         UQ6A4nLwDDImKnUv+Gh5Mn8Cpm7z7M4syyWxJbq0GJsSczNg8L2XXPpoyAPPYG7dO2EB
         wJ7e21v/+sZiPFUEcMrYoCv/gSe7cOzSYWRPWfrMEmjAigPzvsATHZ9upEExQGpycg2i
         dOyr0U2TXitMdtpNmhTiCeeptXyd2RB9TaGSjBl/YBY5AS23udYl+sjPn8H9GgueuDFL
         /QJIvV6OKrxBmMt/y5MB1s+J3sqDwOunn7OUYqCC3KWbYpUuWLr8uMeoy9rMYJz/XRpe
         HhVA==
X-Gm-Message-State: AOAM531kMkxBkCquaXLxrcGpbNU3hCrTLFRvIoIuMxGPidhPgw7Mlqwi
        ODU5FkNpAmcFizyIH9SavvDpbYp2lxZ5EIe0KkYe8Rlz
X-Google-Smtp-Source: ABdhPJxQWYbGMXPhCbB3ZX4yiu6zZQePPyQad/tPInameWhpIOKKMwlEnpvjEuI5SQeXZVdqjlhsy1+Kf220QucvZs0=
X-Received: by 2002:a05:6e02:1a67:: with SMTP id w7mr21865651ilv.137.1622571822724;
 Tue, 01 Jun 2021 11:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxgKr75J1YcuYAqRGC_C5H_mpCt01p5T9fHSuao_JnxcJA@mail.gmail.com>
 <CAJfpegviT38gja+-pE+5DCG0y9n3GUv4wWG_r3XmSWW6me88Cw@mail.gmail.com>
 <CAOQ4uxjNcWCfKLvdq2=TM5fE5RaBf+XvnsP6v_Q6u3b1_mxazw@mail.gmail.com>
 <CAJfpeguOLLV94Bzs7_JNOdZZ+6p-tcP7b1PXrQY4qWPxXKosnA@mail.gmail.com>
 <CAOQ4uxiJRii2FQrX51ZDmw_kGWTNvL21J7=Ow_z6Th_O-aruDA@mail.gmail.com>
 <20210601144909.GC24846@redhat.com> <CAOQ4uxgDMGUpK35huwqFYGH_idBB8S6eLiz85o0DDKOyDH4Syg@mail.gmail.com>
 <4a85fc2f-8ee0-9772-0347-76221a13ef95@redhat.com>
In-Reply-To: <4a85fc2f-8ee0-9772-0347-76221a13ef95@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 1 Jun 2021 21:23:31 +0300
Message-ID: <CAOQ4uxgcDBCD1xSDv-yuknyA4bN-qLBrFXwjMyT8RdMM5ZZc-g@mail.gmail.com>
Subject: Re: virtiofs uuid and file handles
To:     Max Reitz <mreitz@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >> But this does not help with persistent file handle issue for fuse
> >> client.
> >>
> > I see. Yes that should work, but he'd still need to cope with reused
> > inode numbers in case you allow unlinks from the host (do you?),
> > because LOOKUP can find a host fs inode that does not match
> > the file handle of a previously found inode of the same ino.
>
> That=E2=80=99s indeed an issue.  My current approach is to use the file h=
andle
> (if available) as the key for lookups, so that the generation ID is
> included.
>
> Right now, we use st_ino+st_dev+mnt_id as the key.  st_dev is just a
> fallback for the mount ID, basically, so what we=E2=80=99d really need is=
 inode
> ID + generation ID + mount ID, and that=E2=80=99s basically the file hand=
le +
> mount ID.  So different generation IDs will lead to lookup
> finding/creating a different inode object (lo_inode in C virtiofsd,
> InodeData in virtiofsd-rs), and thus returning different fuse_ino IDs to
> the guest.
>
> (See also:
> https://gitlab.com/mreitz/virtiofsd-rs/-/blob/handles-for-inodes-v4/src/p=
assthrough/mod.rs#L594)
>

I see, because you do not require persistent inode numbers.
That makes sense if you do not need to export file handles to NFS
and if you are not evicting inode objects from the server inodes map.

Please keep me posted if there are any updates on LOOKUP_HANDLE.

Thanks,
Amir.
