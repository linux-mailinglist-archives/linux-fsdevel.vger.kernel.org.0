Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9273DBD6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhG3Q5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhG3Q5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:57:39 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4CCC06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 09:57:33 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y200so12235836iof.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vMrhHxq2Fz8e6Gv8iJtBi5orK+B6mypyqmy4OKkzLw=;
        b=PWS130CeczEUvv0MBpfhpjSeFGPh9jIxLDs8mhnI9lOcsy6MgNNeKz81co+++BhxCT
         2Sjrz+QgXK/a4mRyu4XKO+m3adXz5jQHE1PEk6i6VTQnl8k7ZyUVOEGQijBVBQYiKXaV
         19Zp9P6/5Y8BlP1jcsS3lxo3Bf9VsZuH0Npi//qVGfd0sVQjT2SxmV8XJkitivyv+Rmg
         AK1jgyb7XSeZGVDDI6wWjs15RQ1O0T+bYQ9GWMQBuCUyDD6T2G8i5t0Y1L0X3i0DK5V/
         +N/aTi5l1kggDkz6SFoX8bk7pDCv9zkXpvIq0mJ2uXvGU5cfWJtpEbg+kxVv9cqg7kF+
         GHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vMrhHxq2Fz8e6Gv8iJtBi5orK+B6mypyqmy4OKkzLw=;
        b=GkAZwT55ICiz8y26SzhxCj3v5nWAOVlcZ9oa04rz+r6dUq05oUAJBthE+pdFd53WRt
         58N+lF+BRPoiILDRvIiVdItZ/yYn81aUlmJ4zBMGZLM1lbgoTW2WnFiNPyyhLZ6R9iuh
         DcIOnNrUYM1PizVnxrIjHJRbtZz/Yim/+2dRFG0rZ4zxvM6UJFDn7BWgfy4uBWUYWx6w
         W1/ZifwwHWMJu9WQDQ43er35eAWIblI7H9MLoI6FUgMf5uYFfPxSKpRP57aFgWLVfj7x
         hxY/arJOeOLMSQdKs17MtdpD7Nnzm6y2nwxxi91Veymw86fUcywWmaMsgtGRk7gsW00b
         6+aw==
X-Gm-Message-State: AOAM530iCEHQ5jFg2f3HE6pnkYKpwDPDuL0omluw1e6zi/tor8URkXD2
        xwZFgy/AqEsSDlqWQgsXSGneDPRip6EoFk05RLM=
X-Google-Smtp-Source: ABdhPJzRgmkq/i47iXUmcpeHtbdI6SsJOyte6tu6ONPyl+PyCnu3u5F0++/7XJq7ewknxRzyAQhGKo29t2M7jauEok4=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr2000558ion.203.1627664252922;
 Fri, 30 Jul 2021 09:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <f183fb32-3f08-94f1-19b9-6fe2447b168c@samba.org>
In-Reply-To: <f183fb32-3f08-94f1-19b9-6fe2447b168c@samba.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 30 Jul 2021 19:57:22 +0300
Message-ID: <CAOQ4uxgPK+cj2BMuA2EmfkygLmJj0gXk5mM3zZOw9ftR4+Mf1Q@mail.gmail.com>
Subject: Re: Allowed operations on O_PATH handles
To:     Ralph Boehme <slow@samba.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>, Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:25 PM Ralph Boehme <slow@samba.org> wrote:
>
> Hi!
>

Hi Ralph!

> A recent commit 44a3b87444058b2cb055092cdebc63858707bf66 allows
> utimensat() to be called on O_PATH opened handles.
>
> If utimensat() is allowed, why isn't fchmod()? What's the high level
> rationale here that I'm missing? Why is this not documented in man openat.2?
>

As you noticed, there is no uniformity among the various filesystem syscalls,
but there are some common guidelines.

1. O_PATH fds are normally provided as the dirfd argument to XXXat()
    calls (such as utimensat()).
2. When the syscall supports empty name with dirfd to represent the
    O_PATH fd object itself, an explicit AT_EMPTY_PATH is required

So the commit above simply brings utimensat() up to standards.

>  From man openat.2
>
>    O_PATH (since Linux 2.6.39)
>
>      Obtain a file descriptor that can be used for two purposes:
>      to indicate a location in the filesystem tree and to perform
>      operations that act purely at the file descriptor level. The
>      file itself is not opened, and other file operations (e.g.,
>      read(2),  write(2),   fchmod(2),   fchown(2),   fgetxattr(2),
>      ioctl(2), mmap(2)) fail with the error EBADF.
>      ...
>
> My understanding of which operations are allowed on file handles opened
> with O_PATH was that generally modifying operations would not be
> allowed, but only read access to inode data.
>

I think the rationale is that they are allowed when a user explicitly
requests to use them via a new XXXat(..., AT_EMPTY_PATH) API.

write(),read(),mmap() are different because they access file data,
so it is required that the file is "really open".

Letting fgetxattr() accept an O_PATH was actually suggested [1],
but the author (Miklos) dropped it shortly after, because there is
already a safe API to achieve the same goal using magic /proc
symlink (see details in [1]).

If you need to operate on a (real) symlink target and you have an
O_PATH to the (real) symlink, you will need to work a bit harder.
Adding AT_EMPTY_PATH to fchmodat() and friends could make
this task easier and I don't think there would be an objection to do
that, just someone needs to drive the work...

fchmodat() specifically is a bit broken and an attempt to introduce
fchmodat2() was attempted [2], but did not go through.

> Can someone please help me to make sense of this?
>

Does that answer your question or do you have other needs
that the current API cannot provide?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOssrKeV7g0wPg4ozspG4R7a+5qARqWdG+GxWtXB-MCfbVM=9A@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20200916002335.GQ3265@brightrain.aerifal.cx/
