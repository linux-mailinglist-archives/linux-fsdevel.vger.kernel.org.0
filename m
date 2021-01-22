Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3FE3010F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 00:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbhAVX1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 18:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbhAVX1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:27:45 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C752C061786
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 15:27:03 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e22so14694816iom.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 15:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuooQLj08FTndW6GG4FNdPUFeSvF4QeyXpQNaZQvMQU=;
        b=YZ6nQ6FOxluHSewTFEdRxogFELFzJ61SLsAvjLFQZbuTGGMmwsF7JRUaxP7S0eEf3O
         zi4YxhJ311FM5HaM9OKi926md/9trhVY4f8oQ2L69cHtC8SiOc/RvEONC0Brp8EzYXLW
         lv6khpaUQGj21NLNM2haXeFieuHFHlPe5MsuHoJAAixyciIG/WrLFSbzGXn8urZA33tw
         GkWrMip0Wro8nMmVc+kl4jfg0hBCevvC6rr682OGhXTOkMjl301uDZC7QbGb7Yz/vxMK
         LBlL4RWfi61+hAnVPZfXrIwr9DYcO/sReuxxZfpkbORXS6rvMYifp7nAEYX563UTR1UV
         Vw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuooQLj08FTndW6GG4FNdPUFeSvF4QeyXpQNaZQvMQU=;
        b=KlfJcK+9R+bDQnL76B3LxqTVTlDx42+f+AZZ+U9+qSHZ57A2z7HU76ZOxUulCFmud6
         ByO5giHbYMMNZiWfTZLAhZCSkPCAzdyNZ0gRjpliySs3tJsdzdsIjR4oGdE4/xKXw692
         lhcyop7AXnZlxhV/4S8/cAsKJdUCw0gAVdIBr20eXE0GBHYA1nPfKXOMB1ZHkip1cFxo
         +lNG4oxVHNdTWASOk1+pXbJGCkNbG7Znf+Q3fndyHbx8znCbcg5VMI6hVoLpuvHdff+T
         EHHXH0SYFuf5paoUzxPs/7j8mtubwQxq4mPYm63sp5QmbtoPdb56Uqo/sCGRWcyGIv+H
         gqKw==
X-Gm-Message-State: AOAM532Msee+YlJXURUypUe0SFPo+d3jcPYIYrLQ0KfW68I0w0EPHWwL
        zBOHBQU4ZY0olwNvzRjeLMzdULPp12kXawBrh0Ej3w==
X-Google-Smtp-Source: ABdhPJx2/n88EpZhF9H0QRhbuIUDjLNzHy/G5ah/y4Nn1FpXH6Y4ko0ibuQnyPTD5D1W2NrSUOQ62tixsem0o23bO4I=
X-Received: by 2002:a92:4101:: with SMTP id o1mr174997ila.82.1611358022134;
 Fri, 22 Jan 2021 15:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20210115181819.34732-1-ebiggers@kernel.org>
In-Reply-To: <20210115181819.34732-1-ebiggers@kernel.org>
From:   Victor Hsieh <victorhsieh@google.com>
Date:   Fri, 22 Jan 2021 15:26:48 -0800
Message-ID: <CAFCauYN12bWRn2N+uP455KuRmz7CQkCBXnz0B2sr5kCQtpJo4A@mail.gmail.com>
Subject: Re: [PATCH 0/6] fs-verity: add an ioctl to read verity metadata
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LGTM. Thanks!

Reviewed-by: Victor Hsieh <victorhsieh@google.com>

On Fri, Jan 15, 2021 at 10:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> [This patchset applies to v5.11-rc3]
>
> Add an ioctl FS_IOC_READ_VERITY_METADATA which allows reading verity
> metadata from a file that has fs-verity enabled, including:
>
> - The Merkle tree
> - The fsverity_descriptor (not including the signature if present)
> - The built-in signature, if present
>
> This ioctl has similar semantics to pread().  It is passed the type of
> metadata to read (one of the above three), and a buffer, offset, and
> size.  It returns the number of bytes read or an error.
>
> This ioctl doesn't make any assumption about where the metadata is
> stored on-disk.  It does assume the metadata is in a stable format, but
> that's basically already the case:
>
> - The Merkle tree and fsverity_descriptor are defined by how fs-verity
>   file digests are computed; see the "File digest computation" section
>   of Documentation/filesystems/fsverity.rst.  Technically, the way in
>   which the levels of the tree are ordered relative to each other wasn't
>   previously specified, but it's logical to put the root level first.
>
> - The built-in signature is the value passed to FS_IOC_ENABLE_VERITY.
>
> This ioctl is useful because it allows writing a server program that
> takes a verity file and serves it to a client program, such that the
> client can do its own fs-verity compatible verification of the file.
> This only makes sense if the client doesn't trust the server and if the
> server needs to provide the storage for the client.
>
> More concretely, there is interest in using this ability in Android to
> export APK files (which are protected by fs-verity) to "protected VMs".
> This would use Protected KVM (https://lwn.net/Articles/836693), which
> provides an isolated execution environment without having to trust the
> traditional "host".  A "guest" VM can boot from a signed image and
> perform specific tasks in a minimum trusted environment using files that
> have fs-verity enabled on the host, without trusting the host or
> requiring that the guest has its own trusted storage.
>
> Technically, it would be possible to duplicate the metadata and store it
> in separate files for serving.  However, that would be less efficient
> and would require extra care in userspace to maintain file consistency.
>
> In addition to the above, the ability to read the built-in signatures is
> useful because it allows a system that is using the in-kernel signature
> verification to migrate to userspace signature verification.
>
> This patchset has been tested by new xfstests which call this new ioctl
> via a new subcommand for the 'fsverity' program from fsverity-utils.
>
> Eric Biggers (6):
>   fs-verity: factor out fsverity_get_descriptor()
>   fs-verity: don't pass whole descriptor to fsverity_verify_signature()
>   fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl
>   fs-verity: support reading Merkle tree with ioctl
>   fs-verity: support reading descriptor with ioctl
>   fs-verity: support reading signature with ioctl
>
>  Documentation/filesystems/fsverity.rst |  76 ++++++++++
>  fs/ext4/ioctl.c                        |   7 +
>  fs/f2fs/file.c                         |  11 ++
>  fs/verity/Makefile                     |   1 +
>  fs/verity/fsverity_private.h           |  13 +-
>  fs/verity/open.c                       | 133 +++++++++++------
>  fs/verity/read_metadata.c              | 195 +++++++++++++++++++++++++
>  fs/verity/signature.c                  |  20 +--
>  include/linux/fsverity.h               |  12 ++
>  include/uapi/linux/fsverity.h          |  14 ++
>  10 files changed, 417 insertions(+), 65 deletions(-)
>  create mode 100644 fs/verity/read_metadata.c
>
>
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
> --
> 2.30.0
>
