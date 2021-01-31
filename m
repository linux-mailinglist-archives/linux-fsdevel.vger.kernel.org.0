Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522BC309C7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 15:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhAaN4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 08:56:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45710 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhAaLEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:04:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VAxYRQ061602;
        Sun, 31 Jan 2021 11:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fPRyVKp1YNic7QWhkCAB/NX3Li0CH8eARUnRZEnrqzI=;
 b=jvZ4dHHTKKph9ZOXrSFzgUrjJzy1PFJLwfDjMrwGA2g4ItjcjO6PiCa7lQEQ98Ig3Dtr
 w0ipeMCf09Bg8d24c51CG9mNgydgffCIJ/qB8psD6H94KeKv4oPxobiHJ7oBU5sVjDve
 /Pz7VNNWTMrt8O2m0mcb4m4f9zD2gRJg4uf/rK3epdLJy3a1MLyPnF82zmChv+77cMK4
 sWGWGY1EC4mlCvoBPLErv1C/Ku+KJgcUTMmkKNPK4bLr3vvn0ggfjoXqpHkiE+9prxxA
 k7sikX1gQf0Xar9ffMVz8t7PqWdRRkefI4p5iXLzqa9BQOCV5movdxJCK3MXJnHLyf08 sA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydkj3us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 11:01:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VB0njY144936;
        Sun, 31 Jan 2021 11:01:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 36dhbvjbma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 11:01:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9VX8v+/5IkHNe7pzA/KYqmEBEBCqc1TkNDJGYMwZJox9LENcG+JOG+pq/+Mocz/J5ai9Fg+ycTafxQKkZIHKwHuHpzx+qqC3k6nxTxeEdo2Zj7M3jMOWq6Bm7Pscml+ujH8Mv41xW/wb5Ypn8mGdwyI80EZhm3eW9fwJ/1M7oxrdqIU1z0DvjhyUMpxaC1e6Ym7JQsU0jjKc0f2uU4JoQhiAlIKsrzubMB7BpbZzLocGj8zjRaren53R9+GefutP0KoGgHyDgc9YB6N2PP7OWBcfCaQlDQwIIQ6Q1tb1a5vN3cv9i4wTeeBc9C5PJfhZhg/WqOhgT7bH7WQkezSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPRyVKp1YNic7QWhkCAB/NX3Li0CH8eARUnRZEnrqzI=;
 b=WYIF+0TRG/HX4CsdcqBSgXuwsRKY10MqQQ9KTKNRLibVEPjmchwtbFhJE6eabUNeBQ66CbUMUBvK6GVFAzOmexsekrWcmLOg8z1f74tvNXF0TguUjL+ILyPlIQte4U5BpqqeUvEeUcYQDLks1VdHzkRVSOeBowi5nXvwFvv4G9cJId3yVBn8nB0j7Ngjx0WYm/oBmmLoDRqoeMI0uDzByFtWqSdthRRDYovDyc6siX7lx/zImmwZAc2YaF7LXq2zr/kdy8AnzDeAvN5FsV0heofQbtcwoMlDuWCSLevLo/lxwZSmVq3W6PNxzJ42R+usH51Ig9DusLMJrAoyLiz1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPRyVKp1YNic7QWhkCAB/NX3Li0CH8eARUnRZEnrqzI=;
 b=SUT5wZ1ORS6jyvVS71qNZClrwlaZDtDA6EZfxK8WoU8G047e/+J4eb2LrhAEOMk2FiMrinrc9HGtTtupK4LZcyS3HaI8LdqnVv/mWsULSUQ2hRlqFeLboEF+luyz6caYcGYQl7Ji3QucGqcxj9+jl7goaf/YKkV2MM0VEbfAnSw=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3553.namprd10.prod.outlook.com (2603:10b6:408:ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Sun, 31 Jan
 2021 11:01:38 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 11:01:38 +0000
Subject: Re: [PATCH v14 09/42] btrfs: implement zoned chunk allocator
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <aed311f8c69c4cce78a46b41629f56bbb6d52b4f.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <237994c5-d5e6-9371-f703-af9e46bf7a30@oracle.com>
Date:   Sun, 31 Jan 2021 19:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <aed311f8c69c4cce78a46b41629f56bbb6d52b4f.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c074:cdb6:65f3:80b1]
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c074:cdb6:65f3:80b1] (2406:3003:2006:2288:c074:cdb6:65f3:80b1) by SG2PR01CA0163.apcprd01.prod.exchangelabs.com (2603:1096:4:28::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sun, 31 Jan 2021 11:01:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b268732-19a2-4f8e-b250-08d8c5d794ea
X-MS-TrafficTypeDiagnostic: BN8PR10MB3553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB3553AB0A4CD5E773E71D4575E5B79@BN8PR10MB3553.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+bMA7n/MGR6jYlCq/7hSm+lwOSy7rXnWnRUQs8OClnk+UhVRJYr2zwkj9mSXYlpfZyVFDY0CiFZ1mt1NWaiT36Haw4u3xI2eHfs+FJ+24bqsSRKCWdIXkjvSXSNXwpxt8i6lrLmYwoVnM0fd5YSxgiNvp84bCJE+/CG2iPLf01soYxTsyP7c8MdNCvleji8D81fLyfVdZnhmzwdu6c0StP89nGklwJnEmn0RHj7xLmBtod5OSwoUNn388WI6X9ugrr9G/9AG8ndyZB2CV13dHo9Mclj2orpVh7IlxcXIuzbyDcoseLMLLmp/x9BEYpeq5V1puyO+aiMS3vO+XYc1YxP7h87o5pvdJoNFGxb0sWwJ2jS6OPvDe+cuvQwqAjhlHGpE9l/WAzdLHNmMPTHYM7CrcNKv/FNT0aJumRsDckPyAklbE6x6ZHAuVcG8dzqSr6G6Orte4ymhDaXU3aA/eumYAf6XaxobgMQO7qaDjAy4oenmrOkq93r6qGK/qlfv5Ce1n/4ZJCxQgGQwWMyouJZPI3yPaoxOlxpDrGDXVjDYHXfczPMmzJQF0dMqOVihpn206Sjbq4g9grYFwykXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(396003)(346002)(478600001)(6666004)(31696002)(66476007)(30864003)(54906003)(66556008)(8936002)(66946007)(86362001)(53546011)(6486002)(2616005)(8676002)(5660300002)(186003)(4326008)(36756003)(316002)(83380400001)(2906002)(31686004)(16526019)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R0tsRWk3MkpaNXlQY3ZRSmZwRjliMENjTVBBakRQNCs2RUo2OGxSUGJKdVFT?=
 =?utf-8?B?dS9YUGFlVDAyZkVXTWlCeTR5eGJYeWQ1b1YyVXlEbVcvY25FZUdtMG5OOGw0?=
 =?utf-8?B?RmVqajIxWTduRHFGSnRldmVLdjVRVHI2V3JGYVFiWUdPQ2hSRlBVYm5MdW9t?=
 =?utf-8?B?STlMelVFMXZ2aTNmclZxRkdmVm01TkxUaVQyVWw2L2xrNXV6WThtZjh3Rzhz?=
 =?utf-8?B?ZDA5R1RiUERLcjljeDQ2SGp1bEtuLzRQb1I2UFJScS9DbzNkM24wUHVoVGJU?=
 =?utf-8?B?Yk0zN21iSG1wYkUzeC9yeXF6dnZOczMrMEpVVyt1aUZLeVNHTkRnYmsvTmlx?=
 =?utf-8?B?SjJ1bW4vUXFmM2ZGcG82VWhlM3RsTUpMUW8ydEVTVTBDUWE1UnQ3aUNQV1JS?=
 =?utf-8?B?VkNKMU9qVkhoR2Y4VVhuUFFHbGxVc0hJQmh4UXdmUTRaUVZyYlQrK2tJbWw4?=
 =?utf-8?B?MHlpOHkyS1E5K0Nkd1B2UFBKMWt1VkR1d1FEQTRUd3lrZnRvcTEvZG93MWxM?=
 =?utf-8?B?Q01LcW9HRTk2c2dnVDYrSDIyMk9HcC9CbDJJU2VZaVFGelFZZjV0M1E1S3Rr?=
 =?utf-8?B?U1lEc0h2WDFkNXNlczBSMFpGYWtOMnlOYi83ZXJDMER3U0ZETmg1R2FIN2sr?=
 =?utf-8?B?aHRyN0xxOHdvRS9MYlppOEpKUnBhYWFUbGtKNDhzbUw4L1AzNmpxWkFqWTJT?=
 =?utf-8?B?SElxMlBBblpoaXhWb0c1SDJYY2pDZitzN1ZKMFFDanVtNnlCL202VGdlS0RX?=
 =?utf-8?B?Vi9KTUJTaVI4bXlLQ3g0WFc0Mzk3THpiZFJzZ1hYeG1qL2dzYUdsVncyU0Zq?=
 =?utf-8?B?TzJRWGhLd0lnWWhyK2c2cmpRZksrbUpyeHNTTG1tVXNiMmlSY0xLRmN1ZVJX?=
 =?utf-8?B?ZEVtd2ZFSXlieE1ETWUvNjlicDkwMnNiYXNIVVJtNmlVQWw3TU00S0pldU9P?=
 =?utf-8?B?eWFuYUovUzJMZ3c1aXBxb241WkVDaitUVEpJY3psZmZZUTd4UjBjbnJacGNJ?=
 =?utf-8?B?dy8yaGR1NnQ0NWtLVjdmWFdJeTdxOGc1aG9QNUJQUFFlcHhIV1VrTzBnSlds?=
 =?utf-8?B?ekdyK2xlbjlDUklZUlRWTGRtWXhmZmRHNnVyT2FwSDc0QU5nRzNkTFJaTU9x?=
 =?utf-8?B?ZXJrWFpRSitzcXVkYUZsMFRlTU50MGI0a0d1SGFkSjRqL251RFZkSnlrK01O?=
 =?utf-8?B?VGNtYkF1UTNhVGtIdHU1dDRKUkVsZHNHbnFXZ0UydWNLVkNYamVXZmx5LzYr?=
 =?utf-8?B?WXNSMVRQUlNhd1A2TG45VXQ0aEJZYUhmLzUrSUJVSjRYRnI1NEJJUjU3a1BJ?=
 =?utf-8?B?Q0VISWlGS3NHWXh1Q2Fkamp4Wlc4TldQckQrMlIzMFVwMVdMUlU5OHRsajRO?=
 =?utf-8?B?U2xpMFNkemNGU2JlNlFVZGtoTE5kb3lhQTZrWEwyb0FQei9HQkg4czgwSXEr?=
 =?utf-8?B?ZHByL1Q5cDJIR1BGcm1LWEZUUXNDUDV3Zkh5UEhtM2pISU0wV0RVdG1rbTUv?=
 =?utf-8?Q?T4IHRjzFQnwIQUpE3E2Dvt85qQk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b268732-19a2-4f8e-b250-08d8c5d794ea
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2021 11:01:38.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCcy0QhGhfLzvwm7lLS0yFqRbeqrp4PTj2r7lDkYOBQKKL5xpcYOYgG9OQAJCPZjHCNeeVhJfJe24qTaYrN8mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3553
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310057
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310057
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> This commit implements a zoned chunk/dev_extent allocator. The zoned
> allocator aligns the device extents to zone boundaries, so that a zone
> reset affects only the device extent and does not change the state of
> blocks in the neighbor device extents.
> 
> Also, it checks that a region allocation is not overlapping any of the
> super block zones, and ensures the region is empty.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

   A nit below.

> ---
>   fs/btrfs/volumes.c | 169 ++++++++++++++++++++++++++++++++++++++++-----
>   fs/btrfs/volumes.h |   1 +
>   fs/btrfs/zoned.c   | 144 ++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/zoned.h   |  25 +++++++
>   4 files changed, 323 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb3f341f6a22..27208139d6e2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1414,11 +1414,62 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
>   		 * make sure to start at an offset of at least 1MB.
>   		 */
>   		return max_t(u64, start, SZ_1M);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		/*
> +		 * We don't care about the starting region like regular
> +		 * allocator, because we anyway use/reserve the first two
> +		 * zones for superblock logging.
> +		 */
> +		return ALIGN(start, device->zone_info->zone_size);
>   	default:
>   		BUG();
>   	}
>   }
>   
> +static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
> +					u64 *hole_start, u64 *hole_size,
> +					u64 num_bytes)
> +{
> +	u64 zone_size = device->zone_info->zone_size;
> +	u64 pos;
> +	int ret;
> +	int changed = 0;

  bool would have sufficed here.

Thanks.


> +
> +	ASSERT(IS_ALIGNED(*hole_start, zone_size));
> +
> +	while (*hole_size > 0) {
> +		pos = btrfs_find_allocatable_zones(device, *hole_start,
> +						   *hole_start + *hole_size,
> +						   num_bytes);
> +		if (pos != *hole_start) {
> +			*hole_size = *hole_start + *hole_size - pos;
> +			*hole_start = pos;
> +			changed = 1;
> +			if (*hole_size < num_bytes)
> +				break;
> +		}
> +
> +		ret = btrfs_ensure_empty_zones(device, pos, num_bytes);
> +
> +		/* Range is ensured to be empty */
> +		if (!ret)
> +			return changed;
> +
> +		/* Given hole range was invalid (outside of device) */
> +		if (ret == -ERANGE) {
> +			*hole_start += *hole_size;
> +			*hole_size = 0;
> +			return 1;
> +		}
> +
> +		*hole_start += zone_size;
> +		*hole_size -= zone_size;
> +		changed = 1;
> +	}
> +
> +	return changed;
> +}
> +
>   /**
>    * dev_extent_hole_check - check if specified hole is suitable for allocation
>    * @device:	the device which we have the hole
> @@ -1435,24 +1486,39 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
>   	bool changed = false;
>   	u64 hole_end = *hole_start + *hole_size;
>   
> -	/*
> -	 * Check before we set max_hole_start, otherwise we could end up
> -	 * sending back this offset anyway.
> -	 */
> -	if (contains_pending_extent(device, hole_start, *hole_size)) {
> -		if (hole_end >= *hole_start)
> -			*hole_size = hole_end - *hole_start;
> -		else
> -			*hole_size = 0;
> -		changed = true;
> -	}
> +	for (;;) {
> +		/*
> +		 * Check before we set max_hole_start, otherwise we could end up
> +		 * sending back this offset anyway.
> +		 */
> +		if (contains_pending_extent(device, hole_start, *hole_size)) {
> +			if (hole_end >= *hole_start)
> +				*hole_size = hole_end - *hole_start;
> +			else
> +				*hole_size = 0;
> +			changed = true;
> +		}
> +
> +		switch (device->fs_devices->chunk_alloc_policy) {
> +		case BTRFS_CHUNK_ALLOC_REGULAR:
> +			/* No extra check */
> +			break;
> +		case BTRFS_CHUNK_ALLOC_ZONED:
> +			if (dev_extent_hole_check_zoned(device, hole_start,
> +							hole_size, num_bytes)) {
> +				changed = true;
> +				/*
> +				 * The changed hole can contain pending
> +				 * extent. Loop again to check that.
> +				 */
> +				continue;
> +			}
> +			break;
> +		default:
> +			BUG();
> +		}
>   
> -	switch (device->fs_devices->chunk_alloc_policy) {
> -	case BTRFS_CHUNK_ALLOC_REGULAR:
> -		/* No extra check */
>   		break;
> -	default:
> -		BUG();
>   	}
>   
>   	return changed;
> @@ -1505,6 +1571,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
>   
>   	search_start = dev_extent_search_start(device, search_start);
>   
> +	WARN_ON(device->zone_info &&
> +		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
> +
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
> @@ -4899,6 +4968,37 @@ static void init_alloc_chunk_ctl_policy_regular(
>   	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>   }
>   
> +static void init_alloc_chunk_ctl_policy_zoned(
> +				      struct btrfs_fs_devices *fs_devices,
> +				      struct alloc_chunk_ctl *ctl)
> +{
> +	u64 zone_size = fs_devices->fs_info->zone_size;
> +	u64 limit;
> +	int min_num_stripes = ctl->devs_min * ctl->dev_stripes;
> +	int min_data_stripes = (min_num_stripes - ctl->nparity) / ctl->ncopies;
> +	u64 min_chunk_size = min_data_stripes * zone_size;
> +	u64 type = ctl->type;
> +
> +	ctl->max_stripe_size = zone_size;
> +	if (type & BTRFS_BLOCK_GROUP_DATA) {
> +		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
> +						 zone_size);
> +	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
> +		ctl->max_chunk_size = ctl->max_stripe_size;
> +	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
> +		ctl->max_chunk_size = 2 * ctl->max_stripe_size;
> +		ctl->devs_max = min_t(int, ctl->devs_max,
> +				      BTRFS_MAX_DEVS_SYS_CHUNK);
> +	}
> +
> +	/* We don't want a chunk larger than 10% of writable space */
> +	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
> +			       zone_size),
> +		    min_chunk_size);
> +	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
> +	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
> +}
> +
>   static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>   				 struct alloc_chunk_ctl *ctl)
>   {
> @@ -4919,6 +5019,9 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
>   	case BTRFS_CHUNK_ALLOC_REGULAR:
>   		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
>   		break;
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		init_alloc_chunk_ctl_policy_zoned(fs_devices, ctl);
> +		break;
>   	default:
>   		BUG();
>   	}
> @@ -5045,6 +5148,38 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
>   	return 0;
>   }
>   
> +static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
> +				    struct btrfs_device_info *devices_info)
> +{
> +	u64 zone_size = devices_info[0].dev->zone_info->zone_size;
> +	/* Number of stripes that count for block group size */
> +	int data_stripes;
> +
> +	/*
> +	 * It should hold because:
> +	 *    dev_extent_min == dev_extent_want == zone_size * dev_stripes
> +	 */
> +	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
> +
> +	ctl->stripe_size = zone_size;
> +	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
> +	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
> +
> +	/* stripe_size is fixed in ZONED. Reduce ndevs instead. */
> +	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
> +		ctl->ndevs = div_u64(div_u64(ctl->max_chunk_size * ctl->ncopies,
> +					     ctl->stripe_size) + ctl->nparity,
> +				     ctl->dev_stripes);
> +		ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
> +		data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
> +		ASSERT(ctl->stripe_size * data_stripes <= ctl->max_chunk_size);
> +	}
> +
> +	ctl->chunk_size = ctl->stripe_size * data_stripes;
> +
> +	return 0;
> +}
> +
>   static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>   			      struct alloc_chunk_ctl *ctl,
>   			      struct btrfs_device_info *devices_info)
> @@ -5072,6 +5207,8 @@ static int decide_stripe_size(struct btrfs_fs_devices *fs_devices,
>   	switch (fs_devices->chunk_alloc_policy) {
>   	case BTRFS_CHUNK_ALLOC_REGULAR:
>   		return decide_stripe_size_regular(ctl, devices_info);
> +	case BTRFS_CHUNK_ALLOC_ZONED:
> +		return decide_stripe_size_zoned(ctl, devices_info);
>   	default:
>   		BUG();
>   	}
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 1997a4649a66..98a447badd6a 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -213,6 +213,7 @@ BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
>   
>   enum btrfs_chunk_allocation_policy {
>   	BTRFS_CHUNK_ALLOC_REGULAR,
> +	BTRFS_CHUNK_ALLOC_ZONED,
>   };
>   
>   /*
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index f0af88d497c7..e829fa2df8ac 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1,11 +1,13 @@
>   // SPDX-License-Identifier: GPL-2.0
>   
> +#include <linux/bitops.h>
>   #include <linux/slab.h>
>   #include <linux/blkdev.h>
>   #include "ctree.h"
>   #include "volumes.h"
>   #include "zoned.h"
>   #include "rcu-string.h"
> +#include "disk-io.h"
>   
>   /* Maximum number of zones to report per blkdev_report_zones() call */
>   #define BTRFS_REPORT_NR_ZONES   4096
> @@ -557,6 +559,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   
>   	fs_info->zone_size = zone_size;
>   	fs_info->max_zone_append_size = max_zone_append_size;
> +	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
>   
>   	/*
>   	 * Check mount options here, because we might change fs_info->zoned
> @@ -779,3 +782,144 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
>   				sb_zone << zone_sectors_shift,
>   				zone_sectors * BTRFS_NR_SB_LOG_ZONES, GFP_NOFS);
>   }
> +
> +/*
> + * btrfs_check_allocatable_zones - find allocatable zones within give region
> + * @device:	the device to allocate a region
> + * @hole_start: the position of the hole to allocate the region
> + * @num_bytes:	the size of wanted region
> + * @hole_size:	the size of hole
> + * @return:	position of allocatable zones
> + *
> + * Allocatable region should not contain any superblock locations.
> + */
> +u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
> +				 u64 hole_end, u64 num_bytes)
> +{
> +	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> +	u8 shift = zinfo->zone_size_shift;
> +	u64 nzones = num_bytes >> shift;
> +	u64 pos = hole_start;
> +	u64 begin, end;
> +	bool have_sb;
> +	int i;
> +
> +	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
> +	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
> +
> +	while (pos < hole_end) {
> +		begin = pos >> shift;
> +		end = begin + nzones;
> +
> +		if (end > zinfo->nr_zones)
> +			return hole_end;
> +
> +		/* Check if zones in the region are all empty */
> +		if (btrfs_dev_is_sequential(device, pos) &&
> +		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
> +			pos += zinfo->zone_size;
> +			continue;
> +		}
> +
> +		have_sb = false;
> +		for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> +			u32 sb_zone;
> +			u64 sb_pos;
> +
> +			sb_zone = sb_zone_number(shift, i);
> +			if (!(end <= sb_zone ||
> +			      sb_zone + BTRFS_NR_SB_LOG_ZONES <= begin)) {
> +				have_sb = true;
> +				pos = ((u64)sb_zone + BTRFS_NR_SB_LOG_ZONES) << shift;
> +				break;
> +			}
> +
> +			/*
> +			 * We also need to exclude regular superblock
> +			 * positions
> +			 */
> +			sb_pos = btrfs_sb_offset(i);
> +			if (!(pos + num_bytes <= sb_pos ||
> +			      sb_pos + BTRFS_SUPER_INFO_SIZE <= pos)) {
> +				have_sb = true;
> +				pos = ALIGN(sb_pos + BTRFS_SUPER_INFO_SIZE,
> +					    zinfo->zone_size);
> +				break;
> +			}
> +		}
> +		if (!have_sb)
> +			break;
> +	}
> +
> +	return pos;
> +}
> +
> +int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
> +			    u64 length, u64 *bytes)
> +{
> +	int ret;
> +
> +	*bytes = 0;
> +	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,
> +			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT,
> +			       GFP_NOFS);
> +	if (ret)
> +		return ret;
> +
> +	*bytes = length;
> +	while (length) {
> +		btrfs_dev_set_zone_empty(device, physical);
> +		physical += device->zone_info->zone_size;
> +		length -= device->zone_info->zone_size;
> +	}
> +
> +	return 0;
> +}
> +
> +int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
> +{
> +	struct btrfs_zoned_device_info *zinfo = device->zone_info;
> +	u8 shift = zinfo->zone_size_shift;
> +	unsigned long begin = start >> shift;
> +	unsigned long end = (start + size) >> shift;
> +	u64 pos;
> +	int ret;
> +
> +	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
> +	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
> +
> +	if (end > zinfo->nr_zones)
> +		return -ERANGE;
> +
> +	/* All the zones are conventional */
> +	if (find_next_bit(zinfo->seq_zones, begin, end) == end)
> +		return 0;
> +
> +	/* All the zones are sequential and empty */
> +	if (find_next_zero_bit(zinfo->seq_zones, begin, end) == end &&
> +	    find_next_zero_bit(zinfo->empty_zones, begin, end) == end)
> +		return 0;
> +
> +	for (pos = start; pos < start + size; pos += zinfo->zone_size) {
> +		u64 reset_bytes;
> +
> +		if (!btrfs_dev_is_sequential(device, pos) ||
> +		    btrfs_dev_is_empty_zone(device, pos))
> +			continue;
> +
> +		/* Free regions should be empty */
> +		btrfs_warn_in_rcu(
> +			device->fs_info,
> +			"zoned: resetting device %s (devid %llu) zone %llu for allocation",
> +			rcu_str_deref(device->name), device->devid,
> +			pos >> shift);
> +		WARN_ON_ONCE(1);
> +
> +		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
> +					      &reset_bytes);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 058a57317c05..de5901f5ae66 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -36,6 +36,11 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
>   			  u64 *bytenr_ret);
>   void btrfs_advance_sb_log(struct btrfs_device *device, int mirror);
>   int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror);
> +u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
> +				 u64 hole_end, u64 num_bytes);
> +int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
> +			    u64 length, u64 *bytes);
> +int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
>   #else /* CONFIG_BLK_DEV_ZONED */
>   static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   				     struct blk_zone *zone)
> @@ -92,6 +97,26 @@ static inline int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror
>   	return 0;
>   }
>   
> +static inline u64 btrfs_find_allocatable_zones(struct btrfs_device *device,
> +					       u64 hole_start, u64 hole_end,
> +					       u64 num_bytes)
> +{
> +	return hole_start;
> +}
> +
> +static inline int btrfs_reset_device_zone(struct btrfs_device *device,
> +					  u64 physical, u64 length, u64 *bytes)
> +{
> +	*bytes = 0;
> +	return 0;
> +}
> +
> +static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
> +					   u64 start, u64 size)
> +{
> +	return 0;
> +}
> +
>   #endif
>   
>   static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
> 

