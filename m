Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0445841CB28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbhI2Rq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244930AbhI2Rq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:46:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C5C06161C;
        Wed, 29 Sep 2021 10:44:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i19so11121796lfu.0;
        Wed, 29 Sep 2021 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k40QSKaIzA7xI71zhIsTqgkNgsI1dltQ3koc7EdeH7M=;
        b=l97ZYlbzmvKAyfwAYe+jsP1QjlEw1GC0NWjKIkPDeJjvSQSOa5AprQqUy1bkTebqtd
         X7NL/LesrR2p4CX6R6yulPo0rE4QC2cqNkaxgv1uXfqEw4wP3qMM5OnAgTiakJKQLI1K
         FeonMIeflrgodwHKapVpYs/yicDdfZve6nlwzqK3Fxp36qBnC4HeJid/cmYiOIfeBVuH
         wD3WI16J0MGv0yAi3ZE66ny3DPdcY3A9f3hAd88+zf859KpKnNKqA4WO8tHXlCOTYao1
         RbnJ3keA2C/hFDgIYvDIPiDvrW2DIk6DTlciyHX10pXZp8o8B71YiGtSHAYda9YPRWcc
         B/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k40QSKaIzA7xI71zhIsTqgkNgsI1dltQ3koc7EdeH7M=;
        b=12lm986V30V3m0GrYHpvXB19NiIy4f2T+UPIOTEnu0GH3GUIxAtHncnPOtyX0815Yv
         ZYGwA0FYxyi55b4DiAuIu92hnVe72aWhvYDKdOyRMTIRhKro8B/AhLe/D8aB2hW15alA
         fDJVEYRiP1sVR1EhRJhfhJA/55AIC5ul6m2V/dChztJDFJqW3rdomRPbMqTwP9Rk/sGg
         SGanF3WfHMQRvW6PzD5C5ZxWezbZGI3ub+8G5ipc/aOV+egeg/C7ETaybtwoQH+3T5Le
         HlcyhBC7DdcsMRZ0Gg2S5xv6I+NpFX0DKnirrflVXrWQof+cF5w7QQEhaNd3dEQWg1Hz
         Rgeg==
X-Gm-Message-State: AOAM530dS1a/k8ROiNlMrqjfvXer+cPVkLps+Kzxxyo/3iRyYbKfxshS
        LQNO6fGz5bfrboudBKp6pe8v1c/KYKw=
X-Google-Smtp-Source: ABdhPJxHVdMVdhhT8Xf7U20OOMF9gil0ngthBcjWbnD2wFVZAWBvqYqKz27ekusaLjTlyu00XpFG2w==
X-Received: by 2002:a19:ae14:: with SMTP id f20mr989424lfc.488.1632937483901;
        Wed, 29 Sep 2021 10:44:43 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id br40sm61892lfb.64.2021.09.29.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 10:44:43 -0700 (PDT)
Date:   Wed, 29 Sep 2021 20:44:41 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
Message-ID: <20210929174441.qshpp5ukuszb7cf5@kari-VirtualBox>
References: <227c13e3-5a22-0cba-41eb-fcaf41940711@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227c13e3-5a22-0cba-41eb-fcaf41940711@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 07:35:43PM +0300, Konstantin Komarov wrote:
> This can be reason for reported panic.

Is this public panic? If it is then put link here. If you have report
from panic you can put it here also. Patch itself looks correct.

> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/frecord.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 9a53f809576d..007602badd90 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -3080,7 +3080,9 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
>                         const struct EA_INFO *info;
>  
>                         info = resident_data_ex(attr, sizeof(struct EA_INFO));
> -                       dup->ea_size = info->size_pack;
> +                       /* If ATTR_EA_INFO exists 'info' can't be NULL. */
> +                       if (info)
> +                               dup->ea_size = info->size_pack;
>                 }
>         }
>  
> -- 
> 2.33.0
> 
