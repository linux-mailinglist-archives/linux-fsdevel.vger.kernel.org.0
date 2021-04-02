Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25715353175
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Apr 2021 01:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhDBXUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 19:20:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43506 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDBXUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 19:20:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NKpb1017968;
        Fri, 2 Apr 2021 23:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Qz8Hccl+PYzVEHSmsj+QSZRj0KO5+VCBlR/iyZtbFio=;
 b=yP2S9cN1AXHVOp8aE+aVm4J9/gu4z/6SMMLv6Izimj7ithtvnsx4CW/4XD0RnC/vusCp
 62WCDtxavbv1IbwMS9n3NSz0GTqXuuBjfiG5fq8pSRT1zAmz6eZOLQ4Zp6IWENblHXah
 e51ZeNjLxtqVcWdGzY3GDAX1YQBrX0ZK2MhFgQt7vI9AaU6K9FVJDU0QpA1RX0A+SjnP
 EYR0Ypq3mTZw6SvIs/ts47K8Atuzrs1Jrkc+bZi2GvES2KlRBXjqNSOJhpU1TSOY/e6J
 EFlTARE0fQHUmoG4qNbYZF35wjwZ7Sg318JC9yg2dJ74WvzbTYY9Pe0VQlaG5vaZcX42 yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37n30sdn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:20:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NFfDT056335;
        Fri, 2 Apr 2021 23:20:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by userp3030.oracle.com with ESMTP id 37n2auhg9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl5UUjqVZfo5w5I8FzJR/N+FsWhCGaud2wQNJJu/uS9z7f7Gq9tFP9IHreNgDDAlLLckSp6JJLhmj1GmDFlgfSOGeXGff/r1ZtIiKeq4vMb2W0Rbo8V4sKN97rhnyu04s9ZNEsEt9RvjOq4GpFbrOXGRM0hKv1xUo+zL0bcUdO+Z2bGii3+X+lakQ6+eSIGTg5JwSEmbRxshaBiUlJkcgl3FVCHn9lxx/kJI/vvJcnL5wElOelARf7IjNpKmMjMJVvNRY8julLXlBwNSOTp8ATQxeA2rd83ib7c/QuUAh4wIZjhBeLU6gCLMxi/nJEclzGu4xPHTndTVZpZ8RNCf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz8Hccl+PYzVEHSmsj+QSZRj0KO5+VCBlR/iyZtbFio=;
 b=XXlukGxRqGh5dMBh+2qWqfxKCoFbcXL+Kc9HD/ZDJAxexZGI5IdaXZ+aBXGqsxjqvEZ9/GOkrTibCvuMAAIuLOzRB1H70n/CZChIKaOLySYPGsnlRdTN5+pYS4cD0xKSUUd4EjqESAxE13hRXMyKoyBh2M0JibtUjH/VPw3WZ2BBcM6TDvkt29FWdZshYf5QSfwqPE8v+iyhzxRbFOtLJ6VnFBCmSrfsxiNB+rlWo4PeWZ0ZdyGLg8JJUJMA+fiyU5l9yZqEN+DQvzEjgCI0BAh0abcZK7RdW3u7OuE61GdvyHHmKo+qZb6qpGdukWd/6T2U7Q9FGf6zZUCr0jQagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz8Hccl+PYzVEHSmsj+QSZRj0KO5+VCBlR/iyZtbFio=;
 b=IMiI6EQcSNQWwQc9vKyy4WgFuT+bZ4E7ra9CkpxIL7Hn2UWdjCidcDdtCgXVcDkwvzf2I+O9E52VjXZooDPt2A/p9DVEpS/+hpeXTAfDnSe5fO5DAagb0D1u1458cgzSV1eJT65Y2R6yTTpogXfwyB/iHL21sg6yxgKKJcGK73Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BYAPR10MB2789.namprd10.prod.outlook.com (2603:10b6:a03:82::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 23:20:48 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88%3]) with mapi id 15.20.3999.032; Fri, 2 Apr 2021
 23:20:48 +0000
