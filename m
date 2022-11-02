Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38D561613A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 11:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiKBKuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiKBKt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:49:58 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E072253E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667386197; x=1698922197;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=rpWo1MV13aI44StKIkN/97I6euyT2Co7AViwkCWm1Hk=;
  b=oUwj1OoEIMK2IUoepZlMeX7xb3NTyn0Vft7SK4jgkkpd86sOZcQZvYFL
   DfmSYEFcC8CQ7WqsHiO33YvaF/KYH33cRIqjld+zih+wZ1DXV2tyssKEb
   Lf+YfS2G8PMXYQpGlUGvZpGMVQMyWO/9F+Ec3rb3yGl0SLlqY4BTFiqLp
   NdFwaS1nOS8pHL8DQl3XM0m5pjKPJsGeH2jXpQCQctWxSZ3ywp9JOLLt9
   6bRO/RUvs93q10I0lofJE318NiXlR+DnoC2zVakxuRK55FtHxWoXY4qIV
   AF5KO+sK5tYhdpDzJstcn1gWrpVzX5VUTpyYEVQ+px7yDkDwTH7pSDaCx
   A==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="213593921"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 18:49:56 +0800
IronPort-SDR: Njj5TGFI/2n/4PnVUU+j7zaBJiYFDorQhUDfyyXcPfBMn3IHf9wp7rSUqhqKTz768EjRIwt4h5
 eBkDGZiAGY2gwLUU8Cxq6Bq4EC5wtN8uEZIFbxvAYS5W0JzLAI1RQNxJCCN6SKhLwrZf9rjO8B
 ay3jKqtrsclcsnkYLS4eAtRnHfWiz0/cNIhnXSXqDqHJmXouea9XB6SgJ1zxS6JLoFR8Cr66qM
 A7rSA6kjzl0IVM3f5Ls+fJXQvN3FRSjfB5e8waTfV9xSlqPIBAVq7MLuFBPjZjsEqbOo7Genzn
 2yUzsp4EhWeSearDbFU9V/p0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 03:09:10 -0700
IronPort-SDR: N6idbz7QN4zI7/Tu+TR9azk/Yc2vMvbB2HMLQnL6m4+JWjfB3M7kTE9Neh2qcGEVjY38BiaOl9
 1mcEiGdFQID3jnTjv4dWa2biZq5QI5wvR8M0UhSvdeRXLMw+A4kX7Mh3vRBc/C1oQJGAWrsfU2
 p7ChS5XJLcvqqbsaMxfw3zBlJ91BlEOzVtxVWMQF0hcV+5dIE1XEJJKp8Wx8gCJh+YV1TswUr8
 RaiggOTGjahbHt8Xzf+oZbRGacUHci+q+/1d1eDiIUISK4R1LbpjuQmxaiTW+HL4AFtsyu519t
 UGY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Nov 2022 03:49:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N2Nv76CQ3z1RvTr
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 03:49:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667386195; x=1669978196; bh=rpWo1MV13aI44StKIkN/97I6euyT2Co7AVi
        wkCWm1Hk=; b=MLEiaKsum8I34YQFKAeb00Xq6Ay7JHwbw3+gxvWSbjlNWZe8WbA
        VZpXeJ63nHG97RvuUaTh72RgRSi3JaCNSa98z/SrYuDTu77UzLc0cBiryC9hXPZk
        wfzp1/mUu7Qq0oOrTpeObG4tfCR3Y/T6hj4uOSgwyXtP+t0qgVE6k/6L1Z9J05/u
        tf1PU1OCqP+qgJ0q4Htq57ogDxq1DP8+1S7BR0ND6eKPHE8ze9ws04Q4+tSEHV9t
        Vu8SUHwHYPX6HYGJfocTGOFxeCfghcaTfnY9YbTFsEUreXfsF2lJY29tlmQEzKyK
        F9utHeeRpUC0nnx1KpfgywjjA8CVF9xD1ow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kozp1VLV2hHj for <linux-fsdevel@vger.kernel.org>;
        Wed,  2 Nov 2022 03:49:55 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N2Nv70bhGz1RvLy;
        Wed,  2 Nov 2022 03:49:54 -0700 (PDT)
Message-ID: <462d3c16-ae18-df60-fc4a-0aba8eac041c@opensource.wdc.com>
Date:   Wed, 2 Nov 2022 19:49:53 +0900
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
 <af8953db-cdb2-507c-1c54-88593fae4b74@opensource.wdc.com>
 <f3102776-29ee-bb44-c02c-534a25d19743@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <f3102776-29ee-bb44-c02c-534a25d19743@wdc.com>
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

On 11/2/22 19:11, Johannes Thumshirn wrote:
> On 02.11.22 10:44, Damien Le Moal wrote:
>> On 11/2/22 18:28, Johannes Thumshirn wrote:
>>> On 31.10.22 04:00, Damien Le Moal wrote:
>>>> +	/*
>>>> +	 * The only files that have more than one zone are conventional zone
>>>> +	 * files with aggregated conventional zones, for which the inode zone
>>>> +	 * size is always larger than the device zone size.
>>>> +	 */
>>>> +	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
>>>> +		nr_zones = zi->i_zone_size >>
>>>> +			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
>>>> +
>>>
>>> I wonder if we should also have a check/assertion like this somewhere: 
>>> WARN_ON_ONCE(zi->i_zone_size > bdev_zone_sectors(sb->sbdev) && 
>>> 	!sbi->s_features & ZONEFS_F_AGGRCNV)
>>
>> Well, this is set when the inode is created on mount. So we could add the
>> check there, but I do not really see the point since we would be checking
>> exactly what we are doing. So the only chance warn ever showing would be
>> memory corruption, but then we'll likely have bigger problems anyway. No ?
> 
> Something like this:
> 
> From f90acf1ca3f84d37a3bdb570abf89e186697c0d4 Mon Sep 17 00:00:00 2001
> Message-Id: <f90acf1ca3f84d37a3bdb570abf89e186697c0d4.1667383842.git.johannes.thumshirn@wdc.com>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Date: Wed, 2 Nov 2022 02:57:35 -0700
> Subject: [PATCH] zonefs: add sanity check for aggregated conventional zones
> 
> When initializing a file inode, check if the zone's size if bigger than
> the number of device zone sectors. This can only be the case if we mount
> the filesystem with the -oaggr_cnv mount option.
> 
> Emit a warning if this case happens and we do not have the mount option
> set. Also if the -oerror=read-only mount option is set, mark the
> filesystem as read-only.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/zonefs/super.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 860f0b1032c6..7c0b776a7bc4 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1407,6 +1407,15 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>         zi->i_ztype = type;
>         zi->i_zsector = zone->start;
>         zi->i_zone_size = zone->len << SECTOR_SHIFT;
> +       if (WARN_ON(zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) &&
> +                   !sbi->s_features & ZONEFS_F_AGGRCNV)) {
> +               if ((sbi->s_mount_opts & ZONEFS_MNTOPT_ERRORS_RO) &&
> +                   !sb_rdonly(sb)) {
> +                       zonefs_warn(sb, "remounting filesystem read-only\n");
> +                       sb->s_flags |= SB_RDONLY;

This is during mount. So let's fail the mount...

> +               }
> +               return -EINVAL;
> +       }
>  
>         zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
>                                zone->capacity << SECTOR_SHIFT);

-- 
Damien Le Moal
Western Digital Research

