Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD831ADA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 20:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBMTBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Feb 2021 14:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhBMTBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Feb 2021 14:01:18 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DA8C061574;
        Sat, 13 Feb 2021 11:00:38 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id q23so1389209vsg.4;
        Sat, 13 Feb 2021 11:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMAUY9hS4bc4jUz/i8HmaZkUrdp7bHScBNSf6T3QN0Q=;
        b=IYPmykXjaJ+of/tsfhz0Qxd+UuprM9HQudcUmoCT7r7Wkl7k/IXPKHqFFarPMNhUdn
         HA3dg0a5wI7SrwY95vrZOHBRyciQR+t7vsAW2COeTr3TWy0hVHVTgjGYnKxt1U8t13fy
         +6caiJgI4relL342+VB5IT76x6yUzkj/LuIQwj7YMYfLS4aRWdlyvS1qllr7kM+DBOk7
         ZsNfmkuD/MfKNJpWB+GMp1cOWutJjaWqjelj2peq+Hu0LNiLIy7DbDr5tey9zpxbOFRX
         iltD6KqlF4s1Ao7IHLgTi10RG0veiZ968b9/AAKZ5+S1P/OqdDjH4+HnTFdAHRvVGXO9
         aZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMAUY9hS4bc4jUz/i8HmaZkUrdp7bHScBNSf6T3QN0Q=;
        b=m58uH0pgc34FxuvB25Ny4FBnYxSvFSZMT/mB5CUm7sQ4sPzJYboePJfpoXjgAyhpqq
         /dmXH8qcCtY/L9ZK0/mFXvJp0z/rKJCAnsJW9nBez6a3lHpO48kSQyjyxn+WWnJtjXze
         eeJ+KtUIWuohsKldK1Y+GE/NV9hrhLHc6qRfJjxmRIqj6AaTay/pcvHG9z+ilo2X0mDh
         C6WDYCRUC37aVYCcjAOnm2fV/rNownCFnxNp9oyM6X14+8bbrtNwMveBwAtNuMvxAaF2
         rj6eK4mogxJcetIbG2PdomSXE05gsuQxgQEuRKKhIBHzO8x2G0R45sz1rEov5BZQGhA8
         xYTA==
X-Gm-Message-State: AOAM531NgOO2JsO7XNdxgCTXYtAKhsQOyk99RufVKSr1lpw5OD97OMrp
        9TUBAJIMNt+APTuJG3oLFx+sQuKCpWowlxoDZ1o=
X-Google-Smtp-Source: ABdhPJxuna/b0FVJqzqRMmhj9/Uu7T/5ErOJjpQ8Izpc4OEQ8PPC371waXzT28SB9tlED9KTyyj25ZcdG3s3AahCnN0=
X-Received: by 2002:a67:f87:: with SMTP id 129mr4967716vsp.24.1613242837017;
 Sat, 13 Feb 2021 11:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20210212162416.2756937-1-almaz.alexandrovich@paragon-software.com>
 <20210212212737.d4fwocea3rbxbfle@spock.localdomain>
In-Reply-To: <20210212212737.d4fwocea3rbxbfle@spock.localdomain>
From:   Hanabishi Recca <irecca.kun@gmail.com>
Date:   Sun, 14 Feb 2021 00:00:26 +0500
Message-ID: <CAOehnrMK_9uP5j+QCF2qy_08yJEr_u9TEPwJJFogXQCeNFm6Gg@mail.gmail.com>
Subject: Re: [PATCH v21 00/10] NTFS read-write driver GPL implementation by
 Paragon Software
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kasep pisan <babam.yes@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 13, 2021 at 2:27 AM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:

> Hanabishi, babam (both in Cc), here [2] you've reported some issues with
> accessing some files and with hidden attributes. You may reply to this
> email of mine with detailed description of your issues, and maybe
> developers will answer you.

There is strange files access issue since v18 update. Some random
files on partition became inaccessible, can't be read or even deleted.
For example:

# ls -la
ls: cannot access 'NlsStrings.js': No such file or directory
total 176
drwxrwxrwx 1 root root  4096 Oct 20 10:41 .
drwxrwxrwx 1 root root 12288 Oct 20 10:42 ..
-rwxrwxrwx 1 root root  8230 Oct 19 17:02 Layer.js < this file is ok
-????????? ? ?    ?        ?            ? NlsStrings.js < this file is
inaccessible
...

To reproduce the issue try to mount a NTFS partition with deep
structure and large files amout. Then run on it some recursive file
command, e.g. 'du -sh', it will list all access errors.
Can't say what exactly causes it. Filesystem itself is not damaged,
when mounting it via ntfs-3g, ntfs3 <18 or in Windows it works
normally. The files is not damaged and chkdsk report no errors.
