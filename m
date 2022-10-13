Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBA5FD951
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 14:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJMMjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJMMjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:39:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8230A1A3B8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 05:39:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s2so2444666edd.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GD5Q0fIlYFy9UgmSPGmxuwFTbHUtfpAAgAnjM1dUOhI=;
        b=OjcVqnLYYMkA8IvE4mzGLx1ggf60Mdr2S81VA3jSR2/YIK+Z4RcpHYKbRazbSKCDna
         2NjesK0/nrMTJlitm0X4DhPwt8F9DPVoImdHI8zWidu1c2HpteHlY6OCsR69ZFQscD61
         nCISz4Yn2YXce4ZldUahcvzXXzAO0joUXR35Co+xVyt5ONyrwxVDZP5DvXHQGegOmBlw
         iRlOCea2WWOEuiPTM4Cas8FTdwKxdjUnfW0ZFsz3mdV80P7Qxe02m+iagp/tvZ2kDtZd
         HIS6JyK76Ks8WDf/hkjYugkvoCupr5PDSPy3kUGiy5PnYgI18jNxGuKPaAAyvw/Uitmz
         kpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GD5Q0fIlYFy9UgmSPGmxuwFTbHUtfpAAgAnjM1dUOhI=;
        b=w6TRmSNJ2GVO76xC1mhpYENU7YxbpmPpV249nU36m1iQ33fb+FHhaF5CG/yqiawFQz
         HkcmCqCvqphn4r/xe0lXkWpMrgc+/cXKdyc2nZendg6a44GIngMWLBjI3T6eMqaVC3t4
         /Uz4R1C2PdWABs4N6/bILWfmI4lvvkWjosjrYufZJ3Q5X9FFnPmIOMLxX89406UzAayi
         AHnrK3Hoa8KdVxxR6v1H0L73iDx+UvZv1Mq8H/IfaII6P7zH0Y1HJ+gH/NgcTvbUfNGF
         RIbJLJ/GLYNkggegr7LCcD4kLaVwN1Ix/DTMXqeBzsDuQi1ZD2HsGbMJRdgUv5vrp8Xs
         s+hQ==
X-Gm-Message-State: ACrzQf0LUn0UyZ7kUw03QCd51Ihf80YDNQSy8qo4pcodOeHT9jDLmlPp
        TmkRdAiaJve9IvLkb7yDjDhrCU/Bam8FdNNWgPXPQw==
X-Google-Smtp-Source: AMsMyM7LqebKv/Vg0TFf9NGRzOp//qKzV5yRcGJR9qiv0wViF6GF9Ih6o2EBzI/MLW2yjpk3ydnmYG0IkSo+IR/eGhU=
X-Received: by 2002:a05:6402:2989:b0:44e:90d0:b9ff with SMTP id
 eq9-20020a056402298900b0044e90d0b9ffmr31446858edb.110.1665664784554; Thu, 13
 Oct 2022 05:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
In-Reply-To: <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 13 Oct 2022 18:09:32 +0530
Message-ID: <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Oct 2022 at 12:41, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2022/10/12 16:24, Naresh Kamboju wrote:
> > On TI beagle board x15 the connected SSD is not detected on linux next
> > 20221006 tag.
> >
> > + export STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > + STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > + test -n /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > + echo y
> > + mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
> > mke2fs 1.46.5 (30-Dec-2021)
> > The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 does
> > not exist and no size was specified.
> > + lava-test-raise 'mkfs.ext4
> > /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
> > exit'

The reported issue is now noticed on the Linux mainline master branch.

1)
I see following config is missing on latest problematic builds
  - CONFIG_HAVE_PATA_PLATFORM=y

2)
Following ahci sata kernel message are missing on problematic boots,
[    1.408660] ahci 4a140000.sata: forcing port_map 0x0 -> 0x1
[    1.408691] ahci 4a140000.sata: AHCI 0001.0300 32 slots 1 ports 3
Gbps 0x1 impl platform mode
[    1.408721] ahci 4a140000.sata: flags: 64bit ncq sntf pm led clo
only pmp pio slum part ccc apst
[    1.409820] scsi host0: ahci
[    1.410064] ata1: SATA max UDMA/133 mmio [mem
0x4a140000-0x4a1410ff] port 0x100 irq 98

3)
GOOD: 9d84bb40bcb30a7fa16f33baa967aeb9953dda78
BAD:  e08466a7c00733a501d3c5328d29ec974478d717

4)
Here i am adding links working and not working test jobs and kernel configs,
problematic test job:
 - https://lkft.validation.linaro.org/scheduler/job/5641407#L2602
