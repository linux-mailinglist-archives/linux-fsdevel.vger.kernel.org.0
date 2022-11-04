Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479AB618D31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 01:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKDAaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 20:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiKDAaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:30:21 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7651A1EC7F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667521820; x=1699057820;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pFflb22EIdbYzRmqHDykregHxj0CTIDKEWDMpPiEmWI=;
  b=kccLNsycEIw4VaKtUcWxAaOF6y1XKLR1ia+rwHmjtOnnk07H9T3fu+h9
   5SL74m0hcNh0odNmsFLYG6UVMzOVDNb2tvQohBX2eynphg5QFDh0+++Z6
   6OuvYOcGIwfqriyc/Us8k15WLx02xOZde/aG1FKdq0i+6LQIr2VxX5N++
   oryzry6SC3g6Wwfy3hkebM9+asAx697tkIrDYr6nLSt+wnuwv38/izp5m
   AAEoP0JpIuTc9467f4LPL7F5skBHjVFTH8H7MdgpP6YR/BlKqqF4DyTDy
   nMgaORRbPvP5ko7pI4Nagy8rkbO33Eu59I84Nf8mbd8E7feC6XHAHFS7h
   g==;
X-IronPort-AV: E=Sophos;i="5.96,135,1665417600"; 
   d="scan'208";a="220604844"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 08:30:19 +0800
IronPort-SDR: Eufr28owg1p3MCaF8/r7ek2xyBKw+8BA/ne8ouiwmtouAI7egIC1msGXKggoPIfDOSzdfmOU28
 mg+ZQOht6vqhsYdzDThVnoGkeWYGKGQFLLXiqxVDjvN4Moz7EgR0buRafgB6+AjpIz9vo8gZTJ
 K4vs4ZZ3of7b467x+ajKCh7YgKk5eJuS9ak+rg2l4lEEhAH2RZZMSFjm7lS0hRroj/MfPC+2rZ
 ZE2tm6AJldw9RbBQqhb36L/pOJpb/bb5Whs92FhlcN8uu9WzTZCIoTwHB1zrHP613K9ctb5Jyz
 A60=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 16:49:30 -0700
IronPort-SDR: DD1mZojJu3iehmSKYvxglQhK7kCLvWsUxwh0md354GtuXWl3d1lNiVHXZ+GhpMoYQBGF4HlJqA
 Gp1mwgj5Cwtqn6CfElIXPO0jBvPa7WJT+MMh+rAt2iRThlHH+fWVNdG1id3HZL/8lJRu9yS1T4
 bQiK0BKLBm7AiAo2gmvvX53CCl90AMxNmX2yLlJ1A5lACZQR59Vpz8kT9tsAFZC0mh3uQGw0oC
 JCvz6ihzcRVv5hkYp1901zeeNZvKawd6VCv2UcySyrcwQDXRYOzPKb0nchcx1+y75G3kHqQEc6
 oZw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 17:30:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N3M3H34Myz1RvTr
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 17:30:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667521819; x=1670113820; bh=pFflb22EIdbYzRmqHDykregHxj0CTIDKEWD
        MpPiEmWI=; b=N7C8ZZSPCto4Z+DJhnthCxl9L3PaC08nDc2BbGlOIJVItlOzls5
        09vEEccevL1jXI8/tLlrTgiGmvhiUGi+yzOhz7I/XEf2MJ0GAk4OqocgqTFMGmuk
        KlQ7I6ZcyMGCHUGyKL5bM4Dh6NrXXkpXWA9Ss2SyYdCXwW0OZTuXOjujgZmQMRAh
        VlaWqixEoOFAjp1I/KvLHSZWu9tloDSdCFQ2B5yLbs9AOsUki3lDmW0bCqaOctVr
        92LW5ZybVAP2F2WI73h36VzkiBkuxhaPg2LwouUKg+bH2R6aBenTTOG6KEoKYVlF
        F2auEiAd6xmZoSNnpY22YOHWL7omSrotVlQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3kMF9-dB8pnp for <linux-fsdevel@vger.kernel.org>;
        Thu,  3 Nov 2022 17:30:19 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N3M3G5Bz4z1RvLy;
        Thu,  3 Nov 2022 17:30:18 -0700 (PDT)
Message-ID: <7e327427-c47a-29d4-e1af-9b127407d076@opensource.wdc.com>
Date:   Fri, 4 Nov 2022 09:30:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] zonefs: fix zone report size in __zonefs_io_error()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
 <20221031030007.468313-2-damien.lemoal@opensource.wdc.com>
 <959eb68a-3c74-3b57-dd81-8b46dfa341d9@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <959eb68a-3c74-3b57-dd81-8b46dfa341d9@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/22 18:28, Johannes Thumshirn wrote:
> On 31.10.22 04:00, Damien Le Moal wrote:
>> +	/*
>> +	 * The only files that have more than one zone are conventional zone
>> +	 * files with aggregated conventional zones, for which the inode zone
>> +	 * size is always larger than the device zone size.
>> +	 */
>> +	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
>> +		nr_zones = zi->i_zone_size >>
>> +			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
>> +
> 
> I wonder if we should also have a check/assertion like this somewhere: 
> WARN_ON_ONCE(zi->i_zone_size > bdev_zone_sectors(sb->sbdev) && 
> 	!sbi->s_features & ZONEFS_F_AGGRCNV)
> 	

I think It would be good to squash your patch checking zi->i_zone_size on
mount with this one. Can you send that or do you want me to do it ?

-- 
Damien Le Moal
Western Digital Research

