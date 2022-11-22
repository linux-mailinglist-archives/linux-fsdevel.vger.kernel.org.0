Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAD16334B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 06:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKVFXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Nov 2022 00:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKVFXC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Nov 2022 00:23:02 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E27676
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 21:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669094571; x=1700630571;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/rjR4l15Rg+/v/9UokMjWWhyxASa0J3lXItJfGwHcgg=;
  b=jBHRh4++oZGzJjsBF/2CL6GgBiwMsztF3F/q2dyhg9+YaA8vi/hFz8bJ
   FAKLOM841SlQjoQIgO0OEIe7AXnHSs4jp1zVsKYxzrh5K5ZllICUNr+6s
   zxdFtjgtoccGyMIE7x7FW3KLGZogfOOzjf/DhkE676JXBQOxwlSc5kB75
   m7lv/sQLcMWrMP+bl32BCg1PEOSaLguLy1a5F3bEYWBiT47vLZqjdxf0P
   /2XJOSDiaHcdiRPAFD8TfODJqVQz0E2t8IM2qIFyVj88WrPedfC9Rhc1W
   DglOnMxIFdSzeFaPv5QBS1snzVrjkk5E37kL0V/mQqMU0FVgiwY0BXDR8
   A==;
X-IronPort-AV: E=Sophos;i="5.96,182,1665417600"; 
   d="scan'208";a="216857050"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2022 13:22:51 +0800
IronPort-SDR: 64cLi4XND59GzujPyIe9zYc9CCMDmHEweQkg8cR1qb2YcqEMesk7wZAdSQ0r1B0sduoLxM8TSY
 8BjsEjBKgeist2GvitEUU/OKzQgvZpiMWb3948/ty580JY9bpT6a60tpPUETIwkoGdGccXLJhQ
 8uOxAH2RMjODUmx9yQyEJm+yeYMYtNKkizUVcGCkAxt3uY6fOTNF/hEZ96PGAnP+Tf7NcvAfyR
 dTd4nmGiUIg++Z3Ol/MdTbvG7VDKPtsvQRAgmlUgoYEQ50zMOm1IufSOqWU8n1vXBoVp6svLnG
 ibY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 20:41:39 -0800
IronPort-SDR: Duq3ltpUb7FRtmkySuKTvPOnGh9SLPpifCFtzc+cKHEg5MMUeSAQDVRWdeF7IT7FM7I6UZIwvP
 oS5L4U8l/ORKha5SUd9ohU2EiIHwREIDjn4F2KY1tmRxPNhNUo0ZGMMzpBPtgH/74UCUupfQgm
 kyIQJNGrsYV10AVM4jRU7bZWp6h3ZFIHTn8SR45h4SICuONlMbCszyfdvIPUVkTjPVTIgRzZAt
 LOL+8L9KWOhk++44MZw5udpM58phYonD55fYghnpEb6pVBsuyPGuI4U0R1avM6V5XR6INmZRQu
 k2Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2022 21:22:50 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NGXhV51VCz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 21:22:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1669094570; x=1671686571; bh=/rjR4l15Rg+/v/9UokMjWWhyxASa0J3lXIt
        JfGwHcgg=; b=nFtJsMJEcgp2ieMQtueYQ0C8nXXSvvYq9sVy4Y6AdE7R/aEa/p2
        /qhRXI4/7P4/Dou/dXNz/3PLMePkuktdVNUStrLr45N0FTZH7fLau+2edlNs3hkd
        jbKZ10kECpinZezMyOX3BVEuGmniWvJRt12r6mtj90KY+jWYIB8nl9HSBCRRsXsv
        Ywcqi0uRbTA0aDTnIRwA0ATj48mWaGRghSS4548hFLhcbJaWP5TBGFn8dCFNbDCe
        aAWOFbeudRqoPFYI5cBVXpWb5Q9+FTq8yn5941m+10AU+PBQ6JwSqQv0yFAkB4Es
        7/nHwwv7o+O3XOCLPQVKWfjXhsHMutOW01A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PvYVy-sl1Bk8 for <linux-fsdevel@vger.kernel.org>;
        Mon, 21 Nov 2022 21:22:50 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NGXhT54VVz1RvLy;
        Mon, 21 Nov 2022 21:22:49 -0800 (PST)
Message-ID: <2a34be8d-1eab-48bc-9bb9-ed406aed5c04@opensource.wdc.com>
Date:   Tue, 22 Nov 2022 14:22:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] zonefs: Fix race between modprobe and mount
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>,
        linux-fsdevel@vger.kernel.org, naohiro.aota@wdc.com, jth@kernel.org
References: <20221120105759.2917556-1-zhangxiaoxu5@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221120105759.2917556-1-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/20/22 19:57, Zhang Xiaoxu wrote:
> There is a race between modprobe and mount as below:
> 
>  modprobe zonefs                | mount -t zonefs
> --------------------------------|-------------------------
>  zonefs_init                    |
>   register_filesystem       [1] |
>                                 | zonefs_fill_super    [2]
>   zonefs_sysfs_init         [3] |
> 
> 1. register zonefs suceess, then
> 2. user can mount the zonefs
> 3. if sysfs initialize failed, the module initialize failed.
> 
> Then the mount process maybe some error happened since the module
> initialize failed.
> 
> Let's register zonefs after all dependency resource ready. And
> reorder the dependency resource release in module exit.
> 
> Fixes: 9277a6d4fbd4 ("zonefs: Export open zone resource information through sysfs")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>

Applied to for-6.1-fixes. Thanks !

> ---
>  fs/zonefs/super.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 860f0b1032c6..625749fbedf4 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1905,18 +1905,18 @@ static int __init zonefs_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = register_filesystem(&zonefs_type);
> +	ret = zonefs_sysfs_init();
>  	if (ret)
>  		goto destroy_inodecache;
>  
> -	ret = zonefs_sysfs_init();
> +	ret = register_filesystem(&zonefs_type);
>  	if (ret)
> -		goto unregister_fs;
> +		goto sysfs_exit;
>  
>  	return 0;
>  
> -unregister_fs:
> -	unregister_filesystem(&zonefs_type);
> +sysfs_exit:
> +	zonefs_sysfs_exit();
>  destroy_inodecache:
>  	zonefs_destroy_inodecache();
>  
> @@ -1925,9 +1925,9 @@ static int __init zonefs_init(void)
>  
>  static void __exit zonefs_exit(void)
>  {
> +	unregister_filesystem(&zonefs_type);
>  	zonefs_sysfs_exit();
>  	zonefs_destroy_inodecache();
> -	unregister_filesystem(&zonefs_type);
>  }
>  
>  MODULE_AUTHOR("Damien Le Moal");

-- 
Damien Le Moal
Western Digital Research