Good test job:
 - https://lkft.validation.linaro.org/scheduler/job/5640672#L2198

5)
metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: e08466a7c00733a501d3c5328d29ec974478d717
  git_describe: v6.0-7220-ge08466a7c007
  kernel_version: 6.0.0
  kernel-config: https://builds.tuxbuild.com/2Fourpiqf1OrlPFFtKwhHV0wAiq/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/661424896
  artifact-location: https://builds.tuxbuild.com/2Fourpiqf1OrlPFFtKwhHV0wAiq
  toolchain: gcc-10


6)
For your information,
--
I see diff on good to bad commits,
$ git log --oneline 9d84bb40bcb3..e08466a7c007  -- drivers/ata
4078aa685097 Merge tag 'ata-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata
71d7b6e51ad3 ata: libata-eh: avoid needless hard reset when revalidating link
e3b1fff6c051 ata: libata: drop superfluous ata_eh_analyze_tf() parameter
b46c760e11c8 ata: libata: drop superfluous ata_eh_request_sense() parameter
cb6e73aaadff ata: libata-eh: Remove the unneeded result variable
ecf8322f464d ata: ahci_st: Enable compile test
2d29dd108c78 ata: ahci_st: Fix compilation warning
9628711aa649 ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
bc7af9100fa8 ata: ahci-dwc: Add platform-specific quirks support
33629d35090f ata: ahci: Add DWC AHCI SATA controller support
6ce73f3a6fc0 ata: libahci_platform: Add function returning a clock-handle by id
18ee7c49f75b ata: ahci: Introduce firmware-specific caps initialization
7cbbfbe01a72 ata: ahci: Convert __ahci_port_base to accepting hpriv as arguments
fad64dc06579 ata: libahci: Don't read AHCI version twice in the
save-config method
88589772e80c ata: libahci: Discard redundant force_port_map parameter
eb7cae0b6afd ata: libahci: Extend port-cmd flags set with port capabilities
f67f12ff57bc ata: libahci_platform: Introduce reset
assertion/deassertion methods
3f74cd046fbe ata: libahci_platform: Parse ports-implemented property
in resources getter
3c132ea6508b ata: libahci_platform: Sanity check the DT child nodes number
e28b3abf8020 ata: libahci_platform: Convert to using devm bulk clocks API
82d437e6dcb1 ata: libahci_platform: Convert to using platform
devm-ioremap methods
d3243965f24a ata: make PATA_PLATFORM selectable only for suitable architectures
3ebe59a54111 ata: clean up how architectures enable PATA_PLATFORM and
PATA_OF_PLATFORM
55d5ba550535 ata: libata-core: Check errors in sata_print_link_status()
03070458d700 ata: libata-sff: Fix double word in comments
0b2436d3d25f ata: pata_macio: Remove unneeded word in comments
024811a2da45 ata: libata-core: Simplify ata_dev_set_xfermode()
066de3b9d93b ata: libata-core: Simplify ata_build_rw_tf()
e00923c59e68 ata: libata: Rename ATA_DFLAG_NCQ_PRIO_ENABLE
614065aba704 ata: libata-core: remove redundant err_mask variable
fee6073051c3 ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
99ad3f9f829f ata: libata-core: improve parameter names for ata_dev_set_feature()
16169fb78182 ata: libata-core: Print timeout value when internal command times




> >
> > Test log:
> >  - https://lkft.validation.linaro.org/scheduler/job/5634743#L2580
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >   git_sha: 7da9fed0474b4cd46055dd92d55c42faf32c19ac
> >   git_describe: next-20221006
> >   kernel_version: 6.0.0
> >   kernel-config: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F/config
> >   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/659754170
> >   artifact-location: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F
> >   toolchain: gcc-10

7)
> The kernel messages that are shown in the links above do not show any "libata
> version 3.00 loaded." message nor any ata/ahci message that I can see. So I
> think the eSATA adapter is not even being detected and libata/ahci driver not used.
>
> Was this working before ? If yes, can you try with the following patches reverted ?
>
> d3243965f24a ("ata: make PATA_PLATFORM selectable only for suitable architectures")
> 3ebe59a54111 ("ata: clean up how architectures enable PATA_PLATFORM and
> PATA_OF_PLATFORM")

I have reverted above two patches and but the problem has not been solved.

8)
> If reverting these patches restores the eSATA port on this board, then you need
> to fix the defconfig for that board.

OTOH,
Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
device failed to boot.

- Naresh
