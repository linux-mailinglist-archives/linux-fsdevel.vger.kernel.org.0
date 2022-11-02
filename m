Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1610616027
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 10:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKBJoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 05:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBJoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:44:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD81F9EC
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667382261; x=1698918261;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yATie/WaZ8y6YAbklNVTh/Cj/7gOlesOuum56M+zH34=;
  b=OIJmFgKlBt1hEuJUvs+Et0Cuunf3/BHaW14FtuICqwCK9HcyFWnJyGc8
   b44VEusv1vioSqTj2MckaEKkTY2Gmmq++PXT4jYOq7rYo+dYw0Wp4Gmj9
   33srCkXS1Usdy1TX7KsrdR0wa684doQmhcwZqguv4+KMn983YvXmmgRft
   NT23DV+WpauqfyBt0bHxL4Txb7DbtRG85F7kfY924nKapkYE0Q8/mmjC0
   cB/A/fpXai3wKWbAPSvJCJrMIFzplAEOdSETaHDbEHKChaIINqF/h5fsE
   9A0jQN4nFVPJpI6dfF0Yosi1paYacdD8c4BR1bW2l0PwwqnS6v3n090QV
   w==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="327403942"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 17:44:20 +0800
IronPort-SDR: S5/82Ei9+2Znh20Xl0Sb7aZo7Dge8zZ9zFe/kvag8ik+vBxw0HiL7IQwlumVOYV3vIguFGH3PX
 bjm8nOBxTJ9idwfbKBK+BLqGS++qtPob0dCFJb+unGuihmlIYZwcwLMHuTATTus7did492fdTF
 lbcG6zIdfjwWxaiwsB7MgZiNFn5DHp8916iYWsUyBg8Ikxr2dsSK5Sm9yHbshvh59/5tvFxHT0
 Iwyg5/h27H/vElvsetjgMlGMGHBrDZRN5x8lmpTHgFHQhgec1Iu/EmCoSvude8n1tBqGNTubht
 yNTWAHN1W/ic1N8srXJ69kTq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 01:57:49 -0700
IronPort-SDR: U1DxZIH3swLmLjXl4QaR5pkbV8NHOXHy+UoqEGx021wdKo+cxsJiRie0U3k8nKHWevfBjXnvfZ
 ni/bhg4zZHHO2U3C+mzEVnsBAs7fseAoM0PFPhlufLUSY6hldulg8mGf4N4Hu0KmKFLe311VU1
 SpVaOayR2hcWzX3PlrYZyBXT7YYGBGqOA4maK4gbYabelQw4lti5PsaOgfa426K788FQvwPVUG
 QafQ5n0HTPCvi9xgKqPmVkZWCOMpwh6m9SRRyK2aAHZMpwzNCuG8/ITwDP/DsRl5kseQGSFKTi
 hAs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 02:44:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N2MRR55fdz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 02:44:19 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667382259; x=1669974260; bh=yATie/WaZ8y6YAbklNVTh/Cj/7gOlesOuum
        56M+zH34=; b=BlQGNq/TTm7qxttoGG7rEKGAZJiGZKqc+Che3qBrkzIeTYZPrSo
        FLmxHGI+BJ/gswsD/5eu4iIR12yeSUCRrUtb63zGSdAkfMCRwSjw5vAatcLa4jZw
        gCfte9oOyoee5E/hax1N0tTrquxnZ1Tk6xqSXzAC7IIGC28HkzeDsxz6hxyHH+nc
        j9mCzeW/FmUrVHyTD332FC9nnDaVpX3u823r3t9zMBCwXJofiv2c4TblmZAquh57
        MSagsxaca5O8Site65k/jeAc3HA3uxG/MjfKkYZbx5QqvJwcMZEJONp7vkwQxu5G
        uT0UC/GS6df2So+gZbJKn0lV/xM4BwO3dJQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4jmRlY5rDswK for <linux-fsdevel@vger.kernel.org>;
        Wed,  2 Nov 2022 02:44:19 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N2MRQ6rZ9z1RvLy;
        Wed,  2 Nov 2022 02:44:18 -0700 (PDT)
Message-ID: <af8953db-cdb2-507c-1c54-88593fae4b74@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 18:44:17 +0900
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

Well, this is set when the inode is created on mount. So we could add the
check there, but I do not really see the point since we would be checking
exactly what we are doing. So the only chance warn ever showing would be
memory corruption, but then we'll likely have bigger problems anyway. No ?

> 	

-- 
Damien Le Moal
Western Digital Research

