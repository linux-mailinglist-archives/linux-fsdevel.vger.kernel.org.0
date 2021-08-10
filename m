Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7562A3E548D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhHJHsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 03:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhHJHsH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:48:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815D4C0613D3;
        Tue, 10 Aug 2021 00:47:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so16987415lfu.5;
        Tue, 10 Aug 2021 00:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ho5vi/DVYwm8HX90yRCWh3kL6ZbH0pPpPt+rtsTu+E=;
        b=Tq25JJsTwzCuLHsWd9rZoCPk3z64mDLARlSk6+OF1bu8+lJF6AiA2eUxq1xjeaH0rY
         rQILgAW4IsPYmnv2U/XsUxcbpintogfNKMqmMOG2SbcVjUt3MJ4fHJ8mtJzfGOx+TZ9e
         uc8L76lsWJU4YsBdWpxtXKDH+/G24jsxOdJHRqzrFOOeUpgwY96/T+HasQKBHlBmrOj1
         rqocaSnG9epHbk/fQ1lWBux5srmnIX1Pf4+ALLz+qQElDi69NJzlYFvTcwh+w9UDCQ5X
         PqiPbkwOZEYVyAQjqJ+fYNiDuBhK7bJYBJ9U7ftfnftbJh0xHrmOWyF4O0NYARUXgEAX
         bGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ho5vi/DVYwm8HX90yRCWh3kL6ZbH0pPpPt+rtsTu+E=;
        b=uSGa9+fID7eyUS4X++NT6kIGi6qMJnh4L5AROLuggroC7Z8AwBw1GNnLdAkQql19lu
         9rhCYSmCoAYO1s5vBOO0SYI7WLXghS9XwJEOq+YGGNGJLHYxgYSaRXtbpT5DhdUHOc3V
         g+AHZiny+z6IAV7vy25a3Yzx4PLU4cQ0v2iZWQDmlbzsIOXO6qoIZwP24Nqd2CQ6Zc4q
         2sCbJjgzy7A18Cza5LYV6Ii13NZCsldWhvXd3UWjlMFmzHqQ8ATu/KkiqZQnGNrD4Wtq
         /9RcDfOHA42DyWtKJeL0PsJyqnKIAhwfaBkvKvi3M/TK/A21aYsqvN78Z1wZFofkVOyJ
         SY/A==
X-Gm-Message-State: AOAM5309j8hJPt/jybm95KGLpilQj3t3Rpxguq+5rtreQpoam9xxNG16
        JO3PZjq5UQtodpI5uroLLpA=
X-Google-Smtp-Source: ABdhPJwNu3wAQ5xPPvZPKr1/VluV1GfO/Sd7e30s19zJ3T6BV3QajBVWSPz5ccTJyW7KMMhPLGgKug==
X-Received: by 2002:a05:6512:2354:: with SMTP id p20mr20919562lfu.26.1628581663777;
        Tue, 10 Aug 2021 00:47:43 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id u14sm2153481lfu.120.2021.08.10.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:47:43 -0700 (PDT)
Date:   Tue, 10 Aug 2021 10:47:40 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Message-ID: <20210810074740.mkjcow2inyjaakch@kari-VirtualBox>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-9-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729134943.778917-9-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:49:41PM +0300, Konstantin Komarov wrote:
> This adds Kconfig, Makefile and doc
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  Documentation/filesystems/ntfs3.rst | 107 ++++++++++++++++++++++++++++

Still missing Documentation/filesystems/index.rst as I stated before
https://lore.kernel.org/linux-fsdevel/20210103220739.2gkh6gy3iatv4fog@kari-VirtualBox/

>  fs/ntfs3/Kconfig                    |  46 ++++++++++++
>  fs/ntfs3/Makefile                   |  36 ++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 Documentation/filesystems/ntfs3.rst
>  create mode 100644 fs/ntfs3/Kconfig
>  create mode 100644 fs/ntfs3/Makefile
> 
> diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst


> +Mount Options
> +=============
> +
> +The list below describes mount options supported by NTFS3 driver in addition to
> +generic ones.
> +
> +===============================================================================
> +
> +nls=name		This option informs the driver how to interpret path
> +			strings and translate them to Unicode and back. If
> +			this option is not set, the default codepage will be
> +			used (CONFIG_NLS_DEFAULT).
> +			Examples:
> +				'nls=utf8'

It seems that kernel community will start use iocharset= as default. nls
option can still be alias but will need deprecated message. See message
https://lore.kernel.org/linux-fsdevel/20200102211855.gg62r7jshp742d6i@pali/

and current work from Pali
https://lore.kernel.org/linux-fsdevel/20210808162453.1653-1-pali@kernel.org/

This is still RFC state so probably no horry, but good to know stuff. I
also added Pali so he also knows.

> diff --git a/fs/ntfs3/Makefile b/fs/ntfs3/Makefile
> new file mode 100644
> index 000000000..279701b62
> --- /dev/null
> +++ b/fs/ntfs3/Makefile
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the ntfs3 filesystem support.
> +#
> +
> +# to check robot warnings
> +ccflags-y += -Wint-to-pointer-cast \
> +	$(call cc-option,-Wunused-but-set-variable,-Wunused-const-variable) \
> +	$(call cc-option,-Wold-style-declaration,-Wout-of-line-declaration)

It is good idea to include this url in commit message.
https://lore.kernel.org/linux-fsdevel/212218590.13874.1621431781547@office.mailbox.org/

And also add that signed off tag from Tor Vic.

> +
> +obj-$(CONFIG_NTFS3_FS) += ntfs3.o
> +
> +ntfs3-y :=	attrib.o \
> +		attrlist.o \
> +		bitfunc.o \
> +		bitmap.o \
> +		dir.o \
> +		fsntfs.o \
> +		frecord.o \
> +		file.o \
> +		fslog.o \
> +		inode.o \
> +		index.o \
> +		lznt.o \
> +		namei.o \
> +		record.o \
> +		run.o \
> +		super.o \
> +		upcase.o \
> +		xattr.o
> +
> +ntfs3-$(CONFIG_NTFS3_LZX_XPRESS) += $(addprefix lib/,\
> +		decompress_common.o \
> +		lzx_decompress.o \
> +		xpress_decompress.o \
> +		)
> \ No newline at end of file
> -- 
> 2.25.4
> 
