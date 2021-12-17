Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C399D47832F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 03:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhLQCc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 21:32:28 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14757 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhLQCc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639708348; x=1671244348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4S/LmvgSDscy0s+mZTOsg9lW9biG/Qcbrm0MvRqccKk=;
  b=KrDMtEj8xTpLaO1rrDqieuPMZ5c4r1r4Q4PaxbRhE5s2UU/y7LALoSJX
   9wK4DuLnDFMt4KsH4vn1aWaYkyGEUpzbw0nmnP0oMSKlTikKpFtIEqoAC
   /+mC+tfFfmlofrjwWqEUwxrd3tBawxK46e+4S5O3zNmhE7obj4W4iDkVX
   Uw4Sl2UwtZpOTrU2A0shIWDSdQ/N7PNBzMB49jZjW3mlkQmUzhEOMSRVr
   veSA25j1yzPTDxRLQx9ADXtvJS/lPIaU3n5KXUA+DHb+uM/irpnEH3CFs
   XdiCznDJsXBNbjOvROOZhTEDIm+yTRoJvy6rG/dZXLUXNt9E3L0erpCH2
   w==;
X-IronPort-AV: E=Sophos;i="5.88,213,1635177600"; 
   d="scan'208";a="187446558"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2021 10:32:27 +0800
IronPort-SDR: IwxzlmgWT4iupU5kjfZhQ9qHa88WaDONMlTxb+8opu+G/AWZQGqjVG/rPFmpF7HFkyGtAO9zGy
 gc6bVGfn8106SYZS4u1H+Lfvlr8xcYY7W4jcNoT5OdCggoOto5KOZgBI5fbUsikWD1HW8tb9sy
 HIFLjCNXoqcoAAipTk4B1PwBvBLzfMM66TwyPLCwXJ0n85opUtxJvsEemPhXlf5pNg8flLwn1T
 r9GhxJVZw/K8tBcG2uXkFUtGgoaY+n8KqEV+py//5mAbulMz6UK0V4sXNII+QA251Z2aqnhu1Z
 Sv7EkyCtJwsMH5KTWxaFKIa8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 18:05:21 -0800
IronPort-SDR: Jk84Gd/CdNJ0Kr9iTrSix3P9ypFbEw/YyhjykJp35GgdTe6bNvHL8sUDQlaA7FrwmLve5olhBD
 WGyefpva+AE6nrUo9npNq7fBuoLHV5iujM+KBUG6rGbxRElsGDsutpJCceTRFCj4OkpFMvx95n
 RNsF8t7JJ28S1llN/RTFDTALO8y1ShGBj5JM/JSEXRKJbe/aPBB8QkYU8WsHSZ1nPnd8Q+pn86
 AUGZsIUzFY2cIEZWhbM0r69VBRYcffucxqwF0C9+/2aRihJ88bLqMa6A3x1mRqRUtERsVJINl1
 ecg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 18:32:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JFY0q4Glrz1RvTh
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Dec 2021 18:32:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1639708347; x=1642300348; bh=4S/LmvgSDscy0s+mZTOsg9lW9biG/Qcbrm0
        MvRqccKk=; b=enoAGxMwpoY7p+f1oOA4nUEA/gSJuEECtSw5P3+veUagdIvmjHx
        wet63pJdusM4xtm/XISIxL+lQ4U8bm8mM3+czqeS0zmIcngXcdFUIa//+1EkD9K4
        8qRDjajPa+STmQqatORHPvbwY1oCXHrSv+yDkhDP9eZ6CRLoxNCKVwE8fxLLoMWa
        0tmserVnccbejEb4aI7mHWOl3Vq2zxTHeHrBw4I4O++FANKKzYhk7I5UL+M1AfJK
        o8wf44RUi0ShQ5Q+k4fTP/FNHPUFex4ORz/kVO6wsUETY71g+hY3NnSdjgflDZK5
        0zTUWgk4V29QO+mVFqGRjRKuZeQ46x2blLw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E3hOMvkyUfp5 for <linux-fsdevel@vger.kernel.org>;
        Thu, 16 Dec 2021 18:32:27 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JFY0p5bz5z1RtVG;
        Thu, 16 Dec 2021 18:32:26 -0800 (PST)
Message-ID: <997919f5-7745-d15c-6c17-fddd2865e4d6@opensource.wdc.com>
Date:   Fri, 17 Dec 2021 11:32:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH] zonefs: add MODULE_ALIAS_FS
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20211217022403.2327027-1-naohiro.aota@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211217022403.2327027-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/12/17 11:24, Naohiro Aota wrote:
> Add MODULE_ALIAS_FS() to load the module automatically when you do "mount
> -t zonefs".
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

It is probably a good idea to add a fixes tag and CC stable, no ?

> ---
>  fs/zonefs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 259ee2bda492..b76dfb310ab6 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1787,5 +1787,6 @@ static void __exit zonefs_exit(void)
>  MODULE_AUTHOR("Damien Le Moal");
>  MODULE_DESCRIPTION("Zone file system for zoned block devices");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS_FS("zonefs");
>  module_init(zonefs_init);
>  module_exit(zonefs_exit);


-- 
Damien Le Moal
Western Digital Research
