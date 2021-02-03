Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E530D394
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 08:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhBCG6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 01:58:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60774 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhBCG6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:58:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1136nsTi051311;
        Wed, 3 Feb 2021 06:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=loQ33VDfWq5bAVwH9WNgpsGsqkNrotc2VHJjXdj6O9w=;
 b=KCGM1qJinCgl47Ptziks1RjQAQdwGk/FEQ2uk12EEMCFuGqz5ZGb/Zt/X06QSljmfjtM
 vTfCJrIrSheJEEuujurS5a0reD1U7EGsBUB24og12N5zBxO9Mz7eeTMhGsRwkdYhryYI
 0ipeQtzCkt0Br042bwQfLrLzo5YAD6nAMLfsdei1Y0hmPTUAKeUnmtAZPlzp1Jo2pd6E
 Sw09sahl2nWOMZaJMmaTFFJ4GvbJR6XC7nexQPVuPFpTltL1ZviozH9bDTVOVRNnd0uJ
 1UdTAFYXVc/UuiAEtPh3zZebUmu52opE+v9+kBZV4aWN2cQrvt1ISzJ99hOrnpd3sQYI mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydkxdte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 06:57:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1136uEvB165663;
        Wed, 3 Feb 2021 06:57:12 GMT
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2057.outbound.protection.outlook.com [104.47.44.57])
        by userp3020.oracle.com with ESMTP id 36dh7sua6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 06:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJeVTNQ7HoDG8MJNOlU0VBIpyYVtxRzcDfkuIfQLV5hL26JEsoEwQJQJwj+d3QBekCYS7WBEK06lQdO+Mdg9Ed4BB8UFXwPcMeu76Ih7Hq3ezaiBvtx3ftyzXYHfdY1afzQc4Jgne2TjbUGJKmpHC3jsyiZzXd0Jn0LFowjFWtiGQ8n10lPnrgtqbfpBjRXTTf1kvFbfLxAHb2ee4KW9zuPovJBdEUfJiKFLpToO6Xygyu4ARJ5XD/l8fKKW0Vr3KQKGDQb+4aH6neZl+L5hmsrkkQGS0s2cWnZp+1Jky3bwHLhfm02Bv2sXh/2sl7Ahb3sIDmSIba8W2Db8SwQv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loQ33VDfWq5bAVwH9WNgpsGsqkNrotc2VHJjXdj6O9w=;
 b=jTKln8yeGnK3C+5GJvDT/N4Q3lCWBpFhVKFF1972hPRjICy5b0xPmKaocaypQt2JUCpgYsJw0r5JsUNqHu9ffcnO9Oojp/vFaFbXokDb/WssUCm90Q1odgF+DvVi9qTVa7xjXWsj2dR8yqVHKe6Eym7jMfEGlJb10te3JaI6HeyS6pNwCCGIdFF5bwFd6VB2JCJM8RtXYqbZtjaje/g8y/xmBefMnY5IARVUH5pfMvROcS0/4IgIK4eHC636kBosblQjEUufjas14IBPTv9VO4sDUtCnePjQR2BdFKERNoorV6WOOhX1lpYPgJENJL6DwqzIIEQxKOJ5Qh5FvLtDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loQ33VDfWq5bAVwH9WNgpsGsqkNrotc2VHJjXdj6O9w=;
 b=ljff4gbTv7qaN6Y6YukWB7YAISp7UwPFs0CEbbConvgb6yooHQX1yIXbWV9xUS+Jztv2wrnSFj6WgslK7kfIdyLbXP9x6d+mvpIVcvALkZEcPX22bLAetIZKkDVutRSe347tWoltofj6IEIqY/Glq/XKuLqgsS4wzjQdX5vjHEU=
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3137.namprd10.prod.outlook.com (2603:10b6:408:c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Wed, 3 Feb
 2021 06:57:09 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 06:57:09 +0000
Subject: Re: [PATCH v14 12/42] btrfs: calculate allocation offset for
 conventional zones
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Cc:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <583b2d2e286c482f9bcd53c71043a1be1a1c3cec.1611627788.git.naohiro.aota@wdc.com>
 <c1ba8d31-09f7-bab5-72ec-414bf8d7fcc1@oracle.com>
 <BL0PR04MB6514F8BEC71EFA6E8DE76DE9E7B49@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a8f1aeb9-70c4-2d4f-50f3-d4902c3e4173@oracle.com>
Date:   Wed, 3 Feb 2021 14:56:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <BL0PR04MB6514F8BEC71EFA6E8DE76DE9E7B49@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:d99a:96b0:4ac1:95ad]
X-ClientProxiedBy: SG2PR06CA0127.apcprd06.prod.outlook.com
 (2603:1096:1:1d::29) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:d99a:96b0:4ac1:95ad] (2406:3003:2006:2288:d99a:96b0:4ac1:95ad) by SG2PR06CA0127.apcprd06.prod.outlook.com (2603:1096:1:1d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 06:57:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b795bdd6-1e34-49c6-96ac-08d8c810ec64
X-MS-TrafficTypeDiagnostic: BN8PR10MB3137:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB31377A2096089497D1F23634E5B49@BN8PR10MB3137.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSVNx57fp5/L3Hu6DYPRFZcjgU5IulSbj57HIpOmDnnsPTVy1avu2+0SE4fiG0j7+uhd2zzlprknvvsHUEdf9VHf6QvO7aL+XU5CTVRJ+hYe0LO5RmOlOGg29cJlNqGhJy2iHH717UsYLn1PkZucrTm5blOlCpM0plQdeNY7Ik6Z6AU0FrJ+H+NUgv1ahJYYZB2XrTpKh7GoEETQMtvXEoRYgif92PBKNE6JHHQlo1bJOPHt+LdEhkxMyvrXJkr38X81mCo6zw1dgcIiGYzmYba3nUjHfzof9gUbV/ajK4CBWAmrHpbcvKzLnYN5ky5B2+3E/c2o3+qmicDFWxj/s6gQDrRJfjcL4tEcUJJLE7/TIA2Sgt7ntSLWbRmBaIisZwewjV7byT38w66XpioMVGO/Fbr0dBiuWQh7B2ZxzDHopsHUZSTI+CymxxJmo2B8A/e6kKNqgaAeyqecRSOX20hOYkudzEHLPzir8nWqYy4djdU8FpQ3fhxUpjUoKf+SSlotWOPMA7BnNyNF80qPNF4365+3sQ9T7qvsiY7wGmns0FOPYHXbZYcbXWZrB3rRrpU7MM4IEqCZYkvpgTeX5/GoW3UKMW5vdlPJLp6cHjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(4326008)(86362001)(44832011)(186003)(36756003)(66556008)(8936002)(66946007)(16526019)(53546011)(2616005)(478600001)(66476007)(6666004)(5660300002)(83380400001)(31696002)(31686004)(110136005)(54906003)(316002)(6486002)(2906002)(107886003)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZG4zd2hVb2pMZlFnZmtSMWoxNHNPM1ZCeTBPb2JEaVZUVkRYbEFlQS9MOXZC?=
 =?utf-8?B?Mm5UeGdFTkw0RUlRMWJFd3dyaDlCK0ltS1dmbFJIL0pjb2R2UUNNeE9ORnNW?=
 =?utf-8?B?dzQrUW9tTyswMEtXMUxlcEdlSDBDTU1NaUtvanVvQStWZmMvcWxyc05aaVpR?=
 =?utf-8?B?b0c0cVh4WVJlbTUwVHdWbGdxRWxqQ0RTRHRsRGp4R2xHU2t1UXBqb05yMHBa?=
 =?utf-8?B?RUdzcTRDS240aTFTTnF3ODZZUzQ4SENvT3EyTWJGTDZqR2lOdlVXVmdnUWdJ?=
 =?utf-8?B?MEQyclE3eWdJRFV0K0ZWcWpQYTNDMkk2VE56V05qNVFMTGczOGZBUUxxKytI?=
 =?utf-8?B?MVJieGtqeUcyWGtUQ2xxSWh4SHpaUTF0aW5md0dsV1hVSWlPdUJ2dElrRzVT?=
 =?utf-8?B?UTJJOVc1dzNmRWNMYUJ5THRWWkEycXAxbXBwUCtERzJuNm5PZDBQeEpFUDdV?=
 =?utf-8?B?L1N4Z2E0U2J0QUdscHhUSzRlZmcweUxEMnhuVkdWUEZJUnZNSnA4NnZTTFpC?=
 =?utf-8?B?SXJIMnFiQzVCZzlTNlMrdHlqMCtXdWlJQzBwMm42RkJhMTdJY1UxeW8wZlVI?=
 =?utf-8?B?NnVwcWtCcjN2OFNMaVVMTW05cTNoL3A2a1U4RVg5V29nRm9WSXp6MVFyQ05O?=
 =?utf-8?B?cUZPNVM1cmxFaFpKdjlOZWQwaklBTjRJMU1BSHJLWVFMTFEwMllkUEhkMm9m?=
 =?utf-8?B?VkN0YXEzelVVOThsaEJPSmJ0V3lsL1BpWTAzZG0wcFNhM3JlRFpZcEFJOUFF?=
 =?utf-8?B?aThUM1ZIUmNaNXdvWDdoMUZVRG11Q0VCSGRDRTVSSDNZcHlCQUdoYy9JNGRj?=
 =?utf-8?B?MmhWYjU1aWF6N094cG1mc1Y0WVB6dWVVRzJPNnJFeitJMVdWbTNkeDhsR3d6?=
 =?utf-8?B?aW5ab3ExSWhJY1YwMW5YOVpLNnhSb0VKNFJGdkJDbi9tZmxyZGtJU3A2TnMr?=
 =?utf-8?B?clQ2eG8wTzVLZlZHMjdSME82RmQxVWNWWUxxb0YrVUNDYXErZVcrZGM5d2Ru?=
 =?utf-8?B?aFBjM0ZyM05JaWhiM1FGN2szK081ZmFFeDFwZHJYbWNNbWhYNHpYZVNMbVU5?=
 =?utf-8?B?WGlmWitQTlVtNFdDUDNmN3BLK25PTFJVTzF6Um1RZWFTVlhsNVpXdnBUbWxZ?=
 =?utf-8?B?dlFlZzMwbnppTUY3M1NqWWdwUElNWDY4NTNROUNVRG5DT2F3Y3lTUjlHU0Fa?=
 =?utf-8?B?TUZjeU9vTmdVaUtlVktvZEFFaEFVZHVIeTQvS3ZtUmRpeEFoNjhPSU5JbGJG?=
 =?utf-8?B?dTVDZ1l0Zm9KcGZBUDNlVkUzODJ2MzhkTmVWejIyTnptNTUyQ21ySVFuTUZV?=
 =?utf-8?B?YTZURTlnUkhWYUdlSmZnekwvS0h2ZnZoemdhN3VXbUdtdlhTdnRPZTlPWHRq?=
 =?utf-8?B?NncwVUxVUSt6WUdZNXNpcnZVWmE1R1o1OXBzNzUrRlh1d0lkK2s4ZnVuR29E?=
 =?utf-8?B?YnNxWmFwbkg4blh6MklVVUpmbEUweU5OV042ZTk0R3FnelpxdVRnQkJnb0hJ?=
 =?utf-8?Q?0rXLYpo7iBkXHRJLAgswrWhA6nW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b795bdd6-1e34-49c6-96ac-08d8c810ec64
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 06:57:08.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLIby+7Jqk0gHfZGvyQeNhrIMoE66KHzxNgoDkstsbmhZzCAQTSqKrsRr+FlNU1/Y/lcwC5lkNgWBqeE/7uBeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3137
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030040
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1011
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030039
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/3/2021 2:10 PM, Damien Le Moal wrote:
> On 2021/02/03 14:22, Anand Jain wrote:
>> On 1/26/2021 10:24 AM, Naohiro Aota wrote:
>>> Conventional zones do not have a write pointer, so we cannot use it to
>>> determine the allocation offset if a block group contains a conventional
>>> zone.
>>>
>>> But instead, we can consider the end of the last allocated extent in the
>>> block group as an allocation offset.
>>>
>>> For new block group, we cannot calculate the allocation offset by
>>> consulting the extent tree, because it can cause deadlock by taking extent
>>> buffer lock after chunk mutex (which is already taken in
>>> btrfs_make_block_group()). Since it is a new block group, we can simply set
>>> the allocation offset to 0, anyway.
>>>
>>
>> Information about how are the WP of conventional zones used is missing here.
> 
> Conventional zones do not have valid write pointers because they can be written
> randomly. This is per ZBC/ZAC specifications. So the wp info is not used, as
> stated at the beginning of the commit message.

I was looking for the information why still "end of the last allocated 
extent in the block group" is assigned to it?

Thanks.

>> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>> Thanks.
>>
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>> ---
>>>    fs/btrfs/block-group.c |  4 +-
>>>    fs/btrfs/zoned.c       | 99 +++++++++++++++++++++++++++++++++++++++---
>>>    fs/btrfs/zoned.h       |  4 +-
>>>    3 files changed, 98 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 0140fafedb6a..349b2a09bdf1 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -1851,7 +1851,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>>>    			goto error;
>>>    	}
>>>    
>>> -	ret = btrfs_load_block_group_zone_info(cache);
>>> +	ret = btrfs_load_block_group_zone_info(cache, false);
>>>    	if (ret) {
>>>    		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
>>>    			  cache->start);
>>> @@ -2146,7 +2146,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>>>    	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
>>>    		cache->needs_free_space = 1;
>>>    
>>> -	ret = btrfs_load_block_group_zone_info(cache);
>>> +	ret = btrfs_load_block_group_zone_info(cache, true);
>>>    	if (ret) {
>>>    		btrfs_put_block_group(cache);
>>>    		return ret;
>>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>> index 22c0665ee816..ca7aef252d33 100644
>>> --- a/fs/btrfs/zoned.c
>>> +++ b/fs/btrfs/zoned.c
>>> @@ -930,7 +930,68 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>>>    	return 0;
>>>    }
>>>    
>>> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>>> +/*
>>> + * Calculate an allocation pointer from the extent allocation information
>>> + * for a block group consist of conventional zones. It is pointed to the
>>> + * end of the last allocated extent in the block group as an allocation
>>> + * offset.
>>> + */
>>> +static int calculate_alloc_pointer(struct btrfs_block_group *cache,
>>> +				   u64 *offset_ret)
>>> +{
>>> +	struct btrfs_fs_info *fs_info = cache->fs_info;
>>> +	struct btrfs_root *root = fs_info->extent_root;
>>> +	struct btrfs_path *path;
>>> +	struct btrfs_key key;
>>> +	struct btrfs_key found_key;
>>> +	int ret;
>>> +	u64 length;
>>> +
>>> +	path = btrfs_alloc_path();
>>> +	if (!path)
>>> +		return -ENOMEM;
>>> +
>>> +	key.objectid = cache->start + cache->length;
>>> +	key.type = 0;
>>> +	key.offset = 0;
>>> +
>>> +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>>> +	/* We should not find the exact match */
>>> +	if (!ret)
>>> +		ret = -EUCLEAN;
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	ret = btrfs_previous_extent_item(root, path, cache->start);
>>> +	if (ret) {
>>> +		if (ret == 1) {
>>> +			ret = 0;
>>> +			*offset_ret = 0;
>>> +		}
>>> +		goto out;
>>> +	}
>>> +
>>> +	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
>>> +
>>> +	if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
>>> +		length = found_key.offset;
>>> +	else
>>> +		length = fs_info->nodesize;
>>> +
>>> +	if (!(found_key.objectid >= cache->start &&
>>> +	       found_key.objectid + length <= cache->start + cache->length)) {
>>> +		ret = -EUCLEAN;
>>> +		goto out;
>>> +	}
>>> +	*offset_ret = found_key.objectid + length - cache->start;
>>> +	ret = 0;
>>> +
>>> +out:
>>> +	btrfs_free_path(path);
>>> +	return ret;
>>> +}
>>> +
>>> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>>>    {
>>>    	struct btrfs_fs_info *fs_info = cache->fs_info;
>>>    	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
>>> @@ -944,6 +1005,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>>>    	int i;
>>>    	unsigned int nofs_flag;
>>>    	u64 *alloc_offsets = NULL;
>>> +	u64 last_alloc = 0;
>>>    	u32 num_sequential = 0, num_conventional = 0;
>>>    
>>>    	if (!btrfs_is_zoned(fs_info))
>>> @@ -1042,11 +1104,30 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>>>    
>>>    	if (num_conventional > 0) {
>>>    		/*
>>> -		 * Since conventional zones do not have a write pointer, we
>>> -		 * cannot determine alloc_offset from the pointer
>>> +		 * Avoid calling calculate_alloc_pointer() for new BG. It
>>> +		 * is no use for new BG. It must be always 0.
>>> +		 *
>>> +		 * Also, we have a lock chain of extent buffer lock ->
>>> +		 * chunk mutex.  For new BG, this function is called from
>>> +		 * btrfs_make_block_group() which is already taking the
>>> +		 * chunk mutex. Thus, we cannot call
>>> +		 * calculate_alloc_pointer() which takes extent buffer
>>> +		 * locks to avoid deadlock.
>>>    		 */
>>> -		ret = -EINVAL;
>>> -		goto out;
>>> +		if (new) {
>>> +			cache->alloc_offset = 0;
>>> +			goto out;
>>> +		}
>>> +		ret = calculate_alloc_pointer(cache, &last_alloc);
>>> +		if (ret || map->num_stripes == num_conventional) {
>>> +			if (!ret)
>>> +				cache->alloc_offset = last_alloc;
>>> +			else
>>> +				btrfs_err(fs_info,
>>> +			"zoned: failed to determine allocation offset of bg %llu",
>>> +					  cache->start);
>>> +			goto out;
>>> +		}
>>>    	}
>>>    
>>>    	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
>>> @@ -1068,6 +1149,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
>>>    	}
>>>    
>>>    out:
>>> +	/* An extent is allocated after the write pointer */
>>> +	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
>>> +		btrfs_err(fs_info,
>>> +			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",
>>> +			  logical, last_alloc, cache->alloc_offset);
>>> +		ret = -EIO;
>>> +	}
>>> +
>>>    	kfree(alloc_offsets);
>>>    	free_extent_map(em);
>>>    
>>> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
>>> index 491b98c97f48..b53403ba0b10 100644
>>> --- a/fs/btrfs/zoned.h
>>> +++ b/fs/btrfs/zoned.h
>>> @@ -41,7 +41,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>>>    int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
>>>    			    u64 length, u64 *bytes);
>>>    int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
>>> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
>>> +int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
>>>    #else /* CONFIG_BLK_DEV_ZONED */
>>>    static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>>>    				     struct blk_zone *zone)
>>> @@ -119,7 +119,7 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
>>>    }
>>>    
>>>    static inline int btrfs_load_block_group_zone_info(
>>> -	struct btrfs_block_group *cache)
>>> +	struct btrfs_block_group *cache, bool new)
>>>    {
>>>    	return 0;
>>>    }
>>>
>>
>>
> 
> 
