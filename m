Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D8569563
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 00:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiGFWiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiGFWiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:38:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0472B1BC
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657147082; x=1688683082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6qnLDe/yg7WUXPj4IO0fRwUVQrjauWYs9yVOFR0aA/I=;
  b=MmklzOh6EsPVf+a59NYG7thwCn7JQa8o6u6lLUl01QIV2uFmqF+bryeo
   r4J9RQhLxX+3omB+fKWxtaDPh2GkSPT3U+0LA6G/dT1hCIgk+cFSeGjuF
   zHHLCoNt+HgD/EhDechld6LyYneZH7xWR13Al7rgPy9ZLNySu17N2qSDs
   k72VBZcmFkmHgaCmyUqd91A16kBh0J7IvgX7KgFga60LQWIcHt8GNqrjq
   Cr6DRDpWObAbKBOeu0LOFuoySTRnvaUuH0oQsAP/vprELO+5y3G+zgP7O
   1GJ8c6vrQ8ZIC5Zg/eYAwX81B3dMGdTveXTRs3D7Qe+Nc3J0jXtEaOoV+
   g==;
X-IronPort-AV: E=Sophos;i="5.92,251,1650902400"; 
   d="scan'208";a="209925915"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2022 06:38:01 +0800
IronPort-SDR: dmy/gw8jK+/BUSGhUO4CISbmwbQ4hfDQ1rMSzwvj47JUV+M7hOa8daxoIsqLsnSK0xUWbd876Y
 GjFTUNeEBrAncr2UocFaeSnGZjP5Y0+TRpGKyzYciXiRXC5A7DsfPm1C9dtfeByRKgXS8am1n8
 VC5zfE/bcdrkCQQjnQEe0FokxwOMzE1ikKoyhQ+Gmjvi/XWOKGeg0pNSvZ1yyOG80ySZGqQKx+
 Jcsy0vuHMxgg2bpf3F95Gl16OB3Bb6RLMH7NkzR9e5rPtjdRYOuGdErsDjup7bGl3w7UbhLZvx
 ix2rPSJEiZlgt5p7bQ5IU4P4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 14:59:47 -0700
IronPort-SDR: 3tpw/GKzKZDeHtZVb1bqPD3qUKrWqN9av4Mg3SXaibAStQRjz0tBXtBl8/eXqnCfrNyS3QIN3F
 g49fp6AMbTHGB34gKrdqZ6hKBi9RjM8ROGJUd5UdjmksRYfYv8wCFwCzG/zQuDJrNq4kyxk09n
 mgdChGuyE+8CqOPjR3ZzDoDsIf9vm89ZFbxI4IELnhww26FUZwXls8V82xO7FbXRHEHSMaeuZp
 Wknaaaezvf2BqoZIEMwRsA7hD3RAbbl7t/jrXrva5kelf/FFPWJwrXf9ZqJjeZi1dOxGecmoSY
 CNo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 15:38:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LdZF54Xt3z1Rwnm
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jul 2022 15:38:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657147076; x=1659739077; bh=6qnLDe/yg7WUXPj4IO0fRwUVQrjauWYs9yV
        OFR0aA/I=; b=h9HBHIsp+uufAe60GPD0mLTMw0xwsXiH3GXdODQQcpHzf/18rCt
        v5dst8X1xkW5dir+LG8yLMOLK0K6iZNqN5BJZNyV5cNtSnY2ifPvLBLtjYvGSPzR
        Eo5FFBMUobHwO3rhFbjOeYA3N1IqkJZaUEkwFY7gVsn+IVy8DjVpt1rRpuWJ4g62
        t0k0hIa5a+1z3CvoaJv4IUNCZ15vB06QKD4eUmxWzoDF74l0V7n9TiP7d7grPqXA
        VgUeL4fHpX3sU0IdkYovJ/SqJBbHkWruoLtyRf/r5pIl4YqUABb8JcmkNx9TG6xp
        pxrMMhyUmxrggGlBENoNE9sialZE4U2UTmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mlw3EOo1ohBY for <linux-fsdevel@vger.kernel.org>;
        Wed,  6 Jul 2022 15:37:56 -0700 (PDT)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LdZDz1csyz1RtVk;
        Wed,  6 Jul 2022 15:37:55 -0700 (PDT)
Message-ID: <061ce84e-794d-e235-657a-238dd2308cf5@opensource.wdc.com>
Date:   Thu, 7 Jul 2022 07:37:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] zonefs: Call page_address() on page acquired with
 GFP_KERNEL flag
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
References: <20220705142202.24603-1-fmdefrancesco@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220705142202.24603-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/5/22 23:22, Fabio M. De Francesco wrote:
> zonefs_read_super() acquires a page with alloc_page(GFP_KERNEL). That
> page cannot come from ZONE_HIGHMEM, thus there's no need to map it with
> kmap().
> 
> Therefore, use a plain page_address() on that page.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Applied to for-5.20. Thanks !

> ---
>  fs/zonefs/super.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 053299758deb..bd4e4be97a68 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1687,11 +1687,11 @@ static int zonefs_read_super(struct super_block *sb)
>  	if (ret)
>  		goto free_page;
>  
> -	super = kmap(page);
> +	super = page_address(page);
>  
>  	ret = -EINVAL;
>  	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> -		goto unmap;
> +		goto free_page;
>  
>  	stored_crc = le32_to_cpu(super->s_crc);
>  	super->s_crc = 0;
> @@ -1699,14 +1699,14 @@ static int zonefs_read_super(struct super_block *sb)
>  	if (crc != stored_crc) {
>  		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
>  			   crc, stored_crc);
> -		goto unmap;
> +		goto free_page;
>  	}
>  
>  	sbi->s_features = le64_to_cpu(super->s_features);
>  	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
>  		zonefs_err(sb, "Unknown features set 0x%llx\n",
>  			   sbi->s_features);
> -		goto unmap;
> +		goto free_page;
>  	}
>  
>  	if (sbi->s_features & ZONEFS_F_UID) {
> @@ -1714,7 +1714,7 @@ static int zonefs_read_super(struct super_block *sb)
>  				       le32_to_cpu(super->s_uid));
>  		if (!uid_valid(sbi->s_uid)) {
>  			zonefs_err(sb, "Invalid UID feature\n");
> -			goto unmap;
> +			goto free_page;
>  		}
>  	}
>  
> @@ -1723,7 +1723,7 @@ static int zonefs_read_super(struct super_block *sb)
>  				       le32_to_cpu(super->s_gid));
>  		if (!gid_valid(sbi->s_gid)) {
>  			zonefs_err(sb, "Invalid GID feature\n");
> -			goto unmap;
> +			goto free_page;
>  		}
>  	}
>  
> @@ -1732,14 +1732,12 @@ static int zonefs_read_super(struct super_block *sb)
>  
>  	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
>  		zonefs_err(sb, "Reserved area is being used\n");
> -		goto unmap;
> +		goto free_page;
>  	}
>  
>  	import_uuid(&sbi->s_uuid, super->s_uuid);
>  	ret = 0;
>  
> -unmap:
> -	kunmap(page);
>  free_page:
>  	__free_page(page);
>  


-- 
Damien Le Moal
Western Digital Research