Subject: Re: [PATCH 03/18] xfs: allow setting and clearing of log incompat
 feature flags
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <161723934343.3149451.16679733325094950568.stgit@magnolia>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <496a3d16-f53d-96f9-5fcd-cef5d03b2487@oracle.com>
Date:   Fri, 2 Apr 2021 16:20:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <161723934343.3149451.16679733325094950568.stgit@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.1.223.248]
X-ClientProxiedBy: BYAPR11CA0037.namprd11.prod.outlook.com
 (2603:10b6:a03:80::14) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.226] (67.1.223.248) by BYAPR11CA0037.namprd11.prod.outlook.com (2603:10b6:a03:80::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Fri, 2 Apr 2021 23:20:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 548a679c-8f5a-4082-3d04-08d8f62df2fc
X-MS-TrafficTypeDiagnostic: BYAPR10MB2789:
X-Microsoft-Antispam-PRVS: <BYAPR10MB27897A5FA2E3081D52FC5988957A9@BYAPR10MB2789.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hl43PkK3FsWkQkz2xz7CU30aF0iKhsupSfCfx3avDEJvqvePk48IltcZIgFFbTh3YdDnQQyz300mH8qQloVQU0WLJQSH243YtNde3+K7IBVpK6w70lNqr2nVMcaCjpcu2uMpwyhXDYMWlFBlht9W6PyA45uEVSyhWd0uUl7LxRLNX7l8y+NN6ZGNjtnX+YEpHgPhHi4gN2sTISgh2NpQuNH3Mf1uxfuqLhFzLD4QytI1iX0kN/O9eRkuNnpG9dLnLSHBs8gJQiK2qnPF7uB0g7J3hn2HyFFD40EFzEa5MXzCRvGb1fFXr+lChjwomT9wu6y12lg5tZQ/voQlicX/ggQvzyghbAf+SxCyAbRW5INd1t+28BCSVajivlNJdGcX5AjuH/OTSSLYx7OmDwXq+qcLrkHwIusAGhebhJgNjFgHIJhJye5Yq4oTFbvlpXfhsNRIplUh5QMJeVb+yRPk71udKLoCX+uC9demJyfT/N59hH0YslluG1UlG+gOJKcqVbPbwi2OIalttqBGT6ihhOgXRe+Q4xN9ak0Qc5Ih1+TUC1Tf5LGvRw+JGXtjUcApMa58QK/dID1Rd9q6W8URaXBETY0N+NuVbnBqj6Zh/aKkHkVjyHDOWJrDAatew8p1NWaXIwHU871hnyvawCgGSaUt8pHvNurHIRlp/BUy49QziKNjCN7/kSUQi931VAf0Zxh/WNJEifja9tbl83u3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(396003)(346002)(66476007)(66556008)(316002)(44832011)(36756003)(4326008)(16526019)(86362001)(38100700001)(31686004)(6916009)(8676002)(66946007)(8936002)(16576012)(31696002)(53546011)(52116002)(6486002)(478600001)(83380400001)(2616005)(956004)(186003)(26005)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cVJPOUxMWVh3TGlDS1FCeEQ2QWdwUHVqUVNHWVBjN2NlcWsyWDZmTS9WNm9p?=
 =?utf-8?B?NGpOdng5b2VPQWNIVWtmdHg2Q1o0dEJTYnE0b1pZYTlvRVVveTBkeExYNUtO?=
 =?utf-8?B?M0dKWEU5Zmp1NTkyRVJBSkpFMGRtam9hL3UyZ0VhdFhEcUpRZDdnWjBHOTYz?=
 =?utf-8?B?Zm5uU3h5UFphWkVtYTZEeTIyRHpNR1AyeVZjZllWUDhHQlRMcmFIUG43UUxD?=
 =?utf-8?B?ZTV6RTFEd3RNaHdzSjBGOXd2RGFMSTdkWndpL2MzOVZqQ2orZys3U0o2Q05q?=
 =?utf-8?B?UFRPUmY2R3J3R0NCSmM0dE03RzY4SWV6cTNLcC9BQkVCZlpEV0JxWktjbHZW?=
 =?utf-8?B?d21qeHRxY29PZmFDZFI5b1lkb2g1NFFvQ2tCWXgyTkRMM0ZjYWpDMXpCbkRZ?=
 =?utf-8?B?N1ZxeTh6QzFBTUtsdHJ1UHZhS3owcVJ6TVg4MVAvaURHVFdGaVVPd1RZa1RO?=
 =?utf-8?B?Znd3Ym5wWWZQNGFUU2t3ajNGQmQ2Q2h6dVkyMDFXQXQycjFGdktYN0lidHZC?=
 =?utf-8?B?ajlycVl5OVpEQ1BzYlZybW1Rbi9RQm44QUZiUVV6cWhxNkRWL1luMHdzMnQw?=
 =?utf-8?B?aE9QUmxMVHB6RzVCczE2dVhmQzB2eGVjOTVyRlB2SGQxSHYxVDBldU4zczc4?=
 =?utf-8?B?cU1vRk12NVBpeGptREhGc0hDSm1BYXZpT0d4cUsva1F5bUhQKzY3bHkxbjQv?=
 =?utf-8?B?eGFTbUR4QkJMdldBcHdZd3pETlIzQWlXUEJjVWtVZnFWOU12UUpLQnFnaFBE?=
 =?utf-8?B?alczcVAxTUFaZ09XUkdWcFhMYzV5U3U1dzdhRHV4M25jUjNNSmdIYUNZcTBN?=
 =?utf-8?B?dXg3dHJmaU1wYm5pZUJFaVlGdEhvWDVHQzhUK0tWQ2J5M3R2c1JKb0RKa0VW?=
 =?utf-8?B?cWE5Qk1WTlVCVTJZVTRrTjNhZ0h6aVMwT1orYUkrRFZYaXl5WkhJQVV1YUE4?=
 =?utf-8?B?QkhneU9Ra1VjeDVyMDBlQUFrOGZYZmtCOU9IdE1YZVJWV1lJMDJlVlc3b2xO?=
 =?utf-8?B?VkJQUitGN0doZGE0anB4ZkthZ3BqQkhRM1l5KzJxSHhOWDFSSjV1aDRtZXBo?=
 =?utf-8?B?Y2V2emhZc1k0ZHJWZ0tiZmFkdDRON0pDV0hETUJRaVlhcUtXRHRBNElDWTV4?=
 =?utf-8?B?d1ZZZWtPem5UeGxsWGV1SHduZnRxUy9UczI2NGFrZTB6dkl2MnIwc2RWSDcz?=
 =?utf-8?B?ZnNGekpuYk1rTkdDLzNqT09LbXFyOWwrVUFtRGU3ZFg5ekpHckozNklVbTU4?=
 =?utf-8?B?dmQxTHZPbjlRbmc0TGZHTDRUVjloZ1hxNUZMRWNMTjJ3aEVVNUhUckZlQ1dT?=
 =?utf-8?B?Y3E3YVRUc1Z4aU1jalRRZk05UFFzQS9TT1dhOEExLzFSWEVXbnV4TzJKdUln?=
 =?utf-8?B?MHo1YXkzcE9QYlFsQ2tBS2xZMEVYTXNBTEZhRGlLTXVBbk54c1phWmlEL0da?=
 =?utf-8?B?U3hhN2VjMmZOU1QvRVlYQWNnVU5wcDg5dGhlSTc2UU4xNGxvWXJOUUQ3YWdv?=
 =?utf-8?B?VVRDcGtJVGJhMXp0MWx4QmVkZWY1bThwNFpJenQzOXNma0JkWHVub25pOS9r?=
 =?utf-8?B?MmZqeldEZlh4azNFNStBaXZvZEM1UlVqbDhPU1dOS3R0dEJmWDEvT3h1bmpY?=
 =?utf-8?B?TVAvZFlLOG10Wm03S3U4VElSRnY1VTF2aE83OGlGRzduZVpWcGZkVDdkWXNV?=
 =?utf-8?B?N2tteHNqR2ZmeFhsNFFzMWJuQVdERFozUk4yTkpNaVd1YUJvZktKN0s0TEJv?=
 =?utf-8?Q?/ompR+6/Qlmplq8Vgsd9uO2zUZv8ZLXbU2PEtQB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548a679c-8f5a-4082-3d04-08d8f62df2fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 23:20:48.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJdP2QuocybO2kTJy3TS3YGFm+gj0yNuqTDGw1waNVam5jD+HTU4dCw1t51EYzagrzFx8YqMWsmBBOywArbnhESJ+YowfCE2ob1bn+jsEvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2789
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020156
X-Proofpoint-GUID: TWutrThs77O27VwA-0nGwka-EVh2JaGU
X-Proofpoint-ORIG-GUID: TWutrThs77O27VwA-0nGwka-EVh2JaGU
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
> Log incompat feature flags in the superblock exist for one purpose: to
> protect the contents of a dirty log from replay on a kernel that isn't
> prepared to handle those dirty contents.  This means that they can be
> cleared if (a) we know the log is clean and (b) we know that there
> aren't any other threads in the system that might be setting or relying
> upon a log incompat flag.
> 
> Therefore, clear the log incompat flags when we've finished recovering
> the log, when we're unmounting cleanly, remounting read-only, or
> freezing; and provide a function so that subsequent patches can start
> using this.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Ok, seems reasonable
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

> ---
>   fs/xfs/libxfs/xfs_format.h |   15 ++++++
>   fs/xfs/xfs_log.c           |   14 ++++++
>   fs/xfs/xfs_log_recover.c   |   16 ++++++
>   fs/xfs/xfs_mount.c         |  110 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/xfs/xfs_mount.h         |    2 +
>   5 files changed, 157 insertions(+)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 9620795a6e08..7e9c964772c9 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -495,6 +495,21 @@ xfs_sb_has_incompat_log_feature(
>   	return (sbp->sb_features_log_incompat & feature) != 0;
>   }
>   
> +static inline void
> +xfs_sb_remove_incompat_log_features(
> +	struct xfs_sb	*sbp)
> +{
> +	sbp->sb_features_log_incompat &= ~XFS_SB_FEAT_INCOMPAT_LOG_ALL;
> +}
> +
> +static inline void
> +xfs_sb_add_incompat_log_features(
> +	struct xfs_sb	*sbp,
> +	unsigned int	features)
> +{
> +	sbp->sb_features_log_incompat |= features;
> +}
> +
>   /*
>    * V5 superblock specific feature checks
>    */
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index 06041834daa3..cf73bc9f4d18 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -945,6 +945,20 @@ int
>   xfs_log_quiesce(
>   	struct xfs_mount	*mp)
>   {
> +	/*
> +	 * Clear log incompat features since we're quiescing the log.  Report
> +	 * failures, though it's not fatal to have a higher log feature
> +	 * protection level than the log contents actually require.
> +	 */
> +	if (xfs_clear_incompat_log_features(mp)) {
> +		int error;
> +
> +		error = xfs_sync_sb(mp, false);
> +		if (error)
> +			xfs_warn(mp,
> +	"Failed to clear log incompat features on quiesce");
> +	}
> +
>   	cancel_delayed_work_sync(&mp->m_log->l_work);
>   	xfs_log_force(mp, XFS_LOG_SYNC);
>   
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index ce1a7928eb2d..fdba9b55822e 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -3480,6 +3480,22 @@ xlog_recover_finish(
>   		 */
>   		xfs_log_force(log->l_mp, XFS_LOG_SYNC);
>   
> +		/*
> +		 * Now that we've recovered the log and all the intents, we can
> +		 * clear the log incompat feature bits in the superblock
> +		 * because there's no longer anything to protect.  We rely on
> +		 * the AIL push to write out the updated superblock after
> +		 * everything else.
> +		 */
> +		if (xfs_clear_incompat_log_features(log->l_mp)) {
> +			error = xfs_sync_sb(log->l_mp, false);
> +			if (error < 0) {
> +				xfs_alert(log->l_mp,
> +	"Failed to clear log incompat features on recovery");
> +				return error;
> +			}
> +		}
> +
>   		xlog_recover_process_iunlinks(log);
>   
>   		xlog_recover_check_summary(log);
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index b7e653180d22..f16036e1986b 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -1333,6 +1333,116 @@ xfs_force_summary_recalc(
>   	xfs_fs_mark_checked(mp, XFS_SICK_FS_COUNTERS);
>   }
>   
> +/*
> + * Enable a log incompat feature flag in the primary superblock.  The caller
> + * cannot have any other transactions in progress.
> + */
> +int
> +xfs_add_incompat_log_feature(
> +	struct xfs_mount	*mp,
> +	uint32_t		feature)
> +{
> +	struct xfs_dsb		*dsb;
> +	int			error;
> +
> +	ASSERT(hweight32(feature) == 1);
> +	ASSERT(!(feature & XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN));
> +
> +	/*
> +	 * Force the log to disk and kick the background AIL thread to reduce
> +	 * the chances that the bwrite will stall waiting for the AIL to unpin
> +	 * the primary superblock buffer.  This isn't a data integrity
> +	 * operation, so we don't need a synchronous push.
> +	 */
> +	error = xfs_log_force(mp, XFS_LOG_SYNC);
> +	if (error)
> +		return error;
> +	xfs_ail_push_all(mp->m_ail);
> +
> +	/*
> +	 * Lock the primary superblock buffer to serialize all callers that
> +	 * are trying to set feature bits.
> +	 */
> +	xfs_buf_lock(mp->m_sb_bp);
> +	xfs_buf_hold(mp->m_sb_bp);
> +
> +	if (XFS_FORCED_SHUTDOWN(mp)) {
> +		error = -EIO;
> +		goto rele;
> +	}
> +
> +	if (xfs_sb_has_incompat_log_feature(&mp->m_sb, feature))
> +		goto rele;
> +
> +	/*
> +	 * Write the primary superblock to disk immediately, because we need
> +	 * the log_incompat bit to be set in the primary super now to protect
> +	 * the log items that we're going to commit later.
> +	 */
> +	dsb = mp->m_sb_bp->b_addr;
> +	xfs_sb_to_disk(dsb, &mp->m_sb);
> +	dsb->sb_features_log_incompat |= cpu_to_be32(feature);
> +	error = xfs_bwrite(mp->m_sb_bp);
> +	if (error)
> +		goto shutdown;
> +
> +	/*
> +	 * Add the feature bits to the incore superblock before we unlock the
> +	 * buffer.
> +	 */
> +	xfs_sb_add_incompat_log_features(&mp->m_sb, feature);
> +	xfs_buf_relse(mp->m_sb_bp);
> +
> +	/* Log the superblock to disk. */
> +	return xfs_sync_sb(mp, false);
> +shutdown:
> +	xfs_force_shutdown(mp, SHUTDOWN_META_IO_ERROR);
> +rele:
> +	xfs_buf_relse(mp->m_sb_bp);
> +	return error;
> +}
> +
> +/*
> + * Clear all the log incompat flags from the superblock.
> + *
> + * The caller cannot be in a transaction, must ensure that the log does not
> + * contain any log items protected by any log incompat bit, and must ensure
> + * that there are no other threads that depend on the state of the log incompat
> + * feature flags in the primary super.
> + *
> + * Returns true if the superblock is dirty.
> + */
> +bool
> +xfs_clear_incompat_log_features(
> +	struct xfs_mount	*mp)
> +{
> +	bool			ret = false;
> +
> +	if (!xfs_sb_version_hascrc(&mp->m_sb) ||
> +	    !xfs_sb_has_incompat_log_feature(&mp->m_sb,
> +				XFS_SB_FEAT_INCOMPAT_LOG_ALL) ||
> +	    XFS_FORCED_SHUTDOWN(mp))
> +		return false;
> +
> +	/*
> +	 * Update the incore superblock.  We synchronize on the primary super
> +	 * buffer lock to be consistent with the add function, though at least
> +	 * in theory this shouldn't be necessary.
> +	 */
> +	xfs_buf_lock(mp->m_sb_bp);
> +	xfs_buf_hold(mp->m_sb_bp);
> +
> +	if (xfs_sb_has_incompat_log_feature(&mp->m_sb,
> +				XFS_SB_FEAT_INCOMPAT_LOG_ALL)) {
> +		xfs_info(mp, "Clearing log incompat feature flags.");
> +		xfs_sb_remove_incompat_log_features(&mp->m_sb);
> +		ret = true;
> +	}
> +
> +	xfs_buf_relse(mp->m_sb_bp);
> +	return ret;
> +}
> +
>   /*
>    * Update the in-core delayed block counter.
>    *
> diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
> index 63d0dc1b798d..eb45684b186a 100644
> --- a/fs/xfs/xfs_mount.h
> +++ b/fs/xfs/xfs_mount.h
> @@ -453,6 +453,8 @@ int	xfs_zero_extent(struct xfs_inode *ip, xfs_fsblock_t start_fsb,
>   struct xfs_error_cfg * xfs_error_get_cfg(struct xfs_mount *mp,
>   		int error_class, int error);
>   void xfs_force_summary_recalc(struct xfs_mount *mp);
> +int xfs_add_incompat_log_feature(struct xfs_mount *mp, uint32_t feature);
> +bool xfs_clear_incompat_log_features(struct xfs_mount *mp);
>   void xfs_mod_delalloc(struct xfs_mount *mp, int64_t delta);
>   
>   void xfs_hook_init(struct xfs_hook_chain *chain);
> 
