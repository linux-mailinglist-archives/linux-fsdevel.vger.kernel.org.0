Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846F73098D9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 00:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhA3XqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Jan 2021 18:46:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhA3XqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Jan 2021 18:46:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UNjCTk145835;
        Sat, 30 Jan 2021 23:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=p/PWmMZbTmmvWG976tm/6uakaK0MVk5AdI6hJ9hAKS0=;
 b=TCms4wNmAWORauFU4Ztn9vqePeKPxd+bedxQ7kyaPBrHjYTZE6I1xvTvFYp0O0kfvexX
 XifGQ9yvZuWkrCg73SNVuKJXWHWWG+YBlV9EE0pyQyLj6FR8UoAi4jmcpnRSkCKWDw+Z
 8ql7XlHCBX2wQztFJlksM3/LC8ptMFIlT8TZOR/PV2W9cphlyqyQsuz2gaYKlmATE+Hv
 eFDFkvY17RQqVyGzktfMaGZXhbwD2zeKHKX72YNMPdK1yFdoQobotl0o9GNkSPCQ3lMn
 MC1MFwnPa3tMRTLtMidlmEnpDD0KTD9QDzLj/PjHQscXNVGbjk6ElpJ8UmhdW0GnST4r XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36cxvqs9c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 23:45:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10UNdwwB166512;
        Sat, 30 Jan 2021 23:45:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 36dh7n84sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Jan 2021 23:45:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/Ane6vIC/Ju+de8hOp5fU+fgteudw6QlcBxZpKujnh32gg8nsLp5+v123Zjjvw1f7MClK08H3g0aFZYX9PHV0bb8QGXFLGLISxfT9jK6Fxh6BKb8/oqprgMpdpxd/s/wMkWlB1ZyDImEJOCdw6UeH0Nfwv87bNxAxq9F6vXvXvV/xBaseR/CSwIT9ndXpRUdBNrLtkA9KFDAlYh5jq5GQSmOdT5p9njBL/s2HZuNXVyHx+Ie182DMhphpiBd210fjInDSHq8xa46yOwBSGIeKj9KCC4zolb10PctHOmjxw5U/uGJsiHqeAwDr+8Bii1Skk6tt/kXJpsa8jKe5VytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/PWmMZbTmmvWG976tm/6uakaK0MVk5AdI6hJ9hAKS0=;
 b=d1/OBtFAgqy98Rvj0bNl9XK+8JxCfbZMTqEpG9i3eS+1jrTkSIVY6ZwYdhZXeIEd7SWZcDWzta5WC36YMYOutwqvCFyNYXIAa6pk4kTTz+gQFl1833aML0zGrUxpVd8c8NaU8Cgcql1Lgmg9pRRbyfFjJCsaNCZTy8SMboRx1FwXocHmYIaXdi4L7ACuEpi6pDXeNS/mpOaGexL//ur+pmHKVj+a5BZYlYzK0BkIFCroNqKrDhTw6kolHxtssYL6JBHPq47khNYKm6oBqww5OaqglChfwqhr3kv6VzYTmstSKGt2d+lGYtQ5EO/+wzfNIQB0PZjD8RfvgxGo3CMqHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/PWmMZbTmmvWG976tm/6uakaK0MVk5AdI6hJ9hAKS0=;
 b=obz8XC+IJ8J16yuE6PUPO2LcsMzAZAaqvZoVmnU+y0J3f9zU3WPVoOLh2Zy+wT3iSLqjJpiCCwE2Da9/9YFwB4I9Bblc+Ab4119j6Um/YKeOMwbw6W4vkNHeg07Wl/ySSGcYYXCK0FAgdpdOl46gwo/iVOt31JvxI6KxJK1IEUA=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR10MB1761.namprd10.prod.outlook.com (2603:10b6:405:a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Sat, 30 Jan
 2021 23:45:09 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::44c4:3dbe:4b78:f69a%3]) with mapi id 15.20.3805.024; Sat, 30 Jan 2021
 23:45:09 +0000
