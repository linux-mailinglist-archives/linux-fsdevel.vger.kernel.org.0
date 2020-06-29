Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82A920D318
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jun 2020 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgF2Szm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 14:55:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36139 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728686AbgF2SzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593456923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UXq/qqyD2a28IfHjuoKVPd0eQ26Svr0GOqbAfHxZlJE=;
        b=K5xLQ/7ZB+70+d0mGR//iNeAhFlH69HVo/9JHE+EHNQ/eG55pCU1oSIyEXjQ6oMdpnoaCp
        nA3JHB7Ob4qq6z5w3iFLAZlZLtewTr2gL2W2ohydpC5V6SrnrTEExH514PeQhW9Q248RyA
        GMuEjtkFS3d60ane2oRsuwysapsfvAE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-6Hy1If-WOb-f6pOqow9v9A-1; Mon, 29 Jun 2020 09:54:10 -0400
X-MC-Unique: 6Hy1If-WOb-f6pOqow9v9A-1
Received: by mail-qt1-f199.google.com with SMTP id o11so12201750qti.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 06:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXq/qqyD2a28IfHjuoKVPd0eQ26Svr0GOqbAfHxZlJE=;
        b=NS20G7OasHo5oYweAIi3rdVPmrI3wuJtowGFr/oLrDYO5j9lojzDyBuCBjEbRFyZoh
         lGzlwMDRR3/dhKRdYNU3/KEvaoGUQUIG1yek8PUBCjCvgaHNfo7egLFyGvcOw2nX230b
         t0LTgzzYIpwkytrqSWi3ElPelsXnYKjBWlxInO+P69ca0tPcWAtK7fizTq7Vq8K6C9im
         ZEI2IqYzez5kbuNErglaPqwUwonoEPcPj0XRICGJnqwDyKOOjlNGU/0LRGvlqV5Nq2Pl
         KXEpwQsPXDkupM0Yao6KaV6GQhHbH616H/1nnLQ9LZdv6YByu6Td8NxdJVJqUfz7HohC
         HRZg==
X-Gm-Message-State: AOAM5332uAE1Xc4kUzVFekqX5tzotERCZPssAZfNwCoXfL8UNDIm/ks6
        +p4fUwkvwtUaxLpBCnxxIK03IJV2vxRDihSYiCrgmrNvaNd57xO6Za5Um0xQlU+Kfsk9lkgGagv
        dbg3mMXxd5I1yVH5DXycwBSSE3J/rS99OsHzKrH3EPA==
X-Received: by 2002:ac8:1654:: with SMTP id x20mr3623573qtk.83.1593438849807;
        Mon, 29 Jun 2020 06:54:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbFoMlq+MVIRGN64n4d+BAJf1EPSIyNy0vWRZQmNnSJSnsp3U2kxkNBsJHVZ0IH7mZD734alTgmX3vqXm7WMY=
X-Received: by 2002:ac8:1654:: with SMTP id x20mr3623554qtk.83.1593438849542;
 Mon, 29 Jun 2020 06:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
 <1696715.1592552822@warthog.procyon.org.uk> <4a2f5aa9-1921-8884-f854-6a8b22c488f0@profihost.ag>
 <2cfa1de5-a4df-5ad3-e35b-3024cad78ed1@profihost.ag> <CAJfpegvLJBAzGCpR6CQ1TG8-fwMB9oN8kVFijs7vK+dvQ6Tm5w@mail.gmail.com>
 <bffa6591-6698-748d-ba26-a98142b03ae8@profihost.ag> <CAJfpegur2+5b0ecSx7YZcY-FB_VYrK=5BMY=g96w+uf3eLDcCw@mail.gmail.com>
 <1492c31e-9b0c-64b5-8dd9-d9c0b4372f29@profihost.ag>
In-Reply-To: <1492c31e-9b0c-64b5-8dd9-d9c0b4372f29@profihost.ag>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 29 Jun 2020 15:53:57 +0200
Message-ID: <CAOssrKdX5X7WB_tt43h_Pb7nc=3Vb+WyG_kttNd16pxtS4Z0_g@mail.gmail.com>
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 29, 2020 at 2:24 PM Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>
> Hi Miklos,
>
> Am 26.06.20 um 10:34 schrieb Miklos Szeredi:
> > On Thu, Jun 25, 2020 at 10:10 PM Stefan Priebe - Profihost AG
> > <s.priebe@profihost.ag> wrote:
> >>
> >> Does a userspace strace really help? I did a git bisect between kernel
> >> v5.3 (working) und v5.4 (not working) and it shows
> >
> > I cannot reproduce this with the libfuse2 examples.  Passing
> > "nonempty" as a mount(2) in either v5.3 or v5.4 results in -EINVAL.
> > So without an strace I cannot tell what is causing the regression.
>
> the exact mount command is:
> ceph-fuse /var/log/pve/tasks -o noatime,nonempty
>
> so you mean i should just run strace -ff -s0 on it and throw the output
> to pastebin?

Yep.   I might need the arguments for the mount() syscalls though.

Thanks,
Miklos

