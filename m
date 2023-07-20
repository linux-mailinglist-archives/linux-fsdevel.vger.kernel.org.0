Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6360075AD9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGTL5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 07:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjGTL53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:57:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71CA10CB;
        Thu, 20 Jul 2023 04:57:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99357737980so127795466b.2;
        Thu, 20 Jul 2023 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689854247; x=1690459047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEIUFqZ8/Bo/7OzswG7WehHeVU6nxJVjchlFmBJN/gc=;
        b=sab3O3jQd+CYRloP7X1t93c1kiFsTEZMeKDriFob1uWehLbaMPJ+g2pWNgohwFwh0x
         oAJ8KmaC+OUVyt2n9kzP+MW98HQAlGrq08ZbSx4L89P3tvD7Bzq5WGS2vhJZxfJ9zdpg
         6aiiUlRvxYhbTm5ZkeInx8OAFeuKXreaWRLT+j1RbWse+ynByELtOsPyalFMu4boPT8O
         fCzDsc/IkW9VlU9WT5J25rF22j8kpjBGdnLHm3R95HKg/7jofdJGa/XPqGJUlhRzAvd9
         EEtwfheOkWWWut6YTMfP3gIpgdMfUCywCGSW700nbP0hfM8hW87xRzq4D6xtc/SpFPx+
         QrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854247; x=1690459047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEIUFqZ8/Bo/7OzswG7WehHeVU6nxJVjchlFmBJN/gc=;
        b=doxIELDLJcVbRF66q93X2P6Sp85dUpe1Vojz2Uuw/M+BRbVZdBhvRYDuuQKi7QXay1
         2o/uA5e+JYwfMy+J/IzVTLhuNibtGC+a1VwXbmFtxne4iMK2CdDJf1+U4mS7rM+NY48h
         EFgd1lzlDUTpxypfRgzo+30ZdBzS2bi4u0fkl5pjUCbeEtorIXNdOQPVWut3Pqn4ffqm
         TIlT7Hsiiu6GetHeH+H3REqdnKGIT+rC06vvNHJRLDMcIEeD4mVQY45Z6n4Hdk8bnkdX
         8gsvQIGBwgbTIOp3sBheV0uv+U8Av0AIs9wf6h1M2UQEOYGoXPc7WQ55ONiB/OrZsCry
         3c4A==
X-Gm-Message-State: ABy/qLay1BgR2XjZtfYdzBuBzikCK7+INDq5mMh4+F1GuVzvJW3tIn1T
        QKQHdV3t+gFAn8khQLtOniPDOVietujsTVETXEZjqO6nlInZzw==
X-Google-Smtp-Source: APBJJlEoHj71E+vGYJG8JbpB0Axw6SNrU+WwCO42wG0fT6uXmh4s5Fs8rHDoYtAI8FCj5BDLDCAw0GN8uFKmw+ifjsg=
X-Received: by 2002:a17:906:158:b0:99b:40b5:1c3b with SMTP id
 24-20020a170906015800b0099b40b51c3bmr4219040ejh.57.1689854247186; Thu, 20 Jul
 2023 04:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230720115445.15583-1-piotr.siminski@globallogic.com>
In-Reply-To: <20230720115445.15583-1-piotr.siminski@globallogic.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 20 Jul 2023 13:57:18 +0200
Message-ID: <CAKXUXMzL4i0jT0xPFsV4ZG6L82yDCYLtKoUL7t=21ZDZ4OMY7w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: change reiserfs status to obsolete
To:     Piotr Siminski <piotr.siminski@globallogic.com>,
        Jan Kara <jack@suse.cz>
Cc:     reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Piotr, thanks for the clean up in the MAINTAINERS file.

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Jan, could you pick this patch?

Lukas


On Thu, Jul 20, 2023 at 1:54=E2=80=AFPM Piotr Siminski
<piotr.siminski@globallogic.com> wrote:
>
> Reiserfs file system is no longer supported and is going to be removed
> in 2025 as stated in commit eb103a51640e ("reiserfs: Deprecate reiserfs")=
.
>
> Signed-off-by: Piotr Siminski <piotr.siminski@globallogic.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5c16bb92fe2..c340c6fc7923 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18064,7 +18064,7 @@ F:      include/linux/regmap.h
>
>  REISERFS FILE SYSTEM
>  L:     reiserfs-devel@vger.kernel.org
> -S:     Supported
> +S:     Obsolete
>  F:     fs/reiserfs/
>
>  REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM
> --
> 2.34.1
>
