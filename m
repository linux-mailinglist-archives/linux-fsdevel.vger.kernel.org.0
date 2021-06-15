Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8503A7B56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFOKDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhFOKDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:03:19 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06663C061574;
        Tue, 15 Jun 2021 03:01:15 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ho18so21578897ejc.8;
        Tue, 15 Jun 2021 03:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6z4408/6oQsiDbv7fByF9r7biAOY0o4N+GInpU23pkI=;
        b=H06GhBmxY91XwIBiT6QAmQpAftMWvSYiSkZ1ikjQiL/ABWIc6qzGO96hKW2gZMGb8i
         LPGM6p3HrLH5zBeTr2aFA0tc7/l3iZL3/+l4qB8ZwulLOQD6sIaU1oJA8GKcNaMWsbws
         lFSjtNYGjK63ptwBFN6XZPDIMY0jwp+KT/8bJMylNwfW3yTyqtzDS4rgcNqti4cqu8hF
         8F/XzvIhvRLhlw0Jw9BjtkyUHnGGJaIToVlmnZ7F3q3QjBRHXYnfJW4kOUCUtrc4W3nd
         GZRDASpUW3UpxKzXgTBfVY7kj4UzzdGgjJq/j3NKG1CqGI9Zg0Ql29g3cC7NLxBnJp/+
         JdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6z4408/6oQsiDbv7fByF9r7biAOY0o4N+GInpU23pkI=;
        b=LO6ee3JC4uo0tiYbDDRIKnYnuIseQ4BuJRSgZHtpWgme3KCRm9MzZBmAyHy8TXpJ8Q
         GGpk4BeYdC71KDdudKBh7iVSP8souO9ZVwpIaf7mwfk5LNQnxDKoC4T/kvItEUQ/wvpN
         VZYZN4N2mGrna03zJySk1O5AXSRuoKnkG4VuOlvtzHIK/jxGr4+BrhPz9q3U2KavWMQ8
         RW/P6zVItC9HqPrPJVEAw8O/rV+A9We1Ypu3gc3HP2Ti7wmqGLLly8c+is1MxpM7YYmH
         /Hs6K/Q4wPFfvZW4ogHd/EiwhKuQknv2NLYDIhGQAtQ3jlFFZ9b/reQbJI9KFixUbOiY
         Vrhg==
X-Gm-Message-State: AOAM531L5T8/p2TDAPestyLdZv9kgdzlEqM+XlIiBcrBGyP1X+2PHKHT
        tPNHXezKoI+iz+2WZSYhfPGsRNX6LNWaSf/orRk=
X-Google-Smtp-Source: ABdhPJw8+LEtoar+pUf2dCxfuXnKoD7N5HCuiqVYRWxj5aO6xnN+gaJI4iET9GPlCrNM0Q0X32v18zP6Ztg1Aywjybk=
X-Received: by 2002:a17:906:c293:: with SMTP id r19mr20197055ejz.252.1623751273558;
 Tue, 15 Jun 2021 03:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLi8_PDyxtt+=j8AsX9pwLWcT4LmVWKj+UcyFOnj4RDBzg@mail.gmail.com>
 <dacd3fd3-faf5-9795-1bf9-92b1a237626b@gmail.com> <CAOuPNLjCB2m7+b9CJxqTr-THggs-kTPp=0AX727QJ5CTs5OC0w@mail.gmail.com>
In-Reply-To: <CAOuPNLjCB2m7+b9CJxqTr-THggs-kTPp=0AX727QJ5CTs5OC0w@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 15 Jun 2021 15:31:01 +0530
Message-ID: <CAOuPNLio33vrJ_1am-hbgMunUJereC5GOy3QVU6PDDk-3QeneA@mail.gmail.com>
Subject: Re: Kernel 4.14: SQUASHFS error: xz decompression failed, data
 probably corrupt
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Jun 2021 at 10:42, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Tue, 15 Jun 2021 at 03:53, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> >
> >
> > On 6/14/2021 3:39 AM, Pintu Agarwal wrote:
> > > Hi All,
> > >
> > > With Kernel 4.14 we are getting squashfs error during bootup resulting
> > > in kernel panic.
> > > The details are below:
> > > Device: ARM-32 board with Cortex-A7 (Single Core)
> > > Storage: NAND Flash 512MiB
> > > Kernel Version: 4.14.170 (maybe with some Linaro updates)
> > > File system: Simple busybox with systemd (without Android)
> > > File system type: UBIFS + SQUASHFS
> > > UBI Volumes supported: rootfs (ro), others (rw)
> > > -------------------
> > >
> > > When we try to flash the UBI images and then try to boot the device,
> > > we observe the below errors:
> >
> > Someone in The OpenWrt community seems to have run into this problem,
> > possibly on the exact same QCOM SoC than you and came up with the following:
> >
> > https://forum.openwrt.org/t/patch-squashfs-data-probably-corrupt/70480
> >
> Thanks!
> Yes I have already seen this and even one more.
> https://www.programmersought.com/article/31513579159/
>
> But I think these changes are not yet in the mainline right ?
>
> So, I wanted to know which are the exact patches which are already
> accepted in mainline ?
> Or, is it already mainlined ?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/fs/squashfs?h=next-20210611
> From here, I see that we are only till this:
> ==> 2018-08-02: Squashfs: Compute expected length from inode size
> rather than block length
>
@Phillip Lougher, do you have any suggestions/comments on these errors ?
Why do you think these errors occur ?
Also, I noticed that even if these errors occur, the device may boot normally.
However, for some people it does not boot at all.

Thanks,
Pintu
