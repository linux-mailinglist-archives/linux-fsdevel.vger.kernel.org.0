Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA105FE4FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 00:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJMWIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJMWID (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:08:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED1F189C08
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 15:08:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 10so3103918pli.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 15:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HG91HlnBs0Gp075eX+DhqkeC1CpJ7jgAv09vLeJ+oIA=;
        b=lSp8uCpBXzhgIRT9vhEtaY3ZBlU+VNfAikeY1bNW9zPjGrSLawXkzIMCZap+SDiAoy
         cXBY1lw4isxgEjaAZWx8nrIreeP0M794HQmy8+THJf9IbAHNNluYawc16UhB+ZLbnN7A
         NIxwxl2l4qwrOiOZBC1GHxfzBHx8yq/AIKvRp+Jiaho6hm2V10XrRgsf71zHlIOWF1K3
         sFjYB3g0v1zTymEit9JpDTBcM6HTJYRX7/a4IPClo3cs9tOlL0ZHlpC2FnnMN9QzlaO6
         Lh2UfI3iwXCKTkxvsH/JqhtDYqGCEMNI6v/yf06gLUCsFrCUynq2KApZndn3N+DZpjJD
         ZJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG91HlnBs0Gp075eX+DhqkeC1CpJ7jgAv09vLeJ+oIA=;
        b=rVOfe5LA8/JgKXGxjDC6Zk64QB0XiXPT4zavzKrlKn//dC3V8AAKxF2BpsCcPqIMDk
         B3fF66JER2UzaIl9yWBFHR4JJ2lCVdEUAu4RdJoD7WlD5E5FNhKbbQ43Rs1GFH1VhrsY
         kda3mBfmVpv1QJt5rPP7P2LUDLLat5MaNVrecrRv4WUxFs3lCHigq442D48v3GzlWoes
         bo120RuP3ePTRIsMVhS2bV5gRI5a7ZUfC8Beq3geWOrafI8psdVDooidQ85dKrVO7I4T
         vZwwiCI2BjEEmWaG+N7H1qp2FejeMg+nz7vcsHAp7o1ob3mhb7qhSqvUlCxoMwXShS9o
         MmEw==
X-Gm-Message-State: ACrzQf2Y8UzPPe3TTxHqKaMY67YZud8gQ0QIhntf00keVCDXe3mUtZxy
        MAFmg7c8vRXHEueTaYtZwY9W71Ng75FJQ3XH5DPdqw==
X-Google-Smtp-Source: AMsMyM6LV6OL0/s+uVlAMeW+oe+z+7ox+aQ0OBzUP5OTWYFjs3E5Domjv/7Z82BtRW4PVMLjkqZmOjjmY/2x9G04VA0=
X-Received: by 2002:a17:90b:4f87:b0:20b:12e3:32ae with SMTP id
 qe7-20020a17090b4f8700b0020b12e332aemr2126062pjb.236.1665698880863; Thu, 13
 Oct 2022 15:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com> <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
In-Reply-To: <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 14 Oct 2022 00:07:50 +0200
Message-ID: <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sergey.Semin@baikalelectronics.ru, damien.lemoal@opensource.wdc.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Oct 2022 at 14:39, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 13 Oct 2022 at 12:41, Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > On 2022/10/12 16:24, Naresh Kamboju wrote:
> > > On TI beagle board x15 the connected SSD is not detected on linux next
> > > 20221006 tag.
> > >
> > > + export STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > > + STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > > + test -n /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > > + echo y
> > > + mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > > mke2fs 1.46.5 (30-Dec-2021)
> > > The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 does
> > > not exist and no size was specified.
> > > + lava-test-raise 'mkfs.ext4
> > > /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
> > > exit'
>
> The reported issue is now noticed on the Linux mainline master branch.
>
> 1)
> I see following config is missing on latest problematic builds
>   - CONFIG_HAVE_PATA_PLATFORM=y
>
> 2)
> Following ahci sata kernel message are missing on problematic boots,
> [    1.408660] ahci 4a140000.sata: forcing port_map 0x0 -> 0x1
> [    1.408691] ahci 4a140000.sata: AHCI 0001.0300 32 slots 1 ports 3
> Gbps 0x1 impl platform mode
> [    1.408721] ahci 4a140000.sata: flags: 64bit ncq sntf pm led clo
> only pmp pio slum part ccc apst
> [    1.409820] scsi host0: ahci
> [    1.410064] ata1: SATA max UDMA/133 mmio [mem
> 0x4a140000-0x4a1410ff] port 0x100 irq 98
>
> 3)
> GOOD: 9d84bb40bcb30a7fa16f33baa967aeb9953dda78
> BAD:  e08466a7c00733a501d3c5328d29ec974478d717
>
> 4)
> Here i am adding links working and not working test jobs and kernel configs,
> problematic test job:
>  - https://lkft.validation.linaro.org/scheduler/job/5641407#L2602
> Good test job:
>  - https://lkft.validation.linaro.org/scheduler/job/5640672#L2198
>
> 5)
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>   git_sha: e08466a7c00733a501d3c5328d29ec974478d717
>   git_describe: v6.0-7220-ge08466a7c007
>   kernel_version: 6.0.0
>   kernel-config: https://builds.tuxbuild.com/2Fourpiqf1OrlPFFtKwhHV0wAiq/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/661424896
>   artifact-location: https://builds.tuxbuild.com/2Fourpiqf1OrlPFFtKwhHV0wAiq
>   toolchain: gcc-10
>
>
> 6)
> For your information,
> --
> I see diff on good to bad commits,
> $ git log --oneline 9d84bb40bcb3..e08466a7c007  -- drivers/ata
> 4078aa685097 Merge tag 'ata-6.1-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata
> 71d7b6e51ad3 ata: libata-eh: avoid needless hard reset when revalidating link
> e3b1fff6c051 ata: libata: drop superfluous ata_eh_analyze_tf() parameter
> b46c760e11c8 ata: libata: drop superfluous ata_eh_request_sense() parameter
> cb6e73aaadff ata: libata-eh: Remove the unneeded result variable
> ecf8322f464d ata: ahci_st: Enable compile test
> 2d29dd108c78 ata: ahci_st: Fix compilation warning
> 9628711aa649 ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
> bc7af9100fa8 ata: ahci-dwc: Add platform-specific quirks support
> 33629d35090f ata: ahci: Add DWC AHCI SATA controller support
> 6ce73f3a6fc0 ata: libahci_platform: Add function returning a clock-handle by id
> 18ee7c49f75b ata: ahci: Introduce firmware-specific caps initialization
> 7cbbfbe01a72 ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
> fad64dc06579 ata: libahci: Don't read AHCI version twice in the
> save-config method
> 88589772e80c ata: libahci: Discard redundant force_port_map parameter
> eb7cae0b6afd ata: libahci: Extend port-cmd flags set with port capabilities
> f67f12ff57bc ata: libahci_platform: Introduce reset
> assertion/deassertion methods
> 3f74cd046fbe ata: libahci_platform: Parse ports-implemented property
> in resources getter
> 3c132ea6508b ata: libahci_platform: Sanity check the DT child nodes number
> e28b3abf8020 ata: libahci_platform: Convert to using devm bulk clocks API
> 82d437e6dcb1 ata: libahci_platform: Convert to using platform
> devm-ioremap methods
> d3243965f24a ata: make PATA_PLATFORM selectable only for suitable architectures
> 3ebe59a54111 ata: clean up how architectures enable PATA_PLATFORM and
> PATA_OF_PLATFORM
> 55d5ba550535 ata: libata-core: Check errors in sata_print_link_status()
> 03070458d700 ata: libata-sff: Fix double word in comments
> 0b2436d3d25f ata: pata_macio: Remove unneeded word in comments
> 024811a2da45 ata: libata-core: Simplify ata_dev_set_xfermode()
> 066de3b9d93b ata: libata-core: Simplify ata_build_rw_tf()
> e00923c59e68 ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE
> 614065aba704 ata: libata-core: remove redundant err_mask variable
> fee6073051c3 ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
> 99ad3f9f829f ata: libata-core: improve parameter names for ata_dev_set_feature()
> 16169fb78182 ata: libata-core: Print timeout value when internal command times
>
>
>
>
> > >
> > > Test log:
> > >  - https://lkft.validation.linaro.org/scheduler/job/5634743#L2580
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > metadata:
> > >   git_ref: master
> > >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> > >   git_sha: 7da9fed0474b4cd46055dd92d55c42faf32c19ac
> > >   git_describe: next-20221006
> > >   kernel_version: 6.0.0
> > >   kernel-config: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F/config
> > >   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/659754170
> > >   artifact-location: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F
> > >   toolchain: gcc-10
>
> 7)
> > The kernel messages that are shown in the links above do not show any "libata
> > version 3.00 loaded." message nor any ata/ahci message that I can see. So I
> > think the eSATA adapter is not even being detected and libata/ahci driver not used.
> >
> > Was this working before ? If yes, can you try with the following patches reverted ?
> >
> > d3243965f24a ("ata: make PATA_PLATFORM selectable only for suitable architectures")
> > 3ebe59a54111 ("ata: clean up how architectures enable PATA_PLATFORM and
> > PATA_OF_PLATFORM")
>
> I have reverted above two patches and but the problem has not been solved.
>
> 8)
> > If reverting these patches restores the eSATA port on this board, then you need
> > to fix the defconfig for that board.
>
> OTOH,
> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> device failed to boot.

I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
controller support")
from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
successful.

Build artifacts [1].
Any idea what happens?

Cheers,
Anders
[1] https://builds.tuxbuild.com/2G53i1F7vUWWTuZJtka3Fr7iH1B/
