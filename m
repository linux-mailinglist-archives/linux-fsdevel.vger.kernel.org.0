Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A72C420328
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhJCRw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJCRw2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 13:52:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F5C0613EC;
        Sun,  3 Oct 2021 10:50:40 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e15so61759796lfr.10;
        Sun, 03 Oct 2021 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2iMRuCjPLsINVQw+OgaPjcThJGWw/f8kcZvZZDA75bY=;
        b=Ti8jNCJp7ftb5ZrVviV6F0dR394sfOd1XZx5L3D1+TNsORPhLlnohkACLN6QDEcqqN
         HjcCqTf880v1TLqU6hh00Dq66wzYD3U2X9qFqG0hwAROrstAglfP/OtRvul76tmepjrx
         F6sceIh0NyBOMwMCnjGrUy/HmhKLCeCFJ6gAuWVobaYJZcOfLIwg6kN0WEESZt/xgzWF
         ub6Tcy+V5ug985Lz4UYzUuWwX98X+8OlgO7wUf/oX/q5QiKvTuOYATkOb9XkPf/4rtO1
         n4lUR6KZRUxx0NZ7zUcmFZzS5oI5B3LwSz5TEO7p3KQf7bcC5rKhsOAEVGqzUQNBBMok
         xlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2iMRuCjPLsINVQw+OgaPjcThJGWw/f8kcZvZZDA75bY=;
        b=fGRh4tjy5zi+B29/gwMqY4un9JSich/S/ojPMBSx1D+OxeDHp+eDcvEZkK/HbJ2GGP
         059f7Mb0Ankxz4flkB6W0EX5cxaCaygZ3Bfpf67NAhxSaBMJjQ1kPj/tuSe5TqhHEtPQ
         Ms4iaj58S5ZkaY5ft09qfC+mxcsdzI3j4+x5YOdbiC2Fizlz8AJ5h4egka4a8egu0e0n
         miHzkIYREvxrzo61W5MOo/fihQ90S39PWXFABn67P2YnAxuCuKVoKxeJ9KSDl6GvCxIy
         kAzE22FNb9ZmXBPvNZqfAv4C4taPX8NV34Bs01//v1riSUynyDwxK4u12sk+Pwv7gxvH
         ARoA==
X-Gm-Message-State: AOAM533S7INfthwnLlMucTw7whZ3tcFCjk0NNu+z1tf0slvGM9b8EX4v
        Iffego0UdRWuoY24UzyNJlc=
X-Google-Smtp-Source: ABdhPJyjNdjw/hVXJMP3xb/cyret3SIinnQDRSVfmMXQZrNMNEJ4VWnNvnUFjuirBrxoiwgbWVEKaA==
X-Received: by 2002:a05:6512:463:: with SMTP id x3mr9974290lfd.103.1633283438739;
        Sun, 03 Oct 2021 10:50:38 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b22sm1378191lfv.286.2021.10.03.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 10:50:38 -0700 (PDT)
Date:   Sun, 3 Oct 2021 20:50:36 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mohammad Rasim <mohammad.rasim96@gmail.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Check for NULL if ATTR_EA_INFO is incorrect
Message-ID: <20211003175036.ly4m3lw2bjoippsh@kari-VirtualBox>
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
> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")

I see that you have include this to devel branch but you did not send V2
[1]. I also included Mohammad Rasim to this thread. Maybe they can test
this patch. Rasim can you test [2] if your problem will be fixed with
this tree. Or just test this patch if you prefer that way.

[1]: github.com/Paragon-Software-Group/linux-ntfs3/commit/35afb70dcfe4eb445060dd955e5b67d962869ce5
[2]: github.com/Paragon-Software-Group/linux-ntfs3/tree/devel

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
