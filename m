Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E943E315B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 01:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhBJAdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 19:33:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16400 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234514AbhBJAXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:23:19 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11A0J4lt009605;
        Tue, 9 Feb 2021 16:22:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=eYrnwYaf2OGDPRhSZZow/D4cfONn9VnhMTHnRyTH2jo=;
 b=FYUGykLqJrjelJdCuDF/5R4YsZLaLI8SSNsG1yHMC0AE/ZaojuHuA4v+0KPClBdIow0m
 owuJemDdt101b6VlKI3839Jt1qkaGomE9uvO9FwgAV2RJrY8+JSjBW35q3h3hFr+1XvW
 ruOLsvU6qJdXFHblMadd5uNzSFlVycECEb0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36kxmeadq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 16:22:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 16:22:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfwi49xK7ky66OelxHJip1sIEkc4dlz31YGIf2ot+iUbHLIl96ZVn4TXA/zB3/gWCx3QDqfGG8QZqP58fPMI/Y3akxx9ToeZfljoHRjxbA/yw+a3Z84uEgOL+8s3fHd++dqZvwq3VuAFeSEC3fQd5sV51/RCj/LWthfKk8hGVHWrmUuYeO5zlvxjb7c7/ZIL0TyftUqwx0XN9keQAOW79OQgRNhLpt1hBsf2zZ5GvOIek3rJRvwlWJ9hI4xhGr8aT8IqyPVeQh33PjJQ7bAyQoCIjMZxHMAj+Jzo0OMB/TbStykkHmrvrvjVTxreIWMysGdwe2PQKVEhYz3MdQAjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYrnwYaf2OGDPRhSZZow/D4cfONn9VnhMTHnRyTH2jo=;
 b=X1miFNJGRTFRgk63YrGK55QzQ6SB6V3upux99/eec6uQMoykgO9R9cKW4vm7+cF8tl1vqLBepflFBOKmiVQ4jKi3OHtDtOxKt0CUs1EV7Dnl6nPFNWLSHrcRYeHK0ANhNPQHQxGzTSjgd19J/9o6kc3IbH3Gq4WzEMkaRZP5Ip1fBkpVqLhkVxnudmitmimMlYyV+1hVNekeYERFaaXtNix+41K1TTKAF8E145P9g5jXHESRb7jg+nfX8dkq6NwHp2vTy+kaM6XkEtWb3up7x7ulUW4Jp96lBCdeiNSB980vN3CzTbpdr+WdDRpIYH17Ohr5vHGdqijVbsMMnXMHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYrnwYaf2OGDPRhSZZow/D4cfONn9VnhMTHnRyTH2jo=;
 b=bb874uquFvCME+nHpbwzBfDQKzGtqbeQwRliy0d2GBFnMaEpmdQYmotBtirkvjxrye1na0lanJZlFkhhodiPmtBlE01CrhB4V5ks277xXhMVcx0T3ct2dilxfw7szz4soH9Gh+Jg1JmBznBPIU7H7WovjDAKrhDBpf0VQ0FJQ0s=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3446.namprd15.prod.outlook.com (2603:10b6:a03:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Wed, 10 Feb
 2021 00:22:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::53a:b2c3:8b03:12d1%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 00:22:23 +0000
Date:   Tue, 9 Feb 2021 16:22:18 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <ktkhai@virtuozzo.com>, <vbabka@suse.cz>, <shakeelb@google.com>,
        <david@fromorbit.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v7 PATCH 06/12] mm: vmscan: add shrinker_info_protected() helper
Message-ID: <20210210002218.GJ524633@carbon.DHCP.thefacebook.com>
References: <20210209174646.1310591-1-shy828301@gmail.com>
 <20210209174646.1310591-7-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209174646.1310591-7-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:96c7]
