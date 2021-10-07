Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BC42500B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbhJGJaN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 7 Oct 2021 05:30:13 -0400
Received: from mail-vk1-f176.google.com ([209.85.221.176]:34727 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbhJGJaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:30:13 -0400
Received: by mail-vk1-f176.google.com with SMTP id z202so2461191vkd.1;
        Thu, 07 Oct 2021 02:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hzHW72Ay3gWV8fEJFQ+iu6g37baZLnF8PQ8Ot4oxoaI=;
        b=qeBLCc16D7buQsBfZGYlmXCUZ/w243AJOQ/U9QHKzS8K+xLM2qCRhGiy46ZP6fUfXE
         wflMWuY4ySLkJOr0B63wuuO2a8BwGCV9e7qkaAw8/ZzB6DGcWaNnDahpcn0Cx6v/WT38
         tl0HznkRYarmgx8JI4FdafIVXuuU+20dVaKn1V/MmTuiYsu55hcreNXyCb3QN/aM9c0A
         kuZ2YnarftLtP1i7yn0yi3TrmD4ONGm2T4j79mvyRLDPq2oFYmFZ5T9ez1TY4G7yB6p/
         ZOp0dvUxO+6NwVfsKTDsuyE3PimfpBpPL/9L1Hsni9KkFg1/hf7a2I/vIhT7fxNR6kqN
         ndlA==
X-Gm-Message-State: AOAM533Vo9TjIYD9FhXlfUCQ9Tn+xG8GOvKlU+BaMXSXQZYc0gGzJqbF
        g9wCorUjRUnV5b8xxQJXpfXLpcIb//4VbUO93xE=
X-Google-Smtp-Source: ABdhPJxa3fwE1gntWrjljDsvFH6UlsS62TRi8FeltjZ+YAQFTMpawuIEL6cDelrBaNePH9pbfBWO3F+KAs1dSlBCJEY=
X-Received: by 2002:a1f:3a4b:: with SMTP id h72mr2286297vka.19.1633598898975;
 Thu, 07 Oct 2021 02:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211006025350.a5PczFZP4%akpm@linux-foundation.org>
 <58fbf2ff-b367-2137-aa77-fcde6c46bbb7@infradead.org> <20211006182052.6ecc17cf@canb.auug.org.au>
 <f877a1c9-1898-23f3-bba3-3442dc1f3979@amd.com>
In-Reply-To: <f877a1c9-1898-23f3-bba3-3442dc1f3979@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Oct 2021 11:28:07 +0200
Message-ID: <CAMuHMdV3eMchpgUasU6BBHrDQyjCc2TrqJ+zJgFhgAySpqVGfw@mail.gmail.com>
Subject: Re: mmotm 2021-10-05-19-53 uploaded (drivers/gpu/drm/msm/hdmi/hdmi_phy.o)
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Wed, Oct 6, 2021 at 9:28 AM Christian König <christian.koenig@amd.com> wrote:
> Am 06.10.21 um 09:20 schrieb Stephen Rothwell:
> > On Tue, 5 Oct 2021 22:48:03 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> >> on i386:
> >>
> >> ld: drivers/gpu/drm/msm/hdmi/hdmi_phy.o:(.rodata+0x3f0): undefined reference to `msm_hdmi_phy_8996_cfg'
> >>
> >>
> >> Full randconfig fle is attached.
> > This would be because CONFIG_DRM_MSM is set but CONFIG_COMMON_CLOCK is
> > not and has been exposed by commit
> >
> >    b3ed524f84f5 ("drm/msm: allow compile_test on !ARM")
> >
> > from the drm-misc tree.
>
> Good point, how about this change:
>
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 5879f67bc88c..d9879b011fb0 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -5,7 +5,7 @@ config DRM_MSM
>          depends on DRM
>          depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
>          depends on IOMMU_SUPPORT
> -       depends on (OF && COMMON_CLK) || COMPILE_TEST
> +       depends on (OF || COMPILE_TEST) && COMMON_CLK

I'd make that:

    -        depends on DRM
    +       depends on COMMON_CLK && DRM && IOMMU_SUPPORT
            depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
    -        depends on IOMMU_SUPPORT
    -       depends on (OF && COMMON_CLK) || COMPILE_TEST
    +       depends on OF || COMPILE_TEST

to keep a better separation between hard and soft dependencies.

Note that the "depends on OF || COMPILE_TEST" can even be
deleted, as the dependency on ARCH_QCOM || SOC_IMX5 implies OF.

>          depends on QCOM_OCMEM || QCOM_OCMEM=n
>          depends on QCOM_LLCC || QCOM_LLCC=n
>          depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
