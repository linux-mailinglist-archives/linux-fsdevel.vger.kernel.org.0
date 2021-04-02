Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2645C35317B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Apr 2021 01:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbhDBXVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 19:21:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36968 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbhDBXVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 19:21:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NKTew156709;
        Fri, 2 Apr 2021 23:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=AHsa+4eB9zSTQ9GRZnXGqV6Vgs0cntEKdiLLbRPcw3c=;
 b=od1pari4nyXVf4d1WuA/ohlqgRTCmQyoMKXAYP8cGv1FbKUJZlo0FUGrOWl6eyuibxey
 c+LeZjth9H3dU9INJWlNZC/DbubOG3nsEIXrMXmCUlrx4EGeUcOMbyn7Ce4T5SKfyIVE
 hWtJSY1tUs/AvS/TbBPB29CqVng4CWDuJ3BQvEjBCVDQ4m51yBeEywonKfjciBYkAOCr
 2R9dLslbwx2M6OGIa78Mw7pkgXcMV6ex/JVmpBdm7bCEnD4G9wI26SU3I27WJ4Q4/sku
 Hg/eQ4xLahvq2YNcPdyoidf3pe2pjRb8ebKzPNrtQYjbGx+7OIDtX2tf/MkogZfj5zeV Jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37n2aknr88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:21:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NGor1048308;
        Fri, 2 Apr 2021 23:21:04 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2058.outbound.protection.outlook.com [104.47.46.58])
        by userp3020.oracle.com with ESMTP id 37n2pc79g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mY85yebx7oWhqNy2AZOFHxdSuO6Th0GxXoCH2BejK7Lbawh8ySYhlhfiLhb8tGpVNVGWBeLhO7XtxJn0l/uC3TzYKdm2PGluAUcEvpmNcGjyKBmMjH20EmuGi1/mU90TsOywSeOmTatpWbxsBoeKsn/j+RQ7VZq4dT7zWeR/dUjYPXE3S+96XtcnEFZj1q7eR0erTaAGLN4CzdssRVTTcpHxeAYwlXxfrJPFnUEOmhS71jh6SbXUt0WGl8GL/s0R02nZ/uwXxy8Vl1oi/llsPE6Izl+8E8sVE5cXQ8qHaIpQ0iy3pVssIoazzTtEuoeO7HdOS/VOG4norQ11Krvddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHsa+4eB9zSTQ9GRZnXGqV6Vgs0cntEKdiLLbRPcw3c=;
 b=V9ixqzTD8O0Pfn5wllo7PDyTlTTxXZvIluX9dHxsCi8oZhVaDd6jHpo1zKQdMMYiObw/iR8aM1F3xdlma9kwUvuQCOvaGdoUpjcvZO19f1pWesgr6bwsS2TiBvM9XXwPZYXdEoZTehDN5kijwIXJmTuqOhGxzAy7+4jYrZ5WnqJTjM2VRnWKyV5F9c9GXoRxBy5llCx+vQnIP4R1EnozNicdE7CoyZEaKSP4tQnPi5m11QQ6BWGT2SBr4GZ72pHP2JtTTVAKN6ZpM0vlvwbU8peskccozvWgdOoKKtuyTP9T4JqdKA+wYbQlqLTF9WP+fepyPZq35Y12PinQjJJIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHsa+4eB9zSTQ9GRZnXGqV6Vgs0cntEKdiLLbRPcw3c=;
 b=Ec7L6ynJyTdliQUYiab9yChFavhJ8L2/9cVm7SoYSzXdsCWdhUvLku/AJQbqd9ouldtFGANkgx1LRuMzUiPNA7Ts4WelJ62/EJyKWv7rden6HYmsM34vni7DShjNGH5uDTJdPHQFpq6a36wxYSYzKBEiXuyYHFU7mjMHifD9Y6E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 23:21:02 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88%3]) with mapi id 15.20.3999.032; Fri, 2 Apr 2021
 23:21:02 +0000
