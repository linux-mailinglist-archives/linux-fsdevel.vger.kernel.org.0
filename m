Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4CF5FE61C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 02:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJNARp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 20:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiJNARm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:17:42 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2131817FD75
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665706661; x=1697242661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+vPjAjsehrdz7gwDjN7jzS+tOhZOxUsOQekKNk5Wns4=;
  b=pK2RYHhnOqrG+lTqfcKXBi+g5EJDeMdlgXzEFNVgqDypHKlDIoI8IPQF
   HeZHo3QYr6yJNfmpKktYSWe+e8FxNprBNje7+Vr60tbIua+1tRbdmxt6l
   Y+as9piDbnQb8qjA9AR1z/V5an21VTU07uquQCAiXYQZ8T+qQ7LGjNr3U
   S7gMZcBLHQ7+I243l7DW+1N4n+2MfSs7st5oN09Pr+bgUw77+dLjWn2D8
   hzhJ341sJH+O8ThF5HX8VOtdTBThzovlxlKuYYSQyrYXp2megwC9KcSwD
   jA04WcHsxsyFyJ9RkS8Cda4qnlgck8heRu2w7AwH7GEGgbU7kwx4T8Q0J
   g==;
X-IronPort-AV: E=Sophos;i="5.95,182,1661788800"; 
   d="scan'208";a="212086404"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2022 08:17:38 +0800
IronPort-SDR: 6yekDxCbTNZ2pHss6sxS5CuR0gKrzf3SKfBlChQNrCpr3FzGYVUDAjfMBmYW6yAyE0zw6s/QSj
 I2FQTR2fI6JeLICgBSpMN0YehkjFRQpZBbVwxo6tqh7RFsGP9Lm/wuw74Gz9tkAaWMxO38tM/m
 XU39lx9c2PoAaEZPvoxP/BEkdHyxe0KagyOZEKCSbYmS5Gda0GbpXvgi4s81kdsRUvB/1hFFFI
 Yx3cAaUWrukmD4qxzz8QPlWn1u1pTGS5HiZk4jjnntHdZL6bURdf24X08Qlm2tW0yPkzMB4ajz
 SCgy737qqe0vUyt4EqEbZUvF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 16:31:38 -0700
IronPort-SDR: hhTRGxekheALH++eI/aR0d8I30fPpqnWZH9xEgmqjAnqJ+Z220ldNgjNUOB/JfVus/5DTTjpeO
 pMIZnM740hHA9Bm6QCMsBr+AB+vn1YMDXuwD5zviS5O7Qq0DeazS2O2nvVKLrX35RBJuIvNuJG
 NrzOnNi1TeCTRYnWUd7tyxhKPqRdFfk1FAB2jZiwmCafsiVAmAvuiWAi17Ref7LAldmevcVK6N
 xgP5sEaLeaXShvQ3HgLzVsbRFnioTY465GeYF4/32yvkCuc6Jr2av/OrWd5TqHXnQHPzgROcJ1
 Ql4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Oct 2022 17:17:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MpRmL1J7Nz1Rwt8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 17:17:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665706656; x=1668298657; bh=+vPjAjsehrdz7gwDjN7jzS+tOhZOxUsOQek
        KNk5Wns4=; b=LodwpY61BgZC7keTvNXZ2/LYAGnVuGHVb9an48aEd8q8K69gqqy
        VbKy6zJPbmjZA8e4GJtkhiWrVWxVzhRTRHdblvK7z9brHqO6THIBLrIOkylJbRKm
        EmWI4/2bHhhUCa89/emEFum9tB8QqTc0RQbZJwOU30jUng/o2ZpypHqjk/DzgOwT
        O1n8wOb6VycwsJ/vWlYPmiD7B60AsXRj/5NelL1BlKxPqwt8X17JfM7uYooyUXac
        zeEy5ifTLS17wNR9/y5zm5suvvzTAS0cZu9wFSHPIW+wdmNt1daHnDPNVfeaiTew
        lm59hAwDjMXYLr9eYZZ44i525sQgz6dDoKA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SmFjIhkLVhmg for <linux-fsdevel@vger.kernel.org>;
        Thu, 13 Oct 2022 17:17:36 -0700 (PDT)
