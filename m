Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C927D309894
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 23:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhA3WLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 17:11:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60712 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3WLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 17:11:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10ULuYCG098988;
        Sat, 30 Jan 2021 22:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dgyeZbBhRhGRU+mbpbvRVaOa44fWK9sBFSDXM7DTtjk=;
 b=AuQ/0RUff1TsfnzIOErslKk8Pyri0Bi2HS5RazNzzlVAjrOXTCKplo83SNvUcoT1kgj3
 yXypCvlkDaSUVdZSXD7Fm1mygxoX5orw6lU0iT4H+Ze/F5unyZ7h8FdjbEVXTlubXPOc
 HOYEOwTpiClh9mlQ840DKatdEDe+1lIRzrxcz3nJrJwCt/FmqqFnxhrUrJUrstPYjRqK
 AmG+w3k9k14L3c1ZhMpKVQUEkFl5ky5ATJN83cphowoqNi+d2+LNJvRrqxwnO87yvs1+
 Ok8l+a1J2ViVQVBHxi4YheoGNRWb2FNYFwGrogvm8HwUH+ao+yHioVwLG5eVVG/E+diR EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36cydkh6p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 22:10:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10ULtw5s174684;
        Sat, 30 Jan 2021 22:10:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3020.oracle.com with ESMTP id 36cxsgxkfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 22:10:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbzypU/8LqAx4G259iDfd0YNbit9/s/b+ZcSIJx+vMSAryR2KOeA9/7DASPDr0hhBRnHJ/M4qGObmiOg6bWYyZ4/MnATpFA4CQ8/7WIHwUQY3wabV69xTZ1Arv8qbMnXy9w/XIM5CwdBww1Vo3NaufmwKd9yzn1qbnc+fdWzJh6B89zF3RLlZC8Ws/xlsZbRDAxVYkKu8b6Ur+4Wq9l+qsVQ76HbCIMIosPcJRfXrPhGEa8kaMnUU8zyOqUaT4OE3DqtvD0RyaUR9op19i18d/Kaa12G5iVWuZZeqAW0fvF5HYWGgSATRjD9EU/6539YUdwD/zpNUIOf/fc97mME4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgyeZbBhRhGRU+mbpbvRVaOa44fWK9sBFSDXM7DTtjk=;
 b=cez6WmphL/G4MuxDDqF8UgOcHZh37mtpJTbdM6NsPh974TjmjGc6Kusg0AsXDdvA6N2EUZ0K6bBKCiqpsLF0gg8vvqlKo8sa6O2oU7bvNLbgTCYeEzwlSXcae6+BB5KvNSIhlbU8ydfeyE1X+roXP43nFqB5MdssPv3kDjD64FoZRTH736V4OeFNTikaY658m6/so9S9BQSlCzU7ZgFN5TrZrkrHzb9Lw/w9QwjpLsiEM1Focj7XyseJqD+Kxr9Gt+SJCriRa66UKBOokl3/FUWsrwIYszSGUepXxiemaqpBfneHTL41BI/u+RNlS/5TPSK+JXnHe7jIyr70GCjicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgyeZbBhRhGRU+mbpbvRVaOa44fWK9sBFSDXM7DTtjk=;
 b=JH1d8Eo/n1M3D/dBLi/2+KyJiqebk/zdfOCjmwDn0n5PXqy1Z8/YUI1MUrU1e/6qJZ9c/6WN7ISmpLCnKEINXgeCptvFSPtdQdu0zYKNGmKyT+XG8KOuasSFSnmXx6bYOOWZBnFT97RfDLzaZ5nVWaGECbtCcOcuHRjf4pVpgnU=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (10.172.21.143) by
 BN6PR10MB1985.namprd10.prod.outlook.com (10.175.100.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.22; Sat, 30 Jan 2021 22:10:04 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sat, 30 Jan 2021
 22:10:03 +0000
Subject: Re: [PATCH v14 03/42] btrfs: defer loading zone info after opening
 trees
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <d995c6d145d65b93fc1be56d5c5dfab869f50911.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bfecca45-0a0a-1b00-1e9b-3020577b1f5f@oracle.com>
Date:   Sun, 31 Jan 2021 06:09:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <d995c6d145d65b93fc1be56d5c5dfab869f50911.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:b1e5:e46d:4484:a96c]
X-ClientProxiedBy: SG2PR0302CA0023.apcprd03.prod.outlook.com
 (2603:1096:3:2::33) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:b1e5:e46d:4484:a96c] (2406:3003:2006:2288:b1e5:e46d:4484:a96c) by SG2PR0302CA0023.apcprd03.prod.outlook.com (2603:1096:3:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend Transport; Sat, 30 Jan 2021 22:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec5de452-c2b6-4447-6420-08d8c56bca3c
X-MS-TrafficTypeDiagnostic: BN6PR10MB1985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB1985CC4BDE1A0EB13B2D4B6CE5B89@BN6PR10MB1985.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pILua+uihVnjTJmV0nEDIcO1LMcIpbYYiH0S1pyDaBWls7ARHmlaC9cqyfPW+rYRR0Vb9CX9LIVgemOaNOFWM1L0X0CE2yy71dP4NOp9a2PllWxvYBA/cd2o7NpS6WxfAQstDCeWOtvw7TzTEt8tPgHaVYXiiZys+MeryZ27cBhtBAGrbd9mF9EWwP7e61y+F0Ds/GUJIj+C8BgOZNprEhJk5e3tFFDGil6TrZqcDdsv2ItVXMYcG4eCI7tAhByS+z6Ar1eSO7m6R2nzY6DIU7Do8H5HNLDrlJc8U2jy81BATp8ClwGI3NY6O5KVO3UCeLh9pAo3RYM65Jg9i72X6FqbJQ6hxhsTj7WqSuMTBdlBuRLn6gI9pIpQBZ0y22aHJswkpI/2Z+AJW1EzXzvKYdyJjN6B0w3Jfg0sedqOmEbN3Kyyid+C1n5wwqeI42I+Y3M/IaoehJT+ALWpddNP4zC6NWIWvXaMSplXhV3ixOJwyEWkyv+Hl/Fa/HtygQZOt7NWisHHfOvRy2uZbF8Q/0OnYjNudTWJ6TqAoS6BaJa+TNrWe0ti4Z6zft2m0NqrCAWkt5s/DA+FUok+V3B81Re57OHw4ZE0ObW4MXg19i4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(376002)(136003)(346002)(2906002)(8676002)(16526019)(6666004)(316002)(44832011)(478600001)(66476007)(31686004)(4326008)(66946007)(31696002)(36756003)(2616005)(186003)(8936002)(54906003)(86362001)(83380400001)(5660300002)(6486002)(66556008)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SUhTN3JMcDdEU20vQzFsa2NnYkFjQzQyQ0s4KzF0L0ttbTkzbE5IMVpCb1dU?=
 =?utf-8?B?ZENQUzFxUGJpVGtVQnhMNkpiY29BMHlXajU4SG9HRWl6eDJjS0thajcyMFVZ?=
 =?utf-8?B?TEpNNTRJMGVLSlRkYzcvQTkvMytZbXJhWElpdDZBUDJUOExTRFZjSzVZSDdy?=
 =?utf-8?B?cnhWQ21GR1pMUlpFQXdmZFRyVEV2ai9FcHNsN0FIbHIrbE1Da1czVEl5YVZV?=
 =?utf-8?B?T1d6ZTRIUnk1NmFEblpxNTcrT1lzZmMxY01DK0ZEUkQycTNKK1FwNmgxUTVK?=
 =?utf-8?B?S1RvVFNYdU1ORndtWitLQ0NvV3puWVVvTW5YK2tsdzhlYTVvcWxrNWh0TFg3?=
 =?utf-8?B?aXNJWGNMWDZPQnlLSk9vY3VwOXZKODRTcEpzL2RYVlNnQkw3UklKSmU2ekRI?=
 =?utf-8?B?amEwNm41S0RxcXJtRGJHTEs5K0w0bGNxZVV6YkJrUy9MZWFzRGJjNi9YcTFs?=
 =?utf-8?B?Tzltbm56L2w0MUljT3BtUjgwODZqcFJxcVdlaWhSYzMwd3JLaVBObllScko1?=
 =?utf-8?B?NGdrTmM4TjlmUUNyQ1cxOWkzOGlaVitDSTJtMDdOUHp1Mm1mN0JIdFE3bklt?=
 =?utf-8?B?OHpWbUYvNTZ5Vm5heFR0UFI1Y21kc1A3aTRpNzJZNXBnQklkZXpUd1BEaStG?=
 =?utf-8?B?YWxhYURIVUdySGFzaEhvVFlNQWk0bGZXTWtRcDdRY2QwWnlEcWp0OUlmVTQr?=
 =?utf-8?B?dThLbS9pZGlLVmlLaG1DYUtpNElTdzhTSDlMRGJpTU1hMklFZ2k0MEt2b0N6?=
 =?utf-8?B?N1JxUThSK3NnTWVRbmp0Y3JiQi9mVzMyZzc1YllzMTRkd253ZkNYeTVxTjJl?=
 =?utf-8?B?NUpFMnpncTJCb0RLYUdYeUVhRWQ0QmpQM05ycHQrZld1SFNxRG96dVBuTDJE?=
 =?utf-8?B?QWNKRENITXhjSytLMlY3cFJEYlY1VTNQR1JXSVlJZUxYc005aS9WQ05DeU40?=
 =?utf-8?B?UFYvTHppWmhJMkNFOWZJa28vbVM4a1piTUVFN1NmM0pFL0ZnWUpZcWVKTENG?=
 =?utf-8?B?MFJoa2dZVWxFNnovK3IyYUhsVzdRLzY5bDhoaTIyUjkwaUJDUkFVbWF6ZnJW?=
 =?utf-8?B?SDREM0E5T3ZpeHBqMzhIYXdzQUhqUXFnaWxrVzFBcmN0NUc0TkpxWmlUVVpE?=
 =?utf-8?B?Rk9DM3FsYjFQOVJPVzFiMSs4M1lWS2w0V3d4aDRWZG9tenBWVTRtOW5RdkRj?=
 =?utf-8?B?eTBYVkVaTVl4bW1oMlJoYTVuZUdhamU0RHZUQ1EyQ0tmZnBJelZkTSs0MGdH?=
 =?utf-8?B?UWM3dHhaVC9BbkJKUmI0RzJLNS9jZEtJem1XVUZGcS9GNEIzQkdqUGZOL0ov?=
 =?utf-8?B?ZDRtNTI5M0lFblFnWG9VWXJ1Z1ZNUW9tZkVuOEl6ejkxUm50MGVaNjFvRyt6?=
 =?utf-8?B?WHVRcEtQbnB2Nk5EdFdBT1BFVFVsYXBwWCtLWXlJbE1wOXdtTnVGMGJsdGxI?=
 =?utf-8?B?OUlQOU42ajdJSjhOT1Q4ZTZvTE4ycUo2SkJzM0doZEZad3FyS2prRWZDNE5j?=
 =?utf-8?Q?Tbb2pv1WSuiEOK8BnpI8DeGbYkK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5de452-c2b6-4447-6420-08d8c56bca3c
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 22:10:03.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcH5T38S6wLwDh96Ei4eRScSXV4ymFLcrV30mFuinZ6b8KonIkh9H+FFZ++REPrU1/SjFWSh2rOuzxPfLtqpRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1985
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300120
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300120
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> This is preparation patch to implement zone emulation on a regular device.
> 
> To emulate zoned mode on a regular (non-zoned) device, we need to decide an
> emulating zone size. Instead of making it compile-time static value, we'll
> make it configurable at mkfs time. Since we have one zone == one device
> extent restriction, we can determine the emulated zone size from the size
> of a device extent. We can extend btrfs_get_dev_zone_info() to show a
> regular device filled with conventional zones once the zone size is
> decided.
> 
> The current call site of btrfs_get_dev_zone_info() during the mount process
> is earlier than reading the trees, so we can't slice a regular device to
> conventional zones. This patch defers the loading of zone info to
> open_ctree() to load the emulated zone size from a device extent.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>


Patches are already in for-next. My apologies for the delay in review 
here and in the following patches how many ever I could.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/disk-io.c | 13 +++++++++++++
>   fs/btrfs/volumes.c |  4 ----
>   fs/btrfs/zoned.c   | 24 ++++++++++++++++++++++++
>   fs/btrfs/zoned.h   |  7 +++++++
>   4 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5473bed6a7e8..39cbe10a81b6 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3257,6 +3257,19 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	if (ret)
>   		goto fail_tree_roots;
>   
> +	/*
> +	 * Get zone type information of zoned block devices. This will also
> +	 * handle emulation of the zoned mode for btrfs if a regular device has
> +	 * the zoned incompat feature flag set.
> +	 */
> +	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
> +	if (ret) {
> +		btrfs_err(fs_info,
> +			  "failed to read device zone info: %d",
> +			  ret);
> +		goto fail_block_groups;
> +	}
> +
>   	/*
>   	 * If we have a uuid root and we're not being told to rescan we need to
>   	 * check the generation here so we can set the
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index badb972919eb..bb3f341f6a22 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -669,10 +669,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>   	device->mode = flags;
>   
> -	ret = btrfs_get_dev_zone_info(device);
> -	if (ret != 0)
> -		goto error_free_page;
> -
>   	fs_devices->open_devices++;
>   	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>   	    device->devid != BTRFS_DEV_REPLACE_DEVID) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index c38846659019..bcabdb2c97f1 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -143,6 +143,30 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>   	return 0;
>   }
>   
> +int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> +	struct btrfs_device *device;
> +	int ret = 0;
> +
> +	if (!btrfs_fs_incompat(fs_info, ZONED))
> +		return 0;
> +
> +	mutex_lock(&fs_devices->device_list_mutex);
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		/* We can skip reading of zone info for missing devices */
> +		if (!device->bdev)
> +			continue;
> +
> +		ret = btrfs_get_dev_zone_info(device);
> +		if (ret)
> +			break;
> +	}
> +	mutex_unlock(&fs_devices->device_list_mutex);
> +
> +	return ret;
> +}
> +
>   int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   {
>   	struct btrfs_zoned_device_info *zone_info = NULL;
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 8abe2f83272b..5e0e7de84a82 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -25,6 +25,7 @@ struct btrfs_zoned_device_info {
>   #ifdef CONFIG_BLK_DEV_ZONED
>   int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   		       struct blk_zone *zone);
> +int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
>   int btrfs_get_dev_zone_info(struct btrfs_device *device);
>   void btrfs_destroy_dev_zone_info(struct btrfs_device *device);
>   int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
> @@ -42,6 +43,12 @@ static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
>   	return 0;
>   }
>   
> +static inline int btrfs_get_dev_zone_info_all_devices(
> +	struct btrfs_fs_info *fs_info)
> +{
> +	return 0;
> +}
> +
>   static inline int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   {
>   	return 0;
> 

