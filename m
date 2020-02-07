Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF96155521
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGJyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:54:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10660 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgBGJyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581069271; x=1612605271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lWQzrjZ7b6yc+fgYZaPhmnb6hc29GmMcDgSMWcCDW/c=;
  b=f9YfnWPze2mWgmZdNzwfENyWdhCgsRie5xqXiNGvfSH6hIEclsdk0be/
   RuDMF79xtUWAgLUIoKppLlsg8lqG7sE8u5pef9jtkzWcocGkVnbzxTThu
   LCy6glkmlMyros+DSUiJGWVx0hh3jTHrgiY8TOGBMgKxJjaJ0dDTH3dXT
   1zM5C3frPemiBGDMpda4UqdCUkotVsuzohAvDDUsGBFteEgohsdB9J29C
   LP0jLo2r+BpS4YA4IkLAA1v2hwDRFqeO5LDEwDeCv9pQTm1ndw+soi+cX
   KVHCKu+y+jY0BRpzL3SBNTaMXWumWEsKP4rn2MzKYb+KtEjx1wCLzeeCH
   A==;
IronPort-SDR: B+DpAhLBtSauEgHoC4Xb+X7V4X0Icam6rxEhGWLyoJC61d1MokXO9aCtU0GTdIS7kb9Y+TpQGb
 K4Ozclm2ScLR+TX+3avnqKg/IOzDI6Beg3wdA64edzjsozalulDprE6t1VLLPc6E9bRXIYOetY
 uVmgEc++UZRinYpQcvZeQfNXX7HJnJMJBTEgUVtGups8w6yVlWlKPgTvWTbtQzf8U9Kie8DI+m
 05AeUlIYggVtvTRg94oLbl5OxOdmxDsKqw3Q0ZoBDJngPeQegBsNARAX4Yo+aiDiafl1cMEajA
 MTY=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="129341549"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 17:54:31 +0800
IronPort-SDR: RVvR/PyTiKMdme5iKPP8FC8bXcevdMZO9z/2Hb2Mfs8keas7GM1HLDTeNzOTRAtvhJocM1u4ch
 Kpqzgwad4mfgSP0JBcZkIoQgGX+1SbOUR+Ey/JdGwpON4FvY4zpsSAjFp22exVOdwxygsb6qy3
 dBYVh7VYEkDGwv0S3qfDhzxPKRxYM9Mc/idjaL8YcYF/6O4QqM5gHnwR1FCaLuQLFUQYGq7OwW
 tsqL7RAkypqCWI2cpQWaaI0ZRi3Q+CsOfLNRTclQHmcRjQ0MlDxmEQ/i08/edK8hDnRMw2o12K
 Rme/uK2e7ylBUc8B2zSV/9e3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 01:47:29 -0800
IronPort-SDR: r14d2We9/ds7rsdtJF3HQBxbAchTWkpUoKpx0M5wJXXxGlu2l/LbcILP0f6jCo6aFwyPsJ3Ow6
 YjBEp4NMCQjUaORdU9FIk09AkfoHod248MYc/NSrHUJzmvHpuuuoVR/XdLWlNqVLc4iTOFjXuS
 Olwshwh/vZaK2PQED9XBVdsZ4GIvx6aJ0wU64mQb2qwU/N+rScx+NnJmB0OmpP/gMW6Fx47cYs
 /7HPaJKRdPZ3GRTXhbQlKTx6oRmdtxFoWsKDsxTCq8f8c2QQPEBexbA97G1Ucw5jwLA9y4JgJB
 lqo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 07 Feb 2020 01:54:30 -0800
Received: (nullmailer pid 969185 invoked by uid 1000);
        Fri, 07 Feb 2020 09:54:29 -0000
Date:   Fri, 7 Feb 2020 18:54:29 +0900
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 06/20] btrfs: factor out gather_device_info()
Message-ID: <20200207095429.dlo2rei4waa2qtbc@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-7-naohiro.aota@wdc.com>
 <SN4PR0401MB3598D4A69FB9C890F8C25D999B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598D4A69FB9C890F8C25D999B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 03:43:10PM +0000, Johannes Thumshirn wrote:
>On 06/02/2020 11:44, Naohiro Aota wrote:
>> +	BUG_ON(!alloc_profile_is_valid(type, 0));
>
>I know this was present in the old code as well, but can we turn this
>into an ASSERT() + error return?
>

OK, I'll add this as a separated patch.

Thanks,
Naohiro
