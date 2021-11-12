Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1244E24D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 08:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbhKLHV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 02:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhKLHV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:21:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A8C061766;
        Thu, 11 Nov 2021 23:19:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w1so34096991edd.10;
        Thu, 11 Nov 2021 23:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=23MuWJBgLsmpo3DWwY1zc1kp+jWhxY7Ijuwd9E4NgEk=;
        b=Vkfd+Ngmf8e5tezD37bbnSLTKfHJ1YCgXEOfo9QxnVJIx47FaMesIQllT+O2nZMOr2
         gAvUVCbxZ8MBfAjvB4r83cGCaZGmeit88cjzDaNHcUu6pZPw0LYuW9JyqobxIA/dxQZC
         4eMP7qYVNhdEXe1ow2gyqCBNF0azrNp8981zXIHktGMkqw21iUqvWRw/80AjHMwDrACB
         0u7izw69vSTCT6iREHudCfWLd7Tv9y4WYCS1LzBUA/Fxm/yMntlh8RW77MekZwOP1cRP
         Nt4Q9tYszsWb72N4DV3BNTytV9coyEbqgmvvT1+gadXKqa26AKoGnusvqJMxfdIHWVYW
         2zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=23MuWJBgLsmpo3DWwY1zc1kp+jWhxY7Ijuwd9E4NgEk=;
        b=N0u39MIVs+qBAJ/LQm4hqzRoZHAZJodQUC4Vbl1H+VL20Y1TYM4B7tnECRJKS7ZPra
         34ocsJiiAtiKQu8dRq+h2gv+UifrnM2l5JRUxtJQOM2fS6QuFIZBUWdD4jcAEVoz6S6J
         mAhSvI7JaAC3AGIGVtlgjX4hZcF0PKMCqCJnL3VIP3+fmJVkuGMvR206HaqNyXSKbv7n
         diVxOz+IoqG+murfa0MyRge8Sji/J2Ijln+9sKLauJushxITDOxRbYn57PxAFHehfo32
         k2GEUFmaEVOvoBBdz3KjCibqpEPhZHzQ/RREWaLekHQbrSHVyR4e0Hvwq2kYet0Un9Xf
         hWAA==
X-Gm-Message-State: AOAM532b26ZabWsvMUDt7EPdtWGBMBabh+Iv6ySwL7T07e8lnT9ujqi9
        zTAoZP1jorCTFfKB8OIIJg1VuCYqb71URK/QGVtIusbyVbY=
X-Google-Smtp-Source: ABdhPJx13NMWj+ghQdIXzWAZXD21zp7HK2PPcgzpsVoQ5oiXGPhrERb6kk1sCFUWYPnyLmUI/dMVXMZ3WHQjPvatP2I=
X-Received: by 2002:a17:906:fca3:: with SMTP id qw3mr17312375ejb.285.1636701546085;
 Thu, 11 Nov 2021 23:19:06 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLinoW5Cx=xbUcT-DB4RiQkAPpe=9hsc-Rkch0LxD0mh+Q@mail.gmail.com>
 <CAOuPNLgquwOJg85kDcf67+4kTYP9N=45FvV+VDTJr6txYi5-wg@mail.gmail.com> <CAOuPNLjFtS7ftg=+-K3S+0ndyNYmUNqXo7SHkyV4zK4G9bZ4Og@mail.gmail.com>
In-Reply-To: <CAOuPNLjFtS7ftg=+-K3S+0ndyNYmUNqXo7SHkyV4zK4G9bZ4Og@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 12 Nov 2021 12:48:55 +0530
Message-ID: <CAOuPNLg_YwyhK6iPZZbRWe57Kkr1d8LjJaDniCvvOqk4t2-Sog@mail.gmail.com>
Subject: Re: Kernel-4.14: With ubuntu-18.04 building rootfs images and booting
 gives SQUASHFS error: xz decompression failed, data probably corrupt
To:     open list <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        dm-devel@redhat.com, Phillip Lougher <phillip@squashfs.org.uk>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        drosen@google.com, astrachan@google.com, speed.eom@samsung.com,
        Sami Tolvanen <samitolvanen@google.com>, snitzer@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, 9 Nov 2021 at 21:04, Pintu Agarwal <pintu.ping@gmail.com> wrote:

> > > We only get these squashfs errors flooded in the boot logs:
> > > {{{
> > > ....
> > > [    5.153479] device-mapper: init: dm-0 is ready
> > > [    5.334282] VFS: Mounted root (squashfs filesystem) readonly on device 253:0.
> > > ....
> > > [    8.954120] SQUASHFS error: xz decompression failed, data probably corrupt
> > > [    8.954153] SQUASHFS error: squashfs_read_data failed to read block 0x1106
> > > [    8.970316] SQUASHFS error: Unable to read data cache entry [1106]
> > > [    8.970349] SQUASHFS error: Unable to read page, block 1106, size 776c
> > > [    8.980298] SQUASHFS error: Unable to read data cache entry [1106]
> > > [    8.981911] SQUASHFS error: Unable to read page, block 1106, size 776c
> > > [    8.988280] SQUASHFS error: Unable to read data cache entry [1106]
> > > ....
> > > }}}
> > >

One more observation:
When I disable FEC flag in bootloader, I see the below error:
[    8.360791] device-mapper: verity: 253:0: data block 2 is corrupted
[    8.361134] device-mapper: verity: 253:0: data block 3 is corrupted
[    8.366016] SQUASHFS error: squashfs_read_data failed to read block 0x1106
[    8.379652] SQUASHFS error: Unable to read data cache entry [1106]
[    8.379680] SQUASHFS error: Unable to read page, block 1106, size 7770

Also, now I see that the decompress error is gone, but the read error
is still there.

This seems to me that dm-verity detects some corrupted blocks but with
FEC it auto corrects itself, how when dm-verity auto corrects itself,
the squashfs decompression algorithm somehow could not understand it.

So, it seems like there is some mis-match between the way FEC
correction and the squashfs decompression happens ?

Is this issue seen by anybody else here ?


Thanks,
Pintu
