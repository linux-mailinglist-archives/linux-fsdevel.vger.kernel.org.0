Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B42E8EA8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbhACWIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 17:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbhACWIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 17:08:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1661C0613CF;
        Sun,  3 Jan 2021 14:07:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o19so60325045lfo.1;
        Sun, 03 Jan 2021 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iIGt/9zpbYpG6wzXWtXdyQg2ktAIzGOKEGAmeFmpvRg=;
        b=ZWVFggDpWHLYGN7D+phAIvoSpc716LmaO+EBAYcfKzeGscBeaZcSwYAgT10co1BLlk
         7/2WasNQI8ysauoXkvSAbPiaRQP90om287P3OZ5fDtwU6Z/q2TMnXPtKXPB5MGKJBxIG
         iGozzcRneCPnxPQrDigW3jfBjJrLEMyvUhpRlrVn4rYP1AytyvHECnv0iE4+I5wSIhNE
         vknuKXUmVUcyXK805rwU85FbepFk3n9acVh/ebKo7csKRpcV3z2nNDx9qmmjB3Na7p4A
         XLpPlFT3W/MQEW2fNi2Dpw+lXVG6BZhT6qaZj17QKibTJzw6qzlf3JH49g9OXt0h/Wip
         Fh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iIGt/9zpbYpG6wzXWtXdyQg2ktAIzGOKEGAmeFmpvRg=;
        b=l8vl5oUV7+YjpG7kNj3s7GOMNzhwz3jGsZ8skPILA0bZqN9XT7iXHDSpY3Z9qDkp1k
         0Yf/1lHhW86hCVgHTGsasKG2RYOKSPEhU4zm3do/43Yy2HE0Re0bivsdD/MmkFf8bYlP
         BDNQPXs4b+pXIPKGifR4EcYh9WMvNQza7Zq9gIm2ZC9y8skKiycCTUyqeYaO3zNa2FlY
         jbq81AsZBRO7QvKbub8P2pq6iTlwIWk56BGLlNFt78J9waDD5NOsREg2Z3JcAaVrcTwk
         wHdLxHFZr7lNLcoAEtw9aUBuX0Uf3Y8u41WTxknWbEAOHiNOMunu+cMEv5lzv09GNC9j
         OlQg==
X-Gm-Message-State: AOAM530surzuAKVMhtJPBtJbX3eAi0jr2qBaAgiCWcTssuvcgD78PkoT
        1kT7N6GFxO6BIGY8M8EvWXHVLiCzHc5rBg==
X-Google-Smtp-Source: ABdhPJyBOTNRTyOCBerwLXvB8C0DG5CIj1T1Ii1iriOBFi17B/jVs4BMmb8uOwbdo2W1KQUgazeDlA==
X-Received: by 2002:ac2:44ba:: with SMTP id c26mr29339438lfm.132.1609711662388;
        Sun, 03 Jan 2021 14:07:42 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id m8sm7054382lfg.134.2021.01.03.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 14:07:41 -0800 (PST)
Date:   Mon, 4 Jan 2021 00:07:39 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Message-ID: <20210103220739.2gkh6gy3iatv4fog@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-9-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-9-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:59PM +0300, Konstantin Komarov wrote:
> This adds Kconfig, Makefile and doc
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  Documentation/filesystems/ntfs3.rst | 107 ++++++++++++++++++++++++++++
>  fs/ntfs3/Kconfig                    |  41 +++++++++++
>  fs/ntfs3/Makefile                   |  31 ++++++++

Also Documentation/filesystems/index.rst should contain ntfs3.

>  3 files changed, 179 insertions(+)
>  create mode 100644 Documentation/filesystems/ntfs3.rst
>  create mode 100644 fs/ntfs3/Kconfig
>  create mode 100644 fs/ntfs3/Makefile
> 

> diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
> new file mode 100644
> index 000000000000..f9b732f4a5a0
> --- /dev/null
> +++ b/fs/ntfs3/Kconfig
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NTFS3_FS
> +	tristate "NTFS Read-Write file system support"
> +	select NLS
> +	help
> +	  Windows OS native file system (NTFS) support up to NTFS version 3.1.
> +
> +	  Y or M enables the NTFS3 driver with full features enabled (read,
> +	  write, journal replaying, sparse/compressed files support).
> +	  File system type to use on mount is "ntfs3". Module name (M option)
> +	  is also "ntfs3".
> +
> +	  Documentation: <file:Documentation/filesystems/ntfs3.rst>
> +
> +config NTFS3_64BIT_CLUSTER
> +	bool "64 bits per NTFS clusters"
> +	depends on NTFS3_FS && 64BIT
> +	help
> +	  Windows implementation of ntfs.sys uses 32 bits per clusters.
> +	  If activated 64 bits per clusters you will be able to use 4k cluster
> +	  for 16T+ volumes. Windows will not be able to mount such volumes.
> +
> +	  It is recommended to say N here.
> +
> +config NTFS3_LZX_XPRESS
> +	bool "activate support of external compressions lzx/xpress"
> +	depends on NTFS3_FS
> +	help
> +	  In Windows 10 one can use command "compact" to compress any files.
> +	  4 possible variants of compression are: xpress4k, xpress8k, xpress16 and lzx.
> +	  To read such "compacted" files say Y here.

It would be nice that we tell what is recommend. I think that this is recommend.
Of course if this use lot's of resource that is different story but I do not
think that is the case.

> +
> +config NTFS3_POSIX_ACL
> +	bool "NTFS POSIX Access Control Lists"
> +	depends on NTFS3_FS
> +	select FS_POSIX_ACL
> +	help
> +	  POSIX Access Control Lists (ACLs) support additional access rights
> +	  for users and groups beyond the standard owner/group/world scheme,
> +	  and this option selects support for ACLs specifically for ntfs
> +	  filesystems.

Same here. Let's suggest what user should do. Is this recommend if we wan't 
to use volume also in Windows?