Subject: Re: [PATCH 05/18] xfs: create a log incompat flag for atomic extent
 swapping
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <161723935477.3149451.5072642258685986580.stgit@magnolia>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <e7178c6b-12fd-3260-065d-a44697c94001@oracle.com>
Date:   Fri, 2 Apr 2021 16:21:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <161723935477.3149451.5072642258685986580.stgit@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.1.223.248]
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.226] (67.1.223.248) by BYAPR11CA0062.namprd11.prod.outlook.com (2603:10b6:a03:80::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 23:21:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c5d0bfe-0730-40d4-8080-08d8f62dfb1c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4575:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB457512B99A0B5284184450A6957A9@SJ0PR10MB4575.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbglUjHcDd8mr3PGrNPXMMEgPkRdeAkAWNVQpoMZMAvmxSb1cQkY1rxprhhnDqpB4adtwEV9TR9IZRktkAfq0W5gyuh0qBbJ6/T9pDsSOdyHCGXx/MrJf/MIpfGoJu5mLscArK1m40dXyWL+qLeRXI4rGMaddASPRwjevb2sRbYUJSa+IjSlUYf5VIteORzrjFnsFWTWk1GWjVXAYDLDiYAla1PSCoq1homSbQGtLKnnn/bqOGInJV5dyhXtfzlO/N3RyPqDaMmkK2pMEc1/OjO9Vu7WrH6kaNaknNpiocSU6V1JbSW3Q23ybl+iEaTqAJGdDFOU33/qFH91+d4+9bZMBHL6tEXuWOoxpIqd8P+P2zFf8Ms8gs9YAItOOzHmpiwcFCq4n7KAlm8jEV26wTicAuERJwEjRN59jJpf/iXhLotgmjXDzSjcrnD9FcOmy2oi4r2gbiftkgH6kafm56b1co3KDg5D/wAtoN+EpVNvU6dVENhj1Nx3ftefEqjRlP9VqX465cmD6nGLW3tilzPL1Sl2DWlebrMmM1kghHrT/XpbtI2zhL5tgHzZ5SsgTSnJ5nUpByFVMZA8ZQNNUZzfrrY+mlsaMwQD2aWCq8mtZHQRprr4ocHqHrTPt1/19S3h1DZ/cT2JP4EdMpKrkDmC6mJXs3Wp7BD9kNObSzlh3KMVd9KKGBRH8sa3sy2ngFBTZxKytVDhN+o7da8wpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(36756003)(31686004)(86362001)(38100700001)(8676002)(52116002)(186003)(16526019)(31696002)(6486002)(53546011)(4326008)(16576012)(66946007)(66476007)(66556008)(6916009)(44832011)(956004)(2616005)(83380400001)(2906002)(316002)(8936002)(26005)(478600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WnUvN1lvbUxmWnhUVHZhY2VQUk5jSWkrekI0Z3RvL1JlaXVxcUg1WmttWTcx?=
 =?utf-8?B?T0xlVFJ1dk1ob2dKSUQ5WjlaOVFnTEF3U05Zc1R4N2ZwMDBob2lOU3Z0ZUsy?=
 =?utf-8?B?SWNFSkhEUW1XWHBtcUkwdmg2djRnWDJzTHdqb2NJSE5NUVhIMlU2bFlMell3?=
 =?utf-8?B?S0lVdU5hMnlQN1diajlUREp5WVJSQlMxZ3Y4OWl0SFg0NXNiY0ZsK05iNlpG?=
 =?utf-8?B?TzhKdGtLaHlxMkRub2pkSGdhOHQ1TC9TdDc0YURkeGh4M1FvRmI0MXVsZXhk?=
 =?utf-8?B?bkZsaE5tcjUya1V3NVlMS0h3QU1TYi9EY0hjc0wwWWpIZ2dhM09hUnBabnhk?=
 =?utf-8?B?QUFRdGFEclhQVmV3N2VNakxicjZObnBRZk5aMG0yNnRXeldpUGJISHJrU0d3?=
 =?utf-8?B?VVR4aFlBbENMSXM4Nkh2RFBsTXhHeTRkZ3hqZTk0OWt0KzU5S3B6MElYcGcv?=
 =?utf-8?B?ZFE4MnFDd0s2c0FaOTI4K3crbVVGWi9YZ2EremdVUGsvYWhRZkxxUk05azJm?=
 =?utf-8?B?Ryswb2FzNzJWVlB5YTdaNUJEOVBBdmdzSFpvK3pYU0JxUjdvZnJ1VmgrT1lj?=
 =?utf-8?B?RjIwMjhrS2xXd2N0UldPV2FTZ3NHTHZlbW5idUNHd2k3NzRWR2psRktZZFdE?=
 =?utf-8?B?VlpMZ3ovczVXSE0ydktlWmtzUlhvZTFheTQwZ0xtRCtBZFYvUXRodkFHK3lz?=
 =?utf-8?B?T2tsbHgya3BBa280OUc1VU5pRUZ4MmF2UEtXWHlvZHp2U1c1ZUFLTnFPZmpP?=
 =?utf-8?B?NmtUczNxTjBHUi9ucHpzUlJmcFFYMEMxb2MrdnZwWmN6c2VPTVJicVE4RG5I?=
 =?utf-8?B?dXNkVnVIWHBCMVIwTllZb2JJUDdLWkhzQXF1a1NwZGlRL2VpWnBwU0FvQllP?=
 =?utf-8?B?N3QxcFBBNHZNVzBZUUxpVHMydVZwMlBacTdnOVc0b21rTXRvRjRGWW1FSnNU?=
 =?utf-8?B?THI3Ky9UVnBHdy94eGkxbXVFdTRPT2NUazVQYzJWRTlJeTFWdTBoUUtkaGRs?=
 =?utf-8?B?VmNacmdZVk54Q0RaS0dJMDgxVURrNmc0ZWtXVVYzZzhSVXAwWVBkREZKTkR1?=
 =?utf-8?B?NVdIM3pNVmZ2RUIvQ291Ui9abjQ1Tjh2cko2K0xqcUZPcTc4RlMrQTFHYXFa?=
 =?utf-8?B?MGwweEJHc1FPQWo5ejFsOGNkWmNxNmUzemxJMVpYbnJNSlJPTEQ2RTNCVVhs?=
 =?utf-8?B?OVdvZTZiMVU3WFExTE52Wm9kSTJ6cnZ4d2ppbksvM1p0ZHcyamJWSytTbVdy?=
 =?utf-8?B?eDlsMmRxYVNoYVlJOUFHcVE0eUVrTytKMC9aZm1WRVVVMEhMNFdJaWRGWnFK?=
 =?utf-8?B?L3h0YWxxZDhraC9BOHF2NmlnNmdLMEMzZFY1V2R6c1QwUHZPRXowYW1XSG1h?=
 =?utf-8?B?c292RDJra2tpUFhibzdGalpzV1YwK2xhRUJEV0VOZ0hnZk5BSmpvTlRFOUZW?=
 =?utf-8?B?VzJXbHl5U1NsYmVnK0RCNmRUamFsWEZwVlRhQitGbTdLK21DSFp5c1U0UjNN?=
 =?utf-8?B?bnB4ZjE1blhJeTB5SFpZc2JFaE9peEN2NFBOMHNSTEFFRUNOY2swS2t6Z2lT?=
 =?utf-8?B?eUV6dStpem14ZC9rczVGMHhEKzg0M3lCYlVGaDNmVnhRYlQwS0taclhGanhp?=
 =?utf-8?B?TmpXQnA2TXR4UGpvam5QRVExVm9OM3hxSmdmemxjL0s2OHdXQ2FIakMybENz?=
 =?utf-8?B?dFYxYmkzYVRwWm1mVUN3WmQzeFo3TC9nSlREMXF3azZUcHZZb3F1Vzk1WGhv?=
 =?utf-8?Q?u8KY23BJueygt95DB90cploizjEEcfw0u5Kz/uc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5d0bfe-0730-40d4-8080-08d8f62dfb1c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 23:21:02.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g490WGbLGLK0NZwZ2JhDYvTyo4HUsu2KNowyKy9YI39Ay4tB7vuTgqqLnzizPTM9+T8ctteOVNI0x3+nVNWMNxAFm08wopXRtnnSDD76hLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020156
X-Proofpoint-ORIG-GUID: VMKKkthnQ4txBs9y66OGlqYG9LVoEV_g
X-Proofpoint-GUID: VMKKkthnQ4txBs9y66OGlqYG9LVoEV_g
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/31/21 6:09 PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a log incompat flag so that we only attempt to process swap
> extent log items if the filesystem supports it.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
looks ok
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

> ---
>   fs/xfs/libxfs/xfs_format.h |   20 ++++++++++++++++++++
>   fs/xfs/libxfs/xfs_fs.h     |    1 +
>   fs/xfs/libxfs/xfs_sb.c     |    2 ++
>   3 files changed, 23 insertions(+)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 7e9c964772c9..e81a7b12a0e3 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -485,6 +485,7 @@ xfs_sb_has_incompat_feature(
>   	return (sbp->sb_features_incompat & feature) != 0;
>   }
>   
> +#define XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP (1 << 0)
>   #define XFS_SB_FEAT_INCOMPAT_LOG_ALL 0
>   #define XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_LOG_ALL
>   static inline bool
> @@ -607,6 +608,25 @@ static inline bool xfs_sb_version_needsrepair(struct xfs_sb *sbp)
>   		(sbp->sb_features_incompat & XFS_SB_FEAT_INCOMPAT_NEEDSREPAIR);
>   }
>   
> +/*
> + * Decide if this filesystem can use log-assisted ("atomic") extent swapping.
> + * The atomic swap log intent items depend on the block mapping log intent
> + * items introduced with reflink and rmap.  Realtime is not supported yet.
> + */
> +static inline bool xfs_sb_version_canatomicswap(struct xfs_sb *sbp)
> +{
> +	return (xfs_sb_version_hasreflink(sbp) ||
> +		xfs_sb_version_hasrmapbt(sbp)) &&
> +		!xfs_sb_version_hasrealtime(sbp);
> +}
> +
> +static inline bool xfs_sb_version_hasatomicswap(struct xfs_sb *sbp)
> +{
> +	return XFS_SB_VERSION_NUM(sbp) == XFS_SB_VERSION_5 &&
> +		(sbp->sb_features_log_incompat &
> +		 XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP);
> +}
> +
>   /*
>    * end of superblock version macros
>    */
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index e7e1e3051739..08bfce39407e 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -252,6 +252,7 @@ typedef struct xfs_fsop_resblks {
>   #define XFS_FSOP_GEOM_FLAGS_REFLINK	(1 << 20) /* files can share blocks */
>   #define XFS_FSOP_GEOM_FLAGS_BIGTIME	(1 << 21) /* 64-bit nsec timestamps */
>   #define XFS_FSOP_GEOM_FLAGS_INOBTCNT	(1 << 22) /* inobt btree counter */
> +#define XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP	(1 << 23) /* atomic swapext */
>   
>   /*
>    * Minimum and maximum sizes need for growth checks.
> diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
> index 6adfe759190c..52791fe33a6e 100644
> --- a/fs/xfs/libxfs/xfs_sb.c
> +++ b/fs/xfs/libxfs/xfs_sb.c
> @@ -1140,6 +1140,8 @@ xfs_fs_geometry(
>   		geo->flags |= XFS_FSOP_GEOM_FLAGS_BIGTIME;
>   	if (xfs_sb_version_hasinobtcounts(sbp))
>   		geo->flags |= XFS_FSOP_GEOM_FLAGS_INOBTCNT;
> +	if (xfs_sb_version_canatomicswap(sbp))
> +		geo->flags |= XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP;
>   	if (xfs_sb_version_hassector(sbp))
>   		geo->logsectsize = sbp->sb_logsectsize;
>   	else
> 
