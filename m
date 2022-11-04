Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964256195CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 13:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiKDMGL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 08:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKDMGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:06:09 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59642B1AB
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667563568; x=1699099568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tfIWJ94LbdFZJyLZYcnOb1sxbpfgR9gteaK4CUIxwe0=;
  b=BUDLOzqMzoHjbRX4ALIp7xeXRhLO8k0yo/DWYNxn7kSEt1+Q9qFKRY8z
   uDQDJfFHb8vlk37iGfiKNEQre3BMgRsiFIzoI8tXeAplsQlS1RDdjjanH
   zo5yXHkGHcLBcxB3tRmooBGHKv1LNLYe5qX9d1LqIFr9SFtZtGRPb+mEa
   9rwsQuceBipFINwJVQapRU5B/Cc7PlEuBcmeRKtiq4w7wmkbmkvcZXzRb
   ewYPhL3LyrkX3aXyeiIGGF0fmqjQIUB7mVBvDmp+KAIMNu18daHvZW5pI
   XCuS3gcrXrCuzF2ujPEcMx159R6YOqYxbulhfsiGQ1Rd9QX4zMaf8Xt04
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,137,1665417600"; 
   d="scan'208";a="319831476"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 20:06:06 +0800
IronPort-SDR: N3g9ahmewD7WZBi34WccjB/DNqR7Y+xlSZgay11xZ1LhyYl2X36zBGaGxdRavGHVB4dSF5RjnG
 3YdCBcAEd4m5IPxbpUpA0kvn6JoT5KfyvDY8jrXpuDNPsLhed3JDzef6UAKVFKVDOWqrgP4O9m
 mjKPDtt0kWTrhaiIW/l01mwLzbojXgUDLaN7VhN8/8w5a9SpD2cfEwvE0MgJYP0zliMYaW1ruD
 oSCXxq5kpBv8dTb5JTKhT0slDA44OZylT3XpOHvfKV4QYehpMpqnDN8phECdbWer7M1du78QN9
 KVI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2022 04:25:17 -0700
IronPort-SDR: pks8Gd8gEwrbmoKx+31vzY5p2eQJIavHtdssxHXzp/2N89aTJXIlrY5DYGJQyNSM0ZPkAsf08c
 3gIpnfgTWIdHioi0G+mVKsXaopXeFKMCba2Kr5NbA91gFrJGGND0PbJpx22jAZ8rbheImKUMXp
 T+YSTwB8M1nsEx+cgxqomplb0NfHrHzkR7irqFKj2K9wq5WDUacJJetg9gF4dSX79EpgLVd+BW
 mj2YHlcsdb1Eam29zi6W+a/bTWTJNtsKCoh9erOfzuXBB9hu1+Kv59eCdzEsbso5HsVCb4W/Kq
 QR8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2022 05:06:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N3fV65JdXz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 05:06:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667563564; x=1670155565; bh=tfIWJ94LbdFZJyLZYcnOb1sxbpfgR9gteaK
        4CUIxwe0=; b=aCSb0ZgIo+RO7IajVjGhtudw3nfxopl+qNYzg0QhdMt4+hSGX58
        e3feYJ8mZn8xlOKVvwhCpsIyiX0aQmV6YE9bYDwdpToHp9v275vWVWt+rqp7a4+c
        LrP9+4kdDqzgochVXuVuM8/QRIZHadRK+ug5a4OGOUxrpsvu54K0XlZTvX+lMQRu
        2ElZrlrq66LHbB/YVV1+/KFwqmyXqsNLYmSCVULcrd+607nxlU46hNbOYKYyxTmK
        tkDYXrEqBLRAON7fyFlmQIvB5Zb2RYIgQF6nhJpT++qna8LutBOWFbH+TdNMtrsQ
        CrubXwrzredcg0Ax6ZIlvqWpCO3ssmD2tIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SqDCPNteU9WP for <linux-fsdevel@vger.kernel.org>;
        Fri,  4 Nov 2022 05:06:04 -0700 (PDT)
