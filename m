Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01F23098A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 23:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhA3W3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 17:29:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43230 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3W3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 17:29:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UMSqM9167184;
        Sat, 30 Jan 2021 22:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9zQFq3aTB/IBzPPOQixYdBGpe6lj/1SyZYyptnLCvmA=;
 b=f9QndScPNqMPXKO2r4tvNa5PGgUTJPiT3gwNYvNJS7/QF9gBNGWeea1tpKZ5vz09zH8J
 kCDZqrjla60yykpQNHWZpEh01mhF9zhnJp4/15noFnEeXFWiKWG1gH8L8qfa7igj19/s
 jIpOdBDjmkygK9hLzdXCeWL3A/3lV6If3hYM9VxxgEhvjGCxc7m5TN4w0y8w78gjVuiW
 7fs1YZ+Ib61ZUChYLT1B/ddWahQBDwjlF+R4a07QormRez1GyjL7vUoWfMBDnQAnAuQy
 3MbecFv7RcVgTVoHLYMiKsAqnYvSFflAYEe8o6QNOTrakin2tETkPj0S84bYkmNZ2hU/ pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydkh70g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 22:29:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UMOjlp178250;
        Sat, 30 Jan 2021 22:29:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 36cy903v6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 22:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijpHp8K45TBmzRMoDk1MtZLn6cfzn3wHBKaSNODoOkrvuDCbER4Ts2cR2BQdeSsyIpDsMExetuv7/0YZqq8NlVpC3mcrrjFIZ92BjI20EfbZWw8nYnuHySNwITtYDBR0ASYP+T+t3mRWxQoYthOe+WwSMorAINdZSktklDPo7d/gm9Bf0uhl1C6qUGiaj4peOAnSxwx4ElQ64je/uc8cOwE9VBr+sd8Mryf/kqfjHxLZ1d77pIe3HuvmTNMcVPI1ft3Z6qWi3JysRNhKovaZMq9MMG4BXYxu53DUoVNnHg54q3kV3gQN+Yx3NToCJyh10vQhsSiXhjwrOxmn5gqPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zQFq3aTB/IBzPPOQixYdBGpe6lj/1SyZYyptnLCvmA=;
 b=QkgCh3FStayAr2gndNMPF29XBNqVgxONjPZhLxPOAhSzTUVDqfPO3lwr9pbvfLpbXPHrfincUuVnFOhODWsHeHP8qqNoGEeQIjThiGd+iVPc+9GNTc0e0bPTYclDJz8pk/Z/nbdDjzeJoR4yMGaM7dq81GKtjGBWkqbbE+H/7kdNlDtvb72fXH4BwZp9DIOR9cPv7CbUGV4aqHxTNGub5YaUIuSTNjxq/yfBM595tMpCM4Jkrcv/hw2k5iIN0uU+xfYCtz9JFFoOmqwETu4Sx3X6hUzVwEca1DVNZkiNb/nnu+0eBHcFqzm8hfS/LdPxPAz8TJ7Usl1v1Br35yV0NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zQFq3aTB/IBzPPOQixYdBGpe6lj/1SyZYyptnLCvmA=;
 b=NdDIFqQ8fM1Tmc3ywbTWqINLOChbdr0oHcmRR50Lnz6NPsssDm5IEsugHglxaN5DCn4liKzZZ2lZf0O4AE36vKX0mXmDKMTVVzA1aLDdKT89jer9QeewO/+z4vY3KErsVlqODez53WgXb7FWleIGB+DuMIrHg8XbkYBXAE6FBew=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3555.namprd10.prod.outlook.com (2603:10b6:408:bc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Sat, 30 Jan
 2021 22:28:59 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sat, 30 Jan 2021
 22:28:59 +0000
Subject: Re: [PATCH v14 04/42] btrfs: use regular SB location on emulated
 zoned mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <e819daceaa2d00bc95df81a020432a746cf1c6e0.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <6fbccd85-2c76-89c6-83d1-47276fb650c6@oracle.com>
Date:   Sun, 31 Jan 2021 06:28:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <e819daceaa2d00bc95df81a020432a746cf1c6e0.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:b1e5:e46d:4484:a96c]
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:b1e5:e46d:4484:a96c] (2406:3003:2006:2288:b1e5:e46d:4484:a96c) by SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.1 via Frontend Transport; Sat, 30 Jan 2021 22:28:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 400b7c05-e9f7-40e1-b772-08d8c56e7042
X-MS-TrafficTypeDiagnostic: BN8PR10MB3555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB3555DD1334367000A9003BBCE5B89@BN8PR10MB3555.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arhWBgXFdIixtLmJuAsYwRwHwX1ZmY8OPpxsVWmS8L3qeBvwifFnqUm2NtqXDG04RBzYGgJ3iB2effzdzRoNkYlITWcHjEOVhhVqW9iTRy1hRa5HVpCTpx4fiVWPeDehKvPeBr9YGq7id4jhIndwjJDcgt+txwlh93OnCuZLQAGe8aSQVKsLvu0wAcqce8tOMW+5P7phE5NAfpbpVPQO0PXQRrwYns9/94Z5AVuPd4wklobRwYeWOy2KUUFFcKPpvSgbB0YQfOUGM87cUtgqtrquAcqVATfB8HHS18XKJPSI2++tmMigvSObQRqdb7w51e896Fcx6soU24FwCVWag5jdJuvA3qEfu5Uti/j4DWgnrTpE0mR3/r1vURLh9bedyoE5vmcYpkJGw3XFnSHU+380ULXMxOR8QRh+ASUrkgh6eQwwIghLN+ZQo5R9aHuF5+m2h2YxtcNqIsROEveoMtGTwxRHE9Om2yQhVqVgjxPYMybHF/K2I9ds5b6v+wqV1v2hwWINAhtC1ksow+2OoZ6xfQAY4tBW9IrfLcLU9m+ipMFDGfDXK0xNOEnLBEb481u6KQKhW691NZjUg1V3Jpbi1yJg135Xo5cJly623Xg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(346002)(136003)(396003)(376002)(83380400001)(6486002)(54906003)(186003)(31686004)(8676002)(6666004)(2906002)(4326008)(36756003)(16526019)(31696002)(44832011)(316002)(8936002)(478600001)(53546011)(86362001)(66946007)(2616005)(66476007)(5660300002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUFmc2VVS1A3SjhCNXUraDRhWisxeVVscFZpMmVxb0JWOWE0ZFVMYlNCSXk4?=
 =?utf-8?B?a0FDZHdoUExZTXNTVWkxcERyYm55MG91bjEwUlVIZ2tCTThVOUNuekRQZ0tP?=
 =?utf-8?B?Y2dLTFEydHJLYTBrK3IrTUllOGRmYmlCUDdjSjBiZ1VmK1hwWFoxOUZSRUlv?=
 =?utf-8?B?ZGZHZ0ZsYzhCYjMvVWRBUWZldWoxdkx6cjhzM2lQQ0xYckhqWThHMmlqWkpl?=
 =?utf-8?B?QzRPTldoVXVJY1p4Mi9Sam9FR05yLzhsQk5waU9SNTBSN0dSVjBaZWE1a2xQ?=
 =?utf-8?B?TDEvK1FmT1ZjcWh4L0lwMW8vTnM5cy92TEZsWHhWVlBmVUEvTXhleTFUQ0c3?=
 =?utf-8?B?ZHB4aERLQU9DUTh3a2FQdkhSK2M3aDhxNytGN3hENnpDeGp6Qm9SUlNzbFRF?=
 =?utf-8?B?ZU1KTmJXa0ZGZS9DenpJOEdHQXFsc3JxRTJocVN6My9UZ1ovOTdOMkZCQyts?=
 =?utf-8?B?SllEMEx0Uit3SnFNaE5KUnc5ZEc2aXVIOExWYXdIOTNWbnp4dWdUSitWQytk?=
 =?utf-8?B?NGUxMWplMHM3SHo4dS9WZUpNQi9yb3V6YVJ1R3U1SEY4dmJZKzFudWs5alMr?=
 =?utf-8?B?bllRaUVxbGJYQ2pCQmlVL1Q1dnpqVlU0RHZWOTFBZlZ6b21jQjBHNDB2TU9s?=
 =?utf-8?B?alU5bG9OUHNNaGE4cmFEOWtJeUxkWGgwYUJPUHp3WWZvWjk4SUtkY2JmNy90?=
 =?utf-8?B?Zng1RmdDTXBZMng5OTlMQ01qYWhsYkw2emppbUFHdDJQSk0wdjh1Qy9kSysx?=
 =?utf-8?B?cklIVjJTWTJrdFpUWlBKdXQ0MVhUS2xxcFBSZ1F0OEV5SVBXQUJoTEVoRGVQ?=
 =?utf-8?B?Wnc4OWNucklGNXNDWFJhMXIzcHdVUW9SaTROTGdZUkUzTGZpWlNXU0g3eHV6?=
 =?utf-8?B?ZTZUK09odWdKMXRGMXpCZVRJWHBXL2RTQmxmNTVOVkZjUHVCUFBZSzhkTm1U?=
 =?utf-8?B?aThJdE54bDZDLzZ3SXZQVGxHMDBwa2oxSEVNT0V1MnhoYktKRlRvL25pbWFn?=
 =?utf-8?B?N0p5V3NORlFhSTg2OVFFWEtZWnRScEtnczUvMGZkdHhYY3MwVENPZldqbVdj?=
 =?utf-8?B?YXY1ZWVPSkNXeGFMTXBwNXhsY1FuR0xpSFZLd0s0T1FZMGRYMXlFZXlyOC9l?=
 =?utf-8?B?dDRFZUxtN01nbVgraFZDWVAvbUxaUDFNVnJvQzVrWXVRZmZab1Nvb1U5SEJ1?=
 =?utf-8?B?ZkpIelhMLzhWZVc4TExHWHE0N2FsSUZzRWNYTTFzRWhJQkRLcDBlMjFsVUJo?=
 =?utf-8?B?S0MwK2tYNklIckJmTG1LQWJicTc4OEVYUW85cHFLSzFJK05EQ05CYWR0aFlL?=
 =?utf-8?B?QWJiZVVUWFpjanV1cWFiVmxLeTBHOFQ2djd2aXB3eGlkV1VUQXJVdGRMZTJI?=
 =?utf-8?B?ZGw3TUFXVkFCV2RSYWlpNkZlZXVtbWlpRG1TRlpLWk9McG5IZmpZcDZBM1JI?=
 =?utf-8?B?S0MyNmNnOEZ6M05abDEzT0c5cHozeGRLanNRQXhpYkJRYWhHdlI5U1JwSFRY?=
 =?utf-8?Q?vVUIFFaN0CZyxeCo4VYeQSr7trU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400b7c05-e9f7-40e1-b772-08d8c56e7042
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 22:28:59.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ff5e4pTZyIL0MAAwcIWwgBinLXOPzEquqrjC2zuwKdcKQ87u9szPX+/xaMoQHe0XJQc81jNXX1ZmHJfMjnqaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3555
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300122
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> The zoned btrfs puts a superblock at the beginning of SB logging zones
> if the zone is conventional. This difference causes a chicken-and-egg
> problem for emulated zoned mode. Since the device is a regular
> (non-zoned) device, we cannot know if the btrfs is regular or emulated
> zoned while we read the superblock. But, to load proper superblock, we
> need to see if it is emulated zoned or not.
> 
> We place the SBs at the same location as the regular btrfs on emulated
> zoned mode to solve the problem. It is possible because it's ensured
> that all the SB locations are at a conventional zone on emulated zoned
> mode.
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

  Makes sense to me.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.



> ---
>   fs/btrfs/zoned.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index bcabdb2c97f1..87172ce7173b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -553,7 +553,13 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
>   	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>   	u32 zone_num;
>   
> -	if (!zinfo) {
> +	/*
> +	 * With btrfs zoned mode on a non-zoned block device, use the same
> +	 * super block locations as regular btrfs. Doing so, the super
> +	 * block can always be retrieved and the zoned-mode of the volume
> +	 * detected from the super block information.
> +	 */
> +	if (!bdev_is_zoned(device->bdev)) {
>   		*bytenr_ret = btrfs_sb_offset(mirror);
>   		return 0;
>   	}
> 

