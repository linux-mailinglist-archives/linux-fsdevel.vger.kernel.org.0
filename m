Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B8353172
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Apr 2021 01:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhDBXUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 19:20:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbhDBXUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 19:20:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NIYBp194771;
        Fri, 2 Apr 2021 23:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bthM15OHDtbBtE1zzOytW2tHkKay7U29DHg+YLkPvHo=;
 b=lN/33Hxvo95xx6/eKloe/UtmslS4e2d1hyfTVG7o0OBzThP31rxvOlQTcZ04z+fKijEc
 AkX0eUT/4/OqdBRzk+I03g/S4sbd5zejNOfuVz68FyMXif0LNYNKbJ5c/KayeZWiaUxq
 kn2BDHm1jFe7UbF6UxQsm5cDqjf+q6/wWF69FxTaGnLwhCYoNsZYzLExOdzZG1Dpwz5T
 ujCmtnEDJVyh6D3uwYecsWkKbp3VfMyJ8WUEJPVFYRvftILUu2D9hNLpvahXIqMSjRE9
 4l/3QndRzIJwVyqpsL9o/3OrfQSBgdqXm93qB+ukL3BsH/Wg84l4XcDqbaS1IKll8O70 sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37n2a05qd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:20:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 132NFfhI056341;
        Fri, 2 Apr 2021 23:20:39 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by userp3030.oracle.com with ESMTP id 37n2auhg56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Apr 2021 23:20:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKBpkK888aO8X5+bFGI/kp0CQ9k/SeeNmsOXd3aZ6mrzKBIgKQ2z50lK6yXj2pjQUbmIVPcne2Dpe4xmUmqzGnuYGWq2ntEZt+OSeFgNdr6Zr+FvLAbZT9qKvX3dwcMzH4da1uHmrZpmt0vr2ejKBsUO+ubQS6tvykUcy5oyTqLtXRRI/XIVwrl4zIV9Vd+yB8TzExERkg/voYOx8GQjfASt/hSWkKw/rfN7JA7V6BVialc/mXuKdJJ2efZxarS1g40YB2tHBQpRVHoXdojPvSZJutrBXzoFEYXs8hgmNt37IeQgjLgxAvzb5S5FUrHM7wD+BcBodwD/DUPd6aSizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bthM15OHDtbBtE1zzOytW2tHkKay7U29DHg+YLkPvHo=;
 b=cbxPWYa7z19CevV1kSqWdPWJ2RzNfmcj8qq4q4REJCf6W1FAb2agROgSMNg3PickKDk5Buv7akKH8u+GkF02+faRj0iqJZasSIV2BvDwYSTnidzfNAo0mwI/UXf8GZbp/vfc5Nfzq5ivaYNvISkLjYJteFT+rZcqHt0N+pJS0xPBR6Nm534mQvG0/d99ALrEq2RkDY8wrZgn23KmyM5cM7DQipgA+sgoecKQu3cj54QGczNCT2esRsjJZSSiFa6RClbszLJ0Xqy/68/m8cYq/c+10xwlPHqX++RLFLi1pA3qotWp2R5jsO/ayl7TGkPgJOkfalU8kNMOJ0/eHLmgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bthM15OHDtbBtE1zzOytW2tHkKay7U29DHg+YLkPvHo=;
 b=JT2R3OWMvcYjwseNtgGegOlm8BYb5+v2P7HccnM9A1+fx6lKHd49Q8X9PjYtkFisVgamVBPG5S3UkNtYqwnTUdga7uJEXKcidfr1d5Ji1ml9hqo41ikX2VYnODhh0l1mCYb503eI74gnfg++wyo8uaE9BC+TBBJZ3fmrjX798ls=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 23:20:37 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::55a0:c9fb:d00:cd88%3]) with mapi id 15.20.3999.032; Fri, 2 Apr 2021
 23:20:37 +0000