X-ClientProxiedBy: MWHPR22CA0058.namprd22.prod.outlook.com
 (2603:10b6:300:12a::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:96c7) by MWHPR22CA0058.namprd22.prod.outlook.com (2603:10b6:300:12a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 00:22:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d10e22-1596-4e3c-683a-08d8cd59f00a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3446:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3446B43D9A8C29E21F0FE49FBE8D9@BYAPR15MB3446.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tem3lQmypPAZ91FzUVC+XXBE/VNmifS6vFq5R46c23Eej6ZxOor0Ga7DB7pjo0Yk9CZ96vhS7bIDbHmu0g5TW1XrojTyIKI8x7LhzFUJ7TIcngKnhZj6VEohC0DzEpWpmMlwjAh5ibonLFzTsJtw1b1n24lz104BcNjtXhf+iWRu9i1Z/d4oxa8WB+kKgEmCEU1+w83/3VPRbHdmFAaynYXtzuW1teptqJPmo0HnCQ1UbjWtXQmY7xQPtL+Vf21xmjvUnyAXCiGEJ+WJH85S95gIc/vYVw/Xugz35xwbtghlISjzXoHLx//k1dgAPRvjbHH/KKva1zw6pBrCWlcT9P9T/cdJJRekDTHxMj8b4hoUNsFnQvyODe2ooxDwRrgBl0FNrOCFR38aY8LZHx0GEhi0Ie4VEjjFo3Kz2+IFXn6lf7cmxOSvN1wQHc98+GNPh2KDd8f7FzS3ZjKeOloypTh2srNe9LH+nlJS2/0OQMQYLpSGVoaIMX1FFtcmRnEHREK8IrG08evL6ibNssTTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(66946007)(8936002)(4326008)(5660300002)(8676002)(66556008)(66476007)(33656002)(86362001)(6666004)(7696005)(16526019)(186003)(52116002)(1076003)(9686003)(6506007)(316002)(2906002)(83380400001)(6916009)(7416002)(478600001)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JcDd4hDsTKdN88obVnDmZq6VlpxJwpm+MQWBQ2DWjDssBep0oVzblaxCTb8A?=
 =?us-ascii?Q?EDLHJ7RSmRQlqL8Dopz0TD/bHYF8Rul0G+sQGdcGB2QDory8OMI05YenhxfA?=
 =?us-ascii?Q?OHqlhPUZ4zNCDRWREgv2Trj4xx9dc83C8wiZO6FxlTdNS3p5MKiq9ehUbBAB?=
 =?us-ascii?Q?PWKOh92vpVPRRwO2q80l0duuSoKPmdUa6iH0HB5/03AHXipWmxD9Th4Sq4fn?=
 =?us-ascii?Q?RMFUfPBnbfsDLV5GznvttBdZ5h6fb9tyxer5pOtcGqSOPCp2uGpzlRnLqgtX?=
 =?us-ascii?Q?+SMANEWLisqOLRzauOhxZNUnkhbwpxRon/KS5Z1CAtCt5ggs2X6rJk9V2jso?=
 =?us-ascii?Q?S35PBM4WuRoxWN/1ICUqnNWY0Fn0/Pk8KWeBvqICSkSZp6+rrLO6V4slQCgs?=
 =?us-ascii?Q?PeKRK7eNpOACsbWWd8bXQbJZcFh9k/RC31GHFXMH+M/qWMu3riG8OnlWhEaB?=
 =?us-ascii?Q?pSHzA5sOahuHiORBg5ByUGgaR1tBwIPa0Ez19ru9OLCWGnEvnAWiz76SmGhG?=
 =?us-ascii?Q?ePSFz2i9ScQG2tzx5Uq451fTUfX0xPQgdtoqbU4sLEepeVdtXEavWp6/EMoh?=
 =?us-ascii?Q?khE184R/7xmRyqSk6RL0L1fnQrV0/u24wHsXicmEezdVXlwWGLkt+Fiu2Qrw?=
 =?us-ascii?Q?adYNBGYnn9zEl4YwQIH8VzvWdfb2CRmJv3zT7jAl9PUNGKC7Mm+tdxlIbMld?=
 =?us-ascii?Q?16T7j7unwOGez7N/0QfC8yfXRwXNSKrGp1Ksj+vhe2vyLWP6xVyaJ4dHp+BW?=
 =?us-ascii?Q?/CEtbm4/2McTx5xXlOjqZO51rgAqFrywBRWtA10qCLuw8o+zBUqasgSqOTHW?=
 =?us-ascii?Q?243AB8qPeofx5ZXA7IDXLoPbKoH8H/AcU7oh+bOmTsV5O+ApLN+F18kYZQqe?=
 =?us-ascii?Q?ZdYuHLkL5H3WTtRRYI+k/HOUllT4xZ9ZGOftSuZ1HFpITuFq3/Jo23Dz3lFb?=
 =?us-ascii?Q?M8c0VfsCydi7BuaoIAa7WAiaF74w6n4Ogw8Y2eyHa3xYjCk6HtkJHah4e2yh?=
 =?us-ascii?Q?R9ehcVswpgiIGSx1Nztd/jfpnYzqC1ZJFyzuWJt7//n4hg4WLpgbj57wlh5B?=
 =?us-ascii?Q?/VykJblR/uIg6QfzeXYCZwamzCnAG/9Mhx2sBvhhWGdxR0v4WBzkvSHr/V+g?=
 =?us-ascii?Q?Lrmcz51NSulf3RUiUqd7z6/OIes4B9Mju9u+9BEQagoMJ1DP6byPXEc2F3Cq?=
 =?us-ascii?Q?8rD1aCxGxKMVwkWKBLmH8h6zn94Hb/3XXhB4+SVd0uU2uocZXp1XQ1630YUn?=
 =?us-ascii?Q?YS2SrkB1ZFRBlGL9rmAVAGQ1j3HsC/nd5yRNRXAELJAhzDD1o9fBAdrTNh24?=
 =?us-ascii?Q?O4WhaC3nA0Yf3GHrqJF3/1Vuu2l7JHrw6Xzmbi3Mh7472bHSEYwCuUp36mMr?=
 =?us-ascii?Q?gzhWclw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d10e22-1596-4e3c-683a-08d8cd59f00a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 00:22:23.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYdznhPpuEiwxTCV6uAP1a4XcH3haTHixDYVWYi8caGu1p+FMQwe51FB5Ed4w8DH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3446
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_08:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=827 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:46:40AM -0800, Yang Shi wrote:
> The shrinker_info is dereferenced in a couple of places via rcu_dereference_protected
> with different calling conventions, for example, using mem_cgroup_nodeinfo helper
> or dereferencing memcg->nodeinfo[nid]->shrinker_info.  And the later patch
> will add more dereference places.
> 
> So extract the dereference into a helper to make the code more readable.  No
> functional change.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/vmscan.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9436f9246d32..273efbf4d53c 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -190,6 +190,13 @@ static int shrinker_nr_max;
>  #define NR_MAX_TO_SHR_MAP_SIZE(nr_max) \
>  	(DIV_ROUND_UP(nr_max, BITS_PER_LONG) * sizeof(unsigned long))
>  
> +static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
> +						     int nid)
> +{
> +	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> +					 lockdep_is_held(&shrinker_rwsem));
> +}
> +


I'd probably drop the "protected" suffix (because there is no unprotected version,
right?).

Other than that LGTM.

Acked-by: Roman Gushchin <guro@fb.com>
