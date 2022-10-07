Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873645F78C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJGNTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJGNTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C550CBFFD;
        Fri,  7 Oct 2022 06:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3640961652;
        Fri,  7 Oct 2022 13:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97502C43140;
        Fri,  7 Oct 2022 13:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148768;
        bh=AZv0E22RC3fopFvKn2yneS+saRqtYJnDbON0cQSjtyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lKUgT+lap5REN5UxJYNv8QO9H2N0nHKCTt/ZaG0KWH2ZeZXMQvgcb5r43nbngIq3S
         ZYYxsEWLQMFjnz7pMojLBhOQ1JVmJIrq0IejdBJ+5+//06ZpMsql5Lp2VEGTnSGcsv
         IzGB4+BRWrKSGJtrhNBXzCPj6/k6HXMuZhJ1oOcrC05uVdnYtWhTRbZs6lvtbbFER9
         Cld6wIx9Qyi65i/Zd/4PxJ4QEA2oYzg7+cAsrvVu2NkhAiIwwjYTM5idTwymJK68/w
         nciMhSB8ycC8ACzh/t8dQsUBg0lhXztFXk8E8z70edC18Mbk3E5iNzB6qxJyic234O
         f5IHqzbCS/ZDg==
Received: by mail-lf1-f52.google.com with SMTP id j4so7392794lfk.0;
        Fri, 07 Oct 2022 06:19:28 -0700 (PDT)
X-Gm-Message-State: ACrzQf0CQkicBtWL44PsZ4NiSVeIozLiIuuZTTdnZoRJUWMqjp0xulXu
        XHwuO+NSgw4Jo2Y87VxSiT/eVBkBbEF7yLcjnA8=
X-Google-Smtp-Source: AMsMyM7iOCVnNdjNcWvUALa/ghPK8zxkoNpY1jSZb/y+z+QU/Y7WEupn6Gz4unzKYna9micNDuCaPXhwrV3tQoW1WF8=
X-Received: by 2002:a05:6512:2026:b0:4a2:3bb6:302 with SMTP id
 s6-20020a056512202600b004a23bb60302mr1877506lfs.539.1665148766529; Fri, 07
 Oct 2022 06:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221006224212.569555-1-gpiccoli@igalia.com> <20221006224212.569555-9-gpiccoli@igalia.com>
 <202210061614.8AA746094A@keescook> <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
 <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com>
In-Reply-To: <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 Oct 2022 15:19:15 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
Message-ID: <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Oct 2022 at 15:00, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> First of all, thanks Ard for the historical explanation!
>
>
> On 07/10/2022 06:11, Ard Biesheuvel wrote:
> > [...]
> >> I think it'd be great to make it configurable! Ard, do you have any
> >> sense of what the max/min, etc, should be here?
> >>
> >
> > Given that dbx on an arbitrary EFI system with secure boot enabled is
> > already almost 4k, that seems like a reasonable default. As for the
> > upper bound, there is no way to know what weird firmware bugs you
> > might tickle by choosing highly unusual values here.
> >
> > If you need to store lots of data, you might want to look at [0] for
> > some work done in the past on using capsule update for preserving data
> > across a reboot. In the general case, this is not as useful, as the
> > capsule is only delivered to the firmware after invoking the
> > ResetSystem() EFI runtime service (as opposed to SetVariable() calls
> > taking effect immediately). However, if you need to capture large
> > amounts of data, and can tolerate the uncertainty involved in the
> > capsule approach, it might be a reasonable option.
> >
> > [0] https://lore.kernel.org/all/20200312011335.70750-1-qiuxu.zhuo@intel.com/
>
> So, you mean 4K as the default? I can change, but I would try to not
> mess with the current users, is there a case you can imagine something
> like 4k would fail? Maybe 2K is safer?
>

Reducing the number of writes 4x on systems that can support this has
its own advantages, so I am willing to risk it.

> As for the maximum, I've tested with many values, and when it's larger
> than ~30000 for edk2/ovmf, it fails with EFI_OUT_OF_RESOURCES and
> doesn't collect the log; other than that, no issues observed.
>

OVMF has

OvmfPkg/OvmfPkgX64.dsc:
gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x2000
OvmfPkg/OvmfPkgX64.dsc:
gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x8400

where the first one is without secure boot and the second with secure boot.

Interestingly, the default is

gEfiMdeModulePkgTokenSpaceGuid.PcdMaxVariableSize|0x400

so this is probably where this 1k number comes from. So perhaps it is
better to leave it at 1k after all :-(

> When set to ~24000, the interesting is that we have fewer big logs in
> /sys/fs/pstore, so it's nice to see compared to the bunch of 1K files heheh
>
> Anyway, let's agree on the default and then I can resubmit that, I'm
> glad you both consider that it's a good idea =)
>
> Thanks,
>
>
> Guilherme
