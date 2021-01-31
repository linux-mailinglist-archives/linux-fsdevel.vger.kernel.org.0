Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29534309C81
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhAaN50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 08:57:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39502 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhAaMcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:32:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VCUtgd090965;
        Sun, 31 Jan 2021 12:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ckdP5FPM6kZc13GSG9cQLa3WNAz+x6gx4mBrl4F86Hg=;
 b=IMRt298gkek4/Ff022WPXSUsZbSL/hXKKcJUrnqp7XX7ewrif67PRagWB1+At/JWrZYz
 KPZIY6gJ64aROGhDb/WBSIjxvM8t9FrIYNxjBmrTwP/wS6L9dfpurFU35Luk29DydTii
 tXXPe6/dSnupSvCepRiN7/8jslXuuMyDNrDETDWYK4jXhEP6Q0j0Bll1nY3g7w4Ld4kN
 rvIzT1OUGnChDOmFfRTav1i7MockeWIOJhmA35ckAdMIz7RzglzjYYLVAiwFD35WSrfI
 PQgRHhKprOvzVv7tCqcKWRWf2drCmCKvXESRBNTj/2O6QusPkEzoHPUtl4dclcmzLUDq 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36cxvqt9mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 12:30:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10VCLDo3115840;
        Sun, 31 Jan 2021 12:28:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 36dhbvkm9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 12:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxWDyi4V3MO6WQaDmu8tnBZiI2S8FT5Y/EK+PQHufdtg/wk7hfJaFrnt+3oKy1m+lslw6QM0BrAYGfbf+fy3IMFboyLCX8RQl20wbISvRyFg4Hp8stxvz2UMDpbBc0PPgXbBEzH3p09AzprdtgGV+UJ+g0wcbF8hYjal/GXy1e68oNK6me46D0NEG0k9JlHZ9lUlCLgrRAlBy1NhdcEoI5ptrBqqip/fVasKaMR3uhhmtSGHNFuZhrTzXxvVvP2VzBLRDutrbJ3A5BE1dP7QdSUtrscoN9pSNMz+XiDLAy8YtRhEoAXWQB0R4F3WwiSPM49YE/rfpVjfv30xoWJTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckdP5FPM6kZc13GSG9cQLa3WNAz+x6gx4mBrl4F86Hg=;
 b=HKbrn5IfteBMU5tT2TomiWgbXkKRbepp4rskbU/CiolFEpaHd0Nabq50I0Wo1m07Fb3Dg3T5W4wIniueBMDl68IO9YE6A+Wnm29PjIh7Y/Z3UaEF30upPvMaOV7LDjEOLu7Cicn5efQ3b3XKmav/Ti6o7lIKRWO3GixJ9GoWY5Zkz3dmPcl1qyXxrBNv7J+Mi2yN8vd8TIv4qC6ZnzH/f5nwgggjiJLzE49h8LIaK+e8nrk/BYCNVOEaKqllRVye6exq6G2wmA2bRSbbaH2z5iYQZKKwN10DhIWZrHjR48X6xP3AWioFgFBrWcPpuUoUpXzkeCVpFSSO/0++q8jZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckdP5FPM6kZc13GSG9cQLa3WNAz+x6gx4mBrl4F86Hg=;
 b=p5cn6ipDI8/PyvGSPH97Qy9VJr+3iPID1xk98zJ9BTRgHP3INMlA0WMepKJyEApKKZ0BXiLAPs1dOkS54RhSNNyIC9DLl3lsNT3q/W/AGdIDL20i9+tRoOwDtdet9pWZ8eQoXYaxhlSid+DRLDHWDZToDaVx2A2UI+w3UuEN99U=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3700.namprd10.prod.outlook.com (2603:10b6:408:bc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Sun, 31 Jan
 2021 12:28:56 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 12:28:56 +0000
Subject: Re: [PATCH v14 18/42] btrfs: reset zones of unused block groups
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <10c505102feb1c7bd352057ed528b1a04b36bb57.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <7200eeda-5e4f-0634-620b-3faa91b77a90@oracle.com>
Date:   Sun, 31 Jan 2021 20:28:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <10c505102feb1c7bd352057ed528b1a04b36bb57.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:c074:cdb6:65f3:80b1]
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:c074:cdb6:65f3:80b1] (2406:3003:2006:2288:c074:cdb6:65f3:80b1) by SG2PR06CA0221.apcprd06.prod.outlook.com (2603:1096:4:68::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sun, 31 Jan 2021 12:28:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40add79a-b680-4954-ee8f-08d8c5e3c73f
X-MS-TrafficTypeDiagnostic: BN8PR10MB3700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB37002832D01C6E558B13B697E5B79@BN8PR10MB3700.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nEqJ+nYwnI0zc8PI6cSifsQrNfaZRo3IiTlxgFQqjmgH7SXwz+zviGF4lq4U1RlUGVgey5bNZaQD5ZEwh8tYI04VxPt9FY0WeiAjiDcMKtACm4alk/CcmebG0oDH2+a+VGjEnoziwJ5HC9+51wQLn4YQNWtwkXngB25g0E5fqqyIbqOikzCL2dNYlsdhZ4Nz5NuwwWuaCm0bZCqh43/oecVJ7dIsKk2cVtD9QfATFNdw3A7S9qnRgqZMlATXWrAbyvYo5MPIeENDI3NFInPlC5e/yvzAeT6LyZ6O4MVCbis40BBDB+swvYvmDYwv5Y/ArWH0+c8QJO2nHQBFYp/YoJcpgNRgllJ0ZTWHNh1+mx8ay8/gU5iB6jjft90JALjcTtYt9qPkIZp83xULupIrCP2bCVhyLi8xdRmyQGLkAOYamZc5NVV2dupCWnr7lblPUU1KtoazjAba0mudTKiRAo6Y87+ngv1utliB2kCIW0VuokpJ/knKZSFpmub6LOuqQ2hhARGOGmAZ0rWEIaAEhCuMB6O8sRU5SVRrB+7KK95An749xoFaBUkRbF5xusVRg60yBvxtOw+vz7vUXMJZGsyk1NgxLzoMxzOSQNzLF64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(478600001)(4326008)(66476007)(36756003)(316002)(31686004)(66556008)(86362001)(16526019)(6666004)(2906002)(8676002)(83380400001)(31696002)(2616005)(66946007)(186003)(44832011)(6486002)(5660300002)(8936002)(54906003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RnZyU1pyYm9hQWY4ZitMQkx5M2pxQkpNVWNzaFZ5aEh0MzBnK0ZSMlJZZ0lr?=
 =?utf-8?B?NmFGTU9tQ0hYdzVvN3RqT2h6TkEzWlkyUkNtVjI0dFNaN2J4ZTRxUkx0YjRq?=
 =?utf-8?B?Q29Nc29pb2d5b2tqejMwRmNpcVY4d3FkUmRsd1MzWmh0bTlCVkVsdU9rVTFx?=
 =?utf-8?B?YTBXU0xNMy9QNGdCTVdqREJPdFdrZFhIMU9GRHVRRkVlSVdpcVgxQW56MTRn?=
 =?utf-8?B?NVFWSUdTV3pWWWRuVmxGVzJBRDF2YXh5amFXU002bmkrWlRlN3pQVDd0RFpw?=
 =?utf-8?B?V0RUQXJrbzM1ajltaHVuVXg0REV3UXRWVFJ0MEV3bVpxN1JiM1RIYXNCNHVQ?=
 =?utf-8?B?QzY4MUwyVVEzVS9XaW93ekdIWURrL3I5L1JMS1l5Z21hQ1JrK1dtekxEeTlq?=
 =?utf-8?B?THBuc2JreXpwQUNHZlE4dTFweitJZXQ2WHR3dzhocHlnUFB0dXAvem4wMmZQ?=
 =?utf-8?B?SnFadU9aclpCMUtFYU1tclhBMTJLM0liU2V0dC9tUFcvRlVYR2g4emU5Ly9i?=
 =?utf-8?B?bCtIOHFsZ0RlRUs2cWNGVTd5L3BHWXhpLzFFWC92cGJRK2J0TTVGb2RmWkl6?=
 =?utf-8?B?MXdQTmw5SnJCVjVtTWV5cVNEL2wwM253bng4cG55L0lFbWZUejQ4YS9YRHZY?=
 =?utf-8?B?Q1YzdmR6bU54NmRudktEelhteElBYTFuSDRWSm5mUFVCMnBuNldXK2orT2JF?=
 =?utf-8?B?bTlyQ0ZSejFoTlRZa0xOSW9zWHlkTUdNOGVVYk9UUDNwMEpwK1hkaFBsMDND?=
 =?utf-8?B?UDIza2RBQWlxcnRWTmJSdURaQU1pVkRKVXBJMWZwMUhMK3UvWmZVUVJVUEVs?=
 =?utf-8?B?Nld6SnNMSzNxa3ZFa2NWV3BpbDR3bFJST0taSHp2YS9LSWhIMVlVR2RuTkZG?=
 =?utf-8?B?cUJvaVFYMllvMmJhcGRLeDA4UzVSVlkwQUV5ZmpqTGZNNno2TkNvYUFNV2oz?=
 =?utf-8?B?eFVpR3NDUWhsWEsvbXM5NzkvMUkxKzROWXZ4TTR4UVJSbzlXUzV3WUd6OGF5?=
 =?utf-8?B?Z0ZUSTBRaUJHeTJCZGxRU2F5VnloSS91TzdQdnhHOEJlZHpxVzVwVC9aeDR2?=
 =?utf-8?B?d3kwMC9RSUs4U1lOOGNVQVJVYkRrNURYQTlhYnZ5Sk1UK0lsNHV2TmwyMURp?=
 =?utf-8?B?SmNSMEJZZ2lsVUhzcE5YUWhZZnJPY2ozdW93MkpTY1ZMcWJrVzcxdGprc1BW?=
 =?utf-8?B?M0UvbGdCNlR4NWlpODFpWjlvY2doR0ZrN0NxRGVuR1lmbUc1NmFHOFk5WHVB?=
 =?utf-8?B?VGpkM1lwMXJ5RGRsSUh2Mmw3UjBRUmRKVHV3NU5rUkkzUHlydVJ2N01pQlVx?=
 =?utf-8?B?OEIyYXVzUFJ0bjd4Y2pEYWhEeFhiL2FmK0RvN2xBUEs4L1BRQnV5SzZqdml2?=
 =?utf-8?B?ZFdDV2cxMWhOSVNjS3ZhaUtqbXZlN0xabXhYb0JZSmZJTndqWXU1eHphYWpY?=
 =?utf-8?B?Q0pwczBMa1VWUnkyV0Zob1JQWEZudSt6cXg4cktjbDBrSHRBZ3dxYm1YUU9V?=
 =?utf-8?Q?F0oI6f+TyrCgZ6NjJg0ZX3aUnMg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40add79a-b680-4954-ee8f-08d8c5e3c73f
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2021 12:28:56.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNxQcsMjOucEOAUAth96QseGZbUyCRF2G/87UJ0zgOjAqletAoWA9HDlk4YDwx90OYQUzrlmNvpwuFiGDd+ILw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3700
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310067
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310068
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> For an ZONED volume, a block group maps to a zone of the device. For
> deleted unused block groups, the zone of the block group can be reset to
> rewind the zone write pointer at the start of the zone.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


> ---
>   fs/btrfs/block-group.c |  8 ++++++--
>   fs/btrfs/extent-tree.c | 17 ++++++++++++-----
>   fs/btrfs/zoned.h       | 16 ++++++++++++++++
>   3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index f38817a82901..9801df6cbfd8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1403,8 +1403,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>   		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
>   			goto flip_async;
>   
> -		/* DISCARD can flip during remount */
> -		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
> +		/*
> +		 * DISCARD can flip during remount. In ZONED mode, we need
> +		 * to reset sequential required zones.
> +		 */
> +		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> +				btrfs_is_zoned(fs_info);
>   
>   		/* Implicit trim during transaction commit. */
>   		if (trimming)
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 36a105697781..4c126e4ada27 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1298,6 +1298,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>   
>   		stripe = bbio->stripes;
>   		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
> +			struct btrfs_device *dev = stripe->dev;
> +			u64 physical = stripe->physical;
> +			u64 length = stripe->length;
>   			u64 bytes;
>   			struct request_queue *req_q;
>   
> @@ -1305,14 +1308,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
>   				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
>   				continue;
>   			}
> +
>   			req_q = bdev_get_queue(stripe->dev->bdev);
> -			if (!blk_queue_discard(req_q))
> +			/* Zone reset in ZONED mode */
> +			if (btrfs_can_zone_reset(dev, physical, length))
> +				ret = btrfs_reset_device_zone(dev, physical,
> +							      length, &bytes);
> +			else if (blk_queue_discard(req_q))
> +				ret = btrfs_issue_discard(dev->bdev, physical,
> +							  length, &bytes);
> +			else
>   				continue;
>   
> -			ret = btrfs_issue_discard(stripe->dev->bdev,
> -						  stripe->physical,
> -						  stripe->length,
> -						  &bytes);
>   			if (!ret) {
>   				discarded_bytes += bytes;
>   			} else if (ret != -EOPNOTSUPP) {
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index b2ce16de0c22..331951978487 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -210,4 +210,20 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 p
>   	return device->zone_info == NULL || !btrfs_dev_is_sequential(device, pos);
>   }
>   
> +static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
> +					u64 physical, u64 length)
> +{
> +	u64 zone_size;
> +
> +	if (!btrfs_dev_is_sequential(device, physical))
> +		return false;
> +
> +	zone_size = device->zone_info->zone_size;
> +	if (!IS_ALIGNED(physical, zone_size) ||
> +	    !IS_ALIGNED(length, zone_size))
> +		return false;
> +
> +	return true;
> +}
> +
>   #endif
> 

