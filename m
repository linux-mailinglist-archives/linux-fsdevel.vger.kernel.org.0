Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3193A71DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 00:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhFNWZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 18:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhFNWZW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:25:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7295AC061574;
        Mon, 14 Jun 2021 15:23:02 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id g22so4749607pgk.1;
        Mon, 14 Jun 2021 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Zy95WLjXytpC9PA0Bxhiy7YbVeAlOqBwSRRJi5/GujM=;
        b=ALA0aOO4zZ/Yj2B72JsrRI3+M+MYSKj13EqDlVPyLSQUWFdaA/VnpbK76WL2jKOiqP
         hYt52rVc99j0UMwW/g6MOGvC/HllLnTLXjGqXSzTQEIV1BcuHPStIZnOwutnryNWG7CU
         QqxeSXKIKoPRdLD98BhfXPh4WQRDpxupBY5+aLaAHj8qUeKfeaEkcCljWMkVdGD6g81m
         YfNWz45tYBbe95GLCSkWrkMBLiqdrhL0xy9Frg1cFBlTNi3Clb7MzbxbbO8HcdsIzxk4
         XdqO3tDR2rijzANi2X3FV1k6IXaKcwe25XSUBSqWANdPSyD3c5JXpTaQUN9xnt6LCbTg
         NQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zy95WLjXytpC9PA0Bxhiy7YbVeAlOqBwSRRJi5/GujM=;
        b=DKjVCX0eGa4mF90J1Ljjs6Jn4YKIq8KDR8QMD8aYDIi8VHdSqNe1AlrtsxerO8/sTF
         G+zUbu6t/y91rbVs27L4uJClovEM1FKVOwz9KJ07eYlZPwWqXc5Y8/QB7dksJKAUZ6WM
         Xifbobms/Y/ARHNZYDSV6eyycC06pI5F1EDu5Y0HL3HQ8+wY50GpoekmluqofrBcHNmq
         sJ577IybzZ9AT929ubdp0WRK9CXtf3gGyljOXzl/Vdb2kkO7w2QcHx/UAFpErqCtzhCX
         J2VZ+yXkcudkXsuWq77imgEI41W1J98vMFShbMGjHUPt/gKwltZGiIQg5rxv35477I6D
         w0ig==
X-Gm-Message-State: AOAM533mcYcywlVBXspR9AyS7kPWwD6L7KLUvacZ4TBQhC+zIrhkk6Qz
        WNzuqxhO9mpRkjTS5w8ZLM8=
X-Google-Smtp-Source: ABdhPJwUd6Nup08PI/tjLofl2mSwnNASXdMDiGciIRaq/f9u2R8lD0tO32rgpptldT+MPMBtmqJ++A==
X-Received: by 2002:a63:a50a:: with SMTP id n10mr19105289pgf.13.1623709380953;
        Mon, 14 Jun 2021 15:23:00 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i74sm14395769pgc.85.2021.06.14.15.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 15:23:00 -0700 (PDT)
Subject: Re: Kernel 4.14: SQUASHFS error: xz decompression failed, data
 probably corrupt
To:     Pintu Agarwal <pintu.ping@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel@kvack.org, Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>
References: <CAOuPNLi8_PDyxtt+=j8AsX9pwLWcT4LmVWKj+UcyFOnj4RDBzg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dacd3fd3-faf5-9795-1bf9-92b1a237626b@gmail.com>
Date:   Mon, 14 Jun 2021 15:22:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOuPNLi8_PDyxtt+=j8AsX9pwLWcT4LmVWKj+UcyFOnj4RDBzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/14/2021 3:39 AM, Pintu Agarwal wrote:
> Hi All,
> 
> With Kernel 4.14 we are getting squashfs error during bootup resulting
> in kernel panic.
> The details are below:
> Device: ARM-32 board with Cortex-A7 (Single Core)
> Storage: NAND Flash 512MiB
> Kernel Version: 4.14.170 (maybe with some Linaro updates)
> File system: Simple busybox with systemd (without Android)
> File system type: UBIFS + SQUASHFS
> UBI Volumes supported: rootfs (ro), others (rw)
> -------------------
> 
> When we try to flash the UBI images and then try to boot the device,
> we observe the below errors:

Someone in The OpenWrt community seems to have run into this problem,
possibly on the exact same QCOM SoC than you and came up with the following:

https://forum.openwrt.org/t/patch-squashfs-data-probably-corrupt/70480

> {{{
> [    5.608810] SQUASHFS error: xz decompression failed, data probably corrupt
> [    5.608846] SQUASHFS error: squashfs_read_data failed to read block 0x4d7ffe
> [    5.614745] SQUASHFS error: Unable to read data cache entry [4d7ffe]
> [    5.621939] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
> [    5.628274] SQUASHFS error: Unable to read data cache entry [4d7ffe]
> [    5.634934] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
> [    5.641309] SQUASHFS error: Unable to read data cache entry [4d7ffe]
> [    5.647954] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
> [    5.654304] SQUASHFS error: Unable to read data cache entry [4d7ffe]
> [    5.660977] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
> [    5.667309] SQUASHFS error: Unable to read data cache entry [4d7ffe]
> [    5.673997] SQUASHFS error: Unable to read page, block 4d7ffe, size 7a3c
> [    5.680497] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x00007f00
> [....]
> }}}
> We also observed that some of our Yocto build images will work and
> boots fine, while sometimes the build images cause this issue.
> 
> So we wanted to know:
> a) What could be the root cause of this issue ?
> b) Is it related to squashfs ?
> c) If yes, are there any fixes available already in the latest mainline ?
>     Please share some references.
> 
> Please let us know if anybody encountered this similar issue with
> squashfs and how did you handle it ?
> 
> Note:
> Our current commit in fs/squashfs is pointing at:
> Squashfs: Compute expected length from inode size rather than block length
> 
> 
> Thanks,
> Pintu
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

-- 
Florian