Subject: Re: [PATCH 02/18] xfs: support two inodes in the defer capture
 structure
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <161723933765.3149451.18195162751019604410.stgit@magnolia>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <f05812be-e927-4cfa-8b2c-fcb4150a5579@oracle.com>
Date:   Fri, 2 Apr 2021 16:20:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <161723933765.3149451.18195162751019604410.stgit@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.1.223.248]
X-ClientProxiedBy: BYAPR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:a03:80::41) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.226] (67.1.223.248) by BYAPR11CA0064.namprd11.prod.outlook.com (2603:10b6:a03:80::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 23:20:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17daa0a0-3948-436a-176a-08d8f62dec94
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4575:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4575BF557418D10D21F881AB957A9@SJ0PR10MB4575.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgFgSlcXdE6mtkA3Jcd+T4gmXc2zKLsdRPINn8d7jWFZV6pCAlRM32/jPnHK1M5TtO7iI+qMj/vOokZKoJYM/a9HFjPMM6P73tMTMJl9Z0HHc/t8lEUbEPzqW4G6Re5bjEUJzdnoyW+TyboEef5ED0+Zgmby/RUsr849wLuSp6jAH7/n5bIJ9XGePGhNvGuGN6uvxjckZ8dD6A1kxPN+B5RlXyzuc62Rapdo7Fg6gr5hIblY6IfO9j1KQc2UgOokmnGy6OTTeDDfTSS8GlPVCmGSiA0fGpkIimuivaKiOOptz4J7aon4gsgnJEi5qxMp6hF+FY3RV4SvKdZGqP4pDBpdP7Ou0g/2Ce9eTSjOoRR3KaPPiJw8AiY4hqqFIoqhLLb0tJp7kNwqyiAdf7KATYNydVGGi0DFLQdUeMljxi69lDs4v1vpQN4ToPWAZs2bE9PNRIC2WFlzMXDmPI5rBaYhPKeleRVPDYb+Zl336c0HkVwpuMwoEtqxEc+zFYFLdrnGIb9Qc/K74OuKJlPZqYWkeWHYT767K+KAoziiQBKQWIb6DzlpgBszeI2tCC8qFXZQAnZgimj4gdQD6LUPCA6IFpzJ0gLE7yOjwL5WC+XwEMCCpu1iCCBOu96jy+8sTBjWMTnZy3SQdhp8MsrVMj8DfVXiB2D3yio1s9t/4uW2bQktesC/Jox/y6hCb6RNz5RS6d2nwPGIQwnNBGUdjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(36756003)(31686004)(86362001)(38100700001)(8676002)(52116002)(186003)(16526019)(31696002)(6486002)(53546011)(4326008)(16576012)(66946007)(66476007)(66556008)(6916009)(44832011)(956004)(2616005)(83380400001)(2906002)(316002)(8936002)(26005)(478600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SEh0OW0vNjR1RU9kMGlJZGZ3eUtJZW92dG1KYlRrVmJvUEdoS2V5VnNLVzhE?=
 =?utf-8?B?V2FuZzhoOGNDWC9iU1VRT0JUTDEwTFBqbFZhY1dUYWxsdEF5QlgvUHBLWUQw?=
 =?utf-8?B?OVluV2VDYi9Na3VUaGYwTTZrdXJzVXB2QnEzYUJmZzZBekxSS0tvb251eVho?=
 =?utf-8?B?eC9KWUw4c1pnSUJIL21EMHQrenhSYVhKS0NMQ2REaUdjdHRFd2pQaTdNb3FM?=
 =?utf-8?B?YTB3Y0RzM0N6WExDZlFVbkJybUViZVc4eE02VXhUQlJhSWJsNDcvNzZFRW9x?=
 =?utf-8?B?ZFp6bzJCOUdibU01c052MUFFSG8ybzdmTTN0T2F0QjlGUS81ZnJKcmpDcVJk?=
 =?utf-8?B?MXN3V21nUGxiS0xmbEo2OWFHcmpIR1l3TldHTXZsNTByaTFiUzhkL0hvYkFX?=
 =?utf-8?B?UjAzYWFxVmJ6a1VmL25CNTE1ZXNzdzdWY0pib1BvU3IrSCtrOS9pVE1qTGxi?=
 =?utf-8?B?V2VoN1F6dHZPRjJURGgwRjlQeSsyQlF2aVFiQjFpR0JBbHRTbDJXY0NmRXZI?=
 =?utf-8?B?R0QzTkNDd2FhbTY1alRqUlg3ZE53MzNRZHA3WExMRWhYbW1pN2czenkzRDRO?=
 =?utf-8?B?SDlaM3BwdlJ6VFF1N0VVNVZMSTZVdTF2aXJXbSt1TFhzSlJTWEFRdGZMT3Fq?=
 =?utf-8?B?cStzRmkxYVFLKzdscEZQMGtkb3UyRFV1WDk4bThwclpPRmxaUDdtMmp6K1dH?=
 =?utf-8?B?T3lyMlcxRDdmdDZrdHZaV0lrY2NFcFdYRHZwNVNqWVloREV3Yk5DUzFqbnVK?=
 =?utf-8?B?N2ZRRlgyYVFHZFQzb3lOczcra1RqR1hKQmNmd0FTNlVFTVlEdkgvSXQ4cXh2?=
 =?utf-8?B?Y0U0M3dweUoxYWlNZVEwd3BSRWdHU09Td2YrZU1sZzIyazBCb2FZRVRyK0l5?=
 =?utf-8?B?VkwxS0ZNU3ZrWkI2dWFxN0h0TnhlQVVFaXJ5TXRaMVc3THpYTlprWGpnUzNq?=
 =?utf-8?B?TXd6Rld0WjRDZFNJWkdzM2ZJMkRkb0VvNkFQeDdyeFE1bkZQeGFvcGw3MlZn?=
 =?utf-8?B?QkU4cWdaVXRpZ0tYdE0rNGtxWVlGWTQwSStCZVBFYVFyMDJhS1pqMVVscUly?=
 =?utf-8?B?VUcyT1J3YTgwZ3JPNnh6cnlYVnliR1VVVUZsdUtIcXdpaUlBQ0ZRMXlFaEVX?=
 =?utf-8?B?bm1FQk93TGQwTWs2Y2hDeHBCbi9WVVJ1ZlNBRzVna3AyZVdnbkdtV1ZXN1Nu?=
 =?utf-8?B?Zk9hNnhaQURZUFI4S2VKNnRUTkxud0FYMEJqNlJWemdoaUY4d1luY2VjNzR0?=
 =?utf-8?B?NUFZTHRBV25peHVnVHE0dGlHeE9QTFZRT1ZhMFF2Tmw5SmdLaEFzVDBtS2pI?=
 =?utf-8?B?MGhsY1JDN3pSRHlVY01vL1k4eit1VHlFZHFCb05mbHBDWXZzZmx0YitsT3l0?=
 =?utf-8?B?cDZ2QkVFd25YbU1tYllWaklGMmJvRC9sRjFyUHY1MEg1YUE5ZlFtVmNRbVly?=
 =?utf-8?B?YjRiMDNMWnRSWk00cEUyb2paaUxiaWVqdURTa1NhU3lSMTJZL2prMHpGdGNZ?=
 =?utf-8?B?SnZNcTM2Y2dpenpMUXhTVWEzWVZzODRTT3FEY2Z4RkIrVDBvc3NGQjE4OVVB?=
 =?utf-8?B?azU4NkNGUlhFVHF5d21od0lKZnluOVNYSkRKTk5Ebzk4WkphQURwSks1bXNQ?=
 =?utf-8?B?eHdOMFp5Ry9XUzN4WEx2L3JQMjFpdnhpRHdaZkdBQ1FpTVdZbFQxSHFZQTMr?=
 =?utf-8?B?WGlmZ1NyT0czMTNvcDkydE84T3U4ZndCeUN5OWZBNmV6QlpIWjlTc2ZZOGJX?=
 =?utf-8?Q?cWQDHnwdVBWuvEN7GTF01qIF3+cIc4N3JUjyJbj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17daa0a0-3948-436a-176a-08d8f62dec94
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 23:20:37.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEaeQhz5maS23u7VoAr31MrtgCBGBiHjSnh/dSRvvJXULYV0cIlXGdwnuont/6XB+Aw5FDIPdA0oLZ5EluIo7zgC6CPULJ6ZLFAVP9cFNig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020156
X-Proofpoint-GUID: BiLkl6j_lpMlt3gGGjbBxdRWHbXWSUHS
X-Proofpoint-ORIG-GUID: BiLkl6j_lpMlt3gGGjbBxdRWHbXWSUHS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9942 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104020156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/31/21 6:08 PM, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make it so that xfs_defer_ops_capture_and_commit can capture two inodes.
> This will be needed by the atomic extent swap log item so that it can
> recover an operation involving two inodes.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Ok, makes sense
Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>   fs/xfs/libxfs/xfs_defer.c  |   48 ++++++++++++++++++++++++++++++--------------
>   fs/xfs/libxfs/xfs_defer.h  |    9 ++++++--
>   fs/xfs/xfs_bmap_item.c     |    2 +-
>   fs/xfs/xfs_extfree_item.c  |    2 +-
>   fs/xfs/xfs_log_recover.c   |   14 ++++++++-----
>   fs/xfs/xfs_refcount_item.c |    2 +-
>   fs/xfs/xfs_rmap_item.c     |    2 +-
>   7 files changed, 52 insertions(+), 27 deletions(-)
> 
> 
> diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
> index eff4a127188e..a7d1357687d0 100644
> --- a/fs/xfs/libxfs/xfs_defer.c
> +++ b/fs/xfs/libxfs/xfs_defer.c
> @@ -628,7 +628,8 @@ xfs_defer_move(
>   static struct xfs_defer_capture *
>   xfs_defer_ops_capture(
>   	struct xfs_trans		*tp,
> -	struct xfs_inode		*capture_ip)
> +	struct xfs_inode		*capture_ip1,
> +	struct xfs_inode		*capture_ip2)
>   {
>   	struct xfs_defer_capture	*dfc;
>   
> @@ -658,9 +659,13 @@ xfs_defer_ops_capture(
>   	 * Grab an extra reference to this inode and attach it to the capture
>   	 * structure.
>   	 */
> -	if (capture_ip) {
> -		ihold(VFS_I(capture_ip));
> -		dfc->dfc_capture_ip = capture_ip;
> +	if (capture_ip1) {
> +		ihold(VFS_I(capture_ip1));
> +		dfc->dfc_capture_ip1 = capture_ip1;
> +	}
> +	if (capture_ip2 && capture_ip2 != capture_ip1) {
> +		ihold(VFS_I(capture_ip2));
> +		dfc->dfc_capture_ip2 = capture_ip2;
>   	}
>   
>   	return dfc;
> @@ -673,8 +678,10 @@ xfs_defer_ops_release(
>   	struct xfs_defer_capture	*dfc)
>   {
>   	xfs_defer_cancel_list(mp, &dfc->dfc_dfops);
> -	if (dfc->dfc_capture_ip)
> -		xfs_irele(dfc->dfc_capture_ip);
> +	if (dfc->dfc_capture_ip1)
> +		xfs_irele(dfc->dfc_capture_ip1);
> +	if (dfc->dfc_capture_ip2)
> +		xfs_irele(dfc->dfc_capture_ip2);
>   	kmem_free(dfc);
>   }
>   
> @@ -684,22 +691,26 @@ xfs_defer_ops_release(
>    * of the deferred ops operate on an inode, the caller must pass in that inode
>    * so that the reference can be transferred to the capture structure.  The
>    * caller must hold ILOCK_EXCL on the inode, and must unlock it before calling
> - * xfs_defer_ops_continue.
> + * xfs_defer_ops_continue.  Do not pass a null capture_ip1 and a non-null
> + * capture_ip2.
>    */
>   int
>   xfs_defer_ops_capture_and_commit(
>   	struct xfs_trans		*tp,
> -	struct xfs_inode		*capture_ip,
> +	struct xfs_inode		*capture_ip1,
> +	struct xfs_inode		*capture_ip2,
>   	struct list_head		*capture_list)
>   {
>   	struct xfs_mount		*mp = tp->t_mountp;
>   	struct xfs_defer_capture	*dfc;
>   	int				error;
>   
> -	ASSERT(!capture_ip || xfs_isilocked(capture_ip, XFS_ILOCK_EXCL));
> +	ASSERT(!capture_ip1 || xfs_isilocked(capture_ip1, XFS_ILOCK_EXCL));
> +	ASSERT(!capture_ip2 || xfs_isilocked(capture_ip2, XFS_ILOCK_EXCL));
> +	ASSERT(capture_ip2 == NULL || capture_ip1 != NULL);
>   
>   	/* If we don't capture anything, commit transaction and exit. */
> -	dfc = xfs_defer_ops_capture(tp, capture_ip);
> +	dfc = xfs_defer_ops_capture(tp, capture_ip1, capture_ip2);
>   	if (!dfc)
>   		return xfs_trans_commit(tp);
>   
> @@ -724,17 +735,24 @@ void
>   xfs_defer_ops_continue(
>   	struct xfs_defer_capture	*dfc,
>   	struct xfs_trans		*tp,
> -	struct xfs_inode		**captured_ipp)
> +	struct xfs_inode		**captured_ipp1,
> +	struct xfs_inode		**captured_ipp2)
>   {
>   	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
>   	ASSERT(!(tp->t_flags & XFS_TRANS_DIRTY));
>   
>   	/* Lock and join the captured inode to the new transaction. */
> -	if (dfc->dfc_capture_ip) {
> -		xfs_ilock(dfc->dfc_capture_ip, XFS_ILOCK_EXCL);
> -		xfs_trans_ijoin(tp, dfc->dfc_capture_ip, 0);
> +	if (dfc->dfc_capture_ip1 && dfc->dfc_capture_ip2) {
> +		xfs_lock_two_inodes(dfc->dfc_capture_ip1, XFS_ILOCK_EXCL,
> +				    dfc->dfc_capture_ip2, XFS_ILOCK_EXCL);
> +		xfs_trans_ijoin(tp, dfc->dfc_capture_ip1, 0);
> +		xfs_trans_ijoin(tp, dfc->dfc_capture_ip2, 0);
> +	} else if (dfc->dfc_capture_ip1) {
> +		xfs_ilock(dfc->dfc_capture_ip1, XFS_ILOCK_EXCL);
> +		xfs_trans_ijoin(tp, dfc->dfc_capture_ip1, 0);
>   	}
> -	*captured_ipp = dfc->dfc_capture_ip;
> +	*captured_ipp1 = dfc->dfc_capture_ip1;
> +	*captured_ipp2 = dfc->dfc_capture_ip2;
>   
>   	/* Move captured dfops chain and state to the transaction. */
>   	list_splice_init(&dfc->dfc_dfops, &tp->t_dfops);
> diff --git a/fs/xfs/libxfs/xfs_defer.h b/fs/xfs/libxfs/xfs_defer.h
> index 05472f71fffe..f5e3ca17aa26 100644
> --- a/fs/xfs/libxfs/xfs_defer.h
> +++ b/fs/xfs/libxfs/xfs_defer.h
> @@ -87,7 +87,8 @@ struct xfs_defer_capture {
>   	 * An inode reference that must be maintained to complete the deferred
>   	 * work.
>   	 */
> -	struct xfs_inode	*dfc_capture_ip;
> +	struct xfs_inode	*dfc_capture_ip1;
> +	struct xfs_inode	*dfc_capture_ip2;
>   };
>   
>   /*
> @@ -95,9 +96,11 @@ struct xfs_defer_capture {
>    * This doesn't normally happen except log recovery.
>    */
>   int xfs_defer_ops_capture_and_commit(struct xfs_trans *tp,
> -		struct xfs_inode *capture_ip, struct list_head *capture_list);
> +		struct xfs_inode *capture_ip1, struct xfs_inode *capture_ip2,
> +		struct list_head *capture_list);
>   void xfs_defer_ops_continue(struct xfs_defer_capture *d, struct xfs_trans *tp,
> -		struct xfs_inode **captured_ipp);
> +		struct xfs_inode **captured_ipp1,
> +		struct xfs_inode **captured_ipp2);
>   void xfs_defer_ops_release(struct xfs_mount *mp, struct xfs_defer_capture *d);
>   
>   #endif /* __XFS_DEFER_H__ */
> diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
> index 895a56b16029..bba73ddd0585 100644
> --- a/fs/xfs/xfs_bmap_item.c
> +++ b/fs/xfs/xfs_bmap_item.c
> @@ -551,7 +551,7 @@ xfs_bui_item_recover(
>   	 * Commit transaction, which frees the transaction and saves the inode
>   	 * for later replay activities.
>   	 */
> -	error = xfs_defer_ops_capture_and_commit(tp, ip, capture_list);
> +	error = xfs_defer_ops_capture_and_commit(tp, ip, NULL, capture_list);
>   	if (error)
>   		goto err_unlock;
>   
> diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
> index c767918c0c3f..ebfc7de8083e 100644
> --- a/fs/xfs/xfs_extfree_item.c
> +++ b/fs/xfs/xfs_extfree_item.c
> @@ -632,7 +632,7 @@ xfs_efi_item_recover(
>   
>   	}
>   
> -	return xfs_defer_ops_capture_and_commit(tp, NULL, capture_list);
> +	return xfs_defer_ops_capture_and_commit(tp, NULL, NULL, capture_list);
>   
>   abort_error:
>   	xfs_trans_cancel(tp);
> diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
> index b227a6ad9f5d..ce1a7928eb2d 100644
> --- a/fs/xfs/xfs_log_recover.c
> +++ b/fs/xfs/xfs_log_recover.c
> @@ -2439,7 +2439,7 @@ xlog_finish_defer_ops(
>   {
>   	struct xfs_defer_capture *dfc, *next;
>   	struct xfs_trans	*tp;
> -	struct xfs_inode	*ip;
> +	struct xfs_inode	*ip1, *ip2;
>   	int			error = 0;
>   
>   	list_for_each_entry_safe(dfc, next, capture_list, dfc_list) {
> @@ -2465,12 +2465,16 @@ xlog_finish_defer_ops(
>   		 * from recovering a single intent item.
>   		 */
>   		list_del_init(&dfc->dfc_list);
> -		xfs_defer_ops_continue(dfc, tp, &ip);
> +		xfs_defer_ops_continue(dfc, tp, &ip1, &ip2);
>   
>   		error = xfs_trans_commit(tp);
> -		if (ip) {
> -			xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -			xfs_irele(ip);
> +		if (ip1) {
> +			xfs_iunlock(ip1, XFS_ILOCK_EXCL);
> +			xfs_irele(ip1);
> +		}
> +		if (ip2) {
> +			xfs_iunlock(ip2, XFS_ILOCK_EXCL);
> +			xfs_irele(ip2);
>   		}
>   		if (error)
>   			return error;
> diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
> index 07ebccbbf4df..427d8259a36d 100644
> --- a/fs/xfs/xfs_refcount_item.c
> +++ b/fs/xfs/xfs_refcount_item.c
> @@ -554,7 +554,7 @@ xfs_cui_item_recover(
>   	}
>   
>   	xfs_refcount_finish_one_cleanup(tp, rcur, error);
> -	return xfs_defer_ops_capture_and_commit(tp, NULL, capture_list);
> +	return xfs_defer_ops_capture_and_commit(tp, NULL, NULL, capture_list);
>   
>   abort_error:
>   	xfs_refcount_finish_one_cleanup(tp, rcur, error);
> diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
> index 49cebd68b672..deb852a3c5f6 100644
> --- a/fs/xfs/xfs_rmap_item.c
> +++ b/fs/xfs/xfs_rmap_item.c
> @@ -584,7 +584,7 @@ xfs_rui_item_recover(
>   	}
>   
>   	xfs_rmap_finish_one_cleanup(tp, rcur, error);
> -	return xfs_defer_ops_capture_and_commit(tp, NULL, capture_list);
> +	return xfs_defer_ops_capture_and_commit(tp, NULL, NULL, capture_list);
>   
>   abort_error:
>   	xfs_rmap_finish_one_cleanup(tp, rcur, error);
> 
