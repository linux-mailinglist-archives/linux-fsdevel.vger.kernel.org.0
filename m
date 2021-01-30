Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46723098D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 00:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhA3Xn3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 18:43:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3Xn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:43:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UNYbDS123378;
        Sat, 30 Jan 2021 23:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AAN/Ple5uEyn8ro1S7CQzPrctavhTYsHTd3jyhcDQbc=;
 b=LqW8nXOLg29JOMixijp+OjsFyqcJTKHIE/sytOlof0VuuLZpT1CpcUOoEN4YbuN6x4qj
 NezIG9yeLW6Pk7wjgMqFaoy3qu8rLKFLaIlVONjKbK5gNElZIW027YVX0mAa4wJtV9JA
 CNlEqC2QKAjHUyH//vGm78g3ZbdPmz/ZE+I5CQavS1bH7BTM4z/En+cFk6oPpxbE9I5n
 Z69LaXlreuecuD8ZFHa9m6Iz9xqzZ2cW6jpiZBaw+vnPdptu9rn/zS+MW74fkmkLVJWe
 RNGl3NNxtF8LpFHfrymcx4SZabQ00TyVqU1EGgfD0H121YWFf/MYvRlfUWsMsalBfplH PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvqs9b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 23:42:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UNeMkK077228;
        Sat, 30 Jan 2021 23:40:36 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        by userp3030.oracle.com with ESMTP id 36cvjs39d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 23:40:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSZ3mIePX+cwWyRoWco3/VX8OyRTsV6gWOIfFcn+Fp9bRQaENGFpvJDRY18iUKBeoTVJWMTSKjy3PXzSDl4v90vwTeBiBkyMpI5fKUkLl1bNlyMnq56uvDwBAEtr4TBdAULDEeQbG/aFcF5DHWe+BK+RBj5E2WEfvK7HsG5LZOFx6RM9NotHcfTdIIb0L+mkDX/YNDU9zS80nbHfsdU178eqkiG3mbnJHMExYKHStfCkoCAiVN7sDqQD8PPTGvxVfP4hYcAXBytvM2WIKwRzB4D4hF9ukBZ+fcy6Vq1/vxg7eOjQecD8wkrCAc81SoR7Q/dVsY4nZopEd+WhdhOalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAN/Ple5uEyn8ro1S7CQzPrctavhTYsHTd3jyhcDQbc=;
 b=AQflZ4xPciGEuLQNQfo4bMRbleouJpEPgNmPXeQRKwxA/9qbeiXyWno/rQHr9iYAUabjkqUqCGXL88BmyE0cktvIS0YOHHxgNrFDbizZ9U8w7HEdF7NEODIKQcC4aNiROhYldaNf8spMORiF58zNwJaH5BLlZ5OzM6Jz6GXHLxQToctFESmafqg3b+vI8AvHkFE4YKLS5M3FAovTN3B/wp3eM+LoObGRYpDaC2pOIxp+cSTmPCAb+StgovaBKUbkrzVXmmxSsKISQpDDEyDsiWCuVgaKwI3mlDl+2lVneqJ3O4EZkgCERDj/ePQ0ft/KTYsOUTANiPPCxytGUd5sJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAN/Ple5uEyn8ro1S7CQzPrctavhTYsHTd3jyhcDQbc=;
 b=qrQ742VjjSaClfJfg5cD0tZao8a+/w5OghCDG9YdsgU9qiAkf9JHb/iCwaW2ayoN+/b/kvoMlVuFYeYis/Ql2DUL04nMFAGbExkLaSwEGlCNf7XvjG+prgD7ohkE7LXdtNNX2ocxUot0Tf6kEi95IRxzYZ2Oji/vbQ3yXl+qf+8=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (10.172.21.143) by
 BN6PR10MB1506.namprd10.prod.outlook.com (10.173.30.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.15; Sat, 30 Jan 2021 23:40:34 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sat, 30 Jan 2021
 23:40:34 +0000
Subject: Re: [PATCH v14 06/42] btrfs: do not load fs_info->zoned from incompat
 flag
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <a5df66e698c59ab058cece26456520d882d2f4be.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <4839db8c-a4b5-3a84-ba5e-52f54ae73781@oracle.com>
Date:   Sun, 31 Jan 2021 07:40:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <a5df66e698c59ab058cece26456520d882d2f4be.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:b1e5:e46d:4484:a96c]
X-ClientProxiedBy: SG2PR02CA0079.apcprd02.prod.outlook.com
 (2603:1096:4:90::19) To BN6PR10MB1683.namprd10.prod.outlook.com
 (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:b1e5:e46d:4484:a96c] (2406:3003:2006:2288:b1e5:e46d:4484:a96c) by SG2PR02CA0079.apcprd02.prod.outlook.com (2603:1096:4:90::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 23:40:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaad3f50-095d-4959-3332-08d8c5787010
X-MS-TrafficTypeDiagnostic: BN6PR10MB1506:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB15069DD772B226CDF1F31602E5B89@BN6PR10MB1506.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/VjdV8tg/Gpt2KAo/m/cxO/xqZtih1lbiBd767VwQVWENOMdtx+FNjHa9SG4N6HJCu71LhNLT7DkMEq063BNlYtRHA1V8BQjRfbAQ3WZc2NHqQKWNpT+uStdbW5SU5G5a8WSTl8Ni6Z74ukbUpU4azK91CxvNnOPMuuIZqN2ujKuh4ceJy41C0kggFifE64iahOwF7jCyB21toBGBuInnIblmv66GWOAhawOXQJmq/IJPyCJNp2t/1RN3gh9T1NYO5Ar9gsJ3UOs/OSQ+L22NKZxS2oVDPwijAFq0BMbzLL9IrF1Bdd4Hyfd4p9NDIPRSwWa+VLN8iunjeWngdxUddyUqtJ/M0F+t0D4GUA3Cxu0GIhPtMdClCVbFsEXJSYuC2OPhfVSqT/SXrnrpn5y0AOrz525OrwvYS6O4YpJvOQqAKJtJ2huxA9wXSWVAQVGIMFumS8f9g2mrdz3SXB2u6PObo4DVAxzb0iEHEUfmvLCN5E/+D2P1A1+9uAPWnkMfK0kKPZVXhj5iNHlBtLWt1nM5pECSLVb4qHbM+kI2FXecteYXJoKW/j+0sqjSO7/zrotNEKcis/GVN+05rUgn63h5HpWnxxUsYxn8XnQNs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(5660300002)(86362001)(6486002)(186003)(54906003)(8936002)(316002)(83380400001)(2616005)(16526019)(44832011)(31686004)(31696002)(36756003)(6666004)(8676002)(66946007)(53546011)(66476007)(478600001)(4326008)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?N3NpNTljMGo5dW5iWXdZYXdXY0YzNHZtKzhhQk5WL2FXWTdtNnlKSlBaSmt5?=
 =?utf-8?B?QlB1NWxqMVVYOVNqbFJ0M3AvTWRkYkZCb2NrbFA3Ym9rb2dKdVA3K09Zdlcr?=
 =?utf-8?B?Ylljb29TVnJMWTVoSVRUQjhmbTEvMlkwQmhzRFJBTGRwem9IakN3TnpHVHFF?=
 =?utf-8?B?QlFYSDg4NEdPVWVjVkJtNm45czdxY1ZQTkYzWHZ4QTFvc1ZzRG5SUDVuVGdr?=
 =?utf-8?B?aTBNWDNWRTBKdEdUbTVlR09WN2ZGVTlXVEVDeE1Va3I4V2JBd1c0aG10c3dt?=
 =?utf-8?B?djVTSngyTWUvdEluTzB3cjJSNmJBTlJsZGxsQXdReUp2enBObytlWFhLMjJ6?=
 =?utf-8?B?RmE1M1QyRDEvcWgrb3lmY3ZORW1FbE1CQVdZS3FQbzZqRFo1VXpqaHJDVEdN?=
 =?utf-8?B?YjhaRXN2U0E3TC9OQmJkY0orWUNtSHJEUTNjTzNwY0RYa2JRODQ5M0o5VFZD?=
 =?utf-8?B?L1pMMVZMSGxhSkhOS3dTclRtbnR2YmM2TDA2OFltQnVYQ2d4anlMV3JsVWRj?=
 =?utf-8?B?aitnQ0k1WC9ZNnJ0cU1LOGl5c0VkVkVUVWZteVdHZk5DMmJ0TGJCMTFSOEVp?=
 =?utf-8?B?clZJckVzYVJ6NlgwTHc0eG1xK01aZnN4WlpjWUFoZUlRNm9QM09RWFdLZ3dQ?=
 =?utf-8?B?OEpNWHUvZkplM3ExbzBxU0pXb1FRN21rem8yWVBFSElLQzQwMXRyN2cwbkZK?=
 =?utf-8?B?c0pSU1JVNU5GNDZlWEh2YkVtbUJaTGVZVFI5eXArSEZkcUQxWXRBRjBEb3JJ?=
 =?utf-8?B?S1RFemhYL1MvRkVHbkZWVVZQZFo1S3U3RDh1cXBqOTZEZTc5MThyR3VkZ2Mv?=
 =?utf-8?B?OHlzODVZM21BMGVRTGNYN0ZHdXNFdUIzc1liT2hXWlkxOFVJbGtEdjlFQnpo?=
 =?utf-8?B?bHE5KzJhZTlscjZ5eUZlWWcwTTlGanpzWkl2aVFCVnpxZEh6Nm43Q1lmbDJo?=
 =?utf-8?B?Tnd2dkZrdmJSUUIwVDR3MmtFNmo1ZVlRdEVIQTBGb3ZDNDBmY1hJNWlEVlBR?=
 =?utf-8?B?cEk3cUxEUTFtaXVQU2ZkN3I2b3k1Q1pDdFYyZXA1TXNBSnlMSXh4ZFp4c0JR?=
 =?utf-8?B?T29OUE12QitLZlB6L3FXbHUrN0haV05HRDBGQ3ZJcDhaTmJLZko0TWZhYXpM?=
 =?utf-8?B?K2lZMzBwYXphQUNMS3RPSGkrWDRnT0tWNThYd2JSTzVzWS8wSmFRc3dndXJE?=
 =?utf-8?B?NlpadHdGY0NJUW1CWUhEUnlUeGJWTW92RFpUN3ArV0s2NlpuZ0dNMXVDK2c2?=
 =?utf-8?B?Ulg1NFpmUWltV0VzSkcyei9IVXNpY3ozbEZJSlppOGdnRXVLTks1cDBBZ0Nq?=
 =?utf-8?B?bkJVUnRZTHVXY21ybHE2Vm9jZkZKUmo1cnZrY2k4MFJqN0l6UFpWRHVtOE5s?=
 =?utf-8?B?bTJWcnVyMnhZZ3hKd25rTnRaSFpaTjdmS2w5cVc2dGNxT1RieXE4Zk80TUt2?=
 =?utf-8?B?OFFkcXJCaU5IOGs4VWYrYi9hZzZFbFArclpBT2ZPZHdja3RoRzZvZHBWekZt?=
 =?utf-8?Q?6RIjX10Ggas4LrHVLddSJcF7szm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaad3f50-095d-4959-3332-08d8c5787010
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 23:40:34.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmSHI8bPxvqYiecicS1MmeYF+4ufFzx4IzhZjLKr+3px2ACP15EqGkI4h9Fsjbma8MijWdBBVV/bgC56S3hz2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1506
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101300130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Don't set the zoned flag in fs_info when encountering the
> BTRFS_FEATURE_INCOMPAT_ZONED on mount. The zoned flag in fs_info is in a
> union together with the zone_size, so setting it too early will result in
> setting an incorrect zone_size as well.
> 
> Once the correct zone_size is read from the device, we can rely on the
> zoned flag in fs_info as well to determine if the filesystem is running in
> zoned mode.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>


  Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.

> ---
>   fs/btrfs/disk-io.c | 2 --
>   fs/btrfs/zoned.c   | 8 ++++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 39cbe10a81b6..76ab86dacc8d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3136,8 +3136,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>   	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
>   		btrfs_info(fs_info, "has skinny extents");
>   
> -	fs_info->zoned = (features & BTRFS_FEATURE_INCOMPAT_ZONED);
> -
>   	/*
>   	 * flag our filesystem as having big metadata blocks if
>   	 * they are bigger than the page size
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 87172ce7173b..315cd5189781 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -431,6 +431,14 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	fs_info->zone_size = zone_size;
>   	fs_info->max_zone_append_size = max_zone_append_size;
>   
> +	/*
> +	 * Check mount options here, because we might change fs_info->zoned
> +	 * from fs_info->zone_size.
> +	 */
> +	ret = btrfs_check_mountopts_zoned(fs_info);
> +	if (ret)
> +		goto out;
> +
>   	btrfs_info(fs_info, "zoned mode enabled with zone size %llu", zone_size);
>   out:
>   	return ret;
> 

