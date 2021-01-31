Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0630999D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 02:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhAaBUW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 20:20:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52708 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhAaBUS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:20:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10V1Bw5M082767;
        Sun, 31 Jan 2021 01:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=js2/6t3zLJppKVPyYCLjZgpyCP2RHqazJWZTSUr6JuM=;
 b=qodww48si+w2GkTedIn7jDUNDx8qiHtv4691jLuHzsrcHfuGg1U/MlmxygLiwPZ6gpmZ
 foewOt7znlrYhXXLDXV5rFcCJvnaltHh96qMZ3gUM+/OhWB05Ie+/ujBXN1JjZbjavQr
 rTuP7giH/VlQHvo+6KJh6IRP9gvlwlxd5rzMjaxm+0wXYJlcVMmbGo83M/QJEqHPhwGg
 ELoHN1rdSbUuHnYmksO4aEbU+5vd837lgQOBXV+wMqt+pka2wu9U5/MWXcXlXsk6ysgS
 tHwzPJduJ6WDJ4ScrAXq0gSeEloMVUw0DeFwYlc3UcTBWjZgSf4/yyNiR/5+XjcvWnco ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 36cxvqsb91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 01:19:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10V11IiV100079;
        Sun, 31 Jan 2021 01:17:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 36dh1k1gb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 01:17:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfBgIZO2CddlHDoYCRH8xM8/RjD/rHyrwoFZpEKggotgZTiJ/XqTwzY5ajzWCS1vJUxkTrKjubINDa7a56b0pGabZ62ePVgKGG5NCXeX6Nbw9A7hnT/m0SjD8QbYhs9l4VnHFbfxkbP1bMYYDlSkDVff2vKlpF7P9WJiUyI+LxAOqNdnE/hZ8L71ToQN4X5Wq1LPTmLgpYh6C7PhU2g+D2yO2L0ThiwfhCE6n3eVZNmKAyZ4xw+ya2edHbfSuO2vkS0nSHnzcWoeCeBGVODLyoT4Qsc8YteY2acOPLYYhZzWCYrksAYIE+1zILFz6U1lDo1Y/ICTkOPC1dbhvOxKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js2/6t3zLJppKVPyYCLjZgpyCP2RHqazJWZTSUr6JuM=;
 b=UnLP5g2Wj9dqQpdMOZUCXLU+ip6MDXzP8Dt87lHITcQp489GDMsZrNPmn1xbJo4XeGVQ6oQuBWma1Y/dA59Q54GaVsje0af8pmU9fCMiIb2L5GUEfZ4VyekhMf0vOyYWfT1LiBPuvZgVcS/fjTIr8uf4BNxnq5+eaRrJAtH38mtns/UCa+ImaWiOnbdMAMQz4/omvcE93DnyhBxDmttny+kZTG7dp+2eCiT+5nJDydUpqMwPPPxWJGMnUhZBjY5/TM2CX/WOvQdW2VztJwVmOzEfj9GgDA67QlRxV5E/DO04ov+MIUWwEIGG/ON8Cosk7krH9omySrMhmrdi8ofULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js2/6t3zLJppKVPyYCLjZgpyCP2RHqazJWZTSUr6JuM=;
 b=VtnQ70GnoU21X2SeAksnt7J4bHgpa1XSB2RFZXoRvfcDZMFtZnBDeC9hF4WA3x3twl3MWx0341xck0m71cIXd74x1P76OP/yoUihaAaIZP/aWYS/nAO2sTnHsoOruqA8MrWizM3ghkcRyvzNmKc2x2H1xlFD+nPVSUrwNby86OE=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN8PR10MB3618.namprd10.prod.outlook.com (2603:10b6:408:b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Sun, 31 Jan
 2021 01:17:18 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sun, 31 Jan 2021
 01:17:17 +0000
Subject: Re: [PATCH v14 08/42] btrfs: allow zoned mode on non-zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <613da3120ca06ebf470352dbebcbdaa19bf57926.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <a945d1b6-1001-1c06-82cf-e1ee4a71d9e7@oracle.com>
Date:   Sun, 31 Jan 2021 09:17:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <613da3120ca06ebf470352dbebcbdaa19bf57926.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:9fe:a7d1:6d17:4f56]
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:9fe:a7d1:6d17:4f56] (2406:3003:2006:2288:9fe:a7d1:6d17:4f56) by SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sun, 31 Jan 2021 01:17:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da795111-6b10-484b-9a8d-08d8c585f334
X-MS-TrafficTypeDiagnostic: BN8PR10MB3618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR10MB361870503260E4C8649EBD9AE5B79@BN8PR10MB3618.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:209;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UqBekbbIBFrHEf7bYpWO3RyHbNwwEUxgNlJvUIScCO75IDU8ZYH44qzGRqfss/wmJUxbFdOyzFoGLCEhRhqn934hXAs5L/HuUplRa8OlvTTbnXx8qp91Mc2sz516BC4F3JpPwuO86ncxANm9Muo73uUC7yGYMLwiRQTCzcjXvGw3LEqwEEoWSLs88WfGP8etOw1IyP5WFpz8hcdm/ijyUGKciilyWtctNcyHEDgkFFCLYFIU4Pm+OJh/96MwemZ78RZk3Y580O0F980VUyjS2kc/m6SC+oSbHukekothYcOWA9qbyTA7zlQIZt4o+SGzRcKsyMzNTuFJVgtLUAwFF7RMAPTHJm/D9fufbsFYXG3SLFL5tevAQfsgscCfD5Eiy3foT69ToIR89B76BId7gIMdMeaZx2XmCwuMpuwceDF+s+uGc67Jhbc6tO8a7wMh7naSPQnrIE14wBOnMzaqzpSGNNlnRYeSl0bEuwb43R+3s9dMRw3AK6GqxQgrugxbZvKyerDanjCunnASsJmKRuG7pFoPvg2RwvTj832OAscmpvGkO0jcHGTDz5Mz54NOqkZKWoTo6D90KAGienVmCu0jkQ+18huUPDGRpJVobnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(39850400004)(376002)(66946007)(2906002)(36756003)(6666004)(66476007)(16526019)(66556008)(8936002)(186003)(4326008)(316002)(6486002)(83380400001)(54906003)(478600001)(2616005)(44832011)(31696002)(8676002)(31686004)(86362001)(53546011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eHVrcEpmeGZKbTlZQmsxVW12ZFhJQjRHanYwd0FuVUNrYnFoQzVEZFJ0Q0t0?=
 =?utf-8?B?VkVZLzZoWW9OSnFEbE5SMStCejBvOThsNjJLNTVsZ1dTTUN2RDUzK0FHMmFq?=
 =?utf-8?B?Q3czbElaUytpaEp6eThkOVIzU0Q0ek9iTENNejA1MW9taXpDL0pzSVBrTmNC?=
 =?utf-8?B?RFQ3eW1wditpWUhrR3ZTdmNoRW1xUHRNVCt2UDlsQ3Yvc1I0MXQ4ZStDMDhl?=
 =?utf-8?B?U2h4TmJGbGRISEdvY3RRRzBNeGRxcnRVc25KSFVLbTRTYjNuWmFuSFdRWkVp?=
 =?utf-8?B?QTMzd0l6Z0tWaHlvU1JVM3FCamY1R1VkRTBXU2lxK01sOUxiS2M3b3hLaHo2?=
 =?utf-8?B?Sm5vbEU4V2N0cjA3WlN1SStVV0lKODd2V3BJMGgyRGZRb2VYQWV1Rk8vWVYv?=
 =?utf-8?B?VXN4Q1o1a0djQjRna2xOUDFLYk15d05MRTc4VnZIc2laN2xhQ0lTQW9iTTV5?=
 =?utf-8?B?V1NGa09kVVdUR2NzdHhWREhiL1dQZ1FoTngxTHcxZmJzY2swV0dTZDBRazF4?=
 =?utf-8?B?MWhJNHlwN3F4aWdqRXNDbzQ3VExRTk4ra2lSQ3dlREdac1I2cEp4S0VjVzlW?=
 =?utf-8?B?VlpGMVVFaG1GYUxMcmhlbTM4TTNtRC8vMVVUZkowT2lGNmVoUHoxN2VoZlE4?=
 =?utf-8?B?WFhqUUlnNG5yYUlZVnFac2NMY09pNldzRlcvazk3aTVJTGpPdlIxR3pIN2ZE?=
 =?utf-8?B?Qlh3Z3VveDFESmFZYWVRdGNVL0V6VllLV3RDS1BsbHloR3k2MmdDMkN1NUlS?=
 =?utf-8?B?TW9jV2hxYXVwSlNRcmRrSlYyanRYc3dRYlJkOExCcEx1Q0VzNWxvLy9BVkl1?=
 =?utf-8?B?akk4UlFBMjZ0andZNWJBNjk3MkJrZU1vcWN1OGpONDdGaEJVbnlUZ1Z1NnZq?=
 =?utf-8?B?aXRGeHFxK2xoTEJSREVna3drRnE0d0VZZ0Y4NW1kYlFHZnBlUFYwcEU5dVJ4?=
 =?utf-8?B?SE11dWluTFZWTzdUTDE4SkszZFJ1YXRVaWZVbkVuRHIrdjJ0WlNlb3p6NTFy?=
 =?utf-8?B?bmJsRUM3WWFIU3lQL1g4cUZTd2s5b3ZRZkdxdk1HYnZaYW1NZGxTTFB0RTI0?=
 =?utf-8?B?Yk5aNEczZ1ZvSzBtbldhaHNsNk02SFdKemxwTWV3YkJPVTMwVkRUUzN4RDFp?=
 =?utf-8?B?bGNHTVlKOWhsYUlFNStuOXJEdUlQVlUzUnpoYmJ6djRCUkFDWnExajJFUjIz?=
 =?utf-8?B?TGdpMmp1OE5nZlpyZnJLbEs5bXllbDArK3ZrTUJKT2M2NmpKRDdYRFBsdWFp?=
 =?utf-8?B?MHBFeVo1N2hMTlZqL2FNcXBYYklhSmR6NlFpTlVyK21pdE9XVFFKK1V2QzZR?=
 =?utf-8?B?enU0cEMwYXk1ak54cS82a0lDTmhmMHRnVzZpeFFWZWVIU1hDdkgwZHVpWnk0?=
 =?utf-8?B?eW1EZEFlWExnNW8xTGRiUUtVZHV0RytQaDZETWo1YXUxTU1pZFovTHlJN0Vt?=
 =?utf-8?B?YmdRbm5lTjVxUVJJSlJlaDVndEZHUWpldnppbFkrdmY3VTBDczRNQ2FSeFRx?=
 =?utf-8?Q?faX5YicpyXDlQd36cNKTklUWQdC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da795111-6b10-484b-9a8d-08d8c585f334
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2021 01:17:17.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRokMR6oSkQiOVkjrCfUr8Zb6SXkLFK8WD2kHKWm2EkXF7+LXg0Qi4N17tDbEA+MQYeLk1u/Z3OkhmD3aZg3JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3618
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101310002
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Run zoned btrfs mode on non-zoned devices. This is done by "slicing
> up" the block-device into static sized chunks and fake a conventional zone
> on each of them. The emulated zone size is determined from the size of
> device extent.
> 
> This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
> chunk allocator, on regular block devices.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/zoned.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
>   fs/btrfs/zoned.h |  14 +++--
>   2 files changed, 147 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 315cd5189781..f0af88d497c7 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -119,6 +119,37 @@ static inline u32 sb_zone_number(int shift, int mirror)
>   	return 0;
>   }
>   
> +/*
> + * Emulate blkdev_report_zones() for a non-zoned device. It slice up
> + * the block device into static sized chunks and fake a conventional zone
> + * on each of them.
> + */
> +static int emulate_report_zones(struct btrfs_device *device, u64 pos,
> +				struct blk_zone *zones, unsigned int nr_zones)
> +{
> +	const sector_t zone_sectors =
> +		device->fs_info->zone_size >> SECTOR_SHIFT;
> +	sector_t bdev_size = bdev_nr_sectors(device->bdev);
> +	unsigned int i;
> +
> +	pos >>= SECTOR_SHIFT;
> +	for (i = 0; i < nr_zones; i++) {
> +		zones[i].start = i * zone_sectors + pos;
> +		zones[i].len = zone_sectors;
> +		zones[i].capacity = zone_sectors;
> +		zones[i].wp = zones[i].start + zone_sectors;

I missed something.
Hmm, why write-point is again at a zone_sector offset from the start? 
Should it be just...

  zones[i].wp = zones[i].start;

Also, a typo is below.

> +		zones[i].type = BLK_ZONE_TYPE_CONVENTIONAL;
> +		zones[i].cond = BLK_ZONE_COND_NOT_WP;
> +
> +		if (zones[i].wp >= bdev_size) {
> +			i++;
> +			break;
> +		}
> +	}
> +
> +	return i;
> +}
> +
>   static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>   			       struct blk_zone *zones, unsigned int *nr_zones)
>   {
> @@ -127,6 +158,12 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>   	if (!*nr_zones)
>   		return 0;
>   
> +	if (!bdev_is_zoned(device->bdev)) {
> +		ret = emulate_report_zones(device, pos, zones, *nr_zones);
> +		*nr_zones = ret;
> +		return 0;
> +	}
> +
>   	ret = blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zones,
>   				  copy_zone_info_cb, zones);
>   	if (ret < 0) {
> @@ -143,6 +180,50 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
>   	return 0;
>   }
>   
> +/* The emulated zone size is determined from the size of device extent. */
> +static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_path *path;
> +	struct btrfs_root *root = fs_info->dev_root;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_dev_extent *dext;
> +	int ret = 0;
> +
> +	key.objectid = 1;
> +	key.type = BTRFS_DEV_EXTENT_KEY;
> +	key.offset = 0;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
> +		ret = btrfs_next_item(root, path);
> +		if (ret < 0)
> +			goto out;
> +		/* No dev extents at all? Not good */
> +		if (ret > 0) {
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +	}
> +
> +	leaf = path->nodes[0];
> +	dext = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_dev_extent);
> +	fs_info->zone_size = btrfs_dev_extent_length(leaf, dext);
> +	ret = 0;
> +
> +out:
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> +
>   int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
> @@ -169,6 +250,7 @@ int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
>   
>   int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   {
> +	struct btrfs_fs_info *fs_info = device->fs_info;
>   	struct btrfs_zoned_device_info *zone_info = NULL;
>   	struct block_device *bdev = device->bdev;
>   	struct request_queue *queue = bdev_get_queue(bdev);
> @@ -177,9 +259,14 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   	struct blk_zone *zones = NULL;
>   	unsigned int i, nreported = 0, nr_zones;
>   	unsigned int zone_sectors;
> +	char *model, *emulated;
>   	int ret;
>   
> -	if (!bdev_is_zoned(bdev))
> +	/*
> +	 * Cannot use btrfs_is_zoned here, since fs_info->zone_size might
> +	 * not be set yet.
> +	 */
> +	if (!btrfs_fs_incompat(fs_info, ZONED))
>   		return 0;
>   
>   	if (device->zone_info)
> @@ -189,8 +276,20 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   	if (!zone_info)
>   		return -ENOMEM;
>   
> +	if (!bdev_is_zoned(bdev)) {
> +		if (!fs_info->zone_size) {
> +			ret = calculate_emulated_zone_size(fs_info);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		ASSERT(fs_info->zone_size);
> +		zone_sectors = fs_info->zone_size >> SECTOR_SHIFT;
> +	} else {
> +		zone_sectors = bdev_zone_sectors(bdev);
> +	}
> +
>   	nr_sectors = bdev_nr_sectors(bdev);
> -	zone_sectors = bdev_zone_sectors(bdev);
>   	/* Check if it's power of 2 (see is_power_of_2) */
>   	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
>   	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
> @@ -296,12 +395,32 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
>   
>   	device->zone_info = zone_info;
>   
> -	/* device->fs_info is not safe to use for printing messages */
> -	btrfs_info_in_rcu(NULL,
> -			"host-%s zoned block device %s, %u zones of %llu bytes",
> -			bdev_zoned_model(bdev) == BLK_ZONED_HM ? "managed" : "aware",
> -			rcu_str_deref(device->name), zone_info->nr_zones,
> -			zone_info->zone_size);
> +	switch (bdev_zoned_model(bdev)) {
> +	case BLK_ZONED_HM:
> +		model = "host-managed zoned";
> +		emulated = "";
> +		break;
> +	case BLK_ZONED_HA:
> +		model = "host-aware zoned";
> +		emulated = "";
> +		break;
> +	case BLK_ZONED_NONE:
> +		model = "regular";
> +		emulated = "emulated ";
> +		break;
> +	default:
> +		/* Just in case */
> +		btrfs_err_in_rcu(fs_info, "Unsupported zoned model %d on %s",
> +				 bdev_zoned_model(bdev),
> +				 rcu_str_deref(device->name));
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	btrfs_info_in_rcu(fs_info,
> +		"%s block device %s, %u %szones of %llu bytes",
> +		model, rcu_str_deref(device->name), zone_info->nr_zones,
> +		emulated, zone_info->zone_size);
>   
>   	return 0;
>   
> @@ -348,7 +467,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   	u64 nr_devices = 0;
>   	u64 zone_size = 0;
>   	u64 max_zone_append_size = 0;
> -	const bool incompat_zoned = btrfs_is_zoned(fs_info);
> +	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
>   	int ret = 0;
>   
>   	/* Count zoned devices */
> @@ -359,9 +478,17 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>   			continue;
>   
>   		model = bdev_zoned_model(device->bdev);
> +		/*
> +		 * A Host-Managed zoned device msut be used as a zoned

typo
s/msut/must

Thanks.

> +		 * device. A Host-Aware zoned device and a non-zoned devices
> +		 * can be treated as a zoned device, if ZONED flag is
> +		 * enabled in the superblock.
> +		 */
>   		if (model == BLK_ZONED_HM ||
> -		    (model == BLK_ZONED_HA && incompat_zoned)) {
> -			struct btrfs_zoned_device_info *zone_info;
> +		    (model == BLK_ZONED_HA && incompat_zoned) ||
> +		    (model == BLK_ZONED_NONE && incompat_zoned)) {
> +			struct btrfs_zoned_device_info *zone_info =
> +				device->zone_info;
>   
>   			zone_info = device->zone_info;
>   			zoned_devices++;
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index 5e0e7de84a82..058a57317c05 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -143,12 +143,16 @@ static inline void btrfs_dev_clear_zone_empty(struct btrfs_device *device, u64 p
>   static inline bool btrfs_check_device_zone_type(const struct btrfs_fs_info *fs_info,
>   						struct block_device *bdev)
>   {
> -	u64 zone_size;
> -
>   	if (btrfs_is_zoned(fs_info)) {
> -		zone_size = bdev_zone_sectors(bdev) << SECTOR_SHIFT;
> -		/* Do not allow non-zoned device */
> -		return bdev_is_zoned(bdev) && fs_info->zone_size == zone_size;
> +		/*
> +		 * We can allow a regular device on a zoned btrfs, because
> +		 * we will emulate zoned device on the regular device.
> +		 */
> +		if (!bdev_is_zoned(bdev))
> +			return true;
> +
> +		return fs_info->zone_size ==
> +			(bdev_zone_sectors(bdev) << SECTOR_SHIFT);
>   	}
>   
>   	/* Do not allow Host Manged zoned device */
> 

