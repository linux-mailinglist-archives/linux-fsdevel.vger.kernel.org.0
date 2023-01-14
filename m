Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517E366AB2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 12:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjANLY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Jan 2023 06:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjANLYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:24:55 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B54B6EBF;
        Sat, 14 Jan 2023 03:24:54 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y19so3680421ljq.7;
        Sat, 14 Jan 2023 03:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=92D3na9XjC2tldOP8eaUtjmrOr8geOvULba7RpkEF88=;
        b=oidpd6NUevEcdWU5GrYwYjY0qsOZxddfFi5dyyzNnJ2Wgr8bLbb6jFeXbexF5bVlBD
         PXpzRt0GCF3SKbrBAt6JcOgnQyJS9Gr0og+Dq+e9RHjuhJfbI2s2ALH/mtBrvyZW1LTS
         Bv4KqI5LtMUaD17F2xefn4AkiYi6n3yX4JjXnaeZ8bd7U3+2ZBr1TcTguii17qBWOduq
         wgQDH6irGJNASX2cY3h8oOec1dD9pes6xRuyBDYvCRqxqDqzZEeeGYYp3oXDH4iI/8/x
         BTBtmkQpNaDg/wgSuNZgaLvHpGsqW+tW35fA9t3r/86JnTcc87pd3hEVPt/mRBX2UBdv
         bZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92D3na9XjC2tldOP8eaUtjmrOr8geOvULba7RpkEF88=;
        b=qdbJZrrHv0Tzr7u2LVZE2v8T98/LgRrEF76HQkpWzzdBlluh+htLROb4fvB2c4Z/Ew
         0c7lRRCi+xac2W2uXjRRxZzUsbLVoSfFO4biaI0P8RWYFdBqtrz/4sdVoMAu3nr0xffX
         1TEIDosYJ1IcnbV6h/VbKNmRhOADUznEe+3gLl/UpX/P8iEI+49S7aNK3XDkrYm2oi/H
         0c44r/1bz/tn0Uo0sRWd/OaAKgK/2VP6witxAl9ITD97jtaCY9ODWNZE46WoKWqoMimn
         WgcrrnWSdUyj/evQWHmExEAxZDNmMwKlBoi9Amu4MjYyB0bIc83Op/7WiNhHnNeb1Ajn
         Yctg==
X-Gm-Message-State: AFqh2ko42BkD31T3fO+RwTzcrWGSj6rlWnoYwoE+knRcUf9O92IWb9Xv
        uK/KFMPgayf1Uz4HA78ZSIXLiWfUDJiwQyBnlBg=
X-Google-Smtp-Source: AMrXdXuXj5p/ZuIpLf8gZ0GX/uM1VbdJtfoIXhmfKLwfHsiq2B3mV92A8IuI5WlG+MIrW6qcUOUw1/TEF4ro/BOWkZM=
X-Received: by 2002:a2e:8e3b:0:b0:280:4f2:700a with SMTP id
 r27-20020a2e8e3b000000b0028004f2700amr3108966ljk.364.1673695492487; Sat, 14
 Jan 2023 03:24:52 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de> <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
