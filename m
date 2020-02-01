Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB714FAB9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 22:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBAVfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 16:35:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51521 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgBAVfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 16:35:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so11791246wmi.1;
        Sat, 01 Feb 2020 13:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=S9VZZ78KljGoa33WiUOilS5VA6siSq4KfQ/PVuLOUBE=;
        b=cGVZnFZCzSSv10xCFYehVFN0LVdEAzZGcAfUNdgjLxsCY+b7DSlBTU0PimWj0vln2R
         86aAHtHeh0BHgzmP5zxkKjNDvD0+BE2s+5Msin0cEVjF7A4iH8yttNVR4AG8n4rf01Em
         9CT+4qqQU/dmVhiQRfWZMqZvyHdikIiARuw0aC1FJO+lvqLKU/E93vreHUCcswAlgDvM
         1nUHOOvrrQy85MfJnv3m+W6sVXZ6+eAkdh6T2hTYbmA3KEfu9Ptq5UhFe6Gk90ba8KLU
         /vqP2mbX4aYdStiXFY/Hs6fKoZWPFst07Dhbo1FYopfRslDyhtBpCWCiUxQPPWgmatuP
         I3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=S9VZZ78KljGoa33WiUOilS5VA6siSq4KfQ/PVuLOUBE=;
        b=KAeHNz0ACX5uh22cOiUqXtn232ccjckIT1oWGklCArCa5GWWGXGA0DZiInY4Y5pNvF
         V8uYYasP97jLG4IGN3DP7Itz3UJ5YUjb//mSRYR5jOemUehRfaJRQbqP80xGMD4d8Rlx
         PQmANDOzFV7CJSG0wxpN5P/ZEJOh9vWPivzMVDRI6mT3kTYW3QsMU3q1rhYbRX4ky3uM
         Ibbnlo3CHEYy5DLrrUCBf8sNO5PUT3w+KAHg/F/CKBpzbUrwU58Ypr9zOo/8dFlGyI7r
         GaHaGr2fdCYMmmxDsJ4kP1RRm+AfkBT9Tjyk+fD38AozVSFZ+QkOG8bAItZ6AjvUXmoa
         mnCA==
X-Gm-Message-State: APjAAAWy5Fddn7q+U1E7veJSYa3T7f+HMNWimIX96damkHCQ6n3AB1mi
        kyHSURS+iRWb+jwU+M8Cbt8=
X-Google-Smtp-Source: APXvYqzn5MJYZfTNQQTHWl1+XmLcR9O4YgJQwxRmXwXcE5TSQBIqADfogAh3L+707cfNqFq8yBkQ3Q==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr20243827wmc.165.1580592919349;
        Sat, 01 Feb 2020 13:35:19 -0800 (PST)
Received: from felia ([2001:16b8:2d5f:200:35fb:e0f1:a37a:5e0a])
        by smtp.gmail.com with ESMTPSA id g79sm16018741wme.17.2020.02.01.13.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 13:35:18 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sat, 1 Feb 2020 22:35:12 +0100 (CET)
X-X-Sender: lukas@felia
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: rectify radix-tree testing entry in
 XARRAY
In-Reply-To: <20200201180234.4960-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.2002012231410.5859@felia>
References: <20200201180234.4960-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sat, 1 Feb 2020, Lukas Bulwahn wrote:

> The initial commit 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
> missed a trailing slash to include all files and subdirectory files.
> Hence, all files in tools/testing/radix-tree were not part of XARRAY,
> but were considered to be part of "THE REST".
> 
> Rectify this to ensure patches reach the actual maintainer.
> 
> This was identified with a small script that finds all files only
> belonging to "THE REST" according to the current MAINTAINERS file, and I
> acted upon its output.
> 
> Fixes: 3d5bd6e1a04a ("xarray: Add MAINTAINERS entry")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Matthew, please pick this small fixup patch.
> 
> applies cleanly on current master and next-20200131
> 

Matthew, Joe Perches just informed me that get_maintainers.pl is smart
enough to handle the case below and does not strictly need a further 
trailing slash.

Please ignore this patch; the commit message is actually wrong.

Lukas

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f77fb8cdde3..4ebcc2f09028 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18198,7 +18198,7 @@ F:	lib/idr.c
>  F:	lib/xarray.c
>  F:	include/linux/idr.h
>  F:	include/linux/xarray.h
> -F:	tools/testing/radix-tree
> +F:	tools/testing/radix-tree/
>  
>  XBOX DVD IR REMOTE
>  M:	Benjamin Valentin <benpicco@googlemail.com>
> -- 
> 2.17.1
> 
> 
