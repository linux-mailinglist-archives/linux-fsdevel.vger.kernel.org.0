Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ACF353177
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Apr 2021 01:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhDBXVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 19:21:03 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDBXVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 19:21:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NJtP4017384;
        Fri, 2 Apr 2021 23:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wCwwPwy/evzgUcBYHfIHIo4Kt08XHlj0Goa+kXizqu0=;
 b=oeVfICakhzNhTi7wJabvFfb4sEvMyoHwQ7WLi2snbQUfIQN5Ct2D6BytZ7ZzhBuHP3Zc
 zoNr0Z61Ys1bxiJFX/QtpYR3yzhHUyd0a+YMTpc4pIs5o1QfS513YOvOHqbl7YldG5BI
 H5C/kiSPjCyTBC2N1QNu6pZmIx01L/DkQ2mP8weU+BB/bEzWERJdSdO1zUwUKUjqtgOV
 qxr6m9ZZrxob6ulKWYfFt3fg0vlpO6pciNJ1KhFzpYhqLoFr+BjvRjRj30XLGHXMxPER
 DLprPcHV4bmuZK5HUPrRuBMQL9d44ckyEQrTcFetnqPodd6ATqyAIE60+sGjlD1y7DG9 Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37n30sdna9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:20:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NF2tg010340;
        Fri, 2 Apr 2021 23:20:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 37n2acx71r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U70ZeoIz9HXZZXYQ93lbrEbhmPvyjfrgR8UIja2ngFdxRBMCZUZncCbuU0lps0KY8+TLbeROBKuCqk5Wxpcy7VNLqQ49GJSGEdc8tbptv2mAdva9i7F3g5ta6DJ6JlAf9ShB7Z7TrHgZiFTYDP9ZwHwjQdq8jBKc8/blyvKe6iowZmmsRLdsa7tqYGTAKRFFADTnKj6ssLGqk1rXHQDOqi/RMGTYuVj8fVtpZ4snsbWzxIgjF39K3HtXaHVImOqoiC/CRbe4U7xEfon/PDxAyWMhLkIGQXBM7D+OwxqL5c55GrhjGjbgtWWhbCqnm122mLrdMtNwvrxr+06x53qehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCwwPwy/evzgUcBYHfIHIo4Kt08XHlj0Goa+kXizqu0=;
 b=bwCOTh5QyJ50Onr0rEL1bnZujoZ7uq+Mry5NvOtK3CjCYpDKKfHhH7o4I9arU/q5QSU0rJCAANlJIoQ0ACykKPYOdfCZMZOHDps4qhLUKhcyrogWYanW4KLgubAZNO7wfwmXsXGWsi+UJs1wbcoT0NoA5iPRm3WsIk6D1lff8Hq/GpH9o1LqxIQagOTk0wp6oihsvd42uuko9ZdgUwoRBrBkNCxghDI0qpnKJdmciPtq0wgyABOA05hv2XBqAT3USa5+G8FRkktPC73PBNNwsYEKy5nB+lBIklH/AV6yFjdyrk3hOFMMn9qcLpA9bYb+gb850wQe9iKlXifCiZgmgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCwwPwy/evzgUcBYHfIHIo4Kt08XHlj0Goa+kXizqu0=;
 b=ZpsfKgrZJg+NVUsWoKulIRlZGkN62O5ZrOtH8or3ayvzguwciA6UYfjhJvGvolc9TaPmJRporf0QNHQ2OruI23+bizCP4eeMbsv+yqrQD30gtQ5NB226giyKkNHoSVcUTCDz7hE0p8nTzcI37RehaSfrOJ+hBes180XJ2oSmiYg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BYAPR10MB2789.namprd10.prod.outlook.com (2603:10b6:a03:82::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 23:20:56 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88%3]) with mapi id 15.20.3999.032; Fri, 2 Apr 2021
 23:20:56 +0000
