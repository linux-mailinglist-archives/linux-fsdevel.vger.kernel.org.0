Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A097168D6F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 09:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBVIDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 03:03:04 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:55497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgBVIDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 03:03:03 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MGQ85-1jDNxT0E8L-00Gmo9; Sat, 22 Feb 2020 09:03:02 +0100
Received: by mail-lj1-f170.google.com with SMTP id w1so4663095ljh.5;
        Sat, 22 Feb 2020 00:03:01 -0800 (PST)
X-Gm-Message-State: APjAAAXzm3mazZhpifv6NLwNUOZwOlo1AXN5boy8wUSX/H3CDKpMt+O5
        rZW0g871fIpzP2DTUA4cwHcEtUsYDjUs/bnkz+M=
X-Google-Smtp-Source: APXvYqy8pqZnXs4eA0pVTt5xMk383YhNUC6JgnQCwACtDyc9LnpCj6Rs0ZSynacog0ZUWSe9rR6qD5KRQrqsZqng2m8=
X-Received: by 2002:a2e:8e70:: with SMTP id t16mr24610761ljk.73.1582358581384;
 Sat, 22 Feb 2020 00:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com> <20200220074711.GA3261162@kroah.com>
 <ee53fe6f-53de-87c0-db16-989cc15abbce@broadcom.com>
In-Reply-To: <ee53fe6f-53de-87c0-db16-989cc15abbce@broadcom.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 22 Feb 2020 09:02:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
Message-ID: <CAK8P3a0y8RfjEng4AsMr4MAPGMTXduiFOyfUzazgw9c+KVWmYA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XZlkbUR4fxvy+eE3fvD5js5E7JSWv9M4hJtyepE/iQGN5bhv2kl
 LCRDkcdhGgVq9hhYgkCZgDR+VchB2qOw2MftAiiGtTFUU2tweq60mZQa635lfEwtVeEKbWs
 MnJ61uB+Wp7wWZPjOAtlkBmAImwxQO7Ykpn56BlDB0JVbz66Aa27T17gmP7vhlQd6/sfeSy
 QsAJR7A4fAvOlUoULX7cg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vCKx0DV6jsY=:ZsJCmUIHVEjxqelF+v30ky
 lC0Y/TQGa+3Rw3L57lffpcaWs4ZYYhg5vv9wGqlr5jlabbaOpg8V67KH3ZE8IA2X/mtc9J+zm
 +EboEKThaasEeUHgCpyTARgb+oHTQ56g3rp/+CsQjvWyy/zTQQCBVgU6n8JjWHRX3V92XBGEH
 RQ/NcjEF4Xpxec+a++cxJFDCxYMiooJceIVUQK0ypZH9Tjge/LCnt+soje2RgAvYyPbQbI2ZB
 s/hJH7tSKNQd3OHAgjGQszvL9rhTIVK3KHDrBJ5RTR7jXSm3QJjvnCUu4bIh+beLlODSh5Hpj
 3DwCH1bmvrAC19pFXm7+GeKaerf5aOVGe1dWZgBIcpiies54HKXei/5dQ+qwJ4Rghe6+z86PM
 LOTRPDeMSSIau5D0FPh+/g3FRWjz9rkDaI2cccpJZ7dePCAlgkm+HoQasDKk4caYqTbvbW7bk
 md5LyLt70Gj1Iqdd/5KpIKLP9hYOH1yTpoYk08qsKv7XjBsChcJDivxd95HrpuuL4KyrmIzhg
 Cd0DrT7KyLpDyA8K9dkDwPMgRNa+hu86CAkGa7gy/3lCJ8C6ZtllEDFI611rgZW6stxPrfr2F
 lZ3GXKge51OQZ69LqB16KRYr3kyj0YHkPoQbmyRiI/tRT2N2VWYa2HGrmCgwIwqmVgsECMGap
 RtZ14uQm+RrA4IzULJoPDdmF3NU6c7EvQCMpRV79y1zUFq9T6HLkt7BsPViE+FtoR5pGtSiTC
 w8l6oJop0NZNhSkYHu0sKe1Vj+nrZNI7bLi9oFSaMtX9gJRXB9x1XOBrRSLEecrfDX3CMIYp/
 iWjjodC82c9+3yzaXUbBiwhSHDAYsYqdIQLoIak8F6KxcPWWTk=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 7:19 PM Scott Branden
<scott.branden@broadcom.com> wrote:
> On 2020-02-19 11:47 p.m., Greg Kroah-Hartman wrote:

> > Have you worked with the V4L developers to tie this into the proper
> > in-kernel apis for this type of functionality?
> We looked at the V4L model doesn't have any support for anything we are
> doing in this driver.
> We also want a driver that doesn't care about video.  It could be
> offloading crypto or other operations.
> We talked with Olof about all of this previously and he said leave it as
> a misc driver for now.
> He was going to discuss at linux plumbers conference that we need some
> sort of offload engine model that such devices could fit into.

I see. Have you looked at the "uacce" driver submission? It seems
theirs is similar enough that there might be some way to share interfaces.

> > Using a tty driver seems like the totally incorrect way to do this, what
> > am I missing?
> tty driver is used to provide console access to the processors running
> on vk.
> Data is sent using the bcm_vk_msg interface by read/write operations
> from user space.
> VK then gets the messages and DMA's the data to/from host memory when
> needed to process.

In turn here, it sounds like you'd want to look at what drivers/misc/mic/
and the mellanox bluefield drivers are doing. As I understand, they have the
same requirements for console, but have a nicer approach of providing
abstract 'virtio' channels between the PCIe endpoint and the host, and
then run regular virtio based drivers (console, tty, block, filesystem,
network, ...) along with application specific ones to provide the custom
high-level protocols. This is also similar to what the drivers/pci/endpoint
(from the other end) as the drivers/ntb (pci host on both ends) frameworks
and of course the rpmsg/remoteproc framework do.

In the long run, I would want much more consolidation between the
low-level parts of all these frameworks, but moving your high-level
protocols to the same virtio method would sound like a step in the
direction towards a generialized framework and easier sharing of
the abstractions.

       Arnd
