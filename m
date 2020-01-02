Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936E512E647
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 13:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgABMxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 07:53:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35504 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgABMxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 07:53:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so5570262wmb.0;
        Thu, 02 Jan 2020 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YwBwOFr2GTeVQt8tImFqrPLqlCxuVqOvF8sYlUHm2+Q=;
        b=p/DlE16fJVziot3niZucLMnORocGMIL+ZirYo/4YUbuvBiIHVKkOJ7EhWFE69ABIKg
         YGL50ANCbvnvq7e7Gg0PPE317Rg0EbHIMf0ixGjyYiJwPvrTNG67j1Jnc26jbJXSy0lA
         6dGRJqi9Zot5iEumK8FfUA6Yw8xC3qg5wtaCsX5h+eLYorKl9N9uj3WwlqkewAJ10bSh
         YDvZYvTDbBuN638FKFp6SFxud4Z3bWjvECswQVN6+8Y/j77JR4T0l3LJZIJzWCE52VXP
         Nbgo6UDmfXtCAQe+UIjBy5iRcmvSPxSPZfo8BwP96A4Vm9dwTmbOOIQuovylwZJJGc8I
         U1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YwBwOFr2GTeVQt8tImFqrPLqlCxuVqOvF8sYlUHm2+Q=;
        b=caadJEaAo/OKZw2YdVKIIpgUckA68aRq2VEmzg0MK1fpKYNr9qjVBvAKkCr/ViL3g8
         0tHpSN8zbNM3vrjMbCTbRqxKmKTIGINtLaadAm4GKUcs62BvKf+op7kQ3GQGwktwN8Z5
         9N4JsJkKaif/U5ZVGMJx+9HjyBHw5AQoCfm4ZhDnjAkGiCn/MshVLUNPcWVUpidRY20i
         AbVkrq4IMvmsn2c2qSxoP+77zPvrJsrm4Z/FrcNfsfG9zyys41veLjkvhl+4tmg6didj
         Y2xPG3Uc3jbN+fm5CwuWcETs/ToJ31KJD0bTJGpLcslfaXu0vG/egitnmaOJ7HU6zjNb
         f7KQ==
X-Gm-Message-State: APjAAAWlZKGuzIW5AaHJ0FfGYnCRQpmki7XMDp4LiUuJGR8ZvbHQ2hU7
        KehS7i69rBkmmAqZWa7nV6w=
X-Google-Smtp-Source: APXvYqz+dvHUrW9CNP28JElRU2HRzVrtAusa1wqO20Yf+ipAm5KyW+ec/KZa5sNIXWt8dEw0UFinXA==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr14098075wmb.53.1577969620616;
        Thu, 02 Jan 2020 04:53:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id d8sm57064112wre.13.2020.01.02.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 04:53:39 -0800 (PST)
Date:   Thu, 2 Jan 2020 13:53:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 11/13] exfat: add Kconfig and Makefile
Message-ID: <20200102125338.pf3aw62qtnch5oqa@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082408epcas1p28d46af675103d2cd92232a4f7b712c46@epcas1p2.samsung.com>
 <20200102082036.29643-12-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200102082036.29643-12-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday 02 January 2020 16:20:34 Namjae Jeon wrote:
> This adds the Kconfig and Makefile for exfat.
> 
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/Kconfig  | 21 +++++++++++++++++++++
>  fs/exfat/Makefile |  8 ++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 fs/exfat/Kconfig
>  create mode 100644 fs/exfat/Makefile
> 
> diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
> new file mode 100644
> index 000000000000..11d841a5f7f0
> --- /dev/null
> +++ b/fs/exfat/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +config EXFAT
> +	tristate "exFAT filesystem support"
> +	select NLS
> +	help
> +	  This allows you to mount devices formatted with the exFAT file system.
> +	  exFAT is typically used on SD-Cards or USB sticks.
> +
> +	  To compile this as a module, choose M here: the module will be called
> +	  exfat.
> +
> +config EXFAT_FS_DEFAULT_IOCHARSET
> +	string "Default iocharset for exFAT"
> +	default "utf8"
> +	depends on EXFAT
> +	help

Hello! We have already config option FAT_DEFAULT_IOCHARSET. Cannot it be
reused? FAT_DEFAULT_IOCHARSET is used for msdos.ko and vfat.ko, both are
from FAT drivers family. So it looks like that FAT_DEFAULT_IOCHARSET
could be used also for exFAT which belongs to FAT fs family.

> +	  Set this to the default input/output character set you'd
> +	  like exFAT to use. It should probably match the character set
> +	  that most of your exFAT filesystems use, and can be overridden
> +	  with the "iocharset" mount option for exFAT filesystems.
> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
> new file mode 100644
> index 000000000000..e9193346c80c
> --- /dev/null
> +++ b/fs/exfat/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Makefile for the linux exFAT filesystem support.
> +#
> +obj-$(CONFIG_EXFAT) += exfat.o
> +
> +exfat-y	:= inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o \
> +	   file.o balloc.o

-- 
Pali Rohár
pali.rohar@gmail.com
