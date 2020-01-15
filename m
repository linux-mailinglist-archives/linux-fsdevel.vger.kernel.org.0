Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABDE213BC8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 10:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgAOJjU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 04:39:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35589 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgAOJjU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:39:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so15020606wro.2;
        Wed, 15 Jan 2020 01:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZfnLElFWa6G1bLX7+mNV41fXukHAYDx919Y3lEHje0o=;
        b=s6n7uOoRZciHM+AWw01UFjo/YPOlfTf2uKFE40T1I7QMhf5q9n+zdss3nKXJnbP6l2
         zsUa0RxZLYJQoZn9srzAcKf7lKlAidY2SzzdsDXE1WzsEbTTVFApd6LlUbUy038kdJFg
         H2677lS15IjLvEumD3425/7ybsP76IpE3tru4DydDRPfjOADd6GwEMTXlkBDC1Lz/GaF
         ekCn/TMELJ/pXK/zNW0bEyCFCkELKhBXE9gdqc1E5ZNvhh8d7LR/4lXSxybFc5hqt8Ey
         ZBGm0kU/+CxWKQqpi5p2YBgoZpBH9650hkR3DjoNUKrkMOIRT0tV5CuXkFacmCiQGKyN
         17nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZfnLElFWa6G1bLX7+mNV41fXukHAYDx919Y3lEHje0o=;
        b=TtcVC+D1yDuDM0ZZRuv6Tk3hMLUVDL0leI7EPh/QX0MYbPvjr85aVgPRvsMhfaUl/G
         f36ch2s+KT0D9ES7iPoa49xTszlbNyl5wFgQbBwTtYqWI+lXEEAUVnrAfQgB+oN9qs5Y
         +A6DbxpZb/yqev+7KT/Ssm1fvVr5hbTBtLoaLh/oDJ+bF1qbOrwCOFSq0bucWDs+8ZUd
         ZRHRHKCvi6uJxUafcPWQLmvt0n+wyil3Va1ZcnLBXfiCnzfPZvqgAAf04kqpP8kbJQm9
         jCSuDDEXBd/1C9kgs7aeY6n8F34BL6JnqryHJM4mzL1UNnGZ3DOEH78pdhxDb16SH7eO
         S+lw==
X-Gm-Message-State: APjAAAXSjYmLd04r3PvxCjlPP44pb/2Ye/3L7k3p6+KOt5Min2lgrkhl
        t4q2+a2JsM4+JQwOl/VRCmw=
X-Google-Smtp-Source: APXvYqxBXwCDlcnH2Sq70fnoWbE1++IW5U2XzenIZYo8cRzNgUv/sPzrBdcTC2riWlQM/pVqne21aQ==
X-Received: by 2002:a5d:494f:: with SMTP id r15mr31311049wrs.143.1579081157963;
        Wed, 15 Jan 2020 01:39:17 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id a1sm22403351wmj.40.2020.01.15.01.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 01:39:17 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:39:15 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 11/14] exfat: add Kconfig and Makefile
Message-ID: <20200115093915.cjef2jadiwe2eul4@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59@epcas1p1.samsung.com>
 <20200115082447.19520-12-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200115082447.19520-12-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday 15 January 2020 17:24:44 Namjae Jeon wrote:
> This adds the Kconfig and Makefile for exfat.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/Kconfig  | 21 +++++++++++++++++++++
>  fs/exfat/Makefile |  8 ++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 fs/exfat/Kconfig
>  create mode 100644 fs/exfat/Makefile
>=20
> diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
> new file mode 100644
> index 000000000000..9eeaa6d06adf
> --- /dev/null
> +++ b/fs/exfat/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +config EXFAT_FS
> +	tristate "exFAT filesystem support"
> +	select NLS
> +	help
> +	  This allows you to mount devices formatted with the exFAT file system.
> +	  exFAT is typically used on SD-Cards or USB sticks.
> +
> +	  To compile this as a module, choose M here: the module will be called
> +	  exfat.
> +
> +config EXFAT_DEFAULT_IOCHARSET
> +	string "Default iocharset for exFAT"
> +	default "utf8"
> +	depends on EXFAT_FS
> +	help
> +	  Set this to the default input/output character set you'd
> +	  like exFAT to use. It should probably match the character set
> +	  that most of your exFAT filesystems use, and can be overridden
> +	  with the "iocharset" mount option for exFAT filesystems.

Hello! This description is incorrect. iocharset option specify what
character set is expected by VFS layer and not character set used by
exFAT filesystem. exFAT filesystem always uses UTF-16 as this is the
only allowed by exFAT specification.

> diff --git a/fs/exfat/Makefile b/fs/exfat/Makefile
> new file mode 100644
> index 000000000000..ed51926a4971
> --- /dev/null
> +++ b/fs/exfat/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Makefile for the linux exFAT filesystem support.
> +#
> +obj-$(CONFIG_EXFAT_FS) +=3D exfat.o
> +
> +exfat-y	:=3D inode.o namei.o dir.o super.o fatent.o cache.o nls.o misc.o=
 \
> +	   file.o balloc.o

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