Subject: Re: [PATCH 04/18] xfs: clear log incompat feature bits when the log
 is idle
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <161723934912.3149451.16053630119296453937.stgit@magnolia>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <fc3f091d-fced-b342-6d58-f31a6552eccb@oracle.com>
Date:   Fri, 2 Apr 2021 16:20:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <161723934912.3149451.16053630119296453937.stgit@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.1.223.248]
X-ClientProxiedBy: BYAPR11CA0046.namprd11.prod.outlook.com
 (2603:10b6:a03:80::23) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.226] (67.1.223.248) by BYAPR11CA0046.namprd11.prod.outlook.com (2603:10b6:a03:80::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 23:20:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 972d941c-526e-431c-887c-08d8f62df7a9
X-MS-TrafficTypeDiagnostic: BYAPR10MB2789:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2789FAA7B932D914B526648A957A9@BYAPR10MB2789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 421+GxlcNk4Sil82hsa6iiQuQ62W0uODN9m7iK/a9K4C3Di1LnAL8xuNS1cfFoAqrShTC7bCWwzg71y7J0GSLW07oLS0KNDaQquDzasX05PcQBVDifvGxxjGjDjCDHnBpmBzZY6OZFIHljMi/TqbzuNsYwgP17Vt9HWxh0l41PLPqthX7Fzr6W7wd3drBH0DjYmoe2oQxapsJ7tDNfPd1UZS5v6od5YhJXDQfE4SBihBbMbqxzWlRjIDNLFUplFQVFG+AZYZ76i8E1XEi+OJubRirVq7jWe0vjQvLoHGjCEqTixcv6iQRY+yZr3jB+ljPO8ECvV1mTLeWU9XTOx4o5kShmAiRW4+BgpNbd+9ZDvg3ylfEBYLYTwgJc1O+YNYHW9E14sB5qvXHEi4UHlXBRMVIBGD3a88P5Z6I3dO9T9gdcX7XDQg+vxmySiBmfBdBE/OTmW2HzUOffweQwNVuv7sldh5B6CFUIPBnr3vsVTRKRsMtdZK8FXezCm8hImDIn6x4k7L9E7FAxlOfGZDCDXRiP6dl83qNDmmN974wFWPNJvxH0TvZ6uo6XQYY55ZKyprTu0bsw+g/QlGExuA6eCG60EXmqoPu/bz5EhFC/F25qcpsEIzqqtUcY6+N9to3gVi0pUUVADi8fpzFOjKPSninxRgOYCDgEWNsCo8n9ZpWg2m5wY4kPhv9GppWO/Pshhl5w0/fWquRjseVZiP+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(396003)(346002)(66476007)(66556008)(316002)(44832011)(36756003)(4326008)(16526019)(86362001)(38100700001)(31686004)(6916009)(8676002)(66946007)(8936002)(16576012)(31696002)(53546011)(52116002)(6486002)(478600001)(83380400001)(2616005)(956004)(186003)(26005)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?a3FNL2dUbjY2NGk4MGpqTWVOdStzOEdWTEFLVmNEOXA4K2lyZVBHZDdYZGVn?=
 =?utf-8?B?ZzlZOUJNVzR2VURlL3FMRjRZWEptczROR1AzRHRpQlAxK2xjMG1tZ3FSZ0lD?=
 =?utf-8?B?aW5rTi9TdTljZVBOSGIzMEtGMUJ6SS9PR2RVczRNNks3NmdOQmxlY3FuZmwz?=
 =?utf-8?B?WXV4Q0t5UW0yNlBBNmtZeXVPTllRODFUYlNVZkNmRHl3UW1pSnJ4Vm9ha21a?=
 =?utf-8?B?QUkwTVVjVWl5NE9DaUJ5MTFOV3FhTkZHOTM5WkRYQnVkUXo1MkluOVVBWjcv?=
 =?utf-8?B?ZVJBYzBSTUtDMFhYZXBzZThoOGFpb1lidmxSckpIOUNPTHBQaHZUMUJQa3Fh?=
 =?utf-8?B?NytLUmNSQWcwNDg2R3g3QWh3SzJMYlgvNlJtRUZxd3o5RnVqL1grM0RnbUlB?=
 =?utf-8?B?THgxZWlSSEVNRVlMQlhoRmlDWTNUaWRtM09yemRmWHVyeVdnSCtvVTNRTTVQ?=
 =?utf-8?B?cCs3MkhlY0w0Yjl3MHY0MTdORzgyWFpUQ2FaLzR5MUw1ZFdLVmt5dVhpb3NT?=
 =?utf-8?B?NDFUTmxmd0FmNzdJOXdaVEU4eFJpSEc2RTVPUitJWERHMHUyZmU4VkZZYnBJ?=
 =?utf-8?B?ZDU5ZHUrajFwZEZqWWlJTFJrRE5rRW5YV2IxYkpiMGRFQWRrL3VnU0NVUnJH?=
 =?utf-8?B?SFNGU0twYWxMU1gwNEw3RHhsSmQ1VE5RWi93c1lWTVo2R1NoR25IWm55T2FM?=
 =?utf-8?B?UU1XODlzNlJoeU45NGw4NDdIZUF3TkNYbWVRc3hjUmtlK0x3S2FKWmlOenQz?=
 =?utf-8?B?T0NPelYvTzliL3BBYnN6eko1WjYxNzRqTk1IT3BmaWZ0RHg4WGhZbHZuYjl0?=
 =?utf-8?B?T010cDFJVkUyU3oyT3Nwb0c5UUV1NElCMElWWXc1TTlwNUFkcmlYaVZpa2pS?=
 =?utf-8?B?WVljVEl1UFVSY0ZZcHhrc0xUaCtCNEpDQ0dZaExGazlZdUZXNzdnM3FpUERS?=
 =?utf-8?B?VzRkaEI0Q3U5RVhlMkFZb3N0eC8zSkR0TGZRRUdaZDlQa1MvNFBXOEpVVUQw?=
 =?utf-8?B?RnNycFdoZnk2c01WMlNTWEZKZHdWRWE0QWdQdTRKTjZSMGd6VFpGazliZFRV?=
 =?utf-8?B?MFVGb2E1NkY4YXRIVHMxOXQyV2YyN3JITGVueE1zWFZza21uTmlnWmdUZW5M?=
 =?utf-8?B?Q2lBdC8zR3Z4M0k4dzBQajJheXgzM2VUOS9qMkdhcWFtcjU0TFZ3WG1rMHpB?=
 =?utf-8?B?NTVDR0VQeWhEOWVCVEJocWI4dldtcWJrc0pFS285THczS0U3aWtsV1d0WHVR?=
 =?utf-8?B?NjBhZ3ZabVJxUGZybDUwdGJrM01qWHpHMkxGV3lmUkFWNFZMMGt1MDRmb3g2?=
 =?utf-8?B?eXc4WVBHVkIvbEtaY2ZOemdqWGhyMElDTnpTcEhjWG9VdGl0NW1SL1dBQlMv?=
 =?utf-8?B?akZDcWJwOW9mOFdrbElmdGcyZEhZU3k3OW1WeUZ4bUFDL0J4RExlOU8vdnd4?=
 =?utf-8?B?NXhYY0pPaUhxeWdWMzhPNlZNZUxjSUFXTUMxVmpkSzlSanRWR1UzZFdPeXRo?=
 =?utf-8?B?M3FMWVFFbjJMSmdnd0d6SENiTnZ1SlRET24xV2lPcUdHdXpJbXJNTUlHMW5M?=
 =?utf-8?B?eFRkK2o0VGJvRHc2S0dJdU1pbEFEcDh3ckQwU3lkNW9RWmZtdGNSUFp0S0ZY?=
 =?utf-8?B?bDRHd1dJamF6WU1rOEF5aEdXVmJFOWNEME1lT1JrWk4wcHRCWnRRL2ZCaWdC?=
 =?utf-8?B?MzF5OGZpQmdtWEJraWlmaG4vVllYbUJVOHlVRmZBaE84N24vVlprY1Y3d0xO?=
 =?utf-8?Q?4Dl9s2IMj/bysSMbSnLfymRofgFfxD+SDVmPWEM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972d941c-526e-431c-887c-08d8f62df7a9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 23:20:56.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+QyoIjqzY3WZDYn7hbmflSdpl2SG3/o9qGuFW6AVTai8LXMhmO0fzqYum9iHFCwoLpm8lXGGHh5sW/Joef9kS4peXMFq/YbNnBhhQ+/mMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2789
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020156
X-Proofpoint-GUID: 7sFxeU3QmlKSaEdC15U8_5GJTHN06j23
X-Proofpoint-ORIG-GUID: 7sFxeU3QmlKSaEdC15U8_5GJTHN06j23
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/31/21 6:09 PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> When there are no ongoing transactions and the log contents have been
> checkpointed back into the filesystem, the log performs 'covering',
> which is to say that it log a dummy transaction to record the fact that
> the tail has caught up with the head.  This is a good time to clear log
> incompat feature flags, because they are flags that are temporarily set
> to limit the range of kernels that can replay a dirty log.
> 
> Since it's possible that some other higher level thread is about to
> start logging items protected by a log incompat flag, we create a rwsem
> so that upper level threads can coordinate this with the log.  It would
> probably be more performant to use a percpu rwsem, but the ability to
> /try/ taking the write lock during covering is critical, and percpu
> rwsems do not provide that.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
ok, makes sense
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

> ---
>   fs/xfs/libxfs/xfs_shared.h |    6 +++++
>   fs/xfs/xfs_log.c           |   49 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/xfs/xfs_log.h           |    3 +++
>   fs/xfs/xfs_log_priv.h      |    3 +++
>   fs/xfs/xfs_trans.c         |   14 +++++++++----
>   5 files changed, 71 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_shared.h b/fs/xfs/libxfs/xfs_shared.h
> index 8c61a461bf7b..c7c9a0cebb04 100644
> --- a/fs/xfs/libxfs/xfs_shared.h
> +++ b/fs/xfs/libxfs/xfs_shared.h
> @@ -62,6 +62,12 @@ void	xfs_log_get_max_trans_res(struct xfs_mount *mp,
>   #define	XFS_TRANS_SB_DIRTY	0x02	/* superblock is modified */
>   #define	XFS_TRANS_PERM_LOG_RES	0x04	/* xact took a permanent log res */
>   #define	XFS_TRANS_SYNC		0x08	/* make commit synchronous */
> +/*
> + * This transaction uses a log incompat feature, which means that we must tell
> + * the log that we've finished using it at the transaction commit or cancel.
> + * Callers must call xlog_use_incompat_feat before setting this flag.
> + */
> +#define XFS_TRANS_LOG_INCOMPAT	0x10
>   #define XFS_TRANS_RESERVE	0x20    /* OK to use reserved data blocks */
>   #define XFS_TRANS_NO_WRITECOUNT 0x40	/* do not elevate SB writecount */
>   #define XFS_TRANS_RES_FDBLKS	0x80	/* reserve newly freed blocks */
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index cf73bc9f4d18..cb72be62da3e 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -1335,6 +1335,32 @@ xfs_log_work_queue(
>   				msecs_to_jiffies(xfs_syncd_centisecs * 10));
>   }
>   
> +/*
> + * Clear the log incompat flags if we have the opportunity.
> + *
> + * This only happens if we're about to log the second dummy transaction as part
> + * of covering the log and we can get the log incompat feature usage lock.
> + */
> +static inline void
> +xlog_clear_incompat(
> +	struct xlog		*log)
> +{
> +	struct xfs_mount	*mp = log->l_mp;
> +
> +	if (!xfs_sb_has_incompat_log_feature(&mp->m_sb,
> +				XFS_SB_FEAT_INCOMPAT_LOG_ALL))
> +		return;
> +
> +	if (log->l_covered_state != XLOG_STATE_COVER_DONE2)
> +		return;
> +
> +	if (!down_write_trylock(&log->l_incompat_users))
> +		return;
> +
> +	xfs_clear_incompat_log_features(mp);
> +	up_write(&log->l_incompat_users);
> +}
> +
>   /*
>    * Every sync period we need to unpin all items in the AIL and push them to
>    * disk. If there is nothing dirty, then we might need to cover the log to
> @@ -1361,6 +1387,7 @@ xfs_log_worker(
>   		 * synchronously log the superblock instead to ensure the
>   		 * superblock is immediately unpinned and can be written back.
>   		 */
> +		xlog_clear_incompat(log);
>   		xfs_sync_sb(mp, true);
>   	} else
>   		xfs_log_force(mp, 0);
> @@ -1443,6 +1470,8 @@ xlog_alloc_log(
>   	}
>   	log->l_sectBBsize = 1 << log2_size;
>   
> +	init_rwsem(&log->l_incompat_users);
> +
>   	xlog_get_iclog_buffer_size(mp, log);
>   
>   	spin_lock_init(&log->l_icloglock);
> @@ -3933,3 +3962,23 @@ xfs_log_in_recovery(
>   
>   	return log->l_flags & XLOG_ACTIVE_RECOVERY;
>   }
> +
> +/*
> + * Notify the log that we're about to start using a feature that is protected
> + * by a log incompat feature flag.  This will prevent log covering from
> + * clearing those flags.
> + */
> +void
> +xlog_use_incompat_feat(
> +	struct xlog		*log)
> +{
> +	down_read(&log->l_incompat_users);
> +}
> +
> +/* Notify the log that we've finished using log incompat features. */
> +void
> +xlog_drop_incompat_feat(
> +	struct xlog		*log)
> +{
> +	up_read(&log->l_incompat_users);
> +}
> diff --git a/fs/xfs/xfs_log.h b/fs/xfs/xfs_log.h
> index 044e02cb8921..8b7d0a56cbf1 100644
> --- a/fs/xfs/xfs_log.h
> +++ b/fs/xfs/xfs_log.h
> @@ -145,4 +145,7 @@ bool	xfs_log_in_recovery(struct xfs_mount *);
>   
>   xfs_lsn_t xlog_grant_push_threshold(struct xlog *log, int need_bytes);
>   
> +void xlog_use_incompat_feat(struct xlog *log);
> +void xlog_drop_incompat_feat(struct xlog *log);
> +
>   #endif	/* __XFS_LOG_H__ */
> diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
> index 1c6fdbf3d506..75702c4fa69c 100644
> --- a/fs/xfs/xfs_log_priv.h
> +++ b/fs/xfs/xfs_log_priv.h
> @@ -436,6 +436,9 @@ struct xlog {
>   #endif
>   	/* log recovery lsn tracking (for buffer submission */
>   	xfs_lsn_t		l_recovery_lsn;
> +
> +	/* Users of log incompat features should take a read lock. */
> +	struct rw_semaphore	l_incompat_users;
>   };
>   
>   #define XLOG_BUF_CANCEL_BUCKET(log, blkno) \
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index eb2d8e2e5db6..e548d53c2091 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -71,6 +71,9 @@ xfs_trans_free(
>   	xfs_extent_busy_sort(&tp->t_busy);
>   	xfs_extent_busy_clear(tp->t_mountp, &tp->t_busy, false);
>   
> +	if (tp->t_flags & XFS_TRANS_LOG_INCOMPAT)
> +		xlog_drop_incompat_feat(tp->t_mountp->m_log);
> +
>   	trace_xfs_trans_free(tp, _RET_IP_);
>   	xfs_trans_clear_context(tp);
>   	if (!(tp->t_flags & XFS_TRANS_NO_WRITECOUNT))
> @@ -110,10 +113,13 @@ xfs_trans_dup(
>   	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
>   	ASSERT(tp->t_ticket != NULL);
>   
> -	ntp->t_flags = XFS_TRANS_PERM_LOG_RES |
> -		       (tp->t_flags & XFS_TRANS_RESERVE) |
> -		       (tp->t_flags & XFS_TRANS_NO_WRITECOUNT) |
> -		       (tp->t_flags & XFS_TRANS_RES_FDBLKS);
> +	ntp->t_flags = tp->t_flags & (XFS_TRANS_PERM_LOG_RES |
> +				      XFS_TRANS_RESERVE |
> +				      XFS_TRANS_NO_WRITECOUNT |
> +				      XFS_TRANS_RES_FDBLKS |
> +				      XFS_TRANS_LOG_INCOMPAT);
> +	/* Give our LOG_INCOMPAT reference to the new transaction. */
> +	tp->t_flags &= ~XFS_TRANS_LOG_INCOMPAT;
>   	/* We gave our writer reference to the new transaction */
>   	tp->t_flags |= XFS_TRANS_NO_WRITECOUNT;
>   	ntp->t_ticket = xfs_log_ticket_get(tp->t_ticket);
> 
