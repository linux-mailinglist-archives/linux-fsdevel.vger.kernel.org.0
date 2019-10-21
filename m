Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A14DEA81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfJULLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 07:11:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39760 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJULLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:11:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so2754029wme.4;
        Mon, 21 Oct 2019 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MrGT/ACSXBerqMBFt/M8LBAiQe+lN7qu02ft+PsvJxY=;
        b=lyFZeW6r4TsnzNcbEe/m/NFXG6lKFUwNTCSl7xgX3quKIW/6P4Cd8V0H4X3vriuOtw
         wmTpBAtInwGfs5rZMpY15JmfJCU1J0QFGPM2LMvBJ4d0WGIuJ21laUbdy4/oanKPsyYF
         m2d9mmh11nurPv0GDCjemTZrYEnJhejFxBjUrAVudaF9GKLrFRvcq2Fzw19qFxbxelZl
         lBLqfjDuRam9LPw7HwQJJm/PLfhIHCRL5zs0E2XAvVQZ/OfT5RRl93qBggui8JMNWQuX
         J+eRwyRtrDYmtPIyISfXKSYW5IqLQjF+M8awuVe8tu6DUbnb50bWud4ZqeTg/0MLsSZ9
         Wy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MrGT/ACSXBerqMBFt/M8LBAiQe+lN7qu02ft+PsvJxY=;
        b=JA7DpIGHOrKdJjpfFdOJAhIAAivl1DO96WEpm/ZUVVxic8Tihv1iAzz767NOj4wNR/
         ciAPeImZpwIyNWPrHZEKnOtVyUHroaUbFg77TvUBPdrcSSgKIj1oQZpiRleYqm9SEj/5
         MxFFLVKDbPRQhL4ck8H3KfmxUz/UV/+AweCOXI5fGDSQUZAwGvJtUdnkAEmHQ2KmIVQ4
         o6UTrlIC+YlANJGLVztsVfH40idBIebP7RG1YDCkTqKOC0awncR2uDq8BmAJnIYkj0C1
         Y2xDHenRsVs4ssIR/4z/6aixoFcAxLoi9AUHYbPbuh51L6Gcho8FPcGQL3DThsmOlXPb
         uzlw==
X-Gm-Message-State: APjAAAVZgm5eBhZXnjSV1oy67okfAhOgQfzqHQ0cJeIcz4KgBMXYHkBi
        mJkDprhhhobefXmC+QXlG+1RmEGH
X-Google-Smtp-Source: APXvYqzIe08wuPcOlwxSpjMFPHKI1mURWTpYejvuwBQjGEW/mo6OWZV4iGI6OLB5sC6dInut3AxOow==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr20137973wmi.175.1571656298187;
        Mon, 21 Oct 2019 04:11:38 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k8sm28731822wrg.15.2019.10.21.04.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:11:37 -0700 (PDT)
Date:   Mon, 21 Oct 2019 13:11:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: exFAT read-only driver GPL implementation by Paragon
 Software.
Message-ID: <20191021111136.adpxjxmmz4p2vud2@pali>
References: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <453A1153-9493-4A04-BF66-CE6A572DEBDB@paragon-software.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 18 October 2019 15:18:39 Konstantin Komarov wrote:
> Recently exFAT filesystem specification has been made public by Microsoft (https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification).
> Having decades of expertise in commercial file systems development, we at Paragon Software GmbH are very excited by Microsoft's decision and now want to make our contribution to the Open Source Community by providing our implementation of exFAT Read-Only (yet!) fs implementation for the Linux Kernel.
> We are about to prepare the Read-Write support patch as well.

Hi Konstantin! Do you have any plan when you provide also R/W support?

> 'fs/exfat' is implemented accordingly to standard Linux fs development approach with no use/addition of any custom API's.
> To divide our contribution from 'drivers/staging' submit of Aug'2019, our Kconfig key is "EXFAT_RO_FS"
>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
> MAINTAINERS         |    6 +
> fs/Kconfig          |    3 +-
> fs/exfat/Kconfig    |   31 ++
> fs/exfat/Makefile   |    9 +
> fs/exfat/bitmap.c   |  117 +++++
> fs/exfat/cache.c    |  483 ++++++++++++++++++
> fs/exfat/debug.h    |   69 +++
> fs/exfat/dir.c      |  610 +++++++++++++++++++++++
> fs/exfat/exfat.h    |  248 ++++++++++
> fs/exfat/exfat_fs.h |  388 +++++++++++++++
> fs/exfat/fatent.c   |   79 +++
> fs/exfat/file.c     |   93 ++++
> fs/exfat/inode.c    |  317 ++++++++++++
> fs/exfat/namei.c    |  154 ++++++
> fs/exfat/super.c    | 1145 +++++++++++++++++++++++++++++++++++++++++++
> fs/exfat/upcase.c   |  344 +++++++++++++
> 16 files changed, 4095 insertions(+), 1 deletion(-)
> create mode 100644 fs/exfat/Kconfig
> create mode 100644 fs/exfat/Makefile
> create mode 100644 fs/exfat/bitmap.c
> create mode 100644 fs/exfat/cache.c
> create mode 100644 fs/exfat/debug.h
> create mode 100644 fs/exfat/dir.c
> create mode 100644 fs/exfat/exfat.h
> create mode 100644 fs/exfat/exfat_fs.h
> create mode 100644 fs/exfat/fatent.c
> create mode 100644 fs/exfat/file.c
> create mode 100644 fs/exfat/inode.c
> create mode 100644 fs/exfat/namei.c
> create mode 100644 fs/exfat/super.c
> create mode 100644 fs/exfat/upcase.c

Also have you considered to to re-use fs/fat sources instead? It is
possible or there is nothing in fs/fat which could be reused or
refactored/extracted?

> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> new file mode 100644
> index 000000000000..0705dab3c3fc
> --- /dev/null
> +++ b/fs/exfat/super.c
...
> +/* inits internal info from on-disk boot sector*/
> +static int exfat_init_from_boot(struct super_block *sb, struct exfat_boot *boot,
> +				u64 bytes_per_volume, u32 *root_lcn)
> +{
...
> +	if (boot->fats != 1) {
> +		hint = "This version of exfat driver does not support TexFat";
> +		goto out;
> +	}

Are you going to add support also for TexFAT? Or at least for more two
FAT tables (like is used in FAT32)?

-- 
Pali Rohár
pali.rohar@gmail.com