Received: from [10.225.163.119] (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MpRmG2T8Pz1RvLy;
        Thu, 13 Oct 2022 17:17:34 -0700 (PDT)
Message-ID: <3c8596b5-5ba5-df1d-a9d2-f39b9a7a0b21@opensource.wdc.com>
Date:   Fri, 14 Oct 2022 09:17:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/13/22 21:39, Naresh Kamboju wrote:
> On Thu, 13 Oct 2022 at 12:41, Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2022/10/12 16:24, Naresh Kamboju wrote:
>>> On TI beagle board x15 the connected SSD is not detected on linux next
>>> 20221006 tag.
>>>
>>> + export STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
>>> + STORAGE_DEV=/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
>>> + test -n /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
>>> + echo y
>>> + mkfs.ext4 /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84
>>> mke2fs 1.46.5 (30-Dec-2021)
>>> The file /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 does
>>> not exist and no size was specified.
>>> + lava-test-raise 'mkfs.ext4
>>> /dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_190702A00D84 failed; job
>>> exit'
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

The proper driver for this board is not being loaded I think, or not
builtin. What is the compat string in the device tree for this ahci
adapter ? What driver does it need ? I quickly tried to google that info
but did not find any details.

> 3)
> GOOD: 9d84bb40bcb30a7fa16f33baa967aeb9953dda78
> BAD:  e08466a7c00733a501d3c5328d29ec974478d717

What are these ? "git show" says they are drm and rdma pull request merge
from Linus...

> 4)
> Here i am adding links working and not working test jobs and kernel configs,
> problematic test job:
>  - https://lkft.validation.linaro.org/scheduler/job/5641407#L2602
> Good test job:
>  - https://lkft.validation.linaro.org/scheduler/job/5640672#L2198

Hard to read... Can you send a diff of the kernel configs ?

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

I do not understand what you are trying to say here. These are the latest
ata patches for 6.1. They touch different drivers and ata core.
I still do not know which driver needs to be used on that board...

>>> Test log:
>>>  - https://lkft.validation.linaro.org/scheduler/job/5634743#L2580
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> metadata:
>>>   git_ref: master
>>>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>>>   git_sha: 7da9fed0474b4cd46055dd92d55c42faf32c19ac
>>>   git_describe: next-20221006
>>>   kernel_version: 6.0.0
>>>   kernel-config: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F/config
>>>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/659754170
>>>   artifact-location: https://builds.tuxbuild.com/2FkkkZ51ZYhBL1G8D69YX8Pkt5F
>>>   toolchain: gcc-10
> 
> 7)
>> The kernel messages that are shown in the links above do not show any "libata
>> version 3.00 loaded." message nor any ata/ahci message that I can see. So I
>> think the eSATA adapter is not even being detected and libata/ahci driver not used.
>>
>> Was this working before ? If yes, can you try with the following patches reverted ?
>>
>> d3243965f24a ("ata: make PATA_PLATFORM selectable only for suitable architectures")
>> 3ebe59a54111 ("ata: clean up how architectures enable PATA_PLATFORM and
>> PATA_OF_PLATFORM")
> 
> I have reverted above two patches and but the problem has not been solved.

OK.

> 
> 8)
>> If reverting these patches restores the eSATA port on this board, then you need
>> to fix the defconfig for that board.
> 
> OTOH,
> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> device failed to boot.

Why would you need to enable this new driver ? You board was working
before without this new driver, so it is not the one to use for this
board, right ? Please send the ata related bits of the device tree to
understand what this board needs.

-- 
Damien Le Moal
Western Digital Research

