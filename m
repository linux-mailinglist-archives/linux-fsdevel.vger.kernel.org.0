Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C542BF34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhJMLvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 07:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhJMLvN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 07:51:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 481956113E;
        Wed, 13 Oct 2021 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634125750;
        bh=08cmMCW6GG9gWIOhjxYfXSFIYClklm6HhvdpGKvi16g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a8/bDma6IeOw47+CVOZM0/AVmVmBWj1bzuEKec7UQcITca/iyIJH9GPAJIvAVnR2H
         gIj1lAPQWNgzGnxnDjDyDaF32C+R5o6fUz/YUAp3c1YZe/9hIP383TAgZJNW4BPXEl
         xYD+h/4uCsU8H8vRNmQD46ZYx8EtXiEsgIDmEbcLam7Kgy7p0D1CEyyWBZc8Oo5s4s
         mKx9gm2Et/G27qN8h5upJOFFpTZWaLQUyDXCOPY+Lk6JU5Ixx50zk5XTqJg6j3RoFm
         M2wBcpLSkUUaqE3EQb6QT7vjrO8+tWKwpsFH21EvMrrffZtKhX7xSJj6hkqXb9k04J
         n/uD/fERi9WNA==
Received: by mail-wr1-f47.google.com with SMTP id u18so7454311wrg.5;
        Wed, 13 Oct 2021 04:49:10 -0700 (PDT)
X-Gm-Message-State: AOAM5336sVVSTv4GlHgyv6EXioK/K2NL0aV6Jg7okZrRAzM61oFdCg9f
        1ZjYZgvJn6hw+C66/MlVwogV4enydqLgkjA86v0=
X-Google-Smtp-Source: ABdhPJxAPtyVc3G/tOtzJ7z3+RdpcFSsTVHBBrdmAoAeaOD1MZ0LF/ObKmsWMXdtxVVGB9gwLelX+Cl/3S/Jhom+ziQ=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr12179996wmj.1.1634125748613;
 Wed, 13 Oct 2021 04:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211006025350.a5PczFZP4%akpm@linux-foundation.org>
 <58fbf2ff-b367-2137-aa77-fcde6c46bbb7@infradead.org> <20211006182052.6ecc17cf@canb.auug.org.au>
 <f877a1c9-1898-23f3-bba3-3442dc1f3979@amd.com> <CAMuHMdV3eMchpgUasU6BBHrDQyjCc2TrqJ+zJgFhgAySpqVGfw@mail.gmail.com>
 <CAK8P3a1LLABstZ2rPYpsXRTxMdbSTrh0y753vrfGbRovv9fS8A@mail.gmail.com>
In-Reply-To: <CAK8P3a1LLABstZ2rPYpsXRTxMdbSTrh0y753vrfGbRovv9fS8A@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Oct 2021 13:48:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1PoL4KMJfRyOB59tNYR6-cn3rWqDfqXeeW5ggMVGaeVg@mail.gmail.com>
Message-ID: <CAK8P3a1PoL4KMJfRyOB59tNYR6-cn3rWqDfqXeeW5ggMVGaeVg@mail.gmail.com>
Subject: Re: mmotm 2021-10-05-19-53 uploaded (drivers/gpu/drm/msm/hdmi/hdmi_phy.o)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
        freedreno <freedreno@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 12:54 PM Arnd Bergmann <arnd@kernel.org> wrote:
> On Thu, Oct 7, 2021 at 11:51 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> -msm-$(CONFIG_DRM_FBDEV_EMULATION) += msm_fbdev.o
> -msm-$(CONFIG_COMMON_CLK) += disp/mdp4/mdp4_lvds_pll.o
> -msm-$(CONFIG_COMMON_CLK) += hdmi/hdmi_pll_8960.o
> -msm-$(CONFIG_COMMON_CLK) += hdmi/hdmi_phy_8996.o
> +msm-$(CONFIG_DRM_FBDEV_EMULATION) += msm_fbdev.o \
> + disp/mdp4/mdp4_lvds_pll.o \
> + hdmi/hdmi_pll_8960.o \
> + hdmi/hdmi_phy_8996.o
>
>  msm-$(CONFIG_DRM_MSM_HDMI_HDCP) += hdmi/hdmi_hdcp.o

I fixed my local copy now after noticing that these should not go
after CONFIG_DRM_FBDEV_EMULATION but the top-level option:

@@ -23,8 +23,10 @@ msm-y := \
        hdmi/hdmi_i2c.o \
        hdmi/hdmi_phy.o \
        hdmi/hdmi_phy_8960.o \
+       hdmi/hdmi_phy_8996.o
        hdmi/hdmi_phy_8x60.o \
        hdmi/hdmi_phy_8x74.o \
+       hdmi/hdmi_pll_8960.o \
        edp/edp.o \
        edp/edp_aux.o \
        edp/edp_bridge.o \
@@ -37,6 +39,7 @@ msm-y := \
        disp/mdp4/mdp4_dtv_encoder.o \
        disp/mdp4/mdp4_lcdc_encoder.o \
        disp/mdp4/mdp4_lvds_connector.o \
+       disp/mdp4/mdp4_lvds_pll.o \
        disp/mdp4/mdp4_irq.o \
        disp/mdp4/mdp4_kms.o \
        disp/mdp4/mdp4_plane.o \

           Arnd
