Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1055E3A764B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 07:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFOFOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 01:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFOFOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 01:14:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79401C061574;
        Mon, 14 Jun 2021 22:12:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t7so4141835edd.5;
        Mon, 14 Jun 2021 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xyi5xIjGsB+0Cu9DQZo1Hv0CUoMX1ylQGxX15iVtOww=;
        b=YMwn+YehcDBZCmZg3ea09v0qT6YTum/D3Me+RAqRLJAugasSdQjiWbQ3kEdNxxDVrZ
         a0X920zWELBqYhNtoYWVfgomCT1D47sGM0X9wgJoqhHZVx5fTdDteDpbno7bSlhBoXjI
         3aGhILHerFW+Ime9guj5FPkCWR/99i779CAj/VZLsJFbR2fiVThj8HV6bEqd1oNGtiSu
         jUksRfAHoCyjB490aTvR+kvgp1o9damiJK2zmij+3DEAFDqGXXQz+WfCBkx9ap1xQHro
         XYk4HN1MDWKzchgiiivS7cxrRJA4cD1Hw699nitQUTacnXZfaleHZ5aczuHUCZ/0Xiwp
         bxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xyi5xIjGsB+0Cu9DQZo1Hv0CUoMX1ylQGxX15iVtOww=;
        b=RAs/E2UnTvAJ6vDmV+7p6EZR+R9Eg9ZwP1Xwyck1TKra5XuQVD3w3WXDK4XPVWN92h
         1ocyu01031RDTQNfmdrzvaDFgLnqUJYqTSQ+ud3TrcqtR6p3k5W8xHwVEfGwb9xva+z2
         t8Ztu8ZgBlzQkpZRJ6aFiHD7TnP+QZW5K0RjbPd7ltzQmSetHJOO2oM0PTVCMdDo45TQ
         Vm6D4xlKa9FZoUw7ZkV8j81myUxfJ1jgSc+mrJF54I9ABvcy2ip9tQjiKWqZUBW75hSm
         709O/O0z0EPs03sZ79yQ7nZK2Bg1etY3LbM/Fomb5Sxns7KOWYxMdAKH6lfHMnSSr0ng
         LY7g==
X-Gm-Message-State: AOAM530Sdo6ZvJou0lZHC79jLP8eZ/Y7Ywnc6pGNkSOkNlk3dCh+Az2L
        EHI/q1h3d37W9n81cmx5qtSNg0bgBGhUF2s/MBs=
X-Google-Smtp-Source: ABdhPJxN4m823M1pDUBchSwIpcDFs2ZMJrEs2tDgx/y0lzxE6eViASdV4rs6s7+ZKIuNy3f/s8WDKZaFwsZn+hfws1M=
X-Received: by 2002:a05:6402:3134:: with SMTP id dd20mr20768437edb.59.1623733960009;
 Mon, 14 Jun 2021 22:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLi8_PDyxtt+=j8AsX9pwLWcT4LmVWKj+UcyFOnj4RDBzg@mail.gmail.com>
 <dacd3fd3-faf5-9795-1bf9-92b1a237626b@gmail.com>
In-Reply-To: <dacd3fd3-faf5-9795-1bf9-92b1a237626b@gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 15 Jun 2021 10:42:28 +0530
Message-ID: <CAOuPNLjCB2m7+b9CJxqTr-THggs-kTPp=0AX727QJ5CTs5OC0w@mail.gmail.com>
Subject: Re: Kernel 4.14: SQUASHFS error: xz decompression failed, data
 probably corrupt
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel@kvack.org, Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Jun 2021 at 03:53, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 6/14/2021 3:39 AM, Pintu Agarwal wrote:
> > Hi All,
> >
> > With Kernel 4.14 we are getting squashfs error during bootup resulting
> > in kernel panic.
> > The details are below:
> > Device: ARM-32 board with Cortex-A7 (Single Core)
> > Storage: NAND Flash 512MiB
> > Kernel Version: 4.14.170 (maybe with some Linaro updates)
> > File system: Simple busybox with systemd (without Android)
> > File system type: UBIFS + SQUASHFS
> > UBI Volumes supported: rootfs (ro), others (rw)
> > -------------------
> >
> > When we try to flash the UBI images and then try to boot the device,
> > we observe the below errors:
>
> Someone in The OpenWrt community seems to have run into this problem,
> possibly on the exact same QCOM SoC than you and came up with the following:
>
> https://forum.openwrt.org/t/patch-squashfs-data-probably-corrupt/70480
>
Thanks!
Yes I have already seen this and even one more.
https://www.programmersought.com/article/31513579159/

But I think these changes are not yet in the mainline right ?

So, I wanted to know which are the exact patches which are already
accepted in mainline ?
Or, is it already mainlined ?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/fs/squashfs?h=next-20210611
From here, I see that we are only till this:
==> 2018-08-02: Squashfs: Compute expected length from inode size
rather than block length



Thanks,
Pintu