Received: from [10.225.163.24] (unknown [10.225.163.24])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N3fV41qW1z1RvLy;
        Fri,  4 Nov 2022 05:06:04 -0700 (PDT)
Message-ID: <f5513658-6cfe-fe24-d072-ea957d319254@opensource.wdc.com>
Date:   Fri, 4 Nov 2022 21:06:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] zonefs: add sanity check for aggregated conventional
 zones
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <f7e4afaca0eb337bf18231358b7e764d4cdf5c5a.1667471410.git.johannes.thumshirn@wdc.com>
 <085f1e1f-0810-1850-44d0-2704250799a3@opensource.wdc.com>
 <86c97181-fcd5-8e8d-9b20-b7fc2e74c8fe@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <86c97181-fcd5-8e8d-9b20-b7fc2e74c8fe@wdc.com>
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

On 11/4/22 18:47, Johannes Thumshirn wrote:
> On 04.11.22 01:26, Damien Le Moal wrote:
>> On 11/3/22 19:32, Johannes Thumshirn wrote:
>>> When initializing a file inode, check if the zone's size if bigger than
>>> the number of device zone sectors. This can only be the case if we mount
>>> the filesystem with the -oaggr_cnv mount option.
>>>
>>> Emit an error in case this case happens and fail the mount.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>  fs/zonefs/super.c | 27 +++++++++++++++++++++------
>>>  1 file changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>>> index 860f0b1032c6..605364638720 100644
>>> --- a/fs/zonefs/super.c
>>> +++ b/fs/zonefs/super.c
>>> @@ -1407,6 +1407,14 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
>>>  	zi->i_ztype = type;
>>>  	zi->i_zsector = zone->start;
>>>  	zi->i_zone_size = zone->len << SECTOR_SHIFT;
>>> +	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT &&
>>> +	    !sbi->s_features & ZONEFS_F_AGGRCNV) {
>>> +		zonefs_err(sb,
>>> +			   "zone size %llu doesn't match device's zone sectors %llu\n",
>>> +			   zi->i_zone_size,
>>> +			   bdev_zone_sectors(sb->s_bdev) << SECTOR_SHIFT);
>>> +		return -EINVAL;
>>> +	}
>>>  
>>>  	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
>>>  			       zone->capacity << SECTOR_SHIFT);
>>> @@ -1485,7 +1493,7 @@ static struct dentry *zonefs_create_inode(struct dentry *parent,
>>>  dput:
>>>  	dput(dentry);
>>>  
>>> -	return NULL;
>>> +	return ERR_PTR(ret);
>>>  }
>>>  
>>>  struct zonefs_zone_data {
>>> @@ -1505,7 +1513,7 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>>>  	struct blk_zone *zone, *next, *end;
>>>  	const char *zgroup_name;
>>>  	char *file_name;
>>> -	struct dentry *dir;
>>> +	struct dentry *dir, *ret2;
>>>  	unsigned int n = 0;
>>>  	int ret;
>>>  
>>> @@ -1523,8 +1531,11 @@ static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
>>>  		zgroup_name = "seq";
>>>  
>>>  	dir = zonefs_create_inode(sb->s_root, zgroup_name, NULL, type);
>>> -	if (!dir) {
>>> -		ret = -ENOMEM;
>>> +	if (IS_ERR_OR_NULL(dir)) {
>>> +		if (!dir)
>>> +			ret = -ENOMEM;
>>
>> It would be cleaner to return ERR_PTR(-ENOMEM) instead of NULL in
>> zonefs_create_inode(). This way, this can simply be:
>> 		if (IS_ERR(dir)) {
>> 			ret = PTR_ERR(dir);
>> 			goto free;
>> 		}
>>
>> And the hunk below would be similar too.
>>
> 
> Agreed, I'll update the patch. Or do you want to do it when squashing it
> into your "zonefs: fix zone report size in __zonefs_io_error()" patch?

If you can do the squashing, that would be nice too :)

-- 
Damien Le Moal
Western Digital Research

