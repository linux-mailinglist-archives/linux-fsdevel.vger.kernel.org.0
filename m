Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3B2FA1F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 14:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404745AbhARNnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 08:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404737AbhARNm7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:42:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A18C061574;
        Mon, 18 Jan 2021 05:42:17 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v184so9592618wma.1;
        Mon, 18 Jan 2021 05:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=q5isUwhLkIrwtYU6nmgpmTKGhNdkuDOrfeEhUb5gcvA=;
        b=G2O5upPd2pC3Tnob5zTrjjGwRG4GBgaBrojfzoYZ84o2PQDqoUqZnlOLKEzek2K+zl
         WO7DmjhUFIJ2AW3wFC+SR+QnDz3AMbVXZjon50dfpx6igjzvkkKmLBE0Aad1FeAZiC9a
         h8vRvD5neo0+La701dKo3lZJHFIzi2YPb6LkgHslroE6SVy2PIx1w8Mbk2tHVmEU1Yyc
         c68jkA1mAljySRaILsZuijeQXanV/g4ZXVtLa8PFjo8mEUUHtVYzYhsilQxbtD+sVCOo
         IAfp4wKhNeAUBcC12uN6S2b62lG5QukWUVcwrUwZiaMToCoKFhrjB4SgzcP9dLdOIh56
         TsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q5isUwhLkIrwtYU6nmgpmTKGhNdkuDOrfeEhUb5gcvA=;
        b=OkpaWUFgvs0PYQMysmg2FEkQKD9A9MuNbwPr/BSNecJo2DNlaV8F5Lpw3pZKRO9Q+I
         1ygix9QYyX4cPvibowbjdSuMAuBm+2PdML6jsTTk+bRIvzIC6SYLOlxYTvP4zhfHqGrh
         1VTAj5xFeUzdhj9OONXVkYmaTj+e9kGJTIUCneFpbcCmOr0a8jOurcuUACHoftvoRiok
         VPJ7UIzcdLWpk/Betfr2ENzvw+mlEDSqh+ZNlG5GFyB0u1XxuW0m50NBqu5/kjgiQpNG
         LnEt5etdmDjtNYHohTGM4iUSY1f6mn6wHx3V4lkvfYHAYTrF/1KI9Fvn96z5n67bIXUt
         hDXg==
X-Gm-Message-State: AOAM533YhhYAHgN5EVqcFQLVArZQLW6cYM5LW7yik+obPKnSJI0xogzp
        4AqrX+kAs6QXqeElr0TdbcM=
X-Google-Smtp-Source: ABdhPJzoK1VolekfvjLQEc6HBtz4xTC11RI2s8YqOS6Ibyk5Uo5LWtl87LZhRtYJxzjv0LQ0vd++7A==
X-Received: by 2002:a1c:a1c1:: with SMTP id k184mr20790767wme.101.1610977335972;
        Mon, 18 Jan 2021 05:42:15 -0800 (PST)
Received: from ?IPv6:2a02:8010:64ea:0:fad1:11ff:fead:57db? ([2a02:8010:64ea:0:fad1:11ff:fead:57db])
        by smtp.googlemail.com with ESMTPSA id z6sm25197472wmi.15.2021.01.18.05.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 05:42:15 -0800 (PST)
