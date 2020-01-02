Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F212A12E64D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 13:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgABM6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 07:58:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40418 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgABM6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:58:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so39119433wrn.7;
        Thu, 02 Jan 2020 04:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=42ZkJ1/HkGSp5JEAa8sLLmu5GQJaZejYjvN6y481Vvk=;
        b=uPEKQrBNQJahhicTSehio5Xpx5wW6bXGv7UxESVKj15uxLNUoLhRUlqhMkKIP46/U3
         sYypGMdgqchLktk3DELlvWoTndFXC4mlikcLUKgKBrJN21NjkdGrOL6fQp/CYzBxz3I7
         jKN+X8Horvpuj7Ccq4B0XLHRnSLV/glwcmyKnFg0z7QSWXXpTOCetFiLLLP0f+V8Wd/V
         /tJHafUJsQJ3L3vW/oG43fO5Xb3CbtSWYxsPfEN4i/pHJUfMtokosCEuZ1j9CyZMOi1B
         ogVC8HhpwapvQllEc9Svkh1DS2MMfWizyb8wxaiPGg9ilUFCwY1kOzeV4D6tmZ92rpIA
         KAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=42ZkJ1/HkGSp5JEAa8sLLmu5GQJaZejYjvN6y481Vvk=;
        b=JcjnGzOpDvWP2aQLNBQzSZhNmCULtckOYVrCjtID/nw/hXnVG8km4iL0K7O4hmszVL
         QZ5e3HotZgsngAUIg84+FTZoCMx+v6ko0togdPMjiWEXU7QXzVNh9q5Z4cveqocv1IL8
         DNNmg6xuWkbz+HyLDLhKqntBaUwyfEc+OGSUKgwj81SJdZnrWewMXQfM5eemZ766JXyQ
         FZbJ8f6RAGIyGcvLM3HQo5nc7R+NmrYYmfZrw97qoCdRdAEf11XHc6zGHcehX3LCTAVL
         oGpp0w4qBWszRJtzkWgx7YUAROk34WyImXXWBiVoidZGjW0APjm+vhe7GFamWh5ZNb3h
         5KMQ==
X-Gm-Message-State: APjAAAVYv8xqdIT8Yqbkt8q/D04u1G5PojvthUkG6RxaQBz5kJ/iXhMk
        tRwamg6fGvMSSbEVZFvV15I=
X-Google-Smtp-Source: APXvYqzWhhp+shL8VGy4yNyc8NoX5E7wN3rF8KQHlMLauv8mOQfjfGpyH/0DTQX0fXluFWcqOC024A==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr83746667wrn.5.1577969911891;
        Thu, 02 Jan 2020 04:58:31 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p18sm8438385wmb.8.2020.01.02.04.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 04:58:31 -0800 (PST)
Date:   Thu, 2 Jan 2020 13:58:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 12/13] exfat: add exfat in fs/Kconfig and fs/Makefile
Message-ID: <20200102125830.z2uz673dlsdttjvo@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082408epcas1p194621a6aa6729011703f0c5a076a7396@epcas1p1.samsung.com>
 <20200102082036.29643-13-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102082036.29643-13-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 16:20:35 Namjae Jeon wrote:
> Add exfat in fs/Kconfig and fs/Makefile.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/Kconfig  | 3 ++-
>  fs/Makefile | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 7b623e9fc1b0..5edd87eb5c13 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -139,9 +139,10 @@ endmenu
>  endif # BLOCK
>  
>  if BLOCK
> -menu "DOS/FAT/NT Filesystems"
> +menu "DOS/FAT/EXFAT/NT Filesystems"
>  
>  source "fs/fat/Kconfig"
> +source "fs/exfat/Kconfig"
>  source "fs/ntfs/Kconfig"
>  
>  endmenu
> diff --git a/fs/Makefile b/fs/Makefile
> index 98be354fdb61..2c7ea7e0a95b 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_HUGETLBFS)		+= hugetlbfs/
>  obj-$(CONFIG_CODA_FS)		+= coda/
>  obj-$(CONFIG_MINIX_FS)		+= minix/
>  obj-$(CONFIG_FAT_FS)		+= fat/
> +obj-$(CONFIG_EXFAT)		+= exfat/
>  obj-$(CONFIG_BFS_FS)		+= bfs/
>  obj-$(CONFIG_ISO9660_FS)	+= isofs/
>  obj-$(CONFIG_HFSPLUS_FS)	+= hfsplus/ # Before hfs to find wrapped HFS+

Seems that all filesystems have _FS suffix in their config names. So
should not have exfat config also same convention? CONFIG_EXFAT_FS?

-- 
Pali Rohár
pali.rohar@gmail.com
