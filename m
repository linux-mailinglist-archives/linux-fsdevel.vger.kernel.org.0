Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ED6542017
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 02:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383359AbiFHAPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 20:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839311AbiFHAC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:02:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED511CB7F;
        Tue,  7 Jun 2022 16:52:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso16851699pjg.0;
        Tue, 07 Jun 2022 16:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b3NZKzwwnS36QL4ucaqxtIuHPEUyyTomuKdcLQyEKAY=;
        b=Gf7bKdJ2hUOr/LphELuKt2o2il5QdNDO4rPQYRQp+1RKXfjR13N6bKmp5cYllzWRT1
         xhWgDv9jhC081rAPWRyoHtai4YiXoOEshYmG98xEi3wfEpFCM2PDCdIuy+YcJ0chYvKT
         atBYZkLGl8/N43pToDTwRSTpFzFaMaAypJvvAQf+dndtlcYidM4/cRGYnwFcXWEtFEWi
         Tcg9DoCiNNhHm/4hSnGnujiO9+rEPF9ieyuGMobYFn67e4mR2wStVhet3fN/z1EhPV1t
         aMmWf/7BmFv9yBtn8Iwp64KBjrIImavp8mV1C3jBkHuJyJPrwDy+v+PnhrbQjoGDC5sB
         2t0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b3NZKzwwnS36QL4ucaqxtIuHPEUyyTomuKdcLQyEKAY=;
        b=PMNOqZv0gYYje7LKbxAyJDyL+ZlHZfMhp5bM+Gk/YtCO37w6dt/stbuRPAuHeIQxEU
         W/9lu/ToLXXewh7L2Dp0vLRwzv3rrH3vq7aHe/XbS947qmv4b9OyOVqtmqtUaiNXoMnT
         0VC86ADX/oAYxpXqrBh0FK1wBuYB/5BebDWAs10wjvToBJt151B9sM6ZuoHGamjimXMw
         rdeJTuxFqN88UTCvNS7E4h8+EPKJYxzxiXiDNkjJYNJSMScfxEHhelqBPQC9dcXiOwWi
         9qAnrgYpRHQ7b7/V4xZPg5i4FfbQf4Zc1Qs2zXqvXmSbfbK+/iKTsGAhg90+IKW4mdqC
         rwjA==
X-Gm-Message-State: AOAM533xkF3DKvaZ61c7W0Rhme3N5NdJlRfA9RnL3Pf0QGFDFR7ZHWue
        lk613blWefXo7l5Xb85Ya34=
X-Google-Smtp-Source: ABdhPJxccdrile2mSoYxkExBirNwrH/WiEDWbZeQDdUwJ0Lkq9krO4qFXX5rn/DFlb/QY2Iq77CWPw==
X-Received: by 2002:a17:902:ce11:b0:167:7d4a:964b with SMTP id k17-20020a170902ce1100b001677d4a964bmr12617889plg.37.1654645927119;
        Tue, 07 Jun 2022 16:52:07 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:f30f:4d03:66e6:b121])
        by smtp.gmail.com with ESMTPSA id t9-20020a1709027fc900b00167863f0e68sm4026924plb.237.2022.06.07.16.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 16:52:06 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 7 Jun 2022 16:52:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <Yp/kpPA7GdbArXDo@google.com>
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
 <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 07, 2022 at 06:51:27AM +0530, Naresh Kamboju wrote:
> On Mon, 6 Jun 2022 at 23:06, Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Thu, Jun 02, 2022 at 02:19:34PM +0530, Naresh Kamboju wrote:
> > > The following kernel crash reported while running selftests: zram: zram.sh
> > > test case on qemu-arm with Linux mainline v5.18.0 kernel version.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Started noticing from kernel crash from
> > > BAD: git_sha: cdeffe87f790dfd1baa193020411ce9a538446d7
> > > GOOD:   git_sha: babf0bb978e3c9fce6c4eba6b744c8754fd43d8e
> > >
> > > # git log  --oneline
> > > babf0bb978e3c9fce6c4eba6b744c8754fd43d8e..cdeffe87f790dfd1baa193020411ce9a538446d7
> > >   -- drivers/block/
> > > 98931dd95fd4 Merge tag 'mm-stable-2022-05-25' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > 6140ae41effe zram: fix Kconfig dependency warning
> > > b3fbd58fcbb1 mm: Kconfig: simplify zswap configuration
> > > e7be8d1dd983 zram: remove double compression logic
> > > a2ad63daa88b VFS: add FMODE_CAN_ODIRECT file flag
> > > 30226b69f876 zram: add a huge_idle writeback mode
> >
> > Hi Nalesh,
> >
> > Thanks for the reporting the bug!
> >
> > I locally ran the test in my x86 KVM machine but couldn't reproduce it.
> > How is it easy to reproduce?  Could you help to bisect it?
> 
> It works on qemu_x86-64
> It is always reproducible in qemu arm32 environment.
> 
> steps to reproduce:
> # Please download and use this rootfs and kernel zImage
> 
> rootfs: https://oebuilds.tuxbuild.com/29zhlbEc3EWq2wod9Uy964Bp27q/images/am57xx-evm/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4.gz
> kernel: https://builds.tuxbuild.com/29zhqJJizU2Y7Ka7ArhryUOrNDC/zImage
> 
> Boot command,
>  /usr/bin/qemu-system-aarch64 -cpu host,aarch64=off -machine
> virt-2.10,accel=kvm -nographic -net
> nic,model=virtio,maaacaddr=BA:DD:AD:CC:09:04 -net tap -m 2048 -monitor
> none -kernel kernel/zImage --append "console=ttyAMA0 root=/dev/vda rw"
> -hda rootfs/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4
> -m 4096 -smp 2
> 
> # cd /opt/kselftests/default-in-kernel/zram
> # ./zram.sh
> 
> Allow me sometime I will try to bisect this problem.

Thanks for sharing the info. 

I managed to work your rootfs with my local arm build
based on the problematic git tip. 
However, I couldn't suceed to reproduce it.

I needed to build zsmalloc/zram built-in instead of modules
Is it related? Hmm,

Yeah, It would be very helpful if you could help to bisect it.
Thanks!

=== &< ====
create '1' zram device(s)
zram modules already loaded, kernel supports zram-control interface
[  936.188541] zram: Added device: zram1
all zram devices (/dev/zram1~1 successfully created
set max_comp_streams to zram device(s)
The device attribute max_comp_streams was deprecated in 4.7
set disk size to zram device(s)
/sys/block/zram1/disksize = '1048576'
zram set disksizes: OK
set memory limit to zram device(s)
[  936.214438] zram1: detected capacity change from 0 to 2048
/sys/block/zram1/mem_limit = '1M'
zram set memory limit: OK
make swap with zram device(s)
[  936.608854] Adding 1020k swap on /dev/zram1.  Priority:-2 extents:1 across:1020k SS
done with /dev/zram1
zram making zram mkswap and swapon: OK
zram swapoff: OK
zram cleanup
[  937.063416] zram1: detected capacity change from 2048 to 0
[  937.189223] zram: Removed device: zram1
zram02 : [PASS]
root@am57xx-evm:/opt/kselftests/default-in-kernel/zram# uname -r
5.18.0-11934-g54eb8462f21f