Sender: Mark Harmstone <mark.harmstone@gmail.com>
Subject: Re: [PATCH v17 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kari Argillander <kari.argillander@gmail.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-9-almaz.alexandrovich@paragon-software.com>
 <20210103220739.2gkh6gy3iatv4fog@kari-VirtualBox>
 <baa71c9fa715473e87172c3afa3cc7d2@paragon-software.com>
From:   Mark Harmstone <mark@harmstone.com>
Message-ID: <548f5de7-9e24-c1bc-3ef5-641bc8a3dd37@harmstone.com>
Date:   Mon, 18 Jan 2021 13:42:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <baa71c9fa715473e87172c3afa3cc7d2@paragon-software.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/1/21 11:43 am, Konstantin Komarov wrote:
> From: Kari Argillander <kari.argillander@gmail.com>
> Sent: Monday, January 4, 2021 1:08 AM
>> To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>> Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; pali@kernel.org; dsterba@suse.cz;
>> aaptel@suse.com; willy@infradead.org; rdunlap@infradead.org; joe@perches.com; mark@harmstone.com; nborisov@suse.com;
>> linux-ntfs-dev@lists.sourceforge.net; anton@tuxera.com; dan.carpenter@oracle.com; hch@lst.de; ebiggers@kernel.org;
>> andy.lavr@gmail.com
>> Subject: Re: [PATCH v17 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
>>
>> On Thu, Dec 31, 2020 at 06:23:59PM +0300, Konstantin Komarov wrote:
>>> This adds Kconfig, Makefile and doc
>>>
>>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>>> ---
>>>  Documentation/filesystems/ntfs3.rst | 107 ++++++++++++++++++++++++++++
>>>  fs/ntfs3/Kconfig                    |  41 +++++++++++
>>>  fs/ntfs3/Makefile                   |  31 ++++++++
>> Also Documentation/filesystems/index.rst should contain ntfs3.
>>
>>>  3 files changed, 179 insertions(+)
>>>  create mode 100644 Documentation/filesystems/ntfs3.rst
>>>  create mode 100644 fs/ntfs3/Kconfig
>>>  create mode 100644 fs/ntfs3/Makefile
>>>
>>> diff --git a/fs/ntfs3/Kconfig b/fs/ntfs3/Kconfig
>>> new file mode 100644
>>> index 000000000000..f9b732f4a5a0
>>> --- /dev/null
>>> +++ b/fs/ntfs3/Kconfig
>>> @@ -0,0 +1,41 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only
>>> +config NTFS3_FS
>>> +	tristate "NTFS Read-Write file system support"
>>> +	select NLS
>>> +	help
>>> +	  Windows OS native file system (NTFS) support up to NTFS version 3.1.
>>> +
>>> +	  Y or M enables the NTFS3 driver with full features enabled (read,
>>> +	  write, journal replaying, sparse/compressed files support).
>>> +	  File system type to use on mount is "ntfs3". Module name (M option)
>>> +	  is also "ntfs3".
>>> +
>>> +	  Documentation: <file:Documentation/filesystems/ntfs3.rst>
>>> +
>>> +config NTFS3_64BIT_CLUSTER
>>> +	bool "64 bits per NTFS clusters"
>>> +	depends on NTFS3_FS && 64BIT
>>> +	help
>>> +	  Windows implementation of ntfs.sys uses 32 bits per clusters.
>>> +	  If activated 64 bits per clusters you will be able to use 4k cluster
>>> +	  for 16T+ volumes. Windows will not be able to mount such volumes.
>>> +
>>> +	  It is recommended to say N here.
>>> +
>>> +config NTFS3_LZX_XPRESS
>>> +	bool "activate support of external compressions lzx/xpress"
>>> +	depends on NTFS3_FS
>>> +	help
>>> +	  In Windows 10 one can use command "compact" to compress any files.
>>> +	  4 possible variants of compression are: xpress4k, xpress8k, xpress16 and lzx.
>>> +	  To read such "compacted" files say Y here.
>> It would be nice that we tell what is recommend. I think that this is recommend.
>> Of course if this use lot's of resource that is different story but I do not
>> think that is the case.
>>
>>> +
>>> +config NTFS3_POSIX_ACL
>>> +	bool "NTFS POSIX Access Control Lists"
>>> +	depends on NTFS3_FS
>>> +	select FS_POSIX_ACL
>>> +	help
>>> +	  POSIX Access Control Lists (ACLs) support additional access rights
>>> +	  for users and groups beyond the standard owner/group/world scheme,
>>> +	  and this option selects support for ACLs specifically for ntfs
>>> +	  filesystems.
>> Same here. Let's suggest what user should do. Is this recommend if we wan't
>> to use volume also in Windows?
> Hi! All done, thanks for pointing these out.

Is the existence of NTFS3_64BIT_CLUSTER wise? I mean, what on earth is the
point of an NTFS volume that Windows refuses to read?

If NTFS was properly documented by Microsoft, fair enough, but AFAIK it's
defined by what ntfs.sys does. I don't think we should be extending the
specification like this.

