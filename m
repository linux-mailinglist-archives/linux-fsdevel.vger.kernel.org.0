Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22EB44AC5D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 12:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245634AbhKILSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 06:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbhKILSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:18:53 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEA2C061764;
        Tue,  9 Nov 2021 03:16:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g14so74528571edz.2;
        Tue, 09 Nov 2021 03:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rVsY0bOoMyeQFsYvQfJLYPtYkclxmkriKyxzCkOTXMg=;
        b=YahIOPb2qtFmAXmun3nR9l/ho8hUkKHZyHvVAvuE9kDrF6V7BoL2j4P054zaPHV3XF
         p1asyOuoleg4QJFUWzQN+pqmrBN0JgTdLYe5rsvsTmcmwk8pYX2VGq1MJAw9SbDXeazJ
         K2Ffx0HZfDzUGt/YnQJgM//hYH23/M6fChf+oDgj8WaYH5pa3HcAC9dxCtctC/mDUzMr
         BfwXx7nr8izK0LqATpJMRYvYAeUkZ//Tuo7SKdmwQGTK0jn54Sfv4I8dLzma8R0Pv85I
         hxTcsWLYnQ6UgfMlnN1sSfUxMHwfLtBppJSkaAEhxkH9RWzjRwDF7JCqogCwo4IjODqq
         HsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rVsY0bOoMyeQFsYvQfJLYPtYkclxmkriKyxzCkOTXMg=;
        b=ryLixoOSuBNDQ/Sis2R7rcloQFyKOZxuRU5shCsRnWgqB3yFdXZB9AizFNyoiYNiXW
         lVXTrgFISGwNT4Xkf44JUscaK9FjNPLl/uLYOcWM57L6u6V2Av286R8xU3NtYwzLEASa
         AdojPfat47LA2cfPYvlK7p3HkZyoKtxgjJsHQ2VdHJPH7oZI1J7g3m7Y8BjoSz5JydwM
         +UF9f7BsoojhaOu0k3TG/CjKmlN9uZz3pEsDzburqVtHDeTjeHdrvDNTkAP7pKS/XWIT
         IXNW3qOqC4Fk41PC/XgcWCHJQwmYAGRuf3dlJs+NcvobMoX5KuCViSR/Oz7RLVxf0470
         fjmQ==
X-Gm-Message-State: AOAM532C93YvPDaA37B8S+dET9yi4s/r1GcymiPF83EI+XzrXI29WRu+
        J+rdI48WBQC+lI9TjghN4A/1B3rYVEpZUvddjKYNL+6N3Ls=
X-Google-Smtp-Source: ABdhPJzQ1KrAe4zoA1w0iikZNSeX4IFNasgdzFgtAvBS7Sxn2unVRfdx+qvtVYnyIBY69xv5eswfCYx/TYLXEzzlvIk=
X-Received: by 2002:a17:906:2ad2:: with SMTP id m18mr8841239eje.64.1636456565939;
 Tue, 09 Nov 2021 03:16:05 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
In-Reply-To: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 9 Nov 2021 16:45:54 +0530
Message-ID: <CAOuPNLgquwOJg85kDcf67+4kTYP9N=45FvV+VDTJr6txYi5-wg@mail.gmail.com>
Subject: Re: Kernel-4.14: With ubuntu-18.04 building rootfs images and booting
 gives SQUASHFS error: xz decompression failed, data probably corrupt
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com, Phillip Lougher <phillip@squashfs.org.uk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Florian Fainelli <f.fainelli@gmail.com>,
        sumit.semwal@linaro.org, adriens@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Mon, 8 Nov 2021 at 20:00, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
> Here are few details.
> * Linux Kernel: 4.14
> * Processor: Qualcomm Arm32 Cortex-A7
> * Storage: NAND 512MB
> * Platform: Simple busybox
> * Filesystem: UBIFS, Squashfs
> * Build system: Linux Ubuntu 18.04 with Yocto build system
> * Consists of nand raw partitions, squashfs ubi volumes.
>
> What we are trying to do:
> We are trying to boot dm-verity enabled rootfs on our system.
> The images for rootfs were generated on Ubuntu 18.04 machine using
> Yocto build system.
>
> Issue:
> Earlier, when we were using Ubuntu 16.04 to generate our images, the
> system was booting fine even with dm-verity enabled.
> Recently we switched to Ubuntu 18.04 build machine, and now with the
> same changes we are seeing the below squashfs error, just after the
> mount.
> Note: with 18.04 also our rootfs is mounting successfully and
> dm-verity is also working fine.
> We only get these squashfs errors flooded in the boot logs:
> {{{
> ....
> [    5.153479] device-mapper: init: dm-0 is ready
> [    5.334282] VFS: Mounted root (squashfs filesystem) readonly on device 253:0.
> ....
> [    8.954120] SQUASHFS error: xz decompression failed, data probably corrupt
> [    8.954153] SQUASHFS error: squashfs_read_data failed to read block 0x1106
> [    8.970316] SQUASHFS error: Unable to read data cache entry [1106]
> [    8.970349] SQUASHFS error: Unable to read page, block 1106, size 776c
> [    8.980298] SQUASHFS error: Unable to read data cache entry [1106]
> [    8.981911] SQUASHFS error: Unable to read page, block 1106, size 776c
> [    8.988280] SQUASHFS error: Unable to read data cache entry [1106]
> ....
> }}}
>
Just one question:
Is there any history about these squashfs errors while cross-compiling
images on Ubuntu 18.04 or higher ?


Thanks,
Pintu