In-Reply-To: <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 14 Jan 2023 12:24:13 +0100
Message-ID: <CA+icZUXEz7ZxmkV5bw5O2ORjF4bwDXBMyj3Wk_HST98gMPt97g@mail.gmail.com>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs cpu_relax)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:43 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 13 Jan 2023 at 22:06, John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> >
> > Hello Ard!
> >
> > > Can I take that as an ack on [0]? The EFI subsystem has evolved
> > > substantially over the years, and there is really no way to do any
> > > IA64 testing beyond build testing, so from that perspective, dropping
> > > it entirely would be welcomed.
> >
> > ia64 is regularly tested in Debian and Gentoo [1][2].
> >
> > Debian's ia64 porterbox yttrium runs a recent kernel without issues:
> >
> > root@yttrium:~# uname -a
> > Linux yttrium 5.19.0-2-mckinley #1 SMP Debian 5.19.11-1 (2022-09-24) ia64 GNU/Linux
> > root@yttrium:~#
> >
> > root@yttrium:~# journalctl -b|head -n10
> > Nov 14 14:46:10 yttrium kernel: Linux version 5.19.0-2-mckinley (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-6) 11.3.0, GNU ld (GNU Binutils for Debian) 2.39) #1 SMP Debian 5.19.11-1 (2022-09-24)
> > Nov 14 14:46:10 yttrium kernel: efi: EFI v2.10 by HP
> > Nov 14 14:46:10 yttrium kernel: efi: SALsystab=0xdfdd63a18 ESI=0xdfdd63f18 ACPI 2.0=0x3d3c4014 HCDP=0xdffff8798 SMBIOS=0x3d368000
> > Nov 14 14:46:10 yttrium kernel: PCDP: v3 at 0xdffff8798
> > Nov 14 14:46:10 yttrium kernel: earlycon: uart8250 at I/O port 0x4000 (options '115200n8')
> > Nov 14 14:46:10 yttrium kernel: printk: bootconsole [uart8250] enabled
> > Nov 14 14:46:10 yttrium kernel: ACPI: Early table checksum verification disabled
> > Nov 14 14:46:10 yttrium kernel: ACPI: RSDP 0x000000003D3C4014 000024 (v02 HP    )
> > Nov 14 14:46:10 yttrium kernel: ACPI: XSDT 0x000000003D3C4580 000124 (v01 HP     RX2800-2 00000001      01000013)
> > Nov 14 14:46:10 yttrium kernel: ACPI: FACP 0x000000003D3BE000 0000F4 (v03 HP     RX2800-2 00000001 HP   00000001)
> > root@yttrium:~#
> >
> > Same applies to the buildds:
> >
> > root@lifshitz:~# uname -a
> > Linux lifshitz 6.0.0-4-mckinley #1 SMP Debian 6.0.8-1 (2022-11-11) ia64 GNU/Linux
> > root@lifshitz:~#
> >
> > root@lenz:~# uname -a
> > Linux lenz 6.0.0-4-mckinley #1 SMP Debian 6.0.8-1 (2022-11-11) ia64 GNU/Linux
> > root@lenz:~#
> >
> > EFI works fine as well using the latest version of GRUB2.
> >
> > Thanks,
> > Adrian
> >
> > > [1] https://cdimage.debian.org/cdimage/ports/snapshots/
> > > [2] https://mirror.yandex.ru/gentoo-distfiles//releases/ia64/autobuilds/
>
> Thanks for reporting back. I (mis)read the debian ports page [3],
> which mentions Debian 7 as the highest Debian version that supports
> IA64, and so I assumed that support had been dropped from Debian.
>
> However, if only a handful of people want to keep this port alive for
> reasons of nostalgia, it is obviously obsolete, and we should ask
> ourselves whether it is reasonable to expect Linux contributors to
> keep spending time on this.
>
> Does the Debian ia64 port have any users? Or is the system that builds
> the packages the only one that consumes them?
>
>
> [3] https://www.debian.org/ports/ia64/

I have no IA64 hardware or be a user of it or have any strong feelings
to keep this arch in the Linux-kernel.

But I am a Debianist (Debian/unstable AMD64 user).

Best is to ask the Debian release-team or (if there exist) maintainers
or responsibles for the IA64 port - which is an ***unofficial*** port.

What I found... on <cdimage.debian.org>:

https://cdimage.debian.org/cdimage/ > Ports

https://cdimage.debian.org/cdimage/ports/current/

https://cdimage.debian.org/cdimage/ports/current-debian-installer/ia64/debian-installer-images_20211020_ia64.tar.gz
^^ Last modified: 2021-10-20 22:52

https://cdimage.debian.org/cdimage/ports/current/debian-11.0.0-ia64-NETINST-1.iso
^^ Last modofied: 2022-03-28 14:18

With a net-install image you should be able to setup and explore the
IA64 Debian cosmos.

Example #1: binutils packages

Checking available binutils package for Debian/unstable IA64 (version:
2.39.90.20230110-1):

https://packages.debian.org/sid/binutils <--- Clearly states IA64 as
"unofficial port"
https://packages.debian.org/sid/ia64/binutils/filelist

Example #2: linux-image packages

Cannot say what this means...

https://packages.debian.org/search?arch=amd64&keywords=linux-image
(AMD64 - matches)

https://packages.debian.org/search?arch=ia64&keywords=linux-image
(IA64 - no matches)

https://packages.debian.org/search?arch=ia64&keywords=linux (IA64 -
matches - but no linux-image which ships normally a bootable
Linux-kernel)

As stated I have no expertise in Debian whatever release for IA64 arch.

Hope that helps.

-Sedat-
