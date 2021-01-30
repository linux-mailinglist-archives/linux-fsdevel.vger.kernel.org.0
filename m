Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97193098C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 00:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhA3XW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 18:22:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42414 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3XWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:22:54 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UNFaAw119666;
        Sat, 30 Jan 2021 23:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pzYBMTE7BsY0nFFfojoldPWVWt7Pezz4P8pz4tIP0w8=;
 b=N2SJkbCP6HoknzrTwIWNvY1O2Db3QqsJDdLSDM2P5yp0KQqQBpQbLSJ5AALcQLKOwLBg
 1WMa2HZB2BiPjZ3RRZEO+TtgPdDnJ+UTKhooqeAGJiguYx89M/ozVttOxTu8FFtq9TN4
 GTl80y4MilPongWn4D9/f1dYDCY0zROo/0Hf6jrgtKWBnjsWO2TxEV2aDwak/KYWfE4B
 qKGuCnw0Edc2NMEFiM5+CDqa0ZOIrINHzpEEPZlKBWuS7GTreaiLlUkBAhgqEYImopda
 Z1qrx+NCeehlVHxXLlEfY9nZjgmscuksmM3HXIaWGW4OpNxVRjrVay+OUmcdg6SGBWLF +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36cvyahe2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 23:21:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UNGL4k039041;
        Sat, 30 Jan 2021 23:21:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3030.oracle.com with ESMTP id 36cvjs31x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 23:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiGfVMY3XmdVOAc/s1FSsbBjZKWoL2ddpatWmhQbUQLX/2u4LcarV0Z2LzM3EJlXRe/yOkx4Z3YlKP59R6LTWfnt8Giq1OLOT194zBbrOG3z62N+N7Vg6/m0+pB8pB5LAbEqKXZA0YaxvYyX6XvJT+KFA6SXahwluABRKE+1vjY62+89/o+Sh7vC8RkcF60HxLmAb28vbVf4fvj1JzcPFVe0WpYNxL6AAO4+apxDy1+rEMDDZs3QMIGmKehpY5pDER+9qI/D2tM2AslCl8l5XeISlASSI+XGRfWqKLUtv+WfrmzicPz+79t04s7vunvaKYb1gwW90w3cxJ0qVGwL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzYBMTE7BsY0nFFfojoldPWVWt7Pezz4P8pz4tIP0w8=;
 b=hu5XgDr81bZQV+3o5Zx90ES2L4F6tjln+kwzL0yAD10u4IjZlR9SJQHF3g/OLL1MF7jK7AJGTKxCchibBI/36jYCaAyMn1FQVu4m1jTMQDMhXMpSfKFTR4jxlRyqokfIh/uax6Z6a06oETEfiFU1QnU9g37LFXrMo0XPIkEbmt9tYFKvc8Qt8tWKWrRKsZlQ1GjJYkxjsXWmgkhJgbBvAM1s8RC62eOT+Yg73jZsGR+5mvY6jQVxp/S8cxgjtH9T27gJ+3iFJbRZUhgdIOAGWDDSjZeTgBlI+mGRmmho62n9+CgD/x73RCQCqSerHkzH1CfTqIMpbqKor6r+lYHg8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzYBMTE7BsY0nFFfojoldPWVWt7Pezz4P8pz4tIP0w8=;
 b=XxD5QbApmY4XxkzybmRLee/oB9QiYwFJQB4ODRv5Uq3PRZfFdXmXPZwqqg1O7Cgyv8TJfR0jtVAnihh72+U14WyGm7pxPxV8w+Yth+tq1VnOKS1LM9SXTxDsYk+DLo9U6NG20GMFvJVvID3jrEDd/CedzrN5C6eBmudfQp8zEIM=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3556.namprd10.prod.outlook.com (2603:10b6:408:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Sat, 30 Jan
 2021 23:21:53 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sat, 30 Jan 2021
 23:21:53 +0000
Subject: Re: [PATCH v14 05/42] btrfs: release path before calling into
 btrfs_load_block_group_zone_info
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <d931b0c588dda740d140a1d8e87eb5b138869fc5.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d7e18cf7-ad33-7052-15c7-3dff3fa8f635@oracle.com>
Date:   Sun, 31 Jan 2021 07:21:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <d931b0c588dda740d140a1d8e87eb5b138869fc5.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:b1e5:e46d:4484:a96c]
X-ClientProxiedBy: SG2PR06CA0213.apcprd06.prod.outlook.com
 (2603:1096:4:68::21) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:b1e5:e46d:4484:a96c] (2406:3003:2006:2288:b1e5:e46d:4484:a96c) by SG2PR06CA0213.apcprd06.prod.outlook.com (2603:1096:4:68::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 23:21:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7286321c-95cc-4531-dee3-08d8c575d3e3
X-MS-TrafficTypeDiagnostic: BN8PR10MB3556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB3556EA05102950E4E48E3ADDE5B89@BN8PR10MB3556.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Us3Vc2Pu22mSNIHVXxF2YNWevY9VMaWYX9+6/O7mUzglFMr/djA40w4LyEyE8C3Lvl1JY2kccMAq1vrgaO8nmdz21MeCUbIlWdnDh4HTZjXEycWUQl3w6xK0YQdrpqok0kyyo0+i6OCdqdUU1hVuqiry/V711yruL6nSJvXZE6+qmCBCH/N6vobtHOHayshEP2RZ6dUFA4/jH1+2JL0XwFczXWtE2UvdJX4mWXRNxXu5V+8pKNrPOZj+4LNPUXX3B8WlX0cgz1cdmRZwEUrwMlmq9YvjMrDpjBzXqSmRvtGgJrJLzjmi3MjOFSf9hrnXJUffHNcGOzzkZnTm+FoaHW6lJZeVEsbygXTzeZVIkaZcZJgeAnHe4iuZdklXKp02XaXnPHsieUi9mWGaE6JOgul0D0WC5NHOOWSYK0XTbJd8oukFs4TCdy/SGwiSHek0zFqG1ARO58TIMtaBZFBycWUO4wdTm0HkgbxwIS9GNaJPYP6v+S/eLIp7DcZSets2lwKPkAn4tBqioKQQpJqP9BdLTUWKL2Hw/ZCK6sImS7v/Sw1CdObU3rySgOC3MIJuB/EAqKLaRvr+H/C3RZDUeU7GafQrA7NHh2oTjj9Sy7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(346002)(396003)(136003)(376002)(44832011)(53546011)(36756003)(83380400001)(5660300002)(54906003)(86362001)(6486002)(186003)(31696002)(478600001)(316002)(16526019)(66476007)(2906002)(8676002)(4326008)(31686004)(66946007)(66556008)(2616005)(8936002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bVltdnpnUE5tMlRyakptNUJ5UVR6SDk0aXB6ZWcva1hUWkkya2JXOGkvRkhn?=
 =?utf-8?B?UDVzMHNBblBibUdoaXYxTmQ3OCtFK0NyRStCRk90M0JxV1N1SmZDWHk2TU5s?=
 =?utf-8?B?akxXbkROTzkrUTNzNUpDM0luNy9QR2RTdkVBS0ZWVzArSDFuMVR2K0x0dTk1?=
 =?utf-8?B?RG9WZytjQkVNZkJwQnFNRUZWQUVMbU5abURsUWtUU3FMeTJZcFBIOURGTGVh?=
 =?utf-8?B?SWlpd2lQeVBZV2w3VlBmeTZEQ3psb3FiWStyRmt6VXdoQ0dKNDNwQWsyTkhl?=
 =?utf-8?B?b29PeDF4amQzYjY0bko2ZUtNZ3ErNzJEWW5Ec2VwZ0x4WUtSUG1JQy8wTnl5?=
 =?utf-8?B?TkUyTTd3bjhQQWhrQnNjZy9TbWFXTjErNUxxd3V0bExFbjNhNDZmMlpZVVBS?=
 =?utf-8?B?Y1hiTGQvQUdpa2p3aEEvV3RmY2RCbXFwa2JvRmI3TUZLUG9WT2VsQUM4bzFz?=
 =?utf-8?B?cnFOck0zU0dhUnpXR3AwaUJjZU5BQlFRRWFkaEJqcWV5akRQUVN1ZFdyYWFB?=
 =?utf-8?B?MWZyRDJlVkp4eHdXVCtzWEI4REpidEtXS2pxUHhiSXY2SzJoVmtNbDcxWEo1?=
 =?utf-8?B?ekZpcVV1dHJNZzBEVnpXQ2dvT1lDaDFhMVFBNEpRTmEvNlpZMGk1VWRwTExI?=
 =?utf-8?B?c3E3SUdIN2pZakYrTVBzWDZiOENyWjl6N0x4Y0trREtzbWVvVmJYd29HcW9X?=
 =?utf-8?B?VHBuR2VIL2h0eUlvNzNwU2lBempXL0wyU0tqbmczRTFrTk1OOGFDU3Nmc2JU?=
 =?utf-8?B?WTdFWFlsVFJpUFl2QmhzOVVZSW1tN2tINFlTV3ZZYkJoTFM1a3liWG1sVnBY?=
 =?utf-8?B?MlZVeHpVc01uODRKNE1lR25JNTNlbzRSYzJBNTdZVTlhU05sK2tzNzhibk1X?=
 =?utf-8?B?M3ZsQWcwUjFYTXJJWkhMakhVRXpQaTlSaU1pSGthSXNaVlhzSU50aThkaFlx?=
 =?utf-8?B?bS9acUl2QWduQjVaeUROSGhsbVlnQUpzdDJJTzZZN29VM3VDcWRBalo0VEh4?=
 =?utf-8?B?OGE1TUxnanF3Smd2UDR2b0FTOGV2SFY4aEMxbEZzOW4wdlo4bFJFN1RsRzRI?=
 =?utf-8?B?WW04UGNLM1hlMEtzVEFTWW9QdkVKS3BEbUZFcnpRWUJqU2ttNU5kRk84QmQx?=
 =?utf-8?B?aWkvbWFyVjB3YmRSTENzOXlxTVpScEE3Q3VSL1FXWlRwaXRSQWoxVnk0amRp?=
 =?utf-8?B?djNGbjl6bWQ2SUovNlZ2c21xMmFPdFBQZElKWU9pQ096eDNXV002a1o1aGlC?=
 =?utf-8?B?eitya1Y1Vit0SUVxQ3BPRUp3ZjBJMEJKOENWUmErdVZWeDNLQ2tYcGRybGJB?=
 =?utf-8?B?UE9pV21NMHh2TXBQNm1PSEFYeHZKRFVxVGhxNTJWTVUvSmY3cGJlVU5LV2k2?=
 =?utf-8?B?dmsrMTVzYW8xdC9DTktzalJLK25tM2pkcDBudjBHcGh2T3l4UHd3RG1wb2pP?=
 =?utf-8?B?c0dkMzJGSmdHZlJKZUszVkxZMTNjVEhaWWhQUlEva3c4UTJBSzVwMWdEc3Zx?=
 =?utf-8?Q?F59+waIzrx5N11onWGLJkKV9zj+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7286321c-95cc-4531-dee3-08d8c575d3e3
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 23:21:53.4694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iT1GxJcFTYlkAjatrb4v0Gkz0EViVPfQZmaET0ib6/EoM+Uy7fDv3hjloXMFo1sTrQp9TCJlxzhPAQiWvsaTNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3556
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300128
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300128
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Since we have no write pointer in conventional zones, we cannot determine
> the allocation offset from it. Instead, we set the allocation offset after
> the highest addressed extent. This is done by reading the extent tree in
> btrfs_load_block_group_zone_info().
> 
> However, this function is called from btrfs_read_block_groups(), so the
> read lock for the tree node can recursively taken.
> 
> To avoid this unsafe locking scenario, release the path before reading the
> extent tree to get the allocation offset.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>


Looks good to me.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/block-group.c | 39 ++++++++++++++++++---------------------
>   1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 763a3671b7af..bdd20af69dde 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1805,24 +1805,8 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
>   	return ret;
>   }
>   
> -static void read_block_group_item(struct btrfs_block_group *cache,
> -				 struct btrfs_path *path,
> -				 const struct btrfs_key *key)
> -{
> -	struct extent_buffer *leaf = path->nodes[0];
> -	struct btrfs_block_group_item bgi;
> -	int slot = path->slots[0];
> -
> -	cache->length = key->offset;
> -
> -	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
> -			   sizeof(bgi));
> -	cache->used = btrfs_stack_block_group_used(&bgi);
> -	cache->flags = btrfs_stack_block_group_flags(&bgi);
> -}
> -
>   static int read_one_block_group(struct btrfs_fs_info *info,
> -				struct btrfs_path *path,
> +				struct btrfs_block_group_item *bgi,
>   				const struct btrfs_key *key,
>   				int need_clear)
>   {
> @@ -1837,7 +1821,9 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   	if (!cache)
>   		return -ENOMEM;
>   
> -	read_block_group_item(cache, path, key);
> +	cache->length = key->offset;
> +	cache->used = btrfs_stack_block_group_used(bgi);
> +	cache->flags = btrfs_stack_block_group_flags(bgi);
>   
>   	set_free_space_tree_thresholds(cache);
>   
> @@ -1996,19 +1982,30 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
>   		need_clear = 1;
>   
>   	while (1) {
> +		struct btrfs_block_group_item bgi;
> +		struct extent_buffer *leaf;
> +		int slot;
> +
>   		ret = find_first_block_group(info, path, &key);
>   		if (ret > 0)
>   			break;
>   		if (ret != 0)
>   			goto error;
>   
> -		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> -		ret = read_one_block_group(info, path, &key, need_clear);
> +		leaf = path->nodes[0];
> +		slot = path->slots[0];
> +
> +		read_extent_buffer(leaf, &bgi,
> +				   btrfs_item_ptr_offset(leaf, slot),
> +				   sizeof(bgi));
> +
> +		btrfs_item_key_to_cpu(leaf, &key, slot);
> +		btrfs_release_path(path);
> +		ret = read_one_block_group(info, &bgi, &key, need_clear);
>   		if (ret < 0)
>   			goto error;
>   		key.objectid += key.offset;
>   		key.offset = 0;
> -		btrfs_release_path(path);
>   	}
>   	btrfs_release_path(path);
>   
> 