Subject: Re: [PATCH v14 07/42] btrfs: disallow fitrim in ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <dd9f9b5930072bfb64b727f5e2380f37f4fb46fb.1611627788.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <57fa93f5-9689-ddf4-7a82-730fe21e59a7@oracle.com>
Date:   Sun, 31 Jan 2021 07:44:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <dd9f9b5930072bfb64b727f5e2380f37f4fb46fb.1611627788.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:b1e5:e46d:4484:a96c]
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:b1e5:e46d:4484:a96c] (2406:3003:2006:2288:b1e5:e46d:4484:a96c) by SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Sat, 30 Jan 2021 23:45:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186e1013-8e7d-4c2e-328b-08d8c57913e4
X-MS-TrafficTypeDiagnostic: BN6PR10MB1761:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB17611C761D5217DAC802D435E5B89@BN6PR10MB1761.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqRM1hurJ6NclYSFXf/MeVmzfxpciUbWmGtrh8cZ3BTLcQbV2jG2T2Ie12k7DnaTM+pDPtvxJQ1CSSK6Pccc7L7vNfHMRvmo3rUeHhgh+ouEy/D0qqzAoSquiXs16CBkxS80E8D9mwLQa2MC6CEj4xwNzwj50JtMUCM+RHSP8Yhm2miDbQrV0W43dZ/oJX1xr+A1qd1YL8Z4nc5unTDhum9tqcPu/SNBhPmPvcN1GuG+rnQ2/+FzSFCT7gtCuGfQRkCMAn9nWgsCLH9txHSeKJ7EKKxudixjbkg/VFxnvheTdwnNTE1ijCjBG/dCmMEfNv97GJAplzwk2rHEvvjVOIFECrcJtS2GHdurIiboJDnzMl2pzCTfVY37nYMgYKbCSLsNVXX3x0N+UWThbPS57CdX7lV7u99Ovy99N9bttXeI3A7Xdzo59dm/t3YLh3KWD2tdYfFEuG9PG3OepyS1OUqH9JHAfILuDw2shpiyL8LVYPtpCC20fZ6Rxk0SKRqqwgzeiKPSZpSH+YNbK6pUILr42ytZndLpJvk4pq8/o9Z8GX0/Qr6zzyph251DDGkxa1W4VO8toTGBfzEgy1lXzfNhV3dIl9c4f815j2b9soQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(83380400001)(36756003)(44832011)(6666004)(6486002)(86362001)(31686004)(4326008)(2906002)(478600001)(54906003)(316002)(66556008)(5660300002)(66476007)(186003)(8936002)(2616005)(53546011)(16526019)(66946007)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WVBlVW82TEFvbXhWRVpDbXkwRWpINXc0dDNWOXY3UDZPTXlCR1gxRVdPQ2Vi?=
 =?utf-8?B?VUIvNDVJbkVPTGhoNnpwVm43Y2JsQ2pTZzRPQUgyOFRtUUVHdXFMSUh0L2h2?=
 =?utf-8?B?RHh1NUNxb1BiK0Q1aVNKTDVlR3R4dTA4T0ZLMXRZWGNDWDhWdlVsRFZVaE5H?=
 =?utf-8?B?MEdLWi9OK3JaNURJV2VGQjg1NEorR2ZCd1AzMjhuWmJLN2dLNGVzNFlDdkUv?=
 =?utf-8?B?UXJnRFZoSCtUTkJsamRaT1REbmdhZlFKMWRueHgwNEtRTkdFcE1OQkJ3R3dT?=
 =?utf-8?B?clJsV3BmdHUvcytMbFQxR0czTVJSTThpbFRncXdEdUsyNHd0dWMvKzJ2Smtv?=
 =?utf-8?B?cDhIQjR0eW5iK2hRbzgwbkVpL1pjMmFqcVVnbUVSVHRLeW5JdHdINURBUGll?=
 =?utf-8?B?Zis5cHhDY3NsaEwvUjllQzNjKzRubGFjeWVuWFFHeFdqd1VpZ0daNnBYUkc4?=
 =?utf-8?B?ckdtNDM1Z01ETFpXOG5mNXA2T3ZDZDlnemIrSkcvZzgxeGNuZVo4MDJRS2x1?=
 =?utf-8?B?dnJ6VUtpVmRJTm5uMzRTa3F2V25peHUyYWNlcWRjdEZzemV0OVhiaDY1VFNm?=
 =?utf-8?B?OUo3a2dFLzNpT2oxclFUaldwdWRoazNFNFlhT01qY0NOSmlZbllQZzJVWFB3?=
 =?utf-8?B?dnNRNjN6OFdGMFZNWXBNZm1QaVRRSEw2TFBaeEhjSFhnQUIzcTdndFg3ZWtn?=
 =?utf-8?B?UTNjUFVXMGxhUWtKbjZVVlhkUXhNTElCMHRTUDlBU2pab01iRVZvSHlFSENK?=
 =?utf-8?B?WUZDT05lcEJnN1JnU1dzcG1JK01CZUYxRG5jZHA2Tnk0Ri9JVTB4UWcraUZh?=
 =?utf-8?B?Z1hPQlB3VmRPTFJQNGhMUFZqVmowSHdiZGxmV1BQVzZMZkVHZmVZTlJIOWlt?=
 =?utf-8?B?ckg0eFNyM3NsWFc1VHJWSXpSaUlDUGpneU5tTXlnRXJqSmxRNzFCT0hGVG5h?=
 =?utf-8?B?Wmh1b3JoZFRwK2o0QW1EMzZvOTlrV0ZXZGVzMjk2blozNW1QdEZ0UVFmMmsx?=
 =?utf-8?B?ck1LTnhyUVJVN215Rnd1QnFjVTdUenVHYXlJd2lMLzJ2dDJ3VUx5cEF0aDly?=
 =?utf-8?B?Sy9mSUNNdVpIY1k4Mks1ZnpVejZhL2FoUWxNM3pYNy9yUWpMRjBjSFpPQ2RZ?=
 =?utf-8?B?dDdIdkZNMlV3WGlSK0JlYkhrME13VWxBNnVxMmR0bFM4WlpMRnVTdkU3YkRZ?=
 =?utf-8?B?YUxTaEZXbklFRnZsMEhqSGxCcjI4clNVTHpmVytkcXkyQlhmMXJqVlI5K1Qr?=
 =?utf-8?B?WHpXUFZBQjFKbExhMzR1YlhScnZEUGtRY3hjLzRUemFrZHpmc3dMV0ZsSy9O?=
 =?utf-8?B?ck1ndDBqS0hyQnVzaXp0M3E0cE4yQWN6YlNGdFI1VWlYQktZSWZPNElrZFdE?=
 =?utf-8?B?cGZxd3RxSkNyYllFTjFHa0dwei84b0N3WGp2eENlaTRRU3V5QzhxNllTc25a?=
 =?utf-8?B?eUxHTDdGMm0wbUFWYmtMaFpGRkVWcGJEa0JJRm5neElYdnV3VFdkZjZydWtn?=
 =?utf-8?Q?GoLWVimaDzhjFlyMHvzT6gz6CdE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186e1013-8e7d-4c2e-328b-08d8c57913e4
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2021 23:45:09.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1zlP/apYkrHwpwMWyNnTJAJ2FqBJoVu+Q6lMzAP55t95xLQvJoA6cIiXL4L28ieEtMUf0X0ritpEUDsN0bibQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1761
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9880 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101300131
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/2021 10:24 AM, Naohiro Aota wrote:
> The implementation of fitrim is depending on space cache, which is not used
> and disabled for zoned btrfs' extent allocator. So the current code does
> not work with zoned btrfs. In the future, we can implement fitrim for zoned
> btrfs by enabling space cache (but, only for fitrim) or scanning the extent
> tree at fitrim time. But, for now, disallow fitrim in ZONED mode.
> 


> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/ioctl.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7f2935ea8d3a..f05b0b8b1595 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -527,6 +527,14 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>   	if (!capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   
> +	/*
> +	 * btrfs_trim_block_group() is depending on space cache, which is
> +	 * not available in ZONED mode. So, disallow fitrim in ZONED mode
> +	 * for now.
> +	 */
> +	if (btrfs_is_zoned(fs_info))
> +		return -EOPNOTSUPP;
> +
>   	/*
>   	 * If the fs is mounted with nologreplay, which requires it to be
>   	 * mounted in RO mode as well, we can not allow discard on free space
> 

